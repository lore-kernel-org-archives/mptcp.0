Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A2492F5316
	for <mptcp@lists.linux.dev>; Mon, 24 Nov 2025 09:13:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763975583; cv=none; b=YLXajdU2AmQqFNOmPj5/bhK22R43XW2RpGLuqHuCIqwzhv5xg6o+cZ6+zNRpMC2okWqzvuS2KD/uIBS//RSyzOHThKGZxdsyzOdFhQgG1SHz0IZEqEpUcFYvq8ubXBRVjrcScA39ieglzAOK+Qdi/jqTetnPI0ASWpqNnd8qqcU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763975583; c=relaxed/simple;
	bh=4oAz/740iislAtyTaSRLxw2TRzyqyQ35aVNwGUNqNFc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=sLTrvb1vBGFi1fWEyXJMFpr6yVJXOadC0GaQgmiUO4dzsYi8Cq4KMDkfIP2UJSWU48ab6zXViZomPCCq9qPnFB5fINmLRWgvPzZK5POMycpLzKl8Mn+NF1UWTy30XSgMHAMg1jek8dj8iWenjgFUYIw42F0s9qn/3YzNwSWhObw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LZ5qgMuS; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LZ5qgMuS"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 72D0AC116D0;
	Mon, 24 Nov 2025 09:13:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763975582;
	bh=4oAz/740iislAtyTaSRLxw2TRzyqyQ35aVNwGUNqNFc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=LZ5qgMuSx+h+v3BynUEsII43rmjhHsJwvtF5mwZavgm0CABiPDGbMK1o0ap/PDvM0
	 WGYrZzMGu1/D7q7diBtDcgaMg/EGs0GUU3p6lPU8DIBneVWYOicV8wX0BR9HM5mlCk
	 VnQO81OHDMdX5SGMeb/yXseJXIhRhOXDdVpuY/PvEhiVSlFsr0++bVV63Uyy9swYKt
	 kMFh2noPFSLixGN+KoYcNZS9Ud+CDDbh9/xwXm1zpD50Dd+EM5mabvilpiomBfEgF0
	 wH+DEZP1pIk5+VauWliQfzr87z+uMKlvFaNA2qa8bzIMNeiVEC7BoZp7dZNhrLkpf6
	 RNwMpRAyVGYhA==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next v14 1/8] mptcp: add eat_recv_skb helper
Date: Mon, 24 Nov 2025 17:12:46 +0800
Message-ID: <0fac6bd30baca4fdefec5947d967c56c182cc26e.1763974740.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1763974740.git.tanggeliang@kylinos.cn>
References: <cover.1763974740.git.tanggeliang@kylinos.cn>
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
 net/mptcp/protocol.c | 19 ++++++++++++-------
 1 file changed, 12 insertions(+), 7 deletions(-)

diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index ad20b087e9a9..b29790a7cea8 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -1995,6 +1995,17 @@ static int mptcp_sendmsg(struct sock *sk, struct msghdr *msg, size_t len)
 
 static void mptcp_rcv_space_adjust(struct mptcp_sock *msk, int copied);
 
+static void mptcp_eat_recv_skb(struct sock *sk, struct sk_buff *skb)
+{
+	/* avoid the indirect call, we know the destructor is sock_rfree */
+	skb->destructor = NULL;
+	skb->sk = NULL;
+	atomic_sub(skb->truesize, &sk->sk_rmem_alloc);
+	sk_mem_uncharge(sk, skb->truesize);
+	__skb_unlink(skb, &sk->sk_receive_queue);
+	skb_attempt_defer_free(skb);
+}
+
 static int __mptcp_recvmsg_mskq(struct sock *sk, struct msghdr *msg,
 				size_t len, int flags, int copied_total,
 				struct scm_timestamping_internal *tss,
@@ -2049,13 +2060,7 @@ static int __mptcp_recvmsg_mskq(struct sock *sk, struct msghdr *msg,
 				break;
 			}
 
-			/* avoid the indirect call, we know the destructor is sock_rfree */
-			skb->destructor = NULL;
-			skb->sk = NULL;
-			atomic_sub(skb->truesize, &sk->sk_rmem_alloc);
-			sk_mem_uncharge(sk, skb->truesize);
-			__skb_unlink(skb, &sk->sk_receive_queue);
-			skb_attempt_defer_free(skb);
+			mptcp_eat_recv_skb(sk, skb);
 		}
 
 		if (copied >= len)
-- 
2.43.0

