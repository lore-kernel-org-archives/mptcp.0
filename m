Received: from EUR03-VE1-obe.outbound.protection.outlook.com (mail-eopbgr50051.outbound.protection.outlook.com [40.107.5.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D255EA4
	for <mptcp@lists.linux.dev>; Tue, 21 Jun 2022 09:54:26 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ezAp0u+/LessSNE71dGCvS6g7EX4f8VfiIGBlNjCngBsO6XgF4sFCsPMZU1KCsWr2C/947aegUW990kzaTHUghnZ2ecxvil6mXAj+4JNxyFxWYnpIOk36Kzy2ZUaJI3zz6CPpKK31msL75iL0JzymvvJvUXhZ71+e+ShMIBKQoIcD69uZlEo2HKf8Q0WzD6HEjm+bGhMNzVGkGFEXvl1MznUqKwKj08c2YtMXc6zJyKDLAMkDC7QTFFWqPCwHlFdUX/OgUPdnGs7OkHKxjC5DIa3gyOkbqc+CbJ8Bxmkqt2+bcIPIWq6xtwtBPuP4uodeQlZJjaTUmoqUo20UB+3QQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=F7NUb05TY2+opRAHt+W87LgZvFSd25OnJiCNobXUHbM=;
 b=mxrHjsdrKkCPAXx4R2aMWewjweKVDKglbi41BxSWIvI6Df2xDXJGvkFKuKWivqKe9vSpP2/ISVXlCib1UC2aHIW9CbMTSO3agEUiKsLKGy010kZOqJ5R/eOH5b2f+5ltYQXdNSyivvkekVPUdE/wbry4ZiISyO9KaUQH/2V77J/n42Y75sQvjsQlv6jn2VPZE/8z/wwONEkv4Y0vFDnXY1gqGQ42P1nmWCAGyEiA6Ho2NuH1Axn4DEBtdKrysNj5fAuCUWroLx310qU73WBUNpDRRVNy6aTKR7JwGSin2MxQIKInjY2T71RcwBxJNKn3MbCkFLyPzIZf4X/LEx/EHA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=F7NUb05TY2+opRAHt+W87LgZvFSd25OnJiCNobXUHbM=;
 b=0QY48ZCPmhTlrOs4gRmSr6nUJ48eva/q4XQRoevktNZG/Wlz52RUB/MYHLGUQKX9gOB7xXRnR2XnVg/4d7WEItAu3PNy1QpkOufo2ji4sRsL0fEK9TDS2herNUlo2/hy9fdnAt3w5Dx4jxTd/Q0htjWuLSqYXZAk9orQ1Cvq+BSQT23k3JBHvZJ1G8999wmfzvTYC95rhc6aCNJ6WcQi/HXzyIPSnhrw14yfz3NjHpxvTj3X+4erqw2gkP3gyvBT08QAzc3nxJDMGbMgnbqR8IXlfI7K+tsht6HSDY7XVm+TzJsbsLvPIZKAaSf59sooMIuJwtECZ0qJZRvZSgfXuw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by DB9PR04MB9427.eurprd04.prod.outlook.com (2603:10a6:10:369::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5353.22; Tue, 21 Jun
 2022 09:54:24 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::8002:50a5:a57a:d8fe]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::8002:50a5:a57a:d8fe%5]) with mapi id 15.20.5353.022; Tue, 21 Jun 2022
 09:54:23 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next v7 1/5] Squash to "mptcp: add get_subflow wrappers"
