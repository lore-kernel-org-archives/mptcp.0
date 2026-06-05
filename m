Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9E4A3BE62B
	for <mptcp@lists.linux.dev>; Fri,  5 Jun 2026 01:24:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780622658; cv=none; b=DgwQiibzk8m+Gzy/G7cpRJhGsmiVqNeMA/q+CY/9st/SjUjGjet9E6V3HI95AE1eu5zH1A3cMFFbsDZg5hDnlTvelDnu/vLXoizPakTbElDlISD4O/+WKqBrBIuVz88Cl+uNYj+h3uPs22ajatlQmKh8DvPy9qyJYToXcZQmuT4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780622658; c=relaxed/simple;
	bh=P6O/OVi9vyvMfhgQ9Q0yeLoh2mdenLYE9tDkGkxyaM8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=u5CbgSWJyTt9NIGPClFMwSqiPwnnrub+yVJ+vdxQwYdaLdAi6BUEEf5Dwdsa3Rz+oaXf8NPYXVU+NrbTilqSp7ZLB0bba6/tJCmew4UBs8DQoVmXMTh2lktvAmdbHZBv3uU/cYlR0F88DQTkv1FMzmpajPBMF4FvEa6NxTuVXFo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=guq3sxSH; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="guq3sxSH"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 543731F00898;
	Fri,  5 Jun 2026 01:24:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780622652;
	bh=Ny+jzGQ+QwgSl0CJ5DS0auqfHDiPzam/ihtOoeHNj8s=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=guq3sxSHEkfC1reLNMme/UKFLG2SL2dnRp7o37DdESfpsSWaoJwyfjxfIAXW5kCH+
	 xpBtEsxTW9QjsSZL303tCK4dVF+3Z3EYhA3fpUXTm/JVxz7ioh0IGEmY2j/zA/3KPt
	 g5n8orRxXOCJF1KtWP561L6BwlFV2l1GBUtMW4YiOzYymrE8RBb4vpwLXySaAloouo
	 6jT/NbObNvt+PiuqR2k20yP5Gv6CantpAbMq5XOwdg+jTkIKturNhuKItc3GST0IPc
	 DvP1tFi9g+0SqLw6SGotIZC21DBG/9j+EXJlBWwyDlzQE2yzjQqhmWVTMMEy3bnNj7
	 R7sVFSd9UqemA==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev,
	yangang@kylinos.cn,
	qiang.zhang@linux.dev
Cc: Geliang Tang <geliang@kernel.org>
Subject: [RFC mptcp-next v24 08/18] mptcp: update mptcp_check_readable helper
Date: Fri,  5 Jun 2026 09:22:48 +0800
Message-ID: <4b67c21f18961e944b79623ba54bbfff45e3e4a0.1780621326.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <cover.1780621326.git.tanggeliang@kylinos.cn>
References: <cover.1780621326.git.tanggeliang@kylinos.cn>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
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
 net/mptcp/protocol.c | 16 +++++++++++++---
 1 file changed, 13 insertions(+), 3 deletions(-)

diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index f09faf3056b6..55cc68c460b6 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -3410,9 +3410,18 @@ void __mptcp_unaccepted_force_close(struct sock *sk)
 	__mptcp_destroy_sock(sk);
 }
 
-static __poll_t mptcp_check_readable(struct sock *sk)
+static bool mptcp_stream_is_readable(struct sock *sk)
 {
-	return mptcp_epollin_ready(sk) ? EPOLLIN | EPOLLRDNORM : 0;
+	bool ret;
+
+	if (mptcp_epollin_ready(sk))
+		return true;
+
+	lock_sock(sk);
+	ret = sk_is_readable(sk);
+	release_sock(sk);
+
+	return ret;
 }
 
 static void mptcp_check_listen_stop(struct sock *sk)
@@ -4476,7 +4485,8 @@ __poll_t mptcp_poll(struct file *file, struct socket *sock,
 		mask |= EPOLLIN | EPOLLRDNORM | EPOLLRDHUP;
 
 	if (state != TCP_SYN_SENT && state != TCP_SYN_RECV) {
-		mask |= mptcp_check_readable(sk);
+		if (mptcp_stream_is_readable(sk))
+			mask |= EPOLLIN | EPOLLRDNORM;
 		if (shutdown & SEND_SHUTDOWN)
 			mask |= EPOLLOUT | EPOLLWRNORM;
 		else
-- 
2.53.0

