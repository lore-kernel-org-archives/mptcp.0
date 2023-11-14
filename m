Received: from EUR01-DB5-obe.outbound.protection.outlook.com (mail-db5eur01on2087.outbound.protection.outlook.com [40.107.15.87])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 684A52F29
	for <mptcp@lists.linux.dev>; Tue, 14 Nov 2023 06:39:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="X0RpaZdb"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iiEbv1PzbPvgBR5pTbznNNGFje5GrLmooEm0iRbqw4GQ6fX/ZTJQ2qAqT3BZse43oCH+4MN/7h2rtVotPt8rmN5Deat/DeE7ig7/XBeOdJU3gErtkY1cPBPpD15pPLlDCZO2MJPsqgbhJfIWuaerz93EPXOWr0770qmdSlnrAs42HlS0THQIqMjPBtqLkE8+DlCx2iTqaJTIZ8Et8j4fjgtmVpIH7yK2vOfm2bLsT2UAZBcgn3Nm0pkQu6LT1GiypFnVNXzvz/LkzjhqhLN2pNabtR7K7SR2Cj6mh4Zp82BzNNar1N2PSnnzvzZTppDFmeB+0TZH4TltyEiaaXjnxQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FxHgT9FxW4/HB371HaovJX80lhRmP6QF4+bwpKBgNBU=;
 b=ccaG27FOV/OwyvphOdyDTVlnl8TbvAs60FOM1uraywlgrGjL0Cdwmv3rejyunqzwcvF1sxKs79PU8OXZHxV3ze0GkYx6kunBxz9uzhLJEf/TtEg7OjWf3uvKDOQZSwHSFPosd24+c+aDmWEcvSOpHSvRcH2I+NFy1Rzn9Tna4AaBAbaFyw+vu3xnMNtzeKLo2Kw1KHOidXSOxwDBAxWROEs0upNUq8v7bt6bQ9TPC5bX5Xmo+6A2LzCSpM2o/vT2XhfAipH82wTNuV4iJTeTb2EcAyQNpsyQGzX6qJsjZ/x2YiX4+0ejv0vn5SYICsuzBoRG2QEaG38PogkmV5CTcQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FxHgT9FxW4/HB371HaovJX80lhRmP6QF4+bwpKBgNBU=;
 b=X0RpaZdbkOgW8pdjMy512HLxv6rfiOH++osexaI5O7FbKNnlip9wRV+Mdkl1n5XkpXBk03bfAxDGRWMEtPYkOvDEN7lfzZOwzu6HOQDrK2g0/NDQYJFWTUmQoQyokMuiKhDX5PB2RFBSChX9yzDY+bs5CLRbNHU4Wv4uUDet6tE9WqbR09xflvAWlT8+YKfZooSUyh3vtValt6IXzdYtApHlbFKbjfe9EtQESHC1ZHBAKQBxwNdSFQxnLRfqkco6NWqqqgKkvn+F5CfM8iT0VBe1RDLXEzLExherz/6siCL4iI7/Bqh2N4AhsTVwUeN0mmyCQG1hso39xYRalk6tyA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by DB9PR04MB8480.eurprd04.prod.outlook.com (2603:10a6:10:2c6::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7002.17; Tue, 14 Nov
 2023 06:39:45 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::7102:259:f268:5321]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::7102:259:f268:5321%7]) with mapi id 15.20.7002.014; Tue, 14 Nov 2023
 06:39:45 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next v2 14/32] selftests: mptcp: sockopt: print every test result
