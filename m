Received: from de-smtp-delivery-102.mimecast.com (de-smtp-delivery-102.mimecast.com [194.104.111.102])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E6577F
	for <mptcp@lists.linux.dev>; Fri, 11 Feb 2022 22:46:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=mimecast20200619;
	t=1644619575;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=diY6luqeB50+P5Ylfs+PybUUb0suC1rvBuJs0n/ZPjU=;
	b=fT6x6B/BRQQJjgDv/GCAH6T9qTn4xFn3RRtsqrb/DO173D6Ec4bI1WZTybjqiN1eo5jO/I
	icQDyL+jvlU2dBpcQGNLrEcu1olw1DQ4WIVxgCBadpbAdmj6ZhYTnHCmyDENIYMFQHpFql
	lVSUQbG39yjqxTnKWvCGihApczwV0ZA=
Received: from EUR05-AM6-obe.outbound.protection.outlook.com
 (mail-am6eur05lp2104.outbound.protection.outlook.com [104.47.18.104]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 de-mta-28-imY1iHekNnmroKxJgrrZUQ-1; Fri, 11 Feb 2022 23:46:14 +0100
X-MC-Unique: imY1iHekNnmroKxJgrrZUQ-1
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MpBhBhZmSXbFMQd+VTMf31LBXDY4uywWUPWbMQijm3jDj4/SMFFG4llM93bvwwECpBbqIdvdWFB+IIquMxJTNvBW7YCqo3nraao03I9L9YrBnrc+eOLVnQvXSUv13ja4gW5deR1zbg4PcUlMx0WuGg2tZnDfeWJMNAwMbzVhLJffbNdqz0hA/EaRozEAduH2Ybp72oxkt2R4aNfUDeLkHnIkljsjfeFXujGrKgvpBo57pGUzIxWZo55n0uAp0GeUwRG3jQfikEqg8LjrTkydmE/jmuWq9wwLPFiqTAoAGOoQXA15Bie5ddj5B4HiNZbu/BoAZkaX/NeEUkY5C+4ocQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kNSKTY2wQg5gOmanM5MwdlF1QDbW5czE4QchsSlCLXs=;
 b=oLDYzOfwJRVXKQNBuCGEdQTuH/ATAlEwWD7Fm64D3a8CqlauPf4KRNiOPg0bV3rt9jecPPVYiutj4/XRty0kmno2PaCmllX2W9hQ34doK1MIp6h+5z/6j6NMm53SLM6ZCV62Op4eAs4DC/fbjb85tyNEaOVZwIczEtWXI6VnQMIZQ3vVtp05ClH7FI/6kN+pYGPQV0BtXdE8m3MNMks/5JGVa1svQ7+5NAlDGKgon7mg38xA7BkhvJn9PFGUOtxJRbToXaSOUKaWImEOjOo6YHDCh1Tf9VVLjkzXTHticxrXzPdIrdU3FrrZ8oAb3sUhQayBl6tDC0O5Jcw42G3naw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by AM0PR04MB5652.eurprd04.prod.outlook.com (2603:10a6:208:12b::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4975.15; Fri, 11 Feb
 2022 22:46:13 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::60de:f804:3830:f7c5]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::60de:f804:3830:f7c5%4]) with mapi id 15.20.4951.019; Fri, 11 Feb 2022
 22:46:13 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
CC: Geliang Tang <geliang.tang@suse.com>,
	Davide Caratti <dcaratti@redhat.com>,
	Matthieu Baerts <matthieu.baerts@tessares.net>
Subject: [PATCH RESEND mptcp-next v7 7/7] selftests: mptcp: add the MP_FAIL testcases
Date: Sat, 12 Feb 2022 06:45:43 +0800
Message-ID: <c123b28c181b1cc3287f45b1b53854a84221f010.1644618926.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1644618926.git.geliang.tang@suse.com>
References: <cover.1644618926.git.geliang.tang@suse.com>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-ClientProxiedBy: HK2PR02CA0162.apcprd02.prod.outlook.com
 (2603:1096:201:1f::22) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 2260781a-d64f-4766-1146-08d9edb04e52
