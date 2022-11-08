Received: from EUR03-VI1-obe.outbound.protection.outlook.com (mail-vi1eur03on2075.outbound.protection.outlook.com [40.107.103.75])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CCF16ABC
	for <mptcp@lists.linux.dev>; Tue,  8 Nov 2022 09:08:49 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Dq2Z3SsvFddqyOm3oOgLaGoO+OGBCa4VUhPT+vi6raDjWdAi19ZGbmMu281xsCVhMQ9FqDLsdxXJAxQmOQlcj+76YtwkGogeoGdC0HPsweN0P4UIS2lP2Eqtfdr8A2X702ej7Biurcwl9ZRDANAnsw7lBm4GAC9HNsXfQtRiIblQ10GtYkchWNMdT/Zn8VqSbPYDisgvVWUjBrFG9R5cZpC4huFNFhhVLIHUpdL1il2QgTL0W2e2uJnXOZMCCr1uY8Mg5HfzP/JegatB/24EsWrfLZRnMFyR+mfTmrCM1gOGY3M5DdO7XufP45ToIdbe0DGIsyz8l8N5ej3z5DJPww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=T1iPBo9fZTor5zB61UNFiv3m6JOwYDgOm3RcwKqi7Ck=;
 b=l1FDkc20q/t/16AuFZZ0GdKLKjXmGrIaBq+B6tUuA+ITxsmWzNeIlvKjPKQd87z7/lc7esxYa8Ye7NhRaRqSGv/F2xiTK/d4ZmDIMiLAJS7Na8jI5JhCuEafuGTDg0EcPWkOcDNs8Lw1RZ8MUHKSW2KTn+Q0HFP8d31Y77d68o41gT3UMfJ3rtCunL7lfYRP4Rh3t2PhSP+h9GSnqrqZ8mqFN5duSGxVMi54A4IPnLlB2NqQ4gzk79GIKYatGSbn2zkFdibRd5yAkZ7OqtB0J16fsh1hLSbWhW715MMjwVIUGAmOnHsmthhQMYUJiBNdvIgzXPuD15vw8R2leLGaEA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=T1iPBo9fZTor5zB61UNFiv3m6JOwYDgOm3RcwKqi7Ck=;
 b=iGiIJNZ2LvwzTTXfWm7UY4ODBSzqlGMX4ZQTwzcBiz2dfsNwUsxfujLg/6DCHdw42r2fW27de9GZR5XvQoopiT1rLU8clOizg2BmzVNHF5qE7jAs/4YyMtnpV8t3LDnEnmE0YTNvgwKBzjUdzXFTzkKIrDZguHCwE7Bm+cSoqq6/spSzgyZaCPrxgK+z1dj6+O0zbd7XYRRhlo5a/71uIeo6z9FVbA0qaf9gdnCn/TunnEbG2ZAnKEtAG3vhK7MXJYBr/bQGnlJzRim3btawcXT6vbG6o9Fq7Om5YML9dYVWr0KHciwFC6aruEjjAQoRk/8lY3wdz4as60ByMAk/3w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by PA4PR04MB7599.eurprd04.prod.outlook.com (2603:10a6:102:ea::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5791.20; Tue, 8 Nov
 2022 09:08:46 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::a1a0:6e54:f31e:2bad]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::a1a0:6e54:f31e:2bad%5]) with mapi id 15.20.5791.026; Tue, 8 Nov 2022
 09:08:46 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next v18 02/15] mptcp: drop last_snd and MPTCP_RESET_SCHEDULER
Date: Tue,  8 Nov 2022 17:08:24 +0800
Message-Id: <01eed357c459605e487cebb729a72c4674acf4b9.1667897099.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <cover.1667897099.git.geliang.tang@suse.com>
References: <cover.1667897099.git.geliang.tang@suse.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SGAP274CA0001.SGPP274.PROD.OUTLOOK.COM (2603:1096:4:b6::13)
 To HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HE1PR0402MB3497:EE_|PA4PR04MB7599:EE_
