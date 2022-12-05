Project Name：Sbeam Game Store

Framework：mybatis + spring + spring mvc

database：mysql + redis

chat：websocket

How to use:

1.Modify the PROJECT_PATH value in data.properties under src, and the rest of the items do not need to be modified

2.Modify line 50 in the com/sbeam/util/Resources.java utility class to replace the path with the absolute path to data.properties in the project

3.To use the Alipay sandbox, I need to modify the return_url value in the com/sbeam/util/AlipayConfig.java, and I used the intranet penetration address in the project

4.There are two backstage management in this project, one is the game publisher management backend, and the other is the official management background of sbeam (can only be accessed by entering the address in the address bar, the request address is: http://127.0.0.1:8080/root/login)

    4.1 Game publisher management needs to click "Cooperation", fill in the required information, and apply

    4.2 The Sbeam backend is responsible for reviewing game publisher cooperation applications and publishing game reviews, and only through the application can games be released on Sbeam

    4.3 An email notification is sent when the game publisher's application (release game review, application to release the game on Sbeam) is approved or not

    4.4 To log in to the sbeam admin background, you need to log in with an administrator password, which is saved in the t_root table in the database

5.If an error similar to "looking for a value, but finding multiple values" occurs during operation, the probability is that some values of the data in the database are duplicated, and the duplicate can be modified or deleted.I didn't insert data strictly when testing or due to program errors, the inserted data may be partially duplicated, but I was too lazy to change it :)
