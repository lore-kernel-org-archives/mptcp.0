Received: from de-smtp-delivery-102.mimecast.com (de-smtp-delivery-102.mimecast.com [194.104.109.102])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71E8E2C80
	for <mptcp@lists.linux.dev>; Tue,  8 Feb 2022 23:59:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=mimecast20200619;
	t=1644364753;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=29pTi2M6pXySMsZcAeG4cIfGAH8Qnaxl3tAsyOa71BQ=;
	b=GWWdDU+V5L6KoAdZQhRqxdKMX0IJxraUA5budobgw6S2/KnIiwb15vzODNMb/bdaiTxZcB
	1JqUaWnPu7Layaf3DP63/ARxbytmGsiLLULroGixrLS6Oga9gsQDztVNQN5yl10OljBEH9
	Uo3OII4u1NHoCd2qnBvFQD4UbhdrMNk=
Received: from EUR04-DB3-obe.outbound.protection.outlook.com
 (mail-db3eur04lp2053.outbound.protection.outlook.com [104.47.12.53]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 de-mta-23-CFkWtOoJPKqJ1gKO9-uI4w-1; Wed, 09 Feb 2022 00:59:12 +0100
X-MC-Unique: CFkWtOoJPKqJ1gKO9-uI4w-1
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RBJUOrxp4RGkMKHoNy6ECw/ytUyhMVV4DtPUNIzvSpKR6DP515M3EweSDo+yLTNu2/O6kr9miWT4bCMozT+F8W2ZmW46E32nzhAwSini+FK2oNvWgpM0Fc0kRHIPKtv4Pej8k35XZFPttyVZE8x1YEjBL6Xz2FHwU9WiVP+cAlyo3Q+JBV3WMbsiaRso+FncHC5oFmTdLDSCorlmKWREqqH2R4jpJBrWY4OhGPSi4/In/6M3YeZk2PRSdotznk9l2GIzz5YI3IWUR8uLsPnq5+nLkqWN2q5dgzrlFz0LCSPyZ+FRJWPMw4Yup28NCyHA+5kmPLB4QKiMnh8lxfJK7w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pPJz6Mvp6guWd8GRNWsM4x32ViJ+GGJjbLgtQ0zR93w=;
 b=oMvdhI6VJBo4S5dRIktMyv42ECg4EFP4GJFyJUWsA8IF9UhEEXPKszAB0W4rLJG08bwSv+raTgwJZneNQdO1chjNwxsbyRFn1jeGMfYLReiCBoKXzAAnu40n+s9IflVRyrStOnbua1J+YUMI6ClAIdq1NXQxdYSbyQ40Fs8J7Mg1bn+e9RQiGLIeBA236KQlkIL3ZqQEC5a5LaZHPBMB08CoXJcbmSBXdKsceqbzOoYLvMZkkbKZ9YyQdvDRMGAJ5A2CTb0j5TjYtjOUFQicyrcbAyHsU93P/C7uby0e26fhlaL9Uqf+pAycBxtpFwXJ+A+dT+o8qZmvq2Ae1KIMvA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by VI1PR04MB2959.eurprd04.prod.outlook.com (2603:10a6:802:8::25) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4975.11; Tue, 8 Feb
 2022 23:59:11 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::60de:f804:3830:f7c5]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::60de:f804:3830:f7c5%4]) with mapi id 15.20.4951.019; Tue, 8 Feb 2022
 23:59:11 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
CC: Geliang Tang <geliang.tang@suse.com>,
	Davide Caratti <dcaratti@redhat.com>,
	Matthieu Baerts <matthieu.baerts@tessares.net>
Subject: [PATCH mptcp-next v2 2/2] selftests: mptcp: add mp_fail testcases
Date: Wed,  9 Feb 2022 07:59:16 +0800
Message-ID: <846d7cac1f134fe9d3b6e8ac2b0c0ab47defc341.1644364562.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1644364562.git.geliang.tang@suse.com>
References: <cover.1644364562.git.geliang.tang@suse.com>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-ClientProxiedBy: HK2PR03CA0062.apcprd03.prod.outlook.com
 (2603:1096:202:17::32) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 893af25a-6366-437f-b886-08d9eb5f0055
