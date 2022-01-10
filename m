Received: from de-smtp-delivery-102.mimecast.com (de-smtp-delivery-102.mimecast.com [194.104.109.102])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 422A42C9D
	for <mptcp@lists.linux.dev>; Mon, 10 Jan 2022 09:09:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=mimecast20200619;
	t=1641805747;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=J1vKNp20D5xsSyzcRompJ4fCvOu3yratA9ldE18MGwM=;
	b=hEBsDvL9fBSsOBueRlJGgk0N5JZhsiM1IICW6dljd8K4Q7cFQzw1FxhYHJrUNno10emP+j
	AhjFqfd374QMP7IowfTy5zAKv7Pnarg15xzGrNz9/RFGS+zgckmSSwUiwkQyajIQktoOg4
	3zwgoeKrJqqXMPil7FkZE2hKXIUM4MI=
Received: from EUR01-DB5-obe.outbound.protection.outlook.com
 (mail-db5eur01lp2050.outbound.protection.outlook.com [104.47.2.50]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 de-mta-15-lSTnY0W3MP-E4o5VvJfQpQ-1; Mon, 10 Jan 2022 10:09:06 +0100
X-MC-Unique: lSTnY0W3MP-E4o5VvJfQpQ-1
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JXFqxiUKSPaIGy6LivLuWAouGRclCZeOQCpWSwtyzVA41mklzgLKOVxAkLlcxGZxPlF+kxxzH09LiYdL63nJas5qU2kjmJ5ujoSkPNJdpb+KuTN3UtpzfcZyD4hustht3V11G53/qI70l+VXCnvKuFGx0qTDQY57c0it6XayW7OmXJdRG2NMOQ4HOR/hQ5FB8V2m4vtbLRYD1YBuwfVty/A1FkEwFU0oXwzKhFMK9R9KrO18ZfLb3XxfdllGnW0kbdUIxFpp8Zmk9XdqNMuwOIKgM2yVj/QuiawvBBJXHGsf5YxXt+StnVoKpWnDQ0azNIDkeYmCBtYu78xvR7H/Hw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=E1xsVIKW6ylKdliruqpYemV6LlcvQANHsIga8GmvKDs=;
 b=iJLP0wjblqL/x+nGuA5yKe6fj/DP2OXdb6VU+oFoUH8ndjK+u9sVAHONOGTtdcmtxVPMOwOsjxX8qRhj0HBX7rBUob7T8hFap2tI1XAugGn4G0VQcgBS9rH19WRG4/WJ+hMHrYSHMcpi7qf7p6lMQyBU/iUoxoQx43nM+t+f8AaPjqSkL4byW6sju4reUoveJsoxRfq0HMtHAFe30fGPp6spCiMF+SHnsmxDPNNVLFL3qM7+elJjgfEc5b7l9avmX5cay9xGV846py/Uokd3cjfjeL0swHEXtXE9iyL58B5Kde2aY1ub/q40YGyzh5n3AgPaVMLAJWNA/NyECzYGZg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by HE1PR0401MB2345.eurprd04.prod.outlook.com (2603:10a6:3:1e::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4867.11; Mon, 10 Jan
 2022 09:09:05 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::b5bf:e1b5:42fd:4dba]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::b5bf:e1b5:42fd:4dba%4]) with mapi id 15.20.4867.011; Mon, 10 Jan 2022
 09:09:05 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
CC: Geliang Tang <geliang.tang@suse.com>,
	Davide Caratti <dcaratti@redhat.com>,
	Matthieu Baerts <matthieu.baerts@tessares.net>
Subject: [PATCH mptcp-next v9 5/5] selftests: mptcp: add mp_fail testcases
Date: Mon, 10 Jan 2022 17:08:22 +0800
Message-ID: <a0f7ec766ca99a5f2e2aa27a358f45fc06f6cc78.1641804767.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <cover.1641804767.git.geliang.tang@suse.com>
References: <cover.1641804767.git.geliang.tang@suse.com>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-ClientProxiedBy: HK2PR06CA0007.apcprd06.prod.outlook.com
 (2603:1096:202:2e::19) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 59cdf77c-fa33-4145-b820-08d9d418d9e7
