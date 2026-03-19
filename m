Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64AB3379999
	for <mptcp@lists.linux.dev>; Thu, 19 Mar 2026 10:09:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773914947; cv=none; b=jBIWqlcg7ZwnVOXFIDwo+k7RToVikVwbKLC55NgixKMcNE28lggo+/L7mRPZYpx9RsV0gNepVqBzD7Ua8Q7hnk/THDISKzcR7W2Yw1DtrkFZmUcE6gHaHL4FswbUDoIy8rmXnWJpkot3cE0psLJtPuZv3Tfjx+tYhmj/r1uKPPU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773914947; c=relaxed/simple;
	bh=g0QtebIG9KnPGBWOJY5HMZ/sRaDgRN7bFJpZ1zwo4H8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pJpbC+qnCknbXE7sgB+aYV73MwzF+EyMW7tiYaCPZTmfhFTN8PJyIZzmnZYZ4rmRm91Ak9JD1T2ioM7Qq64IbyHEwCKOXQZGys+GvVyfGVkp/KOKHFTpJioeT0r7bJGgNsxSzhsJekM2Zh9C7Tsvve45fZnKqCg6YXOw3bhutOs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iKIrJyXa; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iKIrJyXa"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8C2ECC2BC87;
	Thu, 19 Mar 2026 10:09:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773914947;
	bh=g0QtebIG9KnPGBWOJY5HMZ/sRaDgRN7bFJpZ1zwo4H8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=iKIrJyXaza988hBpj5Fhsb9DMi9RxFnIb4v5QrdWDxn8RnOTIBiHk5hOZqoibQ755
	 at4Ta1UmitSa6UV17e7HZLvF6ExCQnheJlRByaHJYFh9EWWxfwlfv+d37JnXgB3/mO
	 MuY2/rYUdkd9RHVc9x2n3eRNR+Rl6OQO4HWLmbwVNRq4eKfrKgyzHQ33Afv64frWPF
	 +GtTvGK0dh+O0umsuDv2/vX8bD6XVAGFE3o//x03uAMY5rEjLBgJapRq920ZdK7Ioy
	 4hzDmpU813588Uz7zyAZGr9d6yO5ogLo0q7b3wla2+GpWwm/e/psHNn3s+c0TjLWEc
	 H43F3cwN2fflQ==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>,
	Gang Yan <yangang@kylinos.cn>
Subject: [RFC mptcp-next v11 05/15] mptcp: avoid sleeping in read_sock path under softirq
Date: Thu, 19 Mar 2026 18:08:38 +0800
Message-ID: <b7b6fd287877f7b2cb585c3b552ef0925da41858.1773911536.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <cover.1773911536.git.tanggeliang@kylinos.cn>
References: <cover.1773911536.git.tanggeliang@kylinos.cn>
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

Co-developed-by: Gang Yan <yangang@kylinos.cn>
Signed-off-by: Gang Yan <yangang@kylinos.cn>
Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
---
 net/mptcp/protocol.c | 18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index 5585f43cf879..e9e40dfab5ea 100644
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
 
-- 
2.53.0

