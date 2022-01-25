Received: from de-smtp-delivery-102.mimecast.com (de-smtp-delivery-102.mimecast.com [194.104.109.102])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E6D12CA7
	for <mptcp@lists.linux.dev>; Tue, 25 Jan 2022 11:49:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=mimecast20200619;
	t=1643111364;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=BrE4sQ4G4emRkhJq0dPFZQAl919e7BdO3styhVR3ER0=;
	b=CcfCshYkab0BzQbef0EkxTFNNcV18KwX3nbrNJime9p/jXInz+3cdH+ccn+yDFz37W6Fdk
	i1AuW5+4iLOTJm7rJlZr8RG+E/juMUZ5EQQQ6z3SLjHx5ji0MWj+9MSpZu0Vrdjfyc5UPx
	bZKxsSChAUg4rA5g3Ay3I2idcwy96aQ=
Received: from EUR04-VI1-obe.outbound.protection.outlook.com
 (mail-vi1eur04lp2057.outbound.protection.outlook.com [104.47.14.57]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 de-mta-25-nljFjQjaNzurZ0Pa43JSuw-1; Tue, 25 Jan 2022 12:49:22 +0100
X-MC-Unique: nljFjQjaNzurZ0Pa43JSuw-1
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SHhKDDBIWhOmUHxMLhR+t9ED2Ep7H7DtmokjiazNF7m0+WZ4WYvgvuJpZLA5qQuOmlv9mKcnGFUMFQi9J6ZULoYx6a/SlbDS0xKRK4lrn1vNS2RuWqEdHssT/0Wzuiku7EDwViKJ2oPO4BQ0+n0oAb2PSDmzxw4E7jaYyEuO+jdco5M3iLLYvNaOEpTBy6t0PTgjEKiY7DHB9BJEvFMhDX43at9VZL2o5phHbETcW3kJIIB6H0hHjMfgW1TbNo6jYzjdld1v465rVj123Fu8gxU5RBmcZbJXuumqvCrFL2wyxnaunUms+2zBQAODbbaZdkiLmiDxCA8kBSEojEdudg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pCP5Cds2A0YG4wArLMRu641uTx4GRF4J3Pt4ajhzH7c=;
 b=PyKahReNZ5cBv5U5StfX3cRoj7DG9I6nsnCIu4gxZrm3vYVe8nPhPQztYYJw3k34xk27HVgtLK6zlGFtgfXe14BCZp6gT+UPSYYhySkZl6SPTRnQ5G/2gvE1Oh+B0br4yRuPyXPHFe9mxlLhGcp2790mIRdo2fkMxTx7BjXZBEv5FKKKseExH5l+ejaxtHr0+zbwtRot6Q5MRg6TofQDUghI8cT7h5oZ4a4fXn9Ks0BXIit0sKdQH/3KwFF4LZvLsH02azFMaDYDoYcKMkqIOiCCoTaO/R7fgbGzLIXD1Y9W2oZ6hYDKZoNHKo7yG56s28fmLXiJPEx7qh8b5hCvzg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by AM6PR04MB4775.eurprd04.prod.outlook.com (2603:10a6:20b:3::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4909.19; Tue, 25 Jan
 2022 11:49:20 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::fcd9:b39c:2b94:f13c]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::fcd9:b39c:2b94:f13c%7]) with mapi id 15.20.4909.019; Tue, 25 Jan 2022
 11:49:20 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
CC: Geliang Tang <geliang.tang@suse.com>,
	Davide Caratti <dcaratti@redhat.com>,
	Matthieu Baerts <matthieu.baerts@tessares.net>
Subject: [PATCH mptcp-next 3/3] selftests: mptcp: add mp_fail testcases
Date: Tue, 25 Jan 2022 19:49:01 +0800
Message-ID: <064cfe306debc535413c1d39fcf3b8d24a959eeb.1643110285.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <cover.1643110285.git.geliang.tang@suse.com>
References: <cover.1643110285.git.geliang.tang@suse.com>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-ClientProxiedBy: HK2PR02CA0183.apcprd02.prod.outlook.com
 (2603:1096:201:21::19) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 48e14783-cf6e-4285-5b26-08d9dff8b964
