Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.215.174
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793604124;
	b=2Dcx4LIjJZeBhIwMBi2UDfBgkJ1nGwC7HsgfOMd+SN9Ljik7wv27678QwhDYhTytm6KP
	 KJq9UoLdC7KQ6YUuJOnwH+Iyyoy136Ya3dtM9xKy6Grv66n9cfs0wszqYhMbJ7WkLheme
	 4+Dba2EgaRtFjwy5K2+wZubAseiubl6LJud1SnPPMm0urVNdB4NAZ/2Zgf6dLs6PSzB6H
	 RMHyZ3qG/PwoZGukSdo2FQyWOeNUqGoPbDRPizcC+V5cxfWkd49ckZIqkM3BMMnfGI3OB
	 UOcfcjvTL7RkJZCKDrLe4ZAO2YBfNv97x9TUpt23GDteNhVENj4nl+ZvgVaIxxRyBHQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793604124;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=D4eYPuLg3xUyB1bWOTJ4iSiQffpGBEZKMs2NiPHXGTk=;
	b=GSHIIOHkK6qV7yPEG9EG8Wi/ZHzHb0C8i2dnGPn1zvbPa89qt3vhF3jH2cWecXHKhFQ5
	 tFsJBIKi2OFWO1fCptUugAVpm2jPo2J+H+DMt09aVwLaxi3zT0xKF5k2gUw7/B0NJ5nT5
	 Q8KfhOYEGY7iLbLMlWTanjLFeIS2wk72polQ1iW+FpuFOSCTyauu1EqLVkhSl83zaIayX
	 5BPZkYK9Vzg1x3hSClFCmHPiD+pjBZGFnuI/zlb+OMzhmm5RHqzoEgoWyUyKAGZDHlZd9
	 FuXsIjF8eBgH3dSacSbE8e3zq3AEXCJZKWAS0CxCG+iOGHLJrnixv239YY/loChXtdQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=V1nmTk64;
	arc=none smtp.remote-ip=209.85.215.174
Received: from mail-pg1-f174.google.com (mail-pg1-f174.google.com [209.85.215.174])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5B53606A329
	for <mptcp@lists.linux.dev>; Mon,  2 Nov 2026 07:22:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A5B53606A329
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=V1nmTk64
Received: by mail-pg1-f174.google.com with SMTP id 41be03b00d2f7-ccca948203aso841273a12.3
        for <mptcp@lists.linux.dev>; Sun, 01 Nov 2026 23:22:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793604123; x=1794208923; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=D4eYPuLg3xUyB1bWOTJ4iSiQffpGBEZKMs2NiPHXGTk=;
        b=V1nmTk64x7E80ef6qU1GdhNn9wBQt8VWlcpQ0GTSbFrYDwu5ZSIPhaUrdvaoW76R1F
         6hcdaEOV75Sgs/yIXgft+RNmZ3tKViMnUWk+vgsgsYOeyv0hk+KGHaGagX6KAAkvn1mh
         YmEtLwCIsBZxA02ajznZf/dtu9BdS0iFpmAisoTC300xf7J+CktU2LLaHs1iRRNrtaSX
         2gU39NRPM8nTt+e5wM+spajzLP1RfVpwXdbZQ7v6Nx7ddM1u1QCmf4XdD6JWotfsFemD
         X8ti3YiFiwX75J2uXeKorkVAdiKWcYT53C8M8dII+J9KYamOPALYqKBEi0zsi+E8bnpm
         06TQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793604123; x=1794208923;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=D4eYPuLg3xUyB1bWOTJ4iSiQffpGBEZKMs2NiPHXGTk=;
        b=kh4T5F5SZOpEiioao+xnCLL7xo+kMvqXv79mLv0dC6Ojre0rRZ7031Vtmm6/5WvsAO
         sUD1gvJZ8gHRenXmVh9m0oz7iz+wtKLtVfF7F6Ut837se6H5QlHlJ8CZyszB6+6N4oTV
         Viqo7uv4ibvRRNSTQSI1N/PCUm3snEfBw2qH5g3V223pUmRm2aOtWjm5clzK+TJQTXQ1
         BiUPIN57VHm6Pb0XqW+DWIn/fGu+f3TOw1NQ4gUQjmfsf+Q74/RaC0yxZKyT27xaNMux
         PyhyJbzKUo8rURT7yU83RuYF0vX1BGRldPLlsus7WW00y0qPtfbg5SplnQVqqfBWZFCg
         BElA==
