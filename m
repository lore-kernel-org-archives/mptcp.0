Received: from EUR03-DBA-obe.outbound.protection.outlook.com (mail-dbaeur03on2086.outbound.protection.outlook.com [40.107.104.86])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 080B13C094
	for <mptcp@lists.linux.dev>; Tue, 21 Nov 2023 09:55:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="YlL2E06O"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DJUm2W1twA9navlL3a4F73eYF7XjykdMEcy10b1a928QFPT35Pz/7dg7sAw4+xoYwKScM6lblNLwT8KUIWhD2fyV+CLVxuCGmm1IYzPMu2MozYkAiQkAtAY7XmIumSpe1P/q4Mgp6vg499vWLRfC5oXHp0Vm8ZfA2Rq1l7vc4PbUtw4EdmgYTOL3FS/v8Oup1gX3gTnxwjZBI9rrw+mq9Ad83t3ay33Db6Fhuj6kaw9+Dzp5bXOEwq8bC5G497zLOzkqjM/Sz57mD1vgRKcnxxRMsk/esWkGGxwdFW6HQ5guqAtJXZcV5z5Lj38wXISwnBVtwXF2QNjacr8M6Tm25A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qN9PrKZSypFBQZEMwr8q1OvVi/SJ3683OBTM3nsBvIs=;
 b=SiWz5y61K8JITRfHMMPNOyFZOgzyZbyuXvLizvPpblp7Ey91MUhgerp3HZLAeVW1W6qIKvXLt6OEAJ66wrHlfCVG+YQOzAjj+n3g6WMLNRvjdeMrWX0Wxe8BRqF/p+vBajY0df0jvHbYGEXJHliBF/50WKBYHYxUqRJr6olojtrHa0o3P3FPMsvUtipi5spPZchPbSzrrLPMptqw2n6Lqj5AKUgPEpIPFde/AUKfMdvmW+nq5YC6kp3CGeRb37GDvf0Msg1+vBbP+jBpjDgELme5tsQDzifJvU9wHio7bfqzhro1UJfnbKU/kEd5SEn7CITw9zDSg5L/tJvFGcj2+w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qN9PrKZSypFBQZEMwr8q1OvVi/SJ3683OBTM3nsBvIs=;
 b=YlL2E06O+nKh0AQv8C1NVy15Hejwjir0xzCBTuggcxySZFDdAxFJE91AVvsuHCO70cdiqOaAiPU19fvv5IYxuCYpr3VN5IjzsBp5NAQjPGNFTr72mDigEwnf15Jr9Lzpp2Rlp2GfoPYyZdTS0vEum+zBjroMAMjW/9jn71l2aNbctOoCXy0DmecZnbrDCi7VUCACFAKjPzLKww/se+z5nI8Uts/+6G1nLtzKy93XPvH32e47p8aBp52h+ZTShzrVCUnjJMTHB6/7WAWHHeOSMb4UqNAfGAHxE2l2RVo3UpQlrdV7Z1msD3V9uTHU1t6Mtn/PkkvJbicQRrm/jK/Rvw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by AM9PR04MB7620.eurprd04.prod.outlook.com (2603:10a6:20b:2d9::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7025.17; Tue, 21 Nov
 2023 09:55:50 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::7102:259:f268:5321]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::7102:259:f268:5321%7]) with mapi id 15.20.7025.015; Tue, 21 Nov 2023
 09:55:50 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next v12 21/28] selftests: mptcp: flush userspace addrs list
Date: Tue, 21 Nov 2023 17:52:44 +0800
Message-Id: <8844625ec057447cd97786a5dcdc9f1ddff1734d.1700560046.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <cover.1700560046.git.geliang.tang@suse.com>
References: <cover.1700560046.git.geliang.tang@suse.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI1PR02CA0014.apcprd02.prod.outlook.com
 (2603:1096:4:1f7::9) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HE1PR0402MB3497:EE_|AM9PR04MB7620:EE_
