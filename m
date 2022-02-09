Received: from de-smtp-delivery-102.mimecast.com (de-smtp-delivery-102.mimecast.com [194.104.111.102])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EAEA12C9C
	for <mptcp@lists.linux.dev>; Wed,  9 Feb 2022 10:43:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=mimecast20200619;
	t=1644403428;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=QU3VaUyclKaS01pX0/3fH5AYCV0dKc1+aN82+DkVGr0=;
	b=KdW65ZghUbRtGBo1/Gbd8ommgcTiJI5vJ6PHzPc66IZsXB6KwYSEw1p9938eE4clYJofVU
	vgHmRgTjL0qvYWboOdQQy1fQz3cefMgyyYx/MJH2JzGZ2SBbhQrvLNmXWzK9eoAZHs3aTt
	2MpqK494v1qZy7OqjTRjZ1yEMqbQ7o0=
Received: from EUR05-VI1-obe.outbound.protection.outlook.com
 (mail-vi1eur05lp2177.outbound.protection.outlook.com [104.47.17.177]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 de-mta-40-x2orhLW-MYSgZpLZS8mV2Q-1; Wed, 09 Feb 2022 11:43:47 +0100
X-MC-Unique: x2orhLW-MYSgZpLZS8mV2Q-1
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Rtqueo0auNE77eXsP7ON1GrSIhiTOPTZ+ETlALjpobQNUT/+OdZdbl2iWGN3Zx35EF22n4Vz/h9Q7dK3E/w1z2qWZXR5Y4J+H5vCl93p3x6A8DrkGKKbkflntIrbrxwJSjb0jnR7zxxEPtS+6kupc5ygS+QtqwnVpDn4S4TZnSbw30GrDhppiTaVcFqXQ009d9jFhpS8ocnkpuNCxmVHSHovZPybiXrsjVjWSu3UKj5HJysGViuzNb3AMKIYwIUdQG38lniHWzgI0/DbPoVKvrED9DO8msv4JW1O3RWACgMCCBpYXdalEAltvu8D9ROBtQ2wSODN/opdvwqFqRLruQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oJz7VZQLwIqNEpar7GIKTE0t0IyIy/Uvdn5hlzmZp1Y=;
 b=EyeEUBEalWk4kYjtOIv5h830AKcV8hovvF6wakt+U9zgQgqbunLvS2XCsNddfb+gCIoN7JtmRVmunAWTp/E8pqIEO9QJ4RnNf39za2mhlIy9cN2t9QFJJLAXxv0f4mrZcZTxJmOIVU9qRXpgkOhSD62tNelS/JYAIN0hRQZsfhAvi7stBFvOudE0c79qMxQk0wlY1ImRJs/x5rMJlcojK6Mser7blMuA4twIDZ5t7Ns/hKj+q2TSujspq6fOygXQqblElrCRitGvhi65H9cW65jw3UgkeaJKLfRQiXA/2sz+68y1Kq03epwOf3RwaNMjwYwPZ55eDx5kh8VAi5CCLg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by AM7PR04MB6997.eurprd04.prod.outlook.com (2603:10a6:20b:10d::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4975.11; Wed, 9 Feb
 2022 10:43:45 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::60de:f804:3830:f7c5]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::60de:f804:3830:f7c5%4]) with mapi id 15.20.4951.019; Wed, 9 Feb 2022
 10:43:45 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
CC: Geliang Tang <geliang.tang@suse.com>,
	Davide Caratti <dcaratti@redhat.com>,
	Matthieu Baerts <matthieu.baerts@tessares.net>
Subject: [PATCH mptcp-next v5 5/5] selftests: mptcp: add mp_fail testcases
Date: Wed,  9 Feb 2022 18:43:13 +0800
Message-ID: <c1dd2b5c0105f42b9fb12447011d3830c057ac57.1644402973.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1644402973.git.geliang.tang@suse.com>
References: <cover.1644402973.git.geliang.tang@suse.com>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-ClientProxiedBy: HK2PR03CA0043.apcprd03.prod.outlook.com
 (2603:1096:202:17::13) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 1885a671-b451-46c9-8223-08d9ebb90c0a
