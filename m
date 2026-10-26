Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793010941;
	b=shJoi0HzhUqDZ3B4ITkr5MQO0HDL1neUaWHfebNSYj7eU9kHUpe4B+rAApIYBV/TOZoC
	 C5q1gjiI9bVwVWhhFgIkVdHU3Pyb+Tj90cv9R79rcIMk+Sj9osQdwZJhUhQkJRmHsJ94O
	 yTdbyS2+xZBUK8a/kFe9x23w87b4vtdcOtjdDLqB1lscA3hyKeGtpjDuyAka6BC4+7L2R
	 ybXhIjEIGxuVjPM0zfoHMdjADI3eDyP4mToXPXXPat1E9uv9fB1yGdOH+kHHPwvipw0m8
	 TczohiuXugcC3DPAfNX3+JLTXmqPb2j6xHFbCpN9+CITsIlMeMbZfGQLe1eDRoemz5w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793010941;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=EBNwE8s1NAm8Boo+DDfLG6fiMsfMkcA91M8T6BswFtA=;
	b=e5xFItFlAchH71PJJN46KzQ3pU9T40kmBFzQX33331Az1qQuK6oECpz48G9m4x5kB4xH
	 W+o5WQNzVH/ey22nYWOhbeyWv8JowytOS9q4TLY6cxpdHW0X1oN4IlKBvatze2TJXIdUI
	 BrmTgWGZXcW2lraHl54ypa+Wz71iOZnBLun/kgIHkvr5C6TuentF1UCghzwrK/vEqVCd7
	 daJ0vpdRZ74zNJjadYl7A9HFpxmQgUwUUArQf+oeXDhLlpjnYZ5exAgzreuI2gNDG1d9f
	 TSAFigCH2yyZHgi9QdwCHhc2mvTV36g3OSHcDXigce6GWKinBcM5f8cGEOLKCt3pkqQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=lq2YqidU;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08D29606A31A
	for <mptcp@lists.linux.dev>; Mon, 26 Oct 2026 10:35:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=lq2YqidU
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 498E51F031E1;
	Mon, 26 Oct 2026 10:35:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793010940;
	bh=EBNwE8s1NAm8Boo+DDfLG6fiMsfMkcA91M8T6BswFtA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=lq2YqidUcFRApX+qXnBpE5Mh2DBgpEGhmDSCY40Wa9T8HGbtSZAhXYGBrcD8Zk5qn
	 GyDUsmeaofbS8hGYIXGGKTQa60Vd5irgsnRxGpyKWgUyKqlNbjEYEJ9EteOPoItAXO
	 pkh+iAcU7BVjlUQ0b1H9IYA/9f3jaTuGspg3KQE/ALd1m72aJioF5mUmeOh6B2GRqS
	 42mmvjI1amwcVRRYxUpcWF34vCmjnTwP8THN49KQqxf2g8RGOQQrM9ySSygmZjCDyz
	 P/iuPfMs1WGljEbyhcGbzm7AkcpElPtJzEu/llFIEkqF3qzKvn3eMYDb/gJdZebmil
	 1n92rTOok2bTA==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next v2 2/4] sock: add set_memalloc protocol callback
Date: Mon, 26 Oct 2026 18:35:26 +0800
Message-ID: <2394cada9a75d45edb8773c3d24e699e9211e98c.1793010744.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <cover.1793010744.git.tanggeliang@kylinos.cn>
References: <cover.1793010744.git.tanggeliang@kylinos.cn>
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Post: <mailto:mptcp@lists.linux.dev>
List-Help: <mailto:mptcp+help@lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
List-Owner: <mailto:mptcp+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Geliang Tang <tanggeliang@kylinos.cn>

Add a protocol-specific callback set_memalloc() to struct proto that
gets invoked when SOCK_MEMALLOC flag or allocation settings change on
a socket. This allows protocols like MPTCP to propagate these settings
to their sub-sockets automatically.

For MPTCP, when the master socket's memalloc settings change (via
sk_set_memalloc/sk_clear_memalloc), the callback synchronizes
SOCK_MEMALLOC flag, sk_allocation, and sk_use_task_frag to all subflow
sockets immediately. This ensures subflows can use emergency memory
reserves when needed, preventing deadlocks in memory pressure scenarios.

NBD (Network Block Device) benefits from this when used over MPTCP for
swap devices. Previously, NBD would set sk_allocation directly in
__sock_xmit() but this wouldn't propagate to MPTCP subflows. Now it
calls sk_set_memalloc() which triggers the MPTCP callback to sync all
subflows.

