Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2071.outbound.protection.outlook.com [40.107.22.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48BAC17CA
	for <mptcp@lists.linux.dev>; Wed, 12 Oct 2022 04:41:01 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=V21HLqOelQZ0MXWJWc3N4r0Lw/cmahh1MipwHUmblClFFeW44tqahXtv0LCrWKzUKhBVao1Bigr3OEzcFTaYYpbGEaqVLWVzjruMQOJypqIkw13A2SMCUwLPwMXbU+TckR6EM+zKUMWYQ7a4Q3D8VQCy2vlYUkvh8DtKqVGacmxGfEOtXxzz86bK7mfw+HRsWuW8bDmVBCsWOEerIEBDJZk+ve0Ifut6Q+KcpyQDYARFAQgtJNFAbccM7xMe3WN/jYN2liEkqDIRbPzK0alz/Ewezih0L2+NzDgkxsi9yXIflB9eloMEF/WuBLD2ZIiyR/qbfdtK8Px/wD1aWoWh6Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=svNannqIoegQ8ihbXsehrlw5PeUtcNaP+DfZsINbdDs=;
 b=eNmiHGPNCq8Fmgsg98Xy3LJhstIulpeFY0Z4ZXhfCBneZfzExovNc85XhPFUgcmMeerOIv5vne2+LCZsJY/Nq33/HSB+JtjEEnKtAXlegF6MPdUESYd1hpDGyr/y1SYs40PsVkbcyBNpawwesbN04gtj38fTqv1hAKj6vpadNgOjuSN/fDG+fpuoj5W3DeVDuSWHXgtKb045YqVzKihLw5tKbVprjAMXmnjAxcuKT5dZ/WRc1MWzNlJAoGoufwlLk0deuvjHV195cXqaiq4pPYbTzRbVFswWuI8XHHfbWWAioRfrEVToKUtFuECW6WAoR3DVmeqSMA71ohEYdpjULQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=svNannqIoegQ8ihbXsehrlw5PeUtcNaP+DfZsINbdDs=;
 b=GbxVJ2szI0ODBPoNPu+EFP6/DfZC02D5/TSDuiW1mETf5qwjeY8rgCg2Ma0tkGRmr9wyqAswgXOnZy7yfL9YnpHp2rn7ZNG9Q0wXpcQl6jpOdGG1m+3DfrO96CUqc0Aoesk6tvu942hy2Rim6deZkZVkeXxnvkRdYyT27viVKhThl0KOsorDLnmmaIlXe8DW6oHlqTZPZAQtHB1kBb18+kn0vwZZyrV9+34lhLsauLkuGSR/mHBIr4C7GeMW/oym3P5Pcu1E8MHEZsffpDsf4wtqOk9akNXBLmHAmQu6luCQMBsJvTFSej4JmDkj5bojuuAdSQXjwqCqG1Uid4AD7g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by PAXPR04MB8814.eurprd04.prod.outlook.com (2603:10a6:102:20d::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5709.15; Wed, 12 Oct
 2022 04:40:59 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::f426:b04f:d9f1:cd5f]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::f426:b04f:d9f1:cd5f%4]) with mapi id 15.20.5709.021; Wed, 12 Oct 2022
 04:40:58 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next v7 07/12] mptcp: use msk instead of mptcp_sk
Date: Wed, 12 Oct 2022 12:40:02 +0800
Message-Id: <4d32a43bf2ea79a2fa61b691acb6b7e067f98790.1665549148.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <cover.1665549148.git.geliang.tang@suse.com>
References: <cover.1665549148.git.geliang.tang@suse.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR02CA0136.apcprd02.prod.outlook.com
 (2603:1096:4:188::16) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HE1PR0402MB3497:EE_|PAXPR04MB8814:EE_
