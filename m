Received: from de-smtp-delivery-102.mimecast.com (de-smtp-delivery-102.mimecast.com [194.104.111.102])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1AB70EA3
	for <mptcp@lists.linux.dev>; Sat,  7 May 2022 06:18:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=mimecast20200619;
	t=1651904280;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=6PGAB20y8gi4G4oQQH7h89zYog+vzrY3fPt3trf48pk=;
	b=G0V3VOO9bStygJy0NIUpVprhRx3vGDKQaytbOqCQ49WrIovMEKZpb2zcJVcXe556XaC+HX
	aWzrShqjgJyCfgz5Nu8F554YJsYszZLOmBvfTRC4ffrJN0n9qTfTkX/VVxrpALyNyLO1Aa
	L4AT8/plEbwWEVpA2MTiVVRhBNghVQM=
Received: from EUR05-DB8-obe.outbound.protection.outlook.com
 (mail-db8eur05lp2110.outbound.protection.outlook.com [104.47.17.110]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 de-mta-2-FAnMMhXcPS68G5x_uCa7uA-1; Sat, 07 May 2022 08:17:59 +0200
X-MC-Unique: FAnMMhXcPS68G5x_uCa7uA-1
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=C7trThHnS8vgOWF9m9nVlLQsE5CrBnUt+sdww9/KnJk+1oFgi0vSShaJ535+7JLJHA35+lvejc9YlG2l+Bl3IC/JmGztDaN0OKf7/Xn/6jPq4LACQ4qwak+KqqDenapWsMtcJz6ZJw1S4KBa/BeRPbqPG6PtkA1LGQq8uZTqVqstiLq8ioKZCst8SVgtlRjvFt5AxJeNKilDnKihimM1CHTQPNC8WbJkO7b/XQBDH7GfDHnX+7TSwCCVaKv731Wo5IY5aRluhB7Q+RdmIUpkcRKjK3cWmO81q6uGOGPfcL9+ZzvJFnbBiZF+flNdbYMhQjs0/0zJ9kqAIxKbyG0zbQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lGLgmrySP/xko/1sfkHdBDnRTC8mv7sf5issycUFMbo=;
 b=MkCKJmw4gOe+36L8Ieh7yQsFAbX6Fgz+8gi/IspLXvhrUaB3VaE6DGroUGWLafl/oJLwZX8qsUTQOdj774NQFQI4vNHgFO3aM+bRKO2xxqOrYZk2YYLQ0DieqR2TKBQcCfPX7/g69TJ9w0XtZa23c27qC8rCZ9PmMWnfaX6kX1JfFw7z/Y5N2+L84SJq3nnp6sgXYLApifOfpkBekt7nY2S4saXQQD5lkPVpMh2LGPAmwLIja+5cK7uGoBlRo8e92ORPZoQmIejRkTJVY1LikyfdFYcQRi6FbeBOMzKoQD9QTU3SlkRC7s1DyqHBSZ6LhMWxugWuIBscijPBwS/mhQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by AM9PR04MB7489.eurprd04.prod.outlook.com (2603:10a6:20b:281::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5227.21; Sat, 7 May
 2022 06:17:58 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::9974:fd5e:e3c0:14dc]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::9974:fd5e:e3c0:14dc%3]) with mapi id 15.20.5206.027; Sat, 7 May 2022
 06:17:58 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
CC: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next] Squash to "selftests: bpf: verify token of struct mptcp_sock"
Date: Sat,  7 May 2022 14:17:32 +0800
Message-ID: <5eb277e9599a2d5de5853f339c027e0b3d1d9798.1651904151.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <83acce83a5bafc3b45c45b56105678210d07ac92.1651904124.git.geliang.tang@suse.com>
References: <83acce83a5bafc3b45c45b56105678210d07ac92.1651904124.git.geliang.tang@suse.com>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-ClientProxiedBy: HK0PR01CA0065.apcprd01.prod.exchangelabs.com
 (2603:1096:203:a6::29) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 9007513e-e963-4882-9cff-08da2ff1548f
