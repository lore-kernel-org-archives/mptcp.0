Received: from EUR04-VI1-obe.outbound.protection.outlook.com (mail-eopbgr80082.outbound.protection.outlook.com [40.107.8.82])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E7F07B
	for <mptcp@lists.linux.dev>; Wed, 26 Oct 2022 08:04:59 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Zzt4YjhsiuaZDZssRVNFGWFChIusWbXNkwGV2p310a//UVC8Ss5B/bh5FrpxI8UzdsQtnkdvOdxVRV3K00kGidL1isgwHAiROTbCTevXIBAeVINMxpqE4XlrEfNvVuKJbyQ481qJAv63uzsgcJy8s9p988zDjnqiSi9ZV0FaDKXNfv3A03ibQwsy17fmeLfX07cTPGIA/QdZ8Sig9fW6h0cdWCURNJ8P8/mGVkFoai+xzxJt747oB+SVfyVlMKYgDCUzkE8AQikV7bNfMGTilq6oC2HfNV/lIccy8mmr5ZbC35kEH5GpMnoumuH3VnjoAdvpE06BOLkSX5mLCDkozA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=13wkzLVd4YPBc0ZnIx6PxECd5e9ROaEL97reThEGW30=;
 b=O10ycZ0u6xdtIuQogUd79bMcZASXATgF2BnQpOrVPN2n6J2N1v8WAchrVXw9gTIYmQF4YzlQNglpvRRmLMrF3DTVPrLGbIMlnStTPO8V6uEyaILwFMnZejqWNj4ctao/KqFaVw8zuR7oQBKbLQJnX7cq5RprCmxsn0CToggxROModMQDcuGT/UOAgfU8UViF6gZrW3zHuYhM20AO04cwd1prhw57DJhHXzcxXY5pLzvmKAfr0ZqUdW0vat+2txfOODvfyJy1OfrbIUsGYHLiJyRf0PTmJ3EPBL8vtRDeMwh+XtuyfS5L8N/ZLWOlPDQY1mXNzSNjlZhJJ8O4vaLYzQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=13wkzLVd4YPBc0ZnIx6PxECd5e9ROaEL97reThEGW30=;
 b=NLiJfGwlMkBrNOX1KORSR/GQfv7mwJyLO1+N/gVNn4ljnNUBbl75ICWBczZ7yej0241zFEDMGpI8iACIHWu4WaEZAZ2zNt3BbKzHrs7Q6ME/quls3IFVit8O6w9fDVCcjwTAyY4sOMc3GpFKIIDqX9SrSlezMoKNQ0vpRgT0NK1Fb953802V+Bve8Gjxowj9D7Q2lwSsFCosAuNDYQUnmAqfIhrl9Yb975xtTJerUqk7K/2QQuXv9xuIR3/dBh3DTNjH0b26edggHRBuK++XrqsbLLui94GrUc+hXKTre6VBcyNiqo7Lg1GLW2MZ9T+fQxEYb+qVw1c1HkwezFA+fw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by PAXPR04MB9219.eurprd04.prod.outlook.com (2603:10a6:102:222::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5746.21; Wed, 26 Oct
 2022 08:04:56 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::84de:d6d2:6710:556a]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::84de:d6d2:6710:556a%5]) with mapi id 15.20.5746.028; Wed, 26 Oct 2022
 08:04:56 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next v16 02/15] mptcp: drop last_snd and MPTCP_RESET_SCHEDULER
Date: Wed, 26 Oct 2022 16:04:11 +0800
Message-Id: <936bfa2ef820f71b2fbb1da420758f79ccd51cfe.1666771065.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <cover.1666771065.git.geliang.tang@suse.com>
References: <cover.1666771065.git.geliang.tang@suse.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TYCPR01CA0091.jpnprd01.prod.outlook.com
 (2603:1096:405:3::31) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HE1PR0402MB3497:EE_|PAXPR04MB9219:EE_