Date: Tue, 21 Jun 2022 17:54:15 +0800
Message-Id: <f9ad80d798602ba5ac3b21dd6dc6ff213c59c82d.1655804700.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <cover.1655804700.git.geliang.tang@suse.com>
References: <cover.1655804700.git.geliang.tang@suse.com>
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
X-MS-Office365-Filtering-Correlation-Id: 130268a0-5fbf-426a-8ac9-08da536c04df
X-MS-TrafficTypeDiagnostic: DB9PR04MB9427:EE_
X-Microsoft-Antispam-PRVS:
	<DB9PR04MB94273DD021484343D1CF017BF8B39@DB9PR04MB9427.eurprd04.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	mlADDCUtOQNslG1afW1bLOmK0nSNia45wR6MV6ZsUGuNPekC3f/L7iZVUkStzVuGP5EqequxpQhawxS4TiB8/Ok5zjAi0YwBmopQl1nVu/OsbxAAcwocoWatyvN9jUoZgL2qOAd+kk6EC7qUDGcWXJQ9rIjz9n2JCJ79ABMNYj0QWvkXnNU0sFwV2QaLagXWWZEdhrtUGzw6jTNTdQ288i7hfMbxGMlH8fO7SeV8NGSMjdO0BsBgziIFB3IbFr3SrbUD3aR6p1dUTFtF5YzwGGVRM82jeq+Op4o+m/3ikdn4bKEZ02w5d1YeJXrDPpC2Qfq4A3DPHzD46OVxjv0jX6xr/06s9iH9NsPpoq5YUg+BN9NQGUoZHsMJjhaSBnR9Wd2WyK17R084aq2KHWhSFldSqsEJOd6DY5cSmZfZEv/J3/4rtgPpJdEO17yMgU58xaV1Na2AJd0UKz/N7t2pFYIMcSjVozYdNYn6YZyASySvRY0SeeZOOTUy8376hfONKrFFg/b9pUux7BrX2S9OB8bUNOfBojuoenJeBonoCsadtzZo/W2BbF+ONj22x6UZ7a+312aLeOEgLvXAmY1u3KQaBkd0PSSV1Ac2Jc2uM9pW4PWhkjZSGB2Dr4r3u+/zGT2H1Lx1mNVmg6yp8PRAsemjGUFDGfjfJETtBhs6kFP352m1KFC7vfmkWkx9mcVVPF9RuQYnydv85mxvStnt/g==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(136003)(376002)(39860400002)(346002)(366004)(396003)(2906002)(6486002)(83380400001)(6506007)(5660300002)(6666004)(44832011)(478600001)(8936002)(36756003)(38100700002)(186003)(86362001)(41300700001)(316002)(107886003)(6916009)(66556008)(66476007)(66946007)(2616005)(8676002)(6512007)(4326008)(26005)(13296009);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Di+B0Cotq5jO5wAzAAE/jtlbvKiZvhR7XBSRZ0V/e+N6+DdGNoHMne1up8Nx?=
 =?us-ascii?Q?jav34NAKuKPnvysHSah1LdY6A5/jEfRVvzniLNb12kG9+9IFiN8w3Pd2ugSC?=
 =?us-ascii?Q?r7TyfXORLPOyc18dz+jLtUJwcU9RT9k/IEBT8aleAno3PkmQQorGD2wZMRDK?=
 =?us-ascii?Q?plUaENZXMcCEpqn62MEMpHW4Rx9u2kpm2yMEd/CG7yFWVYu6bXPZVNdYKj3k?=
 =?us-ascii?Q?EZXqwfzGQocDRE+IZM+6rL74p7P4It7iMozeOzXEEcYIfLFiQMrv39sjJA/F?=
 =?us-ascii?Q?AkzZRy72cezdd8UzuQ3GR397ItZ/HGTvdKBwTt2reR+SXiOseGfAwTRSjtLz?=
 =?us-ascii?Q?MPVIn8aBen5cDaKsv2H/NDkEu19/BYD3xAxynQF7vygBVivIy0EPDzLc5+dT?=
 =?us-ascii?Q?9KgN7GTRPW39GEPi+da5I1zPvolbpTzx5CZ++1WyZQZ5KziWpdmyqJhx1cvx?=
 =?us-ascii?Q?XdFHBm1ja77kPKNHbpOx9ncAELyEsKs4ic0PIyoxGBspFsTB8VoBqiRzwvQk?=
 =?us-ascii?Q?TA3Ap/6HJlIalY3ekMHItCX0e+HMNxT/Z8qPC/u7cTfOujyVz/4xT/npJuuC?=
 =?us-ascii?Q?PxmMlxKtlVSGwYACjTKj6YZ8J45cVhw+vZ3n/RBtlxRLP7Vdi7BvRoj6n4Rw?=
 =?us-ascii?Q?9AuHrEN7tLYDYS4UyhY/SVI2hcE56ahEwumDnCGCV/L9O78E6rR0bNMEAxej?=
 =?us-ascii?Q?54pgMMs0AGefViOcWPa2i5F9bszrvQV393GdYVcnpqp8MoVdT1gvNg0tRgVQ?=
 =?us-ascii?Q?Td9m379vQ+S3LLPkMpG8PWnbDeNC0tdFAqphnCmHqoPiSg3+9TAohsuPrQ9P?=
 =?us-ascii?Q?EFzyCcnGimVgfeajpYJlKWab/lVxR+/W06cw3ISZhjAPlakp/Qycu7e2NCsE?=
 =?us-ascii?Q?r+zW0LMfJ3e5g/nKjM2+kVVOjoINkpBbAZmTVP9YFGuQY/DSGNMUYWBdFsiM?=
 =?us-ascii?Q?WYIIQ7uYW0r57xd6O6iJbA5KakZ+/WS3PnfQQvpmhMoBMAE04NruA2D0sLyU?=
 =?us-ascii?Q?HXC9wzAJ1OOYlOKYl+s7fUeSXy7A4au+jrYGh0nvm2bJzLjE2lUYR6OLuUt9?=
 =?us-ascii?Q?Ibyo/dNHjsxlVoO/pNx9gwt7F5Ypissr+ltKiAixRJ0DEsr8706GrrFCbYBs?=
 =?us-ascii?Q?4GLdSWd9l8PNQvuzAgSieDZjHOOabV4nUr9BBJXXU/A5lIqQ3ghg3rOrV6Dv?=
 =?us-ascii?Q?QXQiGMnTl/b7xw9pkBPz8vphlyi3046Jgt7FXeVuzKfVurRnComCvItUjAPE?=
 =?us-ascii?Q?ze7laN7hATUfxjyCyKh0rZTl02MwZhVWkZ2ilCOr6bHSbQkCFeTpDepG3fzg?=
 =?us-ascii?Q?HKi/KXnSAS3P49hpqiRw7wyfNYL0VUAgq61kPA6cgfPctlmS/xJmlqXMi35f?=
 =?us-ascii?Q?zT7il/Sv46r0pn8tFKEx+BY/yp0BvCdzH2NpDnuNT0kAMK0YcHzuRendVngB?=
 =?us-ascii?Q?oY8i/zvcuTMIBV8gx9MstxXVBHd44CnzS1u3Z1Aa02AkdbOPgBjIB1Mfw80C?=
 =?us-ascii?Q?/9IJMat34L8DwI0TT+WUr2KkPwUHpUS+NLA+G+3zuSz+FbWmES5XhF1Wh3yS?=
 =?us-ascii?Q?QIpNm6NYX5DXYk0lBzQglsjk/v6Fic8KXbDm/7Vh3ChwpQ80MTtTsqe04QKF?=
 =?us-ascii?Q?n/iR4uY4QnHpAKPh6/Sbl7Jnq5DLh7B3rfp/yTxGOuPGSVdgFOONhPCJbNM0?=
 =?us-ascii?Q?WPydkcpY8wKtmCl+2X67Uj81P3G13vvAznqMp8XidD2mbIcV3ntG03hVyzVz?=
 =?us-ascii?Q?GgTdNyGNWHLtzZ4aOV1wJg46KpebLWY=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 130268a0-5fbf-426a-8ac9-08da536c04df
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jun 2022 09:54:23.1553
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: oWqjfehV/IL2QgS4upUdForRAHVFY89T8cSkhu3JJE/Fma727V3WPzUyhVzqKIIP2UiK16+ZcRzxa3oVPSDJIQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR04MB9427

