Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.176
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793557891;
	b=R/hjyz5ZNLN7B7fff/ybP91qelwJcJhImfKoPG28+v152O8pvYGWh9OoSggePQuyMdIl
	 X3Hp80aQXg3eI9iT+v2Egk5A1TJXcZTd7DxcFiIM3lW3wQ3CQb9oLbiCu1iMq/VMxZDpM
	 6XHKZKQnUDdOIPnZ8KSdXXqqqnTz9zbIquez+vWmLoghLlhZBDOoyPNQEk5r81o+BDa6s
	 em4t4hzYI2mlxJZsKGdIduyFttij/Is2fiEJpnUF1dgZVu+8wSas7PEMWI7z8Hh2eTaCW
	 BRuN2sbeRiCEJs9t80kTjSM5RcL06ykY+z0s2LUn9+Ti+7adi3jqoYuq5GRiq/kgAWQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793557891;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-Id:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=tVpS7upRTy3Zlaor6N/9+WDmU5lrwMQoo7X+ts+rJnQ=;
	b=TbnUeKkmYcSJdzqxdzFgEyDAPquVb8bmWDEtwytWGEvYi1/FEYoBcUQ8S2p5o6Dy3o3S
	 mKYzYG3JHwDEZ0OHgLHcjlAPXWV8Ng+q1xulBkbGZXAHA3hM9oIwtWr/leYSNPf1eOPEm
	 vf9NNuxfM6RT3j4JlizkLbpA4kFMcCghlPHHmtqnyIOdX2Howq3RW/Q0X89A3a7mvRa4A
	 nLKov6BJVLIlaJ1HMf4mwd1a1R5OEn9pA+rOvfKwTfm328AhzEyd/L9THlIInCS1GVo+U
	 +fskeHD6DUsXktrkYh7UDMoZUMcQdvnf/+FZZaRAaFql4++ZPQfavdRUIIBEyQghOCA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=VffSCRxc;
	arc=none smtp.remote-ip=74.125.82.176
Received: from mail-dy1-f176.google.com (mail-dy1-f176.google.com [74.125.82.176])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC267606A325
	for <mptcp@lists.linux.dev>; Sun,  1 Nov 2026 18:31:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org CC267606A325
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=VffSCRxc
Received: by mail-dy1-f176.google.com with SMTP id 5a478bee46e88-3535a54bed9so3500655eec.1
        for <mptcp@lists.linux.dev>; Sun, 01 Nov 2026 10:31:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793557890; x=1794162690; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=tVpS7upRTy3Zlaor6N/9+WDmU5lrwMQoo7X+ts+rJnQ=;
        b=VffSCRxcLja9ASNNxiYHv6u8x03i+m/soRDRybRzG3nAFnwABHbaTeDpvVhNjMQ+0k
         oCidYqmx/IHzFz4RDyNzeO6Boeu8CvDEKf41yvMOV1q6Dd5U0vnn85kzTXv7iOVgXpYC
         JpSWcs3hnUqFzN4il3lVPHEQrOW+JfY+AQdhmPlD8PIP6FdJHifgI9BVuNLQY0+tBXlv
         nEG0SI4ats39AYUluWPYEy3d33qgjDad84jPMIRwdn2ie2KmePgFDhhiWdm1imD65x10
         CYEsSAcSTkjJlPvCvs1VR4lHkHkvYmgqZjLUGGqtzGxfoJ5a5knaXScReNimBHUvjEi0
         K8Iw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793557890; x=1794162690;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=tVpS7upRTy3Zlaor6N/9+WDmU5lrwMQoo7X+ts+rJnQ=;
        b=D8ohhCYERvzAiLm9uQN9Os3igrxOtWO7veUfQpifzvE9KA2PfNhx8WCqrGwhk7GyFb
         JnS3kvnSM1WdbMDg7+tHehQOqxg0RZDyoFP0SIqgeEdJpgUb5GSx/XaGI9YjSZ0bTMWH
         07LjiwADFbz6/YDpVkAcTnu1vP1I4W7doyxNCNtbyq+u2JOLo8FcvwPw4kmc9kUo+Sk2
         Tna6U9ZjqAwCHs8IQZ3OK4JBZrIA8tdu8RXwC423XOlicKv+wyXTbGC75pDLv8rofGHV
         4Y0JsJVSs8qcCifNww823QMJ7I9NXGKWIIdhCdqRG8q70kKfWCOsVnxPukg2v1SonVNO
         ocdw==