X-Forwarded-Encrypted: i=1; AKwUvBzwiGVhfT0NJkwpWiGyfCAbHNLuoZperv8vF5nYPg5hIcYlazl7DdXumSufv5G2AeUmvJo/YQ==@lists.linux.dev
X-Gm-Message-State: APuU4Z8ENCy60ASwd7GTVrU9PEYmJJLX/MsAMSLYqIiVR+3KYQRtiyC6
	ewIZkxIN++8npEgkY9OeJHygRkb+amik3rABhxlZDadOkI/4NCssaJ7/
X-Gm-Gg: AYBFou2L3F30YYcuwKAic/Ska7QVzoh41dZTTUIAu2LUmCOiZmqa+hos6QJ4+pZi7Cf
	84EYK/83M8AAvE9secqj9mdg2Uhl8ME2AewkEx1aFomVYNBDpHyEabgwallKKMlv1MOnEytVHkE
	JjEkKH1OZvWL/2e02/BXw0azmPlYoyJTlrrzr73z/qiTFq01X1lf9Ubqhs+mCLl7ExpL5v6L8El
	KOY7Zw3a1Bp1+44isiK2JBdTNNsMFV1WoTWtOp+5zC6uweLLtsKPccozfgmWsxA4pUFZtTFIlqv
	qfR2iWETzecRnUl0FC5kyXykmLI+z4k2POcqpE9SKTTj5uyGUH827QbSelbmwJHiaDF3IYcfLNo
	+bB+3kFabB89H7lNIGNX2Nurrr2PplzAvfYgE9E3fRw7ZX7dtKvshI7bV8KNTexpo2rMCvbcEQz
	n800FBd3DuExEjdxZUReTfwTFJ67BNsIKTqNJGfkXuiOLgM2fnCx8CEPd9FYDjDtd+WjUxPyWZK
	3NymtGnS6rcfnYDiE8Yp8TeJrou3px6YqEkUtTI/jaiQcGlpfwi4+ydYP6U7INCmuNBKsaj1PA9
	cc/r6gqnVV9FRTPrXExOPYJDCCl8F1MT7UvkTEVgbd3gR+0yr51GHkBywz3tZzFaK12VjTVPshL
	v53x7an4Fpxi5RBHeMSccriCmTyLm60xs47j2s+jQELdnyBh10PKOxFbBziSiH/pOGZpeq/Y7a1
	Y=
X-Received: by 2002:a17:90b:4f42:b0:3ac:a521:953 with SMTP id 98e67ed59e1d1-3ae897c777fmr7064360a91.46.1793604122783;
        Sun, 01 Nov 2026 23:22:02 -0800 (PST)
Received: from coder-ast-ast-dev-ml-0.tail2dda0.ts.net ([153.61.198.246])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3ae6e944ba9sm17487309a91.8.2026.11.01.23.22.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 01 Nov 2026 23:22:02 -0800 (PST)
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
To: bpf@vger.kernel.org,
	netdev@vger.kernel.org
Cc: daniel@iogearbox.net,
	andrii@kernel.org,
	eddyz87@gmail.com,
	memxor@gmail.com,
	john.fastabend@gmail.com,
	jakub@cloudflare.com,
	jiayuan.chen@linux.dev,
	davem@davemloft.net,
	edumazet@kernel.org,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	kuniyu@google.com,
	willemb@google.com,
	matttbe@kernel.org,
	mptcp@lists.linux.dev,
	mason@kernel.org,
	josef@toxicpanda.com
Subject: [PATCH bpf v2 07/15] bpf, sockmap: Check the target of an egress redirect before each send
Date: Mon,  2 Nov 2026 07:21:04 +0000
Message-ID: <20261102072112.4160195-8-alexei.starovoitov@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261102072112.4160195-1-alexei.starovoitov@gmail.com>
References: <20261102072112.4160195-1-alexei.starovoitov@gmail.com>
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

From: Chris Mason <mason@kernel.org>

tcp_sendmsg_locked() expects a caller that has the socket open. It uses
sk->sk_socket and the wait queue sk->sk_wq. For an egress redirect of an
sk_msg prog the sender calls it on the target without a reference to the
target's file. Both pointers are NULL before accept() and after close().
close() can occur while the sender sleeps. Then the kernel crashes.

