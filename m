Received: from EUR04-HE1-obe.outbound.protection.outlook.com (mail-he1eur04on2084.outbound.protection.outlook.com [40.107.7.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED04E18C34
	for <mptcp@lists.linux.dev>; Tue, 14 Nov 2023 10:23:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="33Ay3paC"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=i236/THQ3qJi6zVf5RmfSdIIUZf8FDAm8FdRaRCSz1FTn49UG3eD9Xmg87l3qcN/j1llJRaN06UhwaRGGF5a/SRlZ37Qj55OUzlF00XhevL/jNCj1ByOYlitfOxwB/ZObZOOgBdZwkzxO32ASH7aqlHB5B2l5gwjnC95vS2HcYWAq0oz2phFZiiiKOJHPl/g+askCfXNMPMSS1IiLZSsclgs/dhnTCzk15hN2fWSadaZ+7f/dD89EBW0GRI2wfiUz9okGdlMQ9OW4USg5MLE2oeykQPKYCb9KLJ9EOx12JKXf71aBiuczd2ftsqE3tbvGwaXsqUZEczLzpSF0b/CDQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TPgKtBgb8R+Eodzpz0NAQe7lMk5DTfdsZaxJOTktBeI=;
 b=Qj1PRCPRtqq8BjOb85Ek8Fo4rly7BJ1uSMmFqVI9A5dlC7KEvKwQQre7AxTlG8LnQyJzIxIGpjmcaeDNbME3lfrxy7CItxt9H21z0JGFVPP5GBqQ6lLLMSN+WUVe29Gz30cc3gnAhhi2fijAOoSd90ByNQFvYUU6SvMbZuj50ox2vNChsM+mPD7TYxbedB2sEe49TTWyGqH2WXhN8qn2XYW4zN0UQpvnS8yy3YBjQeuxSdqEbDuT57gK3vhOSDh8xEmS2L9Xf2YefkeOu4CSzdCpc8P+ze8FBitRAciApUMpPry0KAA3s4Q/JKdQaiobZL2Pv1D3lXh1tNdOkvBxjA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TPgKtBgb8R+Eodzpz0NAQe7lMk5DTfdsZaxJOTktBeI=;
 b=33Ay3paCbITFDZlexRRYudxX++OVLGOeak+nlO4gfGHFBysEMhJwlleLwG6dhrPISxlFH+ZbtpJYNZ/XPXjPN472u0To8a9FQBK2kowgcSTCfldHMGcCxXo2Ea2UfqaJeE94Yj2OWA4owtoUGeUegQLd8PDYbwnylpttlM7xOmMO9kp/79ubYbv4RyJx2stQpPWxfIkfPDK49M6aPVnYAWYxMEFClJFHWMom06FZjzVB12RJP0ayoc2K+lUgd7WfmQZp6mYe8q5LW5r4PEXWejf8Y8dx0Xv7eCPnyiUq2si6Pw8h8HiUN14RMFuuc8suo/FyhGmt1MSfY+T6DgG22A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by AM7PR04MB7013.eurprd04.prod.outlook.com (2603:10a6:20b:116::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7002.17; Tue, 14 Nov
 2023 10:23:43 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::7102:259:f268:5321]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::7102:259:f268:5321%7]) with mapi id 15.20.7002.014; Tue, 14 Nov 2023
 10:23:43 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next v3 18/33] selftests: mptcp: connect: print out test counter
Date: Tue, 14 Nov 2023 18:21:48 +0800
Message-Id: <fa1a60dee90cc01683a823a3f4a902f75c98f56b.1699956980.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <cover.1699956980.git.geliang.tang@suse.com>
References: <cover.1699956980.git.geliang.tang@suse.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TYAPR01CA0164.jpnprd01.prod.outlook.com
 (2603:1096:404:7e::32) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HE1PR0402MB3497:EE_|AM7PR04MB7013:EE_