X-Forwarded-Encrypted: i=1; AKwUvBxS3sBmZWnjCocDIEzkpIya4gt/TulWknQ+112fZkYLcQBFr7YLPajiQt9gyC9RzkSzTO+qfA==@lists.linux.dev
X-Gm-Message-State: APuU4Z9KTshoHnhsNRyqa6P4TQXMiV6SS1jnhUYclhOIC9Bkog0NVdC+
	KSe3tYrSanoB5wnA7q1gRtuAHzQ+DeV9298EMO57QBKtmtmI/tP8efPJM32GkGM7djOhVg==
X-Gm-Gg: AYBFou2/z4Py87hGJJ/AlISAXUSzUvvujuWQ4ySUU+SFGUoyWWGXbkSN3CmI2K6vI9G
	8viKb48RcsxVCivmHSTAj9Q4LK8C1ra7hgZp9rjf0flSXxucR5KYoe194B1yTS05t/rIc6Uudys
	mPAd6y0BBluiVl2gWTyvdrsUH69lwiwwdAO0ixju2IXJw/jjEPDyP5pQD8dqIZbJwZ3nMDUvkLi
	c6uQPBwzewLhlLowvXUw9EIVkgK/GuVOMdHBPiVUrSBpGLa1LNp60iip0jARfSdKKhNb01y/wlp
	S3C+8fpALolg0UHDsnfB8nA+pHz0/N+D9zG/lj5MJ0l6s3KI9LqKBFqHa++M6oP42Q9nTcyAOY2
	xd1O+S85qGt0wZqzqD/iBuOm83pXBEOVaLvNpwnG63ydSjkdCId0HUb8eHGzmedXiAW9vrrv+jf
	Iv8GQYjt0a3XBP9ViWv+/U83FDA+cFkQC3GdfGkiNEJE4W5DUMJGbtwxRRx5f0agpUuP9hf425h
	ysVGKor3eoKEb/VD1z3Dcj6ZSdeUrfkx2J4uiKDMMaOtyCrQ8Ok0qYNeYJlquoEK3D1m9XMfzB/
	v1yCSyMOESqxUdfepansN9sT9A==
X-Received: by 2002:a05:7300:6d22:b0:36a:13e1:c889 with SMTP id 5a478bee46e88-36a425e10f8mr19307844eec.36.1793557889821;
        Sun, 01 Nov 2026 10:31:29 -0800 (PST)
Received: from lion.. ([166.1.190.168])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-36a42a6f7f9sm34627741eec.25.2026.11.01.10.31.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 01 Nov 2026 10:31:29 -0800 (PST)
From: Zhiyu Zhang <zhiyuzhang999@gmail.com>
To: Eric Dumazet <edumazet@kernel.org>,
	Kuniyuki Iwashima <kuniyu@google.com>
Cc: Neal Cardwell <ncardwell@google.com>,
	"David S . Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Matthieu Baerts <matttbe@kernel.org>,
	Mat Martineau <martineau@kernel.org>,
	Geliang Tang <geliang@kernel.org>,
	netdev@vger.kernel.org,
	mptcp@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Tong Liu <lyutoon@gmail.com>,
	Qi Tang <tpluszz77@gmail.com>
