Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2079.outbound.protection.outlook.com [40.107.22.79])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8043B2F29
	for <mptcp@lists.linux.dev>; Tue, 14 Nov 2023 06:39:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="GhUA5jA8"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=c+x2tTV67EHZxe1w1gUgXhAUm7Eht7tPR7JwhSVc8ECaF/oP4wdibO6ZTH4tJE1T1ovas4+sps/6h8zvJCxoEMakddOEn8AyrRaLg68209zImvJqloUcJByVDJ1Abw2r54CguiQkL8fawcQmSaJe+aKNu9nnlP77MO4RA8SM2y4uWoXY8tqLmnNo6C6l2238w1J0hAQb+hiOgyAosHBKOSnQTdJsT2l+tj3//kITgVP2td8qPY+0AMDcHo0GFLUu4E6pR/qNVskKvS894vxUgkXGFkmPiNaibt+ZriMSDfOPlpVSpn/GQry8gorMmB7U8D/D3PbZZqJmNk2/AxmW4A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=T38sL+r3/wWcw1Yc3opwLZGblto/rvJgRPxzV6SkvKU=;
 b=UrJE/+hkrq+hFsq4XoH1zAbXRmHxLyppN44fx5IBvcaSMHVn6sMK5y3qZSTzGS89SULTSodWIuHA1KyNjuV7m2uhPYUkQkuZ53jWTKXfmkqL5/eSQMSDpXZGslziGUPtuY4jv54CEEZzzOYsTYjKBrraYys+//lODMAIPWggK+M4JOU6XgNeETbYrLw8YPsR1cSCv7oC/FgPuXUOVJySPaCPmTz8WBn353xWgaQD8nrGSsWE6nFQ+n96wwhMMebK2eQ+GSGIl3Pj4TIZjZzeHsDcmscbRCRwOgOLWWueOiVow2cISzh9YR1+l18umtHk/60PGU98xcxBUhfbH4nNnA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=T38sL+r3/wWcw1Yc3opwLZGblto/rvJgRPxzV6SkvKU=;
 b=GhUA5jA8TBD5Rr5GoW1yDIPKrt00MNZvIMYsZCVvn3B2VqURxiSMOZFkuyRug6s8ZJHFYrDYwnYxVa37RJfUxexyAa3uHa9EdxLKxKrTlOj997Gvmb6A35WUf+bVC2a33qGh9h5pP3KxjhVxyW0OsdCSDOjJRjVjSqWPhUSzONCZT6+8RZhR0NebwnaTbT1V5iNRRbHhWC68pOzrnlgba/UyfI/dbI73+u0omAlqUfcL1RYetwfB4nBMcybAZrNcW43cl/ZEULSx3nhC0OVx/maNSsiuc/WpAcUFgwRtpUQ2hQ09Sa9kB1dSxlEkorg4W1QWsHtXEe1bA6mt0/1KYA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by DB9PR04MB8480.eurprd04.prod.outlook.com (2603:10a6:10:2c6::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7002.17; Tue, 14 Nov
 2023 06:39:32 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::7102:259:f268:5321]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::7102:259:f268:5321%7]) with mapi id 15.20.7002.014; Tue, 14 Nov 2023
 06:39:32 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next v2 12/32] selftests: mptcp: diag: print colored output
