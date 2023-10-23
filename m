Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABB221C6BD;
	Mon, 23 Oct 2023 20:45:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oe+NX9Pq"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 16A60C433AB;
	Mon, 23 Oct 2023 20:45:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1698093934;
	bh=U+qfHVKzSdXpb5Nt3mGZCOI198lAElT+RKzcKjn/PiY=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=oe+NX9Pqh48cHlP94ZQURZ6ZFJY+eg6/vpMO1JiIW+OcOZbq97x0xz9jlo14Au0HJ
	 6peL/N3oX1U0H61PYnv/+Xmmt5N74v0NQuthBMYTMPFRNmVshW7HZRMQl5UeIv92Sq
	 BbiHXYZsnGd5KLNUcHR9wS5Os9PrClNUBpnLWZ5KXHq9Wa9qnlIAuevey0xsK7q6bE
	 KsZzdiuHQpU2GKYjxIEHjTXnSgUZOFmwQezaXFOxYLgJRh9v6T1nhw+s7qpwa8Spse
	 oMAZjfXr5BCp/xUZLMIDQfKtHJt7UlUS7oLxUVwnAO9NAoQmUOX0Tl2HSW921LtxzO
	 zrHspQP60CAbQ==
From: Mat Martineau <martineau@kernel.org>
Date: Mon, 23 Oct 2023 13:44:37 -0700
Subject: [PATCH net-next 4/9] tcp: define initial scaling factor value as a
 macro
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20231023-send-net-next-20231023-2-v1-4-9dc60939d371@kernel.org>
References: <20231023-send-net-next-20231023-2-v1-0-9dc60939d371@kernel.org>
In-Reply-To: <20231023-send-net-next-20231023-2-v1-0-9dc60939d371@kernel.org>
To: Matthieu Baerts <matttbe@kernel.org>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, mptcp@lists.linux.dev, 
 Mat Martineau <martineau@kernel.org>
X-Mailer: b4 0.12.4

From: Paolo Abeni <pabeni@redhat.com>

So that other users could access it. Notably MPTCP will use
it in the next patch.

No functional change intended.

Acked-by: Matthieu Baerts <matttbe@kernel.org>
Signed-off-by: Paolo Abeni <pabeni@redhat.com>
Signed-off-by: Mat Martineau <martineau@kernel.org>
---
 include/net/tcp.h | 12 +++++++-----
 1 file changed, 7 insertions(+), 5 deletions(-)

diff --git a/include/net/tcp.h b/include/net/tcp.h
index 39b731c900dd..993b7fcd4e46 100644
--- a/include/net/tcp.h
+++ b/include/net/tcp.h
@@ -1489,13 +1489,15 @@ static inline int tcp_space_from_win(const struct sock *sk, int win)
 	return __tcp_space_from_win(tcp_sk(sk)->scaling_ratio, win);
 }
 
+/* Assume a conservative default of 1200 bytes of payload per 4K page.
+ * This may be adjusted later in tcp_measure_rcv_mss().
+ */
+#define TCP_DEFAULT_SCALING_RATIO ((1200 << TCP_RMEM_TO_WIN_SCALE) / \
+				   SKB_TRUESIZE(4096))
+
 static inline void tcp_scaling_ratio_init(struct sock *sk)
 {
-	/* Assume a conservative default of 1200 bytes of payload per 4K page.
-	 * This may be adjusted later in tcp_measure_rcv_mss().
-	 */
-	tcp_sk(sk)->scaling_ratio = (1200 << TCP_RMEM_TO_WIN_SCALE) /
-				    SKB_TRUESIZE(4096);
+	tcp_sk(sk)->scaling_ratio = TCP_DEFAULT_SCALING_RATIO;
 }
 
 /* Note: caller must be prepared to deal with negative returns */

-- 
2.41.0

