Received: from EUR01-DB5-obe.outbound.protection.outlook.com (mail-db5eur01on2040.outbound.protection.outlook.com [40.107.15.40])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5F9F7472
	for <mptcp@lists.linux.dev>; Sat,  4 Nov 2023 08:38:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="YHl3It+v"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=S+PeO9NDNBkQew2bXirGGYvusuJT5RwUZyNr+TRF3ydazbv56I5CPP0RvUmHDEYdQQIgt7H4kxrGfijkPuA1sx8pCu6blB3ZLdd9xyWyyOXq2NqZVLyYqNj8s2rd6YF32tCnphnh8jyAjsp0Mt0AwwElJ3kGDqoGehBWn64K0iQ4YoKVSCDVorhQsMqyEM641mrhDyHLygT1RTCzlGYKQGnCk+RoSp7U68B0ugm205rKZGBivnQyNwKxEsFotCkVNk3ZgDeZP8i5afSnJVRUw22fVGaTQWnZpbUhGFWzb9ZkHESa8fMDzGqi9KsP3B75ihzAozMr8VlEN3jqDTX1pw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=l5WuH9stv0qxt7AmRZl2GCRhJPyNI1HOIMLq2wImaaw=;
 b=KEbNzf9NrvAPWOUOkgonMKjZcKGNP6F18AiHskk8DXDuw6b4VLPlA3PzcSLv58Unuix7bqWM42dwsWsrhZnwiGSJ3OxFHFn3jdcwWUJqT/NCTuAPsNeG98c2BRx5Nlk8/HUoYSRBM2LA3+GfeLTGPf3tKPPCnSL+y7oZbsD3VXFPfAuO5Fz2SUV+YS2dCIysD7U8O2mCgqgGwZIbyDL3GidToVrIKzC6ZF6DVnT9FS3Sykaj3747wVgOQwKGm8CvR7ebpVfQQ94PBS1kGMtcvMm3svQYTCLKRGI7psfGeDF3f5bA9BpyrIkiI2e5ULmy8ZSsFqUfS55ZR3vCOnioPw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=l5WuH9stv0qxt7AmRZl2GCRhJPyNI1HOIMLq2wImaaw=;
 b=YHl3It+vcC5l9GuNs23rgNsvHX4BVFwIy3Ap4oT7cYcLhbNZ3kxjFpVLfi0dEnmz/WohlX/oQaHmaWCWevsCrxuxLh/gqALc4WXrnX4GPII3e9YItHC56+bYQnz3XwcvhOyblDjPCGcHCSNSCMmSrvxg7ixbyngg8S5sZc76cKZaLH0PZxCNDQDpUkPE7gFwN9MlgwsoU7vEUtTAMP4meMheSXnbzV9aJNYwckVfwxG4S67LH4EeIT7uYwyrarbEEsZupSAqr17O5VWmzKcVcaKJ6j1g1UwhNRjSVIlGS9mZchmbbHIHlCnnlIkWHhP5qEVkeUFnYiI+AbKw5+hWbg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by AM9PR04MB7681.eurprd04.prod.outlook.com (2603:10a6:20b:286::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6954.17; Sat, 4 Nov
 2023 08:38:09 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::7102:259:f268:5321]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::7102:259:f268:5321%6]) with mapi id 15.20.6977.011; Sat, 4 Nov 2023
 08:38:09 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next v4 11/12] selftests: mptcp: add mptcp_lib_verify_listener_events
Date: Sat,  4 Nov 2023 16:35:59 +0800
Message-Id: <3f7d5b075712f26e3df925d6d9aa07b059e94008.1699086300.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <cover.1699086300.git.geliang.tang@suse.com>
References: <cover.1699086300.git.geliang.tang@suse.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TYCPR01CA0150.jpnprd01.prod.outlook.com
 (2603:1096:400:2b7::19) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HE1PR0402MB3497:EE_|AM9PR04MB7681:EE_
