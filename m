Received: from de-smtp-delivery-102.mimecast.com (de-smtp-delivery-102.mimecast.com [194.104.109.102])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 791797D
	for <mptcp@lists.linux.dev>; Fri, 11 Feb 2022 09:53:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=mimecast20200619;
	t=1644573220;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=9JLqzjBjEXsjqOnKxZKfDGN605V+R/9XGK6umEPPMY8=;
	b=QJTfFlQ+Rti2NYjKL8RGiBKRXZBt2+wSWbAO8UUV2fghpEIiBxzR4iTr/CFIJq5lXeCXiX
	2O2+gDjFHL9NEvH9x/ypnoNDar+0Qe1KWjY45HTRKrckTkOVFk6hQmU3ErBfgEZ2XqvNa0
	7LRGhCAbEtz1H0OhwmmGC4yKFLW8do4=
Received: from EUR05-DB8-obe.outbound.protection.outlook.com
 (mail-db8eur05lp2111.outbound.protection.outlook.com [104.47.17.111]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 de-mta-35-3gEZ4QZcM42ukfp0WR5kZg-1; Fri, 11 Feb 2022 10:53:40 +0100
X-MC-Unique: 3gEZ4QZcM42ukfp0WR5kZg-1
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lb/NRDemd3DtijzVOdk6dG6gStUKk9HUVSsE0w+Zg5gJjyH5hduHdvyykq+7/ElBkW7ddcaLWuoovBKKBfw/mJ/sdEIAHxVHS4e5JMHWdjieqgbvqBZx9MXwXY0OrioXJSnsCo9M4vAToDNbhn4Ln73dlmu5QebG3ioyNfiedyWzqJFdHL6IkM2OLdf6gIcVeU36nX5RSzxWlwqc4PWMYpZgF3CwsgvcLskbME1Zma4oX6OXtckRtj9SFTaEI7S07LZfpsGaYbpGD5KJZBlvDlfWHoAU1f1Ou6ZumoLcC4E+s3jnsTV2YWxi0wHwvfAIT+6xaXQSP3TdxxB4RbN+sg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Q+dq1hdVawW+pqCzY+H7yTyKmodGWzPZi0wViTWZm9s=;
 b=ULEw+pcZYZdsgtJdmxrg5aHnbblIZFu44S7pDvOosuX0pZo85sMMOlYZ3cKfQR7q4ftGKC1TKBcMAYWToO14Wyx4TxrsvKDgUkT91L8hi93PpBgoXrBaeNbMJzSbkmM9+Bqgzdp0xsQBN2ErI0YjiVveExdhC7hdLEAUB38dtywZANbKdX9Zp4LkwsxVy93gIjmcbgV3U7nH8b85ZW7V6MyHLYIG+7OVZRZWcXpZjWDH8f5JP/nb+tFcRKQPcIlFP+ro3b8zaq8fJWjnqfO8vBjrJ5U4kYZLNlT7cf3K++c2xYPHE5zq/YEHYqJmRerX5M5yv8oaX1hIvRvRquND7Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by AS8PR04MB7878.eurprd04.prod.outlook.com (2603:10a6:20b:2af::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4975.14; Fri, 11 Feb
 2022 09:53:38 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::60de:f804:3830:f7c5]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::60de:f804:3830:f7c5%4]) with mapi id 15.20.4951.019; Fri, 11 Feb 2022
 09:53:38 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
CC: Geliang Tang <geliang.tang@suse.com>,
	Davide Caratti <dcaratti@redhat.com>,
	Matthieu Baerts <matthieu.baerts@tessares.net>
Subject: [PATCH mptcp-next v7 7/7] selftests: mptcp: add the MP_FAIL testcases
Date: Fri, 11 Feb 2022 17:53:05 +0800
Message-ID: <b69cf531ac6046cb5d9fc6f61e5d2a333a296b13.1644572307.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1644572307.git.geliang.tang@suse.com>
References: <cover.1644572307.git.geliang.tang@suse.com>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-ClientProxiedBy: HK0PR03CA0113.apcprd03.prod.outlook.com
 (2603:1096:203:b0::29) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: e220ecd3-ed3c-4757-759a-08d9ed4460b5