Date: Tue, 14 Nov 2023 14:35:31 +0800
Message-Id: <cbc7a615c89b83e8d6e5afcf3c53a177b802ed7b.1699943337.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <cover.1699943337.git.geliang.tang@suse.com>
References: <cover.1699943337.git.geliang.tang@suse.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TYCP286CA0213.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:3c5::19) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HE1PR0402MB3497:EE_|DB9PR04MB8480:EE_
X-MS-Office365-Filtering-Correlation-Id: c3a5c3df-03f8-48cf-fc40-08dbe4dc7583
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	InjrJve48mhl5ru9SyTnm5g3A1gxiTjlaATtVfEpgCa5cB5rHfZLfyQ3Ri28UzjNk0ovUDZiaSQ6CaX/fCyqDkjvcbBwNr9rTIyVl4uVGlp2z8AmmiTZVPVsQvHvzRgR/8LN4oomgLRZzReTRunP5fK979PTiL1uJyJnVBNbcK3pL4tS4O4+cuIdbvTkLn1sPibnb7A/z8h7ZrWd8y36TBUbjpWdXlodJ+TXAdSECqrEhAr95jOMNe7Gz0eMjSpHxd/1/VQEJv0s8lY8Auo97wOpJNkdfy3oue+0y8+k6f9bQYAfeA6xHRhedVoKWek7nnxgh2GZYTJ5uXYvDqmzt/IOTpB9C6LNlYv0zbX4jhRudSLaPUCtXXCc3+YgbhwwNVgXx4AY1jy7wozJgCzh7Pwa79LKRrxt9h92cpjZOoXWBp5ql5QEBJBjVhKRmjZy/cuOCgbi+Wu2vSkkWCgT/cIm5csfZtN0X9SKIxn6xPkJtEsJBMlCKPTw61J019CuxONh4My74H3uhbL+VWkGdZq92Udds9GNmV+hsDiIrtD26aoMlNT8c2v0Q9Doqg2X
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(376002)(39860400002)(396003)(366004)(136003)(230922051799003)(1800799009)(64100799003)(451199024)(186009)(2906002)(41300700001)(38100700002)(66476007)(66556008)(478600001)(6486002)(86362001)(66946007)(6512007)(2616005)(26005)(107886003)(6506007)(83380400001)(8936002)(8676002)(4326008)(44832011)(5660300002)(316002)(36756003)(6916009);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?QtIIGPVswTbykrywBmYS1L7IYWnA7wnFZgyGdXTzVtxl95CxUHUDJb17V5YL?=
 =?us-ascii?Q?Dw2kaHXGVl9wdiUFQdbmjETlRyiiVAhVDZofLS9ofKhtN67XMDqcicr82DCx?=
 =?us-ascii?Q?lwWi3/55GPiCpUnO+PVVmGtA+V7YGXzOxGcVu5AacMALAkhq6aKo5s+0kpA+?=
 =?us-ascii?Q?AKEJSGqzE3/yOQJ7UiPjhJO6dcZkK6qh/FYbBFuAPVxORbw0T9eRYV9V0E5D?=
 =?us-ascii?Q?dQJIst0JO80QysQoXJ2WhR6E2Rq0qxssDf3nj3QyPa9dxECezlE2kpAL/WYz?=
 =?us-ascii?Q?kkBG8kF2RKTvmS/aCtQqoBDLsQV5c75yiF/+JbKQVchaqaAMuq9nGFlZrcvW?=
 =?us-ascii?Q?qt4NbwyZnCLhSIsMJa7Ff/EwUNVfl8NWZET0jEtz7tffovB7HmXS03zWy91T?=
 =?us-ascii?Q?wrr7NWmcIAl7YNRVzyiTEWssrBernY6PRImCAbUtx5DZKjMsGhurxf4uYWW1?=
 =?us-ascii?Q?OgnDvgfoRj/YBwQLdwGzZZFCc9ezhxsbiyJ9/VMtdHdSHXJ+xrPWRMlsi11s?=
 =?us-ascii?Q?TlNHlHqFTDViMXQTCJikpCJjc92vHWvzABzLuR30mOzmrOgrpEuil2k2eaEW?=
 =?us-ascii?Q?ZFlMCp3P8dV+Lxb/gVtSariD1EoJW4c+DsQK/re6mONv96uWRJjoeYQzfViD?=
 =?us-ascii?Q?2OOyp2H22TvoAl4Gv/IRmmjfWs2mpX6o/t2dRr5l+oGgX+VLR5lZkOlreIAk?=
 =?us-ascii?Q?BeZ3wDS9y680zF/0ilvFNxFjGOS/xQX6sFd1B7trMgNI174+KIbviGUy/kb1?=
 =?us-ascii?Q?SpTQaYTwTSrzxAYYuyRu1qZXERVFx1Ydq1g1y3Cfm4BWJNu02qkMt+wCYGZs?=
 =?us-ascii?Q?vfijdBtihA846k/qNuI4sBPVg2qAdcHJdrP4dKkrD9xOAvvf8BigLVX7BNUy?=
 =?us-ascii?Q?84DJmp2ZzVtGUnbAHdoZ5DuRMvRV6MS75YwTAlyCrf9UmDfT+vf62mSSrXBY?=
 =?us-ascii?Q?UAgHe6Bs9muxTrDJh1cCzu2RZwLy3NgZdQcv/QpEhTCyPz9neaQnHYScY6sH?=
 =?us-ascii?Q?kpzIm1xbXfGYqQpN80qniy6BOJtAWR1xE2jzK0N9yvctwtRlM4ZmLM+VWTy8?=
 =?us-ascii?Q?botPhaANcKwAhuU+vvLc0plxXDlAA6e2BWvkA9IOW3sXjcGabrOV6Pkzz3Jg?=
 =?us-ascii?Q?RDEzaR7qnVXNfMqMCAbaAGgUyujWLQQUeUO5edndvjm5I+ObnU05f8yUhBFI?=
 =?us-ascii?Q?w90oiqIHzX/zIewPUb1ujOUISB+EWzADRjBOTAkd+hEdviAKNMif+BjfwXlE?=
 =?us-ascii?Q?2rJav3icMXem7cHQLsPPzunyzHbdxBXmH1nszm7sPoZB99rUUilCO20EGTnc?=
 =?us-ascii?Q?sIdimyxHFm2wSman02CSazKnTgfoNm7lKQ853OADxacOKH8ehO/J1LA/OMHa?=
 =?us-ascii?Q?ETeagDRxJYreMmB1DhuXBNf4oRlPuE7FEBv9rVXj4v6QuJNuGzpKb8yp8daQ?=
 =?us-ascii?Q?OKl6K7qQz7t/xMGRkCnlJpd43CNU4lSlKGDqxKf7qoiwLdOnWcd1lpT2nHZq?=
 =?us-ascii?Q?7giFpDUQUEG+dL9aZvgwyyjdimfKQFTPAQDwR106ed9ZEJkHaiD7V38eMVPK?=
 =?us-ascii?Q?H9771DVYB2/a1u8LQ22Mbk9lHkDXKkMnxpOzKqXd?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c3a5c3df-03f8-48cf-fc40-08dbe4dc7583
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Nov 2023 06:39:31.9696
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ZANrobbmlNnEBfV1dhNCipe2h00SBTalXW0n4qxrodQgkj2sdEOLg9FXgCu+EJmJJUFH445nI6lpaYXxP35Wvw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR04MB8480