X-MS-TrafficTypeDiagnostic: AM9PR04MB7489:EE_
X-Microsoft-Antispam-PRVS:
	<AM9PR04MB74898522726DD05AA7EDF4B3F8C49@AM9PR04MB7489.eurprd04.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	Q5G55ANQ9QYozh75GItTBKLtgRVJSo/3SBAPYkQ7nMv3EhP74zgzhhke3mtZozK+0GzmmbadeP4Pz929raCEU1zmOULDmPTD+DxvYxqKcTfRpGKGEyCYfos2dZbx7DQywDxnJkphitzXScxIMlI34PoMLib4K8EoeKWRaA9i6JinD4GBtKLBFizn3W1WRQUwqmXQSr8EdfKSlyRlcuzeV1iKhFyzYQ3Xf8087eTJ/tXLWeenPPuAZuzSKKSYCD185iGPBPTVD3ROxPLJ7BOerYhQeaLvQ4RLbbEg33DD6bidByS2zQ9wKN8tfQK05bKFo/vVR5AGbAHzMTm49F2/rlGNW1nwJU3CWmIGsHQT9xzGQbcmYRLwNCEJCpb1dfgSzQs0qIhIfM5H9ThfMIeVjEHXdlF8ixhl3zxIbGRdOuJ5n+mn1m9eH9aSJ9+s4iXvArKFJpn7AWnrK/R8d6LAEmwz25JK6HWlizYdKakWiWympHC8GOZO2UsVzEScw3gqBJUfkBxGi6ckQKI58fz/QZGtNipb7osL/EEw+fYrmELpnFawHXHSw33y5uRNSokeV1qAtM/PuZDQ5UQ6qWP+F3sl50eZOeEpEAzpa29uV5VTt1Yx1iAyUUVhBNpHq9Q/Yi9k9rVcDzQl4dSj35mw/EbRIl4eqgFaAzuQ6LccbeVEH9wGMqlwbuA/7xF1DtXwlQRIEOCpvvOm34bm22aaYg==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(107886003)(8936002)(2616005)(15650500001)(2906002)(5660300002)(44832011)(186003)(6666004)(316002)(508600001)(6486002)(66556008)(8676002)(4326008)(66946007)(66476007)(26005)(6512007)(6916009)(86362001)(6506007)(83380400001)(36756003)(38100700002)(13296009);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?pr0BA2fSp5K0Pd7e8QXXYrjJSXv/kKHsUz7/YjOYFs/uRh30WPxcRW5JXk2A?=
 =?us-ascii?Q?2NhnDLLmzLlttsQHsZ2ZSW66AKKYIA7h6MsBR3IWYafrPSxWV5tPbUpuxutG?=
 =?us-ascii?Q?ja1pqTLBhY+tLDW3w5HlGqohKZK17DdsjDVz1Jkl7X5ku0mrmH3iVaQktUnG?=
 =?us-ascii?Q?fOThV4KOoTZ7f0jyyTmNWKgyxucR//FoUrbS72f02comiOKeS8hKF7HRKG2X?=
 =?us-ascii?Q?aT8YejLN5TfBMKk2ss9aSs68T1l1+aYvftMBtL9FVdY+UxErj0GP3l2kDVJO?=
 =?us-ascii?Q?wmpm01YBXz5vuQwqAneN/Z3hOoCNw0KX0q7vsxjS2mx4hBWf6ViNrlTU/HiO?=
 =?us-ascii?Q?R85z8FRs3I7YVriP4Y1OpMSyGW8RtW8gWWF5vG/r0zmpl/h7NJATWJY/1bsZ?=
 =?us-ascii?Q?hQofBOad6NKjwSdybqSJolGmcz7qdA3UwEuXUEJMLAVz3GARcNWWgjPKGltg?=
 =?us-ascii?Q?9XsVyuuCAHMTEJ1jVwJ3T31JNVYfWZOhToeTbufTvvHbinJNt6Ae77BPyCv/?=
 =?us-ascii?Q?Yn/Ggc1RQw4CyP6wUJY9m6lf/nQYu87cDUsKHRfhCNvA71jK3p2UWM0kz+SN?=
 =?us-ascii?Q?StW5vJhPPExFdBNWwL52yzN9+j9GtU3+2kRgGljRPLiYq+NDPAZEqLkznKy6?=
 =?us-ascii?Q?54QRyEhQrd9F9eDkrmJSPiZS2tc076+1zUJEqbxU+zUsKa0YEGqm2bYNunGr?=
 =?us-ascii?Q?zR5AzRKj2FR3mx9Ogi4bQ7pXLPMHBuDWSf6dk/MJLCt5lT+EuAhepdPVwtln?=
 =?us-ascii?Q?ZIJT9+MRuq7B/N6XEWiWIWU/cFVIBPxbQ67IpPrj6DwDujemj0iC8SKJ/GyC?=
 =?us-ascii?Q?XLG6SNy/CxYMFIvfXWbjA08ySDiWDkIPUsNpcpZqFW7oCfaN0uo4ChZMMS0n?=
 =?us-ascii?Q?4BQk3UQSidesrZgEX+Tsd0b9LBPf3AEpE3QT6XH3wVNACGvyBl/zlQy7g2K1?=
 =?us-ascii?Q?1lzGjHA1XizLKNotGqAtvCgAcjI0H9r5L/aPUVxBda3IStmbFy6LyLdouldo?=
 =?us-ascii?Q?OvYyFvTWLFWu/kHafpdLtp9cPjzqvDUXs2ssgFHYtCfrL0kuhw+ZnsT96H9A?=
 =?us-ascii?Q?6k+xBnBxQeYSPf9FJcP5anEBJgpSd6qIiEVQ8oE4yyb89zFiWISj1XqLn3Zw?=
 =?us-ascii?Q?TvDoN8lwDUOQPKa0cSAn1GoGKr3nZMY5kTMke0V+JPpmptivQfo8yMrsXYzo?=
 =?us-ascii?Q?0ZO6T19atB9LSgcT8rf3FlN7p0wuNXb2awS2d3GPspE81/Dc5hSZmtNduxRd?=
 =?us-ascii?Q?JxDxbHe8+Y5es4lh4UqZiUqKKZeBFjHgqFyekuL75qaV3iOTeoGdJltpg4Nw?=
 =?us-ascii?Q?Ka8VRZn76CEi7TFR28VeYMoLp83irBfirQoMdheONIwslBz73f1GkazwmB53?=
 =?us-ascii?Q?Hk2rK8iVRHurlv32fQCe9laNRhjrW5rjZ5zR/k7gSAr0alV63z3tDeWiRDVZ?=
 =?us-ascii?Q?OtOJog8oKZsCxcScsZxPyDUp8o1nc2IP+PAhkQ0tXZKbYF1EbwXjxNe3UbHB?=
 =?us-ascii?Q?ZdCzegQE9fJPTOLPwtXbmwPSH4P6fdsMQiM0wxrxE2oOP2m8plPPEHPsPYBh?=
 =?us-ascii?Q?3qbrCs6t7h1WLUw8lmtPNZawtd0SY1IC3y16iRitCUd9ohFbkRpUGw5hKFeK?=
 =?us-ascii?Q?O4e1DrIsN/U1+oGwz/FnL2QlH7nR0e5Ew8Z5FyWXw1f554ma4uaEjWRGvT0D?=
 =?us-ascii?Q?3DCWrwVhWQEDJZUgjpAojNrb5oVjHtCnUGQs/kn0txZID863DYqKxpYm2SVT?=
 =?us-ascii?Q?zMmA9iSmghYczkSuczyxO0R89c9h5JM=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9007513e-e963-4882-9cff-08da2ff1548f
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 May 2022 06:17:58.1636
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +6hA57kOubQV+9y1jAbZuEXe2uzTEPRbYj71osuN/UZ0bTkc9e75aFaInqULrzmcMFUy0WcokmEVCB5mYnUQIA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB7489

