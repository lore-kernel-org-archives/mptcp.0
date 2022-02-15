Received: from de-smtp-delivery-102.mimecast.com (de-smtp-delivery-102.mimecast.com [194.104.109.102])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC2A41388
	for <mptcp@lists.linux.dev>; Tue, 15 Feb 2022 11:26:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=mimecast20200619;
	t=1644924364;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=MDVWPNtUiykpNbbMCAyoYCMROZ1bzsT6qjNBDyxOJHI=;
	b=nCJzUZ4cZ6q03rOxm6gRK4vEW9FsPznLt/1Eb6+bNO2PimXm0jE4lvSzae5wdPO/SYrltx
	mFplxSoQGZOmVEBx8n6mSuvHZSNqcnscEsttk6WFKUNfr+CpBaiPIK3v/x+jmRyiedYEvH
	W0JSv/CunZNz1WgdjzafkWr/GU33LVA=
Received: from EUR05-AM6-obe.outbound.protection.outlook.com
 (mail-am6eur05lp2113.outbound.protection.outlook.com [104.47.18.113]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 de-mta-31-EDuCQhyUN4S_GiIaj9Jouw-1; Tue, 15 Feb 2022 12:26:03 +0100
X-MC-Unique: EDuCQhyUN4S_GiIaj9Jouw-1
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=T8OJlek8wIXEIwWWUKo3pIaLCj8QjJjLR8EstMf85U0GOpOZPxWxoezv+wUlyxNt8/oBmkC992ZaCKJllM51MBBd4/WCHGB8FwPrrat7PUSNlsxOt1p9/8KjMpdJZxv393yAviITsMmKlTsAOcehgzudVXET53BWOp8+H3S0LVgUrmNGseCfofmGWkHPlchTMY3LsrIaP6Cv/ZCaIFCewJK1HoaVloD2xllpoh4LoSQR14i5Olt5DCUjOFV1NuSbPV3Da3QK97UlnUT+Ab/2b7ssKGct4qsy+3IMbjg3A8ued2bcbNqtwKDPggWA94kC3KCkRoiPyL5W3ytWaVTrAw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8zuGtsjNMcjEzNXciFtdNloPhqtHCsKS3u0oqt+1Va0=;
 b=JNOaar5zb4oPFfv65gShB8Ld0zpDbpt2RruqchGfaHgYhRJ3woBcsU8VM4OjBlej4dk0IpSUZ28osEOobZICfvCy24HreTTJR+sK3BYVoPWZQvt+wfx39otXKRk4RNlbnzTSUY/+SDvCfPxzWslHGlcbR+jPv96tXAYt0aGIbWqQQWhznuJ0hYM5zMCBhMSU/QdCJ3br2lTpdU0LJo5f1t9bCDlKE4jVkXa+gG/3e2Hoa6/2ZWKHafWKVpYTbznGzOUNFj0NMJ5On/Vz4b+ULuvL50OjHlmDrYpm4tQ08x0a2bhDMV3hvSKsU+odNwKrlu/y3pNczSv5zZj0Btx1yg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by AM0PR04MB4563.eurprd04.prod.outlook.com (2603:10a6:208:6b::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4975.19; Tue, 15 Feb
 2022 11:26:02 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::60de:f804:3830:f7c5]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::60de:f804:3830:f7c5%4]) with mapi id 15.20.4951.019; Tue, 15 Feb 2022
 11:26:02 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
CC: Geliang Tang <geliang.tang@suse.com>,
	Davide Caratti <dcaratti@redhat.com>,
	Matthieu Baerts <matthieu.baerts@tessares.net>
Subject: [PATCH mptcp-next v8 5/5] selftests: mptcp: add the MP_FAIL testcases
Date: Tue, 15 Feb 2022 19:25:54 +0800
Message-ID: <c5e395c15e7dc21edb156b0985b9afbd8a550175.1644923833.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1644923833.git.geliang.tang@suse.com>
References: <cover.1644923833.git.geliang.tang@suse.com>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-ClientProxiedBy: HK2PR02CA0146.apcprd02.prod.outlook.com
 (2603:1096:202:16::30) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 14d0a006-76f1-4337-7777-08d9f075f265
