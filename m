Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14F341DF26B
	for <mptcp@lists.linux.dev>; Sun, 13 Jul 2025 09:43:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752399837; cv=none; b=jZfPBcmI5y/K2ZnqJZ/UlqoyAPj0PT35xVdeRH1UchiyafcwxEYGti2+n1/evORHjgSLawHAmJedeEuLRrqkLP08Jn4DUwOjvPrDpSs21KYYWz3cwvJ2JTw+hZ9PjE9P8AgQ99tgT07BKgB32VF/S2Ds4kUmQMmvxzliFxSoMS8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752399837; c=relaxed/simple;
	bh=20do/M+FED549W6DKGJEOIhn4PWQQUwjPwuQVSx6Vrs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=aJG9G5rAxUdpRRYDsdcflJoDqNmoCrj6g6M6yESQT95b2An0T3DNPqXDCRaJJeX7eyxSGaiW1atYp3qidk8FnEU3lqJu1WpMW3LqGwMZRGuTZiPsSBKYV5G8MkF2N0d0VJ7IHLiu9o1bKrcoGWPPwjFPEzGK9vgV9XzrHiXL6js=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XvQUmH8w; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XvQUmH8w"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AAB06C4CEF5;
	Sun, 13 Jul 2025 09:43:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752399835;
	bh=20do/M+FED549W6DKGJEOIhn4PWQQUwjPwuQVSx6Vrs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=XvQUmH8wsA5ljRzpBPTqY6bxHr87zWiIl6zDkt5MJkyBTtoqCOttLktD/TElUFTPC
	 WE0cuAm6Mw+b9XPMLlHAgINrbNxLhk7h+P30PjQ+SSD++g474pVaaUMcrbAlG1JVmj
	 Qrt0DS+EvnrB2h3RW7ial1wTs14ck0dWMTOrXKI1jVCC+i3WfBWNmT1cUdmmUYLk4J
	 4OJPsQayaVNnlVpA/Ft5AvEcSuOKYSMLewVQB75fAhLWcJbanfqFMv7nGIEyxBmVH6
	 sfK3g65IxIja7wlKhbosHUGD3f/AaTU8IQPPQJEIGi0bVKcBexKn+38a/qzgeG/4te
	 4o0vmN3tAqhDw==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev,
	hare@kernel.org
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next v9 1/9] mptcp: add eat_recv_skb helper
Date: Sun, 13 Jul 2025 17:43:41 +0800
Message-ID: <e75e79d8338406db94516124db4a9a4a122bb990.1752399660.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <cover.1752399660.git.tanggeliang@kylinos.cn>
References: <cover.1752399660.git.tanggeliang@kylinos.cn>
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
index 4b510e04724f..c2233802b7a1 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -1871,6 +1871,15 @@ static int mptcp_sendmsg(struct sock *sk, struct msghdr *msg, size_t len)
 
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
@@ -1913,12 +1922,7 @@ static int __mptcp_recvmsg_mskq(struct sock *sk,
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

