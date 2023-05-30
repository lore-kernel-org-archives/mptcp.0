Received: from EUR03-AM7-obe.outbound.protection.outlook.com (mail-am7eur03on2074.outbound.protection.outlook.com [40.107.105.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D46A31DDD7
	for <mptcp@lists.linux.dev>; Tue, 30 May 2023 13:18:11 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=i7HJaLQ+WOrViCRHyapOCCTkiZZ/PHugS+UJDidD/v8z+KFcJv1z5+EGiC6j1iwegLm3I380VtSZZnRLOYOT8yMyNHRcRB5wKhh7hokaCsMVJghMQej/+AdTm7nON5SBT6ip2AUTTv8fW/4k7UTGmBJXom6o2YkhYsz36qwMDfalpgbxsNnvANHfBSBx7P2P7vgN7VVDqJDMgdRtlCoskHPlGe6oEmMb20KkStvedIeKc84uOtOq6Jl2QxCqsGfLO8V6M/hUzQTJafO68Y92rML2J1KQFKn+e6fNSYucwEU66trbJtcxPHQWmYLp+hZwY6b0gnr85kxUqzmQEj1/4Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0Q4INmfgho9xg6KL19Hk5Uam9YcWUetT2OGIV4nX6Ho=;
 b=c8bvFhz5wKzm2PIxcV0yGg/EbDolAznMuyqEubR5oqhUge84L+O0SpZH0tYKcLgEKQ8tQOlHvgBOheBRdYm+8/yM0HGtRtR7sp+C3/TYClv58H7xL8GPqvs2IZqatjqothBdT3h8YJwDIopLmieUtEakctxVQnnQUt5cXKHXTz6iBHH5QOxGVqlEPx4lxGFMue10vfurCMLQIjdMf4lEsLNOBCacd2VMB8E8pN5BJhLqylECa4SWW20UwtfQXd3IK7BVoVFiCstfZxt+bADbW0CF3JY56aZeg3VZ7lu+LE0Qv3TMXryYQo6/D6V9oIipuOcB1Rm6hww/lVD0U+37cA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0Q4INmfgho9xg6KL19Hk5Uam9YcWUetT2OGIV4nX6Ho=;
 b=haxXgb20ClT0BHpFMzz7oU2vaXU1OdSLdFZxnZgXqixR+WFol//NKhJCUIGJ57/QdJ+a5iD+4olcgntUuejcEK3j/rTl7vBg5s+PG+5ZOVVq6Mfh0U0LVU7jzeZEEbrUfKLNZUrzI+s/WprU6YfyMm8QMGa66Ikh0a5ZyJpemQnv5k8TWCs4u1VDjT1KjOJbHVhI/o/6fQCi/KHg7U/APQu86UUNu6k+20nDLNfc8AUkz6J4/ibGn/VcS2bAVwn6KNxahveAcmnw5WVvaWv7HYuKaMZ4jgEtn3sIzjphVU72Ln+xOA6oA0omkgWnRwGQvkzNUmgJ1UJcUVQnqNOMlA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by AS8PR04MB8403.eurprd04.prod.outlook.com (2603:10a6:20b:3f7::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6433.23; Tue, 30 May
 2023 13:18:09 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::423a:a30f:5342:9d35]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::423a:a30f:5342:9d35%6]) with mapi id 15.20.6433.022; Tue, 30 May 2023
 13:18:09 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next v3 03/15] Squash to "mptcp: add scheduler wrappers"
Date: Tue, 30 May 2023 21:17:23 +0800
Message-Id: <0ef71dfd3f2a8b4ea06aef816fb2881cff68f1bd.1685452619.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <cover.1685452619.git.geliang.tang@suse.com>
References: <cover.1685452619.git.geliang.tang@suse.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TYCP301CA0030.JPNP301.PROD.OUTLOOK.COM
 (2603:1096:400:381::20) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HE1PR0402MB3497:EE_|AS8PR04MB8403:EE_
