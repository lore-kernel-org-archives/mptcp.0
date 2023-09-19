Received: from EUR03-AM7-obe.outbound.protection.outlook.com (mail-am7eur03on2044.outbound.protection.outlook.com [40.107.105.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB81334CCA
	for <mptcp@lists.linux.dev>; Tue, 19 Sep 2023 04:03:34 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TSrQVGT7NUNyVBr7HREwqAhMM/4PrweZYu9LyM5UGltG6O3/HAvZoQJk77XSLBQjVr3cFHoKsMXC5wMAewHj3c37pSUypRqqlQtqrDZsVOC1oZ6WsR3qxjn0yZ1bqwiEH39Q6qMgHsDga8ZNw+PqFB5BuZ1xtISWpIGoKFAMruoGjRCsM9g709YHvOcdwmGbwMrjxX3ijEopXvMH+Td9+k4aTfDGbq846t1jXbokXenyRUE9kuqjDd8E1S0KACqDC+inrVCAHwsi+rCQWdLpsq064V7oYHjVPjCCopxLyS1RDGHByu5bStnxLZYV6lVImYfyMUDVUBhABGCfoFlrvg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6DVloCXJ3mYJju+edLyiaPtl++IR1GJZL3EH6ObiDIE=;
 b=efwhMKkRbsb0dmA6Mwd4OrYaKzUVmzfOkJNNntubulG2yPMnkmHyBmdQmnkyD5l2+Er0f/Hib93s40sWDdrs6cwDo8q3jEkfoONl4VN5OU40fmWAINAoRAd4Sisx/MzFsuZ6Ugq6EB9N0qp2zzZchqJrUsJyGE45Uv3i+KPTyfB/ii/StZo5VlOw+GeaIlTxQB3xAh68GbEjAcEeQq9DwLt4TxtcEtK0+oW7+agAWN8MI6nsn9TLSFDm65Eq1UA6UEn3VMzl6WNyuOlMEn3XuyeLvwwtK2Mv6Xqiu6ZOiyNOWByZlghK6fWY1NVYgh8PiKM9nHDp88zbHZKpbBJiLw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6DVloCXJ3mYJju+edLyiaPtl++IR1GJZL3EH6ObiDIE=;
 b=efWeto7dYNT3Xh+BShZryHLgCppUxht8ydz4UQM/Bi97H3tiYGWeATcggAnnRDVzesYajEB1U+TaPOUpeQn3NYgJ25pYmjWNjGJOvzsU2JCkd9iSAqGd/kDfWiHOOUk3wGeJOTx/yHN0/ZKTxUqpO3/NnDltMoECrA3WGRNpKCHQo8nxVeOBV0lRdfKwgwmbpXnMFlmbjECvX8WornFdv2QxcjfpUN9G9jvRQCUCD0oKAAVrfmuSrwVJlIbudaACF52NJ9v9d/uf6SY9+tqbpyadQzatSkPKdkRJhlGewg6FEUX0FMlGAzNtvVyHuoLJz4kimg7PTnu0yIT6J5TVNg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by AM8PR04MB7297.eurprd04.prod.outlook.com (2603:10a6:20b:1c5::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6792.27; Tue, 19 Sep
 2023 04:03:33 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::2867:7a72:20ac:5f71]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::2867:7a72:20ac:5f71%3]) with mapi id 15.20.6792.026; Tue, 19 Sep 2023
 04:03:33 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next v2 13/30] selftests: mptcp: userspace pm remove id 0 subflow
Date: Tue, 19 Sep 2023 12:02:14 +0800
Message-Id: <d6c078c4308ee5c7101ec9d7eed2496f24cbe609.1695095289.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <cover.1695095289.git.geliang.tang@suse.com>
References: <cover.1695095289.git.geliang.tang@suse.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2P153CA0028.APCP153.PROD.OUTLOOK.COM (2603:1096:4:190::9)
 To HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HE1PR0402MB3497:EE_|AM8PR04MB7297:EE_
