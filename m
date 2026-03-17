Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C58735A389
	for <mptcp@lists.linux.dev>; Tue, 17 Mar 2026 09:13:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773738822; cv=none; b=HjJwLJpNx/PjgQVLn/VEb6BqWIXZsg0Z66axJV+xkPRDLhE5Xy3K02vWaYjTYw6UWKN+jgFX5qw6CRsrUU/3LF0K2RN4kPZBH56ZfEMb91VzGVkTnzEi7IMEqv22tYao51eRBDUJZVd9P3Xv/1gzSGwyYEiniUNrABaUHL3ofqk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773738822; c=relaxed/simple;
	bh=+YJMWzBa+SbUbHxydiURNRfqH3ZTcgWPX4vlh9xC+/g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ULwUQccSghnMqNzzy5vBFVwSFUYxyLrHbP9OQdDWwVZ2qxZPhT0uSpV/CMDXPVo1+t6V5C4R0lXzxM69ExCzJNQiwLI1FB80Upt73UrHjku97DA+B7mttdtNyntfb9nhlMg2Anj9uJg5NpcTWtQzLYwqxnBkvGji5EheIwiI8Ns=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=q7DHi0ZP; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="q7DHi0ZP"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 18082C19425;
	Tue, 17 Mar 2026 09:13:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773738822;
	bh=+YJMWzBa+SbUbHxydiURNRfqH3ZTcgWPX4vlh9xC+/g=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=q7DHi0ZPJgnS2vRk5QfUbUo0R+cwzu/6iw/uEb6D1Gqba3jHddS4iakB97k2JhvAM
	 ePpN83nJdhGmPHKQX7h66aWqQihC3g7Uq/vB6t3g3Plbrvh29gdpZ98YXbkBNcD6h0
	 +3B1ZhU2KP5kEp6uE8aGxEiiJByrdNVseSTe0LviRh2XkL6Q92l+ikS012LuRL7frl
	 OZCHrczKND4RcbIILwNmm0uyQpBdAbX2/zPLsf+Gp/+QsyEQYvviSO4MX/gbrjBC/h
	 3wD3+hOC+B0RuEBkSYiIdBWyyFyI1blaJ480BsUOSyaDsbzR+h0ls1XEMXpt0Kl452
	 Ysc0OS3tPNgFA==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>,
	Gang Yan <yangang@kylinos.cn>
Subject: [RFC mptcp-next v10 05/14] mptcp: avoid sleeping in read_sock path under softirq
Date: Tue, 17 Mar 2026 17:12:41 +0800
Message-ID: <caab283952b11c4290f8da4bffde84c791dbe06b.1773737371.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <cover.1773737371.git.tanggeliang@kylinos.cn>
References: <cover.1773737371.git.tanggeliang@kylinos.cn>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Geliang Tang <tanggeliang@kylinos.cn>

When mptcp_read_sock() is called from softirq context via TLS
read_sock, lock_sock_fast() in mptcp_rcv_space_adjust() and
mptcp_cleanup_rbuf() may trigger might_sleep() warnings or
illegal sleeps, as softirq context cannot block.

Replace lock_sock_fast() with spin_trylock_bh() to make locking
non-blocking and context-safe. Skip operations if the lock cannot
be acquired.

Also introduce mptcp_data_trylock() in mptcp_move_skbs() to make
data locking non-blocking in the read_sock path.

Co-developed-by: Gang Yan <yangang@kylinos.cn>
Signed-off-by: Gang Yan <yangang@kylinos.cn>
Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
---
 net/mptcp/protocol.c | 21 +++++++++++----------
 net/mptcp/protocol.h |  1 +
 2 files changed, 12 insertions(+), 10 deletions(-)

diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index 5585f43cf879..1903f5b1fc44 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -561,12 +561,11 @@ static void mptcp_send_ack(struct mptcp_sock *msk)
 
 static void mptcp_subflow_cleanup_rbuf(struct sock *ssk, int copied)
 {
-	bool slow;
-
-	slow = lock_sock_fast(ssk);
-	if (tcp_can_send_ack(ssk))
+	if (!spin_trylock_bh(&ssk->sk_lock.slock))
+		return;
+	if (!sock_owned_by_user(ssk) && tcp_can_send_ack(ssk))
 		tcp_cleanup_rbuf(ssk, copied);
-	unlock_sock_fast(ssk, slow);
+	spin_unlock_bh(&ssk->sk_lock.slock);
 }
 
 static bool mptcp_subflow_could_cleanup(const struct sock *ssk, bool rx_empty)
@@ -2194,14 +2193,15 @@ static void mptcp_rcv_space_adjust(struct mptcp_sock *msk, int copied)
 		 */
 		mptcp_for_each_subflow(msk, subflow) {
 			struct sock *ssk;
-			bool slow;
 
 			ssk = mptcp_subflow_tcp_sock(subflow);
-			slow = lock_sock_fast(ssk);
+			if (!spin_trylock_bh(&ssk->sk_lock.slock))
+				continue;
 			/* subflows can be added before tcp_init_transfer() */
-			if (tcp_sk(ssk)->rcvq_space.space)
+			if (!sock_owned_by_user(ssk) &&
+			    tcp_sk(ssk)->rcvq_space.space)
 				tcp_rcvbuf_grow(ssk, copied);
-			unlock_sock_fast(ssk, slow);
+			spin_unlock_bh(&ssk->sk_lock.slock);
 		}
 	}
 
@@ -2299,7 +2299,8 @@ static bool mptcp_move_skbs(struct sock *sk)
 	bool enqueued = false;
 	u32 moved;
 
-	mptcp_data_lock(sk);
+	if (!mptcp_data_trylock(sk))
+		return false;
 	while (mptcp_can_spool_backlog(sk, &skbs)) {
 		mptcp_data_unlock(sk);
 		enqueued |= __mptcp_move_skbs(sk, &skbs, &moved);
diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
index f0eaba2c61fa..7d8531837736 100644
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