X-MS-TrafficTypeDiagnostic: AM0PR04MB5652:EE_
X-Microsoft-Antispam-PRVS:
	<AM0PR04MB5652357564E4101B794E2132F8309@AM0PR04MB5652.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7219;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	1mbDTAhu6a1wUpjCgCnnrX/vAdaLMzMywvjtcX97EoQwjCE5EjfsnKpof0MnNWn7o1R6FK+e5zojdurmw2ghK2baLES4Svem9bXkvwAPK4TvkhKVRYpQiVLBwmvKFzpbJVzRBrsZpo2BV+QMU7UxXOI33gekPTUzVWeqMxBrENCoMPj72m/0s0HzbryJJuAoYA2b7bnmSquKtsPhg6L9PRb601Y5kAClAMHFRHKoE5wWA/ZpPSgm7g6cOU+aQWdLiSuxeiUyzJAXOSZr/sUjNUkj5K0Ug1RzAwBOkscm+Br7Sy2C4av4I/OMcVEJLd7nwWFN8iSNLonHrjXsfjJjUiM8Hd+RMr8efvUoOc+AVgjuVERaPjWYPrpAMTqM8qFydS6x+ozUyenSdssmQ3AVMhwTvnGrY4Dt5GXPlRZnMmu1h0aS7wanE49BaaFwSQlvw9s1FpKk/3YaLXAlo2PAUn87vjKrmbOqoshAKt9jYbN5MMJp/IIgvBw+idjuf1MUJzDKk3LSw++v6dS5ZCx9andAEuVHRhYZZZr0y3wFBfFUCveP70auV3nMbxBCWOv5DNFATcVqc5/V7fs/v2y1uWqpLN3NKT4Du8o6NNUGJmozjedYGw5PUsMYSGhbaSWJ9Mi+H9MZ3cMFQx1jDlcScw==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(6512007)(54906003)(316002)(66556008)(66946007)(66476007)(86362001)(2616005)(66574015)(38100700002)(4326008)(8676002)(36756003)(6486002)(508600001)(6506007)(8936002)(44832011)(186003)(6916009)(6666004)(83380400001)(5660300002)(2906002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?XD5z8RjKffJuz6aCmE3cNQvPYlEY3uiALDNVkcddsgsDJYV6s1gkASaQvYLC?=
 =?us-ascii?Q?fNCjq6sf71RvevQIJcjlU2sWoFBtRO7au3ARHvFfnkCE79Ob8IICEs33fuhB?=
 =?us-ascii?Q?1uIB5oextoz+c2qai7Q8At6JvlgSdPjZZGaqJpDK/SdMnY8x8w6uApElTuko?=
 =?us-ascii?Q?SG+Lh8BihUCBysIa9TyNRkjGZBwSeDfBgwc+g9pEfbOLcAA0iq7JwdU9rQ0O?=
 =?us-ascii?Q?D3yPum+I3QI/H+hdyLjHyd6bLvNtZHT8QpgJL+ECKuGV+IGM693Y/Npbq0NQ?=
 =?us-ascii?Q?Rz8E62YgYzkEwusrybD+i8NZnQYcWG2jaWG+rhbQXgIgHb044v6VA+5xBzQx?=
 =?us-ascii?Q?PokjNZ+3ssVyyVBtyS6zxXCEFd+qrLIpAmu/kPBpZ89BABX0PdOL0bWZMhNA?=
 =?us-ascii?Q?hwk0H++cx3r7soEO9nJZDd5q9bBinot3JYPXfblJgZ0dSwEbF4BEMHTS2BEp?=
 =?us-ascii?Q?/e0GkS2wFKXGOuACyPb8uGMWoZdch4O8JaEvZbsPDajxACRd7XZMaHcX1LUd?=
 =?us-ascii?Q?IRKojKeMVl361kxJz+tbu7e8rFxrXBB34+K0N60o6SDSB8QN59vOpg4KkX+T?=
 =?us-ascii?Q?yhMcVjjEOcZRJcciLRUlgFJsmIH3FkkMbljVrDoIsF67vmz1k97/pgASnET4?=
 =?us-ascii?Q?kwPGgFa+ICaRiriuhbe+26VceULiVUlV5jVdziPm3q5IMm5RJ8+sLHGg4x+D?=
 =?us-ascii?Q?fXKaddZfllsp945C4HyKZZa7ItmGAqQiLGIIS+NQJYsnw4vP5jszj02n4Rjw?=
 =?us-ascii?Q?pjq6ucZsDtz4fE4+LgycNkuevykFzQLFZ1wg4lrEbH6DWN16oqsF5h3/9Oxo?=
 =?us-ascii?Q?L7bidTrNpab6+Bn+t09djUa5OU3kCQjKqn0C8o1oOxavOs4+HMoeoKiE0e+p?=
 =?us-ascii?Q?XZKtPJ3exMVcLszTGNIUnPKclcHgaNrJHkxygg/DBuujXOucluBNEpqlOg9b?=
 =?us-ascii?Q?TDSFqYY90To3K3PNnlctl5puPt/kGFbbRJt9x3nk7vFT3Z1Xdp2tpKyx9mEW?=
 =?us-ascii?Q?SCnJf05BvmtKF6IfitW2YPhCjqU7bgC72MDQzU0vx8Z8hz9CBfc3sNc2lFAJ?=
 =?us-ascii?Q?2jepM7VopKGU/pPbY8IenJbdlZF2mgzKg1jKQnbcdeVxzPqytRzkGg9XJly5?=
 =?us-ascii?Q?d7qec5h1dxaiCHSIiPyeSO1tqy6/nwvoB667z+0A6ac0oJj/3WNc5+gN8jev?=
 =?us-ascii?Q?HP3FI2P0akq2Yn7O6Oi+Xq6LYffZn4iUG+FcC0fDk6EY+5c0bafGMoCHZ5kh?=
 =?us-ascii?Q?eCe7XFfF3pA6GeALBUoJswcDEYHiBP4UgJ99/sGCdUNua8OQqGF3LOlYh1lh?=
 =?us-ascii?Q?UqswdMCOqbDetmS2Laz9nUA+B97cSLXEUmT5MUsELpZ0hj+tdMzRVXqylO5H?=
 =?us-ascii?Q?na5vFxhUs7YQXK/45NFC3ZAwFCYUPoTRsAa837ZyKxVNKN6t7SprylZz/SLc?=
 =?us-ascii?Q?bbhTLQ6KiJLGqaVSL+8a7ub5qQO3SIDb5mAyK7ouLP6wH3AbJ0pyML5Hw/on?=
 =?us-ascii?Q?Zp9Zgy/q9WuTTWCNyPUgfLCFiy0gzWEIqbDq8jzYwfGjvdvY6689jc4+Q1Kl?=
 =?us-ascii?Q?M0xQi4VoqM9hlOhcuhqoMYvE1SgR9ukR/ZJ2K1gXgdIDdd66SpsfYCjL3DIE?=
 =?us-ascii?Q?NUTZ80rk6FqmGXi6hX9PQ+a9z3JPcvvMwJijtkdDlKRlNJANb9xc1TIbplbJ?=
 =?us-ascii?Q?X0fVShwjDovt5kJMR6jD7xD6StI=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2260781a-d64f-4766-1146-08d9edb04e52
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Feb 2022 22:46:13.6944
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qnjD4CwXys6J43RHrpgeYCO9U/tTia9sZ3uULUMOeUuEdr98vplQX2ore/8mU6O9wARlGn9Q6oHiAghQY47pvQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB5652

Added the test cases for MP_FAIL, the multiple subflows test for the
MP_RST case and the single subflow one for the infinite mapping case.
The former used the test_linkfail value to make 1024KB test files,
and the latter 128KB.

Added a new function reset_with_fail(), in it use 'iptables' and 'tc
action pedit' rules to produce the bit flips to trigger the checksum
failures. Added a new function pedit_action_pkts() to get the numbers
of the packets edited by the tc pedit actions.

Added a new global variable validate_checksum to enable checksums for
the MP_FAIL tests without passing the '-C' argument.

Also added the needed kernel configures in the config file.

Suggested-by: Davide Caratti <dcaratti@redhat.com>
Co-developed-by: Matthieu Baerts <matthieu.baerts@tessares.net>
Signed-off-by: Matthieu Baerts <matthieu.baerts@tessares.net>
Signed-off-by: Geliang Tang <geliang.tang@suse.com>
---
 tools/testing/selftests/net/mptcp/config      |  8 ++
 .../testing/selftests/net/mptcp/mptcp_join.sh | 86 ++++++++++++++++++-
 2 files changed, 92 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/net/mptcp/config b/tools/testing/selft=
ests/net/mptcp/config
index d36b7da5082a..38021a0dd527 100644
--- a/tools/testing/selftests/net/mptcp/config
+++ b/tools/testing/selftests/net/mptcp/config
@@ -12,6 +12,9 @@ CONFIG_NF_TABLES=3Dm
 CONFIG_NFT_COMPAT=3Dm
 CONFIG_NETFILTER_XTABLES=3Dm
 CONFIG_NETFILTER_XT_MATCH_BPF=3Dm
+CONFIG_NETFILTER_XT_MATCH_LENGTH=3Dm
+CONFIG_NETFILTER_XT_MATCH_STATISTIC=3Dm
+CONFIG_NETFILTER_XT_TARGET_MARK=3Dm
 CONFIG_NF_TABLES_INET=3Dy
 CONFIG_NFT_TPROXY=3Dm
 CONFIG_NFT_SOCKET=3Dm
@@ -19,3 +22,8 @@ CONFIG_IP_ADVANCED_ROUTER=3Dy
 CONFIG_IP_MULTIPLE_TABLES=3Dy
 CONFIG_IP_NF_TARGET_REJECT=3Dm
 CONFIG_IPV6_MULTIPLE_TABLES=3Dy
+CONFIG_NET_ACT_CSUM=3Dm
+CONFIG_NET_ACT_PEDIT=3Dm
+CONFIG_NET_CLS_ACT=3Dy
+CONFIG_NET_CLS_FW=3Dm
+CONFIG_NET_SCH_INGRESS=3Dm
diff --git a/tools/testing/selftests/net/mptcp/mptcp_join.sh b/tools/testin=
g/selftests/net/mptcp/mptcp_join.sh
index 21add441c08a..bfe2349794fc 100755
--- a/tools/testing/selftests/net/mptcp/mptcp_join.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_join.sh
@@ -17,6 +17,7 @@ capture=3D0
 checksum=3D0
 ip_mptcp=3D0
 check_invert=3D0
+validate_checksum=3D0
 do_all_tests=3D1
=20
 TEST_COUNT=3D0
@@ -62,6 +63,7 @@ init()
 	done
=20
 	check_invert=3D0
+	validate_checksum=3D$checksum
=20
 	#  ns1              ns2
 	# ns1eth1    ns2eth1
@@ -167,6 +169,58 @@ reset_with_allow_join_id0()
 	ip netns exec $ns2 sysctl -q net.mptcp.allow_join_initial_addr_port=3D$ns=
2_enable
 }
