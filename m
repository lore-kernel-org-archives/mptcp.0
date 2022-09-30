Received: from EUR04-HE1-obe.outbound.protection.outlook.com (mail-eopbgr70048.outbound.protection.outlook.com [40.107.7.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 112034A1C
	for <mptcp@lists.linux.dev>; Fri, 30 Sep 2022 14:17:04 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iS38S57KETse+Xg77mDRDsc/RjYxxQ+BU6uohLEaZXJa7BsUQGcj2SHj+8eAzb4x9rV1a1hP2adz13vCBxBGA3CgziZgqSyEilY/MI5X7uEvsyw13jAIpwRrA02HkLuSCGYr6hvfnn4Pex4YH3gi2n9DwTSMpNFVi3cI/6oVk7lXzTT4NjmOoNKT2bZwZ/408wl0LoZacMl/grgfSJzynEuOffCUDmq7Bbeyt7bBNSJZqnIc1GlFObg/tD9itXPYppUfS0ooZlQrBHQlESJQZcniE/tfZKC2qg4LqXzlSi8CAx+qrs4RwIxz+agzDk58DdR8ywPhhJ9EH+IUbDVqrA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LLEIcno9nl4DzTj89lNglw7kQ0NjU6tCvV+tBmvWwkU=;
 b=iAoVk3tu/fgjAVOw5ThZmSPUfjmVyp56V9+ltdkZG3FmW34UDWO7bahgMjmSKIP/6+Qh/Ji+ynq7ZRga8PQ2lJu2F9lEOIUB9ppJ4tGd3mZDWYbRV/Ig+3e3f6E0oogdDmQV6m/k/JmpYMKX9OLG/7ilDM7MA1r7tJQ0l+/z+tXE+DPk7E1Ken5bW3fYacDu9yj25cSironkRFjHUXq4y+VKN1QEa4LxdCCsVbsRZg0sjF20f5laRF/7PxMXsebg6HmQfFAudLdIpKSk32a1XaZ2IcDco/SXPnjQPIV9ze0ZeF6xVTCEiyeyQJi0i2ocLCpGBuaTtQDfatCVGMqTEw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LLEIcno9nl4DzTj89lNglw7kQ0NjU6tCvV+tBmvWwkU=;
 b=Ct/cR2fl+4eoq27p7cuI2Dq2xNVw4JBBjbtXFxYcXI9VF3yMHTNuBaHRH9E/PNvZ4gbSXovDxMjo7kjxM3F+e+zirvXpy++N1bvY9/WXTHrU8mCnisH0sGrugl8gCk5ukXn9J4PsOCpzixwc/394cCTQVJpiwPXwBpzpcFUoT0/oqxWA71KDy0MRWLRvePtu2U8EIb/6Bpg4VlH8ZFc9ZuR3aZKDY8YR8xcjZO99XO/7U1iWIfUHT0dDqhANpdKI4q/6x7csJqrNWchxpKHSUC5che27bwnqeoewjmZKcIDAG8AZAG7mWAMj/usp4X8EPfJ4deyyTTK9YQNAQXL+og==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by DBBPR04MB7882.eurprd04.prod.outlook.com (2603:10a6:10:1e7::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5676.20; Fri, 30 Sep
 2022 14:17:02 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::e936:9fd1:22e7:97d1]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::e936:9fd1:22e7:97d1%5]) with mapi id 15.20.5676.020; Fri, 30 Sep 2022
 14:17:02 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next v3 1/5] mptcp: use msk instead of mptcp_sk(sk)
Date: Fri, 30 Sep 2022 22:17:31 +0800
Message-Id: <f53860eacb38dc955d6860e1c107f7b0e96f0ce4.1664547250.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <cover.1664547250.git.geliang.tang@suse.com>
References: <cover.1664547250.git.geliang.tang@suse.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR04CA0012.apcprd04.prod.outlook.com
 (2603:1096:4:197::14) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HE1PR0402MB3497:EE_|DBBPR04MB7882:EE_