X-MS-TrafficTypeDiagnostic: HE1PR0401MB2345:EE_
X-Microsoft-Antispam-PRVS:
	<HE1PR0401MB23456C2A162EB85A000B875CF8509@HE1PR0401MB2345.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1060;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	ZlDE86p9Z4jTSZ/htP/2vkaQeUIfRm1IvsDhTXBR7lK7thNyyABhhMYvpYEmdQBTvZQuikGit3aDJSd0x6cDtw4nDP1PkNpDv1S94pj4nxbRqle/a9f2Q5yGl1OVz14NXsPr2cSozqcEDNUIGRgEm+P3qlAdzU1ebRW0SNSzwtQy66op8AqQVtXLhH56DD6npoIVtWB3/b4vqrPbp1cQH0+qlgrHx/MgMhCUv3q1naF+fU8Z0jMhIyORqMDUAIQtIemMSDzWObQ20gU8iOnrFaY9CnEtfYUW3u5l2xycMoe6cz3MAHHZu/JIvCRYrRM4H2+pEyXALf4ndGrdf5X/fT2L1E7pEKDhMQ85BnOQ1td03WCi5RT85FRpoGdhjsIPaQykUBG7DDteaWtC+Ch3Q4VxGmzJuBH+3zUmUqwvi1X9eXpTmwzgBJwZPQfpDSq/CbwJR7bg/v6QhhJAA1C69WLPXJK/M9NuxRij1+6TBh8GVIWr5q5TM02dhLPRLqKvZO9UQGC4FvGSrgBwBDNXjyMkVKQqcNi3sjfHp57SNRUbk6QBBJNR+tj7429G8LDg3mHI0EipFNKWFEGi3HulSIKrn6Cx+0W3E8uYZHQrmns+DlpBB3R3jQJ48J+f/thNZnsDzGymhRGF2qNxkArLZA==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(6666004)(6916009)(26005)(508600001)(86362001)(6506007)(66574015)(55236004)(2906002)(83380400001)(316002)(54906003)(5660300002)(186003)(38100700002)(8936002)(8676002)(2616005)(66946007)(66476007)(66556008)(36756003)(6512007)(6486002)(4326008)(44832011);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?CD/xaBru9vrMEZZFzG/PfZ+PD2Dwod6e/al9I7XgmiBB+mivcU22NklV6tQF?=
 =?us-ascii?Q?63kHykIt3zS3bs9epj9RTa6BTIO3kP2DHCeK/0/5XIXQw3u66dDLG/YdWPjR?=
 =?us-ascii?Q?iYKXudSrUcOKScy06A81kojicQI7hN1tujlBnnHL2/qlPkldnUQqnMnnsTkK?=
 =?us-ascii?Q?LHxSZ/La5VZUtAV8CQJBbEAcohtT8SjOlPYzzfiIyeuzyun6cuyuUBIU6ZsD?=
 =?us-ascii?Q?Aa4JjP6w+3eYtk2XqaO35iTNm9vxysxFxHrTS2iX3uxj2lMTtCwStR7fqmZR?=
 =?us-ascii?Q?tKkMvI/LICGwGDp4Jicce9f7GtKqsMZ/IewxxD2l5UHoqy2oBLJRzjNUlZc9?=
 =?us-ascii?Q?o+84DIZSP83Ci84pkE1F8LY8iDWKhhV/Ht9fcbM63RK9NQ6CbhaED1K8im4A?=
 =?us-ascii?Q?HqPY7UXcf2wtUnvqewS++lqp0B+nL/VTud3tTEtVt+Its3vOAaRY41IC84A/?=
 =?us-ascii?Q?gtq1xM5jGAhF7Kck2vJoJcFmbIFhtKZlx+IpV5/OVSn9tQ4SLbG0KuKzdtRp?=
 =?us-ascii?Q?yyNS4QX3AdaHSLGc4ARnPdkzLfkCmsrFb5NMhXtxzRmB2e6wKQUDZ5vcF1ec?=
 =?us-ascii?Q?xyYUJA/XUTfSmFqLcPd2MZ4c/cxu1Q5OXYgLJ1WuKmLO+caNKuanPBDuG0xg?=
 =?us-ascii?Q?i/jDGmgAMsV0wTIi5eWcauKX7d5snXkBMGB5rW0xpl+uYgd9ybvzj5wnqtJX?=
 =?us-ascii?Q?7G/ajwVa5MCbZAD0SULs8Y7rknAJHF69CnRYB1blfvvonkXd9Kc4lez4XHyZ?=
 =?us-ascii?Q?v+UQ3fNTwc9hlZclWpAM713jAikoQ7t3qWOqRrF7sm478XSZmYcwOiJUrIy+?=
 =?us-ascii?Q?uT/1XNmSaQ1jLKz8Jjj7qrluefHHUyw9tmFBKr9ZKNZGvVwep7GuREW0dg/Y?=
 =?us-ascii?Q?PCN2xNMvCteWweELaC8Ld+jvrpn5xp831CYAFVfysZvKNrrA+sULOxZ8FBCM?=
 =?us-ascii?Q?9AyvU9yMG90DiUAqFsecZzUpEjpDMRxae8xEUrHntqTPt04IcZLHRLHtLwOn?=
 =?us-ascii?Q?305SwlXtnoHEfqkRwIxNBWMxfPzsXShHhnQpRafwJksw05wFI/M1uXn8GUx1?=
 =?us-ascii?Q?H2HoFQhQfoFUBriFrhDK3NY2gAIJ9lxz4KYZm/cRNFYXrP3+Q5wpbl+UTdDL?=
 =?us-ascii?Q?9h4KTmswhAYG+GG8uOohLC9jHgnwENSFMa2ObaECOSOH8bwrjcl9ujLkkOjy?=
 =?us-ascii?Q?891CTOFcvZm6PBQWhktGJ92f+uVfhMVKCguxXIOO1aHCSzzCdyNsWohfRwnf?=
 =?us-ascii?Q?X7m27JXWwwvDy8ydng1lmRdFABnLJ5F6JN+nu2WNoQIIWdGwr2VcmkagUOYy?=
 =?us-ascii?Q?AwBJs+gIrRpMkm2sOkiSGGoMAWow6l5hK5xvn4EQcEuHfNFDvXqMiXg0gtTE?=
 =?us-ascii?Q?jquVB2o9ieqOKOU9lEk5KnLxRKb1yRAHnT0kSfGfkX/DXTe5/M2ioOfVO70f?=
 =?us-ascii?Q?F/GlNgdDP0abQ1ZWpktbmsvRH5ej0CmthkeVXfyyB7TE1V1lW92suHxaGpZC?=
 =?us-ascii?Q?ypgX4qamK53LZeQQtcjd7azEaCXiqkhlWTbOydm/1/1c5OVfzWRZotfbMRl7?=
 =?us-ascii?Q?xrY/o8D2k8a/piwLA+z6sylZTCVT4Oh8QpKDFcG9+T5PqiYn3V8QIATGoM9n?=
 =?us-ascii?Q?TIOWBQRu0ifE73ggcTLRbzs=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 59cdf77c-fa33-4145-b820-08d9d418d9e7
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jan 2022 09:09:05.1499
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: MKv/sR9MqWD/uyxI39AqC6r1S13+rVxrXGuraIiSkIk3Stvo6jPlMbL7L3Lv218sY93pX5m8mIF/JPvuVFYAYQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HE1PR0401MB2345