Please update the commit log:

'''
This patch defines two new wrappers mptcp_sched_get_send() and
mptcp_sched_get_retrans(), invoke get_subflow() of msk->sched in them.
Use them instead of using mptcp_subflow_get_send() or
mptcp_subflow_get_retrans() directly.

Set the subflow pointers array in struct mptcp_sched_data before invoking
get_subflow(), then it can be used in get_subflow() in the BPF contexts.

Check the subflow scheduled flags to test which subflow or subflows are
picked by the scheduler.

Move sock_owned_by_me() and the fallback check code from
mptcp_subflow_get_send/retrans() into the wrappers.

Redundant subflows are not supported in __mptcp_subflow_push_pending()
yet. This patch adds a placeholder in mptcp_sched_get_send() to pick the
first subflow for the redundant subflows case.
'''

Signed-off-by: Geliang Tang <geliang.tang@suse.com>
---
 net/mptcp/protocol.c | 12 +++++----
 net/mptcp/protocol.h |  4 +--
 net/mptcp/sched.c    | 61 ++++++++++++++++++++++++++------------------
 3 files changed, 45 insertions(+), 32 deletions(-)

diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index a0f9f3831509..043ac3f222ed 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -1567,7 +1567,7 @@ void __mptcp_push_pending(struct sock *sk, unsigned int flags)
 			int ret = 0;
 
 			prev_ssk = ssk;
