Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2064.outbound.protection.outlook.com [40.107.21.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC40220F8
	for <mptcp@lists.linux.dev>; Fri, 14 Oct 2022 13:33:12 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LJndX5Yyj2UkLZ3DV5KZpi84B5lwPSp0id3gK+MP3YTgrQbVVRk9KFLuGn2QRN5yHc7NgONFNbo1oCKhZNOPNExRYTKvSBqLpDonrnZpgYXDREMiIj8rH/JNOsI56nnN0sToOzVoCLg8B4LLbF3EP5ZnJR4+ICmzm3d/k9t66grV0TL5cn4myX1/jXTcNy0/ZbiRBFgKwg42lG3oPrazjgAx3Lvos1pJUVLLjtRVUV+gdc9rzT9CDnEg7WakpEw0KKcZORXXn/DeVpQk+rDWxu57Vfn81YukL35Hb7p3JqKHdgVxvVaYOZg/AFLIsEl8b+Yxm15D5MqMYM31Df+VVw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Y+F09A6rCMFCPzBaYzBQTA2WxoZHKTWh9neBAy3tBHE=;
 b=D9L3DBw0dvA0azCt32Ib4u0pPK85vuLgxKOzHB0gFZaGmphye140qE8sYyf451uiiPSG8YP6/v/q5yrUBIGBL9DDOKBUlrmVvR4hags0wP/myEFyeUtFb6Mvy+CWGzwYA6BM9kiT0iI2kut9v17dBB4BU1sMvsYG0pSvPKPeIyZkiKK+tVCOZxmAyQQAQFglMUdF3iBlEreZpsqo3xtWy8wLwusBLQ5TL+FwfexapqmMfWdRISb/YtRQjNFCM5m5p0uo7pNv630wTkSIhf4Dwc2OTL7HlwDtXhpz1Iql8Axg1YlCnGXy0cyzRQEN8MzwKpS41pjaJpvnKFxLm0FwoA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Y+F09A6rCMFCPzBaYzBQTA2WxoZHKTWh9neBAy3tBHE=;
 b=sRpBGrWcUN1jpsHPjRamlH45j7/YIVXG8iASxU7ftDpgYS7lxcj7yr0+fwjSeEN3EC5dbEJ/3ppYAgcQLxgGHvkSZsze2mn3pajp6oDBQyxyHme12BHZMKIp8aQFMtAIWzeI0oY5UPrFG+UWaVI+ZbJOElihmcuFfSO6zLW++dbL7y3qh7+LKlSQbV7UbabzqDPb9YS7aTsIMpNS4SZ11etAl4fmWVXUDmsFNOnjpLo9bFFQ7l8HGIwIur9wmFTmnm0P9brSduMDjMPKNQi+RFYrxcy4rrqCYVgIsCvfcGCWoVs3OR0vzpE8PdJymDtyD+ImyZgbVuMi7YnXdiHixA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by VI1PR04MB6975.eurprd04.prod.outlook.com (2603:10a6:803:138::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5709.15; Fri, 14 Oct
 2022 13:33:10 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::645c:cc06:a616:fe45]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::645c:cc06:a616:fe45%7]) with mapi id 15.20.5723.029; Fri, 14 Oct 2022
 13:33:10 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next v8 03/15] mptcp: use msk instead of mptcp_sk(sk)
Date: Fri, 14 Oct 2022 21:32:10 +0800
Message-Id: <c9368333a918bc850cdff07dc01f5489ddac379d.1665753926.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <cover.1665753926.git.geliang.tang@suse.com>
References: <cover.1665753926.git.geliang.tang@suse.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TY2PR02CA0048.apcprd02.prod.outlook.com
 (2603:1096:404:a6::36) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HE1PR0402MB3497:EE_|VI1PR04MB6975:EE_
