import 'domain/use_cases/get_local_categories.dart';
import 'domain/use_cases/get_local_supports.dart';
import 'domain/use_cases/get_national_supports.dart';
import 'external/data_sources/local_support_data_source_impl.dart';
import 'infra/repositories/local_support_repository_impl.dart';
import 'presenter/pages/local_support/local_support_controller.dart';
import 'package:flutter_modular/flutter_modular.dart';

import 'presenter/pages/local_support/local_support_page.dart';
import 'presenter/pages/local_support_filter/local_support_filter_controller.dart';
import 'presenter/pages/local_support_filter/local_support_filter_page.dart';

class LocalSupportModule extends ChildModule {
  @override
  List<Bind> get binds => [
        Bind((i) => LocalSupportController(i(), i())),
        Bind((i) => LocalSupportFilterController(i())),
        //Use_Case
        Bind((i) => GetLocalCategories(i())),
        Bind((i) => GetLocalSupports(i())),
        Bind((i) => GetNationalSupports(i())),
        //Repositories
        Bind((i) => LocalSupportRepositoryImpl(i())),
        //Datasources
        Bind((i) => LocalSupportDataSourceImpl(i())),
      ];

  @override
  List<ModularRouter> get routers => [
        ModularRouter(Modular.initialRoute,
            child: (_, args) => LocalSupportPage(myPosition: args.data)),
        ModularRouter('/filter', child: (_, args) => LocalSupportFilterPage()),
      ];
}