X-MS-TrafficTypeDiagnostic: VI1PR04MB2959:EE_
X-Microsoft-Antispam-PRVS:
	<VI1PR04MB2959006E2492ED6E197BAF7DF82D9@VI1PR04MB2959.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1051;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	d7uoe51xJIfsbWDciY2IAE0ALCeOUZnOoo7Et6b20QwIJnMaAGEaJ7ipSpP8lhEU9M8FcIri5vfPanwsSEnQFYn5U8T1JaVe6vm/MkvUEihu91eCP8ZjF6EOd4CtjUfHJCH0UEehWP95sGDWzTEfE0btGadhHhubLlrWdS05IDvzgcDv95YPhBhRKsctrBaS+SPgah9A2OtdfGpvaYMpjFQOPZZp/1XHnZ0EcYD10oSBzfYLgOUoQNcz+p5ZNwUCS3Cn0Li88kkScRlZWixHHhUUb/Zaf8k9P3l4wjg+A16/xp2omtjS8M6f+Ws68/GGPuNsHyO5zm4cCeawID3KEmwrvTFqmqH5n3+0B7YflP1IZO3zFgOKa/8tJA/FTxKqlgmufuGRr7r5/uA0hb0SLhwbZSgSY7/sgWPvoG1lqN3PAzCLN5eAa45egdQIJmwvcoKnonU05gKTgIajFWPeUaMVgbBYNPqi1GZS4vUMIrzjzG03RjGj9bh6YzHjMXMbwbPauSxRNxv0j7kSs8ZxzDVMSSUSYG12iohRRK1gwEDHdQRvMXfdHFeHYXmQ7lnVMmFUQZtv6lUiwG9Loo0orQN3d3MP42GT+oig0tK8Xm4EY/X8A7Renk9ytjaRGZCuFDm8NcBUiE9PfDOVN0hQdg==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(8936002)(2906002)(83380400001)(2616005)(5660300002)(44832011)(6506007)(6512007)(36756003)(38100700002)(186003)(66574015)(86362001)(66556008)(508600001)(6916009)(54906003)(8676002)(4326008)(66476007)(66946007)(6486002)(316002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?7I7SezyE8tXg7PcXvlzMDCOkjkjhyJzm3LcpILcDu7h+0RNqskNpFo2GlFRG?=
 =?us-ascii?Q?PREbQmHD75ndDGXh2gFPZ8/akv1aVnS+n17dTRuI/MbwC5yob8CP1eVhCRti?=
 =?us-ascii?Q?7iyBJDq8lw8rZWNBafFtbbQtFoiGZFZJ/6N02p2Feqa+U3vuziKT5/EKguGn?=
 =?us-ascii?Q?XRsbij4Tlo1QO1Mo9pqHJQIbsd5NOAMMk5DZiIiWmi5DT8QnS3uoBz7PQqPl?=
 =?us-ascii?Q?6xx3jInyvaW5JlN2Rkdhxuwu4Jn1wChKEW9XSb9567eFeTmPgJAE5MDVniL4?=
 =?us-ascii?Q?82plsIR0aVic0fpYJ8Mvqo/JgytZrlcgHUUD/tjl+bCgmPxUFpP/QmoQOOE1?=
 =?us-ascii?Q?7BN54dqPbfUdXVI8KjepZ0l3BAAykQRYnXjE6+omBoGQVtxalnBNL0QkU2nj?=
 =?us-ascii?Q?3tWhF1UgxkdIievsnEotfoCctLNzI3ACSXP0hxYiAR4jypa3ktpc3aAEa29M?=
 =?us-ascii?Q?0+6yA57gh6f1QyarRPH275smwJNy4Pzxrr0/N3yavAKFFK0ArxyC6u+Y62RC?=
 =?us-ascii?Q?vsYrGFyIbDPzW/9Sr+q0DLQ/s37euBiA5W8dtIn87HxA8+jzWHACA9bgE+Ic?=
 =?us-ascii?Q?i+nS+4NsFbyHrL2cwKk0k5cBZBYDkExwMFPaLRC61FuEK1yysd0yDpzziS0E?=
 =?us-ascii?Q?V06ER22Ezas8RFGaF6lZ57+iqnBy9kYDGyjLjZcQ3LYKdVIDp+GrVJ2LXRc2?=
 =?us-ascii?Q?weRHONJgFfxzj52VtCq7EPOb7mnvMUGuLZPeIoO5JTnthWI9e95GH4CDM/3p?=
 =?us-ascii?Q?jOJ84qDiiGJJAxDLaKO9gL3lVjUp1fiVfzFb03Fh8DFtfv3uj/IjG0z+/wxP?=
 =?us-ascii?Q?L6+EmgAwh6E7471gsvFEQb0O7iBLX1iGMwfLfBoJyMOCMS4SIX3r/jU48Qwt?=
 =?us-ascii?Q?CSY3MkpmRsoZOX7lulSXtAnSfq0jDA7v23J3AMGKHt6F54hCCTRwQwdz/8OT?=
 =?us-ascii?Q?VR78tWYnXbLAgKBjX4uS8bPJkK/1VWvVByG2KYCA7rLtcxjBD5zormfadXMl?=
 =?us-ascii?Q?RNQ7lRB5JJi8lDZJ9fOHf4fid8p61Y+G3wxclBF13IPodOxEpCNYROH3BC30?=
 =?us-ascii?Q?diS+/5MsmL2UUwiffFv/aZWScxpeqK2jf5cgX/hfqiel3lwKaMTy+mLkwTrw?=
 =?us-ascii?Q?e5agU7YMHWe0HExhKW4/3FH/zx+ma1p0AN9MxmiBYkoI1JDTXaOo7seHDyng?=
 =?us-ascii?Q?TZIMMxr/RBZfE71hADhr+8d18k0ylWcFohub6gdRXR3pL7tJtfZaLh9yb1sF?=
 =?us-ascii?Q?85XcuF/OYFiadd7WNpCLzlHIlQgYT4Nx0wcfMCT5wvmNfnQwBiS6ecQcvUF+?=
 =?us-ascii?Q?Qs/aDQVTwJezbroGMyaxn7q3Zjwnys6NQOFHkDpynXuEW6/1AO+qqQtCFWdn?=
 =?us-ascii?Q?Xz1LACx3Lsb0GqZX+Rzi1eb+ES+ERCJLZEnuNfLmKfHeBrgs8npuTu4F9Mxv?=
 =?us-ascii?Q?hht/sw+uZPXEtKkPcOk3mKnAQjkPVVZc+/90+DBq35Ekn8NNZynFrPZWDoFN?=
 =?us-ascii?Q?wWxVQjDIgGA14IdODM1pDxdyAf1ISp7eYMYMC276aQX7bxUVN5IJOiYbx2FY?=
 =?us-ascii?Q?1EN7zT3MnwHbXcbCVgcR72nviTlaZNCGFm4HBzYovQZzmHDSNMqcr8p2EHWl?=
 =?us-ascii?Q?xByNpeIZDxlnX6Gk3dBPOjvQRjqacbRILdWKlgS6nF7O6LgZ9olet3gbGhvU?=
 =?us-ascii?Q?K337G8JG3w8/k59Cn95wWbG+gWQ=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 893af25a-6366-437f-b886-08d9eb5f0055
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Feb 2022 23:59:11.0924
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: W+UxUByyW+o0iLL14gBwYw075Y0gz/b1V29/asCyBTEaFv7gFjeywKzH+MtdlnLZifCVgEYl84ju3Ewb/QFCaA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB2959

Added the test cases for MP_FAIL, the multiple subflows test for MP_RST
and the single subflow test for the infinite mapping, use 'tc' commands
to trigger the checksum failures.

Suggested-by: Davide Caratti <dcaratti@redhat.com>
Co-developed-by: Matthieu Baerts <matthieu.baerts@tessares.net>
Signed-off-by: Matthieu Baerts <matthieu.baerts@tessares.net>
Signed-off-by: Geliang Tang <geliang.tang@suse.com>
---
 tools/testing/selftests/net/mptcp/config      |   8 +
 .../testing/selftests/net/mptcp/mptcp_join.sh | 142 ++++++++++++++++--
 2 files changed, 136 insertions(+), 14 deletions(-)

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
index 90a6adc36490..686c54276ea9 100755
--- a/tools/testing/selftests/net/mptcp/mptcp_join.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_join.sh
@@ -17,6 +17,8 @@ capture=3D0
 checksum=3D0
 ip_mptcp=3D0
 check_invert=3D0
+validate_checksum=3D0
+nr_mp_fail=3D0
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
@@ -167,6 +170,52 @@ reset_with_allow_join_id0()
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
+	nr_mp_fail=3D0
+	local i=3D"$1"
+
+	ip netns exec $ns2 iptables \
+		-t mangle \
+		-A OUTPUT \
+		-o ns2eth$i \
+		-p tcp \
+		-m length --length 150:9999 \
+		-m statistic --mode nth --packet 1 --every 99999 \
+		-j MARK --set-mark 42
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
@@ -185,6 +234,12 @@ if [ $? -ne 0 ];then
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
@@ -245,6 +300,19 @@ link_failure()
 	done
 }
