Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2045.outbound.protection.outlook.com [40.107.21.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75CFF199B1
	for <mptcp@lists.linux.dev>; Wed,  8 Nov 2023 14:13:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="DGHbvOhl"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=htCm78jGTAWkeq7G7NTR/0755v/6oeYBElG4iHXk5DrKZoQnVLtIEgVcnPRYfGvxcVf2hcdk9eih61B55TIR3CuqY35nBRgQbTDqyTe/TDdOdga2jrlJRw+xUsTG8WA4J4gAsBqq8fJlVY8jLQM/LS2LnTS1ukw4C6AacXlcBkYGtjzxLOeCA2Rzh0PIU/29tn/vLBuWt/2K3elU6rH3wwvTCntlcuQiQ3J/VHwro7/2uroJXdzCd9x23qfzxPSXchQOoovbs6JYUegu0wioZgHBaKSzvI5xJjLto3VLSzaUVL25HB/rDHIQC2ZMbKe/3TDQf5QMdmsyuAJkdHeB/w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZTQT+L5Fka8DjEHUuapA0LSN3x6d6tZJcQj7UP8IGH0=;
 b=B59CkiRVUH2HtDTXFtdWpbGQAnePWmOpZrN6+C6Ff/plC/pRFsNgqjGwzsiHsWqusnrR2FUS87ZvQF2g6xe7aGpc889sbxkOuMIpvjKP5yF3sHQ8w/sTg8R9kv3gOegUCtd2NGMmBSUdZiiDzDKTjdlygpSpHvbtESEMpnWYAXUi4LZSzNeCP3f0IK2VvCUiBIZLjzZOiy3vNIB2iItQEWKV/FjRQmmd8MVhKHthM5za8KWlf9Pi3vTJj94Z71xDEFPB6WT9GBuf9m6vEEg1Nd+QPhvm0tWKXBL+NmcgWgbcs68EMUKO1wwrMqKDUuGmcfAQv3geZIgOIhYNBLWGZA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZTQT+L5Fka8DjEHUuapA0LSN3x6d6tZJcQj7UP8IGH0=;
 b=DGHbvOhlWGDhcu9741nQHjTTRI5JkIBIGs88iPXq2zkoV+nWqzxoixoZuSgxp6YtPS8+t9hR04cfKCkf0H2T5FS7sSsRK6K+CPfL+4cEdKNT5XESk5e/RAvzDZ4V2RHtj5vsgY6qS0NA2y0Ep1SGdpJlmdQlhYlbq3wNi7lk6D+y68UkNZu5vFcNiAWyVUFhXjXbXVaSg8Up7JDu6FYFYi5wuF/BS0J1Uy3kGxGSKQe0tvxItp7dCPWJWj7K54zkXXGWFKawUWjC4sqUDfX+nhujcq0HbtX0UQD3m/mer+xq/0RWzOkV4Z0QCO2YOISdrdXO0Rgntdqqc1szXj28YQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by VI1PR04MB10050.eurprd04.prod.outlook.com (2603:10a6:800:1db::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6954.19; Wed, 8 Nov
 2023 14:13:27 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::7102:259:f268:5321]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::7102:259:f268:5321%6]) with mapi id 15.20.6977.011; Wed, 8 Nov 2023
 14:13:27 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next 12/13] selftests: mptcp: export more vars into mptcp_lib
