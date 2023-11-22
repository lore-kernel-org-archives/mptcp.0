Received: from EUR04-DB3-obe.outbound.protection.outlook.com (mail-db3eur04on2081.outbound.protection.outlook.com [40.107.6.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A446751035
	for <mptcp@lists.linux.dev>; Wed, 22 Nov 2023 11:33:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="DI+GSAGL"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hizAtS9bzhBfhLVz6NqGHxhaH5pqlsnwKYWaBvZlmWaC/BNa6nXywdwwWxL2gtbwwflnzsyAuauu/BVLNKEUagtsD/G8rDIFAelPIVUNvcz8x2T11jVOZphTZVu9urPXX2U5t58KuIZX8AuR2odrC3cosyLgu/tyn+0RNXqDAak9aQwK0TZdya9ia7O1+sQTTABe8g6uZnLH508nxdt+9WMbszQaAG0QXpVRyAQl0hK1Qg8Ch4ZiSslGXDzPZ3SQf5pLKqRXjgh/jLiGvfDTzEb+tXa0AoZRE6zpOEJbHQUP5ECw9+jS6wwL/F51G2t+an2ZLyB5fusLOh0esZuuZQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AkZYV6WFJHFXQfrGqSpqVCjOBsM8VJaS355gfq4Ru6s=;
 b=gfxJBsyVjAKoy80PjeXBjF9eIlOHoWobgjqEWVohE4+dDXN7u5zho1qc0qFHCfMk6kEIiOMlgmVQaqb+LtI602vlDx7X4d7atxVbCYrRmrQGOVhOv+g9MsnPFWAM/SeQdaKhYKV0D0EpBw7gaOHvKExJQvPYvUq/fxeKoYHWlLe82CkTNIZBrXzZo9Bf86LQXGHrNueAD8kH3/fEyuatOoswLYf+7mUJd82ABuO5Xd/eP/+JyITH54XYUUG1cVJQbOII1lBm3mIYafJWhtanYW8liZX2lEnh5SlZ0UHCrNZ2e5ntSIo3gL8OUsllB/cQmcgQ86tCUP9LMFHuxNN8eQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AkZYV6WFJHFXQfrGqSpqVCjOBsM8VJaS355gfq4Ru6s=;
 b=DI+GSAGL6LSo+iMpGqxOBuE39ewK3aGeLUHwTftsX5z12vM3uhw+z7SyKZJRtMdZ9tBPQ5tkVqypN7cNaGEx0BLjfna6gQ/ZtgRysjUHVAwPGHoMu5c+wUFO78P+uDm58KpgfF7uFPy8XfVeFJl9/VKSGBxDm+AHYZy3YKAAtqSypPVNw0VgMEF92dF/0M0QWiGDFUU5CTHUQih6L5nwDsq9N9cAKjY8gsswBKSv4h4xGD+Ls+0XDJYV53HP7hVNk2CccftAQ5AidYwWGHeTz5ejvMaaPEK/o5VjYmEelDwgiEUvQ0gmy+6QzLbCv3pQik+ZNHweVZ8wqlfNEDrYPQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by PAXPR04MB8333.eurprd04.prod.outlook.com (2603:10a6:102:1c0::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7025.17; Wed, 22 Nov
 2023 11:33:05 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::7102:259:f268:5321]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::7102:259:f268:5321%7]) with mapi id 15.20.7025.017; Wed, 22 Nov 2023
 11:33:05 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next v4 15/33] selftests: mptcp: sockopt: print colored output
Date: Wed, 22 Nov 2023 19:31:03 +0800
Message-Id: <6a283cce60a2674e5dbda5db1b70a8835e3af2d3.1700652422.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <cover.1700652422.git.geliang.tang@suse.com>
References: <cover.1700652422.git.geliang.tang@suse.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SE2P216CA0029.KORP216.PROD.OUTLOOK.COM
 (2603:1096:101:114::6) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HE1PR0402MB3497:EE_|PAXPR04MB8333:EE_
