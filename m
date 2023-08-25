Received: from EUR04-VI1-obe.outbound.protection.outlook.com (mail-vi1eur04on2075.outbound.protection.outlook.com [40.107.8.75])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB56C7E0
	for <mptcp@lists.linux.dev>; Fri, 25 Aug 2023 03:50:45 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=C0Ps6hl2vt+JKHVcHenUBFaq/STPraJFOSjaAuAYiytp8J0kiATtW2jYwzFwdIzS8qBgcsKwvzjILdGCBGpKo+1gG2iNmVnrjEPG3Ymc1emCP1j1uyQXaAxXJK69to9TMsjC9Q5zqzPEsWzyobbxUR6e4jT9RMNSiK2rMZboij8Vr4JSIld463rK8uubuBAibmikWuwCfnrIMSWAfVebbQxM0eyWULOVjQlTelOfzWtFogXpb7P1+8ymEpiFl2SwEO3uDQJUmDYuN7Vv6ZUVwXjMx+SlMKiHEptdCSaviTR6Yr2pN0JxQarMr/yx/sNT1GWJITw/CdlVq1DhOh59qw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cqGHcroKpYFkVUwXhgBh6SqR4J+n8/y+Bs8j1PjjpDM=;
 b=eaLzG/dvUb6PcbZHeC6FJeR0nQGQ3KtCkvqAsrD3BNTz2dFTFMU3fMfwOADQH1CEzQ+nPJa19sfswUVrlcZG9ppAZlB8zhmvZ+hA6ghnn4iXNArjjmNaERC3MR7azyXiEOhxZtYhaRDPFGGOfmA8GDAJ+1olWzNQ1wCTtjNO6gXtoSq2zmbFoLo1xbkUNeHO7Yk/iGHbXR6ToAujoQGZb31XYU1bfe2SJzBSWVHCJQ8jAZnbk2NtvyJDPX423dmvc2XjbM5FNGZ84+d9KdnnEe5qPDAK46w3yt+b1b1sXmhc81UAQlX20QtCx8CTytXCZrxfW2HJfV8+6AUMdSOxTA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cqGHcroKpYFkVUwXhgBh6SqR4J+n8/y+Bs8j1PjjpDM=;
 b=To7Le4vQDUlieEsPQVLz5/29EZwfnA6xcnOLavXZ4rUsUb0jPF+W6fvJrPHQIJuZIlnB5n2BYwt/o7/FgNyj/Q6ivytHXXh++O6f244GSYjxV9nvBrItIhI4Ai+f4IsbA6GThlfI+gngm8hBPG46a7RdaXify0GjXVuB5zibTEiwiEok+5cHXVvhdYUWZQpERP1vQBNjjXt1ypjfzTuRP94CknSOPMsuci3L4V+xIqtPogDsU+63PDLhsOrv6jTgRxZf6+FAQKdYXsHFmh82S/v/eXgwtyN+fDPSdojxNhrTnuWhL1CMTec9StARcn+U1mHKFuVEZxk88pKfcubTJA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by AM0PR04MB7091.eurprd04.prod.outlook.com (2603:10a6:208:197::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.29; Fri, 25 Aug
 2023 03:50:43 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::2867:7a72:20ac:5f71]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::2867:7a72:20ac:5f71%3]) with mapi id 15.20.6699.027; Fri, 25 Aug 2023
 03:50:43 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next v6 03/10] selftests: mptcp: update userspace pm rm helpers
Date: Fri, 25 Aug 2023 11:50:21 +0800
Message-Id: <ba4d07224a376f9755242c4dedf6382da3204b80.1692935143.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <cover.1692935143.git.geliang.tang@suse.com>
References: <cover.1692935143.git.geliang.tang@suse.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TYAPR01CA0138.jpnprd01.prod.outlook.com
 (2603:1096:404:2d::30) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HE1PR0402MB3497:EE_|AM0PR04MB7091:EE_