Date: Tue, 14 Nov 2023 14:35:33 +0800
Message-Id: <cca6737ad0083fc8bf26c1aea48eec60d6bf2287.1699943337.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <cover.1699943337.git.geliang.tang@suse.com>
References: <cover.1699943337.git.geliang.tang@suse.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TYCP286CA0213.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:3c5::19) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HE1PR0402MB3497:EE_|DB9PR04MB8480:EE_
X-MS-Office365-Filtering-Correlation-Id: 23d30b48-8bc7-45f4-5ae1-08dbe4dc7da5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	zHRDyNIy3kYLeeFDdMF22Px9U8Cp7QxeBVAFHNFVIo0vQ+aYOwXFt7e52Y3Kiogz9NK5A97nGKSFnOiLKlgzrGRVD91bXul+aZ03WDvxdJsHlla+BNSEePoQ15RIjuybYL5oFE5YAkpolXIAA5T6cEJmRt/wddAfqxzuMgpbLbYApiHTVVyW9d5DphW7k3GgZv1ndjVCvWOrm5jbfa1Ns+OY+7CWH7pjjMvlgldP9sztqAC8rj0cpqnRvRlICOwxELdQ+oH6Aw8WQ+JjEbvQ74kg3Jb7i/qIaruJmKAgG6SDiZGRQw4dWwBp7cbJk8aAa2gfZwy7Sxs533LHA26yCxlSMCYbz6Y17EXnl21NMx3cdr5Mm5Lu9Gdn+oufRNmEAmQh/vO8f0A8AZE3UGbG8kHyonciViKtAOuTudI04Nf+zNE9MvON3q1463vDt3Hka04y0KEOl3LCV2CwnW5xTBVgLBIfwHLnYoFMWPY9ofNRrDwoQdDt4htXCk2JK9vbU19CNIu8IivyAh559ItszUz6+Xn86BBhfBHqJzBL/805xLe4dTrp64XqVBxcs3OF
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(376002)(39860400002)(396003)(366004)(136003)(230922051799003)(1800799009)(64100799003)(451199024)(186009)(2906002)(41300700001)(38100700002)(66476007)(66556008)(478600001)(6486002)(86362001)(66946007)(6512007)(2616005)(26005)(107886003)(6506007)(6666004)(8936002)(8676002)(4326008)(44832011)(5660300002)(316002)(36756003)(6916009);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?0Q4UI8BrsqRwCJQLv0CvMSvacrlr1sdRAa+LxuuL+bMpm3KxmEnAHm56wXoE?=
 =?us-ascii?Q?9NxXSREOgiHabBJBL2AlvCRy3VOX2sDwGztd7Imum//X0QVJtLHVHAaFwCet?=
 =?us-ascii?Q?kI5+rRGtgAjqURzHC4LC0EFKoX/QefOV0VAZlOzGcss8u1W4V/o7L3sgRjt7?=
 =?us-ascii?Q?Zy4qWoK0+URJUN27sSjK1rZJN4d2C0gqiCrrSqEzr3mr/Y03y8FYmR57kFkU?=
 =?us-ascii?Q?AX9/iR4SdlLSPhdvdKNPzLmntqMI97P8QSIWHNt5YDqJEcwgTffDTrRcFuss?=
 =?us-ascii?Q?NSjM8TPU0jnQE0WdWn9K0vUZmFQ3XuKtkbWJpIVepa9eIiua/njkCewqYvCy?=
 =?us-ascii?Q?7c8vlTphinZia97CELWpPNSnvAz8bvaNeFFcJvEJBS2y1lg9YEBnzVpGTkpv?=
 =?us-ascii?Q?8NWC5IKL4HV15ng+oukpmaMzM9dw5AY4Jva2g7PBp85fuzMrWtowLHT0VFPf?=
 =?us-ascii?Q?zwS26zQQfYAGd2OdHZzw7ivTgjEPt2Dumg1cYoa8qk54QraitilxzmoIOwRx?=
 =?us-ascii?Q?sGKLntK0hxcjGv2LABtuuNbbK69WnKVUqkTfIu6XWbcA19DkAA1MwuUfWyKF?=
 =?us-ascii?Q?uB4XrjAEO42Zds19r38G5D+1PA2JLZySaYBEvb5Tg45LGAcW7dqs3HphA17m?=
 =?us-ascii?Q?WM12wG//b9M9J6hgVO7SpgYb16MdLAFA7Ijjfoz24K/UJTGeYmFHnD/x9T5v?=
 =?us-ascii?Q?K+PF+/Hk4emRtrQhvWgZ0WknJHS/MmTypPEOmGRrp4wZ0ZQH/4b2NJc3B41h?=
 =?us-ascii?Q?8T14O6XQ45l4ag14MfJcx2riZycsjelIu3Cj8RlysKXGGmaI4uKXGy+Tqwne?=
 =?us-ascii?Q?uCAVf1z4uVfjZ66ILuzY+NndfOmyu2302JljgzGhRyCtLAyiirQoGTJnffGy?=
 =?us-ascii?Q?mQkxAHSAfF3BycNd3qbzhpDRufUAZ+toJvhzOpZ+guaqtRWJIl2ALA/7kGxk?=
 =?us-ascii?Q?L7ZB4H8s4Hz+G1ZKIy5nakChuqwdy2n8biq7Mx+mefpIvWxbvFuhrBnolWz3?=
 =?us-ascii?Q?Pdw3f7kV/cOfq9UWfOnbZPxQnA201laXVkPeoJVRkGOkTJxE4MhNS1E2H1G7?=
 =?us-ascii?Q?Vpm7WncKuZBGSeh6lQtb8XKR4rJH16o4v4bbBy/bnYJT+jFKFj3K072mShDw?=
 =?us-ascii?Q?5xMm9+6TfB8ao2IiiHXaGW7hkpPrTqscNP4Xk3q0lyjrjwqx+XSkgnmyhBBD?=
 =?us-ascii?Q?tx2dMSmHKG1L7PyxqrIJhGFLhD6GxFbhVA/cRYF6xvVGO522i1HoPCvFn1zb?=
 =?us-ascii?Q?CM2cGDTq2dNxIukDuIItkjjNKYjqsSp3543kowqWtLFDk8sLtjFw48eEsz7/?=
 =?us-ascii?Q?mkon4Rea+YAo7rAwFSWIn7xOCb6nvI/GXCbme0y8dJuIjGj0tPQ3FBMNtbva?=
 =?us-ascii?Q?jLmvHsvSAn60xsQwh5YlFopmCaNJhqKucoV0qIvHqBO6Ugow6U/WiRUOoZ35?=
 =?us-ascii?Q?CIOkei6a7NHtC7Lh8L1+Z/JlBPgU2W4qe1d317x8AWlNRR9tdsvvDQag8rtI?=
 =?us-ascii?Q?8x9rXGJtrjo/RhLNno36QYcbKUIyYrgCJDNS1ZYAy2V+AQaOfbe6iq0rgJoW?=
 =?us-ascii?Q?AIVLjKw2Oo55UubQdQNM6gANAn7xDEzz743js1+m?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 23d30b48-8bc7-45f4-5ae1-08dbe4dc7da5
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Nov 2023 06:39:45.8474
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xkVuzCOLurFLmMH3YnhoJl487EyJy3s/xZ+181hXaYB8VwFUdZwhOJ7sDUMERPBYk+0FgEVbPLFWZxgPq3LmXw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR04MB8480

