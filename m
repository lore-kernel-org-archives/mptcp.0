Received: from de-smtp-delivery-102.mimecast.com (de-smtp-delivery-102.mimecast.com [194.104.109.102])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8395A2C80
	for <mptcp@lists.linux.dev>; Wed,  9 Feb 2022 08:58:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=mimecast20200619;
	t=1644397079;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=bouPZqDHPKxuer01UcxQQZu3KldZYvhRcHmEbtyW+1A=;
	b=mvYAXFKrbLGEgbda47JhiPvZDC5U1t0rrpxB5W6pdBMohsu4Rc72YcNJXXfgkkGY80Nob+
	sOdReY2CZRDe6G9wYjDy9jv2Eqe3wQAWJojgk+OlhkM47hQCqW3NybS3f/GX6PJVINBgDZ
	EnyYvV7BKNl1yot0AQGOWbwNUKkPg+U=
Received: from EUR03-DB5-obe.outbound.protection.outlook.com
 (mail-db5eur03lp2055.outbound.protection.outlook.com [104.47.10.55]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 de-mta-25-YbCxivoUNgW_PyoUqrb1yw-1; Wed, 09 Feb 2022 09:57:58 +0100
X-MC-Unique: YbCxivoUNgW_PyoUqrb1yw-1
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EqOw4qe6H2eeBGBNSKBYFAO5KCS8MJogYz6DpgxuUlVzxvywa7B9IgjHOI7M/dUHp+FhIiVpqI1iyFYykVf3z1pzWpxlCcjneQiOOGxYu2gQJ4h6lbl3qy27GBkzA2ZZCOJLytGmVuK7fQgXAIocpKfrkOd/5gKVYA02xSE41MkwgeiEYdsGDMf4B5AC4eGUWvHKGAGigEcD7CSXjCh7tHBO5o3m6fQhiTBFf0JtBCfSWroClyLuuSpYZ/fAOU2GX+Tmop+MgFvBvkf32DP+KlS4BeqmpnRt82PiBFHL9cx3KD3thVYTSqYmC7C21J9XOsdOyhOLxJuYqxuVvWlSqA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7YBtMKQLikWyPuaLDzjHW/HYsdEUkNThV/ODHQv54Kc=;
 b=idOVhjGT5YKh+r1LL/0aM9ug2iuJibIJdpDsKHe+OWKCRX/Q6BUSdV40Jq99NgYLdgv8gYRHElpK8Tpz7BvqOWYVmhWaCg+o4YVRzZzXsS3SqAxIqbESypAC47qRoDXSGycNcUjSSHkEigRIZm+dd8AGGGQmEyS6gavs5RFAQ2dcaERhhLlQ/NHxgJW/RMuAnNNgMiOzUym5a7PG00AlIYSYkH8IpkfqUS328cqes97nXRpH+IjJBIdp21jy2Lnsmvgx2qPl17h77foh3Wu53dIhw89G3+W/XQuA3i8GUDUfyYuBWXHC5wTnmo3XoDTMdVDBNHNQFX6x3cJArmhAdw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by AM9PR04MB7667.eurprd04.prod.outlook.com (2603:10a6:20b:2d5::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4975.11; Wed, 9 Feb
 2022 08:57:57 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::60de:f804:3830:f7c5]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::60de:f804:3830:f7c5%4]) with mapi id 15.20.4951.019; Wed, 9 Feb 2022
 08:57:57 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
CC: Geliang Tang <geliang.tang@suse.com>,
	Davide Caratti <dcaratti@redhat.com>,
	Matthieu Baerts <matthieu.baerts@tessares.net>
Subject: [PATCH mptcp-next v4 5/5] selftests: mptcp: add mp_fail testcases
Date: Wed,  9 Feb 2022 16:57:41 +0800
Message-ID: <7b3e19b0e0b8c3b651320897b25464e0f76806ff.1644396927.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1644396927.git.geliang.tang@suse.com>
References: <cover.1644396927.git.geliang.tang@suse.com>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-ClientProxiedBy: SG2PR06CA0162.apcprd06.prod.outlook.com
 (2603:1096:1:1e::16) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 1cc1393f-3075-44ae-5d38-08d9ebaa4464
