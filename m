Received: from EUR02-DB5-obe.outbound.protection.outlook.com (mail-db5eur02on2066.outbound.protection.outlook.com [40.107.249.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6E2D20E1
	for <mptcp@lists.linux.dev>; Sun,  8 Oct 2023 10:26:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="A5XIEhW5"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Rfgic2nOit6iG/nYasE6lT5Qr9QA7X50AXAxmoLwBhiiV29obuf0hh/bUP5Xa73B6pp2y7Dnk+YRI8uHdic4PwtwgytTewCialnR0mCQrROEuoa/AJoUOv8ARgY1AYh0POk8B76we5lOGCcdx24fvXglOU5iHGCM/zAS2Sicwc5UgrJsh4rer/dnShHiTtHFkXKJ7zjyEN6MvK0wnpgcgf5DTyZ5SbfCwfqDNCQYa5H2PCoP6tR0eqyZF+VFUQ5A5fgdfYoQfSAq21737AuVxqO98veTzv/cF8yYHWgBmSEUK+sfaxArAGJOyZ//M60TedsmxefFO51JovZsJdTFNA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/J2xHLMj+l06mHXwPbLntVzmQlrAysdJwE/trXPiZxU=;
 b=gkF/aXmOQhAwYer4E5QAkBcu1woMk5DsjD0tN+0SAMrKGIMf1J18pOVptnxFILc5AMjby+wZ3wewNSNJlPcfRabmOFfq+zxZ7sSARvtjdSNCPvqw0w19/+llE9vAnUouU6v2JwZqT9yrVFuqHldOlRdAkomi1pln2+Q2TPFSv3McGuD5ym5r2HS6jsHg99I+vNeOTXaKYJGjOkfBJZDNizF5jZwA2ytDHXEJv4hzoAz2H3lH5ROo+bKYMwdy6jNQnFqon9QFBU3S0JC38icMBxeHKBQOkDY99sPCLIw9y21V053XoRcUdRsnprKEycJECdT+4xN93NzmT0rguYmmSg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/J2xHLMj+l06mHXwPbLntVzmQlrAysdJwE/trXPiZxU=;
 b=A5XIEhW5eb8e21ypkCnbN8oNcx/0Bn2Cckchi1iBYIqWkrAHyp5U3HfMhAweIa2XRZ/sR0GRyrh8Ie1T9DNNhmXIyiVa3FbPIoIanNYqE5DTK2NzU3V5y5beSuewBPIR6QtbnsKiKVJ0PUdLRSl0mrnLbfmakmIG2XOvgDs9+xt2eEyAHr5ZCl4s01CwzYXpy/vwCkkbw49PZ1SlqiBhl6diTI+c+zoKmdfPzPLixxZV18tkkJskQONeAJChqqun0AB1tUbQwE8LH90gns75MkVkZmBwuaNiirOBNw82+r3pB2YcJVekaHJE+x1IBWcKbYkZRlq67Pan+64DS+jmpA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by DBAPR04MB7222.eurprd04.prod.outlook.com (2603:10a6:10:1af::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6838.42; Sun, 8 Oct
 2023 10:26:05 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::3852:4f89:9891:73c8]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::3852:4f89:9891:73c8%3]) with mapi id 15.20.6838.030; Sun, 8 Oct 2023
 10:26:04 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next v11 1/4] mptcp: set next subflow to msk->first
Date: Sun,  8 Oct 2023 18:27:07 +0800
Message-Id: <6a31565e01d3474be56bdf62c54d0c20c065c65c.1696760702.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <cover.1696760702.git.geliang.tang@suse.com>
References: <cover.1696760702.git.geliang.tang@suse.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG3P274CA0003.SGPP274.PROD.OUTLOOK.COM (2603:1096:4:be::15)
 To HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HE1PR0402MB3497:EE_|DBAPR04MB7222:EE_