=20
+# Modify TCP payload without corrupting the TCP packet
+#
+# This rule inverts a 8-bit word at byte offset 148 for the 2nd TCP ACK pa=
ckets
+# carrying enough data.
+# Once it is done, the TCP Checksum field is updated so the packet is stil=
l
+# considered as valid at the TCP level.
+# Because the MPTCP checksum, covering the TCP options and data, has not b=
een
+# updated, the modification will be detected and an MP_FAIL will be emitte=
d:
+# what we want to validate here without corrupting "random" MPTCP options.
+#
+# To avoid having tc producing this pr_info() message for each TCP ACK pac=
kets
+# not carrying enough data:
+#
+#     tc action pedit offset 162 out of bounds
+#
+# Netfilter is used to mark packets with enough data.
+reset_with_fail()
+{
+	reset
+
+	ip netns exec $ns1 sysctl -q net.mptcp.checksum_enabled=3D1
+	ip netns exec $ns2 sysctl -q net.mptcp.checksum_enabled=3D1
+
+	check_invert=3D1
+	validate_checksum=3D1
+	local i=3D"$1"
+	local ip=3D"${2:-4}"
+	local tables
+
+	tables=3D"iptables"
+	if [ $ip -eq 6 ]; then
+		tables=3D"ip6tables"
+	fi
+
+	ip netns exec $ns2 $tables \
+		-t mangle \
+		-A OUTPUT \
+		-o ns2eth$i \
+		-p tcp \
+		-m length --length 150:9999 \
+		-m statistic --mode nth --packet 1 --every 99999 \
+		-j MARK --set-mark 42 || exit 1
+
+	tc -n $ns2 qdisc add dev ns2eth$i clsact || exit 1
+	tc -n $ns2 filter add dev ns2eth$i egress \
+		protocol ip prio 1000 \
+		handle 42 fw \
+		action pedit munge offset 148 u8 invert \
+		pipe csum tcp \
+		index 100 || exit 1
+}
+
 ip -Version > /dev/null 2>&1
 if [ $? -ne 0 ];then
 	echo "SKIP: Could not run test without ip tool"
