Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794826680;
	b=xBFzgGR9t5BgTIviIDT+t5yTK5o8WYoOwNiVDNqTbPeCux3xRzLSkirsqlvxL/ED1SQ/
	 U7NAOPjdRvJOoMmFRMQKQfSIaO8qAUPXzdoCz3mIYO8v+f5LgrcdLt8TcL1a42CMPiK4w
	 p4bC6lynfdehKcAZcpxQaMlubrsekvOMFjUdNQZvBD0+sEupyto/k4Hy1vzEzIdW+GXc7
	 EU8mQl5FNm/kWc61yPhPHuJ6KwlxEZ2eAoG/5laSC7uCXqHXGpAvcuUXBPiz+yRxdk1R2
	 emxETXpneDAkrXnOta8ynnPMBfPcChChtQ3fAiYNmc1fGdPaEvR7XJHmf5aFQVsiIxQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794826680;
	h=Received:DKIM-Signature:From:To:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=UidAoq31aSb4/KrxxlaKNK3zCEvy1Ye90Kh3uu5XC38=;
	b=YVmpzknA1g/NTaDXXDhXtbRZby9t2E5y3tNOaNTw6m863pjqHB5pVyA40mynH9YUBHUE
	 L2VKtVknOKF7HJHuDc0cbbXrIhAysvjkpvWrPMqHqFUHacn1fV5Bu3mQmmBLA5ZE93TIv
	 lmVdg9rWQjY3SNPF+oa2MCoYHnlnsE+f+38+Ygx2UxISRuPzK+cx8LQ7D//MLqV2IoSCx
	 F61jCffrRKRK6w+4UOOfBIZF25Egu7w4efBkvY5SHSBiYnaIgVlqvpe2ltRtMjK40hz5p
	 I13JJbksKs2NHmysHh1K/nfLeJ8hSuNIbdVrEo5i4teCSTZRBhPOpZNTwrUrLdLAwXA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Wb7ewJmw;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A89BF606A330
	for <mptcp@lists.linux.dev>; Mon, 16 Nov 2026 10:58:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Wb7ewJmw
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6393D1F000C6
	for <mptcp@lists.linux.dev>; Mon, 16 Nov 2026 10:57:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794826680;
	bh=UidAoq31aSb4/KrxxlaKNK3zCEvy1Ye90Kh3uu5XC38=;
	h=From:To:Subject:Date:In-Reply-To:References;
	b=Wb7ewJmw8waCJwarJHGEdXowPtB/fA632Dkeofs0BwAkQ2oUBVvmrFBvoBSBS4MNc
	 9wSiGSF5llKBc9uTLA4KDmtNIHORDUtaC0mHvEQf5caD1+geucsHery7ehEIMeKwNr
	 EKSvwrc9TkImj5LFBH1HCbnhzDqbcOPHobrsXKX579BXeX7EM19wmIPblMjVM+e76z
	 eBv/s6UKgyAhJ4ctGLtqS3so5Aj4WkwB8YiqHkNYXPsrbs20yZHGsjjrIjvFRPBOkF
	 /Dz6zLYTaD+jJZLMMkq0q5kzDZ32vQlmyYgQ0ZYSGyTv4iANlIsBNs2n7ERjE7q5+s
	 PaYKvxtvuBGfg==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Subject: [PATCH mptcp-next v8 7/7] mptcp: update mptcp_check_readable
Date: Mon, 16 Nov 2026 18:57:45 +0800
Message-ID: <eaaec176b58bd4fb18beddefe9e6e9e4a2de99c2.1794826541.git.geliang@kernel.org>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <cover.1794826541.git.geliang@kernel.org>
References: <cover.1794826541.git.geliang@kernel.org>
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

From: Gang Yan <yangang@kylinos.cn>

This patch makes mptcp_check_readable() aligned with TCP, and renames it to
mptcp_stream_is_readable(). It will be used in the case of KTLS, because
'prot' will be modified, tls_sw_sock_is_readable() is expected to be called
from prot->sock_is_readable().

Co-developed-by: Geliang Tang <geliang@kernel.org>
Signed-off-by: Geliang Tang <geliang@kernel.org>
Signed-off-by: Gang Yan <yangang@kylinos.cn>
---
 net/mptcp/protocol.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index b9d080121f78..c81300db1db3 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -3508,9 +3508,11 @@ void __mptcp_unaccepted_force_close(struct sock *sk)
 	__mptcp_destroy_sock(sk);
 }
 
-static __poll_t mptcp_check_readable(struct sock *sk)
+static bool mptcp_stream_is_readable(struct sock *sk)
 {
-	return mptcp_epollin_ready(sk) ? EPOLLIN | EPOLLRDNORM : 0;
+	if (mptcp_epollin_ready(sk))
+		return true;
+	return sk_is_readable(sk);
 }
 
 static void mptcp_check_listen_stop(struct sock *sk)
@@ -4612,7 +4614,8 @@ static __poll_t mptcp_poll(struct file *file, struct socket *sock,
 		mask |= EPOLLIN | EPOLLRDNORM | EPOLLRDHUP;
 
 	if (state != TCP_SYN_SENT && state != TCP_SYN_RECV) {
-		mask |= mptcp_check_readable(sk);
+		if (mptcp_stream_is_readable(sk))
+			mask |= EPOLLIN | EPOLLRDNORM;
 		if (shutdown & SEND_SHUTDOWN)
 			mask |= EPOLLOUT | EPOLLWRNORM;
 		else
-- 
2.55.0

