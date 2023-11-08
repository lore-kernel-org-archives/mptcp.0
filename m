Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2074.outbound.protection.outlook.com [40.107.21.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7CF7171CF
	for <mptcp@lists.linux.dev>; Wed,  8 Nov 2023 14:13:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="DolwF1Qo"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eCujJqLQqOuVlUWrm6ic/MY3sDDN5LfMyi3zw+jjQ2H4F4ocYWu+t3ftkIh+6fTw0BoQurED+uPia5QplVnY6XG/dL2IERdMlWkNdM4BokkLYg/FK6VHXn5pIxYdJdLtgVqpqsodDYO2zAg2Y3o2G5twX8YWI/eVE4VXCLIDqKxz5S/nc8jJ/w17Yh2dy+I3IsKSutZltTKYY16HxKSBacjwkxVjvXXcoPMrPe8CD1pRwFU8Glyei71rDNccXiR2Ra1ccr77AX+1ukxoeEKcRDTuwJtVeTZd0ls1Jt4OS2XZsjfOh9I5YcQV3MuBhJ8LDZTp4rd0Z+XHae8JMTbxdQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GK1l0Px2k88BE/NhaabN2xqe3pcsBivDH10LHbPldfQ=;
 b=b0/Le/HcqpiKqt8ltQsQ1y1C2o+MALF+GdCZcT1k/eEdZB2VnP894OOEA+UL/yNCLNKWp9yLddpA1hT7ONi+NX+txj31hLX0lnsX5Rmu8R2Kr8FJo2nsrbswQqj7TYQG64CBeQOLySMoUih5iZ74J6gmH4+VTakFiu0NzUM2Z7A6JdiNlQlAYknJ7SPPLnkrR18g6EWxhgWsMljC/jwApcZW3rOC8n4FUt60utJhO9Y3iR053joJdMbBqVc6OrPIPh7vjkNmb6wx+ZdynRTypN2NezsbAql4oeAEt1YQ3GVTxcSzhn163rAwsZWuF/9Ixm/WqFEXKHYWPk/9QyTWlw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GK1l0Px2k88BE/NhaabN2xqe3pcsBivDH10LHbPldfQ=;
 b=DolwF1QofoF+POdG8YhfW+lf51R2lb2bA9GDp/Tp53pHwJOP2PHPBrzmzzHvZnCBlgx14nSalVHYjF0d7lAQLAy/6G+iX/p8+wgs5o0hIujUOyRPg2PU7ZQpXo7CH8ckUM9tTaqcZQ3d4kovDkRNkIZcgG+desaWoniOSpUQLG8wyYFch0EdWrNib0Y/YiuTYIula0ld2tqK5WlZHTPsvNL3FYcwj1+lKD1thDKQWEVr1QAA9vxHiBoKmizcOYIIQMi5uYAqC710XMSP/bzrJlmDapWOdDTsc3dXRu5xBclfO0S48790vC89XOcReS2/+bs9RFLZaITgVR00NbvkrA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by VI1PR04MB10050.eurprd04.prod.outlook.com (2603:10a6:800:1db::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6954.19; Wed, 8 Nov
 2023 14:13:00 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::7102:259:f268:5321]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::7102:259:f268:5321%6]) with mapi id 15.20.6977.011; Wed, 8 Nov 2023
 14:12:59 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next 09/13] selftests: mptcp: add mptcp_lib_verify_listener_events
Date: Wed,  8 Nov 2023 22:11:50 +0800
Message-Id: <8519e8e8149fc74842cb6568e76d72e71d3ca975.1699452144.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <cover.1699452144.git.geliang.tang@suse.com>
References: <cover.1699452144.git.geliang.tang@suse.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TYCPR01CA0155.jpnprd01.prod.outlook.com
 (2603:1096:400:2b1::17) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HE1PR0402MB3497:EE_|VI1PR04MB10050:EE_