X-MS-Office365-Filtering-Correlation-Id: 556a4673-c2c2-43b9-9c24-08dbe4fbc749
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	OiS4h97U4pYIjgA4o/9EWJs+F2VWtjARe21qxu2M78b71MQMpxkaQFjDWasg4/MJZi6eplU5lWeq5tv5f1bSLVfVl2od6tqYLUgUi41v9FGFUJ4WgtvEin4RMl/ELJ6w+SIPnvlzQrYYxSbqYJb7D3snRD6gmIRagd4JJt9UoxR43u20y4d9VnJEtOJbrkDJiloe8EPlvFv1WsMDxflJLjVM3hZHLCIZaFPcL6URqQrBdUUhnsepyDKOiq16SZKXo0ivmzopw7fCNFqbYW1LPZPME9teFVEUL1phjc3eWPD4ySqFIXbrB4oA4mTOXrpOoSA2A6gIOimQ0P0rKUqM3LDSIjbjncwPS/flRz553vP3kJVpFXaPEb2RqCdXOFSrbNRZsJYYXw2NSnck6A+QNFgaGIWw5aY3abrjKQqExM6fXJOCvoU+bEqkbEcLGrYa81MhyBYElE51AylQZTbooBhIopElQkk+AhivRbjlc+3M+98M4WOjNhUMU6keetMBv9SAwFm3ovd9cfRi2Fd+Hy+c+71bgkoRUm54AwldKQp/VFjI6HD2e1OIYO+l3i9b
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(376002)(366004)(136003)(396003)(346002)(230922051799003)(1800799009)(186009)(451199024)(64100799003)(83380400001)(6506007)(38100700002)(8676002)(107886003)(2616005)(6512007)(2906002)(86362001)(41300700001)(5660300002)(36756003)(8936002)(44832011)(66946007)(66556008)(66476007)(4326008)(6916009)(316002)(26005)(6486002)(478600001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?CxqHEbWZhHoiE7AkPN2o9sfcPXsdlUfBgEgFIgNAfnLnIivXYeaBlWpUyoU4?=
 =?us-ascii?Q?LbTYx8dUQEMrvVRUCmTd1kjbM6WDqmG/2rBrIN17gnrtvAchP9ZdtZYdLdw9?=
 =?us-ascii?Q?P30iAnGAL5ArcWWgc8hbRh3NDPo/SLchvu+sOyQuL/tlRebdP7gGvoJtWpmm?=
 =?us-ascii?Q?5/RvNsMOk85soiWzTa7aIL6dZR2FE1kbY4cb8cJXRe7DEWeX3Pad+mgGRodn?=
 =?us-ascii?Q?+4LxHREqG/NC0fJ4mpO/zldJONLTeRuGZrIQDlf+a/2vhIbRzFULlffMtRYi?=
 =?us-ascii?Q?B9xhGZR8SKuQMVmb1hLcIBXJtol09CMw4N/KZnKlUJ/dw/UHEyBRRe7t+Ke3?=
 =?us-ascii?Q?b3S/Ka9Wp9TCVDHGkkE/tk4SOZ88NTmMbSbu99xomryUMAcWx37Dpp1m7Rn+?=
 =?us-ascii?Q?kw1LFYvFjjNQJ6ctkyWL5L+Gi2aM0/cBqJW/e52NlydQsjAfC4AU+ZnHNV11?=
 =?us-ascii?Q?wNGPsCTgQKLbIHI4KZsNGabJqbXH3m20f5WbdC7z0NI7GzpIp8LWjCQFwiMx?=
 =?us-ascii?Q?Z9F+t/kCHfar6itpcuh5NzYHbPs9+P7tcaMysZvNH7m3g+r4/AO+5AnLqrLu?=
 =?us-ascii?Q?hu62VKpOK9Mm9QrgImmWkJUx7y7woD3OMkB0v4ZaoldYiUiRXy8EjC5goZN6?=
 =?us-ascii?Q?O6v240uTxIRyu6JWbEHJzaOD8zn25CzPdQOyl5tmVRojhNXpIy9qxuw8KTk1?=
 =?us-ascii?Q?LTYdQUsdWUKl8bR7Chi8TfMvvD32gZ0h+FlveCfmE1MEYRZcuDrBEZikxD5v?=
 =?us-ascii?Q?RUzqTFblxETKOpq3BCE18YPmG3q9OMFoqd7bnbqjx18OW6jJ2EocSGLYhdnm?=
 =?us-ascii?Q?Il8cVrtrowfMwcZ47eFzVFsj7QiXpOPmKrlt/BDkY7G+Di9Qsc480ullqoVG?=
 =?us-ascii?Q?lSI5el96pOiLqiIdJuC7AoJiOLK3LtTgeG/R/DuJn54BqeZR9/TS/l8wcWGc?=
 =?us-ascii?Q?3eWnCEjWib/7qeje/ftyMNhl4zSe4Hwfa5JNE0p/F20/AmKpp9QOZKMnjq08?=
 =?us-ascii?Q?cv3jfO1irc98tQksJ8R6gtR49NRzh4DcUd7pp321HeFcCCrrbGn27GSXbEtZ?=
 =?us-ascii?Q?At+Tj7qxmXgQ/B2+LuKqHOXgZV+ZVeiLyHUCHML+BvSvYnn1sBgmnTKx3+8y?=
 =?us-ascii?Q?FQAh+DmiF8jPpAPltRHu+7sOvgc4ZV5oxBPhbpjlF+TgiM2BFTG6ysLSbQZ2?=
 =?us-ascii?Q?1LbH+YThMcR6LcxTx4vZonKRD0RLLszcM2cVvs4NKmWzueAc1aohpfp6N0L+?=
 =?us-ascii?Q?kMo+RuSa6JgmqPyRg8DnZ3kexocWgmT4kXfg3igj4rN3eHZx0QHGNpCl0eQd?=
 =?us-ascii?Q?xEXiUMRKtkdWMIPcFnmYq5/eXaWWwW2YPOZCxXRp0IKRYogq5FIfByzmm9a7?=
 =?us-ascii?Q?113qgMJcSN7perlgVfZQfwWwJAU3jgtNUQwvv0z0j6nKa0cfmC4wGjnfJKaO?=
 =?us-ascii?Q?VqA+k6TTXBBDdw3KMXGiSnOQqnh3aEM5Y4AE+5kkJfuWUcs6IVBhRdtVpH6M?=
 =?us-ascii?Q?DJvweYL/2U6Bcsd71eqyV/RRFkTUTQkxfyXpA0rx1dm1/j0+UwIyOU1trUwZ?=
 =?us-ascii?Q?fcKfePka5YJzrxRyCiDFwsPbh618DDpGmnZRv1Dn1nPIiXSXX8fFOc1t+qZC?=
 =?us-ascii?Q?uA=3D=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 556a4673-c2c2-43b9-9c24-08dbe4fbc749
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Nov 2023 10:23:43.8498
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /yZTiI4hdz27cxm/wOO2triUAQ7+kQ+wlCSrhu9sdQtc/nGdqndkX7CGUlnd/0rtBOh57ZcUZ0/q2ccINq25mw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR04MB7013

This patch prints out TEST_COUNT for every tests in script
mptcp_connect.sh. The output looks like:

 01 New MPTCP socket can be blocked via sysctl                        [ OK ]
 INFO: validating network environment with pings
 02 INFO: Using loss of 0.90% delay 30 ms on ns3eth4
 03 ns1 MPTCP -> ns1 (10.0.1.1:10000      ) MPTCP  (duration   116ms) [ OK ]
 04 ns1 MPTCP -> ns1 (10.0.1.1:10001      ) TCP    (duration    33ms) [ OK ]
 05 ns1 TCP   -> ns1 (10.0.1.1:10002      ) MPTCP  (duration    25ms) [ OK ]
 06 ns1 MPTCP -> ns1 (dead:beef:1::1:10003) MPTCP  (duration   128ms) [ OK ]
 07 ns1 MPTCP -> ns1 (dead:beef:1::1:10004) TCP    (duration    31ms) [ OK ]

Having test counters helps to quickly identify issues when looking at a
long list of output logs and results.

Signed-off-by: Geliang Tang <geliang.tang@suse.com>
---
 .../selftests/net/mptcp/mptcp_connect.sh      | 21 ++++++++++++-------
 1 file changed, 14 insertions(+), 7 deletions(-)

diff --git a/tools/testing/selftests/net/mptcp/mptcp_connect.sh b/tools/testing/selftests/net/mptcp/mptcp_connect.sh
index 0a6d40c3aa85..7442bb2a8562 100755
--- a/tools/testing/selftests/net/mptcp/mptcp_connect.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_connect.sh
@@ -267,7 +267,8 @@ check_mptcp_disabled()
 		return 1
 	fi
 
-	echo -n -e "New MPTCP socket can be blocked via sysctl\t\t"
+	TEST_COUNT=$((TEST_COUNT+1))
+	echo -n -e "0${TEST_COUNT} New MPTCP socket can be blocked via sysctl\t\t"
 	mptcp_lib_print_ok "\t           [ OK ]"
 	mptcp_lib_result_pass "New MPTCP socket can be blocked via sysctl"
 	return 0
@@ -337,7 +338,8 @@ do_transfer()
 	local addr_port
 	addr_port=$(printf "%s:%d" ${connect_addr} ${port})
 	local result_msg
-	result_msg="$(printf "%.3s %-5s -> %.3s (%-20s) %-5s" ${connector_ns} ${cl_proto} ${listener_ns} ${addr_port} ${srv_proto})"
+	result_msg="$(printf "%02u %.3s %-5s -> %.3s (%-20s) %-5s" \
+		${TEST_COUNT} ${connector_ns} ${cl_proto} ${listener_ns} ${addr_port} ${srv_proto})"
 	printf "%s\t" "${result_msg}"
 
 	if $capture; then
@@ -641,7 +643,8 @@ run_test_transparent()
 	# following function has been exported (T). Not great but better than
 	# checking for a specific kernel version.
 	if ! mptcp_lib_kallsyms_has "T __ip_sock_set_tos$"; then
-		echo "INFO: ${msg} not supported by the kernel: SKIP"
+		TEST_COUNT=$((TEST_COUNT+1))
+		echo "${TEST_COUNT} INFO: ${msg} not supported by the kernel: SKIP"
 		mptcp_lib_result_skip "${TEST_GROUP}"
 		return
 	fi
@@ -658,7 +661,8 @@ table inet mangle {
 }
 EOF
 	if [ $? -ne 0 ]; then
-		echo "SKIP: $msg, could not load nft ruleset"
+		TEST_COUNT=$((TEST_COUNT+1))
+		echo "${TEST_COUNT} SKIP: $msg, could not load nft ruleset"
 		mptcp_lib_fail_if_expected_feature "nft rules"
 		mptcp_lib_result_skip "${TEST_GROUP}"
 		return
@@ -675,7 +679,8 @@ EOF
 	ip -net "$listener_ns" $r6flag rule add fwmark 1 lookup 100
 	if [ $? -ne 0 ]; then
 		ip netns exec "$listener_ns" nft flush ruleset
-		echo "SKIP: $msg, ip $r6flag rule failed"
+		TEST_COUNT=$((TEST_COUNT+1))
+		echo "${TEST_COUNT} SKIP: $msg, ip $r6flag rule failed"
 		mptcp_lib_fail_if_expected_feature "ip rule"
 		mptcp_lib_result_skip "${TEST_GROUP}"
 		return
@@ -685,7 +690,8 @@ EOF
 	if [ $? -ne 0 ]; then
 		ip netns exec "$listener_ns" nft flush ruleset
 		ip -net "$listener_ns" $r6flag rule del fwmark 1 lookup 100
-		echo "SKIP: $msg, ip route add local $local_addr failed"
+		TEST_COUNT=$((TEST_COUNT+1))
+		echo "${TEST_COUNT} SKIP: $msg, ip route add local $local_addr failed"
 		mptcp_lib_fail_if_expected_feature "ip route"
 		mptcp_lib_result_skip "${TEST_GROUP}"
 		return
@@ -842,7 +848,8 @@ mptcp_lib_result_code "${ret}" "ping tests"
 stop_if_error "Could not even run ping tests"
 
 [ -n "$tc_loss" ] && tc -net "$ns2" qdisc add dev ns2eth3 root netem loss random $tc_loss delay ${tc_delay}ms
-echo -n "INFO: Using loss of $tc_loss "
+TEST_COUNT=$((TEST_COUNT+1))
+echo -n "0${TEST_COUNT} INFO: Using loss of $tc_loss "
 test "$tc_delay" -gt 0 && echo -n "delay $tc_delay ms "
 
 reorder_delay=$(($tc_delay / 4))
-- 
2.35.3

