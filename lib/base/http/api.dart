import 'package:qinglong_app/base/http/http.dart';
import 'package:qinglong_app/base/http/url.dart';
import 'package:qinglong_app/main.dart';
import 'package:qinglong_app/module/config/config_bean.dart';
import 'package:qinglong_app/module/env/env_bean.dart';
import 'package:qinglong_app/module/home/system_bean.dart';
import 'package:qinglong_app/module/login/login_bean.dart';
import 'package:qinglong_app/module/login/user_bean.dart';
import 'package:qinglong_app/module/others/dependencies/dependency_bean.dart';
import 'package:qinglong_app/module/others/login_log/login_log_bean.dart';
import 'package:qinglong_app/module/others/scripts/script_bean.dart';
import 'package:qinglong_app/module/others/task_log/task_log_bean.dart';
import 'package:qinglong_app/module/task/task_bean.dart';
import 'package:qinglong_app/utils/utils.dart';

class Api {
  static Future<HttpResponse<SystemBean>> system() async {
    return await Http.get<SystemBean>(
      Url.system,
      {},
    );
  }

  static Future<HttpResponse<LoginBean>> login(
    String userName,
    String passWord,
  ) async {
    return await Http.post<LoginBean>(
      Url.login,
      {
        "username": userName,
        "password": passWord,
      },
    );
  }

  static Future<HttpResponse<LoginBean>> loginOld(
    String userName,
    String passWord,
  ) async {
    return await Http.post<LoginBean>(
      Url.loginOld,
      {
        "username": userName,
        "password": passWord,
      },
    );
  }

  static Future<HttpResponse<LoginBean>> loginTwo(
    String userName,
    String passWord,
    String code,
  ) async {
    return await Http.put<LoginBean>(
      Url.loginTwo,
      {
        "username": userName,
        "password": passWord,
        "code": code,
      },
    );
  }

  static Future<HttpResponse<LoginBean>> loginByClientId(
    String id,
    String secret,
  ) async {
    return await Http.get<LoginBean>(
      Url.loginByClientId,
      {
        "client_id": id,
        "client_secret": secret,
      },
    );
  }

  static Future<HttpResponse<UserBean>> user() async {
    return await Http.get<UserBean>(
      Url.user,
      null,
    );
  }

  static Future<HttpResponse<List<TaskBean>>> crons() async {
    return await Http.get<List<TaskBean>>(
      Url.tasks,
      {"searchValue": ""},
    );
  }

  static Future<HttpResponse<NullResponse>> startTasks(List<String> crons) async {
    return await Http.put<NullResponse>(
      Url.runTasks,
      crons,
    );
  }

  static Future<HttpResponse<NullResponse>> stopTasks(List<String> crons) async {
    return await Http.put<NullResponse>(
      Url.stopTasks,
      crons,
    );
  }

  static Future<HttpResponse<NullResponse>> updatePassword(String name, String password) async {
    return await Http.put<NullResponse>(
      Url.updatePassword,
      {
        "username": name,
        "password": password,
      },
    );
  }

  static Future<HttpResponse<String>> inTimeLog(String cron) async {
    return await Http.get<String>(
      Url.intimeLog(cron),
      null,
    );
  }

  static Future<HttpResponse<NullResponse>> addTask(
    String name,
    String command,
    String cron, {
    int? id,
    String? nId,
  }) async {
    var data = <String, dynamic>{"name": name, "command": command, "schedule": cron};

    if (id != null || nId != null) {
      if (id != null) {
        data["id"] = id;
      } else if (nId != null) {
        data["_id"] = nId;
      }
      return await Http.put<NullResponse>(
        Url.addTask,
        data,
      );
    }
    return await Http.post<NullResponse>(
      Url.addTask,
      data,
    );
  }

  static Future<HttpResponse<NullResponse>> delTask(String cron) async {
    return await Http.delete<NullResponse>(
      Url.addTask,
      [cron],
    );
  }

  static Future<HttpResponse<NullResponse>> pinTask(String cron) async {
    return await Http.put<NullResponse>(
      Url.pinTask,
      [cron],
    );
  }

  static Future<HttpResponse<NullResponse>> unpinTask(String cron) async {
    return await Http.put<NullResponse>(
      Url.unpinTask,
      [cron],
    );
  }

  static Future<HttpResponse<NullResponse>> enableTask(String cron) async {
    return await Http.put<NullResponse>(
      Url.enableTask,
      [cron],
    );
  }

  static Future<HttpResponse<NullResponse>> disableTask(String cron) async {
    return await Http.put<NullResponse>(
      Url.disableTask,
      [cron],
    );
  }

  static Future<HttpResponse<List<ConfigBean>>> files() async {
    return await Http.get<List<ConfigBean>>(
      Url.files,
      null,
    );
  }