X-MS-TrafficTypeDiagnostic: AM9PR04MB7667:EE_
X-Microsoft-Antispam-PRVS:
	<AM9PR04MB7667F20A04D92A1A428C4293F82E9@AM9PR04MB7667.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1247;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	2VQNIoo7Q7FgHH7N+Pg7EoobqPd6Wlu1/Ok/458w9SiKU1zanN2JdpcCDEyNGOr0jF/qjRFUEa7IEpRKY9AvGEKUoG0R6QVAWYI/IJ338b2Z1RiMaREs9k0j+oIoKo6SHeLiD/voOU9XPtWwoOpXqGU8p1MNWaBzr/IXMVTLnNpiXjfsYWiSUSXQWfOt24B58R4AXr34Ufqzij25fKXhP4ICmOZ+ULrDpnwzVkjIhclrnyGr++AG4pJlZThAQQS+GQuqLTwuwh6nC199VuO7tX2bWTAhNnB+TuDRLMZ6es9n9ZM0gr9E2jPtJCzEp93WIt/A9qEzHYqBmtS+LuRDtQnk2lqwhmqy16ctVVUo8c4zdC91dyMd0nALCJppLtGTlm4qFjwapYk31foDR650WSRiy8qOBC+wQztP6T/5D5zTvBxx58r6bYK6EYAkpbB5ZuzCJcdnShjMglCxuDhKxBFqgwpL5LdtHmKtT0s5RGRhwno36H2ZwZl0CwAHEU2pppGBIeLiL/OAbSUgWTs1MABOP8IRzK2u2f/j7RCoQ9njBMVk+7B0emO2XuEwljPxd4zYseiuyfDq4NRJCiEgPliOL/vVTtK7lyakxdZViuhz6gvOO33q4m4XdZkzQSY8AyfhVq8n3kLRLgZuLDKnKQ==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(508600001)(5660300002)(6506007)(186003)(26005)(55236004)(44832011)(30864003)(6486002)(66574015)(2906002)(6916009)(54906003)(6666004)(316002)(6512007)(8936002)(66556008)(66476007)(66946007)(38100700002)(36756003)(8676002)(4326008)(83380400001)(2616005)(86362001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?VmLpSrLLRSgqb32fKoIhnNYvliltRy0ePCq5nNlb0evWyfYrP6WbK5Gtpi91?=
 =?us-ascii?Q?0tlqQ6w7YhGmgV8UoPHzuSJ4e3LQTyZ2PWsS46+ERYtW/ODSDLYazpgEb6Jh?=
 =?us-ascii?Q?nzjMxCcIxkZH8BzPyI6s6Fo+qkf/S1XUZPCrZ2OaeC256U5J0xIHhj1E6Y6y?=
 =?us-ascii?Q?8uENjZreB3+T+GHm4UphLIGKnOTQI6xvVFqZCD8EIcrGXAzVRg2TPiZUstB7?=
 =?us-ascii?Q?ysbWrrKvkx/P/eqgWNAgJf5fCkJIwLFrApA62dOuGCsTlQ5itV9zOCk9uRo6?=
 =?us-ascii?Q?N6Dv5uVHzK20qBREtdtHT+tUSML3oCxmzMJjJSqEZiy0IYZU6HNjk7C3mlbA?=
 =?us-ascii?Q?U/3x1xuO/+jqxPL6y3+RJzZeux6W02EvIWtB8cYyvamYRKiscaLvAMmKNTsU?=
 =?us-ascii?Q?H4gYM3wKUUDJNZgFKRUA5WDOuA+Ua5jBCHAbQhvPNuYRXuFqwxymxENDRxK5?=
 =?us-ascii?Q?BVKnvQd5WhCrcmxTf86YNm2KM2Gxb/QlKSdnuIiEne4Vj4fx+kDZXAqdq5uP?=
 =?us-ascii?Q?7HrkO1PJ3u43NUAEwRdEm9F45q5ugUyQkpVKAkHcRFon7+uool7NjoCdBsYA?=
 =?us-ascii?Q?kjhsaq5N2pr2cfq9sLBux6Mzg4dR1ORQJF0p7R4vS+auqa1KZcDBw+rWjLRj?=
 =?us-ascii?Q?jALtBQJU3PnRCYDA/Np6rU/yKxGsK7HDvb5m7XKBXX/EaVVNSWYgpnWVxq54?=
 =?us-ascii?Q?63iFsNlTUm9gx3PbDjmFDtK/9MjY36eFReROwP5EG4EpADf4rub9kRTAHZV7?=
 =?us-ascii?Q?bA4eY6O59Lb/QYism5QnK23YLpbF24mwvdHfO8uZvurc9dPhbZWcodhC8xIv?=
 =?us-ascii?Q?MU2Z8nmvTIclFTH/9z8t4cF5n5KR2ZodnUh9OdUTs+q3pMZya/OHuJQKIkBh?=
 =?us-ascii?Q?a28Nin8dv1n9dak4FOzgxDJrSMXxNgFHEzdGN+jbwDw02G50RozlHIkI9AfG?=
 =?us-ascii?Q?U4vrha36qLav13MUCI6KY7uvIYlVepd696ollfzW3DsDekxKEqLu4cq6lTij?=
 =?us-ascii?Q?Y4T31ZbmWDwvtGFskXxxRPdT/h6ZYA/GGNdm0GDWbUSLFtcJtIad/HYnbveA?=
 =?us-ascii?Q?iQo6kHFfgptufrQSP2ahJ+JMIekybACSHDfVwR5ymJ2qgySOLk/z58onhh2j?=
 =?us-ascii?Q?6pffC3knZ1XTCaFSV+BH1t99PnxFDC5LS2EU9M+Q3iLy92W55qhnP6rNtauv?=
 =?us-ascii?Q?OKWeJw4HDCxC+O9XLpENMRdtnBGkfyEVHS2zaOw/sJk3FHuLrtsUA754SMf+?=
 =?us-ascii?Q?p/HXdN1xdwtpayD4lmtK8HdAn9QJiCUJXaDVjhV/sk6WWsDHFXJ9Tg6d+48a?=
 =?us-ascii?Q?bMU4pm6cZ61c5vkSZ0XSuL7PuxQAtroVeoZOi5g0d96a4LLv983b6/ZsM96j?=
 =?us-ascii?Q?5HyBq/pQlKKEcvr7/XeLWfN2lin7nP9dXPfs0mP6aeIn3umuYZkumlUsYj8Y?=
 =?us-ascii?Q?Kp5Si5S5ZrmpTa3GtNVrD0Dp5G9/y+7uJz9HcliXSTfb2PxYJWUxO8sKheJC?=
 =?us-ascii?Q?RSToycofyKzswpXy6hdvJxtN5JtyZIvLuq8r1/f5BAr1LygCOg5d/w2a68cz?=
 =?us-ascii?Q?UG7RKr8lpmrn8OtYxVJV+JSZmuNtW9BzpPbwx/advTue2FgJ7SSTzYn75sXK?=
 =?us-ascii?Q?BjzbleQGdYA91DKpuvdAhLs=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1cc1393f-3075-44ae-5d38-08d9ebaa4464
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Feb 2022 08:57:57.5906
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: nS4X56GuPsT5EZZJxkM9gNXjouI+DEpeUox5INER8l3o+84+NjL0v8yL+XqtN3g2QVSlPEoNHImqQck24Ove7g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB7667

Added the test cases for MP_FAIL, the multiple subflows test for the MP_RST
case and the single subflow one for the infinite mapping case.

These tests used the new test_linkfail value 3 to make 512KB test files for
both the client and server.

Added a new function reset_with_fail(), in it use 'iptables' and 'tc
action pedit' commands to trigger the checksum failures.

Added a new global variable pedit_action to trace whether the tc pedit
action happened during the test. Check and set it in the new function
pedit_action_happened(). Show it in the test description and pass it to
chk_join_nr() to check the numbers of the checksum failures, MP_FAIL
sending and receiving, the infinite mapping sending and receiving.

Added a new global variable validate_checksum to enable checksums for
the MP_FAIL tests without passing the '-C' argument.

Also added the tests needed kernel configures in the config file.

Suggested-by: Davide Caratti <dcaratti@redhat.com>
Co-developed-by: Matthieu Baerts <matthieu.baerts@tessares.net>
Signed-off-by: Matthieu Baerts <matthieu.baerts@tessares.net>
Signed-off-by: Geliang Tang <geliang.tang@suse.com>
---
 tools/testing/selftests/net/mptcp/config      |   8 +
 .../testing/selftests/net/mptcp/mptcp_join.sh | 172 +++++++++++++++---
 2 files changed, 158 insertions(+), 22 deletions(-)

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
index 95d61c97ccad..880430058492 100755
--- a/tools/testing/selftests/net/mptcp/mptcp_join.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_join.sh
@@ -17,6 +17,8 @@ capture=3D0
 checksum=3D0
 ip_mptcp=3D0
 check_invert=3D0
+validate_checksum=3D0
+pedit_action=3D0
 do_all_tests=3D1
=20
 TEST_COUNT=3D0
@@ -62,6 +64,7 @@ init()
 	done
=20
 	check_invert=3D0
+	validate_checksum=3D$checksum
=20
 	#  ns1              ns2
 	# ns1eth1    ns2eth1
@@ -167,6 +170,63 @@ reset_with_allow_join_id0()
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
+	pedit_action=3D0
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
+		-j MARK --set-mark 42
+	if [ $? -ne 0 ];then
+		echo "SKIP: Couldn not add the $tables rule"
+		exit $ksft_skip
+	fi
+
+	tc -n $ns2 qdisc add dev ns2eth$i clsact
+	tc -n $ns2 filter add dev ns2eth$i egress \
+		protocol ip prio 1000 \
+		handle 42 fw \
+		action pedit munge offset 148 u8 invert \
+		pipe csum tcp \
+		index 100
+}
+
 ip -Version > /dev/null 2>&1
 if [ $? -ne 0 ];then
 	echo "SKIP: Could not run test without ip tool"
