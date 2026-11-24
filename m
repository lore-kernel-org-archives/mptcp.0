Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795557687;
	b=q4IvdDohJo/aQfaqajkz/qnU/k9d4QBi7x60r2P9rSOfjp9Tmhym7tCLVX34rpPPg8LX
	 IiSiCwIeJ1bv0kxPbQFekezDDRrCMTQoWVZOJWYD3Z/mg8m90YZSmGZTk4m7Q6Uy6VlX5
	 lTJ236ZI0SviMgkL7uSI5MR8QdasH2Jq1ty882rafsZ4aKvxutU+UevfBDY7AVLl9CVHn
	 kM8DffoJP+WGKrP4a24YICtdvrtZdIpYQIsUM6v/yRtMMFXomVsYfqTm9Y4djp+g3pS21
	 Td+FZ1iA1819rpFqkDuKjjvf1W/pwkBRMGCSule5hb5/8iyrNI7/yIVV23yqCKvWFPg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795557687;
	h=Received:DKIM-Signature:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer:X-Developer-Signature:X-Developer-Key;
	bh=cbHJpgOooJOguSJAWRQ2CKVQOBY8X4T6m783R0TGyis=;
	b=BeZYVBG1kMIj9vrqZ3RsjzAruhNGAxLiZcjQcCVq559Y2DZa9dfZftzPBBJZ9K/RNk7T
	 f3gosItb+inhTahoyhSX5ZoL+jdkGXnLwL4y6mQrdsYCF5ylS7XWiGmjRbL57pcL/21Wf
	 dcQmaOA0kb+OEHKO/rFCPcRHtvr06ZFQ3myTbtmlvaDnLY7DZnd3bqrFeKsN45bflXypT
	 W/wuPIERA1iSSax8LUq7o+hOf0X73bZwwUPbY/KpKAyPAYZPAJfPkX/05ia+epkN8vlX5
	 cgMIN2BLKF8g/+YCvmAtV7QIKZz0F8QBstA8ujkR53PcHqq5O32bW8dx9vqK6MBiqRA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Kp6XRyvX;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CDCE606A31E
	for <mptcp@lists.linux.dev>; Tue, 24 Nov 2026 22:01:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Kp6XRyvX
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3F5F01F000E6;
	Tue, 24 Nov 2026 22:01:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795557686;
	bh=cbHJpgOooJOguSJAWRQ2CKVQOBY8X4T6m783R0TGyis=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=Kp6XRyvXCqclR10VV1Ao8GNxm9vPsiF7rQKWfjCU5z8247zMG16NHXKc4EyqJ+y89
	 lsJ6MauNolCHs12Jx8l+KTBhKMDQOfn5gtQ8womzAZQd2uuE+TLnYvR2x7fg40XWt/
	 OHxbeHZ0lDMzbZaBoAGuqJyKknnfJ/cREkkVQNUo8x/btCxbtNxGQWqmjGjSDFHOP/
	 CdgDoatzyNVI3rVsdh691fY4I80MSVyRQw8tAe4QOOXeKg+EZXBeARDLk3yJCgRayr
	 xGAIPpBRKJ/cjEFr3ziVGKRmJjDuyW9Gwn1e4QqJAP3h2TykBRwZQp1Sn+Iw/Q2idu
	 KowAn59+UuUPw==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Tue, 24 Nov 2026 22:59:41 +0100
