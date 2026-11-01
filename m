Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.45
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793560916;
	b=14vDvg2OfMWmNFUiO82XiIlouyN/mtfM/V8WCLZQodxbgYkgUOCJE9JYhaiOTC2lLL4D
	 f7JLqyAhMCdqRF5IKXagdoU4FGPur1ZTO2QaeN/bktKI72d0xIQmTB8QsIRWhE9sVzAXQ
	 mAmVZXf+AYKAyyDkA8lQGjNH7vrVEw6ztuTA/MhIRmnXPNOJHC6wGa7erxa0ILYnLOZ8O
	 +HIJIev4HO311EmKyv18vhFa4/CvfbER9phCGWUQo+FP4vwRl8kT53mBmuKVBNAbwDNpG
	 LyFPutSL+yJOOmwEJZHiyec2ETT9qLqTC+/8foUpMFyphYgAKihpZ4E14jCPD/wbK5Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793560916;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=iEAaFxE93Z66HvVgBeBCzXXUprLmZg1keqaBn6ibVEs=;
	b=SEoDpszyWjHzp5NF5/EupHzu5oF3xuX+v1Y8+W4ZkWfR5OJfFKw5agTWDknVm3ZB8r88
	 E7gWNIoF63gLx2kOaYRrhPO0kRiAkjrcCMu8O9ZK+LVv7WhsH3Ynd5q36mXVIuqJF3FWt
	 l7Mgab+cX21KeaDNIRERXedi8ncL+1XJy1+QbxA0FuBnoliEr1t4cvGeGmMJ82+1Hg12O
	 k4HxsV9GSHUsiz5RBFGMhjtUtxLQEl0vU8B9KHYa5AA8mA23Vx4rUVNinaMOKEwcpsKFs
	 oAjbUb0Q4wD7AT1b/dmu1t5UG6zvfXzxrjbe6X+eWwLyNz9zaugrNcZ8Bk+Vv8csl5A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=lLxPV6Pv;
	arc=none smtp.remote-ip=209.85.216.45
Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com [209.85.216.45])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A86E606A324
	for <mptcp@lists.linux.dev>; Sun,  1 Nov 2026 19:21:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 5A86E606A324
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=lLxPV6Pv
Received: by mail-pj1-f45.google.com with SMTP id 98e67ed59e1d1-3acb11973c3so1799540a91.3
        for <mptcp@lists.linux.dev>; Sun, 01 Nov 2026 11:21:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793560916; x=1794165716; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=iEAaFxE93Z66HvVgBeBCzXXUprLmZg1keqaBn6ibVEs=;
        b=lLxPV6PvUhquYwJFPWdzeVD+rR83N4dRpsoMO1e9FSUfMKwWC0Xo0nlYjZvavLHb+F
         cle8U0s3h7NYfYG0IHl/7d4O0C0t6r9hoedoBuUyZfIDRIT4FWRsV+y7vXmprmikaX7/
         NCtISXjfFbg5G1Akfa3d61lPyuixxCQQeR3D6f4tuOR/DJ2WV5QokAQm9jFotuZ2AfW1
         sdpDWa2oh1euHtgqiR/2R5ay5ewvb8j9KjV+J5aPfUCY6iccOIy4ZUzuAJ/6hEouRYNj
         5dmjghhu1kyodTw4FrwVjpkaqKJw8u8elRd/8/ADBiVsRfscIdwJ4f+dRgYPBzA/UB1H
         iJcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793560916; x=1794165716;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=iEAaFxE93Z66HvVgBeBCzXXUprLmZg1keqaBn6ibVEs=;
        b=TundlVEaOEYnW0/zcgOIjBItqPToWWOaylPhJGp/2qlt5D8U1T2ab08n1bei6ovrWt
         os0IS8SoOXEsxIT+2fCKUshB8vJ2+R2Zk3QUgrvEt54Xt8IYCZBT8YOvuhHS0iZ8K2cN
         PoXIwEcfw3KtR/6C7pSbN0Eho9z57pDoujHXN4Hc/s/nDTayWeKO9sS/6Rw3IRj4a1uU
         fef6+Bd3m9paIGOLplzkXlzcJ8NVa/PmKMT8m42I7o5WnkfBuOlsbW2G2E3a9gja/333
         u8LokJmkRYESdbQiUprRmAkdsHGjUrNo4WNvXUP0b/tWG5Yi4DVwwQcDxKpbBWpOZGpt
         jVdQ==
