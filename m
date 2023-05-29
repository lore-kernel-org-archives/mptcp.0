Received: from EUR01-VE1-obe.outbound.protection.outlook.com (mail-ve1eur01on2079.outbound.protection.outlook.com [40.107.14.79])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 422357C
	for <mptcp@lists.linux.dev>; Mon, 29 May 2023 09:18:06 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jh9Z58M0Pjmx7Gft+g/SkTRqkbcnhyltspiIGqRMqnonvEbOhclUh6YShIyhf7GFg0gW0OWEtfFhRDFfTLHWeBNd0BKH8qQpP8SuFJtCqGw7ZXske6xOIk2EUJm0cJbeF7lWzA0FPZpV75lVf6eC/WYqAjDBjEJwU6DQlKYG1hu1g51fqzg+MD+DaDfW54sqx3eCtlZAsXWjQl7HpfYz8GqRIJUEyHnE3u4WwbANjNuLMonekhnwMgjAMSJJxK2dLh2oqsl+bMnCmjTpDjsKNEeT0R/QAjGQ45tStGBQ7ojUhEs2zhgBP3LcU9PaosZ17eszrpmPhDl4t4O1qq8dkQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fyNeIeyuX8355W4vyFlbKOm8E583LXoqlH6oAzJzuNs=;
 b=OuNBcEzrff/OBeQBrA2OsER42RpG08zG5Y62qopC5ZGow27JZ48P33Npx8+h/ri/pzwSXDC4e3BAwbiHEWzoAUQlV3VFsMvROLt+VZzNh35R/B+t2NLFE79r1G240Ji/FEGs9+292+54NgY3hkrhimxWRGDJdOq+XqImby9XXsFcFGAj9P6H1YJeG0LT/iJykaQkqk4cF72x6vp2ghhQCefujiCneNw56fmDkFc/VNXjuMGSSqN+lKyyAYcGCINo5l87Zyyg1VLDRlGQjqSK6tjEkWVQIxaLR1mxL3+3o04TKiT28HGYPnnmI6ijTqXTtNa93AN7IwNXEHt+DQwjWQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fyNeIeyuX8355W4vyFlbKOm8E583LXoqlH6oAzJzuNs=;
 b=vX60mW2hxFtwk2lys9uoXod5V4q6MqT8SnEcQYQNrB+E88exLkOk03yvxltgXuEUdx4/K3cuaatqCFxdWB47kpu8zDRh8XHjuZGA+9gVwP/BMjleQlHQwunC7n3deOZHBoGLxQdAyxVr+MuWtxD8PyiBcw/890erb7pSWWCNZx0dHWYGueCDuwLqK5kmnFjFiIP0NkGR6Cqnruo9Zy3VGFAVWB/1QAEqCC5THNRN1urKtBIkranVJDcK9vcddGH7PKNMeklcXE+Bmmx/PiTgi1tuCgQKz1LHJRI4aGpYcKBlYoNTGrhHz4NIfDLJ2eC4g0XJ4F80FxWKvO2vUBasqw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by PR3PR04MB7321.eurprd04.prod.outlook.com (2603:10a6:102:82::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6433.22; Mon, 29 May
 2023 09:18:03 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::423a:a30f:5342:9d35]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::423a:a30f:5342:9d35%6]) with mapi id 15.20.6433.015; Mon, 29 May 2023
 09:18:03 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next v2 04/12] mptcp: add last_snd in sched_data
Date: Mon, 29 May 2023 17:17:18 +0800
Message-Id: <6171af792f902d1e413507ec1b0507f304b1e034.1685351620.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <cover.1685351620.git.geliang.tang@suse.com>
References: <cover.1685351620.git.geliang.tang@suse.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR03CA0097.apcprd03.prod.outlook.com
 (2603:1096:4:7c::25) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HE1PR0402MB3497:EE_|PR3PR04MB7321:EE_