X-MS-Office365-Filtering-Correlation-Id: 72d85ba8-abde-4084-fb3f-08dbc7e8fa36
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	BQy90D0cFyNtur8XFgOm8LEl4E2SMBP+rU50sTtle3Cx7xS8o1l4Ln96uB5F7hFR7gVfG9U3DV8cELVsYjQijQjadVhd+z3CpZeYZ3CT4torWOHg4PEB8oCBkvgBfSCKkd7WKbubrNENeUmgQ/51YUCSmgLBRkMKEDeEBAK/Y0avuc6hDawxs6CoBlSBjLG+2NOw1Fh8ANxK3jSXeyyiDBryQUdfwvjWgoskjbK1gilnGhoj+QEcN82lU+Fnb5sGyyolFZugG+YnkzBZwIabJnXUfoWcrV3wcNq8wwZU0IDechb+Smt/2sBXBIdwMdPNgm/ARFSSKhJ4iYUpjclq3x8MAUgRruS/Vohu2HOvoft25Mlhnrsa3h/yFf4xw4pvx38qtc3gQIu8yGvFdDbgZg85LVGWOi4XV2gYgNZqolUZcBG2J08R2e+6OEPWPUBWEDTQsMalzvYGgxtuBPL2upfFl04T7mt0vIKep//DPGQz7sV8r8vTrkIOJcxaYPJYnwJ+CzRfTLuDimYD5SgJX8nQbo/taNBI3YhsvCVvdzLQd8aOvRTZ1jBh6aqN6vwdaOzKUXmRieEyqtPNdd094Wszl+Z4S/o+X+/4IbHlGCA=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(136003)(396003)(346002)(376002)(39850400004)(230922051799003)(1800799009)(451199024)(186009)(64100799003)(86362001)(36756003)(38100700002)(2616005)(26005)(5660300002)(8676002)(8936002)(4326008)(6512007)(6486002)(6506007)(44832011)(83380400001)(107886003)(2906002)(41300700001)(66476007)(66556008)(66946007)(6916009)(316002)(478600001)(13296009);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?/sB8Z+E4pbeYUCylIvTGh/sLmfhv7HbhAE77/XktuE4Z/fYVSUuXubViUtYd?=
 =?us-ascii?Q?MUM8U5kzUuvonr0brrFZWVZHdNlfINKr21whHcu4IgCizTFpRGRY4ZQtGfmm?=
 =?us-ascii?Q?cyHpiw3jp/9vKOpL8rnDscpa1mvJgIMSzKqszObW9WizYQQ79HykUc7KZsRa?=
 =?us-ascii?Q?PjsawHXGuIWIHXtL0/ZUZjMjZnAtfs/Upkcmek6gP8VK9CliEB+AYZl4FWY/?=
 =?us-ascii?Q?6hE6DhzOWLq4+ypAwVf7mqTJQN/eKEWzS/6PkRHwcygboEcdnMudtrmSRCWO?=
 =?us-ascii?Q?MDW0uu+MZdb20IIUsNpwQKw5DuKTZlmnOLZ28FVso6eWIL817qKyjup0V/Zn?=
 =?us-ascii?Q?l2cDYCJeo5pzswzeHIqNQBXgPlQxMaxmGDtcKI7HsCHKfwUnMIfN6GZh7zOe?=
 =?us-ascii?Q?GlKdtb8ko55wRr+7mlaFB9riDmOpGcDHK53CKe6E17/fJzVZoIfnjTvqFmIX?=
 =?us-ascii?Q?UdwJVq/xCFvRlL4SDtGwjIzTWkqRn7WDgsh5DfSS+6rkYaEr5oLSQSA33Mhv?=
 =?us-ascii?Q?eZStxCfNO/o7mB9Op6Z9kF3kSEgYOlFxJsDHuWEU2d3mC09TaXf8DxkVJ/ww?=
 =?us-ascii?Q?+5l03GxPAfC0equpmYoPiEKbARboGj6PDPPF0KjasvzqMMNrcZqmunwnMsWv?=
 =?us-ascii?Q?d/AsD/bWiP639EFF863Y56fgYwyqP0r7QXR/QhkMt0a0oguI4LWfzX6N1RUz?=
 =?us-ascii?Q?Hy3Yvv6fRQl9mWhajdkSC2qy7mRThQCI9zB8TaV+7H3nDQgHAqtIdJhZU3NY?=
 =?us-ascii?Q?tUnG7SaygrzHV6akMqPxt++6Nnztpe8fm8iPcGecwQtXAq7iIuzs7lyjL9D4?=
 =?us-ascii?Q?6zcLkKrFd0zx6l3ludVNbomx2zHuHpMaoWfqbdQZIk6OOOx/BKL02gaqGlCq?=
 =?us-ascii?Q?EPndRfCNgzaDcm8iU+Cc++yFRV5iixBy0dwgb2TId07CnJxV7TkZQB1jE9iN?=
 =?us-ascii?Q?ZhhsHv3FDBFlh6pJO1tHZdZjI3DocrqiSzj/3gZ+yQzN7gQ7debm+FV78lvs?=
 =?us-ascii?Q?VpiajtmL6KLy4U0b8P3hGoaaE/2LewgGxjPHAxvT28PeL/WJNQrLgS1Dn/rC?=
 =?us-ascii?Q?rjd/cF0YkUG7/3YM9n2Nwl73DiDus1s/UsbqkkhPglcxiXv6EDMq2zZ/Wyk+?=
 =?us-ascii?Q?ZL+BuYLAuJiynNb55vPVPgwlM0/fEInHRTvhsw464/NghJ+3S7Go1LEBWBVo?=
 =?us-ascii?Q?DQVK99qMrpi5+9UHPKPWurpPA67AaIHXAamTfKoKWt9zmYasN+OqLwwl9DST?=
 =?us-ascii?Q?YRNDJh37CvtU/9Nt3/JW5tzkaowNcVqUKFD4KTjxjIEUXCklvR8y4UuT0mm4?=
 =?us-ascii?Q?ZB1UC8V3mN8Wt0qG68OlX1aVJG8xmiR/EWujBLGnipTiB5Lu/7g+tAU83d4L?=
 =?us-ascii?Q?mEq2wj3QoTkpBC+EbHAlFXFZpe9aXXgRRqr7JOiEraV8Sx9dKd6rE6Zy5rob?=
 =?us-ascii?Q?yt7xfXqjiiweMdPrMH2QemJA9xtDrfwH5S/j8d4gZV8siQp7ViYXfb1GdwHr?=
 =?us-ascii?Q?oSug8jIAl3AYbhIvhA7qCTuL0v3DZrsJlUmjhZ5cBweeR37di8u7HYVIpvO5?=
 =?us-ascii?Q?lJNrc0n23aOI8t4hGQJOf/EdKdMTICr+xG91mkN6?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 72d85ba8-abde-4084-fb3f-08dbc7e8fa36
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Oct 2023 10:26:04.8320
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +5Q4r6bxUtYel+A4QQM98VyhoXhZRTmrKzNlVlqyFYsS+ZbQsYaaLW66RlfMBTn85C/ieVFmveOhxobvZDQ5kQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBAPR04MB7222

