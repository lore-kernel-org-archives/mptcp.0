Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2074.outbound.protection.outlook.com [40.107.22.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7025D51035
	for <mptcp@lists.linux.dev>; Wed, 22 Nov 2023 11:32:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="alq6aoFc"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TO1je12noptKxUsgzW9RX6Pf0Rer32IjsUxRWstSXqLAJSGrqwU94NKFoIzGjxX2+JLLFzigl9ZBDDZzO69lm2aMXpUKjtNV8pg12QdFDDNb/GuAWBQ6NFn3NbRaB868PqcaJRy6t4FSAwYLNj4SHCEnO8y/umckS6jyKDfRyLaBgyLAsC+gfL3hmJGomKgQ8R1HjlGAChjMAQ2MlwWuFz5hfWUUWWTH3LimRn/4oibUz8GPxJ1a51CLmFD0ZPJa/te1CHfzE2kec5/Z+4kJo/3bbUgB4wc39NzPQQ6059EhdzidZXS8LWTRup6XECxTvtn7PQH3rgqf9QmN2JOkTg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ofjNNgVIGGCWHBdYCWjEyrQLgmTpFS68/lop7DT0sYU=;
 b=OIX6xOxTmpWFGADjj0rcUuG9OtuKKQ5nsLqGTBhwPcJowSK3kuLC2kTOaBdLAIrsgAW7PZo+J7Q1CI14rWeHJPBTGEb2uGAzvWhPCN/H+clT1wcgcYz4m8ULJSNM6gkWaDtMZ0t1DYYG/tsRAX4SYOe8afS+zu/yfSlJXh/h22iDBeM3emiHZ+3QYoapF1x7+c5dpf2PiEWjUWDLTNybZEQaa3C2CSAGRQzEaUu97FRqJKKHvM8fHSdVeH1tythYcrxo5MTmxddMX1M6VS8cvFSjw6/u1+50K1825YsDRJgPndIdqyssClngYLemSFS/WmoErCN7qGeXPE6XSVE3fg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ofjNNgVIGGCWHBdYCWjEyrQLgmTpFS68/lop7DT0sYU=;
 b=alq6aoFcuhpOzEfCpwMnHna6kfD9tGWFQ0Af5zQ9nojBfDhFZIsraLzDH/8JXfUe4RFr8MVLEIc0mVH11lLL6Gs6QxwgOZu+3ElyC6dUtRVcrCV6pPddshkYWjuXBdYPIUCW7Zy4ZCKtEm6NGdL9wbbsZCFqrK+ka3DC1Qo5DPllzpac2VjNOdFripj9KGu4/BSCBQqRPE7Ix46wCl23TpwWZ9dR2QeamS74uPhN+H5o87/hhYTkbJTKIdQ95OTyfYjzG4h+DZtaibkIhLMSQ6ihI6WXzCSgFteKg8MyLmeeKBQnltPql705WiyXiKYvIsMP9NIaHxXSEdJarm326Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by VI1PR04MB10050.eurprd04.prod.outlook.com (2603:10a6:800:1db::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7025.17; Wed, 22 Nov
 2023 11:32:15 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::7102:259:f268:5321]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::7102:259:f268:5321%7]) with mapi id 15.20.7025.017; Wed, 22 Nov 2023
 11:32:15 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next v4 09/33] selftests: mptcp: add mptcp_lib_verify_listener_events
Date: Wed, 22 Nov 2023 19:30:57 +0800
Message-Id: <e4cd9961d5da772db5c0f1b81247860b2d650f41.1700652422.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <cover.1700652422.git.geliang.tang@suse.com>
References: <cover.1700652422.git.geliang.tang@suse.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SE2P216CA0023.KORP216.PROD.OUTLOOK.COM
 (2603:1096:101:114::12) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HE1PR0402MB3497:EE_|VI1PR04MB10050:EE_