X-MS-Office365-Filtering-Correlation-Id: 512466fc-5b86-48d5-2d63-08db60259b07
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	HXPU/SQe8ZAVn8RMp92VbVUztKXo6T2E0vQjWa04lMf/f2eyEbISwaLg8TzkJm1qI/u/45rA+sGuoMbfKP/s/fV+OxqWCNrRGJ0Ztlr+fzCENHJdcqcC3yi5ALemt8Xx4RNLZHjCwL2jd1/zn9boUxHuuLIxlN4OWmUTiGSzbSs/6ZmuMuSl8ngMEciB8KneVxHO5kgli5iuvIr89LhytQcnzFCWBXDWQbhjW9tMdgfC4muv2ADY1Tm9dAScdUAri94fHz3JhQc8ubY+6Pf7Y1wgd3XxBcI1uhnxmQzWp8+PrX5+Ye4NHUsMEPtlNxtnKXbj6RjTZq33pNJtRo95LqrGUjLLcodGvRIWMP1u9nTYXN89tN9/l9M6rIUTsQqRBDbTW345ih1eg4VTr/64U4wjjSgRfTh4MDoVI5nTOq3tiZ+HzJ7rZ8htQoVSRVCDRlMCGJbYirn4/SRmSoPS9PqhKkbjZ9PXimoftWfJQIUguqHNHXwsV68InYY0eUk7fdnCOrS294SHe/PvFdVPiqJyO7wbKkg12vjbQMraqmrAQI83UdsjFg0QQJVGkZhC
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(396003)(136003)(346002)(39860400002)(366004)(376002)(451199021)(66946007)(4326008)(6916009)(36756003)(66476007)(66556008)(83380400001)(5660300002)(107886003)(44832011)(86362001)(41300700001)(38100700002)(186003)(2616005)(8936002)(8676002)(6486002)(2906002)(6512007)(6666004)(6506007)(316002)(26005)(478600001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?QHPlSID493+bixpvHIsGZLqpfOPJlqrSHhgOgP94Xq6ZCfMwJmc19Udb7tpt?=
 =?us-ascii?Q?YwZZr9dhW5kFV6KyUppjnQFBa/AAQxjOtnklPz21TjyosRS7K2ofe/ICKOj9?=
 =?us-ascii?Q?wnHAlZb3R4ko1kBk4aulg3Zn+xrPlHY05IS9glAtFbcuZCAUhiHJZUzDefvO?=
 =?us-ascii?Q?FtNIQW1c/aM904rVW+zfqfMPIJuojylJhJ7MwRecKab2D+kfxdXNMvcGLjKF?=
 =?us-ascii?Q?sq1FC5en++XdEBGkmM3MWfXpdSanFO6tziOh53/qmk8BV/HXn2m54F5F5cYh?=
 =?us-ascii?Q?+P8xSWgQgJdcUkWBZ3eoPN8rDkmtOlvKVoJ/uB/WH2blzKj9BW0DpdQEI0bi?=
 =?us-ascii?Q?BNd1c3KKu4A73TyFxSU9ZlVkvjHX9mdoZVgdA1yvCcC65afMPP2lA7AcwPq0?=
 =?us-ascii?Q?KprpYd0k88ctK99gq4HLxLpy7FUjPvNHpvaHUUM2N6jnAZcfYXGURaEevFdp?=
 =?us-ascii?Q?Co+6NFDOmm7cgzgeKvjy6KF9+0QcNuQQVMV6WpkUC3zuWc15TSqLRpok5bvP?=
 =?us-ascii?Q?c/3lqXejAf0l7vy84bmfTBIXHSmCwW+pZcsRA7lTP2b1sEl3bJLyDz2PZVLq?=
 =?us-ascii?Q?5FmameGkFvSrSCQTQtHG6QEJ64nMBa6FWmx0RzyUKa9FrN8Yr1oTyd9uAu6h?=
 =?us-ascii?Q?WiX1iTwH3m/N2jpdyykPPMvfO9XZWfv3DLiGJNrdzaYx1KQecG1rYE/Ijug9?=
 =?us-ascii?Q?HD8kJrKXJyr/swwXIy2Q70+tBuWrxam7f0vygQG0ddYspLsBzT7Jes+YPwVK?=
 =?us-ascii?Q?x7MT6RtzuM+fglX4bEzqPbHxpjpigV3dCPceMB1x6+8G3RJ62s29Oarbkqan?=
 =?us-ascii?Q?7EjPEKJJArEZx+grP2/Pbdc9p0LTE65m++W2Lx8S2jckPiiueq32vllLtOjs?=
 =?us-ascii?Q?uLtTEcz07J2/xm5oBjghS3cjr2bivq0zpefkQgb9A7rTDS4EgHYFdQjMjVvR?=
 =?us-ascii?Q?RClfge6eRpLKuVeWU7ZiLaX9nGEquD3BSkF1bJ/aiF3QCRK157+fAdru8JMf?=
 =?us-ascii?Q?WD/4FCSn9v5bn6oZyWFJbWb6a8ZxZHDQaWbHcVygT6WKj2QEhRytQi7RCAJ9?=
 =?us-ascii?Q?1AOKCo1Y4LjOq/xOmlfBibBH+F5UnScWNBpxEmW7JEMaq/UtBcQ+v7kakpra?=
 =?us-ascii?Q?RJ7i/2w/VwUxpdG3JgK9+CjURsP15xWd2iCKppuATvapP3Jhxgl27CMyvySO?=
 =?us-ascii?Q?9F5AW/2H0kRnxWxPxcSM8OojYt2u6rAqCm8JOVohsEMzPsKRdfQIGLWb18YG?=
 =?us-ascii?Q?9T+0/kDIbepwMgm6CJL6Y3a5l3yiDebTfPUqT5qhqsN9Y9NBq+Ql5t4y9o75?=
 =?us-ascii?Q?DS24u8V9l18GtOYRlIHl3Tam4n+3ltu631CL0gF0UU7rKy2t79XfjUKlb9dn?=
 =?us-ascii?Q?UbMtkJPOMGFHgvKGQ++5N+h69kXkB4scVJYncWrH3ASPZadh+XArbEXO8Kk4?=
 =?us-ascii?Q?pnPM1CXUZ4cJ0JjCkUGt0zy8q/VKYaf0NXFIZArVfedjR+AYAxBJFgH8mBTd?=
 =?us-ascii?Q?fjPQBAxMN4AJGYIfoQqENjqF91BEntGQl9RkP7z3IgLW/k1opLIuxAUYkp1A?=
 =?us-ascii?Q?vVBL4XlvC9q2rhH8+hPv3o17HM6RbYfZZQTiq1QF?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 512466fc-5b86-48d5-2d63-08db60259b07
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 May 2023 09:18:03.5616
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +Qw3hBDMXdjdwcCBmSYBC9Ui+d+iYisdfpbATJELjgEtnMaXFNC5NucB8Da5vvpcuVw26GTtHPqiOW8I/hh7ew==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PR3PR04MB7321

This patch moves last_snd from struct mptcp_sock to struct
mptcp_sched_data.

Signed-off-by: Geliang Tang <geliang.tang@suse.com>
---
 include/net/mptcp.h  |  1 +
 net/mptcp/protocol.c | 14 +++++++-------
 net/mptcp/protocol.h |  1 -
 3 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/include/net/mptcp.h b/include/net/mptcp.h
index 4bba29c99172..d52aeb8b4485 100644
--- a/include/net/mptcp.h
+++ b/include/net/mptcp.h
@@ -100,6 +100,7 @@ struct mptcp_out_options {
 #define MPTCP_SUBFLOWS_MAX	8
 
 struct mptcp_sched_data {
+	struct sock	*last_snd;
 	bool		reinject;
 	struct mptcp_subflow_context *contexts[MPTCP_SUBFLOWS_MAX];
 };
diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index 763f709fd5f5..356f8ba1e80d 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -1619,7 +1619,7 @@ void __mptcp_push_pending(struct sock *sk, unsigned int flags)
 					continue;
 				}
 				do_check_data_fin = true;
-				msk->last_snd = ssk;
+				msk->data->last_snd = ssk;
 			}
 		}
 	}
