Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.52
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793560904;
	b=Ra/iNT4KuEy1viOv31hqveHyilA1Z4kLpLSl7jlEPISSVZimAuaoLyETpD+cnDpa5xZV
	 euZmMCUmqXzF4e9jITiKtXJkv4Piu73Rtx/YAEiOwzAhP33QTKxpgpapm/OhyBS963jaM
	 enikxGjt/uQ1EQ7l547zXnzITa8tHt7ad8jD7D67lfkEj0G2vZ2s77esSUS6JBSIP9bYA
	 mllTSSiShwGpOs3WAjoC+BhXoaOfWXjISBl25KovJeb5fbOJgaIW3OcjHD9bPJQRdTEj2
	 3wzyYQa5Wtkcm2JMrdJ+HS9ww9lgl54Wpdigjus9iZ2COsw7ppr6fZz2vRb+pD8BRzw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793560904;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=SzMjUS+/JylIFqehNQ/NUtqKceY36ervniTve9Rd0yE=;
	b=iPgaClv8lumD+6espjLxqovicEwGntpmsGsum1tffoNu4bW8n+GBkYKMHFKgSu/ZK28Z
	 67N1EFM7ig2EPjXG6FKvB7HpceR9wTWhkY9kjZu/O6WilZn6K3lsgnsccd43bi5NIaIoI
	 xYHS+650a0wMJQu0ad67lpaetFPZ4EM8zplF426GthuPQ1a/+x2hbsOXDHtL33kDHIFcq
	 DGa9WtGLcXWJye4G+xVUqgW9y5knr3lN3MYeVVOjo9pulq1m16LUxdMekvBrbqy2vU9Xc
	 BKZahg73busBqsIaNs3l84RkNOHoghid/ObKnl2CLRQWafuxad24zie9/ULjWnue5jw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b="TAS2mQr/";
	arc=none smtp.remote-ip=209.85.216.52
Received: from mail-pj1-f52.google.com (mail-pj1-f52.google.com [209.85.216.52])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A0EA606A324
	for <mptcp@lists.linux.dev>; Sun,  1 Nov 2026 19:21:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4A0EA606A324
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=TAS2mQr/
Received: by mail-pj1-f52.google.com with SMTP id 98e67ed59e1d1-3aded3c6103so1048765a91.0
        for <mptcp@lists.linux.dev>; Sun, 01 Nov 2026 11:21:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793560904; x=1794165704; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=SzMjUS+/JylIFqehNQ/NUtqKceY36ervniTve9Rd0yE=;
        b=TAS2mQr/QQq7q0+YnDpMt4sN2Qpmgz5k6xzqiq8vFH0Zj4IbC/oLDW/xr7A3Qr4GPq
         XG5mS3BcVPIHsH1vrlkP+SUxJadKwygxMRjnEKrPz4pnMFAxK0IhqNUSyDIn6y4npxaQ
         ZWBItFeBNarcFVYoC00gkXSVAlFT4jWmKi71ml3WMinAlye94N4vcWSdC1+D5xDdZLno
         rhG/9mHmB99b06uxZA9zSOfxUeKYtgy9PjgYMiD7lFbGh0LV2qh9VEmrsMkG832pcuU4
         5/zN63zc6Oca1Dq49QDXacBjblEAFQ4ilvWkqd6JCLKgfxwSTowLJ3yF6+HHP2kUas1W
         og1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793560904; x=1794165704;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=SzMjUS+/JylIFqehNQ/NUtqKceY36ervniTve9Rd0yE=;
        b=X6HGS13L2xeUl2UgJjGgM7+A3/OxPfLgA2fhMHiu75TCsSYoQhWIPwu+DOGooRte2Z
         zUIObSy64YyxzMjTUYvEA/MrTeObBdaoK7QRKiPyHDAlXf8jyGumfMjUcg/UyrJdPViL
         bukEr1BDB6llq2o1JsQAVtmihjfubNywGXirjKj+CuR/f0E9g95PCwZ7h+90bn2C5On8
         k0r229QMvuuD9EyT0FTTPqHFr1m4Etiw0yWwTjIRmUirkid0zovWHa6bIrCWoicemXX1
         cWTM+9W6ofKWjIQ23noK/waGqJAZsZFLtSs0OYrpEVAFqZ7SSwgaSUcxsmiRgVJe+LYb
         VRKQ==