X-MS-Office365-Filtering-Correlation-Id: 61f200f7-e6c7-4995-5ff3-08daade8a2cb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	I+W7olRPKjOS5VHH4f8hljcr/VtUyqTaq48GggUN6nNMlo3wpAhjdGX3NhzDvfkDplbXMIxAOedHnmUC490bpcNnRfNT94WYUN0/hKK466ebXc0eb+hZDwCldkRKGEAdWUCN3AxGLSpCtBiYBT/K+Lu0yBI7LDu5sNJ4hBL3p2+DdQ9fgGEubvCv7S7ylTj4PWtXblOlJDo1E7kPH241prSpLzF5s7ud2TrGBzxUnh0VfxtqazfX86iW46RvsjX7L6oRrh4L/xn87PRX8ydBK40aZTnC1ncCc2XK8AYqyZ5OfePgj/NoME862x6E3TSZcSX8DRg/9kTKKYfMygjRfLHlQAeujKxHQ9unsOrmA9WcLiFLcg/g8i7QAJeA5Aces4K5F7ISaOY1u4G0UpT+eKOk8LE7maubhEDvz+TNgrPiSDbQREep8MNOimkr2Q3UR0zfdV4C8enEUsd02UOYURUsK+abCh4zE2fDpchi5N4LUG5fhYI1qtACmKvcLzqQ0zafQ/FFn/6mm2XDDw+28YEHDwDZgIQHovhCowa6b+uZ44uucLRyoRV1x/WA4EbGe4+0l0QNF0977Wmc/hwbszss+ux7cNcEf7TBKbMyxW4QqbzT4uPxor6FSM2GTjnVMHXagKsJ46/gS3Ptp962btGL+4cmhIqB5o3+qKXDkaW/SkTWNleOGlFFF49v/xyUjzctkuyy1vc0NA+gv2TBuHGk6BjjVbP5hGnyE7/9wPwe4Op2QEJXFzbZizfFmPa8
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(346002)(376002)(366004)(396003)(136003)(39860400002)(451199015)(8676002)(38100700002)(6916009)(316002)(478600001)(36756003)(6486002)(86362001)(83380400001)(44832011)(2906002)(66476007)(66556008)(4326008)(5660300002)(41300700001)(2616005)(6506007)(6512007)(66946007)(26005)(107886003)(8936002)(186003)(13296009);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?j7sLvziZKMRDIcNYSv7j83ZBO/ibmeQgTOxrl6g7oW/Z6WuyyoBfFugUqtk2?=
 =?us-ascii?Q?E9AV8tvjkRZRQ+XQ9D7Wji3OBlQs5AZj0ftTArui/Z4Mcr1vaONs/Oe0Oojb?=
 =?us-ascii?Q?k7/KtdVMu6xC1aonWCR/ukKyavT1M0Hs9VkPTWAoChgGrM3AtFOd4CnDZ8RO?=
 =?us-ascii?Q?hwnQO4aLrQLfsUlauTMK5Ms/rnClFOfIy7SouwVRuo4tmHNQ35CY+502/on1?=
 =?us-ascii?Q?HyW4TBfQFiDEGQVfOeRNAUILp34AFFUv/iSHRU3aXnXhaPIWiv1Oi9F5dcZB?=
 =?us-ascii?Q?YfF9eIU3o61paNE58U0YXWYK+1IBT5xsoY/AIUqQtesqw3spQXaxR04BOVkJ?=
 =?us-ascii?Q?KBE3a5o9m6tgxGTlxEDdIU4u8f/AVJXHExYV3AnNvTEAlBGuGQalQooN6SWN?=
 =?us-ascii?Q?lPFGLNKQKd6eaxOG+RozJFHYGe64fQkluI17U2+vMFA2WajlgJB+FNPy/8JV?=
 =?us-ascii?Q?3kyOcs09naYW000Su04bhiosImy96iNkNb0BSXo/OOOiTZyHcD7MdHvzN9YM?=
 =?us-ascii?Q?Law8YUaeVvJtl4MJ1Hz0JxFweUoU6wMZU8DMgM0JYuoxG/heqX8OTGmP8hwY?=
 =?us-ascii?Q?HUYLwTc7ljlDQlLsXpW9OCDkxCsb37b1ZXktTajLINK/JgH1PZNGrEVPvGlA?=
 =?us-ascii?Q?oCtzzGN/GJpKHiWyXEIQYTcZXEnxDfZKkhchgB6OQY7wibcUS8eWVs5eJB+z?=
 =?us-ascii?Q?lvfDL6/ZRbKpfBIEdPh2M+/Rm+NfZSBTsC21t7g9atpkcN3pYwA7boDfZXvt?=
 =?us-ascii?Q?swMmZi6hqqzib7oZQDBZdFF9j4amGuJ9Eg2priFJFYcNj0CskOpHsxzJn9yM?=
 =?us-ascii?Q?9VFJQKbrjjPlHVYcxBbidoRXGxXZ+3VyhIkzaLKVRD0r9oOMxFIAtUV8DNY0?=
 =?us-ascii?Q?vf7DBtdqEznX5vHq3VSOAk10P+upDi0spN1FnnDMZ9lBsE7+Mq8Se0j+NJYE?=
 =?us-ascii?Q?AHVyEUQRHo9JWEvaTV4xy/gRkDVpx3TknZpECatz1nawG/aoXlmOk0RHpw4r?=
 =?us-ascii?Q?UaYSMuyRqcfENx+/uzW5HMNSHvEoLV7JMhJOF/OgVH5nZ+IM4XuS9U4LCxAR?=
 =?us-ascii?Q?1zIc0cnxMAqOFGMkqtoY0q4gts5vD2RzNh7ySIQd36P8Kg7rMSdUavXxBl6w?=
 =?us-ascii?Q?SvJWinXDywtJvOIlU8IQipIWY8rXu2yMJE+BXbP/aZGrIVnWQdzEU/HONVJO?=
 =?us-ascii?Q?Gh4Z+kngN7Zv13/MvA1neE1j5rTlkXmJtE0T2uBKUofXwDd7BI/bJYJmWQP/?=
 =?us-ascii?Q?MrPC48kS4XL3lIMOtosNbZr86Nl9F7hiCsaUcD4QvnrnYxgZublndfki0gZ3?=
 =?us-ascii?Q?m2sk+dQvb4Owiu2/Pyl66X4okXjpQwUDYyh4y2mA5/apXq7W8ZaprlKbczII?=
 =?us-ascii?Q?4rnvM6iY1BOIu99lF7VHYDP/UCHnyl4K2/5rzYj22THp214b4rdEohIsC65E?=
 =?us-ascii?Q?6Is70v9bXv3/HoFFijEuhvtfleX8Cg6h8i1PfzNbbadzgmmSY4JsU4cEN8lm?=
 =?us-ascii?Q?txpH2U2IGLYmL0LBdN5GlS1zCPKB3ATYafAtU3FT90GFFAr3POgGyfyJWLji?=
 =?us-ascii?Q?L4LHO9KgdFNusZsO7U7vE38sICjAXwwO04S7ycSUSxoOCdYWeEEJs+NLOXf0?=
 =?us-ascii?Q?LQ=3D=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 61f200f7-e6c7-4995-5ff3-08daade8a2cb
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Oct 2022 13:33:10.3632
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jXiQ3+7rO1OB7rXCMbpBxjIToK8wsuDwU6Bgli6yuZBKv4igz9I1fjaFTgxKJh4tvQp3c6Jn9Rd64QcS3AdRmg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB6975