Added the test cases for MP_FAIL, use 'tc' command to trigger the
checksum failure.

Suggested-by: Davide Caratti <dcaratti@redhat.com>
Co-developed-by: Matthieu Baerts <matthieu.baerts@tessares.net>
Signed-off-by: Matthieu Baerts <matthieu.baerts@tessares.net>
Signed-off-by: Geliang Tang <geliang.tang@suse.com>
---
 tools/testing/selftests/net/mptcp/config      |   5 +
 .../testing/selftests/net/mptcp/mptcp_join.sh | 111 ++++++++++++++++--
 2 files changed, 107 insertions(+), 9 deletions(-)

diff --git a/tools/testing/selftests/net/mptcp/config b/tools/testing/selft=
ests/net/mptcp/config
index d36b7da5082a..26955abe49f0 100644
--- a/tools/testing/selftests/net/mptcp/config
+++ b/tools/testing/selftests/net/mptcp/config
@@ -19,3 +19,8 @@ CONFIG_IP_ADVANCED_ROUTER=3Dy
 CONFIG_IP_MULTIPLE_TABLES=3Dy
 CONFIG_IP_NF_TARGET_REJECT=3Dm
 CONFIG_IPV6_MULTIPLE_TABLES=3Dy
+CONFIG_NET_ACT_CSUM=3Dm
+CONFIG_NET_ACT_PEDIT=3Dm
+CONFIG_NET_CLS_ACT=3Dy
+CONFIG_NET_CLS_FLOWER=3Dm
+CONFIG_NET_SCH_INGRESS=3Dm
diff --git a/tools/testing/selftests/net/mptcp/mptcp_join.sh b/tools/testin=
g/selftests/net/mptcp/mptcp_join.sh
index e48ce23d2386..535baa3c01e7 100755
--- a/tools/testing/selftests/net/mptcp/mptcp_join.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_join.sh
@@ -16,6 +16,7 @@ mptcp_connect=3D""
 capture=3D0
 checksum=3D0
 do_all_tests=3D1
