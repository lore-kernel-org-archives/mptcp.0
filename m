Received: from de-smtp-delivery-102.mimecast.com (de-smtp-delivery-102.mimecast.com [194.104.111.102])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1267180
	for <mptcp@lists.linux.dev>; Sun, 20 Feb 2022 03:00:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=mimecast20200619;
	t=1645326034;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=wJ56PYOxCQQHdk2Vc2PM4dX//ecB4QJmqINqA/XlOJ4=;
	b=dq2xJN/5xNwwOeUE3ZxmdSR9fIgsDdQuIP/jr2v+3tQ+ZwSq8L/9fv9qkajT01nR8/m7wE
	tmqiLgKLI58j3fFB1htclhyJ0A+o/yqVAo0XMXEJHC7WlmsqjvtUvanEu4ffbzcCgzG4oS
	BgGiObVhCZENdLrFtKNFzG92piaBqQs=
Received: from EUR02-HE1-obe.outbound.protection.outlook.com
 (mail-he1eur02lp2052.outbound.protection.outlook.com [104.47.5.52]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 de-mta-12-9Ix8_SEiMb28oUxr_HvRlA-1; Sun, 20 Feb 2022 04:00:33 +0100
X-MC-Unique: 9Ix8_SEiMb28oUxr_HvRlA-1
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GmYPDYV0sBRJgwhR+kmRoMGhqZlNcvlTOYaOZU3HBSnNpIbpU5j1aUYMw+VmZv40tynSWpyAgcTDSfUcAOXZlnsWeRxDqCOSVRbUOC0ljw2bVJCVO3+lZ1fbGbw3z0fXg1xotGcsUTKftpJgDGKU5o5PcHtEAKeZeRFiVP2d3c0jYleXrFvmo4i5Bn1n1fe/w4QypYZPvvU+s2KIjih19k6Ha6vAFMEvV6FROSOdH1O+YbdT06Grdefwo+r0OLy+FfLSPT40NtK38737pLxrJzNhmmoqOuu0TZfA63yQntlMymqc2QPtEjMYZ7UD9YD4lKkRyp8i1xBwq7qPmIvCmA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+z0fMgpOxW0+ManWxJ7xy1bfqivg+k7dPNaCWZTE5v4=;
 b=kMD6h4G1FUew6fvLo1qgOnu1OPFJOTx440nJpCGvNELYCdJ2NTgnyHDifdPAULLJd8jz6zwbXeOXXlC3QhkUduxfKM+4x+F6zS0YKYrR2f863VB+6GJRm2PA1BIsZhAA0pdWoi/bfaU3vGk75Ez0wcQihVCW3PiAeg+tpvgx61c/YIYz7SMMA/CLKq8gN6ogb+qk1f5E+t8nXVNWqVsJUuVdwb7QnsEikkOy+GsDRuyo18M/fdNO0e7JElWU58QCW0Hflu6GQeahhiZyDSDvTdi9QKsWz66yWipq9oTehYxNkY42c5o8h9Wq0R0vF0TFHxUxLVer8h8UTk2qhPogag==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by AM6PR0402MB3414.eurprd04.prod.outlook.com (2603:10a6:209:3::30) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4995.26; Sun, 20 Feb
 2022 03:00:31 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::60de:f804:3830:f7c5]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::60de:f804:3830:f7c5%4]) with mapi id 15.20.4951.019; Sun, 20 Feb 2022
 03:00:31 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
CC: Geliang Tang <geliang.tang@suse.com>,
	Davide Caratti <dcaratti@redhat.com>,
	Matthieu Baerts <matthieu.baerts@tessares.net>,
	Mat Martineau <mathew.j.martineau@linux.intel.com>
Subject: [PATCH RESEND mptcp-next v2 11/12] selftests: mptcp: add the MP_FAIL testcases
Date: Sun, 20 Feb 2022 10:59:37 +0800
Message-ID: <35a070276d4d81aad0c1c116a13740a99d9eb2d2.1645325178.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1645325178.git.geliang.tang@suse.com>
References: <cover.1645325178.git.geliang.tang@suse.com>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-ClientProxiedBy: HK2PR0302CA0020.apcprd03.prod.outlook.com
 (2603:1096:202::30) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 5f8b1659-7997-4c2c-4712-08d9f41d2834
