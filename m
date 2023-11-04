Received: from EUR04-DB3-obe.outbound.protection.outlook.com (mail-db3eur04on2089.outbound.protection.outlook.com [40.107.6.89])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1977196
	for <mptcp@lists.linux.dev>; Sat,  4 Nov 2023 00:28:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="e/xkVp9h"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UUTYwsHCKvSVrxgaPeal8eNgdfRfubA96Apr3jlzmGl+vqCVuKy9RtlLS/JZibKmSpl7WbXjW3ED9qXJVDXaoqbXERbEzpWX8ZAVIhb4fOC6vJPRR/r5Bw3OZLdkIkd85S4pLLHDlk03tbtZwkKSLZl3uSpBGQmNiLqcljZrlQRV9RUORjzHXmaqXjSJ0jkTDtWnSw93GlsHuyTOKY+qvk2JfNulPjGUpBX4Y7vME5fHSdS0n4W/SnSR+asosJAc//alBs0fnVzPd20mLDC7IHnIrAP+yGZn384N5QpuokAB9mvkFPTeQzW9tjs0SLiacK/ArR2Rkxg7T2c5SnLqBw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zG7fLxzRvLjnijpB1RmcMtsWYu9otoQkCaKaW/grsiQ=;
 b=J8JWH3zdQJtsJlC69BMD/LHCJ3OQM+UhCBKAVDoqQ9PRh+znjGj6jJf6cfLVngQhk0ujQhC6MTM4grR44HfIeFRFPP3HK82Gr6qze8j3znS9t9XwhhCBUmGFJTuQJM2uSZh93QHuQLNr9yrA9cV02aTBPnmjN2sHtik5MDheT3GT0TARNXJ2B0S4SCxxgHZdRp/XSHTxXAWoanFcIZRHKPanHhBYoeIVcgbnkf8VHWwBCOcSAjPOEKELzFOHWa3w1Lu9daAsyifXfCmwPoaz8sYC81J4K2yP1F0khARTQI04VBQvW6X+lnSTU9Z2r0UwsUsCX+3SLvxTHmvIs8Qgxw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zG7fLxzRvLjnijpB1RmcMtsWYu9otoQkCaKaW/grsiQ=;
 b=e/xkVp9hab1gpXMj6/hcL/LuZaLkYBFDVATsNq04ug4Nw/607esW1a2HqwEf0LLvxc4WToH6LVxUTDph4tQQndz5toqbaICuS1cy7ixS69zZLz4b9wUfaxGVradEbKqOzZ5Z1WWEj1EEC/uTCm4TnOtFt3P09YWYsXLJTADttSjIDtczLsQ2Qeei0mZ/p+0IApGCqXZtBPTYnEzImZxbxWgpaBLTP0LEgYmEn8d9l9nDS9zFqiHZ8skMDXo/7hGy/eG5fR1xHjvHz2TzKX+FzavS3dBNBjwWsgv0hrvo0QA7YB3lSGsZzEX9JjVHfxapcm9Mgriw2tcH7MLCE0ZONw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by VI1PR04MB6989.eurprd04.prod.outlook.com (2603:10a6:803:131::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6977.10; Sat, 4 Nov
 2023 00:28:35 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::7102:259:f268:5321]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::7102:259:f268:5321%6]) with mapi id 15.20.6977.011; Sat, 4 Nov 2023
 00:28:34 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next v3 05/10] selftests: mptcp: add mptcp_lib_verify_listener_events
Date: Sat,  4 Nov 2023 08:26:29 +0800
Message-Id: <74080f313fc34dbffc83fe5d01a44c42ba9b8a60.1699057401.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <cover.1699057400.git.geliang.tang@suse.com>
References: <cover.1699057400.git.geliang.tang@suse.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR02CA0013.apcprd02.prod.outlook.com
 (2603:1096:3:17::25) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HE1PR0402MB3497:EE_|VI1PR04MB6989:EE_