X-MS-Office365-Filtering-Correlation-Id: a4f7273c-fad4-4c0b-51bf-08db61105009
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	iUewT/NlAoSX67kV3vQbfAkMRy5709K5WczDMocT9YU4s4NtaNBx7eziU8r6hBewX5R37UvzYwjwt/IaH+ojCzj5BlP2yLieLTSiKCCnRqFTktrGysAlt/qLYWhQ0AhW3sq5zME4gdAT5l03BSPUj9HcqaY1T/UzP4XapG5ql5ICHJiUYZC0OF5xy7fZfcKPn6msgs5MZE8CWBXZ+Cm2uvKh1s7sst2/BcZxfhVhczas8LJJRjh7KFF4ISJqgapmN91+bQV+z9kt9gm5X9zhGPv2zThmKLFKkM1NwEUbMv/1gzTnxjCyKoJVtr2rBZDjpy7J5MDXJU19bm4Lp8I8EWb/QSuaR9Zp3Zl8fsBuJSBs+y0P1m6+zTi7iP4+Zd7aGLh2bXLH2Hkxwdp/zg0uct6V7O0/07NRbHP+NPQ5lOKkK78u6cSdy6PzRg+tEXOtkc0y046tl+E9kOy4RAMeYYC/su5HGfq6vM7pOcnw25ZwEqodA0cL0EmL5tvaTI2eZALPz0wi/sHzxA5MF9+CA0nkxdIObDQaWXiv91cHujVxZhYLDUBIJMRJKEiGPxhv
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(376002)(366004)(136003)(346002)(396003)(39860400002)(451199021)(2906002)(186003)(6506007)(6512007)(107886003)(5660300002)(8676002)(2616005)(38100700002)(8936002)(83380400001)(26005)(6486002)(86362001)(41300700001)(316002)(6666004)(4326008)(66946007)(36756003)(44832011)(66476007)(66556008)(6916009)(478600001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?mEONmf/QYS7vjLEqMnZffKauXsn2qT4B1h4UMEh72UTgnilm+zpGH9bCK2f6?=
 =?us-ascii?Q?9hgft6QoOWiSZTJscw64sTQZ2Hjk2/D3Bj+u7H++s4V43ptdkFyN+HhHm/6e?=
 =?us-ascii?Q?4JyCIJ5cuKCP3ZSwB5TzL5AZbcu1Dg0bdLcHkjm7xIRCuoGKpdheoIw/wsb8?=
 =?us-ascii?Q?b7KN76kQEPWk5BHusUuOpxYCLsCN+5R3PFw/NhNWtRyDNi2AnV91Jh8wahT+?=
 =?us-ascii?Q?Ix3MnH6/nul6NejktsxVK0d4qDl2DCv6/zQLERvRLwrHuSB0zAcUSgG0eh2m?=
 =?us-ascii?Q?evXfiT1/kyvnixc6n+eKne++WXAlBFqsbEVNYbjKhd/Hq0D4LgeypFt4W0u0?=
 =?us-ascii?Q?MGjMJ7CDIJQQ8FLxNvX7j3SHJ/YvtyEbTGhjALLsJ8cMlWJn8gWos40lEPGu?=
 =?us-ascii?Q?j1LFZniZMAlr5eyLobukAPsKH38IF6ILc5w0MqFR754/0N8I24rHuEdQpfdw?=
 =?us-ascii?Q?y2TFHamwonwNAZ/dIL/YN18hiNK+q5EsZZ8qb9FfMcncZf8S27AIZfKBvzbO?=
 =?us-ascii?Q?VlD1+PCrY4VkoEZjrmKIb3mZn0duAKKQZbP1dUupGVEW4lIofr9cyupQMBrX?=
 =?us-ascii?Q?LB1vGxmISxfkbGX7Qr6utV0E98bCV3+XtTSB8ncVlMhOWl9hJYlkyztTH7LP?=
 =?us-ascii?Q?8oip2yRuHJJZRJo+P5gdboaYs47uSMCY4jnhadC0WTG4yysX9FyE2JZECiNE?=
 =?us-ascii?Q?OKtpfEKZ0W7Qew0DswMEqpWcnYjCGmF3Hrm0U0x/oHlpKJAbxv0C0AFiJpLk?=
 =?us-ascii?Q?TIrygtB+cq6Jshc1Jf1/6sJ8mLmE77jigibPfnsYLCeyrjq1zaG9vhJfEpRH?=
 =?us-ascii?Q?k5ymnhzX5Wy0ZecA4a8venOIkSezbIaAQhHNeFszRMUwt/wy0cVJwnYMvW7u?=
 =?us-ascii?Q?pbUVKxtR4XJWUVJeE4k8gPBGo4wwIpr6JJ9gVwJfLGJ9xUsi8PLg8FfS21es?=
 =?us-ascii?Q?XjByi2EEfhdKes+k5KbHNg/jg3MDCMorA+rk8Ix27fLkdlteLO2VdcE5XvKD?=
 =?us-ascii?Q?jg8SnfUCVtXF35AO78s8LCJuPCz0hbP5Hv4x3dQiVhISutxld1dDE6eFOhvO?=
 =?us-ascii?Q?Iog057DaCyMeBfb/8DtZs5W3HnMFgMcnzQIkJ8nNbJcsFjNRrL3na0JgMcev?=
 =?us-ascii?Q?DiEtFHFaI16BcLIaOKZqC8N3rEa4N3W27KjvLR7uoe2eF0sMyXkPDzKbINSm?=
 =?us-ascii?Q?s4amtyLM2Yqpr6O7VC3+xTKQEL6OFv3redbiO9UOCEQobp7K8XA+VrZ8yXyF?=
 =?us-ascii?Q?V8dHppPjg69UKDqCY9rEmO9Yo5uvox+2xjQ1bTLk966EUoXefYYDV+uMvl3f?=
 =?us-ascii?Q?ppoICFpeL71G3CBpDI4WDQ9j17HdLkv+6rAOjgpq+dEjags/ZHiVdOBMqKzJ?=
 =?us-ascii?Q?caM0enEEp4M1VPDrMRmsVfcIrNLpxRUc+NNcxg3yZAnf9hpo8t+KNzJk5qLB?=
 =?us-ascii?Q?KW2z9L9mPh2Bcj8acwcEDqXoovT/Bv01ffpeFn3w+NHSbgEGMiCAbYAyqAeo?=
 =?us-ascii?Q?lkUMTqcwRLELIvZUcg79TqGEIlqgqT3rjon9L1nNYCNnX5dapiXekExW2VR3?=
 =?us-ascii?Q?XNjaZHf5HBlyJiWzihGxvjgxkS+IsVl09eXbuXEa?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a4f7273c-fad4-4c0b-51bf-08db61105009
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 May 2023 13:18:09.4348
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: kBQOoDCKRUymzPAttzdghngKtHtwwQLb+KwJawcI4UhItftjf8Wf0hHYcgU+LGixBFGIhULShA2nOyRzw8VlQg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB8403

Use msk->sched_data instead of the local variable data.

Signed-off-by: Geliang Tang <geliang.tang@suse.com>
---
 net/mptcp/sched.c | 14 ++++++--------
 1 file changed, 6 insertions(+), 8 deletions(-)

diff --git a/net/mptcp/sched.c b/net/mptcp/sched.c
index a053a9504dfd..5438a86e897a 100644
--- a/net/mptcp/sched.c
+++ b/net/mptcp/sched.c
@@ -127,7 +127,6 @@ void mptcp_sched_data_set_contexts(const struct mptcp_sock *msk,
 int mptcp_sched_get_send(struct mptcp_sock *msk)
 {
 	struct mptcp_subflow_context *subflow;
-	struct mptcp_sched_data data;
 
 	msk_owned_by_me(msk);
 
@@ -157,15 +156,14 @@ int mptcp_sched_get_send(struct mptcp_sock *msk)
 		return 0;
 	}
 
-	data.reinject = false;
-	msk->sched->data_init(msk, &data);
-	return msk->sched->get_subflow(msk, &data);
+	msk->sched_data->reinject = false;
+	msk->sched->data_init(msk, msk->sched_data);
+	return msk->sched->get_subflow(msk, msk->sched_data);
 }
 
 int mptcp_sched_get_retrans(struct mptcp_sock *msk)
 {
 	struct mptcp_subflow_context *subflow;
-	struct mptcp_sched_data data;
 
 	msk_owned_by_me(msk);
 
@@ -188,7 +186,7 @@ int mptcp_sched_get_retrans(struct mptcp_sock *msk)
 		return 0;
 	}
 
-	data.reinject = true;
-	msk->sched->data_init(msk, &data);
-	return msk->sched->get_subflow(msk, &data);
+	msk->sched_data->reinject = true;
+	msk->sched->data_init(msk, msk->sched_data);
+	return msk->sched->get_subflow(msk, msk->sched_data);
 }
-- 
2.35.3

