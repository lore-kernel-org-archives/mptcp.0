Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 198013AE195
	for <mptcp@lists.linux.dev>; Thu, 28 May 2026 09:27:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779960455; cv=none; b=XS4zM++T7aav8tTZbE/gNxeaSomfkr5mmqxTzuEHCOcyqg+uqzSFwk2QtvwjDuScT9wopE01fO1je4qoZxev1i9aeRtO8W4OuvjW5VJ3bvoYemESvOwoevQ0Tr3W2ZOglg43/V5kMXwDmkz/hcJNHkHuu5Krlxyn7gXeEaNB7mU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779960455; c=relaxed/simple;
	bh=IK0C/GZlOHo0QcI8yuMhPUHQEt0Y/udby3W879D/eAY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=uPoDVVxPXMNsSAwA4p/IEU5uXGp0L9d3jg/kmz0enBkR/zioimtWks5OhHipDw6NH/Jor/liGD5yVECLS+zaXS00iENrA7hWfWVBw0mkjoHTqZ1yYiWAgYabvY0qAb6BRVYP7HOV11sNliHtsespUvHl4BofbwpxA++voWwzvyk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=I1snOsEH; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="I1snOsEH"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 335051F00A3A;
	Thu, 28 May 2026 09:27:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779960452;
	bh=7B4d8pf6FvYKR3lgfy1IJmPLFaTmVxB3JmqsO6iCS8A=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=I1snOsEH/bvbFC5i9+vc1Y+Wp93/ssVzMojqIpHUHwcGZJRrilPe0A88KuQ4EKV7h
	 DpPaGmidva7C2fhz9+UjobjwPWXIO1Miu5fNgL/Rrm0DmL2sjDvZ8RJINLAHqZh/6Y
	 3l/m3s4mFK2e9nA2kdVq5XdF2/JDs1fJR4/U7LpmfIe7Z6I+TftI6a2lBhme+Q7gI+
	 xEQ754MJ1RZvwX4WZ0ho/NOH27t3cyQlNc+ccyh9BdSAPb1hNdrDh7KM3dr/3sQhgb
	 qGDl5FLMQE2iP7L38im5WMmEiuK0w1eBwWThaXKSy56IINFziU03XMnJGlZnwhtQmi
	 PLwMpqARdB8cw==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>,
	Gang Yan <yangang@kylinos.cn>
Subject: [RFC mptcp-next v21 05/18] tls: add memory barriers for lockless accesses
Date: Thu, 28 May 2026 17:26:56 +0800
Message-ID: <fa1b15224f2938fded78e178aff896f9c4955f8d.1779959644.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <cover.1779959644.git.tanggeliang@kylinos.cn>
References: <cover.1779959644.git.tanggeliang@kylinos.cn>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Geliang Tang <tanggeliang@kylinos.cn>

Add smp_rmb() barriers in tls_sk_poll() and tls_sw_sock_is_readable()
to ensure proper ordering when reading the TLS context. These pair with
the smp_store_release() in update_sk_prot().

In tls_sk_poll(), replace the direct call to tcp_poll() with an indirect
call via tls_ctx->prot->ops->poll. This allows the correct poll function
to be used for both TCP and MPTCP sockets when TLS is enabled.

Also add a NULL check for tls_ctx in tls_sw_sock_is_readable() to safely
return false when the context is not yet initialized.

Co-developed-by: Gang Yan <yangang@kylinos.cn>
Signed-off-by: Gang Yan <yangang@kylinos.cn>
Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
---
 net/tls/tls_main.c | 11 +++++++++--
 net/tls/tls_sw.c   | 17 +++++++++++++++--
 2 files changed, 24 insertions(+), 4 deletions(-)

diff --git a/net/tls/tls_main.c b/net/tls/tls_main.c
index dab69488214b..b463c9fc2908 100644
--- a/net/tls/tls_main.c
+++ b/net/tls/tls_main.c
@@ -482,14 +482,21 @@ static __poll_t tls_sk_poll(struct file *file, struct socket *sock,
 	u8 shutdown;
 	int state;
 
-	mask = tcp_poll(file, sock, wait);
+	/* Paired with smp_store_release() in update_sk_prot().
+	 * Ensures that the read of icsk_ulp_data (tls_ctx) is ordered after
+	 * the read of sk->sk_socket->ops inside tls_ctx->prot->ops->poll().
+	 * Prevents seeing a new ops pointer but a stale (NULL) ulp_data.
+	 */
+	smp_rmb();
+
+	tls_ctx = tls_get_ctx(sk);
+	mask = tls_ctx->prot->ops->poll(file, sock, wait);
 
 	state = inet_sk_state_load(sk);
 	shutdown = READ_ONCE(sk->sk_shutdown);
 	if (unlikely(state != TCP_ESTABLISHED || shutdown & RCV_SHUTDOWN))
 		return mask;
 
-	tls_ctx = tls_get_ctx(sk);
 	ctx = tls_sw_ctx_rx(tls_ctx);
 	psock = sk_psock_get(sk);
 
diff --git a/net/tls/tls_sw.c b/net/tls/tls_sw.c
index 4cac7a90851a..f944a22b7873 100644
--- a/net/tls/tls_sw.c
+++ b/net/tls/tls_sw.c
@@ -2451,11 +2451,24 @@ int tls_sw_read_sock(struct sock *sk, read_descriptor_t *desc,
 
 bool tls_sw_sock_is_readable(struct sock *sk)
 {
-	struct tls_context *tls_ctx = tls_get_ctx(sk);
-	struct tls_sw_context_rx *ctx = tls_sw_ctx_rx(tls_ctx);
+	struct tls_sw_context_rx *ctx;
+	struct tls_context *tls_ctx;
 	bool ingress_empty = true;
 	struct sk_psock *psock;
 
+	/* Paired with smp_store_release() in update_sk_prot().
+	 * Ensures that the read of icsk_ulp_data (tls_ctx) is ordered after
+	 * the read of sk->sk_prot in sk_is_readable(). Prevents seeing a new
+	 * sk->sk_prot (TLS ops) but stale (NULL) icsk_ulp_data.
+	 */
+	smp_rmb();
+
+	tls_ctx = tls_get_ctx(sk);
+	if (!tls_ctx)
+		return false;
+
+	ctx = tls_sw_ctx_rx(tls_ctx);
+
 	rcu_read_lock();
 	psock = sk_psock(sk);
 	if (psock)
-- 
2.53.0