X-MS-Office365-Filtering-Correlation-Id: ad85e844-9750-4835-db63-08daac0bf565
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	iMTHIygXlTLauMXwPiqDZDABI9iRH9ptm2ucQJeWr+LKtJnxIMmvhQa+R93gaJ5bUpt8Cvf87pC/n9OMjnCQZcmM3g1rPkslKcgESiNxkYYsgDUpIP/BtszMqS4C5g+/Bnw2dfvyz7azV4H7CTEtnj3FinkTyiuOROCULE3P+d/jSkZlWw6WGSqrs3mobgsuypRTGwHKG/uNbV4RZrWGQKv7d0jjjSEABBDrIButsM5cngsOmBCmyWIkZVBuSqR7gXcZlFtAXL75mdgZF7tqhmJx1Ma+4/FJxsG76G5rn4hAjCHnGHg/uVdSZGYqNYF1e0OnybwxM9Os9z3Rz4RtFZaqhqAhGyJZT8L17uI2hVYTv6tcsnwvnT36g0+4f8VKWXJdLJqSw2SbOpVIQtxz8D9QiHHs18whzroQ2HaJPkiTEkmgEKBYp9dSP33/nLofcHpSmAEtgoy0JiP9adv5N7rlfe4Uq323NFdqx/qANirkQ8J+itvQJndQJDKJ6bP08x0MKY/+vX/v8hvzAr7CZTNCAIqZbpDTQ94h8CpsgkCGHILwUnvf900AbiQHp66M5TqEyUtzP/fwU4RXow80LfIaLxMTyDsBk2bWJ4J+DlDsuLbJUzdWU1lURNoTn/XknZH4gCd4LXLPkouMix+qYZ6czJ5nWW6/b6Kd91pHlTovScOXKacFxJXhLT/BjgQ2IYES2b6Od7IojL1CW9IJQHdZ3JL0ZGJCPM/SKbPhj7EKuQNZsTfdsPbLNhivkDyP
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(396003)(366004)(39860400002)(346002)(136003)(376002)(451199015)(107886003)(83380400001)(8936002)(2906002)(36756003)(8676002)(5660300002)(86362001)(41300700001)(66556008)(66946007)(316002)(44832011)(6916009)(4326008)(66476007)(26005)(6486002)(478600001)(38100700002)(186003)(2616005)(6512007)(6666004)(6506007)(13296009);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?dh0NwyVKgEVP3U3TjQ6mm8YklyEpB9mer/iE4VHkSWmAWiW+j+MsWOTS+RMQ?=
 =?us-ascii?Q?3kxvgUO15RkNXWqtqqNTg+5wuyuCGm2mc4HtBCvAIhDjlOXHbzU5DVySw9fu?=
 =?us-ascii?Q?JEQanTSqCmV/42ZH5STafjbkpw8eMeI5vuB8REs8TwBN+i3G7x/nxWERN/yS?=
 =?us-ascii?Q?98sxWKB1emYvgEnA/9eJAXcS6tacUrKnZ46IMI+QA6Z/QVf9AqrMo1cyT8LM?=
 =?us-ascii?Q?imSjActUmFapSDKZvL29tLzUzW9OfBfmaJrZEVRl0e3V98yZHGfz8QehPeKl?=
 =?us-ascii?Q?qnYYSVRUcODakJ6AlguutAUCB4+8u67Q4Klasc5K9dQvAoI2ZSxRKAvuvL0p?=
 =?us-ascii?Q?VAcwa42pBWSrs7+EmPGVaerAfcX8Bp/TG9qwhBAv8JB2yi0GYQlFpJh5g37Q?=
 =?us-ascii?Q?Dq+XEQE++rCT0ZVW4qYRIcZ4uCAgLqhIKL1umrdurWtqPJ4mlfzTpEviwbPO?=
 =?us-ascii?Q?cEliD1PBgirHZfvKnS7IMo4N1vpXFTIoRZJ9TIULRyQ4eKo9RI7oHcxNbuwt?=
 =?us-ascii?Q?N4Wys9QxGyonf9FqWiqqkXgpAm6bORnEb0LDLn8C2iGN8THSy/sk60pp6v8A?=
 =?us-ascii?Q?jvp2Srk8tjbH2t1scFKCwLMAIc7fyMvbMl55hSbCmCMNWbOZr0jRUiYGNr/a?=
 =?us-ascii?Q?BFaS8Z+/o4//W3zqtXRPdO+yAqSRtWAH8ZkVMjSqX9UMNjbSmNAm0S3AEI2T?=
 =?us-ascii?Q?eKg6gW7s3goRGwbh8INl++30ay/b+ftjUBNLoVSsPdXlOXM088lGiQ2aplbO?=
 =?us-ascii?Q?ivCSrmm7I7AvBH+n/9gPCnYgrokks3846+U1G+ZifxOZETWrXpKmlvd/7AVs?=
 =?us-ascii?Q?yWxrz1kXonHvS1ieyUphY+EAcCzYzGZndPy5JJaLpS7Fnsdf8F3tXSx9F87o?=
 =?us-ascii?Q?FpXk61rBKbO0hw7lsvDNNaCP+FlP90mNB3HZKhUCUX3CIpU6yLaksIJopk38?=
 =?us-ascii?Q?YyWtj9ifQMzVXiBo24AT5rBPC0qFcW7WAw0ox0dDokcSfXifFdGK7LWTDPWK?=
 =?us-ascii?Q?TdY1ykwWx1Tczr97iWvbrDqPj4/i1HyGdqu71U9l+DGvgKQct9El+hlYxdLW?=
 =?us-ascii?Q?awBTQ+06hJ1uO41zqiFu55Bohff/BwimTnD7EznCsS5pw6Ox7pnJ9g2AF0YU?=
 =?us-ascii?Q?s2CXbijEAzJ4JJuCqcqW81EoI7sfvF4E+UWOwEj+ct5O2KT0G0tIx9UByZof?=
 =?us-ascii?Q?FC0m0hxNUm4EU6rBcT01RyaIIKVfxHm/ls6CfRGcw1XeIwB3kVAGkoWZAOG0?=
 =?us-ascii?Q?5PdGkHZKO0wcxqsZgJuZXdVahKauhHGstF92Ezc/UeFmjbnjmhi+791Fs7Bj?=
 =?us-ascii?Q?O4dNznvfDkeiCzw8zgGzWomQ6mQwBMxj0x1UJNB4/uy06/XKBgw1JX4lGqdr?=
 =?us-ascii?Q?eQOyXnmeB3KpwBJwG+Nuy8RkeuXF9UGGf4FawkbRnr0RTb4ktJbKt9FzVqW8?=
 =?us-ascii?Q?fm2wW7W/0a6OO41zrPnixXWDa5jqaNvB2wzaPHXGa3OwzE9G1/QY61fwLBoq?=
 =?us-ascii?Q?j25GGNH3LLKClfY8O88C8m6shtcFMdrh6FsbPu+1jd+q92NRpMEuK5hHOV5b?=
 =?us-ascii?Q?UKSb4EsiZNRkmHr/Qvq6c/4psBihLbwQmhK6SlG/y0Z6nsxtgpecnWw+uMMT?=
 =?us-ascii?Q?XA=3D=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ad85e844-9750-4835-db63-08daac0bf565
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Oct 2022 04:40:58.8994
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: q0/nkenqnwKygzUyQnCwpguhXuq51VtqGe7tojpzuVsVySsRZ56/22D0FanMZKQ7U9gjoPkWRV66q8e3kzHsSw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB8814

