Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7C75305664;
	Fri,  7 Aug 2026 13:50:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786110645; cv=none; b=LIHIvE6RcJMexzgy4uzdrMxzXHh1/lWJa7wfqKULiJYtCT4ggYApMGkpTvrZFvunp+GeJP2TLYzSOUNb6xVRKDWklgyLD9lE7YAZ+3jsCkYEsSKrlogL2swEv5e7afrPMCwpbZvcBQscFKEfoFJjR0/nFCUipZzyIPHJKQdQFMI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786110645; c=relaxed/simple;
	bh=ALznjQGtvoVBcalJJYwM8tV/AS3Bp4YJ4oVXijUXRTI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=lYLtM8Dh2DiAxUGMqbPKnWPe1pd8q5Q55DA+tNhrZ4Tu7I2GdXeoY2+y+FQvzIzA+gPDKJYgU/A+P0017il3b6uh7PmR58wVD8fPNFXDPICHPaG8HDc3vHrHHNy6aMIE+ri6HuiadjOjWsqlp25nGYTLzNZGT1gRyXTgnknhegQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KFZJqFuV; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KFZJqFuV"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 987E31F0155B;
	Fri,  7 Aug 2026 13:50:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786110637;
	bh=4fQDsfPXPmXQvaEjhBOAK4eluE7WFeO4u3lOgWyfu2k=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=KFZJqFuVnYEP38WE3WZNVpxhxlHGlGMp0ONOgntWlG0RiRnF/B/UsFQSOYym8yN7M
	 UkJ2L0S4cbQGnvHGcr15dQnpNVtK99PptzBmMhnYvJsJswThqtKvqOcQ79WJVMfYLV
	 HCuzDqENg8vRv/tC4U91B5zbw93cdyl9aFa4CY72fPp7pbzn3G3a2AtdpJ1Ls65orb
	 owr7UAWpBslQzbir30XpQ+mzMGjcKdN9eIDM3LM8kvcbI557jaoxiQOcRJLOfA/E0P
	 Tt1FWjtpfV2OzMivpc43JoKhQI5nqeqxOynKtSN2RFupYLsbH/SilzsDSTcAfyHGKS
	 okAzBjXW+RCxA==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Fri, 07 Aug 2026 15:49:05 +0200
Subject: [PATCH net-next v3 5/7] mptcp: enforce hard limit on backlog
 flushing
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260807-net-next-mptcp-oooq-pruning-v3-5-dbc1eb853cc3@kernel.org>
References: <20260807-net-next-mptcp-oooq-pruning-v3-0-dbc1eb853cc3@kernel.org>
In-Reply-To: <20260807-net-next-mptcp-oooq-pruning-v3-0-dbc1eb853cc3@kernel.org>
To: Mat Martineau <martineau@kernel.org>, Geliang Tang <geliang@kernel.org>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Simon Horman <horms@kernel.org>
Cc: netdev@vger.kernel.org, mptcp@lists.linux.dev, 
 linux-kernel@vger.kernel.org, "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2868; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=nO7DO4LcT9hCk2u8lAWi1GUEiA1x94V/H3xv1e2WLkM=;
 b=owGbwMvMwCVWo/Th0Gd3rumMp9WSGLJKH837fPzqm443DU1Buf3z2Fb1zq0NXvFz93k3gU+aK
 W0qVRwpHaUsDGJcDLJiiizSbZH5M59X8ZZ4+VnAzGFlAhnCwMUpABNZt4WRYcIzAduYrrP8lWHv
 raec2PY3nuVo2EolT2Xx3A1TPB6VvGNkaEz2XXRPyX3Zip+WOd8faHvpqNa9fRUjElTM9WR2aXw
 7FwA=
X-Developer-Key: i=matttbe@kernel.org; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

From: Paolo Abeni <pabeni@redhat.com>

Currently a wild producer could keep the backlog flushing operation
spinning for an unbound time.

Since the previous patch, the amount of data present in the backlog is
hard-limited. Move the backlog len update at the end of the flush loop to
prevent it spinning forever.

Also, no need to splice back the remaining skbs list into the backlog, as
such list is always empty after each backlog processing loop.

Signed-off-by: Paolo Abeni <pabeni@redhat.com>
Reviewed-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
 net/mptcp/protocol.c | 21 ++++++---------------
 1 file changed, 6 insertions(+), 15 deletions(-)

diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index cfb77a32518a..d96fbdc34dbb 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -2229,7 +2229,6 @@ static bool __mptcp_move_skbs(struct sock *sk, struct list_head *skbs, u32 *delt
 	struct mptcp_sock *msk = mptcp_sk(sk);
 	bool moved = false;
 
-	*delta = 0;
 	while (1) {
 		prefetch(skb->next);
 		list_del(&skb->list);
@@ -2266,20 +2265,12 @@ static bool mptcp_can_spool_backlog(struct sock *sk, struct list_head *skbs)
 	return true;
 }
 
-static void mptcp_backlog_spooled(struct sock *sk, u32 moved,
-				  struct list_head *skbs)
-{
-	struct mptcp_sock *msk = mptcp_sk(sk);
-
-	WRITE_ONCE(msk->backlog_len, msk->backlog_len - moved);
-	list_splice(skbs, &msk->backlog_list);
-}
-
 static bool mptcp_move_skbs(struct sock *sk)
 {
+	struct mptcp_sock *msk = mptcp_sk(sk);
 	struct list_head skbs;
 	bool enqueued = false;
-	u32 moved;
+	u32 moved = 0;
 
 	mptcp_data_lock(sk);
 	while (mptcp_can_spool_backlog(sk, &skbs)) {
@@ -2287,8 +2278,8 @@ static bool mptcp_move_skbs(struct sock *sk)
 		enqueued |= __mptcp_move_skbs(sk, &skbs, &moved);
 
 		mptcp_data_lock(sk);
-		mptcp_backlog_spooled(sk, moved, &skbs);
 	}
+	WRITE_ONCE(msk->backlog_len, msk->backlog_len - moved);
 	mptcp_data_unlock(sk);
 
 	if (enqueued && mptcp_epollin_ready(sk))
@@ -3747,12 +3738,12 @@ static void mptcp_release_cb(struct sock *sk)
 	__must_hold(&sk->sk_lock.slock)
 {
 	struct mptcp_sock *msk = mptcp_sk(sk);
+	u32 moved = 0;
 
 	for (;;) {
 		unsigned long flags = (msk->cb_flags & MPTCP_FLAGS_PROCESS_CTX_NEED);
 		struct list_head join_list, skbs;
 		bool spool_bl;
-		u32 moved;
 
 		spool_bl = mptcp_can_spool_backlog(sk, &skbs);
 		if (!flags && !spool_bl)
@@ -3785,9 +3776,9 @@ static void mptcp_release_cb(struct sock *sk)
 
 		cond_resched();
 		spin_lock_bh(&sk->sk_lock.slock);
-		if (spool_bl)
-			mptcp_backlog_spooled(sk, moved, &skbs);
 	}
+	if (moved)
+		WRITE_ONCE(msk->backlog_len, msk->backlog_len - moved);
 
 	if (__test_and_clear_bit(MPTCP_CLEAN_UNA, &msk->cb_flags))
 		__mptcp_clean_una_wakeup(sk);

-- 
2.53.0

