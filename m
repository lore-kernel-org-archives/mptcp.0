Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2051.outbound.protection.outlook.com [40.107.21.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40AA8199BB
	for <mptcp@lists.linux.dev>; Wed,  8 Nov 2023 14:12:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="pXjSordS"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZeKo8wNX53fC69gilkaZsIgTfig6JAYyHn3wnYj0CEQ1yp9GTJdn3U1R513+J/g06I26K12N7DKVRxEKh8N2cfMG3ZIS52veDHUacSIfCuEPpE5tKo2MdAaU4WUt2pTc5r/IdvOYudP6T5WZCBRFhUIHwMV78pIwYaLT4egslH7ajkIl6h1STNfQB8K9M7RvL5IvGS2cBvqnz4hdq1vZb36voAxLu4uRf6KuGsC64s2I8dbgWaboQfbdlsiSCO0i2mSQD88QeZGoFa6yiZbK8HNL5xUbFWSaUPVSX9xU7ZgmmCrakc+gtuW/PG6OXtDefJIRDaAFBtqEx/a96WTLiA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rI4qiIKZCDckmcnp2dIb4hzsbK2MdAb85OkgPEQH/UY=;
 b=m0/9DI87Eb06wbxvkew4x3hTsMOFAMCym0LdEoZBLSHMDVi9Hxng/eQs80of7J8J4J6tTwl5yynDuVe73wghANIbO4LjtCF5fTI35EVcpRcKuJJL/7qvaQ+4PDdp5Np57EMP5AJ/fM86RFcwVPJyg+0EMv6sCVeVRTxF3NGGGhyLNaATax/gNidcZEKJCr2/zrn9XLsM+8Ick+9TAk4QSTkmmiPB6tmzxBcTD+/ZtUTo5UdYP63oGGYffDXHHOxDZPSh2BN6DTKGJ7vsFeXMRJSE8yk4jrTpYT2yeJEEkrfd885StHXrhWdkuBSXLkh4rnbMo4MgfEuBwb9GzEoEWg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rI4qiIKZCDckmcnp2dIb4hzsbK2MdAb85OkgPEQH/UY=;
 b=pXjSordS5QUFjcxRRwzJOaCHKMoTENOcU8VEtL+ZzZTLP9NcpgrswxMT8cGQpbmyOPWTEjFxxKQdExQDmEEx9V+T0y0gyn4BqB7ft6LvVx3RlHXAojnobCTKP05RcAkNa5f++tIlXXuqn1n5YrNVvAuC3Uo/M1xxf0NnTnGfKnjPUbrF0GMZUKvTHOt7ToEgwlajJRf/yS4dKd7eDisADYTEFd3h+vKo4svpwjmdA00TOfEBVuvud90AfHjkE/ctekjEfCkT97nfekm6Rk/pN1rlJz6qjI6sgiZu3rKH4AIzslXQHHDz3kk3WdZ2g36vx5N9suQgFOcfTVD++r2dGQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by VI1PR04MB10050.eurprd04.prod.outlook.com (2603:10a6:800:1db::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6954.19; Wed, 8 Nov
 2023 14:12:17 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::7102:259:f268:5321]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::7102:259:f268:5321%6]) with mapi id 15.20.6977.011; Wed, 8 Nov 2023
 14:12:17 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next 03/13] selftests: mptcp: do some cleanups
Date: Wed,  8 Nov 2023 22:11:44 +0800
Message-Id: <cfb6d8610cb75b64e4bc3a79c26ff5c6eb824db1.1699452144.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <cover.1699452144.git.geliang.tang@suse.com>
References: <cover.1699452144.git.geliang.tang@suse.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR03CA0108.apcprd03.prod.outlook.com
 (2603:1096:4:7c::36) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HE1PR0402MB3497:EE_|VI1PR04MB10050:EE_