+nr_fail=3D0
=20
 TEST_COUNT=3D0
=20
@@ -58,6 +59,8 @@ init()
 		fi
 	done
=20
+	validate_checksum=3D$checksum
+
 	#  ns1              ns2
 	# ns1eth1    ns2eth1
 	# ns1eth2    ns2eth2
@@ -161,6 +164,45 @@ reset_with_allow_join_id0()
 	ip netns exec $ns2 sysctl -q net.mptcp.allow_join_initial_addr_port=3D$ns=
2_enable
 }
=20
+# Modify TCP payload without corrupting the TCP packet
+#
+# This rule inverts a 32-bit word at byte offset 148 for all TCP ACK
+# packets carrying enough data.
+# Once it is done, the TCP Checksum field is updated so the packet
+# is still considered as valid at the TCP level.
+# But because the MPTCP checksum, covering the TCP options and data,
+# has not been updated, we will detect the modification and emit an
+# MP_FAIL: what we want to validate here.
+#
+# Please note that this rule will produce this pr_info() message for
+# each TCP ACK packets not carrying enough data:
+#
+#     tc action pedit offset 162 out of bounds
+#
+# But this should be limited to a very few numbers of packets as we
+# restrict this rule to outgoing TCP traffic with only the ACK flag
+# + except the 3rd ACK, only packets carrying data should be seen in
+# this direction.
+reset_with_fail()
+{
+	reset
+
+	ip netns exec $ns1 sysctl -q net.mptcp.checksum_enabled=3D1
+	ip netns exec $ns2 sysctl -q net.mptcp.checksum_enabled=3D1
+
+	validate_checksum=3D1
+	nr_fail=3D0
+	i=3D"$1"
+
+	tc -n $ns2 qdisc add dev ns2eth$i clsact
+	tc -n $ns2 filter add dev ns2eth$i egress \
+		protocol ip prio 1000 \
+		flower ip_proto tcp tcp_flags 0x10/0xff \
+		action pedit munge offset 148 u32 invert \
+		pipe csum tcp \
+		index 100
+}
+
 ip -Version > /dev/null 2>&1
 if [ $? -ne 0 ];then
 	echo "SKIP: Could not run test without ip tool"
@@ -179,6 +221,12 @@ if [ $? -ne 0 ];then
 	exit $ksft_skip
 fi
=20
+jq -V > /dev/null 2>&1
+if [ $? -ne 0 ];then
+	echo "SKIP: Could not run all tests without jq tool"
+	exit $ksft_skip
+fi
+
 print_file_err()
 {
 	ls -l "$1" 1>&2
@@ -233,6 +281,21 @@ link_failure()
 	done
 }