X-MS-Office365-Filtering-Correlation-Id: a1244872-9561-47ad-a644-08dbeb4ead31
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	SOsm8sjX5hcwlVqe39WSYvc5Z7AN6lKj2d+dDG0tnpyb5wKWMjpmbbxEzlDdcp/ueDjjGQba4BvF0UW+qcq7Yk3VC3uj0GrdPzjuKju5t+HN31GsYS2SDTd1n11XKpWdDr1Sls3YrwgZEzH3B3zF8jUo646iR8InpkSiefSXf2Azebaf4fuaUEw4oSDAI+spwowwfo8mu6mQa91nPoro8T2ANIJCQeLBkOlVYhDrc6vmxuwqZOzgyxjQmJi/X3F9Q3RVu/sZ7h8K11YvLZcoXrUMWxnNYkWjeuRHOhFQ1+QNeJz4C3XTRItBbfWSyPgmjVqXDOZw6BbvsnLiqPhijHJawwPlGZqud5ytO1U1FnwHnH7KiezkLLMXyoi/PC/ZfmLz0xb1b7elFfuJ5/JUk2gpFVhiSd+qyuGClZ97QadM9g20H5aQTbbxtra0r50EuJVudubsLHVsLLnpCZC9HurwkO+wWfcwKz8K9n9aHp62vWBcMvLs29zhtJvtZNOn9Qg28fTvxqbqEBusSr/N9ULoSU7m+URKwJbZtb26tDd6jVK9hU82V9pngO04D7H9ZROIiSSc0s5MBh2o3Asu2NtBCUXb8jiXCKbuFS95vIm67ZnPBf0BycCDDziSNIjjdaGWA6EoSn3Y6llNfn4TfA==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(136003)(346002)(396003)(39860400002)(366004)(230922051799003)(1800799012)(186009)(64100799003)(451199024)(5660300002)(44832011)(2013699003)(2906002)(4326008)(8936002)(41300700001)(8676002)(66946007)(66476007)(316002)(6916009)(66556008)(86362001)(6486002)(107886003)(478600001)(26005)(6512007)(6666004)(36756003)(6506007)(2616005)(38100700002)(83380400001)(13296009);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?tCuEUmn8n8wAybY2PHeEIXPmTUYQJY9lnX4vxHyrTpEfyPBQ9Cxos052C2Gk?=
 =?us-ascii?Q?7vig14vz7RQ+V3UBWHX9lZ1n8XT0YqGkLl35uwWM0JrrilwPXPpIrrex6hfx?=
 =?us-ascii?Q?R65rDHaFGjNBnJHToSUNMGOtA5hU642XAkHZAHd6lyxRtg9Mvf/K9p+qoY/O?=
 =?us-ascii?Q?tCJPA6P2XM12R381VUAt5nJ20mDQUWM9xL1aofBKyouW5VUy8W+XHjrbBITN?=
 =?us-ascii?Q?kZLUUou8X3kHTE2aCT2saQC+OglYo6KwEy94X8VSa+QCvpXJJGsKGtu7qXtL?=
 =?us-ascii?Q?4OxBGJsrnigmbbMowARKMWM5GPVnJf9V+Tssm25Ru8gjZ7/x55YlH2F/vbxa?=
 =?us-ascii?Q?bWmecigIrSFvDU6N39yoF5JkEmfEtyU0qdOdM4pFURpC6koMT9Fq5aQJdxgE?=
 =?us-ascii?Q?lfSyqGBFyspFwmmgePwOGWvYAsen05i5jGCLP1LkGZE8fS5aeWlpFCnbArHG?=
 =?us-ascii?Q?cew0JDMImRL/lWNvoEjRAemjS0JZO+WnwP0wIR2h24VQ1g+LNli9ajR/p1UN?=
 =?us-ascii?Q?+OljweUTxYCvCLBJvDWJ6XzPftPax+4z5FdURsCpFmgHQxLAzzqE9ORwG0cS?=
 =?us-ascii?Q?ZQY005e6hkeDf+i2J3/28C3qmkzqp4guPNvuDFqrIiG24TxJ0dVLszazqfrx?=
 =?us-ascii?Q?XAVv81ueNK15CRvxYGTWolTlZE/MBPp3GE0duEwNCimOqDEUO2NurgHMIHV6?=
 =?us-ascii?Q?F5+ALaqFW7T73XaCB2HpurjagzFlqa1D7z8y0DwVv9jFGP0gN4LkhGCykteC?=
 =?us-ascii?Q?l7irpLUnrkn+MOWEJxVUlR20ghls2yMZ5Po9TIGymyf5AX0Kpy942l7FgOeb?=
 =?us-ascii?Q?7812dAIpnxtrrINSCumsL3uwTOlxK7X32QE92YykNQRSVU/jRNZyaSnYhKoF?=
 =?us-ascii?Q?TCJbdDwpnQra+2aiLTozUPLtp19UnOGWGIDEghEXpFzurHMUaqq7+svyi8fQ?=
 =?us-ascii?Q?fR+xoVD8xI4Y2pTX7qNQaKpyjTktRsxJBQobB70xegGFN2IHwQLaKysnAnSK?=
 =?us-ascii?Q?rt1Rk3GNSZ9xd438mWtElWqenut6tCIFaecN8sHcD0gu+Jjq4OrUIF6pbYJj?=
 =?us-ascii?Q?FIRh9wDw7Rtcx5iT6yXYiv671lRS7WIrzxS1A+v41ErovK1tV/r8C/ze3Knc?=
 =?us-ascii?Q?zLD8EQv3SsitUkl2JciE3j0LOUWctjBwgLhI/mNkexzuDbvNGkx1jE4QiNF9?=
 =?us-ascii?Q?b84pGcZ+aNdnJNlLjbten9jIN+qhzk8hxvRN0vq1tKHzspG+kcEF7v/ZA6Ej?=
 =?us-ascii?Q?JWssucpt+lug09k0FU9ecsW53Ae1BZqZgsoSf3MDxOfnPOG1eJoHMUSbBpKr?=
 =?us-ascii?Q?ckHBZ0TZ/rF7vM7cwNmvsUNi0n9xdlaqO8/OZ3a54soHKfFZ4UbLlhXq4bT+?=
 =?us-ascii?Q?Vcv9E1sf7YqazadB1dzIMMzdouo3v7sFhV4uOHSAW0iOF0Ge6XM5P1xO/JFj?=
 =?us-ascii?Q?Y3amDbgX8uJLR+0UONie8jJD1pwmOoVk7qrOJ5SvDRqx0ugm2cTPPMqFoKaF?=
 =?us-ascii?Q?76aPBqoy/5FedXcF3csF8BZdsflOfQ7v+WBWdIKL8s+uceQizxfQYn/4JQ/F?=
 =?us-ascii?Q?zMn/1jBUnenSvKGz6T/g4NxYtZ+PeNRTN3vR26L/vvzi1otaFs7IXOxHCD84?=
 =?us-ascii?Q?jw=3D=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a1244872-9561-47ad-a644-08dbeb4ead31
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Nov 2023 11:32:15.2420
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +HtxqAbjPONvjaJwR/jym2XZSuD8VvZ39A+Q+Eys11uAWNg6orgj2jBqvkSU0+rONZRbUle3LY/aach4dxxEyw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB10050