Subject: [PATCH mptcp-net v3 24/50] mptcp: count a listener once when
 listen() is called again
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Post: <mailto:mptcp@lists.linux.dev>
List-Help: <mailto:mptcp+help@lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
List-Owner: <mailto:mptcp+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261124-mptcp-cmason-fixes-v3-24-416c0920c73f@kernel.org>
References: <20261124-mptcp-cmason-fixes-v3-0-416c0920c73f@kernel.org>
In-Reply-To: <20261124-mptcp-cmason-fixes-v3-0-416c0920c73f@kernel.org>
To: MPTCP Linux <mptcp@lists.linux.dev>
Cc: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
X-Mailer: b4 0.17-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=2837; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=k8aJr5YHDlsRkiaK+5wHnKasKWSA4Fz2iZIpeK6eDno=;
 b=owGbwMvMwCVWo/Th0Gd3rumMp9WSGLLZOFkV9vyw2dfDv/P1y1ymkNy3/DMudwrI7zt+4IRUJ
 udRx92nO0pZGMS4GGTFFFmk2yLzZz6v4i3x8rOAmcPKBDKEgYtTACYiv5uRYaF3FquQMntl2Jze
 Vw953z79z1xtvH/rHY/a3JIt02ya/BgZlqkc5zvye5fgq3mXGpQPuM0sYNhzvOnU6rcbVs28mcf
 kxAgA
X-Developer-Key: i=matttbe@kernel.org; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

listen() on a listening MPTCP socket only updates its backlog, as with
TCP. But mptcp_listen() then counts this socket once more in the
"sockets" column of the MPTCP or MPTCPv6 row of /proc/net/protocols, and
sends a new MPTCP_EVENT_LISTENER_CREATED event, while only one decrement
and one MPTCP_EVENT_LISTENER_CLOSED event are done when it is closed.
Each extra listen() call then leaves the counter one above the number of
MPTCP sockets in use, for the lifetime of the netns, and a userspace
path manager can see two listeners created for one closed.

With TCP, the socket is only counted when it is hashed, which is not
done again for a listening socket.

The fix used here is to only count the socket, and send the event, if it
was not already listening.

This issue has been found by an AI code review agent, while reviewing
the code of the commit "mptcp: pm: kernel: count endpoint listeners as
sockets in use", and confirmed with a new Packetdrill test, and with a
script calling listen() twice. Without this patch:

  listen_listen.pkt:12: error executing `test $(awk '/^MPTCP/ { n += $3 } END { print n }' /proc/net/protocols) -eq 1` command: non-zero status 1

  inuse: relisten: listening: 2 (expected 1)
  inuse: relisten: closed: 1 (expected 0)

The extra event comes from the commit below, and the extra count from
commit c558246ee73e ("mptcp: add statistics for mptcp socket in use"),
which is in all the stable versions having the commit below.

Fixes: f8c9dfbd875b ("mptcp: add pm listener events")
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
v2: commit message: explain the two Fixes tags
---
 net/mptcp/protocol.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index b1072123397f..c57bfedc86a8 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -4568,6 +4568,7 @@ static int mptcp_listen(struct socket *sock, int backlog)
 	struct mptcp_sock *msk = mptcp_sk(sock->sk);
 	struct sock *sk = sock->sk;
 	struct sock *ssk;
+	bool listening;
 	int err;
 
 	pr_debug("msk=%p\n", msk);
@@ -4584,6 +4585,7 @@ static int mptcp_listen(struct socket *sock, int backlog)
 		goto unlock;
 	}
 
+	listening = sk->sk_state == TCP_LISTEN;
 	set_bit(MPTCP_RTX_ENABLED, &msk->flags);
 	mptcp_set_state(sk, TCP_LISTEN);
 	sock_set_flag(sk, SOCK_RCU_FREE);
@@ -4598,7 +4600,8 @@ static int mptcp_listen(struct socket *sock, int backlog)
 	release_sock(ssk);
 	mptcp_set_state(sk, inet_sk_state_load(ssk));
 
-	if (!err) {
+	/* only the backlog changes when listening already */
+	if (!err && !listening) {
 		sock_prot_inuse_add(sock_net(sk), sk->sk_prot, 1);
 		mptcp_copy_inaddrs(sk, ssk);
 		mptcp_event_pm_listener(ssk, MPTCP_EVENT_LISTENER_CREATED);

-- 
2.55.0