Subject: [PATCH net v2] tcp: restore IPv6 af_ops on disconnect of a v4-mapped socket
Date: Sun,  1 Nov 2026 13:27:36 -0500
Message-Id: <20261101182736.430733-1-zhiyuzhang999@gmail.com>
X-Mailer: git-send-email 2.34.1
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

From: Eric Dumazet <edumazet@kernel.org>

A successful connect() of an IPv6 socket to a v4-mapped address switches
icsk_af_ops, sk_backlog_rcv and af_specific to their IPv4-mapped variants.
These are only restored if the connect() fails.

After connect(AF_UNSPEC), the socket can be reused for listen() or for a
native IPv6 connect while still using the mapped handlers. IPv6 packets
processed from the socket backlog are then handled by tcp_v4_do_rcv().
tcp_v4_send_reset() and tcp_v4_send_ack() interpret
TCP_SKB_CB(skb)->header.h6 as IPv4 options, and __ip_options_echo() can
overflow its 40-byte destination buffer.

Commit 8cc3aef0cb19 ("tcp: Do not allow buggy transitions between ehash
and lhash2.") prevents listen() after connect(AF_UNSPEC), but a native IPv6
connect is still allowed.

Add tcp_v6_disconnect() to restore the IPv6 handlers when a v4-mapped
socket is disconnected, and use the same helper in the connect error path.

MPTCP subflows override sk_prot, and two teardown paths call
tcp_disconnect() directly. Route those calls through the protocol-specific
disconnect operation so IPv6 MPTCP subflows receive the same restoration.

Tested with TCP and MPTCP by reconnecting an AF_INET6 socket from a
v4-mapped peer to a native IPv6 peer after connect(AF_UNSPEC).

Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Reported-by: Tong Liu <lyutoon@gmail.com>
Reported-by: Qi Tang <tpluszz77@gmail.com>
Closes: https://lore.kernel.org/netdev/CALf2hKvp0NPVLwr=a3+jUHtPohxbra8gox+aYAfWathJnn-J+Q@mail.gmail.com/
Link: https://lore.kernel.org/netdev/CAL4WiiqFJpmcV4=TWRpukCq6q=-729658FwGvieNcPXe97kLvQ@mail.gmail.com/
Signed-off-by: Eric Dumazet <edumazet@kernel.org>
Co-developed-by: Zhiyu Zhang <zhiyuzhang999@gmail.com>
Signed-off-by: Zhiyu Zhang <zhiyuzhang999@gmail.com>
Reviewed-by: Kuniyuki Iwashima <kuniyu@google.com>
---
Changes in v2:
- Drop redundant Reported-by tag.
- Drop the unrelated watch_queue patch link.
- Add Kuniyuki's Reviewed-by tag.
- No code changes.

v1: https://lore.kernel.org/r/20261030032314.1978575-1-zhiyuzhang999@gmail.com/

 net/ipv6/tcp_ipv6.c  | 37 ++++++++++++++++++++++++++++---------
 net/mptcp/protocol.c |  4 ++--
 2 files changed, 30 insertions(+), 11 deletions(-)

diff --git a/net/ipv6/tcp_ipv6.c b/net/ipv6/tcp_ipv6.c
index e006a30360ea..a93410aab66e 100644
--- a/net/ipv6/tcp_ipv6.c
+++ b/net/ipv6/tcp_ipv6.c
@@ -130,6 +130,19 @@ static int tcp_v6_pre_connect(struct sock *sk, struct sockaddr_unsized *uaddr,
 	return BPF_CGROUP_RUN_PROG_INET6_CONNECT(sk, uaddr, &addr_len);
 }
 
+/* Undo the v4-mapped setup done by tcp_v6_connect(). */
+static void tcp_v6_restore_af_ops(struct sock *sk)
+{
+	/* Paired with READ_ONCE() in tcp_(get|set)sockopt() */
+	WRITE_ONCE(inet_csk(sk)->icsk_af_ops, &ipv6_specific);
+	if (sk_is_mptcp(sk))
+		mptcpv6_handle_mapped(sk, false);
+	sk->sk_backlog_rcv = tcp_v6_do_rcv;
+#if defined(CONFIG_TCP_MD5SIG) || defined(CONFIG_TCP_AO)
+	tcp_sk(sk)->af_specific = &tcp_sock_ipv6_specific;
+#endif
+}
+
 static int tcp_v6_connect(struct sock *sk, struct sockaddr_unsized *uaddr,
 			  int addr_len)
 {
@@ -243,14 +256,7 @@ static int tcp_v6_connect(struct sock *sk, struct sockaddr_unsized *uaddr,
 
 		if (err) {
 			icsk->icsk_ext_hdr_len = exthdrlen;
-			/* Paired with READ_ONCE() in tcp_(get|set)sockopt() */
-			WRITE_ONCE(icsk->icsk_af_ops, &ipv6_specific);
-			if (sk_is_mptcp(sk))
-				mptcpv6_handle_mapped(sk, false);
-			sk->sk_backlog_rcv = tcp_v6_do_rcv;
-#if defined(CONFIG_TCP_MD5SIG) || defined(CONFIG_TCP_AO)
-			tp->af_specific = &tcp_sock_ipv6_specific;
-#endif
+			tcp_v6_restore_af_ops(sk);
 			goto failure;
 		}
 		np->saddr = sk->sk_v6_rcv_saddr;
@@ -2093,6 +2099,19 @@ static int tcp_v6_init_sock(struct sock *sk)
 	return 0;
 }
 
+static int tcp_v6_disconnect(struct sock *sk, int flags)
+{
+	int ret = tcp_disconnect(sk, flags);
+
+	/* A socket used for a v4-mapped connection must not keep IPv4
+	 * handlers when it is reused for listen() or a native IPv6 connect().
+	 */
+	if (sk->sk_backlog_rcv == tcp_v4_do_rcv)
+		tcp_v6_restore_af_ops(sk);
+
+	return ret;
+}
+
 #ifdef CONFIG_PROC_FS
 /* Proc filesystem TCPv6 sock list dumping. */
 static void get_openreq6(struct seq_file *seq,
@@ -2283,7 +2302,7 @@ struct proto tcpv6_prot = {
 	.close			= tcp_close,
 	.pre_connect		= tcp_v6_pre_connect,
 	.connect		= tcp_v6_connect,
-	.disconnect		= tcp_disconnect,
+	.disconnect		= tcp_v6_disconnect,
 	.accept			= inet_csk_accept,
 	.ioctl			= tcp_ioctl,
 	.init			= tcp_v6_init_sock,
diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index 7a22e9388e0e..fdfbc7de2ec0 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -2608,7 +2608,7 @@ static void __mptcp_subflow_disconnect(struct sock *ssk,
 		/* The MPTCP code never wait on the subflow sockets, TCP-level
 		 * disconnect should never fail
 		 */
-		WARN_ON_ONCE(tcp_disconnect(ssk, 0));
+		WARN_ON_ONCE(ssk->sk_prot->disconnect(ssk, 0));
 		mptcp_subflow_ctx_reset(subflow);
 	} else {
 		tcp_shutdown(ssk, SEND_SHUTDOWN);
@@ -3287,7 +3287,7 @@ void mptcp_subflow_shutdown(struct sock *sk, struct sock *ssk, int how)
 			break;
 		fallthrough;
 	case TCP_SYN_SENT:
-		WARN_ON_ONCE(tcp_disconnect(ssk, O_NONBLOCK));
+		WARN_ON_ONCE(ssk->sk_prot->disconnect(ssk, O_NONBLOCK));
 		break;
 	default:
 		if (__mptcp_check_fallback(mptcp_sk(sk))) {

base-commit: 5838f10563d58afca6711edb5e4eda968ca181d9
-- 
2.34.1

