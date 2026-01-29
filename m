Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A224131B131;
	Thu, 29 Jan 2026 19:23:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769714634; cv=none; b=SyyO5rM28nj+aBROxA+RkW3f+2giJJG1ycZ+HVvCwo3QgVsCO4p45VjHhIP1JczB8ow2E3h7E1RiXvkkbna/WvCnaAfX9LE9RciBvf28HN9z5mym4hIGr/sDTzmGWqC//zvHCG0MGsc919HIyFW4jyiKImPxScTZ7gRHmYk4uhM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769714634; c=relaxed/simple;
	bh=9g6BefChnzYyfvDQL2j81TNqLZApmbITYFTvJoYgiNo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=TRYhxGysUSdY0oDfSivLE86h4k+i+mP+B/QRhaP6HsyBfjiXaC5p7zmWry7BOgo9ok69ij2R+ZKXRIcLX5zpaoaSxZ4IFsmH+3MuiXY91lyHXlLqDxxzXsYRKmLEytF9GncoAXsilsanuutT6kVi/17OtZPKiBFO0dDVF3QFZiE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=t1MvztWD; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="t1MvztWD"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ED065C2BC87;
	Thu, 29 Jan 2026 19:23:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769714634;
	bh=9g6BefChnzYyfvDQL2j81TNqLZApmbITYFTvJoYgiNo=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=t1MvztWDZL4DGKiVATl5DkuMlzjyavT7r7QjU2uFpaCVxUYVbGgGjAc3Ux7DOKEvN
	 wbtXh1szn6lhur9tieuJ6audbQ5z4F0R3bmggaTrvMWZY+SdmJYxFsqi2y1xvx+8V0
	 zoohUyzMabcy2dtuk20v81tPRqSZEbV/Uzz09HVcXJlVNizK9w9ty6Ulk8F8XCEOUw
	 V2Ajk0n1fpAkx/359AO1GJmr6KKtJuMQUFXLuZYo11cs7Cl8D74X8g5JO42g6SwlmJ
	 FBh7xbhuZTgBPK2vRSKMWF6fVYksn75jnwd/wNXvbdjnOrUvl9GP4EQDPnRzdcogNW
	 z8if38LIQE3dA==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Thu, 29 Jan 2026 20:23:34 +0100
Subject: [PATCH net-next 1/6] mptcp: add eat_recv_skb helper
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260129-net-next-mptcp-splice-v1-1-994cac40daa0@kernel.org>
References: <20260129-net-next-mptcp-splice-v1-0-994cac40daa0@kernel.org>
In-Reply-To: <20260129-net-next-mptcp-splice-v1-0-994cac40daa0@kernel.org>
To: Mat Martineau <martineau@kernel.org>, Geliang Tang <geliang@kernel.org>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Simon Horman <horms@kernel.org>, Neal Cardwell <ncardwell@google.com>, 
 Kuniyuki Iwashima <kuniyu@google.com>, David Ahern <dsahern@kernel.org>, 
 Shuah Khan <shuah@kernel.org>
Cc: netdev@vger.kernel.org, mptcp@lists.linux.dev, 
 linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 "Matthieu Baerts (NGI0)" <matttbe@kernel.org>, 
 Geliang Tang <geliang@kernel.org>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=1793; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=EyBVwfWPEwe81zm6wQn9WT3j88WpSp4AB+CSv6QkeK0=;
 b=owGbwMvMwCVWo/Th0Gd3rumMp9WSGDKrNx98btl8U93/rhvPwgWHLqi8fiBc5nRyg27rsX0TH
 e7cnLMkoqOUhUGMi0FWTJFFui0yf+bzKt4SLz8LmDmsTCBDGLg4BWAiO34yMryPC2R54X//Ycch
 +d9c07alMW1feu7lu4yvdknvJLe33PZg+O97tWfmlhaNNe+bDvx87rSwY2Mgh0Si3wQfnRutOzu
 +nOEBAA==
X-Developer-Key: i=matttbe@kernel.org; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

From: Geliang Tang <tanggeliang@kylinos.cn>

This patch extracts the free skb related code in __mptcp_recvmsg_mskq()
into a new helper mptcp_eat_recv_skb().

This new helper will be used in the next patch.

Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
Reviewed-by: Mat Martineau <martineau@kernel.org>
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
 net/mptcp/protocol.c | 19 ++++++++++++-------
 1 file changed, 12 insertions(+), 7 deletions(-)

diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index f505b780f713..80f37220ef0c 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -1994,6 +1994,17 @@ static int mptcp_sendmsg(struct sock *sk, struct msghdr *msg, size_t len)
 
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
@@ -2048,13 +2059,7 @@ static int __mptcp_recvmsg_mskq(struct sock *sk, struct msghdr *msg,
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
2.51.0