X-MS-TrafficTypeDiagnostic: AM6PR0402MB3414:EE_
X-Microsoft-Antispam-PRVS:
	<AM6PR0402MB3414625B15AFB829C51B8A54F8399@AM6PR0402MB3414.eurprd04.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	IVO9NV7YWB+XCHwEa95n344dKkOJvRquPq4N95J0U/XuItXpCnsusgSquGY3aZEfRxM/9ZfWHr3B9sA4RZu/tZPnctY2v49x4y6E3ZFAnvQo15ImTABFgEDP6/0J/VZhW8o4Dqzf3dbC4BzNkC5TrwmtjlYV+DbCGu0t0pPZX1/dXLKvZHHyAOyLHBPGWV/QlVEEmPXBJfdrUrG9aYMqZR+gqmLE4zzxy5hLLskAA1nOxLZQjjYTRin/oM4yvTrtLeEAGnvjcP1CRkYnc3af2UmFeBU7/bMfjXRWFr+rmW75EGjYz+Ww6pqf4PgvGJcUEcqvDncMuKlyReb+b7+qSWJXVjb6AYCnr337tLvseAg7LE1WjCeTTe8N1av8HpzxNSr1XKNBKm3OgmULrgLC8lQp9VcvbEBo4ZVdGC685UQ3xIHjyXn6zQ5MqxKYPomUm+xJwrVbiEEWuwFV3dIGO/Zme6XVrs+PD6mujJDaBaBiEOIbqAZVOvm0d276Q3C3Fi+vnMbPnni7lPFpeZWo5CA8JDxBKpbjYc3BFWKih0GSmeqVtXqtvWdHYBECewE86nwr9X4auuthTWfb0XzEPePekaS7+WOHc0Du5ospB4JJN0lhUhQozo3G5uf+7TQ1NwImbhTL9PzNb+q4uWN8pQ==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(186003)(66574015)(38100700002)(2616005)(36756003)(2906002)(5660300002)(44832011)(8936002)(6486002)(508600001)(66946007)(4326008)(66476007)(66556008)(8676002)(6506007)(6512007)(83380400001)(86362001)(316002)(54906003)(6916009);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Oonv3uAHewxMbHk7YrupBH52h7Yriy7eaiMqJVOZ3+tTej7gZMDFX6J7eP2g?=
 =?us-ascii?Q?W2cSE2gRYZkmZbW809RWdNmaI+Lx9sIc9F4/AivOGengoPjFO54FfG2Z794r?=
 =?us-ascii?Q?X5BVF+3y+psD3qXtOBYzbGmFfPwGMZ7nycHcScSkHLMpRfoFq89iZtOxeEK0?=
 =?us-ascii?Q?GL1LUtrek8AVyJQkd1q/70gVEy64QeuSbqq7D7cr3MxmUGjjUJuxEjiLvDTO?=
 =?us-ascii?Q?Jn4684kHxIvhUQ9ZxW9gYeAM3Oazfw0rFSs2X7cXUIVwMlSsu2v6HR+SaMBi?=
 =?us-ascii?Q?Zo8puzsS2fba7QNKem31mAI0Ktz0cU+HZKrcrTqI6Gf5hSl/zIIU69ZM/Wxh?=
 =?us-ascii?Q?gzaQhxGXvbAaONwMVm+Kqcy+uQApW8rUIJoowNjPeTNUzsw/1ZaMDO5uTJRN?=
 =?us-ascii?Q?BBVrQ63bqcI1SOBtkFgjLMwboLFMmMQluHTYcMfK41OgJyr81peEwZ9FNWJL?=
 =?us-ascii?Q?aG8gBIa2BU4+vp7t9O7+49MRhbdKQro8euPfWNkHsMQc+JWEasUye5NSwI0O?=
 =?us-ascii?Q?vWt4L8jrw99f9ZfE5x1Cj5+SaNw3br/eKo6BWGta0bHO4FX8fb2m67NCPkqq?=
 =?us-ascii?Q?d7J+T/5+BYTaqI2mAIXnQOGEHLYzu9fsfZuHqGgyhavc0K6PRVX4AtQHePF5?=
 =?us-ascii?Q?FVG98x5UiPpHphD2JDJorQY7eSXc/Mkjvu4oiVQWA1JyltqClqsPE8sA7Jvn?=
 =?us-ascii?Q?t96EivB1FtdDS6FIRx/gUIWo57KQrVuDsyUYWdsU1I5O/ivqcDlElA8QuuIL?=
 =?us-ascii?Q?4DC2KzwQS9pRpBRKFHo53OFDtPPZZhuHJXCLwul7l5XOvLcW0cFEqOopm0Bi?=
 =?us-ascii?Q?oqPl/gp38pwTCb1cJSGeeLULyGHQI1AooApjl8LYzIfYSZiDhs1ldNcRiovv?=
 =?us-ascii?Q?3jOhAofcRTJEltqc7nmExDv+rXebJlQxCU/RpjdPdvB7oU7pe/EDO4lpT43E?=
 =?us-ascii?Q?OKPklGKWSDKgtsHjdlYoAGvyBt6y+8lTsyi20p6QZHcJb3G9jHfaJDXnOHRX?=
 =?us-ascii?Q?AY5wxoiwdkfZxsM2PPwgv4lxuPUFqtEB6nMuPX2O7WVgz64Fp7zWNoAuKmFI?=
 =?us-ascii?Q?v7Fz+yNKUIgjKfxbh5oHZf23pggqnvG4k5W1M2bYxKXMP9CRKdxvUpaBDmxb?=
 =?us-ascii?Q?GS8oy2uQD0tw07G/pliTK4jiGmPN0y7fmvd35p5P2IPhJQbzc8rH3nHN3Dhs?=
 =?us-ascii?Q?ItXzPDVdbRQSf89ytH94yuR5gLoRcQoTSPSosc+zZoJl/m1flXLYIfJH9lOl?=
 =?us-ascii?Q?jIwMQmRXu+XqieYsQjwIekUcpVsraqS4InDwtRCoZK0UD+zIn3ii2ZqzPoD2?=
 =?us-ascii?Q?Lm4aE8T/Ar+vsTPmJb7ZXGFJ6Xz1uz6zZr8ize3aXajzMzymiTIMpbJhCUQl?=
 =?us-ascii?Q?GTHqX+MD2eDWA3UTFIgDlL0c1CxHyY27GyVxLyQ/Iwz4nZmFFbax9f7FrMtt?=
 =?us-ascii?Q?QG38T1IJaapIVqt3vs2wbtQ3AwhKJpT435F5c1jsmEwMAIITii4tq6ERHLl0?=
 =?us-ascii?Q?+AMN+IDG84vEvIl67gNhEX9JhxxTSN+GiRiYcB6hVj5jQQ4daDF43boaggeV?=
 =?us-ascii?Q?Nmx476uzplg1VoLIZuVAfmnLNEyIBIJBOHShb9zgDfeBu2DWOYK4KFeOZI19?=
 =?us-ascii?Q?AbC+t+y9E/SiS+cvbhlEUE0bEDsrAefgsdBJc9GxrVVlBKzkSlfQ8dt/SJs+?=
 =?us-ascii?Q?3scMw8M4kuRU4swFDnRPoic/NC4=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5f8b1659-7997-4c2c-4712-08d9f41d2834
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Feb 2022 03:00:31.8504
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: yAtWcMbw38dMn+5kqNwpLISaEhUI0Ovj/vnGn6/kqSye2Zp9S2CXwoJq31eAkLYZxm1D5pJB4Mk4u+B3BCgxtQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR0402MB3414

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
Reviewed-by: Mat Martineau <mathew.j.martineau@linux.intel.com>
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
index f33822b28058..6fb883971d46 100755
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
@@ -1079,7 +1133,7 @@ chk_join_nr()
 		echo "[ ok ]"
 	fi
 	[ "${dump_stats}" =3D 1 ] && dump_stats
