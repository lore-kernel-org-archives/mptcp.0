Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7F77157A72
	for <mptcp@lists.linux.dev>; Mon,  7 Jul 2025 09:34:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751880899; cv=none; b=nOrsGflbw/wmyiRkrHzjSkr5YYR12hUFBqI8ZeKtzfnSqXl/Ex6EJS50Iyp88NTufo7rOH7mUolEl9sKXnoCLXHkLa8RBzdAneKFY+wBi+xzP2WKoNXyGFfpo9DZVlH+NkyatSoEcjGzitAd23hHSwG0ikK4561OiblrWb0ztm4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751880899; c=relaxed/simple;
	bh=P3+6H/qR0lnek7JEqRJCQKTskq8zuNWmw8BVjE+jRhg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hiTXYcbEEYKn0QASbCeC4p4qq3Z2HTbLxJHJkUbuz2OTOC+Mfe7LYjnZ2bajb6nUwLGDMJeZn/lSa55CtCWxo3ouCA3/M/jS3PeTBBih89HAnYa6UJAmQoxS9MfntyRAzqNeUR8+Rw02YRE2Uff2bXB7hObqE5y/BdlYoZuQef8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=R0IM3Uoo; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="R0IM3Uoo"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E27AAC4CEEF;
	Mon,  7 Jul 2025 09:34:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751880899;
	bh=P3+6H/qR0lnek7JEqRJCQKTskq8zuNWmw8BVjE+jRhg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=R0IM3UooZHgX+2jJPvbnGGXktovh5GreB3QbbG8pLug2ww9kQtjbMOpCaD0VwMIb0
	 ygabaYKPjqdlr+jdL4m4HAg9YsI+DqkUaXaKNVa8cBN4glhJuIb+sAqnuKeWMZTlzr
	 VuGvGDZvVXe+l6PxNgEa4RMOmtKDCcM/RJC6mEsBzNg097AWS7C6Wl4ysIlqIHa9Z2
	 zgg37c9B6MiwlqVzoIZc8cOiB07gOF6jYTwJhVedpoBIEsehYeF2A1slakfnn04mzn
	 P7AMZmZCNhPt6wF5MHYEbuuCOmImwEAz4RZdRBImDq1sM6Zz4sanvMjgwu12oOxS8K
	 uOAIwPKW7Mceg==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev,
	pabeni@redhat.com,
	hare@kernel.org
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next v7 1/4] mptcp: add eat_recv_skb helper
Date: Mon,  7 Jul 2025 17:34:47 +0800
Message-ID: <ff22a025274ee8b8ff16d0963f27065662b3a903.1751880561.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <cover.1751880561.git.tanggeliang@kylinos.cn>
References: <cover.1751880561.git.tanggeliang@kylinos.cn>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Geliang Tang <tanggeliang@kylinos.cn>

This patch extracts the free skb related code in __mptcp_recvmsg_mskq()
into a new helper mptcp_eat_recv_skb().

Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
---
 net/mptcp/protocol.c | 16 ++++++++++------
 1 file changed, 10 insertions(+), 6 deletions(-)

diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index 0c93b36373b1..48365d54bc06 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -1845,6 +1845,15 @@ static int mptcp_sendmsg(struct sock *sk, struct msghdr *msg, size_t len)
 
 static void mptcp_rcv_space_adjust(struct mptcp_sock *msk, int copied);
 
+static void mptcp_eat_recv_skb(struct sock *sk, struct sk_buff *skb)
+{
+	/* avoid the indirect call, we know the destructor is sock_wfree */
+	skb->destructor = NULL;
+	atomic_sub(skb->truesize, &sk->sk_rmem_alloc);
+	sk_mem_uncharge(sk, skb->truesize);
+	sk_eat_skb(sk, skb);
+}
+
 static int __mptcp_recvmsg_mskq(struct sock *sk,
 				struct msghdr *msg,
 				size_t len, int flags,
@@ -1887,12 +1896,7 @@ static int __mptcp_recvmsg_mskq(struct sock *sk,
 		}
 
 		if (!(flags & MSG_PEEK)) {
-			/* avoid the indirect call, we know the destructor is sock_wfree */
-			skb->destructor = NULL;
-			atomic_sub(skb->truesize, &sk->sk_rmem_alloc);
-			sk_mem_uncharge(sk, skb->truesize);
-			__skb_unlink(skb, &sk->sk_receive_queue);
-			__kfree_skb(skb);
+			mptcp_eat_recv_skb(sk, skb);
 			msk->bytes_consumed += count;
 		}
 
-- 
2.48.1