To avoid duplicated code in different MPTCP selftests, we can add and use
helpers defined in mptcp_lib.sh.

The helper verify_listener_events() is defined both in mptcp_join.sh and
userspace_pm.sh, export it into mptcp_lib.sh and rename it with mptcp_lib_
prefix. Use this new helper in both scripts.

Signed-off-by: Geliang Tang <geliang.tang@suse.com>
---
 .../testing/selftests/net/mptcp/mptcp_join.sh | 24 ++-------------
 .../testing/selftests/net/mptcp/mptcp_lib.sh  | 23 ++++++++++++++
 .../selftests/net/mptcp/userspace_pm.sh       | 30 ++++---------------
 3 files changed, 31 insertions(+), 46 deletions(-)

diff --git a/tools/testing/selftests/net/mptcp/mptcp_join.sh b/tools/testing/selftests/net/mptcp/mptcp_join.sh
index 79bc894a5aba..69bc8d16fc14 100755
--- a/tools/testing/selftests/net/mptcp/mptcp_join.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_join.sh
@@ -2780,15 +2780,10 @@ backup_tests()
 
 verify_listener_events()
 {
-	local evt=$1
 	local e_type=$2
 	local e_family=$3
 	local e_saddr=$4
 	local e_sport=$5
-	local type
-	local family
-	local saddr
-	local sport
 	local name
 
 	if [ $e_type = $MPTCP_LIB_LISTENER_CREATED ]; then
@@ -2806,23 +2801,8 @@ verify_listener_events()
 		return
 	fi
 
-	type=$(mptcp_lib_evts_get_info type "$evt" "$e_type")
-	family=$(mptcp_lib_evts_get_info family "$evt" "$e_type")
-	sport=$(mptcp_lib_evts_get_info sport "$evt" "$e_type")
-	if [ $family ] && [ $family = $AF_INET6 ]; then
-		saddr=$(mptcp_lib_evts_get_info saddr6 "$evt" "$e_type")
-	else
-		saddr=$(mptcp_lib_evts_get_info saddr4 "$evt" "$e_type")
-	fi
-
-	if [ $type ] && [ $type = $e_type ] &&
-	   [ $family ] && [ $family = $e_family ] &&
-	   [ $saddr ] && [ $saddr = $e_saddr ] &&
-	   [ $sport ] && [ $sport = $e_sport ]; then
-		print_ok
-		return 0
-	fi
-	fail_test "$e_type:$type $e_family:$family $e_saddr:$saddr $e_sport:$sport"
+	mptcp_lib_verify_listener_events ${*}
+	[ $? -eq 1 ] && fail_test "$e_type $e_family $e_saddr $e_sport"
 }
 
 add_addr_ports_tests()