X-MS-Office365-Filtering-Correlation-Id: cacaafb4-f8fc-433f-e702-08dbe064d011
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	6Y9juplJTvIxaYe2N8eLdARaBS+s5T7q6Uw+RQjAwW4MKaCjd3MgOETh4ufmwuzE/bL2nKVnSKXfYgqw7X2Ydtpi/3UPCsf+7BLcGraesdTQnW5wFW/lp2IrFNRfZGu45QRIxVX2lCOj7WPdwSWS73mQQkyza1nl61nHEt9dJidi3k3bV09/Bbh8wRgCsloHe/alxhOYxlVLogp3ibXvGpefHwFrbgc20xiLL6XZ/cv1sfoL7/jlYUmool5ArtidvHGAgKz0bVj2XhpCaUUNgfaos9Tfctu0uZP2AvnaDrS6eKWoIYn2wS4LgisJE92NHhFH7ZMJQFkNWKHkqCjE9xmaXbbzwEmDa2xR/AHkQnv1AkYutO3T+pAhTYzGzXpHMke+6FLuMAiP0D09uyfv+KHljEBA9QL8D+1PdsBlF7mdPS0iEou/lwHH0ZTruvUrzmoe1pEn+OIcb+PyvkrxIHLNkS2VAbh2atygA0MoRMlSPgg7wlS9eEwLJ+61ZI+UYJfkEolZp6ngpZvmTLmMpVpUa6mkHXxzqOu3O98onC1r51Au+y5eWeSYuVsx1sF7fMuAdeyVIPIhVNMlUziUvcaZsRubG/hOzJCV6pGK1qQxuaJToRXsFQomObB8VaYG
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(39850400004)(346002)(366004)(396003)(376002)(230922051799003)(186009)(1800799009)(64100799003)(451199024)(26005)(478600001)(6512007)(2013699003)(107886003)(6666004)(6506007)(83380400001)(4326008)(44832011)(5660300002)(66476007)(66556008)(41300700001)(6916009)(8936002)(8676002)(6486002)(316002)(66946007)(2616005)(38100700002)(2906002)(36756003)(86362001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?ikpPO6u+inFpXxOnOwGF0VCsZMjnxV786FrL34X1GJ19k7M/mYm30ghnGHR1?=
 =?us-ascii?Q?WQt+40TQm4NfBSYvFjMOOXWPXjRcXq2l+PJVhs4wABXOXFxSKBy/CyMoCJQ2?=
 =?us-ascii?Q?4MByxcbzZxsqQHYqHs21Eye9khIRxEUQZjgsfNxFB8NGh9m1uLOs3YA83ewu?=
 =?us-ascii?Q?Vcit6wMgq+m4pnRy2F13uGGJFjPCIiqUcxtAdt3wDgxnFRB/UxdboESwC4+9?=
 =?us-ascii?Q?eJXfIBipCmPvw3NVNj7BaiEO3sg0pgPyD50w909WGGb0b3SMZSJG37uKYmP3?=
 =?us-ascii?Q?UBtS93O8fQaKiFGZb07CP/Y5J58C0VTc3CngJWgsCKrpd3cDRE288i/TOj2V?=
 =?us-ascii?Q?rdMQ+d0bgZl1CdeE4QcmVX/D1ZqqdLQq+LC/MKjqUhZRvW6HjkIApQywXwXe?=
 =?us-ascii?Q?ncPb9w1pxno5WGA4vqRQoS6q7PfQcBLEjuZm5FusI9ZiszyCKleXw93bo9dJ?=
 =?us-ascii?Q?nQsgOFf7+KLag8WzWRnIJfpewzivc4hsAlx0RK4jHY/AYufsBTqns19kSXR4?=
 =?us-ascii?Q?SePuTJeKQ6MXN4+Di4YqM3AuFOFOQXH49aLlaLXXaruD07tIaUqg/kOmviYp?=
 =?us-ascii?Q?Pe1G5fMeoK5cXD//WBjcYogmAEgGEhVtifXEUgSV/RhiVS41tPD5HKb9mv/l?=
 =?us-ascii?Q?6o0WBWP++nmf56vOiINrLsQ6tuSiKl4EiMnO1qvAlqISSHrhKEgBPW1Mb+nq?=
 =?us-ascii?Q?8+iqEDGa9WbE7RlYjQ9xsqJh9bAQVbGsnmAjS290zJONe5AnBZRjRVONm/td?=
 =?us-ascii?Q?ZhUncl36wjh3BnTjRTr0yMv6CSRZcshjmoBFufBgHapA3Z40PAbtceQn/AB5?=
 =?us-ascii?Q?9OFPpQxgHBDHwHvLKI5p6HAEFOHBqyw7eANYxkCcmEy79iDtBpqyD2IfL3ON?=
 =?us-ascii?Q?3vo16h3fATQGvfTi7SYtoNI4WkQbvbEQxsnMym0lftofQPTw8Fnl8JB4Ej58?=
 =?us-ascii?Q?LtNnTs9ScIWhgX/TCgiOb4iG2TRlvSpdGY4O58v0WgJ5JIRhzUDGbeeZTY7P?=
 =?us-ascii?Q?/oC+F2PTb+sBpdPcTtEB1nIpHkBzqzVZL1900NsbcsByJlvq9LQfu42m7kPU?=
 =?us-ascii?Q?fw4Fkja8qpyrEeWxXNKkb0TaoEvCi20TxR8jliN+ZT1iwaAjnsL8NQRkxLLW?=
 =?us-ascii?Q?aKu8bGv4ExYybR2mI7tkUzARb3Q5q3IdAv/H0RuYRcx5SW9/3Jf21fIViNKP?=
 =?us-ascii?Q?Sg9gyP9WhEWzxoBMvZe/6WAack9R1BRce4SUOwGKQImg3woszguVxFcpa7u6?=
 =?us-ascii?Q?c+/dQVfk42ru8Xkuu/biOQiPgopwlAZqp6ogsIOn8Z/OG8UFzooRPsDFtefX?=
 =?us-ascii?Q?GsrKOg6LyQOB/a2v/YW++mUkOTvJ2Yg4UZASpCo4/MnwbJtWmk37noKjH1MF?=
 =?us-ascii?Q?conChr3FIlUewzmsDctr69uUs+x2i7/3hg/pWetbQvXXcvfeqd9yuV8vfPNv?=
 =?us-ascii?Q?DKw1yatcSK/2P4CQ6V9rlykRwNhlx7ix28LqGY//R5evNGjVyHFeGclgsiLn?=
 =?us-ascii?Q?EX8IRdze57mIR7gB6gLbDfzxrGKV5eIJPvKmh+9oLL8lmU9VClgykxh1lpgJ?=
 =?us-ascii?Q?Xnsuhcn+fyo5VEXs2Ur41rdW47aWbhvrqgDdZ1sL?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cacaafb4-f8fc-433f-e702-08dbe064d011
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Nov 2023 14:12:59.8949
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: IyTXe6Oxu3VM6mIOliT7jrglFJJjcEEZIr7cYGdlJCHpcQXj3cE4+G1gKA6JKWJm55GB9FHvPofIxqZacj3EGw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB10050

To avoid duplicated code in different MPTCP selftests, we can add and use
helpers defined in mptcp_lib.sh.

The helper verify_listener_events() is defined both in mptcp_join.sh and
userspace_pm.sh, export it into mptcp_lib.sh and rename it with mptcp_lib_
prefix. Use this new helper in both scripts.

Signed-off-by: Geliang Tang <geliang.tang@suse.com>
---
 .../testing/selftests/net/mptcp/mptcp_join.sh | 24 ++-------------
 .../testing/selftests/net/mptcp/mptcp_lib.sh  | 23 ++++++++++++++
 .../selftests/net/mptcp/userspace_pm.sh       | 30 ++++---------------
 3 files changed, 31 insertions(+), 46 deletions(-)

diff --git a/tools/testing/selftests/net/mptcp/mptcp_join.sh b/tools/testing/selftests/net/mptcp/mptcp_join.sh
index 6d2e70785fdc..20e582d39653 100755
--- a/tools/testing/selftests/net/mptcp/mptcp_join.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_join.sh
@@ -2779,15 +2779,10 @@ backup_tests()
 
 verify_listener_events()
 {
-	local evt=$1
 	local e_type=$2
 	local e_family=$3
 	local e_saddr=$4
 	local e_sport=$5
-	local type
-	local family
-	local saddr
-	local sport
 	local name
 
 	if [ $e_type = $MPTCP_LIB_LISTENER_CREATED ]; then
@@ -2805,23 +2800,8 @@ verify_listener_events()
 		return
 	fi
 
-	type=$(mptcp_lib_evts_get_info type "$evt" "$e_type")
-	family=$(mptcp_lib_evts_get_info family "$evt" "$e_type")
-	sport=$(mptcp_lib_evts_get_info sport "$evt" "$e_type")
-	if [ $family ] && [ $family = $AF_INET6 ]; then
-		saddr=$(mptcp_lib_evts_get_info saddr6 "$evt" "$e_type")
-	else
-		saddr=$(mptcp_lib_evts_get_info saddr4 "$evt" "$e_type")
-	fi
-
-	if [ $type ] && [ $type = $e_type ] &&
-	   [ $family ] && [ $family = $e_family ] &&
-	   [ $saddr ] && [ $saddr = $e_saddr ] &&
-	   [ $sport ] && [ $sport = $e_sport ]; then
-		print_ok
-		return 0
-	fi
-	fail_test "$e_type:$type $e_family:$family $e_saddr:$saddr $e_sport:$sport"
+	mptcp_lib_verify_listener_events ${*}
+	[ $? -eq 1 ] && fail_test "$e_type $e_family $e_saddr $e_sport"
 }
 
 add_addr_ports_tests()
diff --git a/tools/testing/selftests/net/mptcp/mptcp_lib.sh b/tools/testing/selftests/net/mptcp/mptcp_lib.sh
index 19e6ceb2b4b0..1617e1bd6785 100644
--- a/tools/testing/selftests/net/mptcp/mptcp_lib.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_lib.sh
@@ -429,3 +429,26 @@ mptcp_lib_check_expected()
 
 	return 1
 }
