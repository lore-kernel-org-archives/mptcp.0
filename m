Received: from de-smtp-delivery-102.mimecast.com (de-smtp-delivery-102.mimecast.com [194.104.109.102])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4CCC2C80
	for <mptcp@lists.linux.dev>; Wed,  9 Feb 2022 04:53:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=mimecast20200619;
	t=1644382397;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=KcJ1aWLgv+fNnbDb9xOYZh49c8B1p+HZ6IV0vDMCBEY=;
	b=JmCgdov/a/VSmBYGYrpMec8wYs+/hOHqvuM0YwhggEGN+7ViGwxwiZ0OqHwa/Yjsabt8mk
	aLwWFjzkYnoIr/aRkKH3fff5oawLwHcTRP+BDk5IndDkaFl9XK5y9Funw3MhBLQKLPkgyq
	XWEjae6miJadT1GHx9losn3IrlZ1rwE=
Received: from EUR04-DB3-obe.outbound.protection.outlook.com
 (mail-db3eur04lp2056.outbound.protection.outlook.com [104.47.12.56]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 de-mta-11-ZMPt1lpPPni78pDLLdmcsw-1; Wed, 09 Feb 2022 05:53:16 +0100
X-MC-Unique: ZMPt1lpPPni78pDLLdmcsw-1
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RtN95qWnOOUSMRunlB9EFxYdth64mdBu0sKYnwyNXE3lzSVI+efUmdgsGipK/Cxsu7S8ZIEXvN3nyhS0tjthZbO6MXWkLZg14jFVZdqD3o7W+RMYMTJ3sXjjSEC16Ps0H4E9bqX+9SsslHgZjQjksVgzP52eGNxdp8TxRuQh5PNkrYoQCCsjIBQ6qTRxATDEuMNSjK+AhGBjhZYN3PadLn+DdP8kUboLaQDHHe8b6q1EGLlbzXdlP7fARKeQTIvST7MDWOs70Cdt5TqyCanMcG5g3LREIjZaik82jwlWdEYMs0dSWOv52BLHSmhkibQPyLqBRukgINPJ1UqtN8yqrA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NQ5EFr7KeiGbdecZFK+5bCXEf+UNShXWTqbKOiPRq04=;
 b=W/osZ2ifiihHqPHFkRKa+dsTo3K+6sxlQheHkNgazNgSMC/s/kUun6mTk2XU2MnpbAFkOanM3xvywgtpCWQT+nTBEcaZn8S+JSnrlRah0Zb1TgwFhXOKLnunjuMIf7NPDZv8Jwu7bCNfSY71weVk4JYhE89Xo/O/UJjEPidu8B/n3Ibj0bREkz/MPkkpszktJiD3cFxDLDZPPaCmIJR8yl85oua/mhivD3gv17A2w2NfnjH2se2asFTxPs8PKgo2SRrP5Nx4/XWgS1QdwnNuEsjHnq9mG2LUSc3bGERTpOa7qYQWmrRCB9FDamTyCMkHwvZdJezCObL10BdSIaHwMQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by VI1PR04MB6125.eurprd04.prod.outlook.com (2603:10a6:803:f9::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4975.11; Wed, 9 Feb
 2022 04:53:14 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::60de:f804:3830:f7c5]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::60de:f804:3830:f7c5%4]) with mapi id 15.20.4951.019; Wed, 9 Feb 2022
 04:53:14 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
CC: Geliang Tang <geliang.tang@suse.com>,
	Davide Caratti <dcaratti@redhat.com>,
	Matthieu Baerts <matthieu.baerts@tessares.net>
Subject: [PATCH mptcp-next v3 2/2] selftests: mptcp: add mp_fail testcases
Date: Wed,  9 Feb 2022 12:53:20 +0800
Message-ID: <0402469dc9a18e8db24fb5c2e87a8af43aec6c6c.1644381932.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1644381932.git.geliang.tang@suse.com>
References: <cover.1644381932.git.geliang.tang@suse.com>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-ClientProxiedBy: HKAPR04CA0009.apcprd04.prod.outlook.com
 (2603:1096:203:d0::19) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: e0b80f5d-ff62-4f71-a90f-08d9eb881492
