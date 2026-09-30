Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C395735C6B6
	for <mptcp@lists.linux.dev>; Wed, 30 Sep 2026 02:28:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790735328; cv=none; b=bNZlA/cvm96eTumnHC3XIvW+lv//3BfRW0t+Tl6iB+7+diqIJbCv7RlbAOrZ9/akSxhUfkcP0L1cgnO5DZrBrpgHwjdNGf9OAJw2jNYu7x6biy90C/6ZScsGgCNFB+1t1rCFlk56tKDS3v8Dn4s/AaxYWfypNsTHWrGVpYiwxyE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790735328; c=relaxed/simple;
	bh=YcsamNNamtCUvUCR/SxqL74eb+lj/rWrYG/T1qLlr/s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Om54dhOTASS5lwK4TZOvtFkXn8WSSG+OI4LVm5BIRu/7+W6zs4XHCqC4iymP1QNC7ObsZMZzBoPU+O/73oAXLiTeApbD8ILQtSGW3QsgUs0ce/5u4DMAouIVEc4+rnNDa+1cOqw8EP42g1EWZ6jC9iqLyXo8r8Vyw+YzGOAHSn4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=izqRNQxg; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="izqRNQxg"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DAB911F00893;
	Wed, 30 Sep 2026 02:28:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790735324;
	bh=bW+AcfyhqKTqDRhejnqAWmE6GuP2Mfw45SAo6ETKxRI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=izqRNQxgx0fCjswvda7GF3mZXzWWHJnU5rl57QONoXgHvoRrOrZOrPdfWjxByuEsX
	 ybh5LOd0c/DA6lw3GfRbgnisZXqwGC95zcfkxyp00YRJjbl1ctyKxVwFbTunSQR+id
	 L82aXInBWD85os8Rgl67GLAnioGOo7+DmWSv051h73vL3cXDoJUup34rl8Wq2r6aCa
	 i5CdH+oFzegRdkD+qBjE+C1X32ZfwcqH+VjZcpxbw2CMNrGsQ+fKXAUbePWcnzxLUt
	 +ARcbwaGM+ac2smHT2GO40JCBkl68DyiVWe4s1WrhLGHqE/icYErB0GMg08MnpobJT
	 Lv2E2+1LSSrBw==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev,
	pabeni@redhat.com
Cc: Gang Yan <yangang@kylinos.cn>,
	Geliang Tang <geliang@kernel.org>
Subject: [PATCH mptcp-next v14 11/11] mptcp: update mptcp_check_readable
Date: Wed, 30 Sep 2026 10:23:45 +0800
Message-ID: <0b914bfd521e1e6eda15f8ba7124cfd5342bb596.1790734083.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <cover.1790734083.git.tanggeliang@kylinos.cn>
References: <cover.1790734083.git.tanggeliang@kylinos.cn>
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
 net/mptcp/protocol.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index 1f7aaf3214a0..dac1659bbb19 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -3546,9 +3546,11 @@ void __mptcp_unaccepted_force_close(struct sock *sk)
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
@@ -4633,7 +4635,8 @@ static __poll_t mptcp_poll(struct file *file, struct socket *sock,
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

