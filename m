Received: from EUR04-DB3-obe.outbound.protection.outlook.com (mail-db3eur04on2084.outbound.protection.outlook.com [40.107.6.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32599612A
	for <mptcp@lists.linux.dev>; Tue, 14 Nov 2023 06:41:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="yqbtamEp"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IvbSaqVb/f9KVSGld44uchmluxFvKRSUDBHYDqWkpCJVMc4DoOZUtC4+twFoPGEU8ARapC76en2IyTgJLlR+V2Tcjy3DNpcJFkMXLghXjBD5C3uFAj6Dnzr/On+vwZrIJ2JJl0VGmgfBWPj+MsfwWppp//TejF34hJyIq7eg2O1QvgsvNMSyAAmS61LyXMJG30b+q/wRqhQ/FD6S0j95BlIdyAi//3FcJdWLkxB0xf+hhEnZdwvfNST1uT0FI2tFq/483pLGjp/7yvO/1cvNwwN65TWPw56K18dMXo646aQ0ZR2BKqg5CJ0tPJcMxkhbkjU+pnrPSvsWeJgHEyb+Ew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FfTYFwfdumfrUg0A69xyNV8GWtgfbuAvEeEOU8MFG6o=;
 b=Wq4ftuBocgv3Q4V1U070lel/cogRdNLiGKuUtuOEZRBW2HlFRR9ALRihgef4sIAXyLA8ov0p5SvKCN7j84UjkLbgv5Vko/YIYTEPrt+iAfbPJcCUwLEn8wm5hQOTAbXeO3V1Ox5dYQZCVzbyF1VY6F9XxL3YZ763IvKejFu93pcX03LkhN8PSNZ1ixO8u69QqB9koKlKHOhMGKikarGSCPuG5zyBVbGM29hR+chNFhtCiHuKMQYHzW4/RdXmpdMLRQYddIWP6noQLScP2yXNXoKtniXDnQZ2XDcaU2bGc26hGWD4Y0hpLGuUg1pYremjWTVfWmMarGezcu3ubdJ9dw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FfTYFwfdumfrUg0A69xyNV8GWtgfbuAvEeEOU8MFG6o=;
 b=yqbtamEpatlnrU9gRCjYbUH2w3CR/k5x4ppyx9xsXaQksRcRPsXXIrcJBd5bDQN1/Za+F4gZrgBqFVUxZQdiJ63sbZBYAAzguxzmmD8enGsh7Dbtx7Vao+G6OWTjHC2c5esAFli4eRxjt30pCRT0KHnnJ3IJmUKTAOv5IPLGj/FThi1feYI9Fql5EDfOtZM6XHLn1LESaFN2raGRrPNEJDE7Qb7DamBObCIhzoJfbMn6dGTbQxgRWUSQovuuvtYvwTceSi7vyVnfnwUT960kaesWrMRtFnd6yisQ5r052ZXDo8sz4rWIMgtjhFh3eIjrzYMWZmyBp3GV7WMOzdyxgQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by AS8PR04MB8932.eurprd04.prod.outlook.com (2603:10a6:20b:42f::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7002.17; Tue, 14 Nov
 2023 06:41:04 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::7102:259:f268:5321]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::7102:259:f268:5321%7]) with mapi id 15.20.7002.014; Tue, 14 Nov 2023
 06:41:04 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next v2 25/32] selftests: mptcp: export TEST_NAME/COUNT to mptcp_lib
Date: Tue, 14 Nov 2023 14:35:44 +0800
Message-Id: <d8ef9c1d2d14e4df7b90ef652bdbd439b30a543a.1699943337.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <cover.1699943337.git.geliang.tang@suse.com>
References: <cover.1699943337.git.geliang.tang@suse.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TYCPR01CA0157.jpnprd01.prod.outlook.com
 (2603:1096:400:2b1::10) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HE1PR0402MB3497:EE_|AS8PR04MB8932:EE_