X-MS-TrafficTypeDiagnostic: AM7PR04MB6997:EE_
X-Microsoft-Antispam-PRVS:
	<AM7PR04MB6997A309729D39E15389C8EEF82E9@AM7PR04MB6997.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1247;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	wjsRc62ZH2ec6x5FU1W3e2Xx5UrFuqPsRz2he9eTwF2id3CxxYZ3BijU6So400nibR9lqpQHghIMpnkF+fYpB+EdQa53oYn6S6jWZ/WQx6jcmnYHgVfZpZKwcNJ8STBcUCwcmBF09Dh0vbE5vf3UP1zJDkk+TWI86M47t+y16N5tbDK3KcXEFsbooOG9KVFPQoU67R32bNlGM7GM+VMPWLdL/2TD5nemoaLem+TPxeIKz+qljE0k4qLYa2WZeBtvrwpl9T3TNCDvipUtMcSvRqLxIzh7YXeFeEM3NIs9MDwcYt4zMentmt3dasj4gIbt32a3QEhjIUTXVGnWcE8g+k3BJH84vipKzkVMVu6fLdIK7verhFt/JFmjREpWrlKJBaJbBu2Yc8/AgnYkTpfNCd02FGM8a0zNHm+ePoxI3CFNDxIioSbxuZkQy/DLr0pHOlIZsmua1Kj4Gq5+IfkQW9L0i/ZSlrwaRVOQxFLfOPj4dq/pGW/uBOtO3gFHrfGLZZQczneg6zjKRJJUXoNVdyXlrUfC3XFCbnXlurUXtJuqrsRyGT6tFraDG4r4xejChfNHhDimiHs1xpz6j7q1AHJZB0JptupNFf12pRRFQbNb5ZvZ+xZvhcUvaiGX2v6AAsIZIxJzGFVcUVpnwCdKcQ==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(83380400001)(316002)(6666004)(44832011)(38100700002)(26005)(54906003)(6916009)(2616005)(6506007)(2906002)(5660300002)(508600001)(66574015)(66946007)(36756003)(66556008)(6512007)(66476007)(4326008)(8676002)(55236004)(186003)(8936002)(6486002)(86362001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?lumFPOecWmRF6X32/7vJyJV0fCV/s6JUnoXes6nUsQxYcJEg2vbpj5/jTHYL?=
 =?us-ascii?Q?Xs6b5ou70qguzmCcVjU9udtUZQI4dj2ylS4YWA0XbiOfQbq4jhTD0Uolva/R?=
 =?us-ascii?Q?HMVhr+T/VkLNlLTk0fO1N45xRLSWPgvqzP7m14/jfgcvQrqdpuZceq2nDR1I?=
 =?us-ascii?Q?qcQg+1n32yk6D0FDpZFuvxvYYswIZ5XWWtJs1FK8EuOsqYH0tNh0/C2gvDan?=
 =?us-ascii?Q?m23y8A2lun1V/4mHTSMoLyx5RRijNzok6EeHhRNnc+O62R7AFoxpy4PxS79j?=
 =?us-ascii?Q?Dk+BRGJYeQnNGhaDt4n0abdWCMMKVHW4ek5KbcOkiwqq2DwrFOgFmQ4fMASr?=
 =?us-ascii?Q?g8jQQGCaKgucufsCxSNfCgKO1erC53VwsSFX4UPdOCCAe9xv7wXW+bXlqQD5?=
 =?us-ascii?Q?7o3/DWuW4zNPNlaEe1GqN1xo2y2Zj/O/nS0y1Aj0HKBBwe9k6Vy72RqLsFvx?=
 =?us-ascii?Q?vfUJQQwSC3Vecszra8ZlysUH133an5SC9/1hGCY7EH0/ma8L6hGVOmsr7tPa?=
 =?us-ascii?Q?t6ySsSe/28tuCqNWN+31CoglEb3F0ApuOaZHkJoWgy9/WeBq0FmaaDdpk539?=
 =?us-ascii?Q?j3zGY7z3E8gtCF9JEanU+DRQ5yR3ldTOUp2tbmGgE35PRHowVDtvmjdHF3E4?=
 =?us-ascii?Q?2SVQkH9OlL6IgnHOmykuIvLJtqtxLrxhl2Bf8nfgdEEFVpygrB+vF4tO8fx7?=
 =?us-ascii?Q?g+cv8eKg65AMlI+G6vTaclD3A5GRiMo62jEnTvZMqY26cjR5sJZGhJPXAWWX?=
 =?us-ascii?Q?hNxhRwUo+D+c+W80FFIvpzmU89PQZ3qj2EYkWMui8kOzdMHtdcJ0pD6XYYyM?=
 =?us-ascii?Q?revv2rwKg0Tjp6969hDcaSCW5mt4OE/Omb5dAAZ7yagbk4CWxvQ5lOxA4Q+a?=
 =?us-ascii?Q?q1aZNH+1TDUwgg0r8aWSqxOo1XmQfT/Jc3ehkJVlRrvnofm8pgkaGhErMkeV?=
 =?us-ascii?Q?w57qJVxf7HtvVpV5nIVqm3IJvzQjolxWCSU9l5SuPk74AQ8xi1SDZUEduSEl?=
 =?us-ascii?Q?68sUc+NaOGtyCbVo5msAJ30SAB/H8ZtZ1jXpyYCBJ/kHx2LEXEqZ5tK/ncEj?=
 =?us-ascii?Q?p5X1eJYNY5oAh7ygyqZJFub8zc6obzZZtDKrWkpsEfjdr5evuSWJayzJ4q8L?=
 =?us-ascii?Q?mOsZdQomJdcleTBizrkpaiJoOAkbHVpnw6EcNyIhVSUerSKLKf/Jrk2e830j?=
 =?us-ascii?Q?hskbxPu0xtKqQd8lCoZiEB1AHzTAPc+lcDii+YE/suc5r8otObK9mgJmCnr/?=
 =?us-ascii?Q?tfAskdjKmFKFFVmfuCnTOZLH1Bk/y2cP0+txBLr6ckdDDO0DDzrLs0T774cf?=
 =?us-ascii?Q?pMQ+KDIIo2pQxDfQQJCsVLIh0PH2RVb3cpsSA+Cc3AzS0BFi6WnGXPmTCygb?=
 =?us-ascii?Q?/zZV7q2UOoMLdD2whWUGPBkD+PmUFyf6FM9mzw0iXLL3CzyVNfliKn+QEfnt?=
 =?us-ascii?Q?/WqKLuaCu6Uoiq7/f8OY8AlwMkfYeMeBoAaEmD/Zj+QVs4CMlUhSTI4tExy2?=
 =?us-ascii?Q?1zqc1glpB0Zi02k/zoyCZ0apkxhDH2Pf4GNgeZiyRq9XTaRlKjeLRVadML68?=
 =?us-ascii?Q?2I5WXdi5bH1Ek902ES3E7OtOVrOXCE12YvLzMiqFpiIlmt+DXOlNx2ld5aYz?=
 =?us-ascii?Q?FVgTXnmPslG4royywBY+etc=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1885a671-b451-46c9-8223-08d9ebb90c0a
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Feb 2022 10:43:45.6096
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mOcVgN6PU8qnRBgJBMa0binDSR5o8Gde/hUfO8wCPRY/cBcwiGg4yQkJlrzeHFSkqjLsfx/doRYOV55d4Y1gDg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR04MB6997

Added the test cases for MP_FAIL, the multiple subflows test for the MP_RST
case and the single subflow one for the infinite mapping case.

These tests used the new test_linkfail value 3 to make 1024KB test files
for both the client and server.

Added a new function reset_with_fail(), in it use 'iptables' and 'tc
action pedit' commands to trigger the checksum failures.

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
 tools/testing/selftests/net/mptcp/config      |   8 +
 .../testing/selftests/net/mptcp/mptcp_join.sh | 147 +++++++++++++++---
 2 files changed, 133 insertions(+), 22 deletions(-)

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
index 95d61c97ccad..9f5c9afc26d2 100755
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
@@ -245,6 +299,12 @@ link_failure()
 	done
 }