=20
+get_nr_fail()
+{
+	i=3D"$1"
+
+	local action=3D$(tc -n $ns2 -j -s action show action pedit index 100)
+	local packets=3D$(echo $action | jq '.[1].actions[0].stats.packets')
+	local overlimits=3D$(echo $action | jq '.[1].actions[0].stats.overlimits'=
)
+
+	let pkt=3D$packets-$overlimits
+	if [ $pkt -gt 0 ]; then
+		nr_fail=3D1
+	fi
+	tc -n $ns2 qdisc del dev ns2eth$i clsact
+}
+
 # $1: IP address
 is_v6()
 {
@@ -589,6 +652,8 @@ dump_stats()
 chk_csum_nr()
 {
 	local msg=3D${1:-""}
+	local csum_ns1=3D${2:-0}
+	local csum_ns2=3D${3:-0}
 	local count
 	local dump_stats
=20
@@ -600,8 +665,8 @@ chk_csum_nr()
 	printf " %-36s %s" "$msg" "sum"
 	count=3D`ip netns exec $ns1 nstat -as | grep MPTcpExtDataCsumErr | awk '{=
print $2}'`
 	[ -z "$count" ] && count=3D0
-	if [ "$count" !=3D 0 ]; then
-		echo "[fail] got $count data checksum error[s] expected 0"
+	if [ "$count" !=3D $csum_ns1 ]; then
+		echo "[fail] got $count data checksum error[s] expected $csum_ns1"
 		ret=3D1
 		dump_stats=3D1
 	else
@@ -610,8 +675,8 @@ chk_csum_nr()
 	echo -n " - csum  "
 	count=3D`ip netns exec $ns2 nstat -as | grep MPTcpExtDataCsumErr | awk '{=
print $2}'`
 	[ -z "$count" ] && count=3D0
-	if [ "$count" !=3D 0 ]; then
-		echo "[fail] got $count data checksum error[s] expected 0"
+	if [ "$count" !=3D $csum_ns2 ]; then
+		echo "[fail] got $count data checksum error[s] expected $csum_ns2"
 		ret=3D1
 		dump_stats=3D1
 	else
@@ -690,6 +755,8 @@ chk_join_nr()
 	local syn_nr=3D$2
 	local syn_ack_nr=3D$3
 	local ack_nr=3D$4
+	local fail_nr=3D${5:-0}
+	local infi_nr=3D${6:-0}
 	local count
 	local dump_stats
=20
@@ -726,10 +793,10 @@ chk_join_nr()
 		echo "[ ok ]"
 	fi
 	[ "${dump_stats}" =3D 1 ] && dump_stats
-	if [ $checksum -eq 1 ]; then
-		chk_csum_nr
-		chk_fail_nr 0 0
-		chk_infi_nr 0 0
+	if [ $validate_checksum -eq 1 ]; then
+		chk_csum_nr "" $fail_nr
+		chk_fail_nr $fail_nr $fail_nr
+		chk_infi_nr $infi_nr $infi_nr
 	fi
 }
=20
@@ -1985,6 +2052,27 @@ userspace_tests()
 	chk_rm_nr 0 0
 }
=20
+fail_tests()
+{
+	# multiple subflows
+	reset_with_fail 2
+	ip netns exec $ns1 ./pm_nl_ctl limits 0 2
+	ip netns exec $ns2 ./pm_nl_ctl limits 0 2
+	ip netns exec $ns2 ./pm_nl_ctl add 10.0.3.2 dev ns2eth3 flags subflow
+	ip netns exec $ns2 ./pm_nl_ctl add 10.0.2.2 dev ns2eth2 flags subflow
+	run_tests $ns1 $ns2 10.0.1.1 2
+	get_nr_fail 2
+	chk_join_nr "$nr_fail MP_FAIL, multiple subflows" 2 2 2 $nr_fail
+
+	# single subflow
+	reset_with_fail 1
+	ip netns exec $ns1 ./pm_nl_ctl limits 0 2
+	ip netns exec $ns2 ./pm_nl_ctl limits 0 2
+	run_tests $ns1 $ns2 10.0.1.1 2
+	get_nr_fail 1
+	chk_join_nr "$nr_fail MP_FAIL, single subflow" 0 0 0 $nr_fail $nr_fail
+}
+
 all_tests()
 {
 	subflows_tests
@@ -2003,6 +2091,7 @@ all_tests()
 	deny_join_id0_tests
 	fullmesh_tests
 	userspace_tests
+	fail_tests
 }
=20
 usage()
@@ -2024,6 +2113,7 @@ usage()
 	echo "  -d deny_join_id0_tests"
 	echo "  -m fullmesh_tests"
 	echo "  -u userspace_tests"
+	echo "  -F fail_tests"
 	echo "  -c capture pcap files"
 	echo "  -C enable data checksum"
 	echo "  -h help"
@@ -2059,7 +2149,7 @@ if [ $do_all_tests -eq 1 ]; then
 	exit $ret
 fi
=20
-while getopts 'fesltra64bpkdmuchCS' opt; do
+while getopts 'fesltra64bpkdmuchCSF' opt; do
 	case $opt in
 		f)
 			subflows_tests
@@ -2109,6 +2199,9 @@ while getopts 'fesltra64bpkdmuchCS' opt; do
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
2.31.1