X-MS-Office365-Filtering-Correlation-Id: 6788b256-a118-4565-924f-08dba51e74c2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	hN1Luhj1naCEn4RbbOMQIzir+FkLYql9D80IAQuwNqOeHDT5eNhQLl2x5kmQ9a3EEZHB7VLdK32spMhwSEfDR14eOyfbsh9bt9TQtoM4hCSrv8W3GlH1hTl1mpggvBv5GY3okqqrFVud8wXfYTnhKe4H487W9DO5CQFa0BJQaJSOCxTZ5fvjRiY4lYbyH/ItvwnVIDScDEai8ZCpOYjkyoynZixjrrb8cbH4YZHROlavve8kDun7mx21m2yPukkfWBB5asSNlFlTfRPIrPI4WwwNE8XeA3L95cxhB2yB7uwuI22PJevd9dgp7Er27VleO6fnZwCNY+tyDvz7wrcYzNsDItyJZPstB+Ndvhyq/jUP5Bg5rX+Wt/ZXxZ4n6AbMtzjqdhelvAG/6bVFm/2ewIq9oun3GgkEcqO1kD1V/fHms1kyTT8sflf5MXtTnrWEWeymyCnxmC6A6DmVWCm0IccoesoNMmLYudX2M/oy/sQK48Q/t5KTXJXj5RPEM5wW6SQRZ4VfetR9FKsfgchoMHWmwEmJ1Tv3YMt/YbCnH0VZgvJ4mzRV6moYWOxaJxRlrWyOUy+BB0QAgDoESMDAMXUnNCt+tSgkdeQzbK3rJyM=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(376002)(346002)(366004)(396003)(136003)(451199024)(1800799009)(186009)(38100700002)(4326008)(8676002)(8936002)(41300700001)(6486002)(6506007)(316002)(6666004)(36756003)(6916009)(66476007)(66556008)(66946007)(86362001)(6512007)(26005)(478600001)(44832011)(83380400001)(2906002)(2616005)(107886003)(5660300002)(13296009);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?TthewTfbbB53BMptjxyKFgmV/0ioze34pMnmXQNTO1hxx0yiqvUlK3li2qEF?=
 =?us-ascii?Q?m6CIEreHX8Bm9y5aEQCDccibyBSi2Gg48AuCuuiUa6cX4XBzAUgUHXdiiONk?=
 =?us-ascii?Q?og1QkR++M30jPcRzUBL6lf+faVj1WLSTjv/V+a9cukwz+AAWxfSPJ27qfSRQ?=
 =?us-ascii?Q?ervekZsy6zO93YWihPWyVUtGyqJ0BD/wwB9cA7z2ZJNMlDX0W2N5KKbG0rYN?=
 =?us-ascii?Q?aX6i/E8cKrfCXfvj1XMV6E7DH/UkK4Bio1bvX9N5OTaktR8OT1MmcDmm03WX?=
 =?us-ascii?Q?XHERKQIhxejUL6DqJL1SXLuCXVAzXGw1LG/sTh98TUnIyEfQTxNdP6s3TY5t?=
 =?us-ascii?Q?pZgSJ1kHj+nSWsqPXEsX34eaYQATOnx6HxnNZijNpmCjnTOPzyHP13lgH4ER?=
 =?us-ascii?Q?ZEgj3+sIKZb0EOlpF4ynf1Yl5f+pTke1yQxCX5u4yj2KQBjgdaeoROng2/c8?=
 =?us-ascii?Q?SxTXqgTvbaXn8jMXZS9YOhCsUNbrHg9/ykZrX4BzVE4cY99d+hiX1pM99s0N?=
 =?us-ascii?Q?VGDyv+g1biz4aFkU+7SY8q0UREo1hvxgDGvMu6E1K7bNddnRFHqx635eTR5m?=
 =?us-ascii?Q?HS6MKFO2fsPqpPOJvDwhwNfG7koQVYtCIiG8Xj5P6S5AJxE/jff30kob9/Ia?=
 =?us-ascii?Q?uVFEHVdA7M168X6MNjdpk+lrayDSakR6yDmIRt8qrf4a5c9VxI2s3BitcyjW?=
 =?us-ascii?Q?uMhIMpCPuXlf5Wlp4CZC+nm6WuvIlxDha6Hxqg9j5DAFMdLcCftTKNgc1nwt?=
 =?us-ascii?Q?+TOW6+/mOxr0xkzVmbyAB1MWq7sl1n5+tgLIpqR6ZqH2FoM3dVRLdmGeCVwm?=
 =?us-ascii?Q?I9LZtDdU/ls8+sb1wlL+QvSZdxyRMEx9TWbcV5Fu/ZrIs8oIsjszMUIISri/?=
 =?us-ascii?Q?SlylSxDk+oF+vsqpz2TliqzGBgQ9CW+FIzG2n1qItMH954M9RPR6M9OS2yGi?=
 =?us-ascii?Q?ScXWa0LgrxwbV0AXCyg4mHEV5WvaTTlRPoNnT3vC42c+698HOfSuJlbLAvd3?=
 =?us-ascii?Q?8V2P7w4tR0ldHyJVfZLjX/k++RNkaqxAI6m07LCzTbSVzxIl1hOnmUBFPLLo?=
 =?us-ascii?Q?wImgEY5OofTWcnU5GriAZlqbhVOm3/sBXJvDBEem7WfDJKSs+61DNVCLiL4Z?=
 =?us-ascii?Q?JnHfVAe6bNy8dW6xmP+su3GHbO89/JzS/sbD88NVqYppQ0PiflSUEI6Dtq4E?=
 =?us-ascii?Q?V/WkAtLFyeuh616dQwZ+b8MKT7Oxlk/wcRDzsKrGMFrkcDBrFxEGJu3wJalc?=
 =?us-ascii?Q?+SkrYuiirHjAYpB8ho6FaXGSyWoqke7U+qT3zZV2zDR4TAJengSynAHxkJtR?=
 =?us-ascii?Q?72n6LKZGNKUGFTJEYFHzsrRkxl75ekj+m+pQeuT5J3As4+IhUeDWHqT4nnjN?=
 =?us-ascii?Q?XLBzf7ExxNyIbxjLv9k89qQqMoGm2bEb+NIAi7laBKm1Z6EW//tIZ7itjdmq?=
 =?us-ascii?Q?2F6ARjNkMrZR1w8TZmsAAZEn3/j4teuA4E1AxYaB4raC3lysjUELqF38gmuE?=
 =?us-ascii?Q?Pzau/PI8NjDCwEwT7IGKVexsu2O7aKE2wRzrTmHyuiEiXDu8J6SJ8BF8MrZj?=
 =?us-ascii?Q?qI5fYKoEN5zJP2EWmMahzUxH14DGeJSYOSIIoV4B?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6788b256-a118-4565-924f-08dba51e74c2
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Aug 2023 03:50:43.3050
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zx5tOY7/4E4g7iEZx1jc9FZqOOskNakfox9YZ62NPNPUaaja7fbmcNXxzs/VUKgZxR3eEbdhhyOzHEAnOY3+lA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB7091

