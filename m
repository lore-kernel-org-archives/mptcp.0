Received: from EUR04-VI1-obe.outbound.protection.outlook.com (mail-vi1eur04on2075.outbound.protection.outlook.com [40.107.8.75])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC0F9199B1
	for <mptcp@lists.linux.dev>; Wed,  8 Nov 2023 14:13:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="gueB4ETQ"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=j8na4aRm6BydmcOXi+AUnwoDxhHbB0BUj03YAZ81j1eYdytCRkAkAKfTiwzgDkMismWx1pvzpzfXMiSb2ogyfCHgC7mMScNWQEyiZpzAOibVJWY4ppAo2q+R4bI+ogaovblDUNHQR7dDZc18Kj8pHV+bCAap9V42JAcxZwINgYZszgCNBmklJoMVUPFwEIfNs8gi/cYdZz3rsFyMOm9rmwPSe+3NA1O4fzgxN2Se3slvyytR7XCAPYCYvF6BSL1OXYish2NKHtIumYgcvS8DuE2mTvhLhl/kqpTngUyYEVrtWjxWBIyfQlWhtegcWir6M5X85pss7ydtET9Z2q+ntg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=odhziH72U41NDBeqalHy40ct/6j3yV3EErhsHwPLBr0=;
 b=dmVoIZiRNcm7877M/QVrUvRL7wHq0/e+xnnjOfxYWax8n7GTkJInjg7vUQ08xYDGhTAhemSAAA6Qph9N4Df8bgJWV4WVRy0vld56ONnoaWr207UJlxG2C675ZFT0tDWhVpTVNC7HHs1+9MvB3iL8YzSosHb7saiZP+7R54MI7DlHMybsTOGUMFuIGwt9ylAmQafwqxwoVumnEfDDPRUP4qkYoZRqjkpcScl1f0/n6rVSa6nzo7kwk1KXwhY8vJuBx4pFwBLPrVyiAcAB+L1jglkO/2Jc9+Ny5nXe0+qSC2+a6vZ+wywoMCLOBBNIEpoKSCMPnU0Tm6lJ5Y+ceyG2VA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=odhziH72U41NDBeqalHy40ct/6j3yV3EErhsHwPLBr0=;
 b=gueB4ETQZ/N/imnbLO5UpzGQyCHx4WVEeCNAHwXLcaUSWZBfvUUd0J6juZXLhTZigsMWXdBiyAC9uwiy7MF6V/5CTZTH8dHFA6ZX7eV2vyytSAtI8rpUHIFCYaUDYGdqJEvh6/H8BwURf0EF3idEGDUhqTfAtFVLeSpW1YpwwiHg8yPtEPYb2tbImmwWRRUwqNOAX0L/CaSOj9EIhZLqFWN2+VESEmea5rdkAWRQdJdcUyh9VZdUgj9pv/5RrOcJ81028rYivwV+Ex/6DDhJNTEB80VTOcyeWn7LzmOhEQgExw/0duO+Y5//7nF6brbL+qNpt+zpOaRo/ZKlPMoyeQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by VI1PR04MB10050.eurprd04.prod.outlook.com (2603:10a6:800:1db::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6954.19; Wed, 8 Nov
 2023 14:13:36 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::7102:259:f268:5321]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::7102:259:f268:5321%6]) with mapi id 15.20.6977.011; Wed, 8 Nov 2023
 14:13:36 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next 13/13] selftests: mptcp: use KSFT_SKIP instead ksft_skip
