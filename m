Received: from EUR04-DB3-obe.outbound.protection.outlook.com (mail-eopbgr60082.outbound.protection.outlook.com [40.107.6.82])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 353F733EC
	for <mptcp@lists.linux.dev>; Tue, 27 Sep 2022 15:26:31 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=X6kZGkjzgbxNtuxXUQGrzcAFGitMKg27J8YHWHpCmbpIDm766UCH7PHxEdNs7JYC5us48JgU/mYdGXZj6BSHvpU9HgzktbPRz0kvRGNnphkaLT+oHh7Vl4wenYujA7JOY0ZSsnenQEyRqz3ke3kABErZuXNv6Ldy+CAJYxMNBaV3x4Ll15J++AJehW4XbEZQZVWrArtlKPtoELQt4nXvZj0OQ/RdV9JU/V+BVvymdVPjBMN+hMImA1Z4sERdQ4BnhsiqmQk++XBOBgitnGJhxbp8TAamnMyx8CrPP/g5VGQMRSWdqQnJ3KJkaEP9zDrha1spSdp5Z3nqqUw3u/xyqQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Hu+ct6f4/9o/sk77C/yzy2NsMVwXXv6K1BgmuvJNYng=;
 b=aBNIImIaYJa4fS8CXhVuLnBKNdM0IJeyaUHnh7LCxpiKkbgMNOaMxMnwotiTkrj0zqsNnMR2KykEWkABwOD6C4dI0ora0wE6QxO9nLhxo4XQYCH0xqdNgprWSQTueM4m2oK4b1yxwV89i6gW/62KJ9FQoKlEbXg72Xv2UeeJtPA0mT7vjtlTKq7973IwMJbp2BaaTxSfmQzoGjoyCG4n+e7uYxzQRMGUNFE7opUhigWR4kSj3lnseA7uBMHmcPloFOuE6p1BLOkTlQ3OWatES8m3nNzWvXCw0zXRYwj6fOfZ/9XF/9Vo/cCclzI102+VRdIAwppBZ15JPpyXa9QfBw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Hu+ct6f4/9o/sk77C/yzy2NsMVwXXv6K1BgmuvJNYng=;
 b=ZLB2S/ZZGYIG+MhZJRg42J+dGOio8C1wRtobVJhLZKTBOlRuBoKLZAjuSgfah2vRJlbjE/w391fa3JCMp7kW6VJvbva5joYL5k7PwBdRm+IPDC69gcrFmgnldpp6QfHI2CMXi33JQkZkgmp0C8Rx+lyKyuC5JDggqNpoF/aYhvtBq4m/U1ld5amP0uDYUc6Rfs5GhX8UpmKbUubGKoEtCJcv57d2VfrLiOmtkooeaMKkT+VAh4tPKzfswIfquvWTVD0YhtgdNBEdSnRzdCWKivuAeMWvWMw5RAxmgEeRoNArwMDAOEJyOpywH8r2PfoKy4MxERQOtSWD8nvudjVmhA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by VI1PR04MB7087.eurprd04.prod.outlook.com (2603:10a6:800:12a::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5654.26; Tue, 27 Sep
 2022 15:26:28 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::e936:9fd1:22e7:97d1]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::e936:9fd1:22e7:97d1%5]) with mapi id 15.20.5654.019; Tue, 27 Sep 2022
 15:26:28 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next v12 1/5] Squash to "mptcp: add get_subflow wrappers"
Date: Tue, 27 Sep 2022 23:27:00 +0800
Message-Id: <7d93daa96520afbc4181daea2385af64d4d69bb1.1664291273.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <cover.1664291273.git.geliang.tang@suse.com>
References: <cover.1664291273.git.geliang.tang@suse.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR01CA0003.apcprd01.prod.exchangelabs.com
 (2603:1096:4:191::16) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HE1PR0402MB3497:EE_|VI1PR04MB7087:EE_