Add two more versatile helpers for userspace pm remove subflow or address:
userspace_pm_rm_addr() and userspace_pm_rm_sf(). The original test helpers
userspace_pm_rm_sf_addr_ns1() and userspace_pm_rm_sf_addr_ns2() can be
replaced by these new helpers.

Signed-off-by: Geliang Tang <geliang.tang@suse.com>
---
 .../testing/selftests/net/mptcp/mptcp_join.sh | 59 +++++++++----------
 1 file changed, 27 insertions(+), 32 deletions(-)

diff --git a/tools/testing/selftests/net/mptcp/mptcp_join.sh b/tools/testing/selftests/net/mptcp/mptcp_join.sh
index 3e2745717913..2017f14408b5 100755
--- a/tools/testing/selftests/net/mptcp/mptcp_join.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_join.sh
@@ -3277,25 +3277,17 @@ userspace_pm_add_addr()
 	sleep 1
 }
 
-userspace_pm_rm_sf_addr_ns1()
+# $1: ns ; $2: id
+userspace_pm_rm_addr()
 {
-	local addr=$1
-	local id=$2
-	local tk sp da dp
-
-	tk=$(grep "type:1," "$evts_ns1" |
-	     sed -n 's/.*\(token:\)\([[:digit:]]*\).*$/\2/p;q')
-	sp=$(grep "type:10" "$evts_ns1" |
-	     sed -n 's/.*\(sport:\)\([[:digit:]]*\).*$/\2/p;q')
-	da=$(grep "type:10" "$evts_ns1" |
-	     sed -n 's/.*\(daddr6:\)\([0-9a-f:.]*\).*$/\2/p;q')
-	dp=$(grep "type:10" "$evts_ns1" |
-	     sed -n 's/.*\(dport:\)\([[:digit:]]*\).*$/\2/p;q')
-	ip netns exec $ns1 ./pm_nl_ctl rem token $tk id $id
-	ip netns exec $ns1 ./pm_nl_ctl dsf lip "::ffff:$addr" \
-				lport $sp rip $da rport $dp token $tk
-	wait_rm_addr $ns1 1
-	wait_rm_sf $ns1 1
+	local evts=$evts_ns1
+	local tk
+
+	[ "$1" == "$ns2" ] && evts=$evts_ns2
+	tk=$(evts_get_info token "$evts")
+
+	ip netns exec $1 ./pm_nl_ctl rem token $tk id $2
+	wait_rm_addr $1 1
 }
 
 # $1: ns ; $2: addr ; $3: id
