Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.45
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793330824;
	b=MCgUUhlWkTyEyOslu/SI7604cN9iGcAhA2yrELaURUEZSkgaXBUT2mj2XyPyzlRZbQVF
	 2LmpMXZN7POuiIECw+oXPpoQol7HoK6rd0NYL3WInh0Ak+StjuNctxe4m8Mie2E2GdosD
	 kFfqgJso8THM58n4TXjbqPamfb7AbNSV6v9Um5Fib+2y0ia2zJPDuvBkhJaEBU5QxO3Pe
	 aopfOJS3E1doZ092gMOZmYQssjesRL/bK228yq01++ggWC1kvNy/sDVxfL8kmwb4KNq0Q
	 Px9c3hwMyMAHjzDiYUI6SktV0g2CL36Eexa/jtqAlktnvY1800xq4+8WN5KIimWRCsA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793330824;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-Id:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=A6Ni+wahzTnZu0bMH4b4Ekm2v/4N8fmdTpJc/aI6SvU=;
	b=e2/C0JCX/5dlsVUxIwkFkwaFr8theXim/k/5ZkHi1vzruMwWZwrXtzaRemgm8rONV5J2
	 3joNuiJWIHmRJ0rphc/Tyh6GEN8Tkd1r7vZ7fxnq4UvJqSGQefPVU75cqPTuYIK70nNlh
	 zgnLCVDJRNTS7BwO6JlKV3xf1zc3cS8RlaLG8Z41pgE/xhVyO/gzugvesjB+aiolgUXPs
	 WohdxIGu15s0JphCxeIl1ssVIKi8Abi3fycw/wtEdQxS6QUvvApVuvOfK78vdEprngZKx
	 CdXFgwvYq+skUedQst0UG7UoqzdxJ8CE/X7C1VPZKrk4YHO2xkM1xWs49VXiKH16q/A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=iTq5DRU2;
	arc=none smtp.remote-ip=74.125.82.45
Received: from mail-dl1-f45.google.com (mail-dl1-f45.google.com [74.125.82.45])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5848606A31A
	for <mptcp@lists.linux.dev>; Fri, 30 Oct 2026 03:27:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A5848606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=iTq5DRU2
Received: by mail-dl1-f45.google.com with SMTP id a92af1059eb24-1931ff67a29so787386c88.1
        for <mptcp@lists.linux.dev>; Thu, 29 Oct 2026 20:27:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793330823; x=1793935623; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=A6Ni+wahzTnZu0bMH4b4Ekm2v/4N8fmdTpJc/aI6SvU=;
        b=iTq5DRU2RLsnMYY3FbTgByRWKkf3RUwrzmpV4O3tBk4qeXklD4GiJdpgDrIEQ/T4JI
         6LY9M/9+JrcSrtOIg67y4VhWBuU/vNerQ/Xq23fbPhJyNcrCdIQ0CGNBimh+XTVYwiqW
         UDO092THRSppSrwjapkLP8x2XhJ7Yashu3P09lCc6dx4TWCvS/lvOD1qsrVgI6Wbxl0G
         CCFdcpU8V3LnbhhbBYi3I3Ge6J4GjlauALklyuUYkPoaazEP1MjLkn5U+rUM08pdnbp0
         ZNEwAUFBPUCBXlhnE9n1WTxOpPLdZ66Ol6MG3TFytkZks7L+87/Z5VcuMD0QTTHquHWR
         OcXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793330823; x=1793935623;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=A6Ni+wahzTnZu0bMH4b4Ekm2v/4N8fmdTpJc/aI6SvU=;
        b=cSqjQ8SYwIJBtjcstmufwMiYf3YYaZ35+38X26qgCb3kxfsWC0Dkh5Q0oNdVtQpoBn
         eBzfZHW6QdSzsNG78Qk2gIPiOPKkF2E/8DLR7KR3iPa/jsnUkEprphyw3l9heJ0dX7J5
         rLXM5v+5FzsJ4Aly4p2/cQMT8y6miaNHrnP8rCaKYXgDnW320i1l2JCr7E8IsWTRz8Rk
         t7KnoGMKlwSx6rsr06nwvFVAe4BHUzcChVyuwRvjbvWP9CvjnnofJ6EwRKeF0+p/R/6w
         GACSNI142EtdH3N3SjseeSgfPMyJybucEJRDcCp6mWSi5kw+WhACynC8wzDeBCtdI4I2
         NDcA==
