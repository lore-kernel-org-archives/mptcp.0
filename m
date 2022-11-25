Received: from EUR04-VI1-obe.outbound.protection.outlook.com (mail-eopbgr80083.outbound.protection.outlook.com [40.107.8.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A5F115B5
	for <mptcp@lists.linux.dev>; Fri, 25 Nov 2022 01:50:48 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DozhlmRxGrvKSMOq74t83iG4nicgmah7B/uPPrG81v7OZrigfgY47FXr/6mqzfY+CBleEFtFi8rfMxhSct5SjFO09RJtDPQBGmlpv4WKQ3HxlPYiiAp0NeoGPJ65o+2/ajfEei79tK3uy+ZbG+GXKb1P900CLTva0hFchD+t/yqlTomhYoSHGPJqWZDgXCI5yT83u6QOcEdCKc950WSDH48vcbJFwmHMQMcKBIamire0yMwNlJRZgMqVv3DwPLlB2RhwpIp8B3fYzPv+w7ZOZExlISwIVd/qeUQ39RazFkYfX4X0hMHIfxowdS9cxbwuZU9N+2xXVQkAvpRl96n9hw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=n+rqgTNEmHoImvoOaDgpoAN560cVCi5HeMses8/++3Y=;
 b=EW+UhIBu3BXQ/8O0XBwBHJoqPfaOjTxqUsHs2bk/a+AvPjt/fYN32nX/VR+f2JuY/DIHgrERwT2LXLjrEX0YkjlPxf1tQZbkRYybMniW+wICf+h5uef29vB0KgHfQ15MUY919h5/3q9V5QcjdFcIrbNoVkNri9A7W9IsxVn0MXdCiXG0xvdJMUmY9O79Mu1d0f6S/2aedhX6RIpRxq9h0Twe+TVNZMDMo+OJ3+OQKSvwCsiu/9xpv5yXVD89wnMkktZHXosg9m3dvOSX7ACAxwz+HEoaDwxF5WvLr9ikkZ7MQcrc6MKp8+KfUl8rFVGWLwmCDZKFY85nv2eikuRPKA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=n+rqgTNEmHoImvoOaDgpoAN560cVCi5HeMses8/++3Y=;
 b=ZvUGYCgbsQbg+nY2MsLDFtUz/g6cz/etCz7GDFI5NMDkglKVCVb3Ibl3zt41OYjWQmqTimjobJuU4fG7NbJOn7xnjXcPG29NDZRxYI1OBgUZWaBkh4bbVDTzlvCL9fT//X4YjOX9nkWTayJSdJAY0yFLgxTzOUI1WWrmkuA5HKZs65hBNX71lFWsDuUk4OHDB+MaZTwdLPe1sVMUCSb74ervBLapInL8iSwqv18ttfiy7CDZHui9xPRjPojc41/bTa8Dx3k9hQP95MGClhEb2pExuBuryHbMtEIFW16fnrmB1QIjxV5Y0OXe1OamgKTGN0WWaRHFt/99WPPmXb4GFw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from VI1PR0402MB3503.eurprd04.prod.outlook.com (2603:10a6:803:d::26)
 by DB9PR04MB9579.eurprd04.prod.outlook.com (2603:10a6:10:306::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5834.15; Fri, 25 Nov
 2022 01:50:45 +0000
Received: from VI1PR0402MB3503.eurprd04.prod.outlook.com
 ([fe80::89bf:6855:abfe:203b]) by VI1PR0402MB3503.eurprd04.prod.outlook.com
 ([fe80::89bf:6855:abfe:203b%7]) with mapi id 15.20.5834.015; Fri, 25 Nov 2022
 01:50:44 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next 1/2] Squash to "selftests: mptcp: listener test for userspace PM"
Date: Fri, 25 Nov 2022 09:51:14 +0800
Message-Id: <7416de705544121ada6c71199d728e8307223eb0.1669340938.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.35.3
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR03CA0127.apcprd03.prod.outlook.com
 (2603:1096:4:91::31) To VI1PR0402MB3503.eurprd04.prod.outlook.com
 (2603:10a6:803:d::26)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VI1PR0402MB3503:EE_|DB9PR04MB9579:EE_
X-MS-Office365-Filtering-Correlation-Id: ddd077f8-b108-4a1c-bf12-08dace87774d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	Y4Y5UdtY8oiEvJTG8o+WBVWDhLIBD5om+Hk4bNXJf4DwwnMRcbsrJx6zG6PxQvxFVeR16kLRFLKs2dD6Tbx3+idSypFS1s7E+V4ULea0O3FUatpLH79mE9niQ1q7Bn1u5J+pFNzgHnaZNeH1X12/9nHmk84WtpCLf3Jk3VK9ghM2beAIewW/3BDR+QTjODBnz7bR12diDZO26uP5M45twhV53ea7BIJijjhYVJUj1WAZ9GpuJNsU0PixSFqO2LxUWRfOpMsZpZWJsMxt+C7ULYBA6741etaSeUh4oyqucFEQa57hM8z1o/0i3Z9B6hOYMvF3twOG8pX7vCi9fZHeVIlJpFHbmwXMJCaPVjPc+ZAeBR+m7oPVZJa/zfJ8rpWLjEi+qXv60VVuSrIklWY8Lm9f6Zm4fz2V5bQ8YDtWf/oDNbJ9F2rc2cHCqOFHq+Q6FHGrqydPtn1pzb1mIGFoyuuaxfMc2wgSX1IQJ+B3PxzDeYF7PZ9iGnjnQ7dIqdpcQqgVCIWV2wSHAfmmBt3Vrd5g1jDXoXGK8bWLK8dzX/9gDe/iIWGo7TWEzINGxtfiPJ+Tmqv68SmrtWA0Vh8yhgvA2Pyxj/s+ReuhcN9psBCYKLKtwr9uThlR4ANBAVFKY+euLJs/evvhBt7iovEXsQ==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR0402MB3503.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(39860400002)(396003)(366004)(136003)(346002)(376002)(451199015)(2616005)(186003)(6506007)(6666004)(6512007)(26005)(107886003)(316002)(6916009)(6486002)(478600001)(66556008)(66476007)(66946007)(8676002)(41300700001)(86362001)(44832011)(5660300002)(4326008)(83380400001)(8936002)(38100700002)(2906002)(36756003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?3xmA0Kr+RYN759FfOBDLcLlItuMtAmQ/wVpKbplQ2P2jpDfS5fdxKRPAkB+6?=
 =?us-ascii?Q?ITX5BTJfzMgSxRjp+yE+n//zBd+gwZlamX2Q1gqNpMJwrcsufKwjd8YjadtQ?=
 =?us-ascii?Q?OGuZ49+5Ay9AoFLFfmHkGC09xNnMwlWl8tRgchvv05RhJt1wdl7/my0Q53uh?=
 =?us-ascii?Q?VGeJ0bjIH7MLyLPfwzuLr2y94ND77UvWgiAMaPpS/KU8D4Ghfc0+UhlgVPZb?=
 =?us-ascii?Q?fBv79Kc23Y0FWYp05tAxvi306Gf4gfXzVBhXFtp9l3UxjzLyww1Eu0bzQIYz?=
 =?us-ascii?Q?uMGQf9Anb9n81ZcTzf53PA0r0hH9oq7tRuAK7QeR0rAcyM4MusX63bhq3crw?=
 =?us-ascii?Q?OtRYp1VoSH3I50pnn4gpeg+AUzfIoMq2EgAzjoXLhqzf0NYtIvWSVMzDgV/z?=
 =?us-ascii?Q?5VXZIm1TGScP3UW03yxi/cAnphWEl7xw72406z3DzCreVzY0nCXURSwsj1cE?=
 =?us-ascii?Q?i5iM0MwaNZzJUFe25HkO47BaO7UVcTr3pRoQVdnutY7emPGZrp2CqoE+p1Fk?=
 =?us-ascii?Q?bbwymdQfCZbb+T3HcrZew88hICH8SlMqdVtuyHKzljX5Nq5lh6vAlrYz8Ozz?=
 =?us-ascii?Q?gPrvLIaqb4VnwGmGEHtklLpBEHHXkjGbVOd33hFREdUhwAY8puFy0zNietoN?=
 =?us-ascii?Q?ve1Jv9drhDPFZ7gJgPCjRiiUsVDklqp336Td5cOeQ7uJHTItLPNmFasqAytB?=
 =?us-ascii?Q?3RMZQRPu+KINBX42R70llNGZxDWf0o84KW96ttZmF+XQwxHvcVH6QwByDfq6?=
 =?us-ascii?Q?E8p8J4BFA/M2GiCtkTGcKujv86Pxx3D2PS50vOEkQwTdzBNG93B+Gdx4i0Jm?=
 =?us-ascii?Q?1HWlMeTHX/kl2npDZr2BICGY0NOg97CeTTmQipk3wnt9BYyhUQHIRh6yQDOQ?=
 =?us-ascii?Q?tdzOddZHE6o98jsqof9Q4x30ImeVHHlG04PniIFHPb2LJpweTsxCzn6NfhJa?=
 =?us-ascii?Q?qLNMS3rC7I914Iz1/oQHNrxRNellBL5DkAl8SXaD3RFvIF5+BmMLQpYwr43w?=
 =?us-ascii?Q?+M5L644x6Kul6C0euK0Gj4ZPEO1PKlO9xGfBMV8a0Rsf0EWbeZDJ8FF/NCF+?=
 =?us-ascii?Q?pVcyBgBY66oxCscZVR5FGsf6SQC8dfY1SX1wHdev29z+luK3zVbrI3FjWup5?=
 =?us-ascii?Q?+t2lcLRCRWtxXrv3NFl4qAcnRXLY0Bu3wZYxD63VQLyHptSlHkUHpAlPKJ32?=
 =?us-ascii?Q?tqBkpNb28Ledd6AzkTKomD8Ae1Wj414m9ph5rrY/h/CyHOJQv1t0VKkty4l7?=
 =?us-ascii?Q?5VFvlvjH74EvWP0a9H6b1SVEIFUu5eA41bVtzHCQV/Cdp35dKikvhdEQOg5H?=
 =?us-ascii?Q?whBqWq/SJ8eoeWrdnf3b3TlLlaLskwMQpvjlfqzGL1hJhW1WKMxntASkPl0W?=
 =?us-ascii?Q?468DAk8sd24wBN698t97Rnonn7hopopljjaMoaPB/cZjlADUOstwIQqV+5Rv?=
 =?us-ascii?Q?vQbYnpoJm72xN3LzY03dJiTnkyjygcd0gr4dvItILP6FxAoqm5CD9xSRzkZi?=
 =?us-ascii?Q?QWP4+WSJJv0iqyL4l8rV1fISLkZKz8CBbXBFKmSBEVhZcHoqpJ6PrdRNB1GQ?=
 =?us-ascii?Q?iLUqO7CYvEGbRZBcBk+eL/Ze2CECY7e12YbUM9zd0jDbmAKbGTUaZPSxz8sP?=
 =?us-ascii?Q?sA=3D=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ddd077f8-b108-4a1c-bf12-08dace87774d
X-MS-Exchange-CrossTenant-AuthSource: VI1PR0402MB3503.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Nov 2022 01:50:44.5555
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: QbQGkiqvLwsnB36Y51dten5dZM5ceSPk4oSHLJunpp0BsSbi6k9rgdX2m0tMYle6lsxN9kqyNvYuNAj3XYH5yQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR04MB9579

Do some cleanups.

Signed-off-by: Geliang Tang <geliang.tang@suse.com>
---
 tools/testing/selftests/net/mptcp/userspace_pm.sh | 12 +++++++-----
 1 file changed, 7 insertions(+), 5 deletions(-)

diff --git a/tools/testing/selftests/net/mptcp/userspace_pm.sh b/tools/testing/selftests/net/mptcp/userspace_pm.sh
index 40801279ebdf..b0946526d70b 100755
--- a/tools/testing/selftests/net/mptcp/userspace_pm.sh
+++ b/tools/testing/selftests/net/mptcp/userspace_pm.sh
@@ -836,7 +836,7 @@ verify_listener_events()
 		 sed --unbuffered -n 's/.*\(family:\)\([[:digit:]]*\).*$/\2/p;q')
 	sport=$(grep "type:$e_type," $evt |
 		sed --unbuffered -n 's/.*\(sport:\)\([[:digit:]]*\).*$/\2/p;q')
-	if [ $family = $AF_INET6 ]; then
+	if [ $family ] && [ $family = $AF_INET6 ]; then
 		saddr=$(grep "type:$e_type," $evt |
 			sed --unbuffered -n 's/.*\(saddr6:\)\([0-9a-f:.]*\).*$/\2/p;q')
 	else
@@ -844,8 +844,10 @@ verify_listener_events()
 			sed --unbuffered -n 's/.*\(saddr4:\)\([0-9.]*\).*$/\2/p;q')
 	fi
 
-	if [ $type = $e_type ] && [ $family = $e_family ] &&
-	   [ $saddr = $e_saddr ] && [ $sport = $e_sport ]; then
+	if [ $type ] && [ $type = $e_type ] &&
+	   [ $family ] && [ $family = $e_family ] &&
+	   [ $saddr ] && [ $saddr = $e_saddr ] &&
+	   [ $sport ] && [ $sport = $e_sport ]; then
 		stdbuf -o0 -e0 printf "[OK]\n"
 		return 0
 	fi
@@ -868,7 +870,7 @@ test_listener()
 		$client4_port > /dev/null 2>&1 &
 	local listener_pid=$!
 
-	verify_listener_events $evts 15 $AF_INET 10.0.2.2 $client4_port
+	verify_listener_events $evts $LISTENER_CREATED $AF_INET 10.0.2.2 $client4_port
 
 	# ADD_ADDR from client to server machine reusing the subflow port
 	ip netns exec $ns2 ./pm_nl_ctl ann 10.0.2.2 token $client4_token id\
@@ -883,7 +885,7 @@ test_listener()
 	# Delete the listener from the client ns, if one was created
 	kill_wait $listener_pid
 
-	verify_listener_events $evts 16 $AF_INET 10.0.2.2 $client4_port
+	verify_listener_events $evts $LISTENER_CLOSED $AF_INET 10.0.2.2 $client4_port
 
 	kill_wait $evts_pid
 	rm -f $evts
-- 
2.35.3