X-MS-Office365-Filtering-Correlation-Id: a3803bb5-e307-4b4a-07f8-08dbea780a88
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	n93yRGxOsdRtp4rZ+ix9/d820Z3zAvyM8HWhZdEL4cbuxMu/UgHYw0QjVbgNILUmTPALGBlZfrPhTNFTcNKdbxjfL2YCaDHhdqmd7nBHWhpZeMbXWWT+P4QKQJlUOpHaxpIxcg2Y2HxJXnlu/edBeVbTUMyHMgvWr8LDChGikMXORTiupIpM9MYvfWaBLpliHscvPj9OqeaMo8VBYouDm8XYm7qWbTmWaalwsfDvd9uglIc0WElTaQJFBuyg3mWDQcwxkxH1guCmtN1Q2IMLKYCwcLhmYsXHF5RUMnmnh3p4N2u0gUSOspD33i43+03K06WfZKX3agFaG069k3lWo38tAmySxVKEb4NqSfz9QugfEgkNUpSeOA57ExdCrVc4Q5QYl66ILxdrVBfQYUdL3IRNAhcTTtxI6cVDtE8hhuC9btwwpIpecJH9MqfkGo5FnFrVINkDn+I8EWXq8Rs+sFelGUucHIyAagCVuGED/r77Nv8qkfnmYZQFMLkSap3SySK1L9NbtBml3MSXeZiFsk6MGIc/YbIrIiO4JeZxYHJzKM4+MNA3jeNGtwhD0Exz
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(39860400002)(376002)(346002)(136003)(366004)(230922051799003)(1800799012)(186009)(451199024)(64100799003)(5660300002)(44832011)(2906002)(41300700001)(4326008)(8936002)(8676002)(66946007)(316002)(6916009)(66556008)(66476007)(86362001)(26005)(6486002)(107886003)(478600001)(6512007)(6666004)(6506007)(36756003)(2616005)(83380400001)(38100700002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?M6Hs4q339yaQh6V5EYqDYk+e97N63zUOXZ7U4ayzqGGaXGPyf2tiENqg7/I3?=
 =?us-ascii?Q?k9MR1D56cxBBOD935s+qJSCf4gjXIj5bO7Q49wtvFXbQXrq4mYj0U5mks/C/?=
 =?us-ascii?Q?XRMeZT/p3QdJ/y3g9EIxVqJrG2/UFdvuq7ooJVZjNtnjo/x9FF8sYV7yyT3Q?=
 =?us-ascii?Q?C8VmINIx7rizLeB8k6d+XmcQ0qLEZv2T4f2LK5sBdQ+Hw8Zj0wOE8Bws7yLv?=
 =?us-ascii?Q?d+WItwu5KcttbKxlwTv9xuKZvqrkbVZ/HpzzvGbgsfHKwJ801+nhJdRn0C83?=
 =?us-ascii?Q?sdLBRmUoMhLiT/UHa93JuK9IRdglXRXvPglXRRpyXybyFTH7PkzNTtRzDg4w?=
 =?us-ascii?Q?3P8XkmZFu/Qb0Kcjb9nkzIw3/n+g2js/ueCEJ9sKTZCXBV6YDb0O8cfky8tE?=
 =?us-ascii?Q?ajfuyrCbeUCGt0MqFZ7YsNZyySDAMZ24tUHXvghf2pHEVn0rs98zVxxHGOAb?=
 =?us-ascii?Q?TtSLetrJL4xoFQy1XZDIf141r49Yjs8+26/BB6u13RBtot0SqzEv5NsraYtB?=
 =?us-ascii?Q?3teyvqxsM6O/8GvNntjINsJhglHrpzIbqGTMntNdQYZAcuuN5C/bO26HbKXW?=
 =?us-ascii?Q?lY2JfElVGZ1hPNovBrFZQiBetWu76Z39vdt1BfTLFifO2jxzBNcLy2anTItZ?=
 =?us-ascii?Q?V27NNlzc53TCwbuRK7t72vSUamBQV9qotk3XVdULKCvlzWkBZywJD70PUAkd?=
 =?us-ascii?Q?OCFXzk2DInY6fLXEKr1zl1aWjWqD0GursnAe2VPouIk8vbrQobNjJ183ffAI?=
 =?us-ascii?Q?St7fx2XWW8znNVCvr6y80/RsKbUPkj98p+hSYgztyePRwtiak8fxm09VDEk7?=
 =?us-ascii?Q?JvyhRNYM1dI5FVqGQMsEBSt5X4/TlXov5/eN2bqmhOihtIfWwzRWnU1WO60Z?=
 =?us-ascii?Q?RtRQdpiL6um0uh47+N8MGRmQwJurK6n6BTLMB7HW5c8mjAB618YmzlQmzoga?=
 =?us-ascii?Q?WgUFHKVZnR0JMp/i9p/6ckR6FDuLAA7UAoSGNUgsnSkD34RryDhNdD314J2Q?=
 =?us-ascii?Q?BBPUymNiYDOIhioj49GYmDZYBxmhpV18x0IJPepub9XVhA/ylypXdZiQjkgn?=
 =?us-ascii?Q?9T6hd0SN6hW+l2K7VT++VMK8K/aD5MXoARQRr9aux9rDf0oXGa7D2LvNhBmm?=
 =?us-ascii?Q?GSKJvNnwxfRpXN5rTLH3u5VFBgUyFOwXtKNzNydvJebkCGvAmRwOykLsLt4g?=
 =?us-ascii?Q?KGIldMXgcn2oEvDzunuRrsVYvYI6AZLrEbKYqzg87PNe4f8viUDiLYBOHcZb?=
 =?us-ascii?Q?9QGgISoRjCznbStHd7ouqxNjVyhTERDZt995mYrf6qBySjTF9i+pyyAqGB+O?=
 =?us-ascii?Q?Iof9bBn4WCsO2iUvCO7PFCP0JJXMR6ycNSREOEECCFgsr7gCYC4BdFKwffsW?=
 =?us-ascii?Q?jmfStY7W1uQnB1LBsgdFE77XsPXv57uv56YVt06g5N2SxSeLYuSOP1CNlgN5?=
 =?us-ascii?Q?q37ZwJ54v8NI0i+Bpgppqurhd5g6iuE70+q9cyxkPxVvuVfrzI1Xt121r0Q0?=
 =?us-ascii?Q?5ldUgCl5vAJ855ooNBAshR7J14j+sB7c2x3IA5O96CBa5sxa3e7N1xzQzKSw?=
 =?us-ascii?Q?ZsTxDqJM18zSuSupmcZtY0PDJXKnscsD/Ox8o/bGj3bs1g9Yw/HTzUEZ+B1M?=
 =?us-ascii?Q?zg=3D=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a3803bb5-e307-4b4a-07f8-08dbea780a88
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Nov 2023 09:55:50.1430
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1KWK0199gQSia4a/DVSQauiQPVw36CigohJ3k5KaHicqq/ftcdw+aP2RLcrRcVs0DtkIpTFndNZtswVowB80UQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB7620

This patch tests newly added flush command for the userspace PM. Add flush
commands into userspace pm dump address and subflow tests. And use dump
commands to check if the userspace pm local address list is empty after
addresses flushing.

Signed-off-by: Geliang Tang <geliang.tang@suse.com>
---
 .../testing/selftests/net/mptcp/mptcp_join.sh | 20 +++++++++++++++----
 1 file changed, 16 insertions(+), 4 deletions(-)

diff --git a/tools/testing/selftests/net/mptcp/mptcp_join.sh b/tools/testing/selftests/net/mptcp/mptcp_join.sh
index a269448bb61a..1145e5f98977 100755
--- a/tools/testing/selftests/net/mptcp/mptcp_join.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_join.sh
@@ -3514,8 +3514,8 @@ userspace_tests()
 		wait $tests_pid
 	fi
 
-	# userspace pm dump address
-	if reset_with_events "userspace pm dump address" &&
+	# userspace pm dump & flush address
+	if reset_with_events "userspace pm dump & flush address" &&
 	   continue_if mptcp_lib_has_file '/proc/sys/net/mptcp/pm_type'; then
 		set_userspace_pm $ns1
 		pm_nl_set_limits $ns2 1 1
@@ -3532,12 +3532,18 @@ userspace_tests()
 		mptcp_lib_check "ip netns exec $ns1 ./pm_nl_ctl dump" \
 				"id 10 flags signal 10.0.2.1" \
 				"      dump addrs signal"
+		ip netns exec $ns1 ./pm_nl_ctl flush
+		mptcp_lib_check "ip netns exec $ns1 ./pm_nl_ctl dump" \
+				"" "      dump addrs after flush"
+		chk_rm_nr 1 1 invert
+		chk_mptcp_info subflows 0 subflows 0
+		chk_subflows_total 1 1
 		kill_events_pids
 		wait $tests_pid
 	fi
 
-	# userspace pm dump subflow
-	if reset_with_events "userspace pm dump subflow" &&
+	# userspace pm dump & flush subflow
+	if reset_with_events "userspace pm dump & flush subflow" &&
 	   continue_if mptcp_lib_has_file '/proc/sys/net/mptcp/pm_type'; then
 		set_userspace_pm $ns2
 		pm_nl_set_limits $ns1 0 1
@@ -3554,6 +3560,12 @@ userspace_tests()
 		mptcp_lib_check "ip netns exec $ns2 ./pm_nl_ctl dump" \
 				"id 20 flags subflow 10.0.3.2" \
 				"      dump addrs subflow"
+		ip netns exec $ns2 ./pm_nl_ctl flush
+		mptcp_lib_check "ip netns exec $ns2 ./pm_nl_ctl dump" \
+				"" "      dump addrs after flush"
+		chk_rm_nr 1 1
+		chk_mptcp_info subflows 0 subflows 0
+		chk_subflows_total 1 1
 		kill_events_pids
 		wait $tests_pid
 	fi
-- 
2.35.3

