Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC1EB2581
	for <mptcp@lists.linux.dev>; Tue,  3 Feb 2026 03:48:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770090481; cv=none; b=kHKDXt8vckZNaqTBGX7gfHv4U9VFv3hu9pEEO9rJ5IeKxNeKwrqEx+YHIuFYB50g6TdCbobjrxJ/vE19dx1FlAGuynLaAMJRTThuIOBpAIRLbdlYY7GfYRe8Huays8Ruanr7SDVK4qso3D/RAexShoufBbc8mGkalNTjM69YIeg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770090481; c=relaxed/simple;
	bh=7VW/geT0M1oAKnsquC10wcOuJNfEFREb937oETjqTMk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DrpjwlxEA6VVCheI9QXnlyC7ND9XW+S83BBra7qUyMl5DIbc/BcA88ZnW92ZfemDKcQCVQoDVsHgoAMoZHfYYffJzPh1xVDYuayQ4T56/od8ExAQQBUYAYIUNY7AQm1vX3wjpKrjJDxkzK0EU+Pzk3oA5RaoPOCaFFMwFNu6tdY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jjC36p7X; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jjC36p7X"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 32FB6C116D0;
	Tue,  3 Feb 2026 03:47:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770090481;
	bh=7VW/geT0M1oAKnsquC10wcOuJNfEFREb937oETjqTMk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=jjC36p7XrhrGtr/SoDv1v4xNdGXoCl0vlr8dkql4uxq+uCCsDdtGH5l/9QyoqNXvA
	 sxo5CBw3Ww6euryKeJL0XqFVJzihrAMQDh/MvN8QosEt1uhKjjXvK9/wL/dg7iEHUJ
	 wxLtDdoKcCD0iuM1EdEPxt+sGM8ea4v024Ni3U7SWkNqMANKgMQpcdSD0BjAtld4QU
	 n5TK0lH/M9AO8QRtyQPeWcOvBxM99cq66dDLKeAssHrO1jspFlt/CNsuHAhCxvQw6i
	 Rjc38U85cXNJUGXXXzxlk+jX1ucI2Smbi4SI/5bqyi9ZdBta1oC7zJAoyh0hIZwdY2
	 IgvBLH+yzYq6g==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>,
	Paolo Abeni <pabeni@redhat.com>,
	Mat Martineau <martineau@kernel.org>
Subject: [PATCH mptcp-next v2 2/2] tcp: add recv_should_stop helper
Date: Tue,  3 Feb 2026 11:47:45 +0800
Message-ID: <5d485efb9c4cea80f3e5ec93f2b6d4b5eca7b1ef.1770089761.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <cover.1770089761.git.tanggeliang@kylinos.cn>
References: <cover.1770089761.git.tanggeliang@kylinos.cn>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Geliang Tang <tanggeliang@kylinos.cn>

Factor out a new helper tcp_recv_should_stop() from tcp_recvmsg_locked()
and tcp_splice_read() to check whether to stop receiving. And use this
helper in mptcp_recvmsg() and mptcp_splice_read() to reduce redundant code.

Suggested-by: Paolo Abeni <pabeni@redhat.com>
Acked-by: Mat Martineau <martineau@kernel.org>
Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
---
 include/net/tcp.h    |  9 +++++++++
 net/ipv4/tcp.c       | 10 ++--------
 net/mptcp/protocol.c | 10 ++--------
 3 files changed, 13 insertions(+), 16 deletions(-)

diff --git a/include/net/tcp.h b/include/net/tcp.h
index cecec1a92d5e..a64b6159f93c 100644
--- a/include/net/tcp.h
+++ b/include/net/tcp.h
@@ -2951,4 +2951,13 @@ enum skb_drop_reason tcp_inbound_hash(struct sock *sk,
 		const void *saddr, const void *daddr,
 		int family, int dif, int sdif);
 
+static inline int tcp_recv_should_stop(struct sock *sk, long timeo)
+{
+	return sk->sk_err ||
+	       sk->sk_state == TCP_CLOSE ||
+	       (sk->sk_shutdown & RCV_SHUTDOWN) ||
+	       signal_pending(current) ||
+	       !timeo;
+}
+
 #endif	/* _TCP_H */
diff --git a/net/ipv4/tcp.c b/net/ipv4/tcp.c
index ae0000215ff4..e6e07df3979f 100644
--- a/net/ipv4/tcp.c
+++ b/net/ipv4/tcp.c
@@ -894,9 +894,7 @@ ssize_t tcp_splice_read(struct socket *sock, loff_t *ppos,
 		release_sock(sk);
 		lock_sock(sk);
 
-		if (sk->sk_err || sk->sk_state == TCP_CLOSE ||
-		    (sk->sk_shutdown & RCV_SHUTDOWN) ||
-		    signal_pending(current))
+		if (tcp_recv_should_stop(sk, timeo))
 			break;
 	}
 
@@ -2783,11 +2781,7 @@ static int tcp_recvmsg_locked(struct sock *sk, struct msghdr *msg, size_t len,
 			break;
 
 		if (copied) {
-			if (!timeo ||
-			    sk->sk_err ||
-			    sk->sk_state == TCP_CLOSE ||
-			    (sk->sk_shutdown & RCV_SHUTDOWN) ||
-			    signal_pending(current))
+			if (tcp_recv_should_stop(sk, timeo))
 				break;
 		} else {
 			if (sock_flag(sk, SOCK_DONE))
diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index fd9a574d1dda..9b0b6324fb56 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -2316,11 +2316,7 @@ static int mptcp_recvmsg(struct sock *sk, struct msghdr *msg, size_t len,
 			break;
 
 		if (copied) {
-			if (sk->sk_err ||
-			    sk->sk_state == TCP_CLOSE ||
-			    (sk->sk_shutdown & RCV_SHUTDOWN) ||
-			    !timeo ||
-			    signal_pending(current))
+			if (tcp_recv_should_stop(sk, timeo))
 				break;
 		} else {
 			if (sk->sk_err) {
@@ -4506,9 +4502,7 @@ static ssize_t mptcp_splice_read(struct socket *sock, loff_t *ppos,
 		release_sock(sk);
 		lock_sock(sk);
 
-		if (sk->sk_err || sk->sk_state == TCP_CLOSE ||
-		    (sk->sk_shutdown & RCV_SHUTDOWN) ||
-		    signal_pending(current))
+		if (tcp_recv_should_stop(sk, timeo))
 			break;
 	}
 
-- 
2.52.0