X-MS-Office365-Filtering-Correlation-Id: c1cbff8a-a734-4c55-f7b4-08dac168d771
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	vRjDLDNYqmhHLuAK04VkH8Tf8t0F/ZjLDeBqDBIL3p3MRsJvXyi/BJ2A1bhsc/5TAyYIMxhYCVw6FjW02YmXFhEEV9szBcdcRUCCKyokI9LSn2fViujvhQPhkrHuaMVrPrLDLOKTXmY6yRngWZehER3UYBB1KOInQJk5c4xEdvzqAFrtVIjA2LkZ8iU50Up8/p0WuVtJoH5+vj/Gpa3t911kqBdvpNGSnA0DUmSlGZqV2gRQ4P5dgblq/jqOq9R01QJayZvvHAemXaptLvcsF5EYCnG9Z0PjQRyEQGuIiR5URnbiFqqyADVdzi8JAwyS3W7fipORrImObCef7SOYncGJavC+ySxzWqCyYdm6AKQK7Ri2KlzFDfuAaBGrDz+CrlmmUesf+bGKPHLxKKkVIbYs7yycl1LjnJPaOAGa0srCzYR+mu3lu4yt2vF49QkyM18hnZ5xZ9Tj97+y3qLhetTeZSof25Cp1+JXnyuQQUcJztHRE6n/ATyNHC2Gjh3999/Ds0Zjphj3FdgmExOSsKm/ACo74LVavmBHODe9L26Q8jhtFQLjbVId8nn64vqa3u7sipF52uMpKsRyvjp4ifZH9xNjAmGU79n7gNpSpv1JOBg9tKldOYriRk+I4q5eyzIjNp79HRfcD7Z5IYZVjvHBqLLyGk0lGPtjHLNEQAdoxBAcuq6tqTjBksQlLCQp2d+zChb6izjMQlIk6c4nRQW0OwY3E2/7mbqyGHPoMrWyM+nzkH4MhMKyd9NBWdEr
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(346002)(39860400002)(376002)(396003)(136003)(366004)(451199015)(83380400001)(86362001)(44832011)(2906002)(478600001)(6486002)(38100700002)(36756003)(6512007)(26005)(186003)(2616005)(6916009)(6506007)(4326008)(8676002)(316002)(66946007)(66556008)(6666004)(107886003)(66476007)(41300700001)(8936002)(5660300002)(13296009);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?cC7Zx6BX1DCbbbo2T7uEBQnJydt/YH7r/BK+vuL3Tngh7I2U/wEIGBBpL3hS?=
 =?us-ascii?Q?Lo6kKOiB7Arf1pXT+fvuQl75VGZ958qv/lKQS2mhvxC4TLOzToPwHCzR0PS4?=
 =?us-ascii?Q?Lc4Y36BCfrs5GcyfVxSBzai/X0Yu5PJAkyHM0pqPZuyqDPZDq7QuRTsjnrZG?=
 =?us-ascii?Q?siz1tREepQ5sjOW5qd/J9H8lR0E9yH0uxT5r4zrYELpVN4P1X7RhOcFHPUhH?=
 =?us-ascii?Q?W5MuJho2eo6pGQlTHrynbYkPjsBCDCEpp8gLhPg5j/imwemI7VqPLF322MyV?=
 =?us-ascii?Q?1uqaVwHsSJyl1yoDe9eRhC8UHKXu3n+6ONsDsIc8tGCOnyAEtdF36BcyIDX1?=
 =?us-ascii?Q?y8Bgu7tsk4qRzr9Cc7sjK93yUnz9CZUKx6V8UOsZxGREUDISz8K8uI8BqHxx?=
 =?us-ascii?Q?eoC9Y0fT3zOvoSP/jE3BJILZFBQRBf3RRSpY2LZxzq5D+AGUwvB0vfC/Od1U?=
 =?us-ascii?Q?HobReK9cKiV7893Tv1bT+rMWRiEr5q1SGwM1F1pBQe5aSr+94M4Yg1jIj1xy?=
 =?us-ascii?Q?pNw+YRbacBoGa+U01VrNkD6VsSm+blz4VxDwl9wauU7QX3wAX8NqhSFlc+Bc?=
 =?us-ascii?Q?DapuxYxyKP7IUXWnF4Ead5nbMl2mDQJfJvqYIf6WAxVFr1ChH+z4sIghS7UJ?=
 =?us-ascii?Q?XbUqTMlEkyRX2TeVatM8qbB22NDsbKrSXS5HVUeVRrj8GZIen0aWAsUvJAId?=
 =?us-ascii?Q?rAqXLqgNM3yfmU5VTdkT0X9nWlyJAKZ41Lirv0Nys6rbdKhiEJ34xqNE3uNp?=
 =?us-ascii?Q?vSkmOYN4TBbumNYa2S7Veu3j3qL9g+nCmj4yrI5CBKxLO78+KqhwTkG0Wz+H?=
 =?us-ascii?Q?EORWVhlX2FhBg7IcSDSx3M/ZB7JBxAZAlb5kGeYulnyaYCCyyXcM56dZhalO?=
 =?us-ascii?Q?c0Ckz53DdjGo5RwG2Dly8Ef/jnbIlRwM8FzxfrOtKQ/ycGEuFEYl2d5kIwK2?=
 =?us-ascii?Q?PGOTPzkkCO5eYkWfVLBVexQBlb7TkBLkV0UEJsrCy0yPuRQJJQR2hsShBTOG?=
 =?us-ascii?Q?/H+oga3XNS7wFm1KS9BZnXPaXlX5nnDpRkv2dypnQpJ2H5AZh6Avh4EwrWBh?=
 =?us-ascii?Q?HZyF3UiNOczVio1tsQiwYdd6QRWR3Sj2zdsFdc4MnPLgaJrVa6JMtWC0kE3Z?=
 =?us-ascii?Q?bHjYaftULBSO/5ataz+lcD0MJc3/jYS/My2lavhA2i96BFSNdVR0Z8pfd4jN?=
 =?us-ascii?Q?eA25Py1GHdsV/GSV6bMoCGOyx4ctYBtS2TuUqrWZLKPUuhlhC1YpeDSSYCTQ?=
 =?us-ascii?Q?UueqRg8VeEfhh5C80LLyysMi0wGCebfe2fH8FeWWJ6nJ3OtY0WKFJiyUCHAr?=
 =?us-ascii?Q?q66381ZS2mR5ra14G3zje4ZEBXZlS+BBjZ5tFF+C5v/xcE1zvgakU4un6kSB?=
 =?us-ascii?Q?x49E4bFv3wbqrD5F41bcIuSE5iWjEzU/N7J6ed7HNNIY3FX67eafCMofLdWk?=
 =?us-ascii?Q?ELyJ+O2iMFMiehxyRQHlPgUONvSTYcr0pxGUh7vwqTh0drqvHnXR6lfIicEY?=
 =?us-ascii?Q?eFVtoYd/nubVu9q3X4s4fhubJyVe/Hbm/SGOzAP3rthX62uwtYLqFS+Jobdu?=
 =?us-ascii?Q?jA1QG8DnkTWsB5NJtkqrfzspKrTHS4wC2jwOFnXM?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c1cbff8a-a734-4c55-f7b4-08dac168d771
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Nov 2022 09:08:46.4488
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2aXNL1xvxap+/v5TZka/rTsrI2elENOb2s986ecsIU/jpXXgI1WnZZQHVG83QxVimlgiwnpwktaZjVK/NnkraA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR04MB7599