Fail the redirect when the target has no struct socket, or when the sender
has to wait for the connection. The error is EINVAL. After close() it is
EPIPE, as today. sk_stream_wait_connect() calls remove_wait_queue() without
a test of SOCK_DEAD. sk_stream_wait_memory() has this test, but it can
still use sk_wq after the sleep. This patch does not change that. The
target can change while the sender sleeps there. Thus do both checks before
each call of tcp_sendmsg_locked(). Clear MSG_FASTOPEN, so that the sender
does not call the connect code of the target, which uses both pointers.

Today the sender can send before accept() and waits in SYN_SENT. send()
with MSG_FASTOPEN sends the data. Today it fails with EISCONN. When the
redirect of a cork fails, send() returns success and the kernel drops the
data, as today.

The Fixes tags are for the two checks and for MSG_FASTOPEN, in this order.

Fixes: 4f738adba30a ("bpf: create tcp_bpf_ulp allowing BPF to monitor socket TX/RX data")
Fixes: b8b8315e39ff ("bpf, sockmap: Remove unhash handler for BPF sockmap usage")
Fixes: c5c37af6ecad ("tcp: Convert do_tcp_sendpages() to use MSG_SPLICE_PAGES")
Signed-off-by: Chris Mason <mason@kernel.org>
Signed-off-by: Alexei Starovoitov <ast@kernel.org>
---
 net/ipv4/tcp_bpf.c | 24 +++++++++++++++++++++++-
 1 file changed, 23 insertions(+), 1 deletion(-)

diff --git a/net/ipv4/tcp_bpf.c b/net/ipv4/tcp_bpf.c
index fd443350f9b8..ef2e15de0fe3 100644
--- a/net/ipv4/tcp_bpf.c
+++ b/net/ipv4/tcp_bpf.c
@@ -88,6 +88,24 @@ static int bpf_tcp_ingress(struct sock *sk, struct sk_psock *psock,
 	return ret;
 }
 
+/*
+ * The target of a redirect belongs to somebody else. A child that nobody has
+ * accepted yet, and an orphan, have no struct socket and no wait queue.
+ * tcp_sendmsg_locked() needs both. See sendmsg_locked() in skbuff.c.
+ * The sender holds no reference to the file of the target, which can be closed
+ * whenever tcp_sendmsg_locked() sleeps. sk_stream_wait_connect() and
+ * inet_wait_for_connect() go back to the wait queue when they wake up, so the
+ * sender must not wait for a connect.
+ */
+static bool tcp_bpf_redir_allowed(const struct sock *sk)
+{
+	if (!sk->sk_socket)
+		return false;
+	if ((1 << sk->sk_state) & (TCPF_SYN_SENT | TCPF_SYN_RECV))
+		return tcp_passive_fastopen(sk);
+	return true;
+}
+
 static int tcp_bpf_push(struct sock *sk, struct sk_msg *msg, u32 apply_bytes,
 			int flags, bool uncharge)
 {
@@ -109,6 +127,10 @@ static int tcp_bpf_push(struct sock *sk, struct sk_msg *msg, u32 apply_bytes,
 		page = sg_page(sge);
 
 retry:
+		/* Only a redirect sends data which is not charged to sk */
+		if (!uncharge && unlikely(!tcp_bpf_redir_allowed(sk)))
+			return sock_flag(sk, SOCK_DEAD) ? -EPIPE : -EINVAL;
+
 		msghdr.msg_flags = flags | MSG_SPLICE_PAGES;
 		has_tx_ulp = tls_sw_has_ctx_tx(sk);
 		if (has_tx_ulp)
@@ -555,7 +577,7 @@ static int tcp_bpf_sendmsg(struct sock *sk, struct msghdr *msg, size_t size)
 	int flags;
 
 	/* Don't let internal flags through */
-	flags = (msg->msg_flags & ~MSG_SENDPAGE_DECRYPTED);
+	flags = (msg->msg_flags & ~(MSG_SENDPAGE_DECRYPTED | MSG_FASTOPEN));
 	flags |= MSG_NO_SHARED_FRAGS;
 
 	psock = sk_psock_get(sk);
-- 
2.55.0

