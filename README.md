1.项目背景
国内很多测试团队使用excel、xmind进行用例设计、案例执行管理。文档管理用例及执行，优点是方便快捷。缺点是没有执行时间，没有数据，不方便数据统计分析。
试用过testlink、禅道等开源工具，编写用例很别扭。需要繁琐步骤才能实现案例编写。案例执行管理做的不够顺手，不能快乐地为所欲为。
综上，我们有必要自己写一套测试管理系统jhtd：管理起测试案例、测试执行。

2.君海Testdirector介绍
系统架构：jsp+tomcat+mysql
系统主要功能：目录树、案例管理、案例执行
涉及技术要点：目录树css+js、HTML5 Server-Sent Events(SSE)功能eventSource、js操作dom元素
EventSource这里踩了2个坑：
1.服务端返回的字符串必须以"data:"开头。
2.客户端js请求onmessage得到数据后需要source.close()，不然会多次请求。

系统流程：

 
系统模块功能

 
系统使用三大技术：HTML5服务端推送事件EventSource、目录树、页面dom元素操作
服务端推送事件EventSource:HTML5 Server-Sent Events(SSE)功能，允许服务端推送数据到客户端，低延迟。测试人员在系统上操作后，系统使用SSE功能静默上传数据到服务端，系统界面无需跳转。
目录树：使用CSS、js实现目录树展开收缩，图标变更。默认情况下只加载根目录，页面小，速度快。点击目录后，系统实时请求服务器获取子目录，数据量小，速度快，效率高。
页面dom元素操作：操作页面控件显示与隐藏，无需跳转，实现快速输入快速提交。测试用例执行成功后，按一般逻辑是提交数据后刷新页面保证数据与服务端一致。而使用dom元素操作则省下刷新页面步骤，数据提交成功后，dom操作控制元素显示为提交的数据内容（与服务器一致）。
系统操作介绍
1.创建目录

 
点击新增目录>输入目录名称>点击“确定”或者按Enter键，完成目录创建
2.新建测试用例

 
点击新增用例>输入用例名称（用例id、描述等选填）>点击提交或者按Enter完成测试用例编写
3.测试用例维护

 
页面上直接修改，系统静默提交修改
4.测试执行

 
点击成功或者失败，更改测试执行状态。
