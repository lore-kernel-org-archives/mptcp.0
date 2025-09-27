Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27D3F279780
	for <mptcp@lists.linux.dev>; Sat, 27 Sep 2025 12:31:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758976297; cv=none; b=sZcY5AQ54GgKZYLkDmUtwe9+1VWROFfFuNVRV6phmX9mkbuhBx6K1O3TeuPGov1CY3T5bJZ/52yTrfJdckPnMlcLgrpZ+9bKLu4Voq8ENFA+/GvqdIYRBoU1nYKA11r3dQ7wz7yeW136gdTfy114QxlZglJPhSkxty8MLkOZyLo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758976297; c=relaxed/simple;
	bh=u6uL/2JO+e+PImVQJitwPk7c7+HFp3BT5LJ36sbowYE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qq909LGnKcYJjiXD440uTQgqNVKw/rb/FKpyFt/r+H0zumilDzCXpMy7UXRSy8yYeD+cOsdapVKaFbKB9oT1CwVik9SjJCzBv0dJhVgyoaAcMMLu9XTnp1w3oVSGx6nJdSOpuFzapLJZ57RqceGZbTIIeM4PKqG/f6+Rwbr1RoY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XkwQlOYs; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XkwQlOYs"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DCCB5C4CEF5;
	Sat, 27 Sep 2025 12:31:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758976296;
	bh=u6uL/2JO+e+PImVQJitwPk7c7+HFp3BT5LJ36sbowYE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=XkwQlOYsARgXf01oASoyMNgzrXykGXIJ+KOMfxwe8r8LiJw1ytRsVFubqe+0FXxyC
	 INgozC8/WYo89NgLGaePwq8ulOxo892f6iA5T+ofn/vDV1aBQksO75zVXsK3Wl1h3J
	 IMdIhph4OKe+oGbh29mQVVjUr70zPg5zJg0h7JKbE7TCvz7pus6uc9eBbwVSHAVEhM
	 sjJpEluWuam5hbZWDSGPRDoCQIIe7PX4OZzDh/VirAFe+AVxbzeQ6Vo1zdLFoQTm2m
	 LiVYd8mROoay1sDpw2kwvK6skAJMs2GxWl5HpQWs5KR+HF/IjpBoTKfEmyMexlGN+Q
	 dk//H6GSopUvg==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next v12 1/8] mptcp: add eat_recv_skb helper
Date: Sat, 27 Sep 2025 20:30:18 +0800
Message-ID: <af81b1547d2edc3eda99c00d63f0140152024794.1758975929.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1758975929.git.tanggeliang@kylinos.cn>
References: <cover.1758975929.git.tanggeliang@kylinos.cn>
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
index 574a1e222d9c..e12dad700a58 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -1936,6 +1936,17 @@ static int mptcp_sendmsg(struct sock *sk, struct msghdr *msg, size_t len)
 
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
 static int __mptcp_recvmsg_mskq(struct sock *sk,
 				struct msghdr *msg,
 				size_t len, int flags,
@@ -1978,13 +1989,7 @@ static int __mptcp_recvmsg_mskq(struct sock *sk,
 		}
 
 		if (!(flags & MSG_PEEK)) {
-			/* avoid the indirect call, we know the destructor is sock_rfree */
-			skb->destructor = NULL;
-			skb->sk = NULL;
-			atomic_sub(skb->truesize, &sk->sk_rmem_alloc);
-			sk_mem_uncharge(sk, skb->truesize);
-			__skb_unlink(skb, &sk->sk_receive_queue);
-			skb_attempt_defer_free(skb);
+			mptcp_eat_recv_skb(sk, skb);
 			msk->bytes_consumed += count;
 		}
 
-- 
2.43.0