Only total test results are printed out in mptcp_sockopt.sh:

 PASS: all packets had packet mark set
 PASS: SOL_MPTCP getsockopt has expected information
 PASS: TCP_INQ cmsg/ioctl -t tcp
 PASS: TCP_INQ cmsg/ioctl -6 -t tcp
 PASS: TCP_INQ cmsg/ioctl -r tcp
 PASS: TCP_INQ cmsg/ioctl -6 -r tcp

This patch prints more info for every test result in each test
group:

 transfer ipv4                                                [ OK ]
 mark ipv4                                                    [ OK ]
 transfer ipv6                                                [ OK ]
 mark ipv6                                                    [ OK ]
 PASS: all packets had packet mark set
 sockopt v4                                                   [ OK ]
 sockopt v6                                                   [ OK ]
 PASS: SOL_MPTCP getsockopt has expected information
 TCP_INQ: -t tcp                                              [ OK ]
 PASS: TCP_INQ cmsg/ioctl -t tcp
 TCP_INQ: -6 -t tcp                                           [ OK ]
 PASS: TCP_INQ cmsg/ioctl -6 -t tcp
 TCP_INQ: -r tcp                                              [ OK ]
 PASS: TCP_INQ cmsg/ioctl -r tcp
 TCP_INQ: -6 -r tcp                                           [ OK ]
 PASS: TCP_INQ cmsg/ioctl -6 -r tcp
 TCP_INQ: -r tcp -t tcp                                       [ OK ]

