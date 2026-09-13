Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 929C03CAA3F
	for <mptcp@lists.linux.dev>; Sun, 13 Sep 2026 10:15:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789294525; cv=none; b=iq+B1bQ17K2gIYjTCXxgEt8rqDD/Rl43N8pOMO9fm3R5sCwK69sTFN65pWPxv+mbkBVhwzeuLs/oX5cIeXD6eIWG9LpT55/QXkNax/Elz/rvyKU+smpSXt7vTHxQwSR1hYdylFeJiv3g54s2s+JLByt9nRqV/CLE1Vp/tyOgkkY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789294525; c=relaxed/simple;
	bh=QsUsZzytdewlwtHwBdJZZp80n/f+kPmNpUe7FTysRgA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=F+Imz78/XNiCI0LfYLPJxdsMG7KbHdvGit6Iel2fn9CqncVj57QAL1CGpKqDKe/sqy71hATi6v4b4dnCmcjIDj+iQaoWEN0gph/ZUhg9r6KieHYgpig+dApKxGRcvXWbSgF5JUF2VAxQMwpGLjm8D3s3oX942HYqXQGzLCfppv4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OKDrl8wu; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OKDrl8wu"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 99F241F00893;
	Sun, 13 Sep 2026 10:15:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789294523;
	bh=G0dYdhSNyJlerIWRd18N/LVtU8y6aN7oswuYCjl46Zg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=OKDrl8wud8Q9VHGGPzMc9e/70dtSOaRzm1wh8u8DD7MZPYu2E6N1noF25V+MyJ1Cr
	 A34Lnjhq3+OuoFoAPeAIPQ7UCrJ0OiLT0AK+ODHf+MbIZ5Q4B8gpzKFc2Yr06aa8n6
	 JrwVdFold6ru/3PLb2uOaUDNRpTTgj28YSKmjDewtu6evTyE0F6K/f0SoyY/luQ2ws
	 st++bAakGkbvxsNUb98cu9mjLnxEv5FdUA4bI4POpmYVUSebONOA/cTDlnsnx4qnGq
	 BG8lSZoVWbUDL34BE/mLT40HakboUrKQuRvNAs/bz1ooZ8jy30ahvZM18RqFlHTQQX
	 BTie6h4ms5bLw==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next v5 10/16] bpf: export and generalize tcp_bpf_ioctl
Date: Sun, 13 Sep 2026 18:14:49 +0800
Message-ID: <2470bdd0b43b4b4530edd7d0448e0e92bd8e578f.1789294365.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <cover.1789294365.git.tanggeliang@kylinos.cn>
References: <cover.1789294365.git.tanggeliang@kylinos.cn>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Geliang Tang <tanggeliang@kylinos.cn>

Export tcp_bpf_ioctl() and generalize it to use protocol-specific
operations (sk->sk_prot->ioctl and sk->sk_socket->ops->peek_len) instead
of hard-coded tcp_ioctl() and tcp_inq(). Wire it into the MPTCP BPF
protocol structures so that SIOCINQ returns correct results accounting
for data in the psock ingress queue.

Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
---
 include/net/tcp.h  |  1 +
 net/ipv4/tcp_bpf.c | 10 +++++-----
 net/mptcp/bpf.c    |  1 +
 3 files changed, 7 insertions(+), 5 deletions(-)

diff --git a/include/net/tcp.h b/include/net/tcp.h
index d9c0214328e3..fb4dec998adc 100644
--- a/include/net/tcp.h
+++ b/include/net/tcp.h
@@ -2878,6 +2878,7 @@ __tcp_bpf_recvmsg(struct sock *sk, struct msghdr *msg, size_t len, int flags,
 		  int (*recvmsg)(struct sock *, struct msghdr *, size_t, int));
 int __tcp_bpf_sendmsg(struct sock *sk, struct msghdr *msg, size_t size,
 		      int (*sendmsg)(struct sock *, struct msghdr *, size_t));
+int tcp_bpf_ioctl(struct sock *sk, int cmd, int *karg);
 #endif /* CONFIG_NET_SOCK_MSG */
 
 #if !defined(CONFIG_BPF_SYSCALL) || !defined(CONFIG_NET_SOCK_MSG)
diff --git a/net/ipv4/tcp_bpf.c b/net/ipv4/tcp_bpf.c
index e006131696e9..8aed3c309b0d 100644
--- a/net/ipv4/tcp_bpf.c
+++ b/net/ipv4/tcp_bpf.c
@@ -331,15 +331,15 @@ static int tcp_bpf_recvmsg_parser(struct sock *sk,
 	return copied;
 }
 
-static int tcp_bpf_ioctl(struct sock *sk, int cmd, int *karg)
+int tcp_bpf_ioctl(struct sock *sk, int cmd, int *karg)
 {
 	struct sk_psock *psock;
 	bool slow;
 
 	if (cmd != SIOCINQ)
-		return tcp_ioctl(sk, cmd, karg);
+		return sk->sk_prot->ioctl(sk, cmd, karg);
 
-	/* works similar as tcp_ioctl */
+	/* works similar as sk_prot->ioctl */
 	if (sk->sk_state == TCP_LISTEN)
 		return -EINVAL;
 
@@ -347,7 +347,7 @@ static int tcp_bpf_ioctl(struct sock *sk, int cmd, int *karg)
 	psock = sk_psock_get(sk);
 	if (unlikely(!psock)) {
 		unlock_sock_fast(sk, slow);
-		return tcp_ioctl(sk, cmd, karg);
+		return sk->sk_prot->ioctl(sk, cmd, karg);
 	}
 	*karg = sk_psock_get_msg_len_nolock(psock);
 	/* Without a verdict program, ingress data is never diverted to
@@ -357,7 +357,7 @@ static int tcp_bpf_ioctl(struct sock *sk, int cmd, int *karg)
 	 */
 	if (!READ_ONCE(psock->progs.stream_verdict) &&
 	    !READ_ONCE(psock->progs.skb_verdict))
-		*karg += tcp_inq(sk);
+		*karg += sk->sk_socket->ops->peek_len(sk->sk_socket);
 	sk_psock_put(sk, psock);
 	unlock_sock_fast(sk, slow);
 
diff --git a/net/mptcp/bpf.c b/net/mptcp/bpf.c
index 7ecafbf51fa0..f6fd610f7077 100644
--- a/net/mptcp/bpf.c
+++ b/net/mptcp/bpf.c
@@ -398,6 +398,7 @@ static void mptcp_bpf_rebuild_protos(struct proto prot[MPTCP_BPF_NUM_CFGS],
 	prot[MPTCP_BPF_BASE].close		= sock_map_close;
 	prot[MPTCP_BPF_BASE].recvmsg		= mptcp_bpf_recvmsg;
 	prot[MPTCP_BPF_BASE].sock_is_readable	= sk_msg_is_readable;
+	prot[MPTCP_BPF_BASE].ioctl		= tcp_bpf_ioctl;
 
 	prot[MPTCP_BPF_TX]			= prot[MPTCP_BPF_BASE];
 	prot[MPTCP_BPF_TX].sendmsg		= mptcp_bpf_sendmsg;
-- 
2.53.0