X-MS-Office365-Filtering-Correlation-Id: ec707d3e-a12a-4d06-835c-08dbb8c5646d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	2SJiSQzwuxsH45hWQPp4tQRjhR1rf81t3gvPuBTeW9aUtub0dZXLywIIUMFOP8X67YkeiIQNIpoc1FXGWVys6vHQGEExtvfCMJQ1OM3vWJSZ5Q2yfK+YEi0HvRVrSRYtxe5aVHsryF0USQJXyNBlLISON+CvZ4G7Kwm0MBcvZ7glTa8Xv72JUvFI/yCe8/CllBfLrsjJbnJ5WtSpgrsxCRKyQbopRX7o92Ke6WiSPB/+ZxPrFxhANLYLDqN+Ilqc19MvLZY6lvYGdKQKpjEyns0Hv5dv/sF5W4b2DUFCbp6djWXdJlfZTyT0ttH6F5Hr0vkaQUjrpdR8uz8sdVtIltyTant4WoGqIDHOkmG/p/GSX8G5EsPpK6A9TcmDTJU27MP1VLARYKdLl2lg3HM+d/7rXX2udS7e5INt4m5V7KwdNufeY4aJ+3EacHFAJ/rbCbCp8JaMqvaaUV0nRq19Xv2BpHipSZRCHIoGetsc2dlgPh2da+DRMnbcK46e2RWAmeVOmY15iq6VpGqg88RiRcq+iS+WzOI0jo57yxpODWbQdtHUK9XOY2oSluNgNaxjIMMto97sm7NCdxNU+ysKGGpTL3sWqoy2ugsW1Z5WAs8=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(376002)(366004)(346002)(396003)(136003)(1800799009)(186009)(451199024)(83380400001)(36756003)(2906002)(38100700002)(6506007)(41300700001)(6486002)(2616005)(66476007)(66556008)(6916009)(316002)(66946007)(6512007)(86362001)(26005)(478600001)(44832011)(6666004)(5660300002)(107886003)(8676002)(8936002)(4326008)(13296009);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?vxEQm2Drh542C2N2lbd02xUMkkubbsk+TaSE+elD2ZJKdduAexAONzsgLZsu?=
 =?us-ascii?Q?9msiiUolE0V2An0Du2+PXBM1MYIjD0W47sCH2tLuqBeKvKIzrtxEZbFSKCzq?=
 =?us-ascii?Q?xTkYfXoUCvXHB1x8VzTx7PxJv+59V/CMqdFvRnQYzCM15rDkBMeN+7PLV9lv?=
 =?us-ascii?Q?LUgo2kZMdlblC0jms1pTC8MQVuCQJYpMfWDYkHUSmmjFOAYymFO/PrpySefK?=
 =?us-ascii?Q?RNLye8Z5hP/vfjwk5lm38/4bWr3aZYRUYTQCmSDiAD7sXFQCDO8IU2QyuWSN?=
 =?us-ascii?Q?FnnIqsvyOAoaHdJP4ui2UCPMZ/WoWBpnJd8x0NihKJKJxJGCTDHr1mPVHREQ?=
 =?us-ascii?Q?9+YoC38Ecg5505nyqeKPOJi+LwNPVYAzgN4vtOkVL5clf7qGw0K+lyx9IV6w?=
 =?us-ascii?Q?dhV8jJDGF8ZhhHGluDAYH1qXndhIRsnyIx8Nj+jFLNbGKeFJmXJsAxbBWNqr?=
 =?us-ascii?Q?45RidkIf7uT1b6tm7F31JCqcKoYiHYxIPT8VJ+e7XrommB/FnJJD55EysQeG?=
 =?us-ascii?Q?S4DigR46bRpyPIB5gzstwOz9DDTDsfZvMDqKfGIFYvGxnRkccxGWRdxYzzC8?=
 =?us-ascii?Q?GhDuzI+c9/aQ1JhfxMxWIr+XDKO0+5wL7JNpuDE/786D9jFXKSTgmK+Lw1FZ?=
 =?us-ascii?Q?vXrCYZZy6+qXv7IJYxH15Fcz0KMhUt3+rdrnMuW02bQydgPJ8HRGMn4gTXvo?=
 =?us-ascii?Q?TFFhD1mhoxFXoC+bOU4tDxdTPJhi3Z+HOoELr4c+x0da2BzNo9Y4rKjj8Yc9?=
 =?us-ascii?Q?Zsmqcs1Lwcn4Z9KjmYR/CiqcJi37NyNv9KEJzn0Ph8TPH0YosbTyc41qXGkt?=
 =?us-ascii?Q?Zf1e6Eh0tWN7vzIc2BI9Dlb66n131gIFlQkPD7pMI8Id/9K8gT2M7wMIkHKp?=
 =?us-ascii?Q?p9Zhp0CZHEgwyLq+TSa/YY/CLp6YC/1hLzkOSbpd5GqrTfBVpyuYwBVsM48c?=
 =?us-ascii?Q?KtKYHlhqRCiab3YB47EBIWZOV2dJ+L/3lBrZA4kMcTs69dUkC3YU4e2xVWWo?=
 =?us-ascii?Q?5F+Y+fnWEwZeasALOi7I6VVgBDMUCnEBIdQA/nHCSTUp2/+hO5DJbXBwtgp5?=
 =?us-ascii?Q?50YqU3uZ4vJHHbQwLoAmHHaN6EX4DbzpEJoqXtoN4+m23FqFcig7ppJNpMRp?=
 =?us-ascii?Q?M2SowZAiSX1sqoFLypv09wQWGvETPxRy4jpZKkav+jadMbnDSyM78N2ubG8F?=
 =?us-ascii?Q?TgLvbGOgZWXeCDDKCAVClr7kVGkhNKupjwJtDAIq0N4D906rihM4sUC+BusF?=
 =?us-ascii?Q?xckqHsTIApEuO4MpnThvtgqhs/r5i8przdg3Y9KqncqiNB9OSwqzxPiDSACK?=
 =?us-ascii?Q?brNkjx07zrMHtvGEEKRZj6Er3Ob6PY/nCf8vzdbkf1qYNrSXGigx/R/KmzJl?=
 =?us-ascii?Q?PfT8S5C3lDycpaYMIW8hC0JJsejN+zijN8E4vMsFXaOeB1enFThxPAfooFDz?=
 =?us-ascii?Q?4DjPDwo4g8Ntaj9PzRkp6i4FQZWOG/YLr2ZH1+VYk9hrb8yjX/FQlCFBL/IF?=
 =?us-ascii?Q?xQRHqUR0A8/SCiK3UscoQjP2NHUvy46QqxPRT0J8Flgc2GuUMzXZhM7kE6+x?=
 =?us-ascii?Q?s69g+vltUN7D0B1hx6Dki7a/HAZBkf3+dZ/IhodJ?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ec707d3e-a12a-4d06-835c-08dbb8c5646d
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Sep 2023 04:03:33.7333
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: OxgDLHaci9rqIyPk7mKz1VuvRM8uRSohCXTA3sX+T4G7kFtDDO2ged9cPAwIco/BZajSQ9RsyK3SubRmzJw8DA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM8PR04MB7297