X-MS-Office365-Filtering-Correlation-Id: 3f6bfef0-6ba3-4e92-3b5f-08dbdcccfb0c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	IcrmCmNyACBx5E8UUB6iH4/Cz5iSpwsopZayIwXwliacK1PtUbfbbHB0BICAbvthuzxKcusUd9X+fcH+h4tBWGMxqa4PH68Aw8I9nfg+uWNvCZ7GgXpClxGrJk6Y3fieO6r3/FTm5iceabAjlfrnAp/q3+ZUjEznH416VfkR6bj+jmPfQmQKWvvV1I1n9Q9pV+Cl1fsZyCxMzD0ca0Rqfbq+APBH7jjemCBzP/9G2aiyNNDRXJEL61pTe/tM+yAUzS/XZEvq0GCQXwoyg1yHx+Y7ghGUL3QokwG01SMyX6lu1EB38TJ+o/vo9wGwWTTtV6iPtus5K0lVf3fkm1BcrGWUg+98sMhpiWDdFT3BcrQnRcA+4JrD+rd+gVZTaZAehlD1Ap7qGxxZGuD2aV7B7lkTs+mB11aAcBo94jlPEHBhjLGfpkXPiuZGhPb3gLt2O3MTbvl8MiSqtPYXlib51jGOsn/xPA8kxJzhdIG2bqMUlFyXpWcI1hcmJKujD2FGggutFzT/ZPZy5azBHOAZw5S11QSmd2gCWvING4Fx4keqyQdlKC6YeJDsrsIZykczc1Xyr0tuRg8DTSVeXabWR6fn/mZQRJcEbAtaASq5D+UfxVTm7Jhu/SWKxtASd3hPculi6umm9hAdtNtRC2ic/w==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(396003)(376002)(366004)(346002)(136003)(230922051799003)(451199024)(64100799003)(1800799009)(186009)(6486002)(5660300002)(66476007)(66556008)(6916009)(8676002)(316002)(4326008)(2906002)(8936002)(66946007)(6666004)(478600001)(44832011)(6512007)(107886003)(41300700001)(26005)(2616005)(6506007)(83380400001)(2013699003)(36756003)(86362001)(38100700002)(13296009);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?1zhCY7gSD9bR6sv62e7J1H9goYILsxczdR8gcE7y5aBlzVkAjQwha0vSeu2C?=
 =?us-ascii?Q?nwYQ05XNDK6/CQy8QXA1h+5/xUHxUmCkSBVU3vgxtPMc1QIgky/W+YgL3Y2u?=
 =?us-ascii?Q?cPfKIZJ89nFVb7hxynDRCeaquNFBkC4mMGyG/bR/gfnjcaoUxuH90FSpcoS7?=
 =?us-ascii?Q?A3/oU5YERNvFVf2+zfy/ueD7yKsfnxj33/z87v47ecyQ5pRu5Wri5K9B4Gss?=
 =?us-ascii?Q?Oe++IRw3Imt4JsY+CYWeGN2dp9WoOhljGBT7M6LAWn2x8RaIcLUFWyn7VXn1?=
 =?us-ascii?Q?mTf7BpfFk9UQBGRraKZE/ZhLULTL1/chqV18TR+0jEUug8Rt5uKhKM9dKV0r?=
 =?us-ascii?Q?vpz5h5RXtKzNyBN1Z5Z2CBNp/yl8Hjm668/s7ZU3lPA5LpVIDnPtj9pXzgy7?=
 =?us-ascii?Q?DG2iOgB9/V5wZMUjWLJdlgp0Gj1J7/BIsALeNckPITdPYUCmEudXwEoDezlV?=
 =?us-ascii?Q?+g1cZ3UUEWAmz26Ahi6wTTYLuBiLEwmMEd4pmKT9qr53gIC8USKKAGoHAYw0?=
 =?us-ascii?Q?qEGpuNRbH0+B4rHh6YhoJxN5S9k0DKkJHJaUxqHZcLfX0SpiVOBHtA0nWWzJ?=
 =?us-ascii?Q?fCk5KRkLU9WGqGQmcCDotex5Sb7QCKW8KbASReMXx7buNgpDNo1YLyvM6wZ6?=
 =?us-ascii?Q?1noKoh0uo0Rs1fuirvnhLldH/Ra+xjAk2WuxT7LcLBGXjfKmUzvh5xvSGgry?=
 =?us-ascii?Q?aalRoVwiTa4Gi+HpgWCOdOajji0gsIM4maC+sbBFP35ccXv0kzp2eLRq432o?=
 =?us-ascii?Q?JObq8ePWBnBmYeJ6Eprf8SqMcX2kVu0DNHekNj4PT/O1D+ZzAXKwrW+cT/wr?=
 =?us-ascii?Q?6tMBRX79mZJbSBfyRiFQhppITPaqt1IZ1VBHvLNTOvTmeynex0175AVLb6HX?=
 =?us-ascii?Q?s6/3ozu5B765qx8Xut/ctLsbiZGk4xIbsNRNuxdkqnO6mK1CfKZ+tlQ9HG70?=
 =?us-ascii?Q?GyRLJgjsfPPLYPDtTxIj4fjD2jR3OAKpQvCROweBZPpjhje12FRjM0GVyaEJ?=
 =?us-ascii?Q?iABz6uwt6JgrwZJasFsdPR1HbaN8aZMngCzuBID5j38WdPWd4YXVlaoLrRib?=
 =?us-ascii?Q?cjEKx+qZ5s0wYYyUjz1P0bh4kXuHfZj2F2hpM8hie5m1HcfvFBEBV4Pzd6ZE?=
 =?us-ascii?Q?OJb5qTaVNpvHLZ7I1hW1gUcjZF26TbATPlOSwKaDOjINwPYBtdMJWj1MLdeU?=
 =?us-ascii?Q?Ykdpv9tm/7f65lsspTXrx39AzK2+jEZ26RhmRA58FLJT90nEKfktsLL7B3s4?=
 =?us-ascii?Q?+92nR1iARksu4mCzB4vUO0c3/N4cihtLX4jHUZPttDpj5oE6nOcOISiDPBRx?=
 =?us-ascii?Q?LIhVj9OdlPUl3fgTl7SNWltgSyeINxoiiOiISW+LliJoRNuBMAJpPmxvRrF1?=
 =?us-ascii?Q?3uYRIaeAjP/B+jTCceeLxw0KYPNBo/Bn6ic/ZYSlqdeT59DWQKWPxVMlgf7R?=
 =?us-ascii?Q?VTT6kTGHDj8pvgWw9JZqj9RaTvyriKQbJeXbP/Ac4d2eJogz+hzoUdlD01qO?=
 =?us-ascii?Q?4aoKWibWpxBd/ZNz1MtdAZ70wP4HQ8ZQ1Dba3mifZWA5YBgDlv0FpzJ1q9JX?=
 =?us-ascii?Q?Pk3KnWorXZgWPhLXtPeSy6Q3e4gqiUBNb5fUoD1C9NRtjfuXhtLeDrDU2sGv?=
 =?us-ascii?Q?rA=3D=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3f6bfef0-6ba3-4e92-3b5f-08dbdcccfb0c
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Nov 2023 00:28:34.9359
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: pCkS1xj+5h1MlXYiPHiP2dIvPn/tW3OLXZkqsCMGgxNHj9glmqpTz9hoZqHQNTFZptRDtKnE2nUJtriJeteF9g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB6989

