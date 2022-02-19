Received: from de-smtp-delivery-102.mimecast.com (de-smtp-delivery-102.mimecast.com [194.104.111.102])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 553C857D1
	for <mptcp@lists.linux.dev>; Sat, 19 Feb 2022 23:21:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=mimecast20200619;
	t=1645312917;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=wJ56PYOxCQQHdk2Vc2PM4dX//ecB4QJmqINqA/XlOJ4=;
	b=HygsMHwB+n1lll9ujCw3wya7vtFkyvO467diA5wicJ6ADWIy4GttCESJuBejLH4+N6JvgX
	ZI4fgzxu5i0gCf0xyMSP4MVVsbxCMlfb4ntD3MJ61095SzAQbRQQsqDjKYcjKV94gVERD+
	HoR2QgKEQ3+v5HxM7qyTJMd+Nada/0w=
Received: from EUR02-HE1-obe.outbound.protection.outlook.com
 (mail-he1eur02lp2055.outbound.protection.outlook.com [104.47.5.55]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 de-mta-4-tH3lcAu9NoaB5372RjeDHQ-1; Sun, 20 Feb 2022 00:21:56 +0100
X-MC-Unique: tH3lcAu9NoaB5372RjeDHQ-1
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ezog/7oU0GD1B36X51wmZh8RBmDAv70o7cFuQHR4gtUJtQ9pfsA0CmzHt768tNT0cQR7l4KiETTVEUsQ9yOFR/5Mg8Xlw+lja7lKBoDB9DE+MKs7GmiwlZ6udKWk5jcGTonCnIzG2wgYww0RneTmCugWfTzTvPY+vLcPuUPrIxOK2FT9P/Ooa62gBeJM1rHX2Sy91zfywNGbt3VMP+vzLPEcm0IhajcuoMgNB732AlqCuwUidExbCNSodUsP6mHMjUKnC68W8KWWlqyFXoJRoD7CqmYnfJexyg2ZR+lDxZ79LHDfJYwfyAPQsumORMS1pgI5sOBuTsT8vdPmLo5YxQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+z0fMgpOxW0+ManWxJ7xy1bfqivg+k7dPNaCWZTE5v4=;
 b=luatMKPorFPz5dxvsTiRj+5w8XRWHF9NRDX758CZKgVtVH1zlNHLyv8JijifH9EKatoBTtVwdEJPcKQsH7i1dGnu8NG0pGlSfk30MgbOA0v/O5jgDqeIrwuczDWzUkbqnHUCuapShjB9QAxMxTSbXTt6KPEFdPy+Y7IDE4bR4s0rA3pXknchdVx96mLEDpE2hDlFeCRgB6Alr9XD0kFzzKSRPgVv1pRjHJkOECQPhEn9Ti5D8SsRXZRhU9pJ6G2LpTkaJgffUIrPU8toy7CNR0PQUgaFgfCGD5JEpxvb34+AFfgSXF7s+lhjzUwZfsC1ykHm9fwJu3IavnnDzCt2VQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by AM9PR04MB8812.eurprd04.prod.outlook.com (2603:10a6:20b:40b::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4995.24; Sat, 19 Feb
 2022 23:21:54 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::60de:f804:3830:f7c5]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::60de:f804:3830:f7c5%4]) with mapi id 15.20.4951.019; Sat, 19 Feb 2022
 23:21:54 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
CC: Geliang Tang <geliang.tang@suse.com>,
	Davide Caratti <dcaratti@redhat.com>,
	Matthieu Baerts <matthieu.baerts@tessares.net>,
	Mat Martineau <mathew.j.martineau@linux.intel.com>
Subject: [PATCH RESEND mptcp-next 18/19] selftests: mptcp: add the MP_FAIL testcases
Date: Sun, 20 Feb 2022 07:21:33 +0800
Message-ID: <7197fee623285e5878d01f19aaa914eb426a9692.1645311956.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1645311956.git.geliang.tang@suse.com>
References: <cover.1645311956.git.geliang.tang@suse.com>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-ClientProxiedBy: HK2PR02CA0161.apcprd02.prod.outlook.com
 (2603:1096:201:1f::21) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 993adb1c-bf2b-40cf-4dbb-08d9f3fe9d9e
