Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.215.182
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793604137;
	b=Cu7tr1yVQYrTrIkNWRzKYHCpjVnfv8jQW/eFfAk8Gm0rWELpR6a+3QOv9AjQySwvBxfc
	 LHwpp9JvLx2aDkKBQW4ghshQvbRFgRRHXSF/2W4kOXcyJLuejmZHNlyzMOJbiEvh2g5Zh
	 6IHmDVWfleTeRNyILV7AAlPZaK+CvOzISQufBPpqUAh1o1Ln8ZSohgQToqXZIo6Dqq/fd
	 l8At4J+UGXtf9NiRpt+HcyG3JHryWwNlTN+C0R1Mbd/CZeQ0bF9CyTK53xvbXnkrL70Ur
	 m8eYK+5BoZ1358dGiNQi/BEywRnwjoRg1V3V09c1RhFDNCHWoP7VD2RbT/XvGUZTiOw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793604137;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=IIVQCChPoYZLHDZpOQjjkNqmaU+lbodlGj9e9gYxfdo=;
	b=wbkpRUn1Ir+1PYvgotqvbiOe40Ov9wyP7m3xBySTU/BjWzYForbWCudvJVRSgEb1o6gB
	 qMRbuDrrxjcBbBVndZaXX/sdZxQ6b+Y1S00W27TjBotN561hLe9/3iCsGWsu5Y77BYPRs
	 b9TEWWrcOYUDJOKVZ3VFScdjfICweikzc9q1KxYxgJd3apRIsbDGhrX8JBBskt9d4gwk4
	 WKMcCNvUKYg6dvCM4YWdfvIyTAgpYuVAoV6h1KMPDZpjbnDxbtY55d6bj7uDZXHJndtJc
	 tQxWDIWbngkI8+F/OkqJga84AefZaL7V0HWWsJQwo9dmqOdJI4iR3pyOj0+tJ5R7Vng==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b="gCH/rFkZ";
	arc=none smtp.remote-ip=209.85.215.182
Received: from mail-pg1-f182.google.com (mail-pg1-f182.google.com [209.85.215.182])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA7E2606A32D
	for <mptcp@lists.linux.dev>; Mon,  2 Nov 2026 07:22:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org AA7E2606A32D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=gCH/rFkZ
Received: by mail-pg1-f182.google.com with SMTP id 41be03b00d2f7-cc1bc88a20eso1818252a12.3
        for <mptcp@lists.linux.dev>; Sun, 01 Nov 2026 23:22:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793604136; x=1794208936; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=IIVQCChPoYZLHDZpOQjjkNqmaU+lbodlGj9e9gYxfdo=;
        b=gCH/rFkZuHQ/6/aC4NJCvj0DzWhcWjYJab3ad5vUiWZZTqHRS2CBTr2l4jCVjIoUjO
         SMHoMZNJuMExg/OxEtjoHPD3KDuwihPM1pnoC21gV2h7jYmiMnRrOGKnITI2PXKwfWZy
         OusO1w0L3i8IaVLa6xTCx2pKNuOBJOumLPPquue84aTAueoJF+eZfAJjNqiH06ZmKD/X
         gG61vkOfAf8WsZaGOFVD5JxIpnDLM5YX+i9ED9TRhotWmMccgS6W7RlEZbAaw7QZDvIE
         L/pkUf9EaDTTdBp3PEA3tLQh+co5fqtb2hDkbMuHd4q0s7lkYbltkb+X0mavXCdUVd14
         4Ijw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793604136; x=1794208936;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=IIVQCChPoYZLHDZpOQjjkNqmaU+lbodlGj9e9gYxfdo=;
        b=wVo6iaP4E5L3lrrYfdh8L/K5q70s1FpDobxpZ0/+wk57FfPcfDCEXScAt3Leg9pRuk
         QnW6ELe6UqjmmEX23LYiyQMz3DUGw1k10gGHFbF4oWj6XsOJ+ZjK9x5WmWW5cFNcLCf6
         qXmKZ3tcjgJ5IGF9KuSA33lZEjPqqkMDPMQ6WGbB+GSCgfdvXwK/zQlLF76sr7TePRIf
         owxlt+fgcJaGRVUqGkA8Fi/zFf3ti+o0hu4TrJFd9lxPRGYvxanI2Rbhug8j1Jo262FM
         BRg+NQX8gol3AgAVyhZ4t2abrNfhlb7baqqLZlSOIFBiPweeP4wpw5APEj/+JMfs55Hb
         XvbA==