X-MS-TrafficTypeDiagnostic: AM0PR04MB4563:EE_
X-Microsoft-Antispam-PRVS:
	<AM0PR04MB45633CA2434293A0127106E2F8349@AM0PR04MB4563.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7219;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	Hkgo1hIRxTfOFO5qwYaBm0bwDW1xdRMSliYbGDebXfbf+0t5KJdraUFWj2YQdygLxjVKOswFSxfC61md6YzLnj3XfTvrCzkra0n4ZKshcnCHWFVTBxozN1Es9tORPc7QfwNWMHGqzEdoyo/ZbqdND69g3PSLrRDjYtklSXY1Ee929xgoY3oHae8sn0xJG7rSeqc2KLHvrL5+Y+C5r/EVTP0fSRcJoy/V5BDM2W+i8NeyYSvm/2T+Pf/bRjV9HLpecEpSVAStpj1fj9d/YYuqNa2HZUu5wrqkFyjn0t+5JczfRKk5798o4e/3VOUbp4/8uQXVDD0vAmch9S2yIQw2+tQ+BU45WJ3CrGitgm9RHItzK3GcfaOoRI+aZxyLtX2NrIaYyJO9nhBmET1cjUm1qmhulYSqrSwP0V3kZy5+9p5izenKSE/zLp+utqURlpWkiPcUWF8eBEZP9vElBjOVLnrOdW2Jt291YzmX2cv5446PpmNg6u7L9MPVV77oQYQMKNlYFXnksilINBdyHDB5Z5oSup+6zSpfCzgL8xE5mnYz4d4eTzCnmaGwqPOupHqbv8PJk4/Va/0fhVmLFnrkE+i6q5hqfWx/k6iI1D9hxCaumhmt9gwARyJlodz3FQhhsaW7WAvwSW0b86uEFUF7Rg==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(8676002)(4326008)(66476007)(66556008)(66574015)(83380400001)(6512007)(86362001)(66946007)(36756003)(8936002)(55236004)(508600001)(2616005)(5660300002)(6486002)(6916009)(6506007)(316002)(54906003)(26005)(186003)(2906002)(38100700002)(6666004)(44832011);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?anAW7dKVbaEn09telDlhnPW/ONtvv7A/9x2Q7yvpAP/6sd2dUXxcY2Y2jFGX?=
 =?us-ascii?Q?M7rZqJCOtjS3AhJjjJ31vgzfAjEZEINJr9P78dodSUJNlh8hEOXG3pgomvrz?=
 =?us-ascii?Q?q6WMIzrjiDJYRDrorwl2y1aSNe5XQCwFMwcxezFG/pV0BbgaiVnXKKFmwsKw?=
 =?us-ascii?Q?yxg/kiR3HBJbHQxOAcEuWRykGhYlU3TEuywqImMqPFky4AtfLwMFEtl5/Rem?=
 =?us-ascii?Q?xEpgjDPri4U+38pBgFXyMQXyvyK4RIqa4HQlJg5vHjkD0DDQZW1V1yGmjWk4?=
 =?us-ascii?Q?YWB/Vc6gj7KaYTIfFManF5DZGq2oZQU2/XBEpylCOv2uunI+TL9HTiWhcBM5?=
 =?us-ascii?Q?BSUV4op69BLvhVg+h4CuPCFO7KV9n4LRpDoo1EYy3zLfcrdSbWMh65yCF5Li?=
 =?us-ascii?Q?m2N+o3E+mYFt464Tv2TTk6k48nUYAna7+KhcsMSeheCZ6ZTAWlE0uz1YM+uB?=
 =?us-ascii?Q?YaaUm3HpocdyUBp0p3Y6fUUNYNjHi6zf0Y7jD8h+LeCLEWVvN9cW3gBviHhr?=
 =?us-ascii?Q?7qkH5Dq2TRdzSuSah94ya0qSKhvhXTFm5v45PE4cmPxy2a2P8zPSP6+nasyw?=
 =?us-ascii?Q?BCApakcZCwy/x4TOCblgefBy+6r6ymHUG/IMIJFiD9x19Zzj19cmzCuO7/++?=
 =?us-ascii?Q?XOAWwJdzmzJw1wjIjBsCpeX4XlJ2d0bKxQZekpnistaafluZdFwTZ6QBiEL+?=
 =?us-ascii?Q?eZ8SU7uVdfycimt5ywK/V2tHe5XzdYHhcUO88g3ujkbPy/iQa1jY/ErMqOWg?=
 =?us-ascii?Q?0neIxG0JRd72sUEyBfZDOzsSG0swm0/hPSrdBk/aqRKtzLP7ODTGkb7xGQzQ?=
 =?us-ascii?Q?WQef1FyUfgtVwNsrpbt1q6yD0OyT3OVAm6mS6l20i+WAaIFiWgw8jdTZE2Kv?=
 =?us-ascii?Q?TgsvutSEU+uxzhv3MZsPx/C8LpK3yPCeaRrM5cAVqrdSyNTo9XZpgYukmi7/?=
 =?us-ascii?Q?V5xFn0RCia6zi6v47578nO1nu+gMVFWLBAC1EmU4uW79ntdPm0YaSwTab28r?=
 =?us-ascii?Q?pf4BGoEDFOiY+BC6x3JHWiIApy4dYjN5meoikWaNZIYELKsv1UziCHFYu8Pi?=
 =?us-ascii?Q?xuIZrLd5Q+EtCvv4rfyAsO6rRVERNfEzlbqnwQMaiUHo571feSgCJDMtDX5w?=
 =?us-ascii?Q?SwGgzT9XQU3h/tlvkN4lsjmTMJnDot1bTopB8G4sDd4f+jPgV3qC8LJu+cCw?=
 =?us-ascii?Q?bmDJEG/CYNpeNUEhsyeBvWFiL46Bh9URSa8cP3jSWz8pMail2Yybm2+sajZb?=
 =?us-ascii?Q?2jwQPrIUk2r/1EalPAYPvMLDxov6OG6xz/qicl8vbYh7Vyn6BJu2ZKITxRew?=
 =?us-ascii?Q?u4jnZJA8LXZD+dkvjJUkg4sKmwNmImsSTRNlotPwiNcNwkY2zDZJduJdYKVp?=
 =?us-ascii?Q?ejMuhQdSxUMvkdep1uiF3tTosyLhR+Iu/gOHx+3VcjF20uu0zxjL6/OHbNS6?=
 =?us-ascii?Q?T7WSyXfPrWHweHmQa6wOf8iKXS28firT7YbzR4som66H9z7MNESGlAkizwfy?=
 =?us-ascii?Q?h/S0Q7aVZOFnw02wgRIuNkhAYGNhE2FyxRHjh4MYDHAIpEC/MVnT3iXeTeCf?=
 =?us-ascii?Q?SXIRD0zo41UAvbO4nGM0YBIHicETyrjkLB3xvx46IszEQwBx8w/DsbYkihdT?=
 =?us-ascii?Q?7qoF765OzOsifG56O4ByZhY=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 14d0a006-76f1-4337-7777-08d9f075f265
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Feb 2022 11:26:02.0867
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: x5iX8AKUp1NcC314xq1lnQld8eM1VqIXi2jCCdmHOl+vZ2NYdwSc0eRn+Rl9uvd9mnKMnEZPjeRzEjImLR2aRw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB4563

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

