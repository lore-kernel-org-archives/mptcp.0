Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C58ED51DE18;
	Fri, 18 Sep 2026 18:38:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789756732; cv=none; b=UsxXNnsVwVy65hzaMkwU3OB5HwMe7xGmb+dxBoG3SIvR2TdyUnoW4kemFSWgUUvR7dljglT+5wUUXcXjae78QQYTISLISlVaVOXoLkYJ79mU7qMI0VpQgR+OPQ4ZU629CEq7VGawG2mvEMf8o3Kl8/F5PHfAvQVYLKNVW0npfUI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789756732; c=relaxed/simple;
	bh=wBV9w9NEHxkHdKdv+pY/PQzJ9oBFaLgpjdOOAi9u9lg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=nBiuLpPegC0g46DKR6uArbh+CbWPOEb5+esc6NeTH/g4QjERnVcjAnW3Y0o5uA4LrQs1Sx2neC+6bZjbCN0vCOpeEvuvRSaF/tSx5R1o4CX7IqawRg1H9xSBrbqh4z0uiXvbJTu+UJjuVfCPl+3oi6/X07yZ++kV5F7dZ/1E/vk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oP3xccBq; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oP3xccBq"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 470D41F00899;
	Fri, 18 Sep 2026 18:38:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789756723;
	bh=h/DLk8aAp4ApzIpkXH1VE7IRsVU6O2wuBRPsq9VNpy8=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=oP3xccBqHxIHLQKrg1BzfFMGrFps+h6DfFOPibWGk0LaOFHCGoT+JWreu2jSuy1K3
	 9lFs1Ucdn7xMs+shJr1Shpm+yLs81qmJauLvt1YimHO4V93fO/0GW8iqVPE7e3pXKK
	 1Je/YnR3sejQWF9zHnKjST22hnAAUjdJ7guU5DTZBdRFNQb7ESZpzACmVALISgE7kk
	 yvBkNOpVnS4wI96D0awd9KtOEh8TJ6ZJU3DETYgf6PdCA7+Ss6JSpjBdRXJmao70wg
	 ldzlYbRAzsDSjYWaE2fTzZDuIkHia0h63qotEMERoZIMI7CaJUny+PBiM/XX1jr/+G
	 oKEk42nHZbCjA==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Fri, 18 Sep 2026 20:38:26 +0200
Subject: [PATCH net-next 2/4] mptcp: sockopt: factor inet_flags propagation
 into a mask
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260918-net-next-mptcp-msg_errqueue-v1-2-dd77e1738248@kernel.org>
References: <20260918-net-next-mptcp-msg_errqueue-v1-0-dd77e1738248@kernel.org>
In-Reply-To: <20260918-net-next-mptcp-msg_errqueue-v1-0-dd77e1738248@kernel.org>
To: Mat Martineau <martineau@kernel.org>, Geliang Tang <geliang@kernel.org>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Simon Horman <horms@kernel.org>
Cc: netdev@vger.kernel.org, mptcp@lists.linux.dev, 
 linux-kernel@vger.kernel.org, "Matthieu Baerts (NGI0)" <matttbe@kernel.org>, 
 David Carlier <devnexen@gmail.com>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2231; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=MZb1Th3F+8BZ7Pe907g7jydsYXsj2hesnGvFASzCFGY=;
 b=owGbwMvMwCVWo/Th0Gd3rumMp9WSGLLWtmoGBD9+/1X035YFCxUW35Y4/jLaf36frc9x+/h1u
 +be+dF/o6OUhUGMi0FWTJFFui0yf+bzKt4SLz8LmDmsTCBDGLg4BWAi2yoY/rtrLJk3OydGyoH3
 VdJXi8KrZp9fXfSNN9x8PuPqik2VmswMf7gjd+5tmNoxmffBsZfn+881fktacEnjjtaG88rm6gI
 HjbgA
X-Developer-Key: i=matttbe@kernel.org; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

From: David Carlier <devnexen@gmail.com>

Introduce MPTCP_INET_FLAGS_MASK and replace the per-flag
inet_assign_bit() calls in sync_socket_options() with a loop driven
by the mask that calls assign_bit() per set bit, preserving the
per-bit atomicity of the original. Further flags propagated by MPTCP
can be added by extending the mask rather than touching the call
site.

No functional change.

Signed-off-by: David Carlier <devnexen@gmail.com>
Acked-by: Paolo Abeni <pabeni@redhat.com>
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
 net/mptcp/sockopt.c | 15 ++++++++++++---
 1 file changed, 12 insertions(+), 3 deletions(-)

diff --git a/net/mptcp/sockopt.c b/net/mptcp/sockopt.c
index fcf6feb2a9eb..2ba56832587e 100644
--- a/net/mptcp/sockopt.c
+++ b/net/mptcp/sockopt.c
@@ -16,6 +16,10 @@
 
 #define MIN_INFO_OPTLEN_SIZE		16
 #define MIN_FULL_INFO_OPTLEN_SIZE	40
+#define MPTCP_INET_FLAGS_MASK \
+	(BIT(INET_FLAGS_TRANSPARENT) | \
+	 BIT(INET_FLAGS_FREEBIND) | \
+	 BIT(INET_FLAGS_BIND_ADDRESS_NO_PORT))
 
 static struct sock *__mptcp_tcp_fallback(struct mptcp_sock *msk)
 {
@@ -1550,8 +1554,11 @@ int mptcp_getsockopt(struct sock *sk, int level, int optname,
 static void sync_socket_options(struct mptcp_sock *msk, struct sock *ssk)
 {
 	static const unsigned int tx_rx_locks = SOCK_RCVBUF_LOCK | SOCK_SNDBUF_LOCK;
+	unsigned long mask = MPTCP_INET_FLAGS_MASK;
 	struct sock *sk = (struct sock *)msk;
+	unsigned long src;
 	bool keep_open;
+	int b;
 
 	keep_open = sock_flag(sk, SOCK_KEEPOPEN);
 	if (ssk->sk_prot->keepalive)
@@ -1597,9 +1604,11 @@ static void sync_socket_options(struct mptcp_sock *msk, struct sock *ssk)
 	tcp_sock_set_keepcnt(ssk, msk->keepalive_cnt);
 	tcp_sock_set_maxseg(ssk, msk->maxseg);
 
-	inet_assign_bit(TRANSPARENT, ssk, inet_test_bit(TRANSPARENT, sk));
-	inet_assign_bit(FREEBIND, ssk, inet_test_bit(FREEBIND, sk));
-	inet_assign_bit(BIND_ADDRESS_NO_PORT, ssk, inet_test_bit(BIND_ADDRESS_NO_PORT, sk));
+	src = READ_ONCE(inet_sk(sk)->inet_flags);
+
+	for_each_set_bit(b, &mask, BITS_PER_LONG)
+		assign_bit(b, &inet_sk(ssk)->inet_flags, src & BIT(b));
+
 	WRITE_ONCE(inet_sk(ssk)->local_port_range, READ_ONCE(inet_sk(sk)->local_port_range));
 }
 

-- 
2.55.0