When closing the msk->first socket in __mptcp_close_ssk(), the original
behaviour is to reset this socket. But if there's another subflow available
in this case, it's better to set the first available subflow to msk->first,
instead of resetting the msk->first.

Signed-off-by: Geliang Tang <geliang.tang@suse.com>
---
 net/mptcp/protocol.c | 18 +++++++++++++++---
 1 file changed, 15 insertions(+), 3 deletions(-)

diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index 30e0c29ae0a4..fde65d901f47 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -2396,7 +2396,7 @@ static void __mptcp_close_ssk(struct sock *sk, struct sock *ssk,
 		goto out_release;
 	}
 
-	dispose_it = msk->free_first || ssk != msk->first;
+	dispose_it = msk->free_first || ssk != msk->first || msk->pm.subflows;
 	if (dispose_it)
 		list_del(&subflow->node);
 
@@ -2446,8 +2446,20 @@ static void __mptcp_close_ssk(struct sock *sk, struct sock *ssk,
 
 	sock_put(ssk);
 
-	if (ssk == msk->first)
-		WRITE_ONCE(msk->first, NULL);
+	if (ssk == msk->first) {
+		struct mptcp_subflow_context *tmp;
+		struct sock *next = NULL;
+
+		mptcp_for_each_subflow(msk, tmp) {
+			struct sock *s = mptcp_subflow_tcp_sock(tmp);
+
+			if (s != msk->first) {
+				next = s;
+				break;
+			}
+		}
+		WRITE_ONCE(msk->first, next);
+	}
 
 out:
 	__mptcp_sync_sndbuf(sk);
-- 
2.35.3