Also added the needed kernel configures in the selftests config file.

Suggested-by: Davide Caratti <dcaratti@redhat.com>
Co-developed-by: Matthieu Baerts <matthieu.baerts@tessares.net>
Signed-off-by: Matthieu Baerts <matthieu.baerts@tessares.net>
Signed-off-by: Geliang Tang <geliang.tang@suse.com>
---
 tools/testing/selftests/net/mptcp/config      |  8 ++
 .../testing/selftests/net/mptcp/mptcp_join.sh | 98 ++++++++++++++++++-
 2 files changed, 104 insertions(+), 2 deletions(-)

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
index 26829fbbc67c..f00b1ae835a9 100755
--- a/tools/testing/selftests/net/mptcp/mptcp_join.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_join.sh
@@ -16,6 +16,7 @@ capture=3D0
 checksum=3D0
 ip_mptcp=3D0
 check_invert=3D0
+validate_checksum=3D0
 do_all_tests=3D1
 init=3D0
=20
@@ -62,6 +63,7 @@ init_partial()
 	done
=20
 	check_invert=3D0
+	validate_checksum=3D$checksum
=20
 	#  ns1              ns2
 	# ns1eth1    ns2eth1
@@ -207,6 +209,58 @@ reset_with_allow_join_id0()
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
 print_file_err()
 {
 	ls -l "$1" 1>&2
@@ -1028,7 +1082,7 @@ chk_join_nr()
 		echo "[ ok ]"
 	fi
 	[ "${dump_stats}" =3D 1 ] && dump_stats
-	if [ $checksum -eq 1 ]; then
+	if [ $validate_checksum -eq 1 ]; then
 		chk_csum_nr "" $csum_ns1 $csum_ns2
 		chk_fail_nr $fail_nr $fail_nr
 		chk_rst_nr $rst_nr $rst_nr
@@ -2362,6 +2416,41 @@ fastclose_tests()
 	chk_rst_nr 2 2 invert
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
+	chk_join_nr "MP_FAIL MP_RST: $(pedit_action_pkts) corrupted pkts" 1 1 1 \
+									  +1 +0 \
+									  1 \
+									  1
+
+	# single subflow
+	reset_with_fail 1
+	run_tests $ns1 $ns2 10.0.1.1 128
+									# syn_nr syn_ack_nr ack_nr
+									# csum_ns1 csum_ns2
+									# fail_nr
+									# rst_nr
+									# infi_nr
+	chk_join_nr "Infinite map: $(pedit_action_pkts) corrupted pkts" 0 0 0 \
+									+1 +0 \
+									1 \
+									0 \
+									1
+}
+
 all_tests()
 {
 	subflows_tests
@@ -2381,6 +2470,7 @@ all_tests()
 	fullmesh_tests
 	userspace_tests
 	fastclose_tests
+	fail_tests
 }
=20
 # [$1: error message]
@@ -2409,6 +2499,7 @@ usage()
 	echo "  -m fullmesh_tests"
 	echo "  -u userspace_tests"
 	echo "  -z fastclose_tests"
+	echo "  -F fail_tests"
 	echo "  -c capture pcap files"
 	echo "  -C enable data checksum"
 	echo "  -i use ip mptcp"
@@ -2440,7 +2531,7 @@ if [ $do_all_tests -eq 1 ]; then
 	exit $ret
 fi
=20
-while getopts 'fesltra64bpkdmuchzCSi' opt; do
+while getopts 'fesltra64bpkdmuchzCSFi' opt; do
 	case $opt in
 		f)
 			subflows_tests
@@ -2493,6 +2584,9 @@ while getopts 'fesltra64bpkdmuchzCSi' opt; do
 		z)
 			fastclose_tests
 			;;
+		F)
+			fail_tests
+			;;
 		c)
 			;;
 		C)
--=20
2.34.1