To avoid duplicated code in different MPTCP selftests, we can add
and use helpers defined in mptcp_lib.sh.

verify_listener_events() helper is defined both in mptcp_join.sh and
userspace_pm.sh, export it into mptcp_lib.sh and rename it with
mptcp_lib_ prefix. Use this new helper in both scripts.

Signed-off-by: Geliang Tang <geliang.tang@suse.com>
---
 .../testing/selftests/net/mptcp/mptcp_join.sh | 54 +++++--------------
 .../testing/selftests/net/mptcp/mptcp_lib.sh  | 32 +++++++++++
 .../selftests/net/mptcp/userspace_pm.sh       | 30 ++---------
 3 files changed, 49 insertions(+), 67 deletions(-)

diff --git a/tools/testing/selftests/net/mptcp/mptcp_join.sh b/tools/testing/selftests/net/mptcp/mptcp_join.sh
index f922d32f4f20..f98166b232c2 100755
--- a/tools/testing/selftests/net/mptcp/mptcp_join.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_join.sh
@@ -2779,49 +2779,17 @@ backup_tests()
 
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
 	local name
 
-	if [ $e_type = $MPTCP_LIB_LISTENER_CREATED ]; then
+	if [ $2 = $MPTCP_LIB_LISTENER_CREATED ]; then
 		name="LISTENER_CREATED"
-	elif [ $e_type = $MPTCP_LIB_LISTENER_CLOSED ]; then
+	elif [ $2 = $MPTCP_LIB_LISTENER_CLOSED ]; then
 		name="LISTENER_CLOSED "
-	else
-		name="$e_type"
 	fi
+	printf "%-6s%-36s" " " "$name $4:$5"
 
-	print_check "$name $e_saddr:$e_sport"
-
-	if ! mptcp_lib_kallsyms_has "mptcp_event_pm_listener$"; then
-		print_skip "event not supported"
-		return
-	fi
-
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
+	[ $? -eq 1 ] && fail_test "$name $4:$5"
 }
 
 add_addr_ports_tests()
@@ -2859,10 +2827,14 @@ add_addr_ports_tests()
 		chk_add_nr 1 1 1
 		chk_rm_nr 1 1 invert
 