X-MS-Office365-Filtering-Correlation-Id: 4b39a146-401e-4432-82cc-08dbe4dcac95
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	K78WdKRocKUI9wPy6R5gP9KhQmriT+siYU3s+nrvM6USCVxy1JBOTUUWpcq6VNt/TwraJJtMMTXp4iTvlssfZMotWPDkJFsKglOiscbEjkCDUe4BG2JrTBf8bp6Py/DoaQisHIag3qpXt9PO/r6QtuH6IRUnWrLjKytVqyiptNzRGRODI5IwIvyEFD6lRl4UjfZl1XIXuwqGUFbhkIbewtm3rMSUaQ0K74k/BY3hM7LvolhNOC2SYr/6HZzjvbKUTNIsYveYazORAKKpttSP0xe/4k93wKFbpIlrEA320Wgea+Qf+PfSiWRy5GVrGFQdCVpF6y0RqqiNEUUOLTffZxJEixA37ctDbz4DH8WZkO9FivfEEF+BGdNwaGD4ti+gmrwia3lMnRykYax2VVsA70psXcSVzOqezIPOqvZC3Gt63Ur7txAifFcRQGXyxXLPNqN/hATzXo+s+CSZ4Qb88q6FgCWEx7VpEhgAFl4a53Z+RqPIl2+1MyQ8KoD4GD84UT7Qaqrytoibp+NlqdiX3fH7m7RGEJW5PewG1s+JKVRJKShi/lUPNqOwpNnm7Kqk
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(346002)(136003)(396003)(376002)(366004)(230922051799003)(451199024)(1800799009)(64100799003)(186009)(107886003)(5660300002)(2616005)(26005)(6506007)(6512007)(44832011)(6666004)(83380400001)(2906002)(478600001)(41300700001)(6916009)(66946007)(36756003)(316002)(66476007)(66556008)(8936002)(4326008)(8676002)(6486002)(86362001)(38100700002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?UAE5OsaAW6xKzPG6Y5NtPSnG3WhHUQtuUfQLTf2R8ORpK72uhAqK2RLQ0osn?=
 =?us-ascii?Q?evX4yJ7ZGvrWNsVPWWhffPOzUm3ekQCO0fSyEpNcA0IkPiQmrLoo1DO7lsLt?=
 =?us-ascii?Q?KzpV+mHd4dOAqtJp8QYqFdi3t9qZqkaBInbuiei9tYCYaF86AXICIcvR+3SF?=
 =?us-ascii?Q?TWfd4lnTMGqbkg4Ok2LE/hU8OwhR3u/MO/MnXKlJCkVnRjCCDxT5YvOnK7Lk?=
 =?us-ascii?Q?eo16oClo23lmXzpLa6PQ9/GVkZCnJZeXwV+jh0poOPMInaAkDz9WXdtlZwXK?=
 =?us-ascii?Q?CY71GqUCYzyOBQHWMb+nrR+x1Z4QiG4DOn3f/Ka0Tw73cluY5e29e+/Hywye?=
 =?us-ascii?Q?Tq3jsqPYYMpJBjiP73F3NstPTRynl5Xe3qEex0VKdQCM7tdRdGvTCvrOXUdK?=
 =?us-ascii?Q?V4W9qg5NjCRCiVIXPn9FI7d119kB8sPYk4eL2vg6yrH9NiAEYjP7JP99ifeB?=
 =?us-ascii?Q?KVdmX4s6yY3AhUxv3LdQbdvQSn8jmf+/6OO+TC1WQ4IJJDIi2O9oRNo7qjyf?=
 =?us-ascii?Q?hf1eVxp6jmBfFfNfzf7veny6SHTPtPFCKbkY/yZ+DLKH+eYSAUxUU6yqkz34?=
 =?us-ascii?Q?BxTSC8Pbljp1ri/1WTjTOInLMlijtsg59UZbLKosLbh201GuxEmlM6SXi2vM?=
 =?us-ascii?Q?kPQ5vogRVtKF3wde5ciBBftezAhCnlsxIdNo4nr23/cmaSjBGwk0rX/m0nT9?=
 =?us-ascii?Q?lzbJHI+1jbNHJwiY9bClBmR4Y0hPLDUAP7DfpoQCz3xS47/3MHCWTgPz59GD?=
 =?us-ascii?Q?HfVlzFOg19/TgHHqF6gtazNcVfeOHqyWhJEIXt8M/oqcJm9lnXc2AVsEhr4/?=
 =?us-ascii?Q?R2M/ftVRjM0EfI7SLKZbfJ/+rHEp8VHYnal9z9fZOPJPNxHVJXf3nV/XNTtw?=
 =?us-ascii?Q?f+579s8cDC5G4MyeHjeTls1MbyPCSDZk+XcIHlNW/5to3R+9NW3rZbxLO21R?=
 =?us-ascii?Q?Z6AddZBf1uJ9zBouratFiMj56jp8VqayPZzQihDov+y0fhtbjnmYCH+NTz12?=
 =?us-ascii?Q?91DhehOIqe0GYucnWFQ/wfRD/8J39JDMw7tAGOUHurTyyuQIUtT4O7liiuqk?=
 =?us-ascii?Q?P4WnDp+i6oGhmU8X+XXtQZe8rhLxDDuyLlbFZqhau30RfjTe7JWy8nOYaDh1?=
 =?us-ascii?Q?1tFFLtPShBLjFC4xH3Yj+TYVQunmfmLIMIzvJz4HNeaokebVAOfgL0bJeaLo?=
 =?us-ascii?Q?TxWfO9YAQ6j6gy/hirb54V3SPvBguabWhH8Bry+2BZOPCnWIyTC8inL19dzS?=
 =?us-ascii?Q?8nD6tnF8uhSLrwugIdZx4AmisKAUCl2SQBDTa4n4u6oK4Mr5N3yzpHp+2nF6?=
 =?us-ascii?Q?9xHv7QRrQBVZ3C2hjTZ27UXPrx6hfyPtIYw9BeS5hJ3bT0tCvbuR60S4MUXL?=
 =?us-ascii?Q?H5WYIp4KXsqzcuFsObp8CIevsrnyclgunOXfEtYD6CFmXYZVJ+bWCmnT1MWR?=
 =?us-ascii?Q?SMbwg9Ng7CJuFYUBFjqni4Jky6gKSnbHkw/CKjWP+vBuQr/q2KSDEmzvCTr2?=
 =?us-ascii?Q?NUbzR7jf+Lt+Xlgm45FONGLTnWFacjTxeynsE3VVJ3mkqHgCzY/v7AKfck2o?=
 =?us-ascii?Q?kg/17KTq6vSsR8zbos/oFIpGV3OVnpUjP3pBH3MA?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4b39a146-401e-4432-82cc-08dbe4dcac95
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Nov 2023 06:41:04.6154
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Xs176j9JKz4t17OXkuwJ/oO7Jcyi+NUo9y/NIIJ1WnBIUl9+6vinsS7pUZCZesagIzWcUxHFUGp9DBfTYBWP1g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB8932

Move the variables 'TEST_NAME' and 'TEST_COUNT' into mptcp_lib.sh as
public variables.

Signed-off-by: Geliang Tang <geliang.tang@suse.com>
---
 tools/testing/selftests/net/mptcp/diag.sh          | 1 -
 tools/testing/selftests/net/mptcp/mptcp_connect.sh | 1 -
 tools/testing/selftests/net/mptcp/mptcp_join.sh    | 2 --
 tools/testing/selftests/net/mptcp/mptcp_lib.sh     | 3 +++
 tools/testing/selftests/net/mptcp/simult_flows.sh  | 1 -
 tools/testing/selftests/net/mptcp/userspace_pm.sh  | 2 --
 6 files changed, 3 insertions(+), 7 deletions(-)

diff --git a/tools/testing/selftests/net/mptcp/diag.sh b/tools/testing/selftests/net/mptcp/diag.sh
index 4279bb59939d..c7a7c0d2792c 100755
--- a/tools/testing/selftests/net/mptcp/diag.sh
+++ b/tools/testing/selftests/net/mptcp/diag.sh
@@ -5,7 +5,6 @@
 
 mptcp_lib_ns_init
 ksft_skip=4
-TEST_COUNT=0
 timeout_poll=100
 timeout_test=$((timeout_poll * 2 + 1))
 
diff --git a/tools/testing/selftests/net/mptcp/mptcp_connect.sh b/tools/testing/selftests/net/mptcp/mptcp_connect.sh
index 7442bb2a8562..54ad82ed8c91 100755
--- a/tools/testing/selftests/net/mptcp/mptcp_connect.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_connect.sh
@@ -123,7 +123,6 @@ done
 
 mptcp_lib_ns_init
 
-TEST_COUNT=0
 TEST_GROUP=""
 
 cleanup()
diff --git a/tools/testing/selftests/net/mptcp/mptcp_join.sh b/tools/testing/selftests/net/mptcp/mptcp_join.sh
index 52a4080b32d9..bf2f73209cdc 100755
--- a/tools/testing/selftests/net/mptcp/mptcp_join.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_join.sh
@@ -40,8 +40,6 @@ declare -A all_tests
 declare -a only_tests_ids
 declare -a only_tests_names
 declare -A failed_tests
-TEST_COUNT=0
-TEST_NAME=""
 nr_blank=6
 
 # These var are used only in some tests, make sure they are not already set
diff --git a/tools/testing/selftests/net/mptcp/mptcp_lib.sh b/tools/testing/selftests/net/mptcp/mptcp_lib.sh
index d1bd8aa02c2e..d645bfad1415 100644
--- a/tools/testing/selftests/net/mptcp/mptcp_lib.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_lib.sh
@@ -17,6 +17,9 @@ MPTCP_LIB_LISTENER_CLOSED=16  #MPTCP_EVENT_LISTENER_CLOSED
 readonly AF_INET=2
 readonly AF_INET6=10
 
+TEST_NAME=""
+TEST_COUNT=0
+
 MPTCP_LIB_SUBTESTS=()
 
 # only if supported (or forced) and not disabled, see no-color.org
diff --git a/tools/testing/selftests/net/mptcp/simult_flows.sh b/tools/testing/selftests/net/mptcp/simult_flows.sh
index a9e14698c179..e1f4ddf04bc3 100755
--- a/tools/testing/selftests/net/mptcp/simult_flows.sh
+++ b/tools/testing/selftests/net/mptcp/simult_flows.sh
@@ -8,7 +8,6 @@ capture=false
 ksft_skip=4
 timeout_poll=30
 timeout_test=$((timeout_poll * 2 + 1))
-TEST_COUNT=0
 bail=0
 slack=50
 
diff --git a/tools/testing/selftests/net/mptcp/userspace_pm.sh b/tools/testing/selftests/net/mptcp/userspace_pm.sh
index 9399dff81dd8..5620997b4e32 100755
--- a/tools/testing/selftests/net/mptcp/userspace_pm.sh
+++ b/tools/testing/selftests/net/mptcp/userspace_pm.sh
@@ -45,8 +45,6 @@ client_addr_id=${RANDOM:0:2}
 server_addr_id=${RANDOM:0:2}
 
 mptcp_lib_ns_init
-TEST_NAME=""
-TEST_COUNT=0
 
 _printf() {
 	stdbuf -o0 -e0 printf "${@}"
-- 
2.35.3

