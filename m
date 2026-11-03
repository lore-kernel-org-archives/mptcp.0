Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.180
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793702430;
	b=2q3jFf0nCZLMeQo6MtCO+R0J106YVktiO4o4v0Qd5sMN9dj8UVOUv/Da2obRyHDKTwF8
	 TfIzKfYprcQvlQsw+MYikY95EKva7W4ipj84ytndFSplg5hBuRCyGnJOf31qNtPOm2jxi
	 OpvzBtaSu86FlObzZosP0KEP8OKcE4Fg9x3eNvRwxBhBJyAwoxS9ablYKOODHZ2JMIMfn
	 qsZXWybpuAYap/cIld+bi2Nsaf3d0X+0kP0t8zw9V/hNeoym1Oo9o5GAfK8v4ZWaL4ZbM
	 07P+H66BGXYa36TfqReqn4O8sqJVlklZ4s30lQhbUVDjhANdHSeKbNxgu/rOZYiEpZg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793702430;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-Id:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=WwDr7AR3Yel0vmHw532J1yhKIdIYegdDoVEAcqR8ZcY=;
	b=jP96KTVDVmo0SANIzvJpjtg9is44psc8qrU6CjYbbu3yhrlfA7sgCDHCbB3kRvrJkbOR
	 ppzjy3QbMoMFQU/wfE2MgmSOSHn6igWTQCIk8mM8ai7Q2JMWTeLAD438XjI7GDBcW/XyG
	 tuR8dxJms3qTlkk4xvaDBNGlMgYVfj18ru4Anv5OIw4eX4K+d+o6U7GNtD/MnAAqVy/fS
	 +RcwOL+W35Dy3aVCG4nM8nX/SGCjEQn5i4Mo06JX3Jc1K3LB1Tb731xbAmfVHjQA6bLeJ
	 b9DKV2Q2jlli7H+3l3tmfdR/tsFEGl61oaHkU1MbDu5JFnoHKqj0pYp6+mD2YVI8Fpg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=xdHJWIj3;
	arc=none smtp.remote-ip=74.125.82.180
Received: from mail-dy1-f180.google.com (mail-dy1-f180.google.com [74.125.82.180])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77D8C606A80B
	for <mptcp@lists.linux.dev>; Tue,  3 Nov 2026 10:40:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 77D8C606A80B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=xdHJWIj3
Received: by mail-dy1-f180.google.com with SMTP id 5a478bee46e88-33bf40b0c8bso3914492eec.0
        for <mptcp@lists.linux.dev>; Tue, 03 Nov 2026 02:40:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793702429; x=1794307229; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=WwDr7AR3Yel0vmHw532J1yhKIdIYegdDoVEAcqR8ZcY=;
        b=xdHJWIj35+AGi9eBoxrLewDHhH3zXrrs2m9kQJUUHOxTDWUfZwiUl4QqM3ijE/Bk4T
         vZaBCqEQZSr9a/tmmM0AK66rK7xBL8vE926at2s8Ao5m+06yy1MitCpm2/Zx0fLzKJc9
         LVxHLUt3eqxkowK9txtBefQwyciqYmJDNsdqeulG38XvTp9FlR3IPli0y3ZwsZqdqxqg
         Aq1Q0c9lXj8kBi/Mtl6TnVpKu8Fyu7fiBWaDJalneu6KsKK+fEjcbHietYzlyxsA/EkS
         91Ey9wJEBrSCowAsHHhw7oSQYKX0TYPvQ4ggHGPqf9mecErMlfOke5mTvscTfTOxkrP+
         RhYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793702429; x=1794307229;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=WwDr7AR3Yel0vmHw532J1yhKIdIYegdDoVEAcqR8ZcY=;
        b=S0qUyDbsMK9fgjdf0NMlNorJrTAOMWCoUEwDaZy3f8HSvCNC7pOJ6XZoVuJr96VC79
         ijGxOOfY+FPqoZ283QAyhuDc+H+3/s2dK/xfzLhVTdCBGU2PWtXyu8fmk/sBpk1RS+F1
         kKj8aYuFT5BP9Uc9tuSwBT9rImYf4bnpFFSSc4KtWzAX1mrO/OXHzS/P4yM/j5F9qu+k
         +0xIBZ69PJrq90gAfyqSaboRLL8aumqZIfhWlu0uCArfiqZzvj40ECSFfBQ+hfTmArhL
         Y34qvLGLXISToDiVfxAU/wIeHV5wv7tugNeKcgUf50grE/cqoQgY+ncR6lZ9e+QUCEDk
         CDHQ==
X-Forwarded-Encrypted: i=1; AKwUvBzzPCdubYaLp4pPU4BXkL+uQuZxZHG3J3u+gdnA7GinUEwqRFIai3GfjmTqVqNRG8naJV/1gA==@lists.linux.dev
X-Gm-Message-State: APuU4Z/0DqLwXJ3OG2bUJ4c8i1C0TbPqPt5FYDXUKSyFN3v/wKAQgilc
	A3BqnlwTqXUM64fnya2U+lE1Lyr7tuUQeFZFW5wFWT+pnokw6elGao2Q
