Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C073A26B955
	for <mptcp@lists.linux.dev>; Wed,  9 Jul 2025 07:25:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752045947; cv=none; b=f2yKXpgGzi7rH6VPWQqbFK9sfUmKh/otBVbhIu8PtjMwj3/V7hqBDAIA5S8uaGy74jS78UXof0pBSVRgux3lTTGUvdPTVaC3cWmG4+fN64ylzexMnpT/6+91k+930JWaftcu6T8uZU6qjqc1SK1w0MVhyt14UdP/xOoG1N6r0LQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752045947; c=relaxed/simple;
	bh=CO4KtAfcjEBQODMX1D6EQv4ipfEwpdp2u+Ty9rMcrK0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=vBEtz3XpjZ2bdRZizE0G7R7ft/7a5Pub3PbmSuNBLv+erXq4gVP8Sy9vSYuX4pczGLcKf0QL54erVasP6cGvJMC8UiUa2S02H5G6fql9a9rmAvTT5eFEwyvjkJHorSoFCpO91X5IatvoIen7svb9ajjuMT6/w3+b5tJrMLCL+nk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=N+XYttOQ; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="N+XYttOQ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2959CC4CEF1;
	Wed,  9 Jul 2025 07:25:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752045947;
	bh=CO4KtAfcjEBQODMX1D6EQv4ipfEwpdp2u+Ty9rMcrK0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=N+XYttOQoVlnNkvG30hxxsm8rn5MrHnNsYAw6bTijmhB5y4GmLTCAdoyyuD/DNxj1
	 NX45HBf+asYttbT25SfCY14wfK6Ga7rRGSIb2ctxfndZ9o7BPAz6aAPGGGsNjEhZWi
	 MOj8YiojdGE2fzAwoBUAn23aY9JBAoEl8bnKVqGmrc/HnEeavGk+rXtibc7KlrySvY
	 3KYjTEE2apXumileiSwXhswR96x7iFKi5E7dKAghVB2WoO4bY6UExcOHx6nojGWkjU
	 lqxzvpytjOoOAwk5U1WCG7FlfGhO9/QL+UrahrkMvisDsPIIaBuJ7bzdR4duI+7Pwc
	 3Q+Zvgjweev1w==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev,
	matttbe@kernel.org,
	hare@kernel.org,
	pabeni@redhat.com
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next v8 1/7] mptcp: add eat_recv_skb helper
Date: Wed,  9 Jul 2025 15:25:28 +0800
Message-ID: <59ab5dfdd73b79e58cb48a855af0753a72be730f.1752045499.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <cover.1752045499.git.tanggeliang@kylinos.cn>
References: <cover.1752045499.git.tanggeliang@kylinos.cn>
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

Use sk_eat_skb() in this helper instead of open-coding it.

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

