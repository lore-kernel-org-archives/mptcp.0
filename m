Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2066.outbound.protection.outlook.com [40.107.22.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCEDD612A
	for <mptcp@lists.linux.dev>; Tue, 14 Nov 2023 06:39:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="kQbcx9yU"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EPQCqEyBHmXsLbtGA4n6j4f0cVsTQEvjBQO+Mo5MqwIi8xACJmThWgCYxcrCi/SxL7+UKj0VqmGi4WLa5eFyJMkx2v3SqEOYpgcofF3EVFTD6VrxtAWzxVetLLrKvK4wyN0iPceCqxpD3BISN8UtCRvyptKKV108VVUiNoiYpirws+gVXfIDa4VhzkeB0d2BvI+HmeQ7U6c3/g41/NxgTXya7hF7h1apeNsLSd51NMZcEW1tkUMFHrQUu8SIc5HvmS7MhlJ+r8uRolFcSw4bbaHRt6jMrXo1b7P0h4J6c+q+FIjMVLsIBrS266fuxn1fS0zAWo+h81ZLddZN1D/AWA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=b9ioPhQUKL6fyznMbm8avRfKNc1Xqu3s05AbZNbSOs4=;
 b=YT2tHB+nxltketnDhoKZlaE01K2LfismY5SbXZA8kGjaFes/xnxTjQoUegZesmnJNmli+r2yewzJvRoED4i1evRPo+IqbGZlr8uX9AKVvOSGF3UhYYTeeY0qN58VMxakFfUFXFA1s+xu39OHfgskERYYKaSSBeuvA0UJnSHVp1iyi+x+Jsv2KqF8Dknl33+Rs5Ga1VNJNJZbeK2qkt64ZCDw3dr0kYP3Oj2wjilMSrLG0Jy4eTB5z833GZSrl4bJORrClvg7hhboP5r9vTPxDAoJwNcjpBZ49H5KeDDQhifq210gII6tlZxcGaV+x+SpnYS/Jn6F5ev8Rr1Dc2SfOA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=b9ioPhQUKL6fyznMbm8avRfKNc1Xqu3s05AbZNbSOs4=;
 b=kQbcx9yUqsJHz2JSJeVleD1JqnKHLGhyXz0u2rfUg7Bx/P/Z5nXaZgj7XZD89INm6cAYIP8qDQKyzrX7wjtCneVp5ln0B/Krp14Y53ME2ospNaD7DSGxs+Hvxy0+bs+qHbiK0qYu27Tzbq/Z23I+0Sxfcr4M7vYnsd9qcZGRIYfpw+doIQua0ASvqLzWsfsyUoIeyf+o5xKYaVWFN3BkeM+1ojd7P0kHzbSTpNCq/K2b7+Bm7IUFgv0pNn45RG5H5/G3FM3hUXX9xKoHQrsS6uM8s2De66BJ8qb6YtUuQ0i+CU3bGue6Axd+UdZ3NNSGlvZeKgCw0FZA9aKBZFioYA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by DB9PR04MB8480.eurprd04.prod.outlook.com (2603:10a6:10:2c6::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7002.17; Tue, 14 Nov
 2023 06:39:08 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::7102:259:f268:5321]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::7102:259:f268:5321%7]) with mapi id 15.20.7002.014; Tue, 14 Nov 2023
 06:39:07 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next v2 09/32] selftests: mptcp: add mptcp_lib_verify_listener_events
Date: Tue, 14 Nov 2023 14:35:28 +0800
Message-Id: <54dba84461555c2def301b1b300e064231360969.1699943337.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <cover.1699943337.git.geliang.tang@suse.com>
References: <cover.1699943337.git.geliang.tang@suse.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TYAPR01CA0194.jpnprd01.prod.outlook.com
 (2603:1096:404:29::14) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HE1PR0402MB3497:EE_|DB9PR04MB8480:EE_