Use mptcp_lib_print_ok(), _warn(), and _err() helpers in script diag.sh
to print test results with colors.

Having colors helps to quickly identify issues when looking at a long
list of output logs and results.

Signed-off-by: Geliang Tang <geliang.tang@suse.com>
---
 tools/testing/selftests/net/mptcp/diag.sh | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/tools/testing/selftests/net/mptcp/diag.sh b/tools/testing/selftests/net/mptcp/diag.sh
index 3119811018fc..7cf1f602bf48 100755
--- a/tools/testing/selftests/net/mptcp/diag.sh
+++ b/tools/testing/selftests/net/mptcp/diag.sh
@@ -62,15 +62,15 @@ __chk_nr()
 	printf "%-50s" "$msg"
 	if [ $nr != $expected ]; then
 		if [ $nr = "$skip" ] && ! mptcp_lib_expect_all_features; then
-			echo "[ SKIP ] Feature probably not supported"
+			mptcp_lib_print_warn "[ SKIP ] Feature probably not supported"
 			mptcp_lib_result_skip "${msg}"
 		else
-			echo "[ FAIL ] expected $expected found $nr"
+			mptcp_lib_print_err "[ FAIL ] expected $expected found $nr"
 			mptcp_lib_result_fail "${msg}"
 			ret=$test_cnt
 		fi
 	else
-		echo "[  OK  ]"
+		mptcp_lib_print_ok "[  OK  ]"
 		mptcp_lib_result_pass "${msg}"
 	fi
 	test_cnt=$((test_cnt+1))
@@ -111,15 +111,15 @@ wait_msk_nr()
 
 	printf "%-50s" "$msg"
 	if [ $i -ge $timeout ]; then
-		echo "[ FAIL ] timeout while expecting $expected max $max last $nr"
+		mptcp_lib_print_err "[ FAIL ] timeout while expecting $expected max $max last $nr"
 		mptcp_lib_result_fail "${msg} # timeout"
 		ret=$test_cnt
 	elif [ $nr != $expected ]; then
-		echo "[ FAIL ] expected $expected found $nr"
+		mptcp_lib_print_err "[ FAIL ] expected $expected found $nr"
 		mptcp_lib_result_fail "${msg} # unexpected result"
 		ret=$test_cnt
 	else
-		echo "[  OK  ]"
+		mptcp_lib_print_ok "[  OK  ]"
 		mptcp_lib_result_pass "${msg}"
 	fi
 	test_cnt=$((test_cnt+1))
-- 
2.35.3