-			ssk = mptcp_sched_get_send(msk);
+			ssk = mptcp_subflow_get_send(msk);
 
 			/* First check. If the ssk has changed since
 			 * the last round, release prev_ssk
@@ -1628,13 +1628,13 @@ static void __mptcp_subflow_push_pending(struct sock *sk, struct sock *ssk)
 		info.limit = dfrag->data_len;
 		len = dfrag->data_len - dfrag->already_sent;
 		while (len > 0) {
-			int ret = 0;
+			int ret = 0, err = 0;
 
 			/* the caller already invoked the packet scheduler,
 			 * check for a different subflow usage only after
 			 * spooling the first chunk of data
 			 */
-			xmit_ssk = first ? ssk : mptcp_sched_get_send(mptcp_sk(sk));
+			xmit_ssk = first ? ssk : mptcp_sched_get_send(mptcp_sk(sk), &err);
 			if (!xmit_ssk)
 				goto out;
 			if (xmit_ssk != ssk) {
@@ -2438,7 +2438,7 @@ static void __mptcp_retrans(struct sock *sk)
 	mptcp_clean_una_wakeup(sk);
 
 	/* first check ssk: need to kick "stale" logic */
-	ssk = mptcp_sched_get_retrans(msk);
+	ssk = mptcp_subflow_get_retrans(msk);
 	dfrag = mptcp_rtx_head(sk);
 	if (!dfrag) {
 		if (mptcp_data_fin_enabled(msk)) {
@@ -3088,11 +3088,13 @@ void __mptcp_data_acked(struct sock *sk)
 
 void __mptcp_check_push(struct sock *sk, struct sock *ssk)
 {
+	int err = 0;
+
 	if (!mptcp_send_head(sk))
 		return;
 
 	if (!sock_owned_by_user(sk)) {
-		struct sock *xmit_ssk = mptcp_sched_get_send(mptcp_sk(sk));
+		struct sock *xmit_ssk = mptcp_sched_get_send(mptcp_sk(sk), &err);
 
 		if (xmit_ssk == ssk)
 			__mptcp_subflow_push_pending(sk, ssk);
diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
index bef7dea9f358..c4ce576458a2 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -634,8 +634,8 @@ void mptcp_subflow_set_scheduled(struct mptcp_subflow_context *subflow,
 				 bool scheduled);
 struct sock *mptcp_subflow_get_send(struct mptcp_sock *msk);
 struct sock *mptcp_subflow_get_retrans(struct mptcp_sock *msk);
-struct sock *mptcp_sched_get_send(struct mptcp_sock *msk);
-struct sock *mptcp_sched_get_retrans(struct mptcp_sock *msk);
+struct sock *mptcp_sched_get_send(struct mptcp_sock *msk, int *err);
+int mptcp_sched_get_retrans(struct mptcp_sock *msk);
 
 static inline bool __mptcp_subflow_active(struct mptcp_subflow_context *subflow)
 {
diff --git a/net/mptcp/sched.c b/net/mptcp/sched.c
index 8858e1fc8b74..5bd96ec5da5a 100644
--- a/net/mptcp/sched.c
+++ b/net/mptcp/sched.c
@@ -117,31 +117,46 @@ static int mptcp_sched_data_init(struct mptcp_sock *msk, bool reinject,
 	return 0;
 }
 
-struct sock *mptcp_sched_get_send(struct mptcp_sock *msk)
+struct sock *mptcp_sched_get_send(struct mptcp_sock *msk, int *err)
 {
+	struct mptcp_subflow_context *subflow;
 	struct mptcp_sched_data data;
 	struct sock *ssk = NULL;
-	int i;
 
+	*err = -EINVAL;
 	sock_owned_by_me((struct sock *)msk);
 
 	/* the following check is moved out of mptcp_subflow_get_send */
 	if (__mptcp_check_fallback(msk)) {
-		if (!msk->first)
-			return NULL;
-		return sk_stream_memory_free(msk->first) ? msk->first : NULL;
+		if (msk->first && sk_stream_memory_free(msk->first)) {
+			mptcp_subflow_set_scheduled(mptcp_subflow_ctx(msk->first), true);
+			*err = 0;
+			return msk->first;
+		}
+		return NULL;
 	}
 
-	if (!msk->sched)
-		return mptcp_subflow_get_send(msk);
+	if (!msk->sched) {
+		ssk = mptcp_subflow_get_send(msk);
+		if (!ssk)
+			return NULL;
+		mptcp_subflow_set_scheduled(mptcp_subflow_ctx(ssk), true);
+		*err = 0;
+		return ssk;
+	}
 
 	mptcp_sched_data_init(msk, false, &data);
 	msk->sched->get_subflow(msk, &data);
 
-	for (i = 0; i < MPTCP_SUBFLOWS_MAX; i++) {
-		if (data.contexts[i] && READ_ONCE(data.contexts[i]->scheduled)) {
-			ssk = data.contexts[i]->tcp_sock;
-			msk->last_snd = ssk;
+	mptcp_for_each_subflow(msk, subflow) {
+		if (READ_ONCE(subflow->scheduled)) {
+			/* TODO: Redundant subflows are not supported in
+			 * __mptcp_subflow_push_pending() yet. Here's a
+			 * placeholder to pick the first subflow for the
+			 * redundant subflows case.
+			 */
+			ssk = subflow->tcp_sock;
+			*err = 0;
 			break;
 		}
 	}
@@ -149,31 +164,27 @@ struct sock *mptcp_sched_get_send(struct mptcp_sock *msk)
 	return ssk;
 }
 
-struct sock *mptcp_sched_get_retrans(struct mptcp_sock *msk)
+int mptcp_sched_get_retrans(struct mptcp_sock *msk)
 {
 	struct mptcp_sched_data data;
 	struct sock *ssk = NULL;
-	int i;
 
 	sock_owned_by_me((const struct sock *)msk);
 
 	/* the following check is moved out of mptcp_subflow_get_retrans */
 	if (__mptcp_check_fallback(msk))
-		return NULL;
+		return -EINVAL;
 
-	if (!msk->sched)
-		return mptcp_subflow_get_retrans(msk);
+	if (!msk->sched) {
+		ssk = mptcp_subflow_get_retrans(msk);
+		if (!ssk)
+			return -EINVAL;
+		mptcp_subflow_set_scheduled(mptcp_subflow_ctx(ssk), true);
+		return 0;
+	}
 
 	mptcp_sched_data_init(msk, true, &data);
 	msk->sched->get_subflow(msk, &data);
 
-	for (i = 0; i < MPTCP_SUBFLOWS_MAX; i++) {
-		if (data.contexts[i] && READ_ONCE(data.contexts[i]->scheduled)) {
-			ssk = data.contexts[i]->tcp_sock;
-			msk->last_snd = ssk;
-			break;
-		}
-	}
-
-	return ssk;
+	return 0;
 }
-- 
2.35.3