Signed-off-by: Geliang Tang <geliang.tang@suse.com>
---
 tools/testing/selftests/net/mptcp/mptcp_sockopt.sh | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/tools/testing/selftests/net/mptcp/mptcp_sockopt.sh b/tools/testing/selftests/net/mptcp/mptcp_sockopt.sh
index ff49ee9b9cc2..f445fc685b86 100755
--- a/tools/testing/selftests/net/mptcp/mptcp_sockopt.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_sockopt.sh
@@ -173,6 +173,7 @@ do_transfer()
 	wait $spid
 	local rets=$?
 
+	printf "%-25s %35s" "transfer ${ip}" " "
 	if [ ${rets} -ne 0 ] || [ ${retc} -ne 0 ]; then
 		echo " client exit code $retc, server $rets" 1>&2
 		echo -e "\nnetns ${listener_ns} socket stat for ${port}:" 1>&2
@@ -186,7 +187,9 @@ do_transfer()
 		ret=1
 		return 1
 	fi
+	mptcp_lib_print_ok "[ OK ]"
 
+	printf "%-25s %35s" "mark ${ip}" " "
 	if [ $local_addr = "::" ];then
 		check_mark $listener_ns 6 || retc=1
 		check_mark $connector_ns 6 || retc=1
@@ -202,6 +205,7 @@ do_transfer()
 	mptcp_lib_result_code "${rets}" "transfer ${ip}"
 
 	if [ $retc -eq 0 ] && [ $rets -eq 0 ];then
+		mptcp_lib_print_ok "[ OK ]"
 		return 0
 	fi
 
@@ -232,23 +236,27 @@ do_mptcp_sockopt_tests()
 	ip netns exec "$ns3" ./mptcp_sockopt
 	lret=$?
 
+	printf "%-25s %35s" "sockopt v4" " "
 	if [ $lret -ne 0 ]; then
 		echo "FAIL: SOL_MPTCP getsockopt" 1>&2
 		mptcp_lib_result_fail "sockopt v4"
 		ret=$lret
 		return
 	fi
+	mptcp_lib_print_ok "[ OK ]"
 	mptcp_lib_result_pass "sockopt v4"
 
 	ip netns exec "$ns3" ./mptcp_sockopt -6
 	lret=$?
 
+	printf "%-25s %35s" "sockopt v6" " "
 	if [ $lret -ne 0 ]; then
 		echo "FAIL: SOL_MPTCP getsockopt (ipv6)" 1>&2
 		mptcp_lib_result_fail "sockopt v6"
 		ret=$lret
 		return
 	fi
+	mptcp_lib_print_ok "[ OK ]"
 	mptcp_lib_result_pass "sockopt v6"
 }
 
@@ -271,6 +279,7 @@ run_tests()
 
 do_tcpinq_test()
 {
+	printf "%-25s %35s" "TCP_INQ: $*" " "
 	ip netns exec "$ns3" ./mptcp_inq "$@"
 	local lret=$?
 	if [ $lret -ne 0 ];then
@@ -279,6 +288,7 @@ do_tcpinq_test()
 		mptcp_lib_result_fail "TCP_INQ: $*"
 		return $lret
 	fi
+	mptcp_lib_print_ok "[ OK ]"
 
 	echo "PASS: TCP_INQ cmsg/ioctl $@"
 	mptcp_lib_result_pass "TCP_INQ: $*"
-- 
2.35.3