X-Forwarded-Encrypted: i=1; AKwUvBxWphN35hQrG9hN8xY77aiZVQL0tdISWZ/LSHdQTLoUScx8OXoXHckiwqMpQy/m2ehFD9pQ0g==@lists.linux.dev
X-Gm-Message-State: AFq9FYKTY+5mtTiPU6YyIkS7+YLxzkwhA4pAes84rF6pIf3ewW8JmFmA
	caW9f/bZSAsxgVV5KR+sqm/0iiRWR3aKq1qXYP0KyREIQrtddO4l81Eg
X-Gm-Gg: AYBFou10ACqQFk6naS+emgkWtyMd6mVvLEYezjYmSkPHvA1PFm4giGAdG6suvICouEa
	67oG4tzY8GemJHmzTPmWum/LUSlEKRvnLKggTmnGqfv4hdSoAmm/crj4GbM5qEZeEYvMFgGDkvB
	G495hSWfAWrui5J/Zgw1QVYBlu8+VQkFmQVS9Wc2az0W9Zpxg3x9ntLRGKo9jG97N8YzZo7ZMcf
	pt4bDAIXYBPiNbzGxkHng0vvxI1abgf2SmhN/yRJB2QMAWvQCQdnk4LPY3Cl69xv1G51F5+W5ue
	sDBTRsl6CgprPUofo8OyaiTjZK6zW7um5P7p5RGiBNABSgEPQ5C9o+HPHZKtMybn3wXpAwzs9dO
	V+lEherxq1DvCiz4Mu5gyplWcp7RloRF246Fet/Ex80pnDURDCIA1NT1SNVDEYWZl9g/KtVRzHu
	UWkeWXYkoJNAK54zGYUacXQiTql46oEMqaz/js2CNkbwINQ6R8V81vtr+I9mCHgAf1arJshvRgV
	adBrWI76DiwoatODSP3irTKJc3BvY1H/09r8IdAVUxMCOtR0LqEjXQgsJ9ANAXagsJTwRKy70LP
	UoWovGVGZm3/F4xvxUyW8E0u7A==
X-Received: by 2002:a05:7022:3b87:b0:196:d6e1:108b with SMTP id a92af1059eb24-1ac59fbfd13mr1403659c88.10.1793330822482;
        Thu, 29 Oct 2026 20:27:02 -0700 (PDT)
Received: from lion.. ([166.1.190.168])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1ac1a13652csm3067356c88.17.2026.10.29.20.26.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Oct 2026 20:27:02 -0700 (PDT)
From: Zhiyu Zhang <zhiyuzhang999@gmail.com>
To: Eric Dumazet <edumazet@kernel.org>,
	Kuniyuki Iwashima <kuniyu@google.com>
Cc: Neal Cardwell <ncardwell@google.com>,
	"David S. Miller" <davem@davemloft.net>,
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
Subject: [PATCH net] tcp: restore IPv6 af_ops on disconnect of a v4-mapped socket
Date: Thu, 29 Oct 2026 23:23:14 -0400
Message-Id: <20261030032314.1978575-1-zhiyuzhang999@gmail.com>
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
Reported-by: Zhiyu Zhang <zhiyuzhang999@gmail.com>
Closes: https://lore.kernel.org/netdev/CALf2hKvp0NPVLwr=a3+jUHtPohxbra8gox+aYAfWathJnn-J+Q@mail.gmail.com/
Link: https://lore.kernel.org/netdev/CAL4WiiqFJpmcV4=TWRpukCq6q=-729658FwGvieNcPXe97kLvQ@mail.gmail.com/
Link: https://lore.kernel.org/lkml/20261029054136.1174216-1-zhiyuzhang999@gmail.com/
Signed-off-by: Eric Dumazet <edumazet@kernel.org>
Co-developed-by: Zhiyu Zhang <zhiyuzhang999@gmail.com>
Signed-off-by: Zhiyu Zhang <zhiyuzhang999@gmail.com>
---
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

