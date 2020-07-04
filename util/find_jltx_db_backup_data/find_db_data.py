#!/usr/bin python
# -*- coding:utf-8 -*-
"""
#	> Author	: tmark
#	> Created Time	: Tue 30 Jun 2020 03:32:48 PM CST
#	> File Name	: find_db_data.py
#	> Description	: 
    """
import os, sys
import traceback
import json

# ***************************************************
# log file class
# ***************************************************
class LogFileException(Exception):
    def __init__(self, *args):
        self.args = args

class BaseLogFile(object):
    def __init__(self, file_name = None, mode = None, file_obj = None):
        self.init_attr()

        if file_obj is not None:
            self.set_file_obj(file_obj)

        if file_name is not None:
            self.open(file_name, mode)

    def __enter__(self):
        return self.file_obj

    def __exit__(self, exc_type, exc_value, exc_trace):
        self.close()

    def init_attr(self):
        self.file_name  = None
        self.mode       = None
        self.file_obj   = None

    def set_file_obj(self, file_obj):
        if not isinstance(file_obj, file):
            raise LogFileException("file_obj parameters invalid");
        self.file_obj = file_obj

    def open(self, file_name, mode):
        if isinstance(self.file_obj, file):
            raise LogFileException("repeat open"); 

        self.file_name  = file_name
        self.mode       = mode
        try:
            self.file_obj = open(file_name, mode)
        except Exception, err:
            self.init_attr()
            traceback.print_exc()
            raise LogFileException(err.message)

    def close(self):
        if isinstance(self.file_obj, file):  
            self.file_obj.close()
        self.file_obj = None

    # please override it  
    def format(self, res_data):
        return "%s" % str(res_data) 

    def write(self, res_data):
        if not isinstance(self.file_obj, file):
            raise LogFileException("self.file_obj is not instance of file");

        print >> self.file_obj, self.format(res_data)

class BarrierLogFile(BaseLogFile): 
    ''' 障碍物输出log '''
    def __init__(self, file_name = None, mode = None, file_obj = None):
        super(BarrierLogFile, self).__init__(file_name, mode, file_obj)
 
    def format(self, res_data):
        uid, res_build_data = res_data
        return "uid : %s\nbarrier : %s" % (uid, json.dumps(res_build_data, indent = 4, ensure_ascii = False))

# ***************************************************
# handler class 
# ***************************************************
class FindDBDataException(Exception):
    def __init__(self, *args):
        self.args = args

class BaseHandler(object):
    """base class"""

    def __init__(self, src_file, dst_log_obj = None, limit = 1):
        self.src_file = src_file
        self.limit = limit

        self.src_file_obj =   None
        try:
            self.src_file_obj = open(src_file, "r")
        except Exception, err:
            raise FindDBDataException(err.message)
        
        self.set_log_obj(dst_log_obj)

    def set_log_obj(self, dst_log_obj): 
        self.dst_log_obj = dst_log_obj

    def filter(self, user_data):
        return False

    def data_handler(self, user_data):
        return None
    
    def main_loop(self):
        err_cnt = 0
        bingo_cnt = 0
        loop_cnt = 0
        for line in self.src_file_obj:
            try:
                loop_cnt += 1
                if bingo_cnt >= self.limit:
                    break

                user_data = json.loads(line)
                if not self.filter(user_data):
                    continue

                bingo_cnt += 1
 
                res_data = self.data_handler(user_data) 
                self.dst_log_obj.write(res_data)


            except Exception, err:
                traceback.print_exc()
                err_cnt += 1

        print "*** loop_cnt : %s ***" % loop_cnt
        print "*** match : %s ***" % bingo_cnt
        print "*** error : %s ***" % err_cnt


class BarrierHandler(BaseHandler):
    ''' 障碍物数据处理类 '''
    def __init__(self, src_file, dst_log_obj = None, limit = 1):
        super(BarrierHandler, self).__init__(src_file, dst_log_obj, limit)

        self.target_data = None

    def set_target_data(self, target_data):
        self.src_file_obj.seek(0)
        self.target_data = target_data 
        
    def filter(self, user_data): 
        if self.target_data is None:
            return False

        uid = user_data.get("__indexing__", 0) 
        if uid == self.target_data:
            return True

        return False

    def data_handler(self, user_data):
        uid = user_data.get("__indexing__", 0) 
        
        user_build_data = user_data.get("building", {})
        all_buildings_data = user_build_data.get("buildings", {})
        res_build_data = {}
        for bid, binfo in all_buildings_data.iteritems():
            res_build_data[bid] = binfo.get("templateId")
             
        return uid, res_build_data 

# ***************************************************
# 主处理函数， （类实例化与调用） 
# ***************************************************
def do_barrier():
    argc = len(sys.argv)
    
    if argc != 5:
        print "usage : %s %s db_data uid output_path" % (sys.argv[0], sys.argv[1])
        return 
     
    db_file = sys.argv[2] 
    uid = int(sys.argv[3])
    output_path = sys.argv[4]
    
    print "begin to run : %s %s %s %s %s" % tuple(sys.argv)

    log_obj = BarrierLogFile(output_path, "w")
    obj = BarrierHandler(db_file, log_obj) 
    obj.set_target_data(uid)
    obj.main_loop() 


# ***************************************************
# hash 与 主控逻辑   
# ***************************************************
handler_hash = {
    "do_barrier" : do_barrier,
}


if __name__ == "__main__":
    if len(sys.argv) < 2:
        print "usage : %s handler [args...]" % sys.argv[0]
        exit(1)

    handler_func = handler_hash.get(sys.argv[1])
    if not handler_func:
        print "usage : %s handler [args...]" % sys.argv[0]
        exit(1)

    handler_func()