X-MS-Office365-Filtering-Correlation-Id: 118216a5-55cb-4728-1663-08daa2ee71bc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	pCrXs9Il9OPbwz0b/RZmiAXOqYPbzg4fAptuRp9d1Z45twIG4B1o3cFYuLplz7oREDyE2VuKtaxACTG8kq73FzFfhf8BJrJ9w6SbbTvj6vQkjzQfPRMyfk21oURh1eFGjfbsKpshEjv017LSIh/L4GBUNPvOJsDV61gDn/5WToHRGcogqbU88eR6J5mhm4Ye46AzuP6ulSPf7anRoMvq9i1CAQA2VQZccVp4iGOUF7kBGuBmzIj3vF+Sg7FBWe+x0vlTHs0579hroqdjVQt/T6IMH0hk44z67xWobw3OK4sM1aeTRBq4Vi49gJYNTLrSxFXUKrfZe8Wihc8ZCrNh3lgsQ/3PvMjLoP1JvUkk+BrINyP9WsmiDkMgKqU+4EC/MJpDQtpX5rAyp9GbzNMvt17gUDQ0bxO0kc6lI3N+erzX9aFQO2kkPPjJZDgiDTtWEWBnRy03vui+4oTZQag8pKEy20suMUZr3yyClKmowR1IAReJSPdtG+N0NUxW9cdJHtgVxxBDBZtF7QAshJFTB9gXHJx2IZHS5/NRJsYzluH0OW1CJjml/KBqNS/D5sAu+VWJg1elxY53KK62Qbq2yA1HPx5CZPBNi34QaxTTH2HtaSuOoJI5Co/5mXrHC6aTZaB4GU3pexTR51yhp4MW1KEdgiA4S0tNhWTtRHlp7/Bi5X5zKBegk1j8UzkaCkW1v9Gsf+uFYd2niediV6a+bjd9dZQzAQF7zGHmnRl8R2F+QUbk5Js2xulbckTbgKqn
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(376002)(136003)(366004)(346002)(39860400002)(396003)(451199015)(478600001)(6486002)(66556008)(4326008)(186003)(2616005)(316002)(66946007)(8676002)(5660300002)(2906002)(26005)(6916009)(6506007)(6512007)(6666004)(107886003)(36756003)(8936002)(83380400001)(44832011)(41300700001)(66476007)(86362001)(38100700002)(13296009);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?AR78x6hhjp3mWoi4iCYpDWP3P6aIWcxkPvcymXcTmhRbnxBjnei/P1659M4L?=
 =?us-ascii?Q?D4p5wTnRwkBJOckogytOFg5OyDZJunSYe8/3l9VJXcQHhUOHRoeORrMoAYG3?=
 =?us-ascii?Q?GFeZfiR296wKNXJtq5fxLFYPWczjBo5tbGA0buvHLogPIOg1wW9JT+5cgPGH?=
 =?us-ascii?Q?O0OAFFsV5q7LTPc6S/KjZRzr3kcNCOWy/I4DgREIxEhpWeKYDNZffahWdNCH?=
 =?us-ascii?Q?H4zi8S0kC7vDy/4EXhDYiA4tQOyhzuTJUX6vqRZRpH/kfWx4xkfbOKiLpCUz?=
 =?us-ascii?Q?Q0FlY2kljVvSxB+TIdBUk6lNs9hmpkYM4OJh0SCB1CO89FE3Tb5i/CJVACQ6?=
 =?us-ascii?Q?qb/mkA7ZGZXvhHpOjy7QWx5VwrQf3udGuvEMQh3hafPxv6NuX64LlNt08AAz?=
 =?us-ascii?Q?+XYPTNlbbHZE9a9BH3vSiXFfvJcgoP+ENxigygAfs06wm8ygQb5EXJHg9R5o?=
 =?us-ascii?Q?cYgOP6AWpXzr/dSNRSKFq5K028JQzK5XHAk2cd4LlVyrVPoPeIciodWt6KBj?=
 =?us-ascii?Q?aXHnPkFV5hN3xFmgU7xfwJW7ZASTORnGoWCH/g53ypqIbOVfdV7JExITioMb?=
 =?us-ascii?Q?OBMSYF1wnp7kue/7/JUzIIUu7bvQ+hu7fYze6rCtl/8hKWiYSl47/pEq8sU4?=
 =?us-ascii?Q?Kz4sRBmLyxy1sUmv8FLMmD5JYiEJK6KqmYCLXfuYFnv/ql2QkjpnhFyufNAV?=
 =?us-ascii?Q?2MOp1hya1l0Il1MCZ0a4YqKaiRmZLHtw2p5/8pjsq9AFoCvKk1cd3emTfltO?=
 =?us-ascii?Q?g88s8Gb3gXftJbigNrl2dNZzHUDIBR/0yR+Gj9mA12PycN1rzVkJg2ElQFu8?=
 =?us-ascii?Q?799xqOIfxe/jp0ysY6OaMnM96CjTRe0tHXGr/fQaXlaCVSS3FGvPGvPxS6bK?=
 =?us-ascii?Q?aqs4E22uBBfD+iYGx8xQp+K/sKSh7VWC2TenecHsYDE2fC6ul/bmOwilIMAT?=
 =?us-ascii?Q?TmO2gULuxSBjusCmokmTwAFChUtGb+oY9k7RbBQakmU/xDt0gcawBr3WKSjw?=
 =?us-ascii?Q?LFwEIlLL3C94sKLdejjV3qSN/SByHmO+aHDL+2P+MoSjoJ9HbaIhCTewQ4Aa?=
 =?us-ascii?Q?Hvx+59nP0+hdpG0PHSzsL4I4cY8WssR4qPc3zA/YeqlDCBtJPMJjOPgPMtF7?=
 =?us-ascii?Q?0G8KXbmedPYmNthkTO3if2ywZkrnBA9+xw90h3VsytvoCwuejZNopL+H7K+c?=
 =?us-ascii?Q?r4EUciCelwATxeNvEIbCtkZhqGnFIALzqsIAijFiv0E/w06oIlzJA3fu4/ty?=
 =?us-ascii?Q?O9jH0wCzUleIOVBAzrHowRkmgTOLoofsriXsWnLnhywIIMziYGxlMKwU4GwG?=
 =?us-ascii?Q?hxnZlojfcsz8UhEeMwSvCH6Nny2+QWxNokgr2mp8vTg3E07dINMLmETi59ks?=
 =?us-ascii?Q?ryD36OinNI/A3AZERBLFLbU9Vc//K0GOwad0ZgaR8T8cCJqAsZnMhrnmakUd?=
 =?us-ascii?Q?aQGfLH7rXHfnSNw64msxU358+lG11CyVxI/o7Z4u85Bz6xNNmecUeX7vv3Tn?=
 =?us-ascii?Q?E4GK2Vo4KIiiUaGzeoNCHwDFPAJtdj7M5R3BgpatgUO8TJ/Z7PcYdLv+YLXk?=
 =?us-ascii?Q?w+wac67C2RxZtkkr3f3E6dGQNivBxqVbCOcGBeR5?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 118216a5-55cb-4728-1663-08daa2ee71bc
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Sep 2022 14:17:02.3226
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: TSa22rByIFcLDMwo9rYeYZzBW/pgfSxqAIPpp9tAA3rT9nww0U5BZjfBYCd+lpvf7GC/H0dTSoX3Kw/FHPH8tA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBBPR04MB7882