=20
+pedit_action_pkts()
+{
+	tc -n $ns2 -j -s action show action pedit index 100 | \
+		sed 's/.*"packets":\([0-9]\+\),.*/\1/'
+}
+
 # $1: IP address
 is_v6()
 {
@@ -446,7 +506,7 @@ do_transfer()
 		local_addr=3D"0.0.0.0"
 	fi
=20
-	if [ "$test_link_fail" -eq 2 ];then
+	if [ "$test_link_fail" -gt 1 ];then
 		timeout ${timeout_test} \
 			ip netns exec ${listener_ns} \
 				$mptcp_connect -t ${timeout_poll} -l -p $port -s ${srv_proto} \
@@ -466,13 +526,19 @@ do_transfer()
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
@@ -632,7 +698,7 @@ do_transfer()
 		return 1
 	fi
=20
-	if [ "$test_link_fail" -eq 2 ];then
+	if [ "$test_link_fail" -gt 1 ];then
 		check_transfer $sinfail $cout "file received by client"
 	else
 		check_transfer $sin $cout "file received by client"
@@ -681,7 +747,12 @@ run_tests()
=20
 	# create the input file for the failure test when
 	# the first failure test run
-	if [ "$test_linkfail" -ne 0 -a -z "$cinfail" ]; then
+	if [ "$test_linkfail" -eq 3 ]; then
+		if [ -z "$cinfail" ]; then
+			cinfail=3D$(mktemp)
+		fi
+		make_file "$cinfail" "client" 1024
+	elif [ "$test_linkfail" -ne 0 -a -z "$cinfail" ]; then
 		# the client file must be considerably larger
 		# of the maximum expected cwin value, or the
 		# link utilization will be not predicable
@@ -694,7 +765,12 @@ run_tests()
 		make_file "$cinfail" "client" $size
 	fi
=20
-	if [ "$test_linkfail" -eq 2 -a -z "$sinfail" ]; then
+	if [ "$test_linkfail" -eq 3 ]; then
+		if [ -z "$sinfail" ]; then
+			sinfail=3D$(mktemp)
+		fi
+		make_file "$sinfail" "server" 1024
+	elif [ "$test_linkfail" -eq 2 -a -z "$sinfail" ]; then
 		size=3D$((RANDOM%16))
 		size=3D$((size+1))
 		size=3D$((size*2048))
@@ -719,6 +795,8 @@ dump_stats()
 chk_csum_nr()
 {
 	local msg=3D${1:-""}
+	local csum_ns1=3D${2:-0}
+	local csum_ns2=3D${3:-0}
 	local count
 	local dump_stats
=20
@@ -730,8 +808,8 @@ chk_csum_nr()
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
@@ -740,8 +818,8 @@ chk_csum_nr()
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
@@ -752,27 +830,27 @@ chk_csum_nr()
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
@@ -852,6 +930,9 @@ chk_join_nr()
 	local syn_nr=3D$2
 	local syn_ack_nr=3D$3
 	local ack_nr=3D$4
+	local fail_nr=3D${5:-0}
+	local rst_nr=3D${6:-0}
+	local infi_nr=3D${7:-0}
 	local count
 	local dump_stats
=20
@@ -888,11 +969,11 @@ chk_join_nr()
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
@@ -2197,6 +2278,23 @@ userspace_tests()
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
+	chk_join_nr "MP_FAIL MP_RST: $(pedit_action_pkts) corrupted pkts" 2 2 2 1=
 1
+
+	# single subflow
+	reset_with_fail 1
+	run_tests $ns1 $ns2 10.0.1.1 3
+	chk_join_nr "Infinite map: $(pedit_action_pkts) corrupted pkts" 0 0 0 1 0=
 1
+}
+
 all_tests()
 {
 	subflows_tests
@@ -2215,6 +2313,7 @@ all_tests()
 	deny_join_id0_tests
 	fullmesh_tests
 	userspace_tests
+	fail_tests
 }
=20
 usage()
@@ -2236,6 +2335,7 @@ usage()
 	echo "  -d deny_join_id0_tests"
 	echo "  -m fullmesh_tests"
 	echo "  -u userspace_tests"
+	echo "  -F fail_tests"
 	echo "  -c capture pcap files"
 	echo "  -C enable data checksum"
 	echo "  -i use ip mptcp"
@@ -2275,7 +2375,7 @@ if [ $do_all_tests -eq 1 ]; then
 	exit $ret
 fi
=20
-while getopts 'fesltra64bpkdmuchCSi' opt; do
+while getopts 'fesltra64bpkdmuchCSFi' opt; do
 	case $opt in
 		f)
 			subflows_tests
@@ -2325,6 +2425,9 @@ while getopts 'fesltra64bpkdmuchCSi' opt; do
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