Date: Wed,  8 Nov 2023 22:11:54 +0800
Message-Id: <0c440fc3867b134f0dfa76c347d7c0c8bab0d8ae.1699452144.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <cover.1699452144.git.geliang.tang@suse.com>
References: <cover.1699452144.git.geliang.tang@suse.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TYCP286CA0072.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:31a::20) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HE1PR0402MB3497:EE_|VI1PR04MB10050:EE_
X-MS-Office365-Filtering-Correlation-Id: 1c6ecdfb-d4ae-4a8f-d2c8-08dbe064e61a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	joZNA0JDJij2qFBZVkU+301Oc6c23GS9LQ6urX/ktRw7l0WryjjAIJDZbOWhO3SUEE7BXZC8Pa5xnw8m21N4RcHQiXUdoLVkcU6iVLDIvTxQB1Q0aHYhw3N1p2B7LhwcczM5FzzXi2uIzx6Dbi/KzRNQnh/JGptQJVpqdJukF00nAClq90B7kDFdhOOr3ky/BMqH1RroMTHnJUqm40ecWPyJwSbMePCRLFqot3qhSUJF/93Tesx36PGlzcrn77XyX+dU7wLtidPy3GEp2epPOLdhDgc85QDpfDYT3Aiksg0JhVRK+M7+UoWs86I4u9wSWoQN/hKvQDtx6YBBtAb93cftZUmFpdzE953j5kq8zbJEsFm9aI5eviYvYJHAuGhJJKGNLbAIVE9fs3o34UJCqB8iKoUw6NrWwnj/AD8T2BEKVNu6fSQAbIK41Y6TzK2INwOYksKlapYTgdreF6QBrtpNdMadvgpc42FfwxvcJ8d6Tn2HqigtRtlYI/hhUZeX2+CJb2GpfQUybSFvTam2RiwawCbOGd2jNG2arACaPvBEsLN+dYxgoiTRE3ckGUiC
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(39850400004)(346002)(366004)(396003)(376002)(230922051799003)(186009)(1800799009)(64100799003)(451199024)(26005)(478600001)(6512007)(107886003)(6666004)(6506007)(83380400001)(4326008)(44832011)(5660300002)(66476007)(66556008)(41300700001)(6916009)(8936002)(8676002)(6486002)(316002)(66946007)(2616005)(38100700002)(2906002)(36756003)(86362001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?YewPjdDT+XSMZnKsEuvcKGlx+CahsVLb14FIHyu4frl1ojcUZKFIBTiBNEKE?=
 =?us-ascii?Q?z4k0fdIKtU4egUQdcIdYIKNT3urK9Yx8kuOQ8QXMQGoPKyL79OYKnjJR4lyO?=
 =?us-ascii?Q?BX1JpelMCkUNl63C61rMJ0S4LOD3koUdpEvSJFfHR92LaOxC8USqhpEItmpk?=
 =?us-ascii?Q?o35m7A1UU9o4qcDDJjgFjPX85747Ox3PSwJS0glFFtBn9rBDIKxGcYdrSa9A?=
 =?us-ascii?Q?sA21KVGQQtpUFfls2XqVfrJJ0H3AP8kHaMloHZx7jCRMbarEuJ8eK7yS2p2I?=
 =?us-ascii?Q?5PAneg4weu22cnesBrL8ceQ1qDPhTZvvWaPoC0H4FtG0BEvaVI+2i7SXpLV6?=
 =?us-ascii?Q?+VMKB7xMtLeL+cEWlqpBrZoLxgCjDr6uYsfw8JVU8/Krag6svCDsaJ23+kxz?=
 =?us-ascii?Q?t/mBt9lRmG9vSsEXZd4nrBCjF89RMQn4ByQ3xqQgMfm7GXJjN4qgR7gh0fzO?=
 =?us-ascii?Q?4ct53pEO24L+JUh4PAIqkYScmQnF2beXs72i4bsib65Cij+ENLKinSyajTir?=
 =?us-ascii?Q?Y3rqV+JWHVho7HZhTjsUKmarW783+isw9vlhC+UCJQoGFY+6BrMsAsXUqFD1?=
 =?us-ascii?Q?Yt9wifvvNDd9bONfZJxYFXbgDIFtzRyjZ6wGXUXCuSqQzi9dc+g0vDwORUFx?=
 =?us-ascii?Q?TYux8Ud9UGbBsT2KpjY4ODKPGEDe8Js1b4qrdyoTUa2eqT8DXyYQTaTgXP7e?=
 =?us-ascii?Q?J5hyl1FO0OUnk2wXTjGuwOEm9gugTR+5MUsJZKXZu8DyqK4p/8rTOHPbgPo9?=
 =?us-ascii?Q?l+Fl82F3npD4BHa+HdErEApBB2/uMMHH5lfoMcDk+x354yJx6QrLIZgpcyEf?=
 =?us-ascii?Q?RiKiHJZjXCJwOxJ6k3nJhCynpW80w1LAcDy8lPkqE8rNw1ziDBM2qM+tBW1d?=
 =?us-ascii?Q?/kvbmHOdHnrN9IsCg7c4pbLoWsxMXs5AMqQaAnFigRiznMHKmHVKLEL4dGw+?=
 =?us-ascii?Q?AVt0fxa+dzTFIMZlddsHAiorrSHxaun0zieAULjz9bAVi8cbbInXu6CR9YYs?=
 =?us-ascii?Q?h+AzOlBlXVNVNJ/Y0Z0I93cQAMvNlKlhD0JxeBQTfQL2L/qV/ad4g6Lm7WVD?=
 =?us-ascii?Q?YZUJp128e9oyVsYr2hMkrdtk8M1r6iS5Kro+CMN7qz2eoEXxJ03fklRWJFm+?=
 =?us-ascii?Q?kgvD76gCr/K++Aizp8eIuAQ+NqXETsv9Op23XW8vBkMSDLbQnyawpak38AfG?=
 =?us-ascii?Q?VDVuQ0Mx+9nJLG6d6NN+v+S4iZba5pPxToNNJiS6tJU+j1DLnFyPdu2wtUw8?=
 =?us-ascii?Q?pJL0CPyN34KRsUu6vjdzcZ+chdcZVZqoIpAQ2tq/dZH+7ox8TYO4i4uma87E?=
 =?us-ascii?Q?M24+75F30jULJeQf+7+wH1tBCuM4UN7uAzian/h2U0TrqCLP7IpFMLGUSwjC?=
 =?us-ascii?Q?llAetnV8tfnwcQ9VkERBH7Nq4mK1XAPvUXb1dG0GiiIiwDqzyzbP+lV0kBkg?=
 =?us-ascii?Q?PVj7C2RYAVP4m4/t3L054Fyx/7e0vS3pBrxRmiv1HNZe11zIXs5Is4aWs93r?=
 =?us-ascii?Q?5oNCrVsK8A6ScPSN9EN5d7mu3cOx7pFGPLxDFIXfhw5p9xD20R6mqlx/ANvV?=
 =?us-ascii?Q?Y+ISOHH6+loV6J0A5tTmRZj+4K8KSjNL20RB8fqp?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1c6ecdfb-d4ae-4a8f-d2c8-08dbe064e61a
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Nov 2023 14:13:36.8147
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: cm4ZHjvpRvwpkSflASBm2rHoGAtdOefAv89y4pDFFhDGGliPETAABHC6qn8Ed6n1TmYb2tAsjsKo5ORCjnR+0Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB10050

This patch uses the public var KSFT_SKIP in mptcp_lib.sh instead of
ksft_skip, and drop every 'ksft_skip=4'.

Signed-off-by: Geliang Tang <geliang.tang@suse.com>
---
 tools/testing/selftests/net/mptcp/diag.sh       |  5 ++---
 .../selftests/net/mptcp/mptcp_connect.sh        |  7 +++----
 tools/testing/selftests/net/mptcp/mptcp_join.sh | 17 ++++++++---------
 .../selftests/net/mptcp/mptcp_sockopt.sh        | 10 ++++------
 tools/testing/selftests/net/mptcp/pm_netlink.sh |  6 ++----
 .../testing/selftests/net/mptcp/simult_flows.sh |  5 ++---
 6 files changed, 21 insertions(+), 29 deletions(-)

diff --git a/tools/testing/selftests/net/mptcp/diag.sh b/tools/testing/selftests/net/mptcp/diag.sh
index 6c5f84f59898..c114434954ae 100755
--- a/tools/testing/selftests/net/mptcp/diag.sh
+++ b/tools/testing/selftests/net/mptcp/diag.sh
@@ -4,7 +4,6 @@
 . "$(dirname "${0}")/mptcp_lib.sh"
 
 mptcp_lib_init_ns
-ksft_skip=4
 
 flush_pids()
 {
@@ -32,12 +31,12 @@ mptcp_lib_check_mptcp
 ip -Version > /dev/null 2>&1
 if [ $? -ne 0 ];then
 	echo "SKIP: Could not run test without ip tool"
-	exit $ksft_skip
+	exit ${KSFT_SKIP}
 fi
 ss -h | grep -q MPTCP
 if [ $? -ne 0 ];then
 	echo "SKIP: ss tool does not support MPTCP"
-	exit $ksft_skip
+	exit ${KSFT_SKIP}
 fi
 
 get_msk_inuse()
diff --git a/tools/testing/selftests/net/mptcp/mptcp_connect.sh b/tools/testing/selftests/net/mptcp/mptcp_connect.sh
index a926493a349e..e41f96254f84 100755
--- a/tools/testing/selftests/net/mptcp/mptcp_connect.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_connect.sh
@@ -8,7 +8,6 @@ time_start=$(date +%s)
 optstring="S:R:d:e:l:r:h4cm:f:tC"
 final_ret=0
 cin_disconnect=""
-ksft_skip=4
 ipv6=true
 ethtool_random_on=true
 tc_delay="$((RANDOM%50))"
@@ -136,7 +135,7 @@ mptcp_lib_check_kallsyms
 ip -Version > /dev/null 2>&1
 if [ $? -ne 0 ];then
 	echo "SKIP: Could not run test without ip tool"
-	exit $ksft_skip
+	exit ${KSFT_SKIP}
 fi
 
 capout=$(mktemp)
@@ -145,7 +144,7 @@ cout_disconnect="$cout".disconnect
 trap cleanup EXIT
 
 for i in "$ns1" "$ns2" "$ns3" "$ns4";do
-	ip netns add $i || exit $ksft_skip
+	ip netns add $i || exit ${KSFT_SKIP}
 	ip -net $i link set lo up
 done
 
@@ -238,7 +237,7 @@ fi
 check_mptcp_disabled()
 {
 	local disabled_ns="ns_disabled-$rndh"
-	ip netns add ${disabled_ns} || exit $ksft_skip
+	ip netns add ${disabled_ns} || exit ${KSFT_SKIP}
 
 	# net.mptcp.enabled should be enabled by default
 	if [ "$(ip netns exec ${disabled_ns} sysctl net.mptcp.enabled | awk '{ print $3 }')" -ne 1 ]; then
diff --git a/tools/testing/selftests/net/mptcp/mptcp_join.sh b/tools/testing/selftests/net/mptcp/mptcp_join.sh
index f11d47354937..3dfe20b00220 100755
--- a/tools/testing/selftests/net/mptcp/mptcp_join.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_join.sh
@@ -17,7 +17,6 @@ cinfail=""
 cinsent=""
 tmpfile=""
 capout=""
-ksft_skip=4
 ip_mptcp=0
 check_invert=0
 validate_checksum=false
@@ -68,7 +67,7 @@ init_partial()
 
 	local netns
 	for netns in "$ns1" "$ns2"; do
-		ip netns add $netns || exit $ksft_skip
+		ip netns add $netns || exit ${KSFT_SKIP}
 		ip -net $netns link set lo up
 		ip netns exec $netns sysctl -q net.mptcp.enabled=1
 		ip netns exec $netns sysctl -q net.mptcp.pm_type=0 2>/dev/null || true
@@ -132,7 +131,7 @@ check_tools()
 
 	if ! ip -Version &> /dev/null; then
 		echo "SKIP: Could not run test without ip tool"
-		exit $ksft_skip
+		exit ${KSFT_SKIP}
 	fi
 
 	# Use the legacy version if available to support old kernel versions
@@ -141,10 +140,10 @@ check_tools()
 		ip6tables="ip6tables-legacy"
 	elif ! iptables -V &> /dev/null; then
 		echo "SKIP: Could not run all tests without iptables tool"
-		exit $ksft_skip
+		exit ${KSFT_SKIP}
 	elif ! ip6tables -V &> /dev/null; then
 		echo "SKIP: Could not run all tests without ip6tables tool"
-		exit $ksft_skip
+		exit ${KSFT_SKIP}
 	fi
 }
 
@@ -399,15 +398,15 @@ setup_fail_rules()
 		-p tcp \
 		-m length --length 150:9999 \
 		-m statistic --mode nth --packet 1 --every 99999 \
-		-j MARK --set-mark 42 || return ${ksft_skip}
+		-j MARK --set-mark 42 || return ${KSFT_SKIP}
 
-	tc -n $ns2 qdisc add dev ns2eth$i clsact || return ${ksft_skip}
+	tc -n $ns2 qdisc add dev ns2eth$i clsact || return ${KSFT_SKIP}
 	tc -n $ns2 filter add dev ns2eth$i egress \
 		protocol ip prio 1000 \
 		handle 42 fw \
 		action pedit munge offset 148 u8 invert \
 		pipe csum tcp \
-		index 100 || return ${ksft_skip}
+		index 100 || return ${KSFT_SKIP}
 }
 
 reset_with_fail()
@@ -421,7 +420,7 @@ reset_with_fail()
 	local rc=0
 	setup_fail_rules "${@}" || rc=$?
 
-	if [ ${rc} -eq ${ksft_skip} ]; then
+	if [ ${rc} -eq ${KSFT_SKIP} ]; then
 		mark_as_skipped "unable to set the 'fail' rules"
 		return 1
 	fi
diff --git a/tools/testing/selftests/net/mptcp/mptcp_sockopt.sh b/tools/testing/selftests/net/mptcp/mptcp_sockopt.sh
index 019d4dc91d70..fccc5c504050 100755
--- a/tools/testing/selftests/net/mptcp/mptcp_sockopt.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_sockopt.sh
@@ -3,8 +3,6 @@
 
 . "$(dirname "${0}")/mptcp_lib.sh"
 
-ksft_skip=4
-
 mptcp_lib_init_ns
 
 add_mark_rules()
@@ -29,7 +27,7 @@ init()
 {
 	local netns
 	for netns in "$ns1" "$ns2" "$ns3";do
-		ip netns add $netns || exit $ksft_skip
+		ip netns add $netns || exit ${KSFT_SKIP}
 		ip -net $netns link set lo up
 		ip netns exec $netns sysctl -q net.mptcp.enabled=1
 		ip netns exec $netns sysctl -q net.ipv4.conf.all.rp_filter=0
@@ -80,7 +78,7 @@ mptcp_lib_check_kallsyms
 ip -Version > /dev/null 2>&1
 if [ $? -ne 0 ];then
 	echo "SKIP: Could not run test without ip tool"
-	exit $ksft_skip
+	exit ${KSFT_SKIP}
 fi
 
 # Use the legacy version if available to support old kernel versions
@@ -89,10 +87,10 @@ if iptables-legacy -V &> /dev/null; then
 	ip6tables="ip6tables-legacy"
 elif ! iptables -V &> /dev/null; then
 	echo "SKIP: Could not run all tests without iptables tool"
-	exit $ksft_skip
+	exit ${KSFT_SKIP}
 elif ! ip6tables -V &> /dev/null; then
 	echo "SKIP: Could not run all tests without ip6tables tool"
-	exit $ksft_skip
+	exit ${KSFT_SKIP}
 fi
 
 check_mark()
diff --git a/tools/testing/selftests/net/mptcp/pm_netlink.sh b/tools/testing/selftests/net/mptcp/pm_netlink.sh
index 208669f474cf..422aac2bfaf6 100755
--- a/tools/testing/selftests/net/mptcp/pm_netlink.sh
+++ b/tools/testing/selftests/net/mptcp/pm_netlink.sh
@@ -3,8 +3,6 @@
 
 . "$(dirname "${0}")/mptcp_lib.sh"
 
-ksft_skip=4
-
 usage() {
 	echo "Usage: $0 [ -h ]"
 }
@@ -37,12 +35,12 @@ mptcp_lib_check_mptcp
 ip -Version > /dev/null 2>&1
 if [ $? -ne 0 ];then
 	echo "SKIP: Could not run test without ip tool"
-	exit $ksft_skip
+	exit ${KSFT_SKIP}
 fi
 
 trap cleanup EXIT
 
-ip netns add $ns1 || exit $ksft_skip
+ip netns add $ns1 || exit ${KSFT_SKIP}
 ip -net $ns1 link set lo up
 ip netns exec $ns1 sysctl -q net.mptcp.enabled=1
 
diff --git a/tools/testing/selftests/net/mptcp/simult_flows.sh b/tools/testing/selftests/net/mptcp/simult_flows.sh
index ad589c7699a1..1fb2cb5d6b5f 100755
--- a/tools/testing/selftests/net/mptcp/simult_flows.sh
+++ b/tools/testing/selftests/net/mptcp/simult_flows.sh
@@ -4,7 +4,6 @@
 . "$(dirname "${0}")/mptcp_lib.sh"
 
 mptcp_lib_init_ns
-ksft_skip=4
 bail=0
 slack=50
 
@@ -32,7 +31,7 @@ mptcp_lib_check_mptcp
 ip -Version > /dev/null 2>&1
 if [ $? -ne 0 ];then
 	echo "SKIP: Could not run test without ip tool"
-	exit $ksft_skip
+	exit ${KSFT_SKIP}
 fi
 
 #  "$ns1"              ns2                    ns3
@@ -54,7 +53,7 @@ setup()
 	trap cleanup EXIT
 
 	for i in "$ns1" "$ns2" "$ns3";do
-		ip netns add $i || exit $ksft_skip
+		ip netns add $i || exit ${KSFT_SKIP}
 		ip -net $i link set lo up
 		ip netns exec $i sysctl -q net.ipv4.conf.all.rp_filter=0
 		ip netns exec $i sysctl -q net.ipv4.conf.default.rp_filter=0
-- 
2.35.3