@@ -920,7 +974,7 @@ chk_join_nr()
 		echo "[ ok ]"
 	fi
 	[ "${dump_stats}" =3D 1 ] && dump_stats
-	if [ $checksum -eq 1 ]; then
+	if [ $validate_checksum -eq 1 ]; then
 		chk_csum_nr "" $fail_nr
 		chk_fail_nr $fail_nr $fail_nr
 		chk_rst_nr $rst_nr $rst_nr
@@ -2239,6 +2293,29 @@ userspace_tests()
 	chk_rm_nr 0 0
 }
=20
+pedit_action_pkts()
+{
+	tc -n $ns2 -j -s action show action pedit index 100 | \
+		sed 's/.*"packets":\([0-9]\+\),.*/\1/'
+}
+
+fail_tests()
+{
+	# multiple subflows
+	reset_with_fail 2
+	tc -n $ns2 qdisc add dev ns2eth1 root netem rate 20mbit delay 1
+	pm_nl_set_limits $ns1 0 1
+	pm_nl_set_limits $ns2 0 1
+	pm_nl_add_endpoint $ns2 10.0.2.2 dev ns2eth2 flags subflow
+	run_tests $ns1 $ns2 10.0.1.1 1024
+	chk_join_nr "MP_FAIL MP_RST: $(pedit_action_pkts) corrupted pkts" 1 1 1 1=
 1
+
+	# single subflow
+	reset_with_fail 1
+	run_tests $ns1 $ns2 10.0.1.1 128
+	chk_join_nr "Infinite map: $(pedit_action_pkts) corrupted pkts" 0 0 0 1 0=
 1
+}
+
 all_tests()
 {
 	subflows_tests
@@ -2257,6 +2334,7 @@ all_tests()
 	deny_join_id0_tests
 	fullmesh_tests
 	userspace_tests
+	fail_tests
 }
=20
 usage()
@@ -2278,6 +2356,7 @@ usage()
 	echo "  -d deny_join_id0_tests"
 	echo "  -m fullmesh_tests"
 	echo "  -u userspace_tests"
+	echo "  -F fail_tests"
 	echo "  -c capture pcap files"
 	echo "  -C enable data checksum"
 	echo "  -i use ip mptcp"
@@ -2317,7 +2396,7 @@ if [ $do_all_tests -eq 1 ]; then
 	exit $ret
 fi
=20
-while getopts 'fesltra64bpkdmuchCSi' opt; do
+while getopts 'fesltra64bpkdmuchCSFi' opt; do
 	case $opt in
 		f)
 			subflows_tests
@@ -2367,6 +2446,9 @@ while getopts 'fesltra64bpkdmuchCSi' opt; do
 		u)
 			userspace_tests
 			;;
+		F)
+			fail_tests
+			;;
 		c)
 			;;
 		C)
--=20
2.34.1