X-MS-Office365-Filtering-Correlation-Id: 500cc51d-cc14-4713-8522-08dbe064b6e5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	RMx4JRXi0teNmQ+aq1+cryy6ZIG97nm0YeQiySNgsjqhn3UTn/fw0Ye/co2PQ5OSMaVHNzqccGi2wE427/MVO6HAnxfoBPS5DNKyJZk2qP94Y6fcqf79HDSNKY/9jyi0x6Ckmaox8TbXAQ4MgFFqk4xvb0M/ezTGdFuyfGNqPDG7lHFvRVTQm08/rYgTGWK7MxvbrJyqj+6G+bHeXDzrma8tklmkXhCB9L1Fa1FoDncz3VYt+3EWy+GGrXBNeCmlm074li79DDxxTK3bDWOUwZpDNF63voHqJhHZVK7XPQPPpFruNLdB1MIq14SmyHKP9a58cmLdLVaPEOvYrkTHpQfFt54rylBBqCwp90i8dnJUhCo6yqAbHVzpDNVqXITkSX+5oOcBo3Ad0QbdNVU89MM52GCyshBK2GRAAYh07rNFl+Ks/dmmSsqdf8j34vUHGkSAFCGm8pI+SNRi8fQX9FbTOqpV0Sg9hGBzpe6f3gvrnCGBV0H8AT/v2cHvsrdzN2i+ZDPTBrxibtW2GpDWEt2Y25B7Ke4Eb3Tcubs9Fj0taU5eyo12r7v9aXTC477o
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(39850400004)(346002)(366004)(396003)(376002)(230922051799003)(186009)(1800799009)(64100799003)(451199024)(26005)(478600001)(6512007)(107886003)(6666004)(6506007)(83380400001)(4326008)(44832011)(5660300002)(66476007)(66556008)(41300700001)(6916009)(8936002)(8676002)(6486002)(316002)(66946007)(2616005)(38100700002)(2906002)(36756003)(86362001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?NPzpXHfa2Q+2S6/R1+JTSLTLxDkepsMwSX6ehUFEDl+13MRz0dUI7A7DAYlR?=
 =?us-ascii?Q?dK3MHYtlwWNx5/Qh4X3l2X1cSJ6n0/9tSTh6upol4EhqsNX8NCWPVcyDFAZ7?=
 =?us-ascii?Q?jjI8SIv6ED7NkCZb/7eAW7FE3EbpqO+976Hq08IuFgcUyvzfW3J5XoVgJ6xI?=
 =?us-ascii?Q?qKf0k2yGUf+ADD6+RGFWv1FYBHs0bjHRUexreMbdyScjj8zXutWZQPN9G/Ea?=
 =?us-ascii?Q?gtD17xBk3T4W4z6f97R9GZnTYdBT1x6C67mQE9krGivhQRTeFoRNHJFLsOj5?=
 =?us-ascii?Q?Gs85xy0SA6WMFjXH4vt3m3j49GlWGqTSl0EeUkdUMdIfvips86A/QvETDEBY?=
 =?us-ascii?Q?5E78O73ED9clAmscUvIHSN+GxHDli9E7cUVZgG0CFU2UsGHK1Z955YsxY0XT?=
 =?us-ascii?Q?E8oNoWdXN+xaQ7Cx06S8s/COSyPphIn2mbROFzoIPn62bKOKz7u5Jy2O/Gws?=
 =?us-ascii?Q?HuTFLVwLnxBJm4lrOBfOqEDVH9G2kqGzleTd01RfUJP6QvlHAz4SkJ9gETHm?=
 =?us-ascii?Q?MlViM387guQybQ0WxCKODjwM4z2MFO2r1euC55E4zBSChCQ1YmNuVunu5IC+?=
 =?us-ascii?Q?8L/LVSObXIrvCI8UBNeinePXy2h+i/iaB6iNzrz9xPme3afvLSVWfgELjuY0?=
 =?us-ascii?Q?zpHAOWteclAGq2qCpHHgczY9FrnkBQWFOvk9ifFpfuot3DaGzUwPsWJjUKK+?=
 =?us-ascii?Q?MZic7Mpsc/jADtsnHQbaxYf6F8vjQ08wPLyHRSMPBla18sj80D8MjeHKMP9m?=
 =?us-ascii?Q?MUpIi5P2SKyU7YsYb5Y6xBo6aajzC8c82RGll9GyxsGY5CpcqG7DjGg0Mg69?=
 =?us-ascii?Q?HLxf9mJPDqzuBVwv19m/UXYgf3s8/aapwxyGWHMF92obeb8atXFvgoVgJ13k?=
 =?us-ascii?Q?5bLryL094OxT2j/UbaAgISx4z/nK2c3M4fm27zg60dlFqsIzEMY1687+8DO8?=
 =?us-ascii?Q?LzEUUvwwJVHfYlg6aoWSRkmjIzTa0s3kyMBhgbXNPH0AwG9tNz6hFy0cxvJ2?=
 =?us-ascii?Q?0ym5G+p2GDiNLOvzw/7KRwhG6/sAtmWp8fQnN3+SZlbLOSL5uqli5yDuc8A3?=
 =?us-ascii?Q?f9scgccGSvSTdTz520K5ElkXD/eYK+RSY4ZOom6popc0SGIFLAuLc3o8AFha?=
 =?us-ascii?Q?WFGyIu/G+53bUZwyehSeq4nW+TJ+3SCeggiKjEqD5KGJ1fSXWz0d2aUtr7vR?=
 =?us-ascii?Q?ewXvAjLhXgJrMy0QxYY9isD8gZfVAsfao1GWM2+HJzihPHzO97th9yCIvUua?=
 =?us-ascii?Q?MwknH7hPkmG4sgOFkhtTP2wsBTq53lsjLEl6JSc8rY9j9dJIE53s/reB0bnx?=
 =?us-ascii?Q?mt0anV6lp/xVkZrTa2Pa9hcoFCVZghqyuVRa42uSH/dsxcPLByZmCH8mq2aM?=
 =?us-ascii?Q?PZyEl+Zhv2/5r3I1OGouyZmW4ouhoWdudxnZt99rCfO69MMGFciPh9zG3cLO?=
 =?us-ascii?Q?Kh8VEJn3nUuvWVhPABh8jz0z6xWxxPRAE/ytUw4eSdSFC8Q+jDntcg86VSny?=
 =?us-ascii?Q?UxBySGurVipGq3/FIDUG9UYeof0ZE0vYseNJv0inqFeK507QHxSdsibY0MiM?=
 =?us-ascii?Q?7Sq2ELz7gSIvJNhRlBHnqLMMl5/3aQCci1pVKmlk?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 500cc51d-cc14-4713-8522-08dbe064b6e5
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Nov 2023 14:12:17.6136
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: deRcNBHwcHlijQunPz6Ncsfga76HnHiYu8L4ApmzKGznwChrNUsCTxEB+gyzKadEMs/K3n2MnVLkRopjSIndvg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB10050

To maintain consistency with other scripts, this patch does some
cleanups:

    drop duplicate 'ret' var in pm_netlink.sh,
    change 'capture' and 'checksum' as bool vars in mptcp_join,
    change timeout_poll to 30 in diag.sh.

Signed-off-by: Geliang Tang <geliang.tang@suse.com>
---
 tools/testing/selftests/net/mptcp/diag.sh     |  2 +-
 .../testing/selftests/net/mptcp/mptcp_join.sh | 22 +++++++++----------
 .../testing/selftests/net/mptcp/pm_netlink.sh |  1 -
 3 files changed, 12 insertions(+), 13 deletions(-)

diff --git a/tools/testing/selftests/net/mptcp/diag.sh b/tools/testing/selftests/net/mptcp/diag.sh
index 95b498efacd1..e59d3b33bb22 100755
--- a/tools/testing/selftests/net/mptcp/diag.sh
+++ b/tools/testing/selftests/net/mptcp/diag.sh
@@ -8,7 +8,7 @@ rndh=$(printf %x $sec)-$(mktemp -u XXXXXX)
 ns="ns1-$rndh"
 ksft_skip=4
 test_cnt=1
-timeout_poll=100
+timeout_poll=30
 timeout_test=$((timeout_poll * 2 + 1))
 ret=0
 
diff --git a/tools/testing/selftests/net/mptcp/mptcp_join.sh b/tools/testing/selftests/net/mptcp/mptcp_join.sh
index 5c8873bc75e1..6d2e70785fdc 100755
--- a/tools/testing/selftests/net/mptcp/mptcp_join.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_join.sh
@@ -29,11 +29,11 @@ iptables="iptables"
 ip6tables="ip6tables"
 timeout_poll=30
 timeout_test=$((timeout_poll * 2 + 1))
-capture=0
-checksum=0
+capture=false
+checksum=false
 ip_mptcp=0
 check_invert=0
-validate_checksum=0
+validate_checksum=false
 init=0
 last_test_failed=0
 last_test_skipped=0
@@ -94,7 +94,7 @@ init_partial()
 		ip netns exec $netns sysctl -q net.mptcp.pm_type=0 2>/dev/null || true
 		ip netns exec $netns sysctl -q net.ipv4.conf.all.rp_filter=0
 		ip netns exec $netns sysctl -q net.ipv4.conf.default.rp_filter=0
-		if [ $checksum -eq 1 ]; then
+		if $checksum; then
 			ip netns exec $netns sysctl -q net.mptcp.checksum_enabled=1
 		fi
 	done
@@ -373,7 +373,7 @@ reset_with_checksum()
 	ip netns exec $ns1 sysctl -q net.mptcp.checksum_enabled=$ns1_enable
 	ip netns exec $ns2 sysctl -q net.mptcp.checksum_enabled=$ns2_enable
 
-	validate_checksum=1
+	validate_checksum=true
 }
 
 reset_with_allow_join_id0()