X-MS-Office365-Filtering-Correlation-Id: aac87786-f330-4ecb-2374-08daa09ca5d6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	MKqtzf2QR5mGL5ftrCdhddGvB4rewounLRr/vLI0WYDgtFll4Z5xi6ozXcouLahBvHYhqedyn41S4f7QEpODioF7kpDuEcHwa1r2peSpeJ5METRNr0AxKIGx99zSvqy/7FFNyDsS4d8+8zvgO6YCp4t93Pv2nPdbB8KuU90dGBkO1PN55/VzE/Q6Pj+pTCAqnTqasa8FivKxd0OP5XbqaacA2x6ORqlOL6N81RyECFyOQSnWG+CSvMhwfwivnTzIRXxkOTwkAyax//EwuGIgn5+/dSt2yOwQ53v2hxiAuOS2w2BkVP7+mXooI9i93t9tLQP5uoEoJ8hyYK+SrVWHWhq4MuuXHkimrVWk2PwKIjyXsGO/Q5lc2b5w/Gzf32IToGPxU6C+l5s342rIGj3F4TgCDXUagtN7BJXqia5ucK+JCxJKQEXagtvJxyNs55xb6atVdh/X0Ay/mkMWoLhLs9j/v7aN47G5kx4s0a0Auq5mfIa30hZVf0aXNBiEEvSZTSp+qARwP6a93zkROGDHK212xkaQoZPu4FazxXL+A7I+j7MrHcjJY/3xNBx4evfSX0jvM8zDBzGBmEUpO4YJWH7+je0QzfEpGPIzXJzk89ucHXxADYZVik88Qs3krDY3v/Y3qeEwEfay9sRxtiFVo9HcLHRKD3Nyb5zp7DWUeIzz6YQCBx8Uo19K1mC2MToonXnJgmSkkABogYf8xbZnw2ZNFJ7mLETRGkF+6u0CZhVOLqdJyESUVAm/Ux2rxt7a
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(366004)(346002)(136003)(376002)(39860400002)(396003)(451199015)(38100700002)(6486002)(6666004)(107886003)(6506007)(316002)(66946007)(66476007)(66556008)(83380400001)(4326008)(8676002)(86362001)(26005)(2906002)(6512007)(44832011)(478600001)(41300700001)(36756003)(186003)(6916009)(2616005)(5660300002)(8936002)(13296009);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?giXj0bXy/e80EKbqF4tjs9LcO+ifvI/2CWVikLoo4naC7Uuy6ss4HFlEB8Am?=
 =?us-ascii?Q?Z6CLiRPHX1i+SBxYw+N1pPwrM4TyWaR110DzBc30NZywaVE5381fWQv6ffvl?=
 =?us-ascii?Q?0l27yUQZNmMH011BCogngW2TLAxUT5OYTFTX33QrBDfPtShYpY8yNQiGaUXG?=
 =?us-ascii?Q?t4I5Q+Be8HGnDjJYjfaPKzcyfn+YCALe1LNUM+nMiqRYC2MKwbd7C87K1aFd?=
 =?us-ascii?Q?AAIj2tOKwHI5UMZOuSuv8Gv0CoqVcTaepaV9baFdYRBsZwponsAJJExlItjp?=
 =?us-ascii?Q?vNJwPbD46R7Kv3qfItd4oSXte3Di6j5g0gHShdijbF3e7O/Z+ouKbIMWBcgH?=
 =?us-ascii?Q?KAMKBjaDJcEpdX8mb8MCuc3RPgxxuc8BBxkiLPXzQFsaW1D7h3z2BQ9OKDO6?=
 =?us-ascii?Q?oKez0bCx4MNCeeUCYvRVsA+PDTp6EQ+/HwRUkyA0Or8vBVyBj1fGbjd3H7rp?=
 =?us-ascii?Q?smRWI3Uz+LRW1QkFQVaMiABNQNO9UcRwAa+Y7B0QD5JlwScG+yzE2jsqMwqy?=
 =?us-ascii?Q?tZ7269UeiU0yrVuy6QOELPaXL7+hfS4kw1BPj2/ZXh5Vyk3UfCAOYqcZJWVt?=
 =?us-ascii?Q?ykDtOIDORHxI6PmYSBymPBvRWURL/pRRuBsNl7rBUbzkLb7YjuwEht3Z0UPn?=
 =?us-ascii?Q?aSFWjCFOF/qe+gVZFAYHnf5fdZiFYIcVgIdI83GYuprI1On+ttHJOCuiqOQA?=
 =?us-ascii?Q?RG+RIKZ3mgssbTyJoCzPOR7Vm9VwyXZ0eU3zD7V77pM+sRU1w/pKBnGLNMU6?=
 =?us-ascii?Q?x1jaGIbccLzxaOadZ6W0+/AHl0KopdIKq7H33XBia92l06trf+aG1/5x4J1c?=
 =?us-ascii?Q?I1cWRaNTnH+/DBc8jsI+deZu5XTDFPXvunjs64uvFhU4aeMRvbOHnPRzPiFd?=
 =?us-ascii?Q?yvDFjYE9pwJeZxUnbuHFfui7B6Aba8S3l/L2djGUHGYBL5PzIO6MfKCC/IP9?=
 =?us-ascii?Q?QQdOWsvLbG5sxFZLlGxwx1iGGkXhGJpf7ujkdm3un0kJ8RsQmziqMh+rHl+m?=
 =?us-ascii?Q?3cLSSVQTGr4dC10zyvn1uTFwpy7ydKGETrOWWOl+ptHC0F7y8fiJiOOtMk2r?=
 =?us-ascii?Q?hdWe+yjoQDCs9U8vMgeP+vmeyQUbGV6pfc6MFDwOfWQhJCVuPEFg543rwqLr?=
 =?us-ascii?Q?RMuA+o295D6vRyM7n6wI9Zhq7wq7jnpGERduVeZVz8QBEgISfsO1gPVSjzp8?=
 =?us-ascii?Q?bsNcq+VaW284hdF74+BsTV1ZSMuh/vBadnLcMaarZjvZsf51Uyea+me4QHlE?=
 =?us-ascii?Q?M6t0gWkCRZ4r5JhPWma4Vkp9bX6nWGbeRsxsddny9nP296Uc9m4VCspYmH04?=
 =?us-ascii?Q?E0mWecGiFaE5LB3F4nzWPxd+9NxWhkD18Ye0Ly71KWdbSWramqZpfkMA7nfr?=
 =?us-ascii?Q?5enGv7RlnHcWurF3zQmBrHhzA912nEvAOF6JBIaK0hWqYXzkbjKBf72T2+lh?=
 =?us-ascii?Q?UbmRdwtmUhLs4iPXBbk2jH7QuWQT4hA1oLUk9aAF71ukZ+ootkorBi0QkVSP?=
 =?us-ascii?Q?2eSHNkoiH4AYyapnFoCj4tN7ZSZJREt/quOf0Uj4JYQt4Kv3t3k7sKsClcLw?=
 =?us-ascii?Q?CuPPRTgB7qgNzr58zIeRqBP4H8KtimOfjfzP7nNz?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: aac87786-f330-4ecb-2374-08daa09ca5d6
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Sep 2022 15:26:28.6775
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fhx7Cq5FsGpA9Hcg6rRrVzgEF6OyAMDO5cHRjroxXsxx6PA1tqhAQ72QyIkAk/dr3XvKDl6cyLbonmjOBqZBmw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB7087

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
 net/mptcp/protocol.c |  4 +--
 net/mptcp/protocol.h |  2 +-
 net/mptcp/sched.c    | 59 +++++++++++++++++++++++++-------------------
 3 files changed, 37 insertions(+), 28 deletions(-)

diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index 8feb684408f7..e5c5173108e4 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -1547,7 +1547,7 @@ void __mptcp_push_pending(struct sock *sk, unsigned int flags)
 			int ret = 0;
 
 			prev_ssk = ssk;
-			ssk = mptcp_sched_get_send(msk);
+			ssk = mptcp_subflow_get_send(msk);
 
 			/* First check. If the ssk has changed since
 			 * the last round, release prev_ssk
@@ -2478,7 +2478,7 @@ static void __mptcp_retrans(struct sock *sk)
 	mptcp_clean_una_wakeup(sk);
 
 	/* first check ssk: need to kick "stale" logic */
-	ssk = mptcp_sched_get_retrans(msk);
+	ssk = mptcp_subflow_get_retrans(msk);
 	dfrag = mptcp_rtx_head(sk);
 	if (!dfrag) {
 		if (mptcp_data_fin_enabled(msk)) {
diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
index 93c535440a5c..79313476ac59 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -641,7 +641,7 @@ void mptcp_subflow_set_scheduled(struct mptcp_subflow_context *subflow,
 struct sock *mptcp_subflow_get_send(struct mptcp_sock *msk);
 struct sock *mptcp_subflow_get_retrans(struct mptcp_sock *msk);
 struct sock *mptcp_sched_get_send(struct mptcp_sock *msk);
-struct sock *mptcp_sched_get_retrans(struct mptcp_sock *msk);
+int mptcp_sched_get_retrans(struct mptcp_sock *msk);
 
 static inline bool __tcp_can_send(const struct sock *ssk)
 {
diff --git a/net/mptcp/sched.c b/net/mptcp/sched.c
index 044c5ec8bbfb..cff538a9e187 100644
--- a/net/mptcp/sched.c
+++ b/net/mptcp/sched.c
@@ -114,35 +114,48 @@ static int mptcp_sched_data_init(struct mptcp_sock *msk, bool reinject,
 	for (; i < MPTCP_SUBFLOWS_MAX; i++)
 		data->contexts[i] = NULL;
 
+	msk->snd_burst = 0;
+
 	return 0;
 }
 
 struct sock *mptcp_sched_get_send(struct mptcp_sock *msk)
 {
+	struct mptcp_subflow_context *subflow;
 	struct mptcp_sched_data data;
 	struct sock *ssk = NULL;
-	int i;
 
 	sock_owned_by_me((struct sock *)msk);
 
 	/* the following check is moved out of mptcp_subflow_get_send */
 	if (__mptcp_check_fallback(msk)) {
-		if (!msk->first)
-			return NULL;
-		return __tcp_can_send(msk->first) &&
-		       sk_stream_memory_free(msk->first) ? msk->first : NULL;
+		if (msk->first &&
+		    __tcp_can_send(msk->first) &&
+		    sk_stream_memory_free(msk->first)) {
+			mptcp_subflow_set_scheduled(mptcp_subflow_ctx(msk->first), true);
+			return msk->first;
+		}
+		return NULL;
 	}
 
-	if (!msk->sched)
-		return mptcp_subflow_get_send(msk);
+	if (!msk->sched) {
+		ssk = mptcp_subflow_get_send(msk);
+		if (ssk)
+			mptcp_subflow_set_scheduled(mptcp_subflow_ctx(ssk), true);
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
 			break;
 		}
 	}
@@ -150,31 +163,27 @@ struct sock *mptcp_sched_get_send(struct mptcp_sock *msk)
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