The callback mechanism maintains clean layering: core socket code
doesn't need MPTCP-specific knowledge, and MPTCP handles its own
subflow synchronization transparently.

Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
---
 drivers/block/nbd.c  |  1 +
 include/net/sock.h   |  1 +
 net/core/sock.c      |  8 ++++++++
 net/mptcp/protocol.c | 21 +++++++++++++++++++++
 4 files changed, 31 insertions(+)

diff --git a/drivers/block/nbd.c b/drivers/block/nbd.c
index ffce519bf008..c5e26fc98d1a 100644
--- a/drivers/block/nbd.c
+++ b/drivers/block/nbd.c
@@ -579,6 +579,7 @@ static int __sock_xmit(struct nbd_device *nbd, struct socket *sock, int send,
 		do {
 			sock->sk->sk_allocation = GFP_NOIO | __GFP_MEMALLOC;
 			sock->sk->sk_use_task_frag = false;
+			sk_set_memalloc(sock->sk);
 			msg.msg_flags = msg_flags | MSG_NOSIGNAL;
 
 			if (send)
diff --git a/include/net/sock.h b/include/net/sock.h
index 173b37b2b8bb..aaf50293ea37 100644
--- a/include/net/sock.h
+++ b/include/net/sock.h
@@ -1361,6 +1361,7 @@ struct proto {
 	/* Memory pressure */
 	void			(*enter_memory_pressure)(struct sock *sk);
 	void			(*leave_memory_pressure)(struct sock *sk);
+	void			(*set_memalloc)(struct sock *sk);
 	atomic_long_t		*memory_allocated;	/* Current allocated memory. */
 	int  __percpu		*per_cpu_fw_alloc;
 	struct percpu_counter	*sockets_allocated;	/* Current number of sockets. */
diff --git a/net/core/sock.c b/net/core/sock.c
index e7405be8941f..dc5fbe2f63fc 100644
--- a/net/core/sock.c
+++ b/net/core/sock.c
@@ -306,6 +306,10 @@ void sk_set_memalloc(struct sock *sk)
 	sock_set_flag(sk, SOCK_MEMALLOC);
 	sk->sk_allocation |= __GFP_MEMALLOC;
 	static_branch_inc(&memalloc_socks_key);
+
+	/* Call protocol-specific callback if available */
+	if (sk->sk_prot->set_memalloc)
+		sk->sk_prot->set_memalloc(sk);
 }
 EXPORT_SYMBOL_GPL(sk_set_memalloc);
 
@@ -315,6 +319,10 @@ void sk_clear_memalloc(struct sock *sk)
 	sk->sk_allocation &= ~__GFP_MEMALLOC;
 	static_branch_dec(&memalloc_socks_key);
 
+	/* Call protocol-specific callback if available */
+	if (sk->sk_prot->set_memalloc)
+		sk->sk_prot->set_memalloc(sk);
+
 	/*
 	 * SOCK_MEMALLOC is allowed to ignore rmem limits to ensure forward
 	 * progress of swapping. SOCK_MEMALLOC may be cleared while
diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index d4f42dfc227e..5eccff04151d 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -4327,6 +4327,26 @@ static int mptcp_connect(struct sock *sk, struct sockaddr_unsized *uaddr,
 	return 0;
 }
 
+static void mptcp_set_memalloc(struct sock *sk)
+{
+	struct mptcp_sock *msk = mptcp_sk(sk);
+	struct mptcp_subflow_context *subflow;
+	bool memalloc;
+
+	lock_sock(sk);
+	memalloc = sock_flag(sk, SOCK_MEMALLOC);
+	mptcp_for_each_subflow(msk, subflow) {
+		struct sock *ssk = mptcp_subflow_tcp_sock(subflow);
+
+		lock_sock_nested(ssk, SINGLE_DEPTH_NESTING);
+		sock_valbool_flag(ssk, SOCK_MEMALLOC, memalloc);
+		ssk->sk_allocation = sk->sk_allocation;
+		ssk->sk_use_task_frag = sk->sk_use_task_frag;
+		release_sock(ssk);
+	}
+	release_sock(sk);
+}
+
 static struct proto mptcp_prot = {
 	.name		= "MPTCP",
 	.owner		= THIS_MODULE,
@@ -4358,6 +4378,7 @@ static struct proto mptcp_prot = {
 	.obj_size	= sizeof(struct mptcp_sock),
 	.slab_flags	= SLAB_TYPESAFE_BY_RCU,
 	.no_autobind	= true,
+	.set_memalloc	= mptcp_set_memalloc,
 };
 
 static int mptcp_bind(struct socket *sock, struct sockaddr_unsized *uaddr, int addr_len)
-- 
2.55.0