=20
+get_nr_mp_fail()
+{
+	i=3D"$1"
+
+	local action=3D$(tc -n $ns2 -j -s action show action pedit index 100)
+	local packets=3D$(echo $action | jq '.[1].actions[0].stats.packets')
+
+	if [ $packets -gt 0 ]; then
+		nr_mp_fail=3D1
+	fi
+	tc -n $ns2 qdisc del dev ns2eth$i clsact
+}
+
 # $1: IP address
 is_v6()
 {
@@ -446,7 +514,7 @@ do_transfer()
 		local_addr=3D"0.0.0.0"
 	fi
=20
-	if [ "$test_link_fail" -eq 2 ];then
+	if [ "$test_link_fail" -gt 1 ];then
 		timeout ${timeout_test} \
 			ip netns exec ${listener_ns} \
 				$mptcp_connect -t ${timeout_poll} -l -p $port -s ${srv_proto} \
@@ -466,13 +534,19 @@ do_transfer()
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
@@ -632,7 +706,7 @@ do_transfer()
 		return 1
 	fi
=20
-	if [ "$test_link_fail" -eq 2 ];then
+	if [ "$test_link_fail" -gt 1 ];then
 		check_transfer $sinfail $cout "file received by client"
 	else
 		check_transfer $sin $cout "file received by client"
@@ -681,7 +755,12 @@ run_tests()
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
@@ -694,7 +773,12 @@ run_tests()
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
@@ -719,6 +803,8 @@ dump_stats()
 chk_csum_nr()
 {
 	local msg=3D${1:-""}
+	local csum_ns1=3D${2:-0}
+	local csum_ns2=3D${3:-0}
 	local count
 	local dump_stats
=20
@@ -730,8 +816,8 @@ chk_csum_nr()
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
@@ -740,8 +826,8 @@ chk_csum_nr()
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
@@ -820,6 +906,8 @@ chk_join_nr()
 	local syn_nr=3D$2
 	local syn_ack_nr=3D$3
 	local ack_nr=3D$4
+	local fail_nr=3D${5:-0}
+	local infi_nr=3D${6:-0}
 	local count
 	local dump_stats
=20
@@ -856,10 +944,10 @@ chk_join_nr()
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
@@ -2164,6 +2252,27 @@ userspace_tests()
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
+	get_nr_mp_fail 2
+	chk_join_nr "$nr_mp_fail MP_FAIL, multiple subflows, MP_RST" 2 2 2 $nr_mp=
_fail
+
+	# single subflow
+	reset_with_fail 1
+	pm_nl_set_limits $ns1 0 2
+	pm_nl_set_limits $ns2 0 2
+	run_tests $ns1 $ns2 10.0.1.1 3
+	get_nr_mp_fail 1
+	chk_join_nr "$nr_mp_fail MP_FAIL, single subflow, infinite" 0 0 0 $nr_mp_=
fail $nr_mp_fail
+}
+
 all_tests()
 {
 	subflows_tests
@@ -2182,6 +2291,7 @@ all_tests()
 	deny_join_id0_tests
 	fullmesh_tests
 	userspace_tests
+	fail_tests
 }
=20
 usage()
@@ -2203,6 +2313,7 @@ usage()
 	echo "  -d deny_join_id0_tests"
 	echo "  -m fullmesh_tests"
 	echo "  -u userspace_tests"
+	echo "  -F fail_tests"
 	echo "  -c capture pcap files"
 	echo "  -C enable data checksum"
 	echo "  -i use ip mptcp"
@@ -2242,7 +2353,7 @@ if [ $do_all_tests -eq 1 ]; then
 	exit $ret
 fi
=20
-while getopts 'fesltra64bpkdmuchCSi' opt; do
+while getopts 'fesltra64bpkdmuchCSFi' opt; do
 	case $opt in
 		f)
 			subflows_tests
@@ -2292,6 +2403,9 @@ while getopts 'fesltra64bpkdmuchCSi' opt; do
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