-		verify_listener_events $server_evts $MPTCP_LIB_LISTENER_CREATED \
-				       $AF_INET 10.0.2.1 10100
-		verify_listener_events $server_evts $MPTCP_LIB_LISTENER_CLOSED \
-				       $AF_INET 10.0.2.1 10100
+		if mptcp_lib_kallsyms_has "mptcp_event_pm_listener$"; then
+			verify_listener_events $server_evts $MPTCP_LIB_LISTENER_CREATED \
+					       $AF_INET 10.0.2.1 10100
+			verify_listener_events $server_evts $MPTCP_LIB_LISTENER_CLOSED \
+					       $AF_INET 10.0.2.1 10100
+		else
+			mptcp_lib_print_warn "[skip] event not supported"
+		fi
 		mptcp_lib_evts_kill
 	fi
 
diff --git a/tools/testing/selftests/net/mptcp/mptcp_lib.sh b/tools/testing/selftests/net/mptcp/mptcp_lib.sh
index 68b07216e47a..0aea2c5175d5 100644
--- a/tools/testing/selftests/net/mptcp/mptcp_lib.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_lib.sh
@@ -411,3 +411,35 @@ mptcp_lib_check_expected()
 
 	return 1
 }
+
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
+	local name
+
+	if [ $e_type = $MPTCP_LIB_LISTENER_CREATED ]; then
+		name="LISTENER_CREATED"
+	elif [ $e_type = $MPTCP_LIB_LISTENER_CLOSED ]; then
+		name="LISTENER_CLOSED "
+	else
+		name="$e_type"
+	fi
+
+	type=$(mptcp_lib_evts_get_info type "$evt" "$e_type")
+	family=$(mptcp_lib_evts_get_info family "$evt" "$e_type")
+	sport=$(mptcp_lib_evts_get_info sport "$evt" "$e_type")
+	if [ $family ] && [ $family = $AF_INET6 ]; then
+		saddr=$(mptcp_lib_evts_get_info saddr6 "$evt" "$e_type")
+	else
+		saddr=$(mptcp_lib_evts_get_info saddr4 "$evt" "$e_type")
+	fi
+
+	mptcp_lib_check_expected "type" "family" "saddr" "sport"
+}
diff --git a/tools/testing/selftests/net/mptcp/userspace_pm.sh b/tools/testing/selftests/net/mptcp/userspace_pm.sh
index 6a84e563b2ca..f99edce8171f 100755
--- a/tools/testing/selftests/net/mptcp/userspace_pm.sh
+++ b/tools/testing/selftests/net/mptcp/userspace_pm.sh
@@ -832,32 +832,8 @@ test_prio()
 
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
-	if [ $e_type = $MPTCP_LIB_LISTENER_CREATED ]; then
-		print_test "CREATE_LISTENER $e_saddr:$e_sport"
-	elif [ $e_type = $MPTCP_LIB_LISTENER_CLOSED ]; then
-		print_test "CLOSE_LISTENER $e_saddr:$e_sport"
-	fi
-
-	type=$(mptcp_lib_evts_get_info type $evt $e_type)
-	family=$(mptcp_lib_evts_get_info family $evt $e_type)
-	sport=$(mptcp_lib_evts_get_info sport $evt $e_type)
-	if [ $family ] && [ $family = $AF_INET6 ]; then
-		saddr=$(mptcp_lib_evts_get_info saddr6 $evt $e_type)
-	else
-		saddr=$(mptcp_lib_evts_get_info saddr4 $evt $e_type)
-	fi
-
-	check_expected "type" "family" "saddr" "sport"
+	mptcp_lib_verify_listener_events ${*}
+	[ $? -eq 0 ] && mptcp_lib_result_pass "${TEST_NAME}"
 }
 
 test_listener()
@@ -879,6 +855,7 @@ test_listener()
 	local listener_pid=$!
 
 	sleep 0.5
+	print_test "LISTENER_CREATED 10.0.2.2:$client4_port"
 	verify_listener_events $client_evts $MPTCP_LIB_LISTENER_CREATED \
 			       $AF_INET 10.0.2.2 $client4_port
 
@@ -896,6 +873,7 @@ test_listener()
 	mptcp_lib_kill_wait $listener_pid
 
 	sleep 0.5
+	print_test "LISTENER_CLOSED 10.0.2.2:$client4_port"
 	verify_listener_events $client_evts $MPTCP_LIB_LISTENER_CLOSED \
 			       $AF_INET 10.0.2.2 $client4_port
 }
-- 
2.35.3