X-Forwarded-Encrypted: i=1; AKwUvBwNL2dVlVt9avgAZ41dSEN0RgM/EYEkFgITrLOf9Zpf0zJwiZDzc33YNR6KQIhqY8CBP/Dgcw==@lists.linux.dev
X-Gm-Message-State: APuU4Z/6RQf3pKw/Cw+rMp5+Ad5xwsJHwTWrAUyE44VsAFi/ZyWe4XY0
	RjMCXDyZ9mfXP85AZzPbzmInzYfgebU9OnfxvCamXou0kvjrPllYxkL6XaXdAw==
X-Gm-Gg: AYBFou2ShI1Pfpt0eRTyZxhndciAzTy+rJYddUauQYo1rRS7ui7Ntza38XNvthxn6v2
	yyVDB4j4uxgZTE+OrhOo0RsgGNc51eM4kDxH/v6bx801qtletgc2u0Y1Vjo50OXN6VeuyWEA/51
	yQD9sOl4H+QTxRPeDmAC/256v1P/8fAhnSLdxJwetOvw1fBEi4mdOrKl8yL2wNbkX+V6VFGR6su
	K0/UKy0iPHzoL2bQk9W72rg6yZBD9/hp/lBT0XbtYckLniScwTjDyWlEsETv1YV2wmS/ylqmQdy
	dAuohvKA5jXHr/LNEtf38oJsfWMR4pBIxyF/ZW23bKz7PGhu5SxUN26ny2ZPNXh9S2HvQU+lL8b
	CxWnAU4mpPRU9E1uEykZ1dH7rbZ7SL1RDh2ptkcm2ray+ORcInb4Wy3PSH5F+aDmiIHIYo62YRl
	6TcEyahYEbTq5TEK0YPp1sPbH/XXy8YMjUZ2Rt4EiHisIOHUvsMr8iuOyRqSd42WHz7k60Fuj/T
	KW8IBkPwTxRiIJHDSMp64MN2eYNWptTWJEgLgGTT98Rf7Kms6XuIHWZUX/eLyctMBbMBG8D2M1j
	+9SsyscwFfgm4VTuTCp5PlFOIp61nsWn86pMxrhf/7sAkc7wkgmtgTew25mGxNSkjkzEciVAk/Q
	MM2RBtKLfe8Xz5uQtgqJ0AITh0En8TRTGW1KoAI5c5y1mpyRG92CXzVgOiM91ui8tfLO4hN0h9Q
	==
X-Received: by 2002:a17:90b:2641:b0:3ac:8446:c1b5 with SMTP id 98e67ed59e1d1-3ae8974b804mr6354294a91.31.1793560915674;
        Sun, 01 Nov 2026 11:21:55 -0800 (PST)
Received: from coder-ast-ast-dev-ml-0.tail2dda0.ts.net ([153.61.198.251])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3ae87fc548fsm6851876a91.4.2026.11.01.11.21.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 01 Nov 2026 11:21:55 -0800 (PST)
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
Subject: [PATCH bpf 09/15] bpf, sockmap: Check the TCP state in recvmsg()
Date: Sun,  1 Nov 2026 19:20:51 +0000
Message-ID: <20261101192057.2296489-10-alexei.starovoitov@gmail.com>
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
index b635d3ebf4fb..9848c8e5a2cd 100644
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