X-MS-TrafficTypeDiagnostic: AS8PR04MB7878:EE_
X-Microsoft-Antispam-PRVS:
	<AS8PR04MB7878EB7280C9AD1846DBBF20F8309@AS8PR04MB7878.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7219;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	BbakrEnInusxGQ29gJ7ZdmSBl4Esj2VfuUf/AzHEBPFrPJUbAiGQ3YB+GYZVIEIWgxqV656g3v1T5nOeviX5YFv5dwEsXAyJmt6QZ4BCFZhF/AFc32DmXDx0ZJcY6zjaFFLdE5gZ+8LH1NKpoKnjqG8u2sStLIuV82CHimUJHDFRAANw+IqCvBEPjoaPiBqu8tApl53h8xwJ6AX3gOS1QgYwXqfaD0Pt8bco7uGqxm3lRGCUV0MIZVsi90t9e8g5aNwTSCCsJd/SJI+H/mg8kvYCwTmOIeGNMb/T3XI4M8MHA82hd5wZo2qVWA/QqpgILNeEglCO1noepLBxK15oKXby+qexI2SEkS1qHmv+vh+PH/dPQu93vNspQ6wLvaVY7RhA5p/1h5bHJ5XKaiTPu3HQYzJXkL7fT3yBkQRzhJIpzpa9KpkZK3SlI5i9J1TrU17T1xGuKasNDoppBnUrxTWtlN5SPiRJrTMDBSTGrKSbPx5TlMWEPaI1/LfXeOjggdjfm7qyMquhRERTCwD5Sd7QwRuIaPonmLzhPkrnnyhbqj7ItrnjChCPFZUQhRV4eC+7JGQp4IPQ8SSq6Ztf8BHaOjA3mNW7ub4JRe2tXwKpzq/K/KpZsFcHX1EFj+yjpXKqyC+CKnk6ML8ZEt4cwg==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(66574015)(316002)(44832011)(66476007)(66946007)(6916009)(508600001)(38100700002)(8936002)(66556008)(6486002)(4326008)(6506007)(36756003)(6512007)(2906002)(55236004)(6666004)(86362001)(83380400001)(5660300002)(8676002)(54906003)(26005)(2616005)(186003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?o+s1gMfCT7Eo+AyQHQ+jUuUhn1CA8NoU9PQ05ICJRRCkoo7acLvk6JrGn2nO?=
 =?us-ascii?Q?mTb8Xbd6ZG+WKgeguowfRP1UNssmVd2YHbOaH73Octrq+tkSTHgfLMQ785Lx?=
 =?us-ascii?Q?VncDDbfULb/EzTFMCufC8MpjBIqQ0lDkeSQ8P8awQAVhMG3UdVY5wlH4IjOe?=
 =?us-ascii?Q?ZpEtbVmBnTCgFDoNngKDjY6zBYiEe1WHsFwwQJJGSkIX8YCRunY4rozd0W0L?=
 =?us-ascii?Q?H5z8BQDCChvm5wTlbq82cCDS4y4/c7FC0Hw3Glm0HvRsI6GzZ4kh9F09o/8i?=
 =?us-ascii?Q?DKeZqNjDgW7AF7YkJ509US5pA9l0naoZ9t/uR0FQxLH7MV22q5RoVsxSLcDy?=
 =?us-ascii?Q?BKBHQBVQgqLVsZuVzsaLu5emKfMvvEIskWu+kc71kAF4mJJPqi+Z9L9Nu+ut?=
 =?us-ascii?Q?MLnHmx55w8jlxDII8Oh6iMTJwBI8btJ7bXiiEbqeoDmw5TzCXvBZDWpRmyDL?=
 =?us-ascii?Q?0UaQNutzb+2U2rcMLSZxyovZhpqt+t7v7ZzJyQyxuZ6hYNm95bpCMArBX0c+?=
 =?us-ascii?Q?5yTE9nNkuunKViCXpsVHSdMzJGonUtH2rPCMX/0SVqDHG2J6P8RJ3QAkPgb7?=
 =?us-ascii?Q?0ZF2Z7YvE7yl7e3iEXxDTDCwATO7xPfpGBOYI2TFS9QJuJMoVdqQZZ4IvtAI?=
 =?us-ascii?Q?b97tEQePQQIuQunjo6xvLK5SL2+gWhBkmgNSkNLE2ER1Dh0Dd1pmKkQX8WEK?=
 =?us-ascii?Q?y9l1g7uHh5PwFy2cdVBBBj4rykApkcbQ68lKF+rTbrxFgs6t9d/67Bjf/cKq?=
 =?us-ascii?Q?0AgGfOge3aZyhNAF4l1/6rOH8hX0k1Z/iyOlCO7LOCFrYscP5lC+akSkUINI?=
 =?us-ascii?Q?uuiNE7hlSYMDmu7rC1bzCWM4nqIP2ksOwsXw+tqLsPoyDytEcVdVrUZI2kJ/?=
 =?us-ascii?Q?g8ej86mrJ6rdQCMWv/fnfx6l00rSqvikkyhoBVMJtBXiFv3BYs/o/M0jF0id?=
 =?us-ascii?Q?8qTKdw+5QVXFU4JrqkBkauABszN9fcj2uevl16FTRce9/zj42U+ZQDHrdfC7?=
 =?us-ascii?Q?YcatfqgiJUt4Q7HD/6QilSIVA54zoc2E8QBbuzYdv257FWI7EVh0bxSegjRk?=
 =?us-ascii?Q?PjCdjZgQVLvS3u9oiEmmT4w3ZhuzYUri4BHzladM2CQ2VETrlNiOL1q7nvwG?=
 =?us-ascii?Q?B2ivxG+zEoJn+/1ab9hhhmjRIrv+5+2VHf7ow0wJH0HlkNmRlIHcu5rWZVK7?=
 =?us-ascii?Q?ILIJQQyqVX1NIfZIuBpn8euChBoxdgUBJhNDyNMef8oIPb9j0ChIFKig6Sae?=
 =?us-ascii?Q?ICm1CBsWL+iazzs6YizQarERa7bKaAD8hd9QYSVOC/ddwgu1iOxgitX8/R9m?=
 =?us-ascii?Q?sLQjRDNRBSNtwkK1bcP1e1lW4YNfmVgHJ1o8XcwPG5juM80wR+NAevNz1AXz?=
 =?us-ascii?Q?JbVAbS8yWcnUMsgtJaa/UToRNw0Mn+UCf9m61WlPpiIuqH0PitRAbjSfsaF1?=
 =?us-ascii?Q?34B+qo5zQMzt31uKu3vxf7mtKAbANU+SeuyfNt82vLKuAFiU1eecyZzpw47V?=
 =?us-ascii?Q?kIEHHfKKO9Gfgtyppero3C+8DSwF6pgT/6LDmYJrQpbZ5f2aRxeLfwBJx+SF?=
 =?us-ascii?Q?jvElY1pO7om/CrXAhsZn71GZcT6jtx/Z8awuKP74qHJVa+0I0KqWVFXy4OEY?=
 =?us-ascii?Q?JfAdv8tFx33F4vJRrPnXkYc=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e220ecd3-ed3c-4757-759a-08d9ed4460b5
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Feb 2022 09:53:38.7574
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: gDBPGg76dRzmpEcHSDadVY7Nhe7UdXMpOdzO1N0zXbWwhmDWNHaO7AvFauQiFeRFR+borHD06qOrJv+15gSXxQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB7878

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

Also added the tests needed kernel configures in the config file.

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
index 244c4aac1c6e..8c72edcb0ee2 100755
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
@@ -919,7 +973,7 @@ chk_join_nr()
 		echo "[ ok ]"
 	fi
 	[ "${dump_stats}" =3D 1 ] && dump_stats
-	if [ $checksum -eq 1 ]; then
+	if [ $validate_checksum -eq 1 ]; then
 		chk_csum_nr "" $fail_nr
 		chk_fail_nr $fail_nr $fail_nr
 		chk_rst_nr $rst_nr $rst_nr
@@ -2238,6 +2292,29 @@ userspace_tests()
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
@@ -2256,6 +2333,7 @@ all_tests()
 	deny_join_id0_tests
 	fullmesh_tests
 	userspace_tests
+	fail_tests
 }
=20
 usage()
@@ -2277,6 +2355,7 @@ usage()
 	echo "  -d deny_join_id0_tests"
 	echo "  -m fullmesh_tests"
 	echo "  -u userspace_tests"
+	echo "  -F fail_tests"
 	echo "  -c capture pcap files"
 	echo "  -C enable data checksum"
 	echo "  -i use ip mptcp"
@@ -2316,7 +2395,7 @@ if [ $do_all_tests -eq 1 ]; then
 	exit $ret
 fi
=20
-while getopts 'fesltra64bpkdmuchCSi' opt; do
+while getopts 'fesltra64bpkdmuchCSFi' opt; do
 	case $opt in
 		f)
 			subflows_tests
@@ -2366,6 +2445,9 @@ while getopts 'fesltra64bpkdmuchCSi' opt; do
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