X-Gm-Gg: AYBFou0/U9/9zK+AT3HLcxZdOIzMUNDy1npY+qVyU26+K0h8udZfJ/isSZBcXHUAn8v
	w86WaE4eEQ59qc2d9lSh4nCqYgms1TcfO0WN7RlUVv39a3ogs3JwPvA/b9+Pc48dq/kwXyhcutL
	jUVXdIa2mrmhILaKslzJwkwuccw19Wz8Ho+Qs0PBHDqd6YbL3tEvzfHW4BkX+VEAmJMSOhZQAEf
	rSGC7drINc1/LrwJbx2VEujakrpPRldxfKftV47v1WNHHRG8FZbW1dXlJxogEi6SyuPDsNPpdrm
	GGEDkvvnLTWGus4diwU/UpTvOig6NjuJT87TEM/fIMksw8gT6LHiEvRg3/e2nlFHE/UDf8Cr90+
	+ZTlx2/wj7Me9Pr+HOBHQC94Svz8qYm56s7cWOG4MS+AycXANyRKAFLoY6REPvwMok8KxIIc4cV
	2Eva5vbfQ/LmRx7hIG1nD3OeJ5lwFhgEhl0quYKV7ANbRhjh4CE09nG50McPP8AUWkd4BzJn+sE
	eDVt6tYh6BwggSXfQ69xYmHLRqB+CNOb9YIQdIOXY5j+ja1Jjq8j4SPwckKnGBFenYwB+pUapyW
	Co7nvEEPO3KBHVg7d63ejQ==
X-Received: by 2002:a05:7301:2710:b0:351:207d:bff4 with SMTP id 5a478bee46e88-36a42203e2bmr20325803eec.4.1793702429355;
        Tue, 03 Nov 2026 02:40:29 -0800 (PST)
Received: from lion.. ([104.192.92.238])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-36b13bd87b2sm6024447eec.28.2026.11.03.02.40.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Nov 2026 02:40:28 -0800 (PST)
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
Subject: [PATCH net v3] tcp: prevent cross-family skb processing after disconnect
Date: Tue,  3 Nov 2026 05:36:33 -0500
Message-Id: <20261103103633.2707416-1-zhiyuzhang999@gmail.com>
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
icsk_af_ops, sk_backlog_rcv and af_specific to their IPv4-mapped
variants. A later connect(AF_UNSPEC) calls tcp_disconnect(), which does
not restore them.

The socket can then be reused for a native IPv6 connection while
tcp_v4_do_rcv() remains installed. IPv6 packets drained from its backlog
are consequently passed to the IPv4 receive path.

There is also a race in the opposite direction. tcp_v6_rcv() can look up
the socket and initialize TCP_SKB_CB(skb)->header.h6 before taking the
socket lock. If the socket is disconnected and reconnected to a
v4-mapped peer in that window, release_sock() can drain the queued IPv6
skb through the newly installed tcp_v4_do_rcv().

tcp_v4_send_reset() and tcp_v4_send_ack() then interpret header.h6 as
IPv4 options. __ip_options_echo() can consequently overflow its 40-byte
destination buffer.

Commit 8cc3aef0cb19 ("tcp: Do not allow buggy transitions between ehash
and lhash2.") prevents listen() after connect(AF_UNSPEC), but a native
IPv6 connect is still allowed.

Add tcp_v6_disconnect() to restore the IPv6 handlers after disconnecting
a v4-mapped socket, and use the same helper in the connect error path.
Reject non-IPv4 skbs in tcp_v4_do_rcv() before accessing IPv4
control-block data. In the reverse race, the skb belongs to the
disconnected connection, so drop it instead of redirecting it to the
IPv6 receive path.

MPTCP subflows override sk_prot, while two teardown paths call
tcp_disconnect() directly. Route them through the protocol-specific
disconnect operation so IPv6 MPTCP subflows receive the same
restoration.

Tested with TCP and MPTCP by reconnecting an AF_INET6 socket in both
directions after connect(AF_UNSPEC). A socket filter was used to widen
the native-to-mapped race window and verify that the stale IPv6 skb did
not reach tcp_v4_send_reset().

Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Reported-by: Tong Liu <lyutoon@gmail.com>
Reported-by: Qi Tang <tpluszz77@gmail.com>
Closes: https://lore.kernel.org/netdev/CALf2hKvp0NPVLwr=a3+jUHtPohxbra8gox+aYAfWathJnn-J+Q@mail.gmail.com/
Link: https://lore.kernel.org/netdev/CAL4WiiqFJpmcV4=TWRpukCq6q=-729658FwGvieNcPXe97kLvQ@mail.gmail.com/
Signed-off-by: Eric Dumazet <edumazet@kernel.org>
Co-developed-by: Zhiyu Zhang <zhiyuzhang999@gmail.com>
Signed-off-by: Zhiyu Zhang <zhiyuzhang999@gmail.com>
---
Changes in v3:
- Reject non-IPv4 skbs in tcp_v4_do_rcv() to cover packets queued
  across a native IPv6 to v4-mapped reconnect.
- Drop Kuniyuki's Reviewed-by tag due to the code change.

v2: https://lore.kernel.org/netdev/20261101182736.430733-1-zhiyuzhang999@gmail.com/
v1: https://lore.kernel.org/netdev/20261030032314.1978575-1-zhiyuzhang999@gmail.com/

 net/ipv4/tcp_ipv4.c  |  5 +++++
 net/ipv6/tcp_ipv6.c  | 37 ++++++++++++++++++++++++++++---------
 net/mptcp/protocol.c |  4 ++--
 3 files changed, 35 insertions(+), 11 deletions(-)

diff --git a/net/ipv4/tcp_ipv4.c b/net/ipv4/tcp_ipv4.c
index a7f9242f1e42..8fa6564d2b60 100644
--- a/net/ipv4/tcp_ipv4.c
+++ b/net/ipv4/tcp_ipv4.c
@@ -1836,6 +1836,11 @@ int tcp_v4_do_rcv(struct sock *sk, struct sk_buff *skb)
 {
 	enum skb_drop_reason reason;
 
+	if (unlikely(skb->protocol != htons(ETH_P_IP))) {
+		reason = SKB_DROP_REASON_INVALID_PROTO;
+		goto err_discard;
+	}
+
 	reason = psp_sk_rx_policy_check(sk, skb);
 	if (reason)
 		goto err_discard;
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