X-Forwarded-Encrypted: i=1; AKwUvBxOsb0cbLLUW3LlfZl+SrRg038kiXnVHrMQVv98wK4dScUg450YxoDZ6Nu/wweROKN+Cw/nSQ==@lists.linux.dev
X-Gm-Message-State: AFq9FYJg1z3GPwDqLBV+mIqVmwJskOkVVm+Du3xTCJhn3AwyaSbsJjCI
	QeGF1ceu6c5gDMtDzdXNpTx8tSUoENxmU4M9h9mMRU7vecxI7lB3n+xM
X-Gm-Gg: AYBFou0zE7NjyI9IlW6EJRpkAj2pjiSqeaaIREEEIkZrFyurMY2+1esNgfpCuknI+Fz
	LDecLqbIUcuQhxC1OGOpYp1E6eevnzP35eiLTiMWFbpqCmkYEJNxNaPtG10JGCcFRkizZ5ksMoJ
	4k79BsjDU3XLaaEgYik0dz3XWmrRuotAqHwXxi43GqkoWIAYb4mnnuXFbArvkVHrFNz7LwD+uW6
	tlWRdnPzs00WPPAweatsxzBZjx6PKeZeKjrUPJQmnMYxqk/fRdBocFd/JlIysSl1CpT5bil6gFG
	OAWQ3CUYUT1WBnlxxE+1xzXjRtx0eLwE8HDDDAaeee2TUnMgRya/kxIZiyj5CuwalCbb6FNep1D
	inOZoejdTbhzU4Ae8mUWzFcsUo9yWlXsmegEobCXBhFrzlxjvXfjSgypQ7V/JoXTPqe2gUp9o0B
	5UxjwS6/mEVNpqhnGvTfvyKLvXCAUtDCJb9BjsR47OFfefXKXGgA3SN3PiwUPWm0xBu09Y0oCQP
	5i5f7FOW1gfvtxHWDLyKS+dfChkEP+MmsxxNaIrychgeUrID+/TubFDMVZ0WDg/RE7YKy39y1NK
	akLZPMjS8Ql2VkbzAYY9aJ1nMImwvvKpjcdokCaIe+8ckHJMvcnw/a2AH2h3o+3B9bU0+EihRzu
	v7JjlPLl7CMmQfqQkNAiS2QxquzucdCntRUspUSydUbLZLbd+1IE6gEeS9XrNDYGhFGoEze1KwQ
	==
X-Received: by 2002:a05:6300:6bcf:10b0:3eb:6198:7068 with SMTP id adf61e73a8af0-3eb61987343mr628123637.17.1793604135777;
        Sun, 01 Nov 2026 23:22:15 -0800 (PST)
Received: from coder-ast-ast-dev-ml-0.tail2dda0.ts.net ([153.61.198.240])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-cdb096d3827sm2894741a12.12.2026.11.01.23.22.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 01 Nov 2026 23:22:15 -0800 (PST)
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
Subject: [PATCH bpf v2 09/15] bpf, sockmap: Check the TCP state in recvmsg()
Date: Mon,  2 Nov 2026 07:21:06 +0000
Message-ID: <20261102072112.4160195-10-alexei.starovoitov@gmail.com>
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