@@ -1660,7 +1660,7 @@ static void __mptcp_subflow_push_pending(struct sock *sk, struct sock *ssk, bool
 			if (ret <= 0)
 				break;
 			copied += ret;
-			msk->last_snd = ssk;
+			msk->data->last_snd = ssk;
 			continue;
 		}
 
@@ -1673,7 +1673,7 @@ static void __mptcp_subflow_push_pending(struct sock *sk, struct sock *ssk, bool
 			if (ret <= 0)
 				keep_pushing = false;
 			copied += ret;
-			msk->last_snd = ssk;
+			msk->data->last_snd = ssk;
 		}
 
 		mptcp_for_each_subflow(msk, subflow) {
@@ -2457,8 +2457,8 @@ static void __mptcp_close_ssk(struct sock *sk, struct sock *ssk,
 		WRITE_ONCE(msk->first, NULL);
 
 out:
-	if (ssk == msk->last_snd)
-		msk->last_snd = NULL;
+	if (msk->data && ssk == msk->data->last_snd)
+		msk->data->last_snd = NULL;
 
 	if (need_push)
 		__mptcp_push_pending(sk, 0);
@@ -2640,7 +2640,7 @@ static void __mptcp_retrans(struct sock *sk)
 
 			release_sock(ssk);
 
-			msk->last_snd = ssk;
+			msk->data->last_snd = ssk;
 		}
 	}
 	dfrag->already_sent = max(dfrag->already_sent, len);
@@ -3142,7 +3142,7 @@ static int mptcp_disconnect(struct sock *sk, int flags)
 	 * subflow
 	 */
 	mptcp_destroy_common(msk, MPTCP_CF_FASTCLOSE);
-	msk->last_snd = NULL;
+	msk->data->last_snd = NULL;
 	WRITE_ONCE(msk->flags, 0);
 	msk->cb_flags = 0;
 	msk->push_pending = 0;
diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
index 09a5e23adca1..21d59b0875e7 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -266,7 +266,6 @@ struct mptcp_sock {
 	atomic64_t	rcv_wnd_sent;
 	u64		rcv_data_fin_seq;
 	int		rmem_fwd_alloc;
-	struct sock	*last_snd;
 	int		snd_burst;
 	int		old_wspace;
 	u64		recovery_snd_nxt;	/* in recovery mode accept up to this seq;
-- 
2.35.3