  static Future<HttpResponse<String>> content(String name) async {
    return await Http.get<String>(
      Url.configContent + name,
      null,
    );
  }

  static Future<HttpResponse<NullResponse>> saveFile(String name, String content) async {
    return await Http.post<NullResponse>(
      Url.saveFile,
      {"content": content, "name": name},
    );
  }

  static Future<HttpResponse<List<EnvBean>>> envs(String search) async {
    return await Http.get<List<EnvBean>>(
      Url.envs,
      {"searchValue": search},
    );
  }

  static Future<HttpResponse<NullResponse>> enableEnv(String id) async {
    return await Http.put<NullResponse>(
      Url.enableEnvs,
      [id],
    );
  }

  static Future<HttpResponse<NullResponse>> disableEnv(String id) async {
    return await Http.put<NullResponse>(
      Url.disableEnvs,
      [id],
    );
  }

  static Future<HttpResponse<NullResponse>> delEnv(String id) async {
    return await Http.delete<NullResponse>(
      Url.delEnv,
      [id],
    );
  }

  static Future<HttpResponse<NullResponse>> addEnv(
    String name,
    String value,
    String remarks, {
    int? id,
    String? nId,
  }) async {
    var data = <String, dynamic>{
      "value": value,
      "remarks": remarks,
      "name": name,
    };

    if (id != null || nId != null) {
      if (id != null) {
        data["id"] = id;
      } else if (nId != null) {
        data["_id"] = nId;
      }
      return await Http.put<NullResponse>(
        Url.addEnv,
        data,
      );
    }
    return await Http.post<NullResponse>(
      Url.addEnv,
      [data],
    );
  }

  static Future<HttpResponse<NullResponse>> moveEnv(String id, int fromIndex, int toIndex) async {
    return await Http.put<NullResponse>(
      Url.envMove(id),
      {"fromIndex": fromIndex, "toIndex": toIndex},
    );
  }

  static Future<HttpResponse<List<LoginLogBean>>> loginLog() async {
    return await Http.get<List<LoginLogBean>>(
      Url.loginLog,
      null,
    );
  }

  static Future<HttpResponse<List<TaskLogBean>>> taskLog() async {
    return await Http.get<List<TaskLogBean>>(Url.taskLog, null, serializationName: Utils.isUpperVersion2_12_2() ? "data" : "dirs");
  }

  static Future<HttpResponse<String>> taskLogDetail(String name, String path) async {
    if (Utils.isUpperVersion2_13_0()) {
      return await Http.get<String>(
        Url.taskLogDetail + name + "?path=" + path,
        null,
      );
    } else {
      return await Http.get<String>(
        Url.taskLogDetail + path + "/" + name,
        null,
      );
    }
  }

  static Future<HttpResponse<List<ScriptBean>>> scripts() async {
    //2.12.2以及以上版本,脚本路径url做了修改
    return await Http.get<List<ScriptBean>>(
      Utils.isUpperVersion2_13_0() ? Url.scripts2 : Url.scripts,
      null,
    );
  }

  static Future<HttpResponse<NullResponse>> updateScript(String name, String path, String content) async {
    return await Http.put<NullResponse>(
      Url.scriptDetail,
      {
        "filename": name,
        "path": path,
        "content": content,
      },
    );
  }

  static Future<HttpResponse<NullResponse>> delScript(String name, String path) async {
    return await Http.delete<NullResponse>(
      Url.scriptDetail,
      {
        "filename": name,
        "path": path,
      },
    );
  }

  static Future<HttpResponse<String>> scriptDetail(String name, String? path) async {
    return await Http.get<String>(
      Url.scriptDetail + name,
      {
        "path": path,
      },
    );
  }

  static Future<HttpResponse<List<DependencyBean>>> dependencies(String type) async {
    return await Http.get<List<DependencyBean>>(
      Url.dependencies,
      {
        "type": type.toString(),
      },
    );
  }

  static Future<HttpResponse<NullResponse>> dependencyReinstall(String id) async {
    return await Http.put<NullResponse>(
      Url.dependencies,
      [id],
    );
  }

  static Future<HttpResponse<String>> dependencyLog(String id) async {
    return await Http.get<String>(
      Url.dependencies + "/" + id,
      null,
    );
  }

  static Future<HttpResponse<NullResponse>> addDependency(List<Map<String, dynamic>> list) async {
    return await Http.post<NullResponse>(
      Url.dependencies,
      list,
    );
  }

  static Future<HttpResponse<NullResponse>> addScript(String name, String path, String content) async {
    return await Http.post<NullResponse>(
      Url.addScript,
      {
        "filename": name,
        "path": path,
        "content": content,
      },
    );
  }

  static Future<HttpResponse<NullResponse>> delDependency(String id) async {
    return await Http.delete<NullResponse>(
      Url.dependencies,
      [id],
    );
  }
}