+
+mptcp_lib_verify_listener_events() {
+	local evt=$1
+	local e_type=$2
+	local e_family=$3
+	local e_saddr=$4
+	local e_sport=$5
+	local type
+	local family
+	local saddr
+	local sport
+
+	type=$(mptcp_lib_evts_get_info type "$evt" "$e_type")
+	family=$(mptcp_lib_evts_get_info family "$evt" "$e_type")
+	if [ $family ] && [ $family = $AF_INET6 ]; then
+		saddr=$(mptcp_lib_evts_get_info saddr6 "$evt" "$e_type")
+	else
+		saddr=$(mptcp_lib_evts_get_info saddr4 "$evt" "$e_type")
+	fi
+	sport=$(mptcp_lib_evts_get_info sport "$evt" "$e_type")
+
+	mptcp_lib_check_expected "type" "family" "saddr" "sport"
+}
diff --git a/tools/testing/selftests/net/mptcp/userspace_pm.sh b/tools/testing/selftests/net/mptcp/userspace_pm.sh
index cc6e8120ed10..fba15905b890 100755
--- a/tools/testing/selftests/net/mptcp/userspace_pm.sh
+++ b/tools/testing/selftests/net/mptcp/userspace_pm.sh
@@ -840,32 +840,12 @@ test_prio()
 
 verify_listener_events()
 {
-	local evt=$1
-	local e_type=$2
-	local e_family=$3
-	local e_saddr=$4
-	local e_sport=$5
-	local type
-	local family
-	local saddr
-	local sport
-
-	if [ $e_type = $MPTCP_LIB_LISTENER_CREATED ]; then
-		print_test "CREATE_LISTENER $e_saddr:$e_sport"
-	elif [ $e_type = $MPTCP_LIB_LISTENER_CLOSED ]; then
-		print_test "CLOSE_LISTENER $e_saddr:$e_sport"
-	fi
-
-	type=$(mptcp_lib_evts_get_info type $evt $e_type)
-	family=$(mptcp_lib_evts_get_info family $evt $e_type)
-	sport=$(mptcp_lib_evts_get_info sport $evt $e_type)
-	if [ $family ] && [ $family = $AF_INET6 ]; then
-		saddr=$(mptcp_lib_evts_get_info saddr6 $evt $e_type)
+	mptcp_lib_verify_listener_events ${*}
+	if [ $? -eq 0 ]; then
+		mptcp_lib_result_pass "${TEST_NAME}"
 	else
-		saddr=$(mptcp_lib_evts_get_info saddr4 $evt $e_type)
+		test_fail
 	fi
-
-	check_expected "type" "family" "saddr" "sport"
 }
 
 test_listener()
@@ -881,6 +861,7 @@ test_listener()
 	# Capture events on the network namespace running the client
 	:>$client_evts
 
+	print_test "Listener event LISTENER_CREATED 10.0.2.2:$client4_port"
 	# Attempt to add a listener at 10.0.2.2:<subflow-port>
 	ip netns exec $ns2 ./pm_nl_ctl listen 10.0.2.2\
 		$client4_port &
@@ -900,6 +881,7 @@ test_listener()
 		rport $client4_port token $server4_token
 	sleep 0.5
 
+	print_test "Listener event LISTENER_CLOSED 10.0.2.2:$client4_port"
 	# Delete the listener from the client ns, if one was created
 	mptcp_lib_kill_wait $listener_pid
 
-- 
2.35.3