Since the burst check conditions have moved out of the function
mptcp_subflow_get_send(), it makes some msk->last_snd useless.
This patch drops them as well as the macro MPTCP_RESET_SCHEDULER.

Signed-off-by: Geliang Tang <geliang.tang@suse.com>
---
 net/mptcp/pm.c         | 9 +--------
 net/mptcp/pm_netlink.c | 3 ---
 net/mptcp/protocol.c   | 7 +------
 net/mptcp/protocol.h   | 1 -
 4 files changed, 2 insertions(+), 18 deletions(-)

diff --git a/net/mptcp/pm.c b/net/mptcp/pm.c
index 45e2a48397b9..cdeb7280ac76 100644
--- a/net/mptcp/pm.c
+++ b/net/mptcp/pm.c
@@ -282,15 +282,8 @@ void mptcp_pm_mp_prio_received(struct sock *ssk, u8 bkup)
 
 	pr_debug("subflow->backup=%d, bkup=%d\n", subflow->backup, bkup);
 	msk = mptcp_sk(sk);
-	if (subflow->backup != bkup) {
+	if (subflow->backup != bkup)
 		subflow->backup = bkup;
-		mptcp_data_lock(sk);
-		if (!sock_owned_by_user(sk))
-			msk->last_snd = NULL;
-		else
-			__set_bit(MPTCP_RESET_SCHEDULER,  &msk->cb_flags);
-		mptcp_data_unlock(sk);
-	}
 
 	mptcp_event(MPTCP_EVENT_SUB_PRIORITY, msk, ssk, GFP_ATOMIC);
 }