X-MS-Office365-Filtering-Correlation-Id: 85628d6a-8133-4a0d-912c-08dbeb4ecb1b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	MLC1htGF6ktrPeZ5cfuRqx3wVw7mrX+FbAsQ0PayqwYpCLnxX0vtYBwoKGBqVs26B4OaQgjAZh0fYoy9TmcvEpwglkcPmEqdIZKkgvWPAmWBnhuxqfl8R/uVUkE5NNYh2DLyZiloQRSot6BcR6zPZmnR8O5GLgOpOgko+QxUnwyQRsHK4syARRdOgWkheqt6WgkEaw1fP/WwFq2KteoargcLk/ZEFUV0mSkzd6RBysNUA7xD145k1WIzz5BDJ+vhg0zj5zxFewLK8q4tSSLldHdRqMI6gwxE7nwbA+jPRoERXdItWkXQCOZY4mgpbbP9eFpVSrkzs49O+xEuZBf9Ft550fCIxNuFgZwfttdxqmt9aHD9zN8OlGW9n+I33F+LrnOxzFxgE2/qShycnCbtS1Wf5exZpzweCxrXW0fdfy7377zlPRd99D3bzPBwzkwSM6YbQExFQ46msaiSWbda7JYJby9Vo3E2zeiVTtNeNsWrXlGQpHDAZgasoZXod0ClbsB1kxEJSD8IuAQm6qncFYsGXitO7nz94890rHQd+dd5cSjowfkgP3eXowx6VS51qngl77EZMSkV3QEqRpIXuDYgTt3W3T/85DDQaf8V+88=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(366004)(376002)(396003)(346002)(39860400002)(230922051799003)(1800799012)(186009)(451199024)(64100799003)(6506007)(2616005)(107886003)(26005)(6512007)(316002)(6486002)(478600001)(83380400001)(66556008)(6916009)(66946007)(66476007)(44832011)(4326008)(8676002)(5660300002)(38100700002)(86362001)(8936002)(2906002)(41300700001)(36756003)(13296009);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?yQp9MNkKx5UGGMr564UQ9NRHNHHDW2jXp+1SI5tfRFHG2h3XnbkE3pNHJLbE?=
 =?us-ascii?Q?OBeoSaOF1t0adzDaocQDR8MieWaWIh3jOS/ybTJC9qdlSseULEkS9KI6QvPo?=
 =?us-ascii?Q?BxGTwUFynL6AbZMU7kfW61Yx/NKZGDYxdfQcbfdVkGjn1XngVvHIymBzysKz?=
 =?us-ascii?Q?kU5GERzyztjhO3H+plm7IfMI/U/KlUQba1GKiF5dhs2iauLe700U0Ixi8IQk?=
 =?us-ascii?Q?y1u1MjsfsmeWV3P0ZMo+VUXyYU3Zbwhj62y2lV1zyxH1JZVjKQCoTiNYNuzx?=
 =?us-ascii?Q?QfQLdN3me6EVHWZOtmqsseWd9P04kbN89U26JP0f6dSuLEhtc5hK758CgVK1?=
 =?us-ascii?Q?EazH1m2HK/VVKf+Ei5VnD1bojkfOEjGPkLjP3jvcxfqUBRC4NDs0fNB3t8Gb?=
 =?us-ascii?Q?gPIdSQjB93WUT37g+/GWCr9PV/86OuY2FgqfTNSFnRBAicrEz1WxNcsX7GsJ?=
 =?us-ascii?Q?jSPHWLAjG0azo5w5D2KkJcBQajcj5qy9lmEWWVQeVWyeWv+iO5fxPsbAXnhs?=
 =?us-ascii?Q?rrqEsAFfSD3wcx1ToaCyXzSOK9pT/4wV3lf1mBC+Yw2vGMQNs1GZyQYHeEVm?=
 =?us-ascii?Q?dyghbSp8zPMxUEsEzujGDZANLgEtJFsFWqZJhzJIXj27fIgmFQh9c+zAj1bu?=
 =?us-ascii?Q?TLvMgpiZWNGUvq4BanQo1Hr1kgTw2mPCaJjx+QvFDy6POs49MrXssznsrcKP?=
 =?us-ascii?Q?xD2vSAiyUKXQI2Mk1Zg9D2IIxjDJ5H1xDrqyu3Pwv3r9aZ8YJar2Y1gVQmRF?=
 =?us-ascii?Q?v6sk6L+fLGqR59i8VfqPkWNw1h1HIdwnTIZ5ElsT0xmWUbZzZMVXbJGPVwG9?=
 =?us-ascii?Q?J4YGxrDmDJHA5EpcJJThZyQfDyulPsIWoolBICDblChQujxVLAZHcXf2noZy?=
 =?us-ascii?Q?8Rpf2NCJ/G4LDZK1uNgsS/6Cdj4+zVW4nwbMd5HMxcd77A+gEI7vJRoJIBng?=
 =?us-ascii?Q?+x8euzBTnJL345OFOchuFRvrjEMz5RF/LAW6dOTsxfGfiKXFe7WnKcR7N1qr?=
 =?us-ascii?Q?9BUCyh+q6njUnBDIN/mLUgxsjjA60crSSDOWYvnl/Hy/ifyJP4IB91JwpvXu?=
 =?us-ascii?Q?90TTMVDlwZK2LON76YVLwCBeJyQBVfd5HJnopf4gUmj+71Gj0jBhMt7DxzUm?=
 =?us-ascii?Q?422pRgf2IJN1JEWzY65QqQ6m7yoE/ka/4M0gfEt9qZMcI11jQu1ahfSecddA?=
 =?us-ascii?Q?ISjXuMRBYPA3N5iMcnqfSWme7DxT6Py0tUtAw1tgcb4W0z3B3CP2z4hEfZ6W?=
 =?us-ascii?Q?IGshSLqjDJZAyk4FHc/nx8d14RUcE/X3b2A6t80JDb/HqPV3HBuSl+LRaRpw?=
 =?us-ascii?Q?IsQb4crHOzJ6uEaZ/AbA6BjSYcZ6ArSz5vnWmEgb630pJ4uwdwXXwrPWxpMZ?=
 =?us-ascii?Q?j/WCkXwmq6YLdCA50ne2ZnPYYorYyoFuq8tjkiLXdmnzeAfIa1K3z4FjAF2r?=
 =?us-ascii?Q?5QDJuGWGuohGM3aUGlozmPX+AhiqJiBoZqTSXHsa6X4fZGROg5k4Yz6p+LDh?=
 =?us-ascii?Q?n+nPrqlSOmCOhCtXg8QOZm01GjCfL369dmuZCtLUehQPeRElwXwP2C0tiheZ?=
 =?us-ascii?Q?XTDSMBH2eFxNS6qYkcSSWInSZ1R7la2eLfKhGcj/IVmfhPzfu5QqcwDCHljU?=
 =?us-ascii?Q?Pg=3D=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 85628d6a-8133-4a0d-912c-08dbeb4ecb1b
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Nov 2023 11:33:05.3346
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +NWjhpNX1zPa8LehZsE4Fva2XJ6ySIsjb50vtPY+I/Uj+uL7tCabJG1Ps9JH+QtHYT6pqkOQbw3fBMOECIUGuA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB8333