Use msk instead of mptcp_sk(sk) in the functions where the variable
"msk = mptcp_sk(sk)" has been defined.

Signed-off-by: Geliang Tang <geliang.tang@suse.com>
---
 net/mptcp/protocol.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index 8ad13569cb25..989708e85779 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -1625,7 +1625,7 @@ static void __mptcp_subflow_push_pending(struct sock *sk, struct sock *ssk)
 			 * check for a different subflow usage only after
 			 * spooling the first chunk of data
 			 */
-			xmit_ssk = first ? ssk : mptcp_subflow_get_send(mptcp_sk(sk));
+			xmit_ssk = first ? ssk : mptcp_subflow_get_send(msk);
 			if (!xmit_ssk)
 				goto out;
 			if (xmit_ssk != ssk) {
@@ -2256,7 +2256,7 @@ bool __mptcp_retransmit_pending_data(struct sock *sk)
 	struct mptcp_data_frag *cur, *rtx_head;
 	struct mptcp_sock *msk = mptcp_sk(sk);
 
-	if (__mptcp_check_fallback(mptcp_sk(sk)))
+	if (__mptcp_check_fallback(msk))
 		return false;
 
 	if (tcp_rtx_and_write_queues_empty(sk))
@@ -2938,7 +2938,7 @@ bool __mptcp_close(struct sock *sk, long timeout)
 
 	sock_hold(sk);
 	pr_debug("msk=%p state=%d", sk, sk->sk_state);
-	if (mptcp_sk(sk)->token)
+	if (msk->token)
 		mptcp_event(MPTCP_EVENT_CLOSED, msk, NULL, GFP_KERNEL);
 
 	if (sk->sk_state == TCP_CLOSE) {
@@ -2997,8 +2997,8 @@ static int mptcp_disconnect(struct sock *sk, int flags)
 	mptcp_stop_timer(sk);
 	sk_stop_timer(sk, &sk->sk_timer);
 
-	if (mptcp_sk(sk)->token)
-		mptcp_event(MPTCP_EVENT_CLOSED, mptcp_sk(sk), NULL, GFP_KERNEL);
+	if (msk->token)
+		mptcp_event(MPTCP_EVENT_CLOSED, msk, NULL, GFP_KERNEL);
 
 	/* msk->subflow is still intact, the following will not free the first
 	 * subflow
-- 
2.35.3