Date: Wed,  8 Nov 2023 22:11:53 +0800
Message-Id: <7f579f7b04d9433dfdab7dc568a014cc5f0f905f.1699452144.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <cover.1699452144.git.geliang.tang@suse.com>
References: <cover.1699452144.git.geliang.tang@suse.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TYCP286CA0176.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:3c6::8) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HE1PR0402MB3497:EE_|VI1PR04MB10050:EE_
X-MS-Office365-Filtering-Correlation-Id: 3f31fd57-610f-46bb-dd43-08dbe064e08d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	0p20aZaXq1rCnTougLJ/06M/aQYz/1zcuaMTvUqSfQQoK3nUG0wJxtgBtWB7P6J7BNU8/9LyZMmPCFQJ82n4Xyj8pI6ozQCPcCnS237tUGFh0N/AJB0mzNTKViuTDgx5mUCyMrVRL/1nClnMwCK6baMGc1hYEMsWbfIq/iQivl4xQxO1Pkj5p1CarY/ydbW88e91+DpxW97aWlsevNF9swTVCLNaWaSrTljDpl/d9BHufUWBL6zfGivPMkR8olrfQrXmyJuNvpm0ZyynsTfa4QWNhuWaw29ijcLorxosy7q4BOocSjfnlKg61xUbdfHYCkwXtWz0jXRcCdsf+fvEPWiuJRhvnTtc9dGdA3ruJ4k/hfiHvrONffkHDlwusiloTepB2hkf7W9Jnfmc4B+JCvGmteuIBKRdDWsT7cexyepweTOAzIC3h0+tGDCdav0bvrUou/gx9FUYufN3oUSBrJmDuqkNgQjz3TUcC5nlQ/HBRJp+sJMRl6OF6xI9hX1vfT99ljIa1iTEveKRHO/TcOe1gTQEeP3X+A5m472Am0b/Q68x6Q3FJWPDwlyCc5N7
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(39850400004)(346002)(366004)(396003)(376002)(230922051799003)(186009)(1800799009)(64100799003)(451199024)(26005)(478600001)(6512007)(107886003)(6666004)(6506007)(83380400001)(4326008)(44832011)(5660300002)(66476007)(66556008)(41300700001)(6916009)(8936002)(8676002)(6486002)(316002)(66946007)(2616005)(38100700002)(2906002)(36756003)(86362001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?8YStbDOF6r5fr5MrmcfygZxiJqZlrzZAIr+w3kVMs2O9G93vqjcLxl3rN7ph?=
 =?us-ascii?Q?W64YGKMcCrJbUpGcsG3SL/zEE8Xp29bGyYQwg8kOkcU+Ao9/lZPXhWhkEbfU?=
 =?us-ascii?Q?hYYn2gurDGTK99Klr5N1Ee5X8xLPzYKlFdCTyv3IhZt8CJfl3V3eU7NIa3Us?=
 =?us-ascii?Q?/RLaqIwXOE3CmwAJu7V4GIQhvTs9PswRW69wk5TPZSlA4lIxLCzJb1zSmJAk?=
 =?us-ascii?Q?LmwAXdVj+oBs3OBSkOaTVyE4ZsqGZ4V3/rizCd4u2PbDY1YEjybFmqcu/SXn?=
 =?us-ascii?Q?5tgr155z09AU1hJhswhdAZw9/Cnt7E2zcmneSdUvv7/rgdf5RwPcHPRwUtnr?=
 =?us-ascii?Q?RtftU393M2JNn68+q1PiRhPv1YoaJUNMAm72cRg6GU1GwFQftq6FqtVH7Nzq?=
 =?us-ascii?Q?DKQXH+d6vN5VJous0L3VMhvzVq+n5LHoA/u11XgNMUpoMXe53CnReNjGh5w7?=
 =?us-ascii?Q?zVt6Fn7GJnKod8UJebktx8tvRmBpRYhsiEUWmleAWrv6FTSwA1OyBp/11SHX?=
 =?us-ascii?Q?al9yUiXITLpImNWoXmmlml8Lipz6KqtRhIGvtSKfapd64khvOOuQkkXt5938?=
 =?us-ascii?Q?Jq9D2i+HrYvfOXz/0QPFgVI8GEQzxPy8jtQ5zG+S19J6kDP9SJ1gkZDRy+YK?=
 =?us-ascii?Q?6LhbSM0caDc8SAhbLFW+J7y1qFLllErnueMIeYP6G7NwymtFEoSbbqziBVEL?=
 =?us-ascii?Q?BUADK0DK2h7zk6QrIwELL6XNlOnueS4cDEohvkW8EIm+w2mZGwTKtqrh9vl1?=
 =?us-ascii?Q?rWTjfhxmbv6xGc09xd7pmYNN1PeimCyl+1YK7L9p3m/pgz53EjakAjBPnNms?=
 =?us-ascii?Q?87iS9IbFlui/uLi26DOhEDc0V9fQvGmVpociwLnm8OYTho0Gxjg8v/xw1w+A?=
 =?us-ascii?Q?YwXo4JApbHgKSt9pYZcHib+HpztKzwpgdpoTkMfduW/sWKErzxobRUflGlsd?=
 =?us-ascii?Q?HuTbJCd/CxuJcLOW+cXWEqYCR1NaxE5mijMRe5rpwyGUeRxEDSQhQiy+YPb/?=
 =?us-ascii?Q?uxC+feTgdCsawafXkvjO+bO7/1O1ov8Q3HGy7SN1ILoaZ3fAj+nOhrNIYBLl?=
 =?us-ascii?Q?FXxrrdLOQ/1RjRNzbij/kiHIQimuTxfosN7NXYlmkGKX5aNF93qoutSrXh7v?=
 =?us-ascii?Q?qhCWtg4NJ779IcHuy3xvrsNZ+ibbfq0jQeNgfHPFxVP1mx/inKUkjDuXymoS?=
 =?us-ascii?Q?ECjyHVP/p4VCOeL9ID9rigF5OaJnE10K5rhVZDXxhWMTLRtq+46djHR1gcBW?=
 =?us-ascii?Q?o/qV3dCBRB8tovtZOuMzLtLk/oY4MWkomEWAawHM8vg1q+N6bdy5cBZPlbjh?=
 =?us-ascii?Q?T4VPHcwXfwSVly9mdyDkzQYv8LTgMTHA0niFGgTZ8H0PDzoaWd+Y6LVbiuiK?=
 =?us-ascii?Q?yWM2as88sWmuLF9L70yfQReoOM3K7sN/7aR6YwUfHeWiLq8KSEEWcVYWjc01?=
 =?us-ascii?Q?WvTLlkRNAx3kpoy9bxKalaZPyh/015imy9zfjhC6OVd5COTUOclNzvYUkLsk?=
 =?us-ascii?Q?J2UAFr/4rspBHC0cSpYwj4sOSQnoGU8kjWs9IaAmNFJYWCdV67ALKKmRusYp?=
 =?us-ascii?Q?r4TokQnEe8+ZGwzC9k6Mp2J9Wsi7cLisG6Ey3qO/?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3f31fd57-610f-46bb-dd43-08dbe064e08d
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Nov 2023 14:13:27.6268
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: DxikA/cdQP7G1Z4Oq5ORUPBh3uTiNbXh+UfUf/mvzRSDzbJaA2IMgtyRzTn0042VRjN1CVf1qjbA5Pb7NGhLxA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB10050

Move the variables 'TEST_NAME' and 'TEST_COUNT', 'ret', 'capture' and
'checksum', 'timeout_poll' and 'timeout_test', 'iptables' and 'ip6tables'
into mptcp_lib.sh as public variables.

Signed-off-by: Geliang Tang <geliang.tang@suse.com>
---
 tools/testing/selftests/net/mptcp/diag.sh          |  4 ----
 tools/testing/selftests/net/mptcp/mptcp_connect.sh |  6 ------
 tools/testing/selftests/net/mptcp/mptcp_join.sh    |  9 ---------
 tools/testing/selftests/net/mptcp/mptcp_lib.sh     | 14 ++++++++++++++
 tools/testing/selftests/net/mptcp/mptcp_sockopt.sh |  5 -----
 tools/testing/selftests/net/mptcp/pm_netlink.sh    |  1 -
 tools/testing/selftests/net/mptcp/simult_flows.sh  |  5 -----
 tools/testing/selftests/net/mptcp/userspace_pm.sh  |  3 ---
 8 files changed, 14 insertions(+), 33 deletions(-)

diff --git a/tools/testing/selftests/net/mptcp/diag.sh b/tools/testing/selftests/net/mptcp/diag.sh
index e28dce8f6f94..6c5f84f59898 100755
--- a/tools/testing/selftests/net/mptcp/diag.sh
+++ b/tools/testing/selftests/net/mptcp/diag.sh
@@ -5,10 +5,6 @@
 
 mptcp_lib_init_ns
 ksft_skip=4
-TEST_COUNT=0
-timeout_poll=30
-timeout_test=$((timeout_poll * 2 + 1))
-ret=0
 
 flush_pids()
 {
diff --git a/tools/testing/selftests/net/mptcp/mptcp_connect.sh b/tools/testing/selftests/net/mptcp/mptcp_connect.sh
index da932176c85d..a926493a349e 100755
--- a/tools/testing/selftests/net/mptcp/mptcp_connect.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_connect.sh
@@ -6,13 +6,9 @@
 time_start=$(date +%s)
 
 optstring="S:R:d:e:l:r:h4cm:f:tC"
-ret=0
 final_ret=0
 cin_disconnect=""
 ksft_skip=4
-capture=false
-timeout_poll=30
-timeout_test=$((timeout_poll * 2 + 1))
 ipv6=true
 ethtool_random_on=true
 tc_delay="$((RANDOM%50))"
@@ -22,7 +18,6 @@ sndbuf=0
 rcvbuf=0
 options_log=true
 do_tcp=0
-checksum=false
 filesize=0
 connect_per_transfer=1
 
@@ -119,7 +114,6 @@ done
 
 mptcp_lib_init_ns
 
-TEST_COUNT=0
 TEST_GROUP=""
 
 cleanup()
diff --git a/tools/testing/selftests/net/mptcp/mptcp_join.sh b/tools/testing/selftests/net/mptcp/mptcp_join.sh
index 4aac1bce8aec..f11d47354937 100755
--- a/tools/testing/selftests/net/mptcp/mptcp_join.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_join.sh
@@ -12,19 +12,12 @@
 
 . "$(dirname "${0}")/mptcp_lib.sh"
 
-ret=0
 sinfail=""
 cinfail=""
 cinsent=""
 tmpfile=""
 capout=""
 ksft_skip=4
-iptables="iptables"
-ip6tables="ip6tables"
-timeout_poll=30
-timeout_test=$((timeout_poll * 2 + 1))
-capture=false
-checksum=false
 ip_mptcp=0
 check_invert=0
 validate_checksum=false
@@ -37,8 +30,6 @@ declare -A all_tests
 declare -a only_tests_ids
 declare -a only_tests_names
 declare -A failed_tests
-TEST_COUNT=0
-TEST_NAME=""
 nr_blank=6
 
 # These var are used only in some tests, make sure they are not already set
diff --git a/tools/testing/selftests/net/mptcp/mptcp_lib.sh b/tools/testing/selftests/net/mptcp/mptcp_lib.sh
index 53e69fc807a6..ae394d5e1735 100644
--- a/tools/testing/selftests/net/mptcp/mptcp_lib.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_lib.sh
@@ -17,6 +17,20 @@ readonly AF_INET6=10
 
 MPTCP_LIB_SUBTESTS=()
 
+TEST_NAME=""
+TEST_COUNT=0
+
+ret=0
+
+capture=false
+checksum=false
+
+readonly timeout_poll=30
+timeout_test=$((timeout_poll * 2 + 1))
+
+iptables="iptables"
+ip6tables="ip6tables"
+
 sin=$(mktemp)
 sout=$(mktemp)
 cin=$(mktemp)
diff --git a/tools/testing/selftests/net/mptcp/mptcp_sockopt.sh b/tools/testing/selftests/net/mptcp/mptcp_sockopt.sh
index 780ceb9314b9..019d4dc91d70 100755
--- a/tools/testing/selftests/net/mptcp/mptcp_sockopt.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_sockopt.sh
@@ -3,12 +3,7 @@
 
 . "$(dirname "${0}")/mptcp_lib.sh"
 
-ret=0
 ksft_skip=4
-timeout_poll=30
-timeout_test=$((timeout_poll * 2 + 1))
-iptables="iptables"
-ip6tables="ip6tables"
 
 mptcp_lib_init_ns
 
diff --git a/tools/testing/selftests/net/mptcp/pm_netlink.sh b/tools/testing/selftests/net/mptcp/pm_netlink.sh
index 0b6e56be1207..208669f474cf 100755
--- a/tools/testing/selftests/net/mptcp/pm_netlink.sh
+++ b/tools/testing/selftests/net/mptcp/pm_netlink.sh
@@ -4,7 +4,6 @@
 . "$(dirname "${0}")/mptcp_lib.sh"
 
 ksft_skip=4
-ret=0
 
 usage() {
 	echo "Usage: $0 [ -h ]"
diff --git a/tools/testing/selftests/net/mptcp/simult_flows.sh b/tools/testing/selftests/net/mptcp/simult_flows.sh
index 0a06b7f41650..ad589c7699a1 100755
--- a/tools/testing/selftests/net/mptcp/simult_flows.sh
+++ b/tools/testing/selftests/net/mptcp/simult_flows.sh
@@ -4,12 +4,7 @@
 . "$(dirname "${0}")/mptcp_lib.sh"
 
 mptcp_lib_init_ns
-capture=false
 ksft_skip=4
-timeout_poll=30
-timeout_test=$((timeout_poll * 2 + 1))
-TEST_COUNT=0
-ret=0
 bail=0
 slack=50
 
diff --git a/tools/testing/selftests/net/mptcp/userspace_pm.sh b/tools/testing/selftests/net/mptcp/userspace_pm.sh
index 263a3ac9a3ee..021d570df234 100755
--- a/tools/testing/selftests/net/mptcp/userspace_pm.sh
+++ b/tools/testing/selftests/net/mptcp/userspace_pm.sh
@@ -45,9 +45,6 @@ client_addr_id=${RANDOM:0:2}
 server_addr_id=${RANDOM:0:2}
 
 mptcp_lib_init_ns
-ret=0
-TEST_NAME=""
-TEST_COUNT=0
 
 _printf() {
 	stdbuf -o0 -e0 printf "${@}"
-- 
2.35.3