X-MS-Office365-Filtering-Correlation-Id: 3b7641c3-078f-4423-f720-08dbdd115fad
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	0JUFlA13WuU9KPaWmmBODWxkV73VNdwSXij/ft+LOIuQ8so3qx4OoUgrd00btdxrBEhGxZR8raRSNCzf6UYpdUKoDE9P4YPNYwrFk6eByFSJfNnm5LgN67RgoprwONUQzYmm0cQg6dd9sAVO3Iwiboa3ejiXtkGHFnAxzRfH49RvgtQ9psPCGPXuWv5tglkk2cBI2tuow/jInH/fTuoGLlFZxJNjSl+dcpgKnDq9RWRhoJOwnoVAlBoC+m5B29mXCOZq4M7a0HvJVnjSQ0WwaPt1ylqT8Fza1hDThitPr2Hr6aGdDSa5/bMhm5qJBK73NGILj2nEZtgLYYL82qvOxQoGkQPr+grALgDg9BND6wfxCA1x31a9S3fN9MoxyuXGESrYeZUlZ7ZUWTcwXo/m7Pl6z7Xvt5xLcdg+nX0wSsV7pSIbL1zNGxv3DvIOOJwM+FP6C/1u0KGY4Wo50z4in2bAstVhYTqKOklmy6aEtjxLvW3j4iSSP+qrN7WRo5jEACdn48ADPcTrMqC144iuO+UEGmKFs7s7WiT7uwSae2jeWGgqkmQZBoBJLv0tx0HfHjTWrqYGs9OiF1FVypvLlKYCeSaCRiMxsNdJEMHrsuvzdHhaaf8D5+WpmBIKP7J5DN1r7zU2gcdT4oltMvJJuA==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(39860400002)(136003)(346002)(366004)(376002)(230922051799003)(186009)(451199024)(64100799003)(1800799009)(36756003)(2013699003)(86362001)(2906002)(6506007)(6512007)(6486002)(44832011)(478600001)(41300700001)(6666004)(8676002)(8936002)(26005)(107886003)(83380400001)(2616005)(4326008)(66476007)(66946007)(66556008)(6916009)(38100700002)(316002)(5660300002)(13296009);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?uTpT2uSBVMJfG1/TYiZsE/uTUfqBNm/Dpg00NNh1cGsBnvyee1hSJsQGWunK?=
 =?us-ascii?Q?dtiWV/3/+eZQMuUmzSnjjV7HidQ4fJlUH/vKOnagnwbZIDaw57oGbEnrWlDN?=
 =?us-ascii?Q?npkjchLVwNl9+GcF06bfjs+ZEiCGY05ytxk1tCIVIo7LTHJL5IZ8trRj0wuJ?=
 =?us-ascii?Q?ezdFGbuEmVtlMLzQsE3V/hogfAuHAwnn/ceVL6vj/VHkx0Ji30FSdhBQD7To?=
 =?us-ascii?Q?0ikdlO+JrTPypiwq5zbwq1gHuwrVxQLZEWOkhnh1hsmvWoYhL6HysuojJXcg?=
 =?us-ascii?Q?7wkLsDJSy/5aObDVdJhnNS0tzybHYMAKfZz3umXxbzqYxlO5+IO4HFrNtYaM?=
 =?us-ascii?Q?WIpsTIG3HlUD9KxOUYPcAAlx5Fdcp3b8sef2ub45pNI+st0TpGrnuzTwUsFp?=
 =?us-ascii?Q?+4rXVDojNwzC2vioHB2zAOsBaoVW+8C7q7P+vqOVI4xjNpMSy4XFL6xu/Yti?=
 =?us-ascii?Q?rXoL5Xy3tkx7MbV6bzA15q6YwmFrh/C1n0JHv9XXMAFI6el77Em64n7EzFlf?=
 =?us-ascii?Q?H2UxOz0gIzxju0IysmhexB9HrAMzvtOtEhusNv3bmnVNVeIQtr/2mv4zHYbf?=
 =?us-ascii?Q?wTi3xsgwiv1CzfSnXWlyDxepK9nd8YOydyKqAGG4iFYPMV+xZa15lMsyzFhx?=
 =?us-ascii?Q?yO5bp1GTRx5WS9kuA5QDv3DyUWwST/J6OUFrto8/+xyrsVOQ2WEk4MJllYTy?=
 =?us-ascii?Q?plVBSFpgZ0RGK2W305DHJDEecoq1knHuANk0AY3t8HD3I+X/3Gzl6XR1883s?=
 =?us-ascii?Q?SBY7Mk1cLaB8dlfbR223tr5zOkIrsyy6K4qb3cVY4jERNenUVeOR5nHwEF5a?=
 =?us-ascii?Q?rBiHszG2/9uEzckCwwfuGpBoPMfvgcd6ijtkth/DKh5vmddc+rmiPdWtX8s7?=
 =?us-ascii?Q?QGXKsiJI+8aU2RiJPMs9JmCqlvFbGhXwRyDiMb1P5mSowq1mwGaGHImygljt?=
 =?us-ascii?Q?eXatwEB5BLvLMFn25zlAIzn9l5aADNT7VrCsDFnrk5TlgYZWrv+CRpMJLk+P?=
 =?us-ascii?Q?RZTlcz1m/u8LSPksE9XsmRAIJ0SML7ntABuAwiKy/Pi6k1uDcK5fHChGqYrm?=
 =?us-ascii?Q?1vcoNCNJUri3qMCIT+WLQUjb77kVejAPagyE7zFvxWWgjFMWL+oDZMn38vNR?=
 =?us-ascii?Q?3fGacwqmYzf/hxfQ4abjPZrNFlqBoluJUFQIFCahva2zhNS/yOTsTlvzHfa9?=
 =?us-ascii?Q?zCUCyCnNArapGWMuIqIb2XQr4TXHbe4STp8lY4k/gfn8YX1Y7PNV60y6Qqye?=
 =?us-ascii?Q?xLLQ2Hug/ER7i2Rdfhc2Ei8JTN4aiRmpXCdMzhcyZblRjiWzJedXlhKXVPUY?=
 =?us-ascii?Q?QOimNK5/u+RAVBLUi1VOmv2gX8/gVM2gNLbtDZRvnskMYv6UvriDpXubBL8y?=
 =?us-ascii?Q?dgInFXBrU0Ex65uAe4Jnw6Qa/yQuwDWqn+4YTXQF2PJzB6wIh858ptGJrTh+?=
 =?us-ascii?Q?JQk7c1m/LFHKgbscNY8AZAQJAxU69869uPcfCoPYs4POuWRDxH43BAQvxPel?=
 =?us-ascii?Q?5gtEujBn9QSksX5tDNaAGSmWjhfqs0sttfm3jmBFErKRPWOcvVU0nTQEtbCw?=
 =?us-ascii?Q?QAeCDwWpHDtPCPP9uZwWL7hECNovsGlj92RJL0GRXss3vCZ37pWeJikfquJa?=
 =?us-ascii?Q?tw=3D=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3b7641c3-078f-4423-f720-08dbdd115fad
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Nov 2023 08:38:09.5651
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: aq6ZvyMsnLzBZcujh5FUlBFZSGSmsquE675xe0+WKR3SSfHuEHZY1EryVe9Q1hWz/JtV1FqCKjkBkIEWkOvC0w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB7681

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
index 8f7112cb120e..ae58a38d941b 100755
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