X-MS-Office365-Filtering-Correlation-Id: e772af51-c162-40cb-77e4-08dbe4dc6701
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	F7i1KN55K0ptWa9DpbTLwI+eUJFvgPUe0QO7riyS45JeTY7i7Swm/5smp/BS2EkFfpx1N+wnWlnHXiMFc1sp5D1W2bLcIvcr0qlmqu2EwS8wFIRswqOw2B7aNGDewvrJjiAIR+qyuuuFu5zhUCGhubHi/Ls/NNz+FkAr+avLia/nWEPmsxra2/ZO/yYEM6wrTdVSJSZawBuZ/rdTVMyXKubAAhw3LmF2H7/VbmPuzcI2QRkDwh7/UVe5h/IVfBxNUJgrMFdegTn8sE8c/loSPQiQdfMHJqYaoRTRRd5C+yZfepqNaE+oRtEDj0gfmB22GXlYYY6LZyQlb4WRl22+NHpbNSycIxsa1dpySlOz1hgPKUZ7e8ySZj170EDWoqxq1VizdU4dtKj6TDMP4VCvfUTKBdG8flYYmSqRS/1rZZ/VVUWe+Ft6kFJBHuwEra8/XKMYwywwFiq5iOWIr4qIgTAnVmRxLFb/9o/OBINCfbU78EIuVXSmGAqZuZ/8WGxYCmFYFlYVvVE9R/bkFD/npFk6V36/SVDsjut2w3iwubYhJ5bv3oAittTdLzBQCUHyS7+j2nbAKS5ziNcqFFU36sdjrza5IqGRugdebj0hOavFAaxeG/S59SU/cZwRn3Ly
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(376002)(39860400002)(396003)(366004)(136003)(230922051799003)(1800799009)(64100799003)(451199024)(186009)(2906002)(41300700001)(38100700002)(66476007)(66556008)(478600001)(6486002)(86362001)(66946007)(6512007)(2616005)(26005)(107886003)(6506007)(6666004)(83380400001)(2013699003)(8936002)(8676002)(4326008)(44832011)(5660300002)(316002)(36756003)(6916009);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?XOmSQ8RRs5Ccakolrr+7WiikFSAhaDVaLRSjxZ0HKFd0LlD7mwwD1UbxacXm?=
 =?us-ascii?Q?KFySfyIt4AC8pjzfanld0opZO670y+bKaY25e36q9/5yEq2RStwiBxCuRHaB?=
 =?us-ascii?Q?YvHs93rsNU9IcETHP8EXejQ+wJXTs3v3cofPDdQRloZalB4JY9fYsTyYYnYF?=
 =?us-ascii?Q?5NBXsmnTF96Luq3lvZbkKM3OwR/4jNdA9xSssqos69rGl4fn/4qjUrkMAoJB?=
 =?us-ascii?Q?KZ7ItwBrr224onHLEgXCtXE7PwfqGWhOH2j03TsOXLKeDS3d0ItaU5+L33P1?=
 =?us-ascii?Q?yfqTdNbeOVLyo/svuwI8mhQu06RX5uNy77FsQVjYbMVmkzlxPLsB7CW4WEAV?=
 =?us-ascii?Q?jCggL6RCJSinhhJw4NlrnfUAvFYZ6fBubDIb2C2ug3Y12LwM1G0HavtG7MHy?=
 =?us-ascii?Q?GQkaK9hRemsfk7mDXGp+6/+H+tEtIL+XX60HhF092iWg0Xt6pKfs/5NypuAP?=
 =?us-ascii?Q?xjU9y/h08PXsf7CLWL2VUWy9BwUF9bvnhyaBT6boFsdFWQZNsIzooAmR9M36?=
 =?us-ascii?Q?teYlZmzEfkyy9VPhXjc/b0uot3Osz5Jop7mVnRxxsrgDb42zjLYF4uxxsJZP?=
 =?us-ascii?Q?6fF46r1CC7cLcIb9y8HWDo5UJkn+pNi/tTZjRKX09A+hYPSA9rfXy3sAqdkr?=
 =?us-ascii?Q?tOp95h7cf52WCkphdwEci8n0X+KwDpXcQ3tlQeqfywWketasq8f9sBQ5vn9a?=
 =?us-ascii?Q?GvfdVaFAeF0W9dPtmUUe61l1gZlJdZb4ODU38YmTtF/pb4la2jasuUDT6Wuq?=
 =?us-ascii?Q?lisoLfYp3MBXRs4c4fJsLXRvNCazTSGt71Blosnt9vKqMvV46pFwOc6xc2B+?=
 =?us-ascii?Q?MyG59Zd1IIlHXVP2eqVodXWb8K6ZvKZyKQzxVvfPyr8jtbQjbgKTXikOIdAF?=
 =?us-ascii?Q?sFrE1TiiiL1cj7iuOqXJtyk+1XHrKU6JkLjx/1dPAPmZO+WQQRvdBC5tBgZe?=
 =?us-ascii?Q?d/RbbFNI20+Ri+PswjycGVKvTvKQbIFxFmRyxS1iIqwDcbeTlEtQIH8XMmKT?=
 =?us-ascii?Q?UlQl3CwHLNuB87vpHLMx5Zw+4f8uV+s1JP+OQhGMzxpWd9noT8U+vmGQjmg8?=
 =?us-ascii?Q?z6XFTUltxolBrleHaQ5bl5Y1jxPiChBo7vaRAz9fl0/BXjTxrtd2ji3Mplv/?=
 =?us-ascii?Q?Wj/deCO0ECc+3fVh5AMatCldY94lwlnjyky20gKLBI29bkqi7zJnh6LUyW3z?=
 =?us-ascii?Q?Eh2y0JOH2YZJZpquPFXOzU/bTs9+LMiSrvsNdPlPkhJOW03fA9r45dFl72aP?=
 =?us-ascii?Q?RrBWI8TY6VqZ7Sr49qrGcDnGJpIGDFRTA+Z/2GC67EIFYBsGs+olsSooJlF/?=
 =?us-ascii?Q?lAqcJOMweik+QxD0bmNYyU6ciCF20KZ2ICN8arTy3LoaNJUpPMRCBx9PK5m6?=
 =?us-ascii?Q?suzSMTiPl7HQPAWSMhoAH1MWpwWDa43LrXkxjeRwhRxhaalV/3iGc/ZZsYEB?=
 =?us-ascii?Q?cZ0L5EpghgtzU50lLlPI0VGjQaWQ316AKDSp/atX0sRxcEIieBaHsbdxhgM5?=
 =?us-ascii?Q?jqpVEfLFq42aHN+VC2bzSQvNXpr/p1ciYadSWaIO+Tj+bxM93gfzML73Cf9P?=
 =?us-ascii?Q?5TV0sx5AIN2zaPVWFwjZo2cqVE+MvAEtOYCaTENx?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e772af51-c162-40cb-77e4-08dbe4dc6701
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Nov 2023 06:39:07.8974
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7QWoSsNx72dNRC/F+fqZeTtYqIvYSOHSpGc2watY4p1ifHmSRUENJlRGZc0rx1VIxYiaKPhImJQSYzdISxcqJw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR04MB8480

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
index 1c3df7831855..9ad8c600e58f 100755
--- a/tools/testing/selftests/net/mptcp/mptcp_join.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_join.sh
@@ -2779,15 +2779,10 @@ backup_tests()
 
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
@@ -2805,23 +2800,8 @@ verify_listener_events()
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
index 036130569652..09d948f45f59 100644
--- a/tools/testing/selftests/net/mptcp/mptcp_lib.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_lib.sh
@@ -440,6 +440,29 @@ mptcp_lib_check_expected()
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
index 6e5370275e49..22812292b00f 100755
--- a/tools/testing/selftests/net/mptcp/userspace_pm.sh
+++ b/tools/testing/selftests/net/mptcp/userspace_pm.sh
@@ -838,32 +838,12 @@ test_prio()
 
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
@@ -879,6 +859,7 @@ test_listener()
 	# Capture events on the network namespace running the client
 	:>$client_evts
 
+	print_test "Listener event LISTENER_CREATED 10.0.2.2:$client4_port"
 	# Attempt to add a listener at 10.0.2.2:<subflow-port>
 	ip netns exec $ns2 ./pm_nl_ctl listen 10.0.2.2\
 		$client4_port &
@@ -898,6 +879,7 @@ test_listener()
 		rport $client4_port token $server4_token
 	sleep 0.5
 
+	print_test "Listener event LISTENER_CLOSED 10.0.2.2:$client4_port"
 	# Delete the listener from the client ns, if one was created
 	mptcp_lib_kill_wait $listener_pid
 
-- 
2.35.3