@@ -406,7 +406,7 @@ reset_with_allow_join_id0()
 setup_fail_rules()
 {
 	check_invert=1
-	validate_checksum=1
+	validate_checksum=true
 	local i="$1"
 	local ip="${2:-4}"
 	local tables
@@ -978,7 +978,7 @@ do_transfer()
 	:> "$sout"
 	:> "$capout"
 
-	if [ $capture -eq 1 ]; then
+	if $capture; then
 		local capuser
 		if [ -z $SUDO_USER ] ; then
 			capuser=""
@@ -1079,7 +1079,7 @@ do_transfer()
 	wait $spid
 	local rets=$?
 
-	if [ $capture -eq 1 ]; then
+	if $capture; then
 	    sleep 1
 	    kill $cappid
 	fi
@@ -1467,7 +1467,7 @@ chk_join_nr()
 	else
 		print_ok
 	fi
-	if [ $validate_checksum -eq 1 ]; then
+	if $validate_checksum; then
 		chk_csum_nr $csum_ns1 $csum_ns2
 		chk_fail_nr $fail_nr $fail_nr
 		chk_rst_nr $rst_nr $rst_nr
@@ -3611,10 +3611,10 @@ while getopts "${all_tests_args}cCih" opt; do
 			tests+=("${all_tests[${opt}]}")
 			;;
 		c)
-			capture=1
+			capture=true
 			;;
 		C)
-			checksum=1
+			checksum=true
 			;;
 		i)
 			ip_mptcp=1
diff --git a/tools/testing/selftests/net/mptcp/pm_netlink.sh b/tools/testing/selftests/net/mptcp/pm_netlink.sh
index 8f4ff123a7eb..ed1e8380838a 100755
--- a/tools/testing/selftests/net/mptcp/pm_netlink.sh
+++ b/tools/testing/selftests/net/mptcp/pm_netlink.sh
@@ -28,7 +28,6 @@ sec=$(date +%s)
 rndh=$(printf %x $sec)-$(mktemp -u XXXXXX)
 ns1="ns1-$rndh"
 err=$(mktemp)
-ret=0
 
 cleanup()
 {
-- 
2.35.3