X-Forwarded-Encrypted: i=1; AKwUvBzoeJre8tsUXpy+Ob+oQg3a50/HwunAW1H61mbwhR4xeU8EjqyxfDrtjBl56lAGaS1LHssyOg==@lists.linux.dev
X-Gm-Message-State: APuU4Z/VdAGqoH4ztbExjebkh4u9eM1R31Dv3prqMun4q5Kdds2Yb0aC
	2UkGk7pTCj4rTIfSwpeFE8b2PVXG6At89hUbng9f+gQctkRLlQroBb8g
X-Gm-Gg: AYBFou0gC2GUSFQsKjvVwsblolQzr2apohwSI48z3QMIwjwXw88+l31JdUHy46wTSdg
	ESUo2cJ5ZFipY9zRlIyeg34sfSuOlfa3ECVW008OzweFd9ohVERqN3tLbvPgl4Jos6VTRssatuT
	mLtkxjAfU30Vg0UJtG/q7vy9LQy7Hyy2473rFmh6zgOF+SFYhIpjq/DHuiuIX2arkXImTEqembz
	ppuflsHDpq3bdfTmD33CuikPnpcmyORxbO+FJHZ9XPvphwNDTMrM/qKZc/lEgX6GT0Wdl9YmuM0
	ENr2SM58vSC80d1s+SeCPLtgRWLaZ+pddcue/M7sYpMWP4oun8S3kQHF4S5nlUdr5g8Rb5mO/J3
	8hVFewfcwePFT0tqmRiZsiLEHY0Ou+TfW0F0VU/D0m+fKboUQ2djh5vwIsI4QFJUB6h6FpbeZI1
	LwSA2wWXHkmFuVTcCr4msI+ZYUSPK6LGmxtus1Y70jVy3jvMTmdTNKk00eQVzWgEOJZ9r2nKipw
	0srPHUk8Tn//BnQmsZ4azVBjHi81k/JPWPIpkLOx5d36Q7fwnM8UlWPhAuV/t2RRAV2m+FB+aK3
	ekBsfCRqFgh6eoPIoQSDk0efyFEiXJEq4H1kKbwZ9gm/Ds+0STd+be9MIe2J3AMZdQvGjWRqrZp
	sewRoRZGaUwAaABjYiicUl+TXyKELeivgm+6KBe6pexUkfXf6TKXsDbalxJghBlJ+Xr/6fBI+kw
	==
X-Received: by 2002:a17:90b:3f84:b0:3ab:b39f:41da with SMTP id 98e67ed59e1d1-3ae89776af6mr6425348a91.11.1793560903588;
        Sun, 01 Nov 2026 11:21:43 -0800 (PST)
Received: from coder-ast-ast-dev-ml-0.tail2dda0.ts.net ([153.61.198.250])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3ae85cb1bfdsm7009849a91.0.2026.11.01.11.21.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 01 Nov 2026 11:21:43 -0800 (PST)
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
Subject: [PATCH bpf 07/15] bpf, sockmap: Check the target of an egress redirect before each send
Date: Sun,  1 Nov 2026 19:20:49 +0000
Message-ID: <20261101192057.2296489-8-alexei.starovoitov@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261101192057.2296489-1-alexei.starovoitov@gmail.com>
References: <20261101192057.2296489-1-alexei.starovoitov@gmail.com>
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
index aa904ded816f..b635d3ebf4fb 100644
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
@@ -547,7 +569,7 @@ static int tcp_bpf_sendmsg(struct sock *sk, struct msghdr *msg, size_t size)
 	int flags;
 
 	/* Don't let internal flags through */
-	flags = (msg->msg_flags & ~MSG_SENDPAGE_DECRYPTED);
+	flags = (msg->msg_flags & ~(MSG_SENDPAGE_DECRYPTED | MSG_FASTOPEN));
 	flags |= MSG_NO_SHARED_FRAGS;
 
 	psock = sk_psock_get(sk);
-- 
2.55.0