This patch adds a selftest for userpsace PM to remove id 0 subflow. Use
userspace_pm_add_sf() to add a subflow, and pass initial ip address to
userspace_pm_rm_sf() to remove id 0 subflow.

When closing the initial subflow in __mptcp_close_ssk(), dispose_it is
false, then tcp_disconnect is invoked. This will send a MP_RST to close
a subflow on the peer too. So chk_rst_nr() is added in this test, and
chk_all_subflows after closing the initial subflow is '1 1', not '2 1'.

Signed-off-by: Geliang Tang <geliang.tang@suse.com>
---
 .../testing/selftests/net/mptcp/mptcp_join.sh | 22 +++++++++++++++++++
 1 file changed, 22 insertions(+)

diff --git a/tools/testing/selftests/net/mptcp/mptcp_join.sh b/tools/testing/selftests/net/mptcp/mptcp_join.sh
index 25c2948391f5..ca75d2c6d415 100755
--- a/tools/testing/selftests/net/mptcp/mptcp_join.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_join.sh
@@ -3467,6 +3467,28 @@ userspace_tests()
 		kill_events_pids
 		wait $tests_pid
 	fi
+
+	# userspace pm remove id 0 subflow
+	if reset_with_events "userspace pm remove id 0 subflow" &&
+	   continue_if mptcp_lib_has_file '/proc/sys/net/mptcp/pm_type'; then
+		set_userspace_pm $ns2
+		pm_nl_set_limits $ns1 0 1
+		speed=10 \
+			run_tests $ns1 $ns2 10.0.1.1 &
+		local tests_pid=$!
+		wait_mpj $ns2
+		userspace_pm_add_sf $ns2 10.0.3.2 20
+		chk_join_nr 1 1 1
+		chk_mptcp_info subflows 1 subflows 1
+		chk_subflows_total 2 2
+		userspace_pm_rm_sf $ns2 10.0.1.2
+		chk_rm_nr 0 1
+		chk_rst_nr 1 1 invert
+		chk_mptcp_info subflows 1 subflows 1
+		chk_subflows_total 1 1
+		kill_events_pids
+		wait $tests_pid
+	fi
 }
 
 endpoint_tests()
-- 
2.35.3