With an sk_skb verdict prog, tcp_bpf_recvmsg_parser() copies data from the
psock. Then it calls __tcp_cleanup_rbuf() to calculate the receive window
and to send an ACK. The window and the ACK need a connection on the socket.
But tcp_disconnect() keeps the socket in the sockmap and the data on the
psock. For a TCP socket sock_map_redirect_allowed() rejects only
TCP_LISTEN. Thus the psock can also get data after tcp_disconnect().

__tcp_select_window() divides by icsk_ack.rcv_mss, which can be 0 in
TCP_CLOSE. In TCP_SYN_SENT the new peer can get an ACK with the sequence
numbers of the old connection.

Call __tcp_cleanup_rbuf() only when tcp_can_send_ack() returns true.
recvmsg() returns the data as before. Move tcp_can_send_ack() from MPTCP to
tcp.h. It also returns false for a fastopen child in TCP_SYN_RECV. From its
peer the child has only the SYN data, and the SYN-ACK acknowledges it.

Fixes: e5c6de5fa025 ("bpf, sockmap: Incorrectly handling copied_seq")
Signed-off-by: Chris Mason <mason@kernel.org>
Signed-off-by: Alexei Starovoitov <ast@kernel.org>
---
 include/net/tcp.h    | 6 ++++++
 net/ipv4/tcp_bpf.c   | 3 ++-
 net/mptcp/protocol.c | 6 ------
 3 files changed, 8 insertions(+), 7 deletions(-)

diff --git a/include/net/tcp.h b/include/net/tcp.h
index 3560adddf821..23a22d70718e 100644
--- a/include/net/tcp.h
+++ b/include/net/tcp.h
@@ -1845,6 +1845,12 @@ static inline void tcp_adjust_rcv_ssthresh(struct sock *sk)
 void tcp_cleanup_rbuf(struct sock *sk, int copied);
 void __tcp_cleanup_rbuf(struct sock *sk, int copied);
 
+/* Is the socket in a state in which TCP may send an ACK? */
+static inline bool tcp_can_send_ack(const struct sock *sk)
+{
+	return !((1 << inet_sk_state_load(sk)) &
+	       (TCPF_SYN_SENT | TCPF_SYN_RECV | TCPF_TIME_WAIT | TCPF_CLOSE | TCPF_LISTEN));
+}
 
 /* We provision sk_rcvbuf around 200% of sk_rcvlowat.
  * If 87.5 % (7/8) of the space has been consumed, we want to override
diff --git a/net/ipv4/tcp_bpf.c b/net/ipv4/tcp_bpf.c
index ef2e15de0fe3..3d703f1517d8 100644
--- a/net/ipv4/tcp_bpf.c
+++ b/net/ipv4/tcp_bpf.c
@@ -343,7 +343,8 @@ static int tcp_bpf_recvmsg_parser(struct sock *sk,
 	if (!peek)
 		WRITE_ONCE(tcp->copied_seq, seq);
 	tcp_rcv_space_adjust(sk);
-	if (copied > 0)
+	/* Data on the psock outlives the connection that it came in on */
+	if (copied > 0 && tcp_can_send_ack(sk))
 		__tcp_cleanup_rbuf(sk, copied);
 
 unlock:
diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index 7a22e9388e0e..d62cfbf2d490 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -619,12 +619,6 @@ static void mptcp_set_timeout(struct sock *sk)
 	__mptcp_set_timeout(sk, tout);
 }
 
-static inline bool tcp_can_send_ack(const struct sock *ssk)
-{
-	return !((1 << inet_sk_state_load(ssk)) &
-	       (TCPF_SYN_SENT | TCPF_SYN_RECV | TCPF_TIME_WAIT | TCPF_CLOSE | TCPF_LISTEN));
-}
-
 void __mptcp_subflow_send_ack(struct sock *ssk)
 {
 	if (tcp_can_send_ack(ssk))
-- 
2.55.0

