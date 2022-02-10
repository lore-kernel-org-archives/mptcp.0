Received: from de-smtp-delivery-102.mimecast.com (de-smtp-delivery-102.mimecast.com [194.104.111.102])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED8652C80
	for <mptcp@lists.linux.dev>; Thu, 10 Feb 2022 06:00:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=mimecast20200619;
	t=1644472857;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=yeDC2j1LKmvJEQ6MhzWNeMpDIgBoNr4KGkGYyk6xDx8=;
	b=fEA843Ydpt9M4wWwGtjG0APZsdQTd/K8JorHH7GmCxoOnpM4ttnS+Lz9tdvSZvizgqAx6T
	HXkpbPV1yOX/ljqiW0TiOBK1SDUcbjr/Y9vhQTMfUVfFlV+olJBFZok1XTUklkSum4MMqh
	cfVnR078nGUv3D3LBIVOH79Js3tozVU=
Received: from EUR02-AM5-obe.outbound.protection.outlook.com
 (mail-am5eur02lp2056.outbound.protection.outlook.com [104.47.4.56]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 de-mta-34-Cvmav_srPYWYe0vK0T9CuQ-1; Thu, 10 Feb 2022 07:00:56 +0100
X-MC-Unique: Cvmav_srPYWYe0vK0T9CuQ-1
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=W56HlOt5ovC54MqpjaSuWKVkXRbWGq8tyZI9Kay3SPjQS1p1GrWPi35ZID1DRsUKg4/daaXM0BoweYxBi76uukAlxHCHSyGqipajXnmCqlg7P10hx1A2OATX/1ED06exfroM1ZdiS7kBZtdMN5S81jVGi1LHQBBoA5b7IV0hXKeG84j3c/ORHvPO3gJ0myCk8uqX6giy0mg35Ocne7fUlTgVvFsZ/JHv2DkOHi8lV0TTICdH5tGUqXzLyTcSK6ni18lo6azYb5flwo8BCO8/BahuOIPN4MsQNNVs9ZDsJfooktXQV4NwXbQ/Z0AZznQUr+yWgy8EPQ1SeSrFSyEjWg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RBa/wSMk/wJR8qxDgPIl3t2SXvBXOy3VEypwLXO/dnE=;
 b=lOY6HwFxNZ7j4f1NH75RdJ8kug9RtNo4Q/5ATL1jowlbIOZFxchYSYYRBAXJU03y5f0BAF/Wu24VdsXAxctBCDzY59hyy5lXsMMPvd1UVxzGj27UOr+jYbVynvxTFOMERzbZbEFNfCmXsMJl3u4Buzsd0+p+mL+71zu+L0rHSLoVz60fh/ij8R6X3uC/z6nBqhnJLKaINBaa9ZsM3zTTfUq2J+4QfBz7J7Ot7NNV0+Kg9M+RSQCR6Y1q+/iH4ZMpOffbxFkB1mrfN22b2LvRyII0L9ve286wMj/BIXbppYBwGD0ufkSsfWqJbAB8cErlKBtfxiSrRkpaEBIlI+BYKA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from VI1PR0402MB3503.eurprd04.prod.outlook.com (2603:10a6:803:d::26)
 by AM0PR04MB5761.eurprd04.prod.outlook.com (2603:10a6:208:12e::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4951.19; Thu, 10 Feb
 2022 06:00:55 +0000
Received: from VI1PR0402MB3503.eurprd04.prod.outlook.com
 ([fe80::b823:3668:e8d8:beb]) by VI1PR0402MB3503.eurprd04.prod.outlook.com
 ([fe80::b823:3668:e8d8:beb%3]) with mapi id 15.20.4951.018; Thu, 10 Feb 2022
 06:00:55 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
CC: Geliang Tang <geliang.tang@suse.com>,
	Davide Caratti <dcaratti@redhat.com>,
	Matthieu Baerts <matthieu.baerts@tessares.net>
Subject: [PATCH mptcp-next v6 7/7] selftests: mptcp: add the MP_FAIL testcases
Date: Thu, 10 Feb 2022 14:00:31 +0800
Message-ID: <4ce97f8f882fcdab197d88cae88ce8ed714b8f32.1644466571.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1644466570.git.geliang.tang@suse.com>
References: <cover.1644466570.git.geliang.tang@suse.com>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-ClientProxiedBy: HK2PR04CA0048.apcprd04.prod.outlook.com
 (2603:1096:202:14::16) To VI1PR0402MB3503.eurprd04.prod.outlook.com
 (2603:10a6:803:d::26)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: a9f5f7f8-d807-46e6-2590-08d9ec5ab373
X-MS-TrafficTypeDiagnostic: AM0PR04MB5761:EE_
X-Microsoft-Antispam-PRVS:
	<AM0PR04MB5761B3E6B1C8E93B6F85712BF82F9@AM0PR04MB5761.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1247;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	4HUcMyweiim9w732/ou2wqMKLLmJnC0fGg3u0wGTB+B+weQ7lp3D6b10Fe6akVcQwb789okT4qHFWVkYHnaPcWLlkJ/VW0GD1/ezbJwqJU5npb2nAoFPU3g8uYjG1yKIdAGoU02VqT8tUEMr0VsPxRwIQhewNaSIs7nK5qzk3Cv0zJi0fXUVXqj1DLJOdf/Wrc1trKqKUZ1pIucG+sZbQXLqMOWCdDc4N63Sk9kIxIUxsFJjxppZHuUHm3a+6kQ/5wJxsyKIC9zEv6Fpe0PKIw0LZhf8UHCj6Bh/iOqaAIdGvExF0ykin6XoTFyN9oLZbSZT9ZTU9TYtRUJMOCEK2Zxi+8eThX5zzZrKrIFePaLVIel1ZoVZHs8p6u737b8LJf+np0kuDUAGysl9lqSX7TPGcu+P/Ppuz/peaAYXhfn52ElRoeFHAbZTdq2HhrU+7/w/HYZ3OOp3L5uyxH4BUPHYom+8HTYGWwOspvhEAYnZpLJxY0i6GIMrfKw9mjSMbf69JFMEQa4/WW3UPF8BaWtqBvm+3ODhOcNhVjuGCF6yN48DNP6AlSev/gSoyw0uGuXe41a/MP9LN6Sgh/AbhzQLyKyDjnOQx2+0qfIseFNhQYdWGAnwHsPp9an1JpFu2YG770lJfzKufReByimXYg==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR0402MB3503.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(83380400001)(316002)(36756003)(86362001)(55236004)(66946007)(6512007)(6916009)(54906003)(66476007)(66556008)(6506007)(8936002)(6666004)(8676002)(44832011)(4326008)(66574015)(2906002)(508600001)(2616005)(26005)(5660300002)(38100700002)(6486002)(186003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Mpg7WNmXn7RCDem2Hsj9mHPwsKM+Q6U5A2/W8WYAMW3hGdu3QtUSlnAlz0FH?=
 =?us-ascii?Q?1RTt6Pxg1eEkwcVdIP6eVu44E0jbIRJQWstCZy7FJ7E87Xi/RNHvsBPSN2nq?=
 =?us-ascii?Q?XfhZ8cNueVZHvgubSZlse4IKBb56W3FpRlNv1WxAFUPB+W5Y+SxsKe6WM/Yj?=
 =?us-ascii?Q?b0jBbc3URrousi38JIaE3ylt6R6A7z9Yi2iY7ZKvihZNduqhHadFtuerABWe?=
 =?us-ascii?Q?legCbNtsNH0zbv+iUK0rIXk+iQNGW+ttciGUiz0wz0R3mOt+2kBYD4kDvWKH?=
 =?us-ascii?Q?3uR3aeztl/zJtx1+jvOVXzbUoifZSeKHcWLRC1Opcq+4R3SmJamrjCyZfL08?=
 =?us-ascii?Q?R7mRlET9wY82q4kSJ1jwkwrEi1RccWSZwQmHzf+2jL4t5LQMyXHDGssII9gG?=
 =?us-ascii?Q?t6IDx5W8UZgPzNGGEa5+10/3bzvE8YDNV3Q29IeSH9ebCSCz9Vhv/s1hzxTR?=
 =?us-ascii?Q?dXX6fTSapgKq4CR8EAs51fNUkqtEw4eUSxPUrCGvHSh74Ul2pnMvHMc7h6xn?=
 =?us-ascii?Q?SMq3/TYTXGODRZiqeItzrWuXA2sI3G8WhhpRtL832/6IqRjFYL2vmup0H4+A?=
 =?us-ascii?Q?6KtjGh/+cJ5jeTSGoS4zf96p47PH7kVvloTvUG2Rd3Wv4Gh4jqu/y1StEpJ+?=
 =?us-ascii?Q?Scf3hfazDZwh61nY5hNdDw7Ys2tJ0CW55/EICZojaGl4fuUSFMppAv47K7UU?=
 =?us-ascii?Q?K3/lpwgbKqJz8/9KXAGw7BNygR1aZFAHiYx1U9nCqCdqzfacZPW10ie7PkuK?=
 =?us-ascii?Q?zDNHNKqWKgPEqr5ciaFKo/jLQSpcxqoX4Bv29kSClJfq1ZSy6n+QPnsbj226?=
 =?us-ascii?Q?QLQbxNFtxOT4uSP78Vls81MYaqu18VKc1J82WiiS9huOVS4fo1MBFXWU2197?=
 =?us-ascii?Q?uI4FT1JVoyLaa0CXq8PsClb6yFCodsOU5hm/C2pDjFLAi8yzGw5frW/HE4Kk?=
 =?us-ascii?Q?C6lOI7YM+bStYwss0yJQzUosE+D+Bl5DZEBcPCkirsigKSGqr4dZLcB/jVhc?=
 =?us-ascii?Q?809Nsr3DpBggBgNRX2a6fJM37ca8Ya6+cNhlPSJhiTl0tt8u7zSVma206PUt?=
 =?us-ascii?Q?n4b6eEGZ4Ln2RTLfJvvgWfUMPbdZGuwg/MKnIooLI3G2zIzFD1Y6q+sSAkkj?=
 =?us-ascii?Q?DlQGoWiiTDxnmJvBw32Ly5hML2xCRgm2fVdQznst+eFze29ccaQvuKK8u6Zb?=
 =?us-ascii?Q?7VzaWJAd+q7WfPPptRcJvJwUjsM4HJTPE7oq08d3h3soLl1ST16dcdKmtoDK?=
 =?us-ascii?Q?d+De7+0aUAWNpXa+nHtMt5e/FsAMgd3oPuQUm+MQb6+8lZOsnnmvZuJkjsZy?=
 =?us-ascii?Q?h3/tzgv8mYMYvhO7Hgurpm0AK63+HWLmdjJq7T5ayP+NC7QvfbxjEtdDXiyk?=
 =?us-ascii?Q?DAU4eeCa6mW5pMI/LlGhsE6vU3dUZZFfXuRWg9WlyqD28j8rTE6o12/UAWfE?=
 =?us-ascii?Q?FQtaNEIOBlxqp53ctsC54Rh66Bmz3vua+x8LyPZ7rFu9Ov4mWZ5aHYUIpodk?=
 =?us-ascii?Q?zdE31P2j5JZgYM2Ne2Vo5s+FzeO+tw1sSFj4L1qIDytYonDCOFrFG2DBNxtM?=
 =?us-ascii?Q?gBVBhgz/nYaIYZiHc7Xs7ZKHGhUSJTkDnZXmDdPVLbhjpJlpFIiXYKqP/0Gf?=
 =?us-ascii?Q?9ZnFF5YmJLgBcB0N30grUSI=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a9f5f7f8-d807-46e6-2590-08d9ec5ab373
X-MS-Exchange-CrossTenant-AuthSource: VI1PR0402MB3503.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Feb 2022 06:00:55.4327
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: uNClNoe3SRSa5H4HW0+cxhi4pPx2ceT+zJnB1FtDIqhr2OSfz5cp/USX0hsOrVbocrNgne2DbYhu8zMU6Lw+rQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB5761

Added the test cases for MP_FAIL, the multiple subflows test for the MP_RST
case and the single subflow one for the infinite mapping case.

The multiple subflows test used the test_linkfail value to make 1024KB test
files, and the single subflow test 128KB.

Added a new function reset_with_fail(), in it use 'iptables' and 'tc
action pedit' ruless to produce the bit flips to trigger the checksum
failures.

Added a new function pedit_action_pkts() to get the numbers of the
packets edited by the tc pedit action.

Added a new global variable validate_checksum to enable checksums for
the MP_FAIL tests without passing the '-C' argument.

If the tc rules didn't produce the bit flips in the multiple subflows
test, retry the test three times.

Also added the tests needed kernel configures in the config file.

Suggested-by: Davide Caratti <dcaratti@redhat.com>
Co-developed-by: Matthieu Baerts <matthieu.baerts@tessares.net>
Signed-off-by: Matthieu Baerts <matthieu.baerts@tessares.net>
Signed-off-by: Geliang Tang <geliang.tang@suse.com>
---
 tools/testing/selftests/net/mptcp/config      |  8 ++
 .../testing/selftests/net/mptcp/mptcp_join.sh | 94 ++++++++++++++++++-
 2 files changed, 100 insertions(+), 2 deletions(-)

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
index 50a7f9a9b364..3bb9ec44ed24 100755
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
@@ -909,7 +963,7 @@ chk_join_nr()
 		echo "[ ok ]"
 	fi
 	[ "${dump_stats}" =3D 1 ] && dump_stats
-	if [ $checksum -eq 1 ]; then
+	if [ $validate_checksum -eq 1 ]; then
 		chk_csum_nr "" $fail_nr
 		chk_fail_nr $fail_nr $fail_nr
 		chk_rst_nr $rst_nr $rst_nr
@@ -2218,6 +2272,37 @@ userspace_tests()
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
+	# If the tc rules didn't produce the bit flips, retry three times.
+	for n in `seq 1 3`; do
+		reset_with_fail 2
+		pm_nl_set_limits $ns1 0 2
+		pm_nl_set_limits $ns2 0 2
+		pm_nl_add_endpoint $ns2 10.0.2.2 dev ns2eth2 flags subflow
+		pm_nl_add_endpoint $ns2 10.0.3.2 dev ns2eth3 flags subflow
+		run_tests $ns1 $ns2 10.0.1.1 1024
+		if [ $(pedit_action_pkts) -gt 0 ]; then
+			break
+		else
+			printf "%03u %s\n" "$TEST_COUNT" "MP_FAIL MP_RST: retry $n"
+		fi
+	done
+	chk_join_nr "MP_FAIL MP_RST: $(pedit_action_pkts) corrupted pkts" 2 2 2 1=
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
@@ -2236,6 +2321,7 @@ all_tests()
 	deny_join_id0_tests
 	fullmesh_tests
 	userspace_tests
+	fail_tests
 }
=20
 usage()
@@ -2257,6 +2343,7 @@ usage()
 	echo "  -d deny_join_id0_tests"
 	echo "  -m fullmesh_tests"
 	echo "  -u userspace_tests"
+	echo "  -F fail_tests"
 	echo "  -c capture pcap files"
 	echo "  -C enable data checksum"
 	echo "  -i use ip mptcp"
@@ -2296,7 +2383,7 @@ if [ $do_all_tests -eq 1 ]; then
 	exit $ret
 fi
=20
-while getopts 'fesltra64bpkdmuchCSi' opt; do
+while getopts 'fesltra64bpkdmuchCSFi' opt; do
 	case $opt in
 		f)
 			subflows_tests
@@ -2346,6 +2433,9 @@ while getopts 'fesltra64bpkdmuchCSi' opt; do
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