X-MS-TrafficTypeDiagnostic: VI1PR04MB6125:EE_
X-Microsoft-Antispam-PRVS:
	<VI1PR04MB61257A8390AE6FF087EFBCD9F82E9@VI1PR04MB6125.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1247;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	ktAyO9n+BYWddw3bFdhYQ734Q6VQjcqe/dUPfeELkv51Ha0hLGTHqUaP4k2sNcpJ9un/NeaZtZD+8IR2FpNWlVGrEe/zc4JCicbqExjofQqbsR2bWJNAlGdlL+lJq4SqWwotVJP4yMXYzlsKt0GMdMKushmdgJyUAKcQHAZG7Z/Spw7nVMHw5FFPlLMdN+g2fU64Ve2ZF5nBe3m2RWmIUmelAOmbQy2N9ne2xKDF279Wahe2uJeHjHZELde/oAwunmKT37W4xC4aN0DZQhs4GzvGfwBE/TdRwMCDpNaSIllj1OSNkkKGgo5I0Ov0Y8J4lcDvNj9Nz0VkElhxZF1MuOazUpCDaXMUSCxmILVpnC3Ujq2mVrb23Y5fMxxN0O3bFpvE7g96J12z5I5YSn9WuSMQ0NGJ4H/kJqTyba/UgxhtqWyGSB4tNrOffxryOzFLEfLv2a1Vj2M7DY4/V52cWb9m90Qp/+Z6/WCMp6YnIvspAvM/LkjniFuC4p6gbXiS5JSYeBAnWpfZA4yqGCi1zDiwl3CGc8wOgR/H8y5sSdQZs1zOhEj9js3/ttcNwg8HLkFIEgIDXcpovnfBUpoITeyX/FOZtclkR+EPqXu5FmwbMaUYWW5Hn6oMkw3mpi1341qlduGKmIaNE7+AmmcYSw==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(186003)(55236004)(26005)(6506007)(6512007)(2616005)(6666004)(66574015)(83380400001)(44832011)(2906002)(8936002)(5660300002)(6916009)(508600001)(4326008)(66476007)(8676002)(6486002)(54906003)(66946007)(66556008)(316002)(86362001)(38100700002)(36756003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?k3uPYJEGBdT6gNx7P0a0OOt0oH8XVhQ1d5nSffqNKyvxaGo3Va56tdgbm2Uj?=
 =?us-ascii?Q?P6yNtm9p9JznRVhgcvjborIlXB1MTbiXxvrPv8KBMrYfwrKH1ackF+lDyhuU?=
 =?us-ascii?Q?xw4PzMO2vYVnvhnnG8Z0d/Wwp0jaECtPZ6qaVc8Z5OrpzQEKuEYA+tnyjjhi?=
 =?us-ascii?Q?L+ONhyfwkD55avsFGKUUW43tL0kkEgHBbRmFZZc8zLjWH9NcO8ouyNasAkPT?=
 =?us-ascii?Q?QTKvTU6F8E4dqXJMu2gAmWdve2UniKC4DfJFVxAdT7Wip3ldrGoFUcg9q+gW?=
 =?us-ascii?Q?WHBXJCwfl4Lhj9r/ql9+4byE+4Ow4b8rBBZVomYE6jYPh8PMQa65VTobt7G1?=
 =?us-ascii?Q?I9MAOgAyvd+XQluPFJzGIMQksYiImradEuRuwabUbRn1b4KeK+XOG/TQtJb8?=
 =?us-ascii?Q?UWfB1+y2odS43GD5s9hs0+RyQPKTzL6wUIe8r9O2pq3jpMrUQS9DIgXQLbRK?=
 =?us-ascii?Q?6HoiJfqbRAx5mh6WQ1iVnTYCZka4xBgJKEMTHIYlL6lpBNw50MwqOm7QvSqR?=
 =?us-ascii?Q?NZl+poijtt8p11GvP/iOO3Z/ovgLjNex1lOHujQSSIR6CV+gtyFTI5kCSnUr?=
 =?us-ascii?Q?YJ4qbzn16iqhdBkmtYgGnlzn+Im5QqGFSWehTcQR3mXen5wQwnJWtUxbZmc7?=
 =?us-ascii?Q?s/B2deiN2Vs4iWDjwTDUTpcUIgsa+JWqFTQRaBTGcGzDtbOvwa7dhvlFqbi/?=
 =?us-ascii?Q?vIBi+d83mI2ovw2xEaf7g42cod4RqERL2j6tAS6SBihqoW9vBVxXJuFOYfg8?=
 =?us-ascii?Q?qtw+/78M7gtiM9YKeG8Qm8U2mpxkzagzFn+KLR4HZeK8IjQa8VHlRiDhf/gH?=
 =?us-ascii?Q?4I6Xj0ENBbxnvRiwv/otWOVLaxjkkpSmP47bjdjxdTEJ0qG/LxOW6v/6GkkG?=
 =?us-ascii?Q?jdbDXugJbVbLDPbatmD2OmsnTL+rOrufCosB/Zrx7CXAYiSOBaQzhhLo66yR?=
 =?us-ascii?Q?1zHK86bujmo5OioJiZGrGA0it6sASHgqEzv/aEMHTdxW4m4n8IusydO1P8aD?=
 =?us-ascii?Q?jynZ7nauFzXC9nqxv90mA1LiE5pqrwuYW+WbRtIm2zYI4JctaV/eLQLCHmrt?=
 =?us-ascii?Q?7RCvUQ+AC7LTXkBON9e5+QnhjMLFP6TpndNvojfFtUTGIF0mWYF9VN2l4bdU?=
 =?us-ascii?Q?sRIIapfCbbt9T1QEzZk6ISesRJIj8leDAvMC9rvCKdtSfccZK9qK4p+V121N?=
 =?us-ascii?Q?zSoxCITi/j2kCYeUAv7aD1oxLokvT6XSKQRF60epAx9s1OX2ZMn511iXjL61?=
 =?us-ascii?Q?dECHW7RPTM2FnjhDhADLLP3ROvGPqYoobjmdcLncvJ8X4LrksffOqQSGGXMs?=
 =?us-ascii?Q?SN0n+mTBuIRJPmjLCyhrs36UilKvpIBJhIQG8FcYqiZ5lXr2EHJiTr8dTPz2?=
 =?us-ascii?Q?NAHN/OETURv40qHvdKjKlvRG7G9HG2JNFyc+3uBU+aooCeI3SYRafJMopQbG?=
 =?us-ascii?Q?xsK9qpnalnsQaDzrpn+rBkNr7R9Q19oNjwbyUMIx2ueKOCPD97N2FQ4GZmxs?=
 =?us-ascii?Q?3yUs6qnQXmZZkx8eteh7JvWq9PWoyegDk7OX1gnepjvCTJS/m3IuWLql9Uyx?=
 =?us-ascii?Q?yzjkk433E7mS8w3LZ0saeTXUyJ3EBLLzXwR9qpQHJmL4pJPgNtTTQw1cr/aC?=
 =?us-ascii?Q?+PTunohRcjxpQtAL6AsoNas=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e0b80f5d-ff62-4f71-a90f-08d9eb881492
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Feb 2022 04:53:14.5058
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: XCzFpZzx4b0Knz15gmDpizC2VLF3QuXegRKJIpp2/FqasVH73qQ0BltPqKLWd4ey6PbhTz8qa9cshpzWI/xNDQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB6125

Added the test cases for MP_FAIL, the multiple subflows test for the MP_RST
case and the single subflow one for the infinite mapping case.

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
 .../testing/selftests/net/mptcp/mptcp_join.sh | 154 ++++++++++++++++--
 2 files changed, 148 insertions(+), 14 deletions(-)

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
index 90a6adc36490..a62f737805ab 100755
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
+	i=3D"$1"
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
@@ -820,6 +917,8 @@ chk_join_nr()
 	local syn_nr=3D$2
 	local syn_ack_nr=3D$3
 	local ack_nr=3D$4
+	local fail_nr=3D${5:-0}
+	local infi_nr=3D${6:-0}
 	local count
 	local dump_stats
=20
@@ -856,10 +955,10 @@ chk_join_nr()
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
@@ -2164,6 +2263,28 @@ userspace_tests()
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
+	chk_join_nr "MP_FAIL MP_RST: $pedit_action pedit action" 2 2 2 $pedit_act=
ion
+
+	# single subflow
+	reset_with_fail 1
+	pm_nl_set_limits $ns1 0 2
+	pm_nl_set_limits $ns2 0 2
+	run_tests $ns1 $ns2 10.0.1.1 3
+	pedit_action_happened 1
+	chk_join_nr "MP_FAIL infinite map: $pedit_action pedit action" 0 0 0 \
+		$pedit_action $pedit_action
+}
+
 all_tests()
 {
 	subflows_tests
@@ -2182,6 +2303,7 @@ all_tests()
 	deny_join_id0_tests
 	fullmesh_tests
 	userspace_tests
+	fail_tests
 }
=20
 usage()
@@ -2203,6 +2325,7 @@ usage()
 	echo "  -d deny_join_id0_tests"
 	echo "  -m fullmesh_tests"
 	echo "  -u userspace_tests"
+	echo "  -F fail_tests"
 	echo "  -c capture pcap files"
 	echo "  -C enable data checksum"
 	echo "  -i use ip mptcp"
@@ -2242,7 +2365,7 @@ if [ $do_all_tests -eq 1 ]; then
 	exit $ret
 fi
=20
-while getopts 'fesltra64bpkdmuchCSi' opt; do
+while getopts 'fesltra64bpkdmuchCSFi' opt; do
 	case $opt in
 		f)
 			subflows_tests
@@ -2292,6 +2415,9 @@ while getopts 'fesltra64bpkdmuchCSi' opt; do
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