diff --git a/net/mptcp/pm_netlink.c b/net/mptcp/pm_netlink.c
index 02469d603261..b0b83e03a4fd 100644
--- a/net/mptcp/pm_netlink.c
+++ b/net/mptcp/pm_netlink.c
@@ -475,9 +475,6 @@ static void __mptcp_pm_send_ack(struct mptcp_sock *msk, struct mptcp_subflow_con
 
 	slow = lock_sock_fast(ssk);
 	if (prio) {
-		if (subflow->backup != backup)
-			msk->last_snd = NULL;
-
 		subflow->send_mp_prio = 1;
 		subflow->backup = backup;
 		subflow->request_bkup = backup;
diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index 1fb3b46fa427..d7aaa49c64f4 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -1478,16 +1478,13 @@ static struct sock *mptcp_subflow_get_send(struct mptcp_sock *msk)
 
 	burst = min_t(int, MPTCP_SEND_BURST_SIZE, mptcp_wnd_end(msk) - msk->snd_nxt);
 	wmem = READ_ONCE(ssk->sk_wmem_queued);
-	if (!burst) {
-		msk->last_snd = NULL;
+	if (!burst)
 		return ssk;
-	}
 
 	subflow = mptcp_subflow_ctx(ssk);
 	subflow->avg_pacing_rate = div_u64((u64)subflow->avg_pacing_rate * wmem +
 					   READ_ONCE(ssk->sk_pacing_rate) * burst,
 					   burst + wmem);
-	msk->last_snd = ssk;
 	msk->snd_burst = burst;
 	return ssk;
 }
@@ -3294,8 +3291,6 @@ static void mptcp_release_cb(struct sock *sk)
 			__mptcp_set_connected(sk);
 		if (__test_and_clear_bit(MPTCP_ERROR_REPORT, &msk->cb_flags))
 			__mptcp_error_report(sk);
-		if (__test_and_clear_bit(MPTCP_RESET_SCHEDULER, &msk->cb_flags))
-			msk->last_snd = NULL;
 	}
 
 	__mptcp_update_rmem(sk);
diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
index 8df6d95a3247..e93d64217896 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -124,7 +124,6 @@
 #define MPTCP_RETRANSMIT	4
 #define MPTCP_FLUSH_JOIN_LIST	5
 #define MPTCP_CONNECTED		6
-#define MPTCP_RESET_SCHEDULER	7
 
 static inline bool before64(__u64 seq1, __u64 seq2)
 {
-- 
2.35.3