Use msk instead of mptcp_sk(sk) in the functions where
"msk = mptcp_sk(sk)" has been defined.

Signed-off-by: Geliang Tang <geliang.tang@suse.com>
---
 net/mptcp/protocol.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index 7ca21915b3d1..3641fb73bc1f 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -1616,7 +1616,7 @@ static void __mptcp_subflow_push_pending(struct sock *sk, struct sock *ssk)
 			 * check for a different subflow usage only after
 			 * spooling the first chunk of data
 			 */
-			xmit_ssk = first ? ssk : mptcp_sched_get_send(mptcp_sk(sk));
+			xmit_ssk = first ? ssk : mptcp_sched_get_send(msk);
 			if (!xmit_ssk)
 				goto out;
 			if (xmit_ssk != ssk) {
@@ -2239,7 +2239,7 @@ bool __mptcp_retransmit_pending_data(struct sock *sk)
 	struct mptcp_data_frag *cur, *rtx_head;
 	struct mptcp_sock *msk = mptcp_sk(sk);
 
-	if (__mptcp_check_fallback(mptcp_sk(sk)))
+	if (__mptcp_check_fallback(msk))
 		return false;
 
 	if (tcp_rtx_and_write_queues_empty(sk))
@@ -2921,7 +2921,7 @@ bool __mptcp_close(struct sock *sk, long timeout)
 
 	sock_hold(sk);
 	pr_debug("msk=%p state=%d", sk, sk->sk_state);
-	if (mptcp_sk(sk)->token)
+	if (msk->token)
 		mptcp_event(MPTCP_EVENT_CLOSED, msk, NULL, GFP_KERNEL);
 
 	if (sk->sk_state == TCP_CLOSE) {
@@ -2980,8 +2980,8 @@ static int mptcp_disconnect(struct sock *sk, int flags)
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