diff --git a/tools/testing/selftests/net/mptcp/mptcp_lib.sh b/tools/testing/selftests/net/mptcp/mptcp_lib.sh
index f711cc0d0271..20c260aa68dd 100644
--- a/tools/testing/selftests/net/mptcp/mptcp_lib.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_lib.sh
@@ -443,6 +443,29 @@ mptcp_lib_check_expected()
 	return 1
 }
 
+mptcp_lib_verify_listener_events() {
+	local evt=$1
+	local e_type=$2
+	local e_family=$3
+	local e_saddr=$4
+	local e_sport=$5
+	local type
+	local family
+	local saddr
+	local sport
+
+	type=$(mptcp_lib_evts_get_info type "$evt" "$e_type")
+	family=$(mptcp_lib_evts_get_info family "$evt" "$e_type")
+	if [ $family ] && [ $family = $AF_INET6 ]; then
+		saddr=$(mptcp_lib_evts_get_info saddr6 "$evt" "$e_type")
+	else
+		saddr=$(mptcp_lib_evts_get_info saddr4 "$evt" "$e_type")
+	fi
+	sport=$(mptcp_lib_evts_get_info sport "$evt" "$e_type")
+
+	mptcp_lib_check_expected "type" "family" "saddr" "sport"
+}
+
 mptcp_lib_cleanup()
 {
 	echo "cleanup"
diff --git a/tools/testing/selftests/net/mptcp/userspace_pm.sh b/tools/testing/selftests/net/mptcp/userspace_pm.sh
index 9b1d8b56d8d6..e78a79da3960 100755
--- a/tools/testing/selftests/net/mptcp/userspace_pm.sh
+++ b/tools/testing/selftests/net/mptcp/userspace_pm.sh
@@ -839,32 +839,12 @@ test_prio()
 
 verify_listener_events()
 {
-	local evt=$1
-	local e_type=$2
-	local e_family=$3
-	local e_saddr=$4
-	local e_sport=$5
-	local type
-	local family
-	local saddr
-	local sport
-
-	if [ $e_type = $LISTENER_CREATED ]; then
-		print_test "CREATE_LISTENER $e_saddr:$e_sport"
-	elif [ $e_type = $LISTENER_CLOSED ]; then
-		print_test "CLOSE_LISTENER $e_saddr:$e_sport"
-	fi
-
-	type=$(mptcp_lib_evts_get_info type $evt $e_type)
-	family=$(mptcp_lib_evts_get_info family $evt $e_type)
-	sport=$(mptcp_lib_evts_get_info sport $evt $e_type)
-	if [ $family ] && [ $family = $AF_INET6 ]; then
-		saddr=$(mptcp_lib_evts_get_info saddr6 $evt $e_type)
+	mptcp_lib_verify_listener_events ${*}
+	if [ $? -eq 0 ]; then
+		mptcp_lib_result_pass "${TEST_NAME}"
 	else
-		saddr=$(mptcp_lib_evts_get_info saddr4 $evt $e_type)
+		test_fail
 	fi
-
-	check_expected "type" "family" "saddr" "sport"
 }
 
 test_listener()
@@ -880,6 +860,7 @@ test_listener()
 	# Capture events on the network namespace running the client
 	:>$client_evts
 
+	print_test "Listener event LISTENER_CREATED 10.0.2.2:$client4_port"
 	# Attempt to add a listener at 10.0.2.2:<subflow-port>
 	ip netns exec $ns2 ./pm_nl_ctl listen 10.0.2.2\
 		$client4_port &
@@ -899,6 +880,7 @@ test_listener()
 		rport $client4_port token $server4_token
 	sleep 0.5
 
+	print_test "Listener event LISTENER_CLOSED 10.0.2.2:$client4_port"
 	# Delete the listener from the client ns, if one was created
 	mptcp_lib_kill_wait $listener_pid
 
-- 
2.35.3