X-MS-Office365-Filtering-Correlation-Id: 255636d7-1149-4de1-1709-08dab728c4df
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	/GOuLfc/QATVkX/dJ/IS+A80rJ3YKAJ940JZ/ayW8NG5vaAUgOe/pqtLh1T+IuXH0nwjCDYG+kSfRlBPvezXGX0kEDYmLbYgFm9VTLXMXKwAW+1gKVRZbQPAdqiexL3C5jrdxbdMvKLWmM51hDQ8NvjZ3xcLk51DRdJ3cVjm6XDcUUVXAk/JgVb2Jy56JQHxuRqnUhtkr7LpIjqei78QBOlXezkjUAOAmL3HGYIeYpSBMI14EVYwT/pPAUMBTrjXC9OszAfb+hT1oTKZH4A4sPUFKOtH0hRsBuWFdc4bn/RJpmnGJrQowHJOfgRT1n0ix7EXXOOiX778asekaX6HmhUxTNqXo3BbLZZoWFewXfGYPf3wWljymYw8/C64RzB7XKycdXxxRKrgJp60Cn/afbAhRF7LGhOkRjijZEcDQ+lVYjXkzLZavdQQFBFI3/6VTxc6mojmhJvuc1BHsLF+J1SMYSQVw6lAo57LprVZu6wdWhrBmv7EZCdaFR5hzZ2xM/1X4MPNcYUatqWsGd5FuQPX0tMGnO5YnfGyorF6QlfkcWOUOysQscsDbFy6FUyU3Nm0ObmewazFWmdptnPOJtAITgPyW97t/FlSWaSqFiquyF8uzWV6qfCNMoY6OWMZC7mUVlwHPOJRo2BWJ3r0qJxkfJrQcs/6C3bAzwJkEkCN3QBBoQWF3VKrKXs38jByg/qS5p5HqIAuPaLX6O/9zUT3PBbqohWeXOoSOzxmDW5U6C6uuyC++HkFEdzzd8At
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(39860400002)(396003)(376002)(136003)(366004)(346002)(451199015)(36756003)(6512007)(86362001)(44832011)(2906002)(2616005)(5660300002)(186003)(83380400001)(4326008)(6666004)(316002)(107886003)(6506007)(26005)(66946007)(66476007)(6486002)(38100700002)(66556008)(478600001)(6916009)(8676002)(8936002)(41300700001)(13296009);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?GboVPWmwldkzTRDp5P2HiZj6wg1NPsfpcEJGh38Cl5tM7DaeE2ISW75CMZnE?=
 =?us-ascii?Q?EUDTzGpQEYreI8BJz9nINUkOGNAW5wdATKUaQGsTGN/PCDXUekOnDSt1WvQR?=
 =?us-ascii?Q?ZGn6otC3xL6ilJvz3sNf8/32I9mpF7lE5OZ7VUSsOPZHCbpZpkNAwK+Q3V+g?=
 =?us-ascii?Q?/8u/3U1Ale2XcwEUeHU2Yj45TVUxitDeLDvs1+18hB+xfHUaIwqyCm2uiIrK?=
 =?us-ascii?Q?n6kpXfBFX/UVX6UYTCWC8nZkAGqP1l4vUqf+2dv7LbyPnXx2CPVrdfs5FWb6?=
 =?us-ascii?Q?hdhbRgcBkyoKVPShEioBZyw1O//THiO+JwcZAGKQTwx8ZW+Sggg6xPngEtxL?=
 =?us-ascii?Q?woTrgyyLH7mHtw9JFoVz4N0nkziYcYf/elFh1MnHomPrjo+GKeCsZthm4PkS?=
 =?us-ascii?Q?MhZ9Sau+4uiUlAGL0mm5hUg2ly6wjCmiUN2zmIJGU5+u/tYsYGJZ+uNan7o2?=
 =?us-ascii?Q?UElKEx0StzimmO/vpfcwiFrEXeJKOj32R1DggTXM1hO2A4Z0M0d10c8kFHch?=
 =?us-ascii?Q?nJvvZl8BJtTnS4Y3Oqosty0JeVxvTxgCmuW3d+uLpvl21v1xmzILTiY5SUGV?=
 =?us-ascii?Q?+WfFREWzg9A6dPOYCFaIp/tHtOWjFMf4+R2ptMZN/p5Vonq+w5zE4pipoo57?=
 =?us-ascii?Q?eoNh/Gp+pu7tdUGFY+rA7xYbvHDgVL8ohLXPPAQGHrD87BDKiHyZEPIFE1dC?=
 =?us-ascii?Q?vDmQkSs9pK5eMDqR4HduUMyxUgPeuU7Q36+nb+0RfE6VwBSVwOPP3S57O7pe?=
 =?us-ascii?Q?CzSu5J8jE6BE4g4XeXIwL+pzkGR+KukFIZ4EPFVs25ltQwKoaZUCzwDsW/lm?=
 =?us-ascii?Q?TDxFdeTJVC0c72pz4ZNcIkZMjKz9pIgO3u5nMwUAqktVySkeUeefmEPlU2c1?=
 =?us-ascii?Q?Uy6zGcJOnteidjcj6RQ5oU1A6Nay/OL3YWeKO+p3KLLmNmhobppDO21oS9AO?=
 =?us-ascii?Q?xJI79w+5LBQmPyaVPRxFkrKMHDlZ/fmVo4ZpxftWWGMugSGAsw7Z2TfI4jz6?=
 =?us-ascii?Q?TCZukehMCTmE+d8HsVGaBjY+6nhuCGY/bw9UU5FNHRkSVWlTNoCss2TQ6Kvu?=
 =?us-ascii?Q?b5bJAO/os7J9DviIGRuZaYs5r7DR4e0jVDcNRD0pY4ldu4HM07TXnMWle7iN?=
 =?us-ascii?Q?ws+NUAuPOiIuczpZIuUSnYk/Wd70LNalqfJqYvIl0+pzweTSbHIkPpvA0T3g?=
 =?us-ascii?Q?RJaBHus0W407C9UOiheqlZmVYfRFIo/92WzlY4MnH1GBiuhQkCjMT6cBAJPN?=
 =?us-ascii?Q?Ps0YWxp3zVsV4ZpxasfkW7E9+JChWHTs/CFMwmD7JEPMWuM9WhiGHpuFqZtC?=
 =?us-ascii?Q?YsPZyrBaWVAwVF5Ko3YmLRQ6ukw/2RjJEgF/B7IcM9zz+JO5cYIMDJ5lEduR?=
 =?us-ascii?Q?HumqnxqbXvo8Tf4wvFJQYjtcR6huYcQDin7R9AsqIj0w9I4UJi3C4WuTcPLB?=
 =?us-ascii?Q?CQhA5/sjrmIVqbnmsJ5AqubblonhlA59T3zxrpz4NQWWrhzZhKts/N3jYfpv?=
 =?us-ascii?Q?++DBrsXFl5lwwHilOCjcKZo7nibdra1YPoPt+/trH2dFgeCju1lR3GLZ5p7m?=
 =?us-ascii?Q?91A1k4bEuwLADcxkykXaPcCTC0MGYUgb/WOiSKH+?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 255636d7-1149-4de1-1709-08dab728c4df
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Oct 2022 08:04:55.9625
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: BOfJdmHCIgz8UvnX0DILiREVs/rlw63B5osM1bGguBwfnAXYOQR4fUqOYsAQD2wA/inEnCdKdmJGEGFno3KCLw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB9219

Drop the useless msk->last_snd and macro MPTCP_RESET_SCHEDULER.

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
index 85cdd957bb11..ab64ba39e91a 100644
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
index 71a6f08cc87b..1f64abb94cc8 100644
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
@@ -3288,8 +3285,6 @@ static void mptcp_release_cb(struct sock *sk)
 			__mptcp_set_connected(sk);
 		if (__test_and_clear_bit(MPTCP_ERROR_REPORT, &msk->cb_flags))
 			__mptcp_error_report(sk);
-		if (__test_and_clear_bit(MPTCP_RESET_SCHEDULER, &msk->cb_flags))
-			msk->last_snd = NULL;
 	}
 
 	__mptcp_update_rmem(sk);
diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
index b8a56ec36d33..285abbad833f 100644
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