X-MS-TrafficTypeDiagnostic: AM9PR04MB8812:EE_
X-Microsoft-Antispam-PRVS:
	<AM9PR04MB881296E63C8DD69F2852EC93F8389@AM9PR04MB8812.eurprd04.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	af6qPUWkimuiQ9td5EgilHKoI0hJ0nh65mXr4SROVc45gD9AZP05GFljCW/g2evp7AYyOluSYdG0RZCuk1f8k+xEeWKrYh+ppzZprVyluNsQJMxr2AMRuEIgf8yglLkAAJZmI0sOq0CWit6gLR5RPMvHshz703gizDRAKROGs8dEM/bYG4fjkghWzH81okCMqamGiXM/xFk2/BTESwFP3T27Q9bDMlSnuQ+35oEfwHCtZWxpQ2edCYQHiPYrCJC+3wOnuhK8H82vbje+ZkPRGqcQSzM/tDi5bEabHb9K9g1KjRcTdtS0FTNAxtQPdw5/qsdzo0tnxt4Vl7yWJQ2rxo1AqUavwvbRDe57S4D6EqeUuJDrI4sru8liPcaP/7igHGawuaa2spTgscI0xNx3hgf9htRg7LhVtDUe51BRwpuXl+d59X/oLwezZmU76R1L43OhcIaRG1d3z+fufsrHIOWkajGbxozhtyxbUTQzIBN/XUlG7gg0QqVK99lDo/gth1Wy30/eFQWQvqnCSjwsElYF+GHF9t98nd+ZMhsZXGYsG19U+JptkiuXICNxEC/QZBw/B2SKLsVh7yt2ydI5tV2iWYerr6vptfE3xpwt74tTpq0G5VOjFP90v1qDoGYbGPAb1QAh6ta88ju/UZstCw==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(44832011)(66476007)(6486002)(66946007)(66556008)(4326008)(86362001)(8676002)(66574015)(5660300002)(54906003)(186003)(8936002)(508600001)(6666004)(2616005)(38100700002)(6916009)(36756003)(6506007)(2906002)(316002)(83380400001)(6512007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?aE9yo6sBn4fcA9ASBwsNImcq1cQUGBEI3idvsEB+DVMJvdYp0NXbvPOsorte?=
 =?us-ascii?Q?8YLFAogTTev+HTGSw1mY+l06H7+XUnIq/zFaglbSToRtEfQEpZuHIfb0Xhk+?=
 =?us-ascii?Q?8oZnqC2KfRi20E7YW2MJQ2Iz3bArZfe3NDsDZrO89Q9IaBFsmtYF/mk7RO9Y?=
 =?us-ascii?Q?HiDR8hBeC95ubXyQ8h2he6fg9BYGXiLxY4VWCuYMy3FdcZv8ZETo4nFJ8qsn?=
 =?us-ascii?Q?qUSJZfSLgoxTwqoTfr2zauRVVopUFGgXe4VjN4o4N+LhdsAqKg+XiZpdlmk2?=
 =?us-ascii?Q?6QiuBb5JM6PzUT3zVtU/kKZ5QHcqYjIe4o5IXzWUOfqZ0Kw6fC5/8n8qHu6H?=
 =?us-ascii?Q?zsseHJNnL5ZTbyQXWDbXwTUDii7ycDKl8AD6Gts2CuizLndCDOqjk/OcpDB2?=
 =?us-ascii?Q?kGh8OB2YawyOOUJCH0KIcyU/keF6312EXuaooM1I5hxN0K6MnVxsd0PoKGnf?=
 =?us-ascii?Q?TYKqo3G+AoHMG3KPdqRWCWCdTnSeUT1DqgscQuQkqjf3jJQT62u7wZmCV0r0?=
 =?us-ascii?Q?ihCjmiJi2iQiePMx106mVKhZjXhrhp6gG6oC+NkKq+WzWhYBjomy21olxg5L?=
 =?us-ascii?Q?2/xry5GS5xKZuDrIOMAszPE8Xv7T7iaL2zMdu7ZK2SmvC+rHWX3G2W7cnZ/e?=
 =?us-ascii?Q?fCYMwBRGtvadd9A2lOBOiUY/b9YB9B7XFbzEbquY+3NYY5LSLvrZb1cYjlwl?=
 =?us-ascii?Q?i2lvUtuJOCW6upeNF8snyCcUV7zfEqADdgt7d3Hc9U53PGGsWDa8/Px2wv/l?=
 =?us-ascii?Q?G44dINkhEs/us6p/bGsAkciqYUzjCOuyCkTPly44/CMtinkxoCWWzWYZmld3?=
 =?us-ascii?Q?COkrfPJjBvNrI6ASH6iXlekiBNYacdS5Q0ZycXc6KOsMnw7wdPkH0Zht7Z5H?=
 =?us-ascii?Q?gXbJx+rYUaeNBNgqmt9G1hgSDyWR9T8Q92//afJNcyLBblOo1PijRhLM0xcQ?=
 =?us-ascii?Q?wPDB0atlkdWL0earYKXh8Tcwc2tsQNBf/cUK56EZrnzPPL5uN3ztl/m8upUv?=
 =?us-ascii?Q?4GwuoQMoghpWYvDHfJlI7czyIbWo+jrhIqZHC96w6Y2iXZAf2AUS6+xNhg42?=
 =?us-ascii?Q?vucEHj+Cri+83eVnKPMYS5q1xs8/34JH9tP3CeA/FOwN2P4EGxvPdx35zeN+?=
 =?us-ascii?Q?TXP5Z4hfSLKFF/1MTOEl/vr3/36e/333X/IDKAwz6n2WC9yH/A3HAdEJL3gI?=
 =?us-ascii?Q?U2dVdE1XLQxreLpUB7yIuOgeLzpCOlnAUgEhPx7uv8GotUzlCL/eF2sdnb+p?=
 =?us-ascii?Q?gvmUHf6aUTuAld5S6MnYW4Ft//MfzSCfI9JpB/bsOU9vbRUeqoCbbn712b3b?=
 =?us-ascii?Q?dfytLu6yyf3IKaXkBJpXA4/oJ4KZss0kxSfAL8hqK3LxEGsQCFyXTuG/29x8?=
 =?us-ascii?Q?NTZT2JDTO6FdPHwmf+FeuLm+9w0WLd8msDKqHV4BufBVazoIeG86Un7fZyYn?=
 =?us-ascii?Q?ZKlYYAw8AE0pyhlSu5gycXGNZX65MupFdtSnblAMHZd+nDte8kULsPAIkkNb?=
 =?us-ascii?Q?KcvQXkEcltAuxL2T0CVS1gyxhIsDdkaHCpwegrFDEOn8y+oTZgCiNJK0XBxz?=
 =?us-ascii?Q?6fSVbzfNnioTgyVdVZgGIxIHOMXaA4Ves/X33r0uMrGnPzFMGlXVL1kuM/lL?=
 =?us-ascii?Q?D/GFEjQ77u6n82i6X8VAaEZJCJYW31rUH3yltT8v9jNm+j8ljuidczTPsKju?=
 =?us-ascii?Q?AjHx/szxaNLVaTmAiAhdh9t2j/Q=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 993adb1c-bf2b-40cf-4dbb-08d9f3fe9d9e
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Feb 2022 23:21:54.2682
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: CyTQ9aka/ZI0R8hAyvfdEJ6SyYLmIrbsi0DniFCKYFIy4F/0tL02KzyWu6mPodDORKz/K+UWrwtMXKXx9mYflA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB8812

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