Use msk instead of mptcp_sk(sk) in the functions where the variable
"msk = mptcp_sk(sk)" has been defined.

Signed-off-by: Geliang Tang <geliang.tang@suse.com>
---
 net/mptcp/protocol.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index 86ac38d10bc4..abdaeb0d867a 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -1618,7 +1618,7 @@ static void __mptcp_subflow_push_pending(struct sock *sk, struct sock *ssk,
 			/* check for a different subflow usage only after
 			 * spooling the first chunk of data
 			 */
-			xmit_ssk = first ? ssk : mptcp_subflow_get_send(mptcp_sk(sk));
+			xmit_ssk = first ? ssk : mptcp_subflow_get_send(msk);
 			if (!xmit_ssk)
 				goto out;
 			if (xmit_ssk != ssk) {
@@ -2251,7 +2251,7 @@ bool __mptcp_retransmit_pending_data(struct sock *sk)
 	struct mptcp_data_frag *cur, *rtx_head;
 	struct mptcp_sock *msk = mptcp_sk(sk);
 
-	if (__mptcp_check_fallback(mptcp_sk(sk)))
+	if (__mptcp_check_fallback(msk))
 		return false;
 
 	if (tcp_rtx_and_write_queues_empty(sk))
@@ -2930,7 +2930,7 @@ bool __mptcp_close(struct sock *sk, long timeout)
 
 	sock_hold(sk);
 	pr_debug("msk=%p state=%d", sk, sk->sk_state);
-	if (mptcp_sk(sk)->token)
+	if (msk->token)
 		mptcp_event(MPTCP_EVENT_CLOSED, msk, NULL, GFP_KERNEL);
 
 	if (sk->sk_state == TCP_CLOSE) {
@@ -2989,8 +2989,8 @@ static int mptcp_disconnect(struct sock *sk, int flags)
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

