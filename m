Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F7F52F069D
	for <mptcp@lists.linux.dev>; Fri, 13 Mar 2026 01:43:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773366203; cv=none; b=pFiTYIS/Spmu58E9kmDBIzS5bFfGhN5GFHi2lXcWXCEkCs/ZlEtem2Tq5PwUEict+ODeDxjO7zaXnsuXFxjHx2GxMjl+UxxHgNhumD5Gj6KU+ZQlmO2HfveO8unT+b1QQHiy5g9DupEViub0prCFg2dLorQkN6p4cu8WB73iaRM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773366203; c=relaxed/simple;
	bh=47uypetk96GpSk+m+WFMeHEEHzARkkkKR2bV17xw7Xk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fu48C8p+hhNusuO0w/nQ5ic2uguVI7AqAhYmwKx/tznplqNAa4hjnND49CRQ5z8POKlTs9tf4nfIe/OVxni4K1H5VfQmfVv3nyFOfpsiWmCVb+2u4KGt8MrFyr6ofCIdt/y7gqye6s7h/EizUfqTEOn13lv1tIkMHWvGltgbego=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=W65CdR+p; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="W65CdR+p"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6866BC116C6;
	Fri, 13 Mar 2026 01:43:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773366202;
	bh=47uypetk96GpSk+m+WFMeHEEHzARkkkKR2bV17xw7Xk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=W65CdR+pBrxc5XpAOB3B0KhslrNpyhVCIMTLs9gy/oDMYgM3betZR/ACzpUDNjNZE
	 lllc8tSMo/j+IEU79MNo00RTnt6LRaPb+fqC+gmVB2u8TdawIeasZ5+nr2yKqsNkSU
	 d0UTgwsUnzOFhJh9DcWQ7LER0ACIO2d+b5/K36hStKMBxlWwtu6wkDkqb+5j4RvVsw
	 D38Owjj8cyP6cRDqrmNrzX1B8sxpiBypDH45sjLrrNr2AUuXNN4xw+Z9YgosK7g8Ka
	 Mq5/mCnSJFkXrUwkfpV522n9F677NYc7d3OM5GLcuxX5frGjKOxYh/aGm5eM0LBbaf
	 SoFfbEzPoQU+A==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>,
	Gang Yan <yangang@kylinos.cn>
Subject: [RFC mptcp-next v9 05/10] mptcp: avoid deadlocks in read_sock path
Date: Fri, 13 Mar 2026 09:42:47 +0800
Message-ID: <0c7c925402d4419989e7349c5099b4d80288df9c.1773365606.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <cover.1773365606.git.tanggeliang@kylinos.cn>
References: <cover.1773365606.git.tanggeliang@kylinos.cn>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Geliang Tang <tanggeliang@kylinos.cn>

When invoking mptcp_read_sock() from a softirq context (e.g., through
the TLS read_sock interface), calling lock_sock_fast() in
mptcp_rcv_space_adjust() or mptcp_cleanup_rbuf() can lead to deadlocks,
since the socket lock may already be held.

Replace lock_sock_fast() with spin_trylock_bh() in these functions to
make the locking attempt non-blocking. If the lock cannot be acquired,
skip the operation to avoid deadlock.

Also introduce mptcp_data_trylock() and use it in mptcp_move_skbs() to
make the data locking non-blocking in the read_sock path.

Co-developed-by: Gang Yan <yangang@kylinos.cn>
Signed-off-by: Gang Yan <yangang@kylinos.cn>
Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
---
 net/mptcp/protocol.c | 16 ++++++++--------
 net/mptcp/protocol.h |  1 +
 2 files changed, 9 insertions(+), 8 deletions(-)

diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index c0109338648a..fdfe6145f6da 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -557,12 +557,11 @@ static void mptcp_send_ack(struct mptcp_sock *msk)
 
 static void mptcp_subflow_cleanup_rbuf(struct sock *ssk, int copied)
 {
-	bool slow;
-
-	slow = lock_sock_fast(ssk);
+	if (!spin_trylock_bh(&ssk->sk_lock.slock))
+		return;
 	if (tcp_can_send_ack(ssk))
 		tcp_cleanup_rbuf(ssk, copied);
-	unlock_sock_fast(ssk, slow);
+	spin_unlock_bh(&ssk->sk_lock.slock);
 }
 
 static bool mptcp_subflow_could_cleanup(const struct sock *ssk, bool rx_empty)
@@ -2152,14 +2151,14 @@ static void mptcp_rcv_space_adjust(struct mptcp_sock *msk, int copied)
 		 */
 		mptcp_for_each_subflow(msk, subflow) {
 			struct sock *ssk;
-			bool slow;
 
 			ssk = mptcp_subflow_tcp_sock(subflow);
-			slow = lock_sock_fast(ssk);
+			if (!spin_trylock_bh(&ssk->sk_lock.slock))
+				continue;
 			/* subflows can be added before tcp_init_transfer() */
 			if (tcp_sk(ssk)->rcvq_space.space)
 				tcp_rcvbuf_grow(ssk, copied);
-			unlock_sock_fast(ssk, slow);
+			spin_unlock_bh(&ssk->sk_lock.slock);
 		}
 	}
 
@@ -2232,7 +2231,8 @@ static bool mptcp_move_skbs(struct sock *sk)
 	bool enqueued = false;
 	u32 moved;
 
-	mptcp_data_lock(sk);
+	if (!mptcp_data_trylock(sk))
+		return false;
 	while (mptcp_can_spool_backlog(sk, &skbs)) {
 		mptcp_data_unlock(sk);
 		enqueued |= __mptcp_move_skbs(sk, &skbs, &moved);
diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
index f5d4d7d030f2..3146e26687b4 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -378,6 +378,7 @@ struct mptcp_sock {
 };
 
 #define mptcp_data_lock(sk) spin_lock_bh(&(sk)->sk_lock.slock)
+#define mptcp_data_trylock(sk) spin_trylock_bh(&(sk)->sk_lock.slock)
 #define mptcp_data_unlock(sk) spin_unlock_bh(&(sk)->sk_lock.slock)
 
 #define mptcp_for_each_subflow(__msk, __subflow)			\
-- 
2.53.0