@@ -3314,22 +3306,23 @@ userspace_pm_add_sf()
 	sleep 1
 }
 
-userspace_pm_rm_sf_addr_ns2()
+# $1: ns ; $2: event type ; $3: addr
+userspace_pm_rm_sf()
 {
-	local addr=$1
-	local id=$2
+	local evts=$evts_ns1
+	local ip=4
 	local tk da dp sp
 
-	tk=$(sed -n 's/.*\(token:\)\([[:digit:]]*\).*$/\2/p;q' "$evts_ns2")
-	da=$(sed -n 's/.*\(daddr4:\)\([0-9.]*\).*$/\2/p;q' "$evts_ns2")
-	dp=$(sed -n 's/.*\(dport:\)\([[:digit:]]*\).*$/\2/p;q' "$evts_ns2")
-	sp=$(grep "type:10" "$evts_ns2" |
-	     sed -n 's/.*\(sport:\)\([[:digit:]]*\).*$/\2/p;q')
-	ip netns exec $ns2 ./pm_nl_ctl rem token $tk id $id
-	ip netns exec $ns2 ./pm_nl_ctl dsf lip $addr lport $sp \
+	[ "$1" == "$ns2" ] && evts=$evts_ns2
+	if is_v6 $3; then ip=6; fi
+	tk=$(evts_get_info token "$evts")
+	da=$(evts_get_info "daddr$ip" "$evts" "$2")
+	dp=$(evts_get_info dport "$evts" "$2")
+	sp=$(evts_get_info sport "$evts" "$2")
+
+	ip netns exec $1 ./pm_nl_ctl dsf lip $3 lport $sp \
 				rip $da rport $dp token $tk
-	wait_rm_addr $ns2 1
-	wait_rm_sf $ns2 1
+	wait_rm_sf $1 1
 }
 
 userspace_tests()
@@ -3421,7 +3414,8 @@ userspace_tests()
 		chk_add_nr 1 1
 		chk_mptcp_info subflows 1 subflows 1
 		chk_mptcp_info add_addr_signal 1 add_addr_accepted 1
-		userspace_pm_rm_sf_addr_ns1 10.0.2.1 10
+		userspace_pm_rm_addr $ns1 10
+		userspace_pm_rm_sf $ns1 10 "::ffff:10.0.2.1"
 		chk_rm_nr 1 1 invert
 		chk_mptcp_info subflows 0 subflows 0
 		kill_events_pids
@@ -3440,7 +3434,8 @@ userspace_tests()
 		userspace_pm_add_sf $ns2 10.0.3.2 20
 		chk_join_nr 1 1 1
 		chk_mptcp_info subflows 1 subflows 1
-		userspace_pm_rm_sf_addr_ns2 10.0.3.2 20
+		userspace_pm_rm_addr $ns2 20
+		userspace_pm_rm_sf $ns2 10 10.0.3.2
 		chk_rm_nr 1 1
 		chk_mptcp_info subflows 0 subflows 0
 		kill_events_pids
-- 
2.35.3

