Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D33243230E;
	Fri, 24 Jul 2026 14:02:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784901769; cv=none; b=k/ol7djJMi4F7RgIdW4/gpDw65iwqzh7C3Rqnaf1eFmBoZYUYbVWnWMz2CujSUVMiV9HK6H5/geJOkN6VuLwUwOHwU/El1hg4OBR4trdUmC9gv1MuozLig5Fdn1JpYuviSgz3hocHs1XKfhEIWVNTbgZEqwwoZemroqz6IovUA0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784901769; c=relaxed/simple;
	bh=FGREC4W6Mh/CHWXFlthiI7UvopuXq/RVGFIwYGmO6W4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=WFdgHrDnq1m7IdGyOQ/c3ToTKl/Y3osBqpyyI51hIgsd69UL3XpHgxN0KGYB70W+qUzBE5kALcqVRFELhOClrk91K16ziQsurY6qf9E1K2s3WoPcSw+p53tdXb/vjmMTCf8sABDEDDF45sYedLfZAd/v3UeCx5ZcsnAMK/TvCcU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UcpZEdyh; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UcpZEdyh"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 725EB1F00A3D;
	Fri, 24 Jul 2026 14:02:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784901765;
	bh=36lAnMkjB07VIYCCBLdzVx8RoT1sIGgW6HHKCR5eWMg=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=UcpZEdyhat91TWRDwkFKUzDUIIAdLPG5fJH6W3uXjKWjvgc3HdQmk0cQu+gvR6+HO
	 N2c/fbL1wo7wGy5v4DBmKUrd82LgiliEi9vYOZOWpqOeW3PkWvZdd5QgI/rQYmSzIc
	 0rdt7sgBuy5uX1NU2q5yvFNrUmCHGqVUFnHsi9D4apGmDtbJVpaC/mL4p6v+7+z4U+
	 Mr11amWEc99fcqdwRGwZ++Z1G+3biN+krwslszSUwytQnwKI/73o5uP0rcAOs4BChC
	 4JeTCNx3nQDoBf/4vThIEFGibxEPX37wrt3YmcefZULykCs4iaYJ2/z6VN9d3M2grl
	 igosbsBDwo9dA==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Fri, 24 Jul 2026 16:02:16 +0200
Subject: [PATCH net-next 4/5] mptcp: enforce hard limit on backlog flushing
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260724-net-next-mptcp-oooq-pruning-v1-4-5dd4dec63a54@kernel.org>
References: <20260724-net-next-mptcp-oooq-pruning-v1-0-5dd4dec63a54@kernel.org>
In-Reply-To: <20260724-net-next-mptcp-oooq-pruning-v1-0-5dd4dec63a54@kernel.org>
To: Mat Martineau <martineau@kernel.org>, Geliang Tang <geliang@kernel.org>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Simon Horman <horms@kernel.org>
Cc: netdev@vger.kernel.org, mptcp@lists.linux.dev, 
 linux-kernel@vger.kernel.org, "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=2868; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=8oehzmC/Ja20Y/2KJD9sivd0mO9h5X8ufkiQiwQH0Fc=;
 b=owGbwMvMwCVWo/Th0Gd3rumMp9WSGLKSCyosFGPsFjp0+fAtvFGjs4mNedMBoR1Lu2dO3ri2N
 uC5ZLNxRykLgxgXg6yYIot0W2T+zOdVvCVefhYwc1iZQIYwcHEKwESOvGZkWNL3XuPrP+0QmXVf
 Vm755Nm6Yd7jvjYTM0fPUuPLpTdWazEy/AmJbJz+9HTUqZf+XHw3Vq3facpgP/1myKQc5tOzGLi
 jGAE=
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
index 5f7d8340a3d9..7f257419c5ea 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -2223,7 +2223,6 @@ static bool __mptcp_move_skbs(struct sock *sk, struct list_head *skbs, u32 *delt
 	struct mptcp_sock *msk = mptcp_sk(sk);
 	bool moved = false;
 
-	*delta = 0;
 	while (1) {
 		prefetch(skb->next);
 		list_del(&skb->list);
@@ -2260,20 +2259,12 @@ static bool mptcp_can_spool_backlog(struct sock *sk, struct list_head *skbs)
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
@@ -2281,8 +2272,8 @@ static bool mptcp_move_skbs(struct sock *sk)
 		enqueued |= __mptcp_move_skbs(sk, &skbs, &moved);
 
 		mptcp_data_lock(sk);
-		mptcp_backlog_spooled(sk, moved, &skbs);
 	}
+	WRITE_ONCE(msk->backlog_len, msk->backlog_len - moved);
 	mptcp_data_unlock(sk);
 
 	if (enqueued && mptcp_epollin_ready(sk))
@@ -3752,12 +3743,12 @@ static void mptcp_release_cb(struct sock *sk)
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
@@ -3790,9 +3781,9 @@ static void mptcp_release_cb(struct sock *sk)
 
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