Address to Andrii's comments:
- use ASSERT_* instead of CHECK_FAIL

Signed-off-by: Geliang Tang <geliang.tang@suse.com>
---
 tools/testing/selftests/bpf/prog_tests/mptcp.c | 16 +++++-----------
 1 file changed, 5 insertions(+), 11 deletions(-)

diff --git a/tools/testing/selftests/bpf/prog_tests/mptcp.c b/tools/testing=
/selftests/bpf/prog_tests/mptcp.c
index 42d496f52bc4..637e60bc3b14 100644
--- a/tools/testing/selftests/bpf/prog_tests/mptcp.c
+++ b/tools/testing/selftests/bpf/prog_tests/mptcp.c
@@ -56,16 +56,12 @@ static __u32 get_msk_token(void)
 	sync();
=20
 	fd =3D open(monitor_log_path, O_RDONLY);
-	if (CHECK_FAIL(fd < 0)) {
-		log_err("Failed to open %s", monitor_log_path);
+	if (!ASSERT_GT(fd, 0, "Failed to open monitor_log_path"))
 		return token;
-	}
=20
 	len =3D read(fd, buf, sizeof(buf));
-	if (CHECK_FAIL(len < 0)) {
-		log_err("Failed to read %s", monitor_log_path);
+	if (!ASSERT_GT(len, 0, "Failed to read monitor_log_path"))
 		goto err;
-	}
=20
 	if (strncmp(buf, prefix, strlen(prefix))) {
 		log_err("Invalid prefix %s", buf);
@@ -87,10 +83,8 @@ static int verify_msk(int map_fd, int client_fd)
 	__u32 token;
=20
 	token =3D get_msk_token();
-	if (token <=3D 0) {
-		log_err("Unexpected token %x", token);
+	if (!ASSERT_GT(token, 0, "Unexpected token"))
 		return -1;
-	}
=20
 	err =3D bpf_map_lookup_elem(map_fd, &cfd, &val);
 	if (!ASSERT_OK(err, "bpf_map_lookup_elem"))
@@ -197,12 +191,12 @@ void test_base(void)
=20
 with_mptcp:
 	/* with MPTCP */
-	if (CHECK_FAIL(!mkdtemp(tmp_dir)))
+	if (!ASSERT_OK_PTR(mkdtemp(tmp_dir), "mkdtemp"))
 		goto close_cgroup_fd;
 	snprintf(monitor_log_path, sizeof(monitor_log_path),
 		 "%s/ip_mptcp_monitor", tmp_dir);
 	snprintf(cmd, sizeof(cmd), "ip mptcp monitor > %s &", monitor_log_path);
-	if (CHECK_FAIL(system(cmd)))
+	if (!ASSERT_OK(system(cmd), "ip mptcp monitor"))
 		goto close_cgroup_fd;
 	server_fd =3D start_mptcp_server(AF_INET, NULL, 0, 0);
 	if (!ASSERT_GT(server_fd, 0, "start_mptcp_server"))
--=20
2.34.1