@@ -185,6 +245,12 @@ if [ $? -ne 0 ];then
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
@@ -245,6 +311,19 @@ link_failure()
 	done
 }
=20
+pedit_action_happened()
+{
+	local i=3D"$1"
+
+	local action=3D$(tc -n $ns2 -j -s action show action pedit index 100)
+	local packets=3D$(echo $action | jq '.[1].actions[0].stats.packets')
+
+	if [ $packets !=3D "null" ] && [ $packets -gt 0 ]; then
+		pedit_action=3D1
+	fi
+	tc -n $ns2 qdisc del dev ns2eth$i clsact
+}
+
 # $1: IP address
 is_v6()
 {
@@ -446,7 +525,7 @@ do_transfer()
 		local_addr=3D"0.0.0.0"
 	fi
=20
-	if [ "$test_link_fail" -eq 2 ];then
+	if [ "$test_link_fail" -gt 1 ];then
 		timeout ${timeout_test} \
 			ip netns exec ${listener_ns} \
 				$mptcp_connect -t ${timeout_poll} -l -p $port -s ${srv_proto} \
@@ -466,13 +545,19 @@ do_transfer()
 			ip netns exec ${connector_ns} \
 				$mptcp_connect -t ${timeout_poll} -p $port -s ${cl_proto} \
 					$connect_addr < "$cin" > "$cout" &
-	else
+	elif [ "$test_link_fail" -eq 1 ] || [ "$test_link_fail" -eq 2 ];then
 		( cat "$cinfail" ; sleep 2; link_failure $listener_ns ; cat "$cinfail" )=
 | \
 			tee "$cinsent" | \
 			timeout ${timeout_test} \
 				ip netns exec ${connector_ns} \
 					$mptcp_connect -t ${timeout_poll} -p $port -s ${cl_proto} \
 						$connect_addr > "$cout" &
+	else
+		cat "$cinfail" | tee "$cinsent" | \
+		timeout ${timeout_test} \
+			ip netns exec ${connector_ns} \
+				$mptcp_connect -t ${timeout_poll} -p $port -s ${cl_proto} \
+					$connect_addr > "$cout" &
 	fi
 	cpid=3D$!
=20
@@ -632,7 +717,7 @@ do_transfer()
 		return 1
 	fi
=20
-	if [ "$test_link_fail" -eq 2 ];then
+	if [ "$test_link_fail" -gt 1 ];then
 		check_transfer $sinfail $cout "file received by client"
 	else
 		check_transfer $sin $cout "file received by client"
@@ -681,7 +766,12 @@ run_tests()
=20
 	# create the input file for the failure test when
 	# the first failure test run
-	if [ "$test_linkfail" -ne 0 -a -z "$cinfail" ]; then
+	if [ "$test_linkfail" -eq 3 ]; then
+		if [ -z "$cinfail" ]; then
+			cinfail=3D$(mktemp)
+		fi
+		make_file "$cinfail" "client" 512
+	elif [ "$test_linkfail" -ne 0 -a -z "$cinfail" ]; then
 		# the client file must be considerably larger
 		# of the maximum expected cwin value, or the
 		# link utilization will be not predicable
@@ -694,7 +784,12 @@ run_tests()
 		make_file "$cinfail" "client" $size
 	fi
=20
-	if [ "$test_linkfail" -eq 2 -a -z "$sinfail" ]; then
+	if [ "$test_linkfail" -eq 3 ]; then
+		if [ -z "$sinfail" ]; then
+			sinfail=3D$(mktemp)
+		fi
+		make_file "$sinfail" "server" 512
+	elif [ "$test_linkfail" -eq 2 -a -z "$sinfail" ]; then
 		size=3D$((RANDOM%16))
 		size=3D$((size+1))
 		size=3D$((size*2048))
@@ -719,6 +814,8 @@ dump_stats()
 chk_csum_nr()
 {
 	local msg=3D${1:-""}
+	local csum_ns1=3D${2:-0}
+	local csum_ns2=3D${3:-0}
 	local count
 	local dump_stats
=20
@@ -730,8 +827,8 @@ chk_csum_nr()
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
@@ -740,8 +837,8 @@ chk_csum_nr()
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
@@ -752,27 +849,27 @@ chk_csum_nr()
=20
 chk_fail_nr()
 {
-	local mp_fail_nr_tx=3D$1
-	local mp_fail_nr_rx=3D$2
+	local fail_tx=3D$1
+	local fail_rx=3D$2
 	local count
 	local dump_stats
=20
 	printf "%-${nr_blank}s %s" " " "ftx"
 	count=3D`ip netns exec $ns1 nstat -as | grep MPTcpExtMPFailTx | awk '{pri=
nt $2}'`
 	[ -z "$count" ] && count=3D0
-	if [ "$count" !=3D "$mp_fail_nr_tx" ]; then
-		echo "[fail] got $count MP_FAIL[s] TX expected $mp_fail_nr_tx"
+	if [ "$count" !=3D "$fail_tx" ]; then
+		echo "[fail] got $count MP_FAIL[s] TX expected $fail_tx"
 		ret=3D1
 		dump_stats=3D1
 	else
 		echo -n "[ ok ]"
 	fi
=20
-	echo -n " - frx   "
+	echo -n " - failrx"
 	count=3D`ip netns exec $ns2 nstat -as | grep MPTcpExtMPFailRx | awk '{pri=
nt $2}'`
 	[ -z "$count" ] && count=3D0
-	if [ "$count" !=3D "$mp_fail_nr_rx" ]; then
-		echo "[fail] got $count MP_FAIL[s] RX expected $mp_fail_nr_rx"
+	if [ "$count" !=3D "$fail_rx" ]; then
+		echo "[fail] got $count MP_FAIL[s] RX expected $fail_rx"
 		ret=3D1
 		dump_stats=3D1
 	else
@@ -852,6 +949,9 @@ chk_join_nr()
 	local syn_nr=3D$2
 	local syn_ack_nr=3D$3
 	local ack_nr=3D$4
+	local fail_nr=3D${5:-0}
+	local rst_nr=3D${6:-0}
+	local infi_nr=3D${7:-0}
 	local count
 	local dump_stats
=20
@@ -888,11 +988,11 @@ chk_join_nr()
 		echo "[ ok ]"
 	fi
 	[ "${dump_stats}" =3D 1 ] && dump_stats
-	if [ $checksum -eq 1 ]; then
-		chk_csum_nr
-		chk_fail_nr 0 0
-		chk_rst_nr 0 0
-		chk_infi_nr 0 0
+	if [ $validate_checksum -eq 1 ]; then
+		chk_csum_nr "" $fail_nr
+		chk_fail_nr $fail_nr $fail_nr
+		chk_rst_nr $rst_nr $rst_nr
+		chk_infi_nr $infi_nr $infi_nr
 	fi
 }
=20
@@ -2197,6 +2297,29 @@ userspace_tests()
 	chk_rm_nr 0 0
 }
=20
+fail_tests()
+{
+	# multiple subflows
+	reset_with_fail 2
+	pm_nl_set_limits $ns1 0 2
+	pm_nl_set_limits $ns2 0 2
+	pm_nl_add_endpoint $ns2 10.0.2.2 dev ns2eth2 flags subflow
+	pm_nl_add_endpoint $ns2 10.0.3.2 dev ns2eth3 flags subflow
+	run_tests $ns1 $ns2 10.0.1.1 3
+	pedit_action_happened 2
+	chk_join_nr "MP_FAIL MP_RST: $pedit_action pedit action" 2 2 2 \
+		$pedit_action $pedit_action
+
+	# single subflow
+	reset_with_fail 1
+	pm_nl_set_limits $ns1 0 2
+	pm_nl_set_limits $ns2 0 2
+	run_tests $ns1 $ns2 10.0.1.1 3
+	pedit_action_happened 1
+	chk_join_nr "MP_FAIL infinite map: $pedit_action pedit action" 0 0 0 \
+		$pedit_action 0 $pedit_action
+}
+
 all_tests()
 {
 	subflows_tests
@@ -2215,6 +2338,7 @@ all_tests()
 	deny_join_id0_tests
 	fullmesh_tests
 	userspace_tests
+	fail_tests
 }
=20
 usage()
@@ -2236,6 +2360,7 @@ usage()
 	echo "  -d deny_join_id0_tests"
 	echo "  -m fullmesh_tests"
 	echo "  -u userspace_tests"
+	echo "  -F fail_tests"
 	echo "  -c capture pcap files"
 	echo "  -C enable data checksum"
 	echo "  -i use ip mptcp"
@@ -2275,7 +2400,7 @@ if [ $do_all_tests -eq 1 ]; then
 	exit $ret
 fi
=20
-while getopts 'fesltra64bpkdmuchCSi' opt; do
+while getopts 'fesltra64bpkdmuchCSFi' opt; do
 	case $opt in
 		f)
 			subflows_tests
@@ -2325,6 +2450,9 @@ while getopts 'fesltra64bpkdmuchCSi' opt; do
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