-	if [ $checksum -eq 1 ]; then
+	if [ $validate_checksum -eq 1 ]; then
 		chk_csum_nr "" $csum_ns1 $csum_ns2
 		chk_fail_nr $fail_nr $fail_nr
 		chk_rst_nr $rst_nr $rst_nr
@@ -2444,6 +2498,41 @@ fastclose_tests()
 	chk_rst_nr 1 1 invert
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
@@ -2464,6 +2553,7 @@ all_tests()
 	userspace_tests
 	implicit_tests
 	fastclose_tests
+	fail_tests
 }
=20
 # [$1: error message]
@@ -2493,6 +2583,7 @@ usage()
 	echo "  -u userspace_tests"
 	echo "  -I implicit_tests"
 	echo "  -z fastclose_tests"
+	echo "  -F fail_tests"
 	echo "  -c capture pcap files"
 	echo "  -C enable data checksum"
 	echo "  -i use ip mptcp"
@@ -2524,7 +2615,7 @@ if [ $do_all_tests -eq 1 ]; then
 	exit $ret
 fi
=20
-while getopts 'fesltra64bpkdmuchzCSiI' opt; do
+while getopts 'fesltra64bpkdmuchzCSFiI' opt; do
 	case $opt in
 		f)
 			subflows_tests
@@ -2577,6 +2668,9 @@ while getopts 'fesltra64bpkdmuchzCSiI' opt; do
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