Use mptcp_lib_print_info(), _warn() and _err() helpers in script
mptcp_sockopt.sh to print test results with colors.

Having colors helps to quickly identify issues when looking at a
long list of output logs and results.

Signed-off-by: Geliang Tang <geliang.tang@suse.com>
---
 .../testing/selftests/net/mptcp/mptcp_sockopt.sh | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/tools/testing/selftests/net/mptcp/mptcp_sockopt.sh b/tools/testing/selftests/net/mptcp/mptcp_sockopt.sh
index f6b9660122ea..9baa103055c4 100755
--- a/tools/testing/selftests/net/mptcp/mptcp_sockopt.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_sockopt.sh
@@ -230,7 +230,7 @@ do_mptcp_sockopt_tests()
 	local lret=0
 
 	if ! mptcp_lib_kallsyms_has "mptcp_diag_fill_info$"; then
-		echo "INFO: MPTCP sockopt not supported: SKIP"
+		mptcp_lib_print_warn "INFO: MPTCP sockopt not supported: SKIP"
 		mptcp_lib_result_skip "sockopt"
 		return
 	fi
@@ -240,7 +240,7 @@ do_mptcp_sockopt_tests()
 
 	printf "%-25s %35s" "sockopt v4" " "
 	if [ $lret -ne 0 ]; then
-		echo "FAIL: SOL_MPTCP getsockopt" 1>&2
+		mptcp_lib_print_err "[ FAIL ] SOL_MPTCP getsockopt"
 		mptcp_lib_result_fail "sockopt v4"
 		ret=$lret
 		return
@@ -253,7 +253,7 @@ do_mptcp_sockopt_tests()
 
 	printf "%-25s %35s" "sockopt v6" " "
 	if [ $lret -ne 0 ]; then
-		echo "FAIL: SOL_MPTCP getsockopt (ipv6)" 1>&2
+		mptcp_lib_print_err "[ FAIL] SOL_MPTCP getsockopt (ipv6)"
 		mptcp_lib_result_fail "sockopt v6"
 		ret=$lret
 		return
@@ -286,13 +286,13 @@ do_tcpinq_test()
 	local lret=$?
 	if [ $lret -ne 0 ];then
 		ret=$lret
-		echo "FAIL: mptcp_inq $@" 1>&2
+		mptcp_lib_print_err "[ FAIL ] mptcp_inq $@"
 		mptcp_lib_result_fail "TCP_INQ: $*"
 		return $lret
 	fi
 	mptcp_lib_print_ok "[ OK ]"
 
-	echo "PASS: TCP_INQ cmsg/ioctl $@"
+	mptcp_lib_print_info "PASS: TCP_INQ cmsg/ioctl $@"
 	mptcp_lib_result_pass "TCP_INQ: $*"
 	return $lret
 }
@@ -302,7 +302,7 @@ do_tcpinq_tests()
 	local lret=0
 
 	if ! mptcp_lib_kallsyms_has "mptcp_ioctl$"; then
-		echo "INFO: TCP_INQ not supported: SKIP"
+		mptcp_lib_print_warn "INFO: TCP_INQ not supported: SKIP"
 		mptcp_lib_result_skip "TCP_INQ"
 		return
 	fi
@@ -339,12 +339,12 @@ run_tests $ns1 $ns2 10.0.1.1
 run_tests $ns1 $ns2 dead:beef:1::1
 
 if [ $ret -eq 0 ];then
-	echo "PASS: all packets had packet mark set"
+	mptcp_lib_print_info "PASS: all packets had packet mark set"
 fi
 
 do_mptcp_sockopt_tests
 if [ $ret -eq 0 ];then
-	echo "PASS: SOL_MPTCP getsockopt has expected information"
+	mptcp_lib_print_info "PASS: SOL_MPTCP getsockopt has expected information"
 fi
 
 do_tcpinq_tests
-- 
2.35.3

