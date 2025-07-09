Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1270326B778
	for <mptcp@lists.linux.dev>; Wed,  9 Jul 2025 07:25:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752045960; cv=none; b=FsJtlHekozn5l2JTqz+y318KPpnwyFlUIsy7Cn+Lks4IK89E8tMNkBQgBwKg64PLBibp97qEM85ys+tq6hKu38tZI/wEbZ+yWbtE26nlYaJePjYauWFEu/pHriswp/GWr0cVXEdopb9MzKk25M11+ljmWmslaCx9h67oFFI4xX4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752045960; c=relaxed/simple;
	bh=OjbFbRCuqzvUduDjZoX/Ing2VFQrPaLPZMKGgUW54Bc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=W5yRd8kmtOsWHKLoVLJXTUFDQiIezuGfifUaDGW+E9y90tr1dIvuKmSLb+bT9sJrLf0a8tfU/HiuaJYjjsX/O5IPM3LwlVUOV3WGiEz0whM1xn48CO4lk1RwARfqUPL3DQxvu7b5EhWm6TLxPheUnGEJwI9FDc/Mjw6Shxc3WJA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tfrXpU88; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tfrXpU88"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 48B58C4CEF1;
	Wed,  9 Jul 2025 07:25:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752045959;
	bh=OjbFbRCuqzvUduDjZoX/Ing2VFQrPaLPZMKGgUW54Bc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=tfrXpU88+W/GdVDacVTG7JKSYND+i0MJca+4IvlGbtyLml0i3DjfxBpOCAjcyMkxA
	 FH2E5gLIJ5IdgFwHf+nQojPcrlgcDE0pjWLqxJnUq+f+Z1gz3KKTJews6kadDihtJd
	 dqYhKVdn1QNBvhKwReILZjLd52Gry4izKTciaunrB+3ITtH8Bo+KIdNprQEkY06HLa
	 EXf99YlX8JZlGizpYKb5nsri0sSD9ghlPUUeXEUAYoI2nSXalwOapQniN/NrxB8u1Q
	 mdAxEUvuJl7pPM+LWc9vQ3NHyJ3U5Kfbvqnia6+S8cvkHEo6qYQgY8yeS1r730fGN1
	 0aPG7RXK6Luvw==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev,
	matttbe@kernel.org,
	hare@kernel.org,
	pabeni@redhat.com
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next v8 4/7] mptcp: add recv_should_stop helper
Date: Wed,  9 Jul 2025 15:25:31 +0800
Message-ID: <e61ea2bf23abcd7ec01ed0783ee9ca693bb86e79.1752045499.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <cover.1752045499.git.tanggeliang@kylinos.cn>
References: <cover.1752045499.git.tanggeliang@kylinos.cn>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Geliang Tang <tanggeliang@kylinos.cn>

Factor out a new helper mptcp_recv_should_stop() from mptcp_recvmsg() to
check whether to stop receiving. It will be used in mptcp_splice_read()
too.

Suggested-by: Paolo Abeni <pabeni@redhat.com>
Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
---
 net/mptcp/protocol.c | 59 ++++++++++++++++++++++++--------------------
 1 file changed, 32 insertions(+), 27 deletions(-)

diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index fc429d175ede..1fe04ec05ebd 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -2090,12 +2090,40 @@ static unsigned int mptcp_inq_hint(const struct sock *sk)
 	return 0;
 }
 
+static int mptcp_recv_should_stop(struct sock *sk, long timeo, int *shutdown)
+{
+	if (sk->sk_err)
+		return sock_error(sk);
+
+	if (sk->sk_shutdown & RCV_SHUTDOWN) {
+		*shutdown = 1;
+		/* race breaker: the shutdown could be after the
+		 * previous receive queue check
+		 */
+		if (__mptcp_move_skbs(sk))
+			*shutdown = 0;
+		return 0;
+	}
+
+	if (sk->sk_state == TCP_CLOSE)
+		return -ENOTCONN;
+
+	if (!timeo)
+		return -EAGAIN;
+
+	if (signal_pending(current))
+		return sock_intr_errno(timeo);
+
+	return 0;
+}
+
 static int mptcp_recvmsg(struct sock *sk, struct msghdr *msg, size_t len,
 			 int flags, int *addr_len)
 {
 	struct mptcp_sock *msk = mptcp_sk(sk);
 	struct scm_timestamping_internal tss;
 	int copied = 0, cmsg_flags = 0;
+	int shutdown = -1;
 	int target;
 	long timeo;
 
@@ -2146,34 +2174,11 @@ static int mptcp_recvmsg(struct sock *sk, struct msghdr *msg, size_t len,
 			    signal_pending(current))
 				break;
 		} else {
-			if (sk->sk_err) {
-				copied = sock_error(sk);
+			copied = mptcp_recv_should_stop(sk, timeo, &shutdown);
+			if (copied < 0 || shutdown == 1)
 				break;
-			}
-
-			if (sk->sk_shutdown & RCV_SHUTDOWN) {
-				/* race breaker: the shutdown could be after the
-				 * previous receive queue check
-				 */
-				if (__mptcp_move_skbs(sk))
-					continue;
-				break;
-			}
-
-			if (sk->sk_state == TCP_CLOSE) {
-				copied = -ENOTCONN;
-				break;
-			}
-
-			if (!timeo) {
-				copied = -EAGAIN;
-				break;
-			}
-
-			if (signal_pending(current)) {
-				copied = sock_intr_errno(timeo);
-				break;
-			}
+			if (shutdown == 0)
+				continue;
 		}
 
 		pr_debug("block timeout %ld\n", timeo);
-- 
2.48.1