X-MS-TrafficTypeDiagnostic: AM6PR04MB4775:EE_
X-Microsoft-Antispam-PRVS:
	<AM6PR04MB4775DEC5A3B3CFCC725666A4F85F9@AM6PR04MB4775.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1060;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	7OpMwKqpKGKsFSuF17KgHCylz8kTGF0bsZ7mFLLJSpQC4yyNAgHYnKC3yp6MWU9OfpCvWR1Hyc14LM6LT+IVgdALjkMsvfjiOBlUWW+ytT2xrA8fbA2XAyM2K4bhBaJkQ49bSDlt9jLnQ6i3mAiHA16uUO9otNwRzAdJyhhM3H1IZEm2kynfvod6XRsDuy6yXN9eVYTHy85Gc8Tk1XwzO7iswWYoLlv1ADjl4tXmQQKELr9LESvsKhxU3HSv16q8HbOMcWOTjLKnt0j9PPfp1xbk8oClMt0KsIf+8DfH8Vy9DPLJ74lk+NjTRpDzydetBoCSZXzatP+k5cnl3KF4pK/3nOqygWHjH/CQk3CeBsCbMvV9tZPmqB/NjhiWHiFPd2Oq6PnR2cXQ1FgYsDgxeWe9y/hU3sx1jFS0MZVFQD6Z0moylgGp2RY5bU65JL1alvO5dR3pSKQFhgQ2JCTANK6q64a8G+5jVbUSJlvqPaFEWBe02ePqHdLk5r8N1gQXx7d8mwVLjrTE4/wAx/nXyEWW19+J12Y5pvKNt1wptl5gh9QcEQPtiwpcQ9UDF4xbeCjKTWacPjBlmQSTwMxJwhxJ4+O2FNbuJvlR46Qjm9g15MNTDFqF/qE1hFCfO/mUcs+MiIRthLkNaXrBnMg16g==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(83380400001)(44832011)(66574015)(316002)(186003)(5660300002)(38100700002)(6916009)(2616005)(54906003)(36756003)(66556008)(8676002)(8936002)(508600001)(6486002)(66946007)(2906002)(66476007)(6512007)(4326008)(26005)(6666004)(55236004)(86362001)(6506007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Q+xq6uOQYPUo5aNHbshF7Gox3wFyhFefLY5bHGTgQr7Qjl7nUFqJ8XUxmsgT?=
 =?us-ascii?Q?laaLs47+5Jg9PP8JjBK86/bYcW7Xw5rsqKs98dJgVjGD/NWyrAfwy4HjYcD2?=
 =?us-ascii?Q?k5KewY3pOUnAyfLOedrWOxYW1jP/45H4uMQmf9txLG4jDsDXlJshwiOXlVrr?=
 =?us-ascii?Q?CQdq6582GTCHE9QTsmusJ/YBRCBMDutMAY+X0KcUEWaYyjBaayUP2h6MT2hG?=
 =?us-ascii?Q?PHGENvedNFkhJWePy6QpNNZl8BOs0xHJsK3SCPbiL9pTEYdP71LFLJCmM1+S?=
 =?us-ascii?Q?3h+l9pmAHW8EpweA0rA2FM86tDUOLMpCLKQtyKwJ96qocgHGUivhbu6aeWKz?=
 =?us-ascii?Q?zLwJ2ehYGIljPYp7+E/ZKClei1Gp1+e1jLujUsARZ7M8tbgTt0TZ+WdmbVOf?=
 =?us-ascii?Q?/iefv/2lNmBa+b+S2lJPgZUZPXYEpKfNxHLG9SqVmm9VmH4uXFIisTjXS2aj?=
 =?us-ascii?Q?L9yZ/2NHS0ClsOmx2TNLG4J9s9vkvzSXsqCri9x8wiv3K0PJjARsvGtzbTrY?=
 =?us-ascii?Q?JcRd2yOuPAmue+x2QSREbpm1s2ZwL+rJj3iNWYM6pqB+bNATgHvLJxxsK5Vs?=
 =?us-ascii?Q?IVLs6/1J1Vat18Uqk6CWuU/51G0Emi7Gz3L91M7RYYtxtGq3ksBEzmZQKFfE?=
 =?us-ascii?Q?6HcVXwWG+V6+LH3PHZmt3LMSKxvaxSsJxKG1EsYdBoGxp3rMb1ocyUR5wvA7?=
 =?us-ascii?Q?LmLWy1xMHBSVSueYXC6aUR38R4nlVC7VVwFErJc7LKPEmS2VHAHzWQzLZgwe?=
 =?us-ascii?Q?SdoXvGnM+ZIsSRFTVSpfmIeZiXD/PagjjwBF9vxiJ3rLceucXxXU4isb35VE?=
 =?us-ascii?Q?0iRzTXhA6I1Lof33QMtQZtW2KyrlJqcY8NA31aYV8VmYwT/4C+p5g0lj5YwX?=
 =?us-ascii?Q?+It3jqzatjWXLqPlqdMLhTANU3QrdSe6ifH5zP8ZwRQrdNdFjlLwBVUzBEPH?=
 =?us-ascii?Q?Vae+ouQd9n1mEalLKWw78NJxMw3mtEPbTJ/6vvyeDtjXPtswpXJbKM3buQ2Y?=
 =?us-ascii?Q?oYU+lFlOb83/q5G8SAvFMQrRV0FIM+WPIxbPgt7XfS0nW16v1xstOZyw7xyR?=
 =?us-ascii?Q?OX0u4DvVObmFXaBb4xsRp8ZNVkTLmbiZHSrzCsU1WKKCrxT0wWmXs6IcQaPV?=
 =?us-ascii?Q?Z7VpCs8wLxalJ+5IKcAVfEVNJt8AfFsK1j+Ig4obz2yT0/JiUHIZfCtAT706?=
 =?us-ascii?Q?VypTPnmzOvciJS/wIjBrwtpK5VALIZORDb/cBFJm1blwMqPzvpvVKtIsNu05?=
 =?us-ascii?Q?FLoTLGPdK61RVgxu7PHX1UMs88oL/fyWFuXNNXxr0gFzZt2DWOdL6aJrPWcR?=
 =?us-ascii?Q?CORoE7q7hqF6wOmAlz2U1PPIogsdfJjQSq8XPHTu5n6bywwmE1GVWKbHo2SM?=
 =?us-ascii?Q?V6Oe2hurtuEaIaIPQmLVdihSQGpPQjonirXAJ5C/oZRaGTJ20OXf+cw73Dhr?=
 =?us-ascii?Q?7YzcuHxTJfkNsA9HIx2zuiLpZNRQQoek4qAoFwyrkdXv1c2PCsOEzJO8/KkV?=
 =?us-ascii?Q?I7WLxpKYkNfJ7zqKhPD5oJ4NcjwV8GmcytWS5ymlnIvV8wcXX13lHMgaRhTq?=
 =?us-ascii?Q?Hc9uxygcXpxyGA4P5QPts5gwha/e6JlT2SfB3291x3RstgM4tI1riaglzJ1L?=
 =?us-ascii?Q?5/3DWaV8k0b4H7fMu6aK7UY=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 48e14783-cf6e-4285-5b26-08d9dff8b964
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Jan 2022 11:49:20.8005
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: HHoKH0mnfChpR4+9HIqP6nyXPpiV1nDvlQ8sYcLNKW3QEZEpMB8Jv3zjiRewlAAJW/xbflhJ/kpOzqbm9PpASA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR04MB4775

Added the test cases for MP_FAIL, use 'tc' commands to trigger the
checksum failures.

Suggested-by: Davide Caratti <dcaratti@redhat.com>
Co-developed-by: Matthieu Baerts <matthieu.baerts@tessares.net>
Signed-off-by: Matthieu Baerts <matthieu.baerts@tessares.net>
Signed-off-by: Geliang Tang <geliang.tang@suse.com>
---
 tools/testing/selftests/net/mptcp/config      |   5 +
 .../testing/selftests/net/mptcp/mptcp_join.sh | 148 +++++++++++++++---
 2 files changed, 135 insertions(+), 18 deletions(-)

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
index 76c45c845d3b..44176419ff1d 100755
--- a/tools/testing/selftests/net/mptcp/mptcp_join.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_join.sh
@@ -17,6 +17,8 @@ capture=3D0
 checksum=3D0
 ip_mptcp=3D0
 check_invert=3D0
+validate_checksum=3D0
+nr_fail=3D0
 do_all_tests=3D1
=20
 TEST_COUNT=3D0
@@ -61,6 +63,7 @@ init()
 	done
=20
 	check_invert=3D0
+	validate_checksum=3D$checksum
=20
 	#  ns1              ns2
 	# ns1eth1    ns2eth1
@@ -166,6 +169,46 @@ reset_with_allow_join_id0()
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
+	check_invert=3D1
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
@@ -184,6 +227,12 @@ if [ $? -ne 0 ];then
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
@@ -244,6 +293,21 @@ link_failure()
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
@@ -458,7 +522,7 @@ do_transfer()
 		local_addr=3D"0.0.0.0"
 	fi
=20
-	if [ "$test_link_fail" -eq 2 ];then
+	if [ "$test_link_fail" -gt 1 ];then
 		timeout ${timeout_test} \
 			ip netns exec ${listener_ns} \
 				$mptcp_connect -t ${timeout_poll} -l -p $port -s ${srv_proto} \
@@ -478,13 +542,19 @@ do_transfer()
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
@@ -652,7 +722,7 @@ do_transfer()
 		return 1
 	fi
=20
-	if [ "$test_link_fail" -eq 2 ];then
+	if [ "$test_link_fail" -gt 1 ];then
 		check_transfer $sinfail $cout "file received by client"
 	else
 		check_transfer $sin $cout "file received by client"
@@ -701,7 +771,13 @@ run_tests()
=20
 	# create the input file for the failure test when
 	# the first failure test run
-	if [ "$test_linkfail" -ne 0 -a -z "$cinfail" ]; then
+	if [ "$test_linkfail" -eq 3 ]; then
+		cinfail=3D$(mktemp)
+		make_file "$cinfail" "client" 10240
+	elif [ "$test_linkfail" -eq 4 ]; then
+		cinfail=3D$(mktemp)
+		make_file "$cinfail" "client" 512
+	elif [ "$test_linkfail" -ne 0 -a -z "$cinfail" ]; then
 		# the client file must be considerably larger
 		# of the maximum expected cwin value, or the
 		# link utilization will be not predicable
@@ -714,7 +790,13 @@ run_tests()
 		make_file "$cinfail" "client" $size
 	fi
=20
-	if [ "$test_linkfail" -eq 2 -a -z "$sinfail" ]; then
+	if [ "$test_linkfail" -eq 3 ]; then
+		sinfail=3D$(mktemp)
+		make_file "$sinfail" "server" 10240
+	elif [ "$test_linkfail" -eq 4 ]; then
+		sinfail=3D$(mktemp)
+		make_file "$sinfail" "server" 512
+	elif [ "$test_linkfail" -eq 2 -a -z "$sinfail" ]; then
 		size=3D$((RANDOM%16))
 		size=3D$((size+1))
 		size=3D$((size*2048))
@@ -739,6 +821,8 @@ dump_stats()
 chk_csum_nr()
 {
 	local msg=3D${1:-""}
+	local csum_ns1=3D${2:-0}
+	local csum_ns2=3D${3:-0}
 	local count
 	local dump_stats
=20
@@ -750,8 +834,8 @@ chk_csum_nr()
 	printf " %-36s %s" "$msg" "sum"
 	count=3D`ip netns exec $ns1 nstat -as | grep MPTcpExtDataCsumErr | awk '{=
print $2}'`
 	[ -z "$count" ] && count=3D0
-	if [ "$count" !=3D 0 ]; then
-		echo "[fail] got $count data checksum error[s] expected 0"
+	if [ "$count" -lt $csum_ns1 ]; then
+		echo "[fail] got $count data checksum error[s] expected $csum_ns1"
 		ret=3D1
 		dump_stats=3D1
 	else
@@ -760,8 +844,8 @@ chk_csum_nr()
 	echo -n " - csum  "
 	count=3D`ip netns exec $ns2 nstat -as | grep MPTcpExtDataCsumErr | awk '{=
print $2}'`
 	[ -z "$count" ] && count=3D0
-	if [ "$count" !=3D 0 ]; then
-		echo "[fail] got $count data checksum error[s] expected 0"
+	if [ "$count" -lt $csum_ns2 ]; then
+		echo "[fail] got $count data checksum error[s] expected $csum_ns2"
 		ret=3D1
 		dump_stats=3D1
 	else
@@ -780,7 +864,7 @@ chk_fail_nr()
 	printf "%-39s %s" " " "ftx"
 	count=3D`ip netns exec $ns1 nstat -as | grep MPTcpExtMPFailTx | awk '{pri=
nt $2}'`
 	[ -z "$count" ] && count=3D0
-	if [ "$count" !=3D "$mp_fail_nr_tx" ]; then
+	if [ "$count" -lt "$mp_fail_nr_tx" ]; then
 		echo "[fail] got $count MP_FAIL[s] TX expected $mp_fail_nr_tx"
 		ret=3D1
 		dump_stats=3D1
@@ -791,7 +875,7 @@ chk_fail_nr()
 	echo -n " - frx   "
 	count=3D`ip netns exec $ns2 nstat -as | grep MPTcpExtMPFailRx | awk '{pri=
nt $2}'`
 	[ -z "$count" ] && count=3D0
-	if [ "$count" !=3D "$mp_fail_nr_rx" ]; then
+	if [ "$count" -lt "$mp_fail_nr_rx" ]; then
 		echo "[fail] got $count MP_FAIL[s] RX expected $mp_fail_nr_rx"
 		ret=3D1
 		dump_stats=3D1
@@ -812,7 +896,7 @@ chk_infi_nr()
 	printf "%-39s %s" " " "itx"
 	count=3D`ip netns exec $ns2 nstat -as | grep InfiniteMapTx | awk '{print =
$2}'`
 	[ -z "$count" ] && count=3D0
-	if [ "$count" !=3D "$mp_infi_nr_tx" ]; then
+	if [ "$count" -lt "$mp_infi_nr_tx" ]; then
 		echo "[fail] got $count infinite map[s] TX expected $mp_infi_nr_tx"
 		ret=3D1
 		dump_stats=3D1
@@ -823,7 +907,7 @@ chk_infi_nr()
 	echo -n " - irx   "
 	count=3D`ip netns exec $ns1 nstat -as | grep InfiniteMapRx | awk '{print =
$2}'`
 	[ -z "$count" ] && count=3D0
-	if [ "$count" !=3D "$mp_infi_nr_rx" ]; then
+	if [ "$count" -lt "$mp_infi_nr_rx" ]; then
 		echo "[fail] got $count infinite map[s] RX expected $mp_infi_nr_rx"
 		ret=3D1
 		dump_stats=3D1
@@ -840,6 +924,8 @@ chk_join_nr()
 	local syn_nr=3D$2
 	local syn_ack_nr=3D$3
 	local ack_nr=3D$4
+	local fail_nr=3D${5:-0}
+	local infi_nr=3D${6:-0}
 	local count
 	local dump_stats
=20
@@ -876,10 +962,10 @@ chk_join_nr()
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
@@ -2183,6 +2269,27 @@ userspace_tests()
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
+	get_nr_fail 2
+	chk_join_nr "$nr_fail MP_FAIL, multiple subflows" 2 2 2 $nr_fail
+
+	# single subflow
+	reset_with_fail 1
+	pm_nl_set_limits $ns1 0 2
+	pm_nl_set_limits $ns2 0 2
+	run_tests $ns1 $ns2 10.0.1.1 4
+	get_nr_fail 1
+	chk_join_nr "$nr_fail MP_FAIL, single subflow" 0 0 0 $nr_fail 0
+}
+
 all_tests()
 {
 	subflows_tests
@@ -2201,6 +2308,7 @@ all_tests()
 	deny_join_id0_tests
 	fullmesh_tests
 	userspace_tests
+	fail_tests
 }
=20
 usage()
@@ -2222,6 +2330,7 @@ usage()
 	echo "  -d deny_join_id0_tests"
 	echo "  -m fullmesh_tests"
 	echo "  -u userspace_tests"
+	echo "  -F fail_tests"
 	echo "  -c capture pcap files"
 	echo "  -C enable data checksum"
 	echo "  -i use ip mptcp"
@@ -2261,7 +2370,7 @@ if [ $do_all_tests -eq 1 ]; then
 	exit $ret
 fi
=20
-while getopts 'fesltra64bpkdmuchCSi' opt; do
+while getopts 'fesltra64bpkdmuchCSFi' opt; do
 	case $opt in
 		f)
 			subflows_tests
@@ -2311,6 +2420,9 @@ while getopts 'fesltra64bpkdmuchCSi' opt; do
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

