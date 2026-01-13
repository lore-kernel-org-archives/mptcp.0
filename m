Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61B42366DC7
	for <mptcp@lists.linux.dev>; Tue, 13 Jan 2026 06:13:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768284833; cv=none; b=QC1bS2q8DMIoopCaCOhON8ChN7haI4KoizGsyBfQTkVo1UIaL+eWrBPZ3uZNrltzdDROgRhR/uKzbPsJdfViW0nN+gDLOzJcEqCin8aalXtSqTxZfYOFQKPBSSTrA/OYHWeBhp2B1RwKXu2kZO29ZXb3rpMaFyQP9dUbBbOMTb8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768284833; c=relaxed/simple;
	bh=GBw4zWCGkK5GIjNsRYXI1QrMdTiVpNMOHKCjnMweplQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=IvrKd2Ny5vBLzpWCg4k/4WFzZKHMEhJEVRpk52RvnLK5WpiNV+26OlGCgJXDrHClse3sFTEAkG5nlG1TLW9qAIq0EFN+gxOMbglW7E7z5FRVviclHbzWSOLsmoRHLxQ+Kew6b9jRsre1sIq35AAVvx6d3US9ZrU+LAn2zJwCmZA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OesChuQw; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OesChuQw"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 27E0CC116C6;
	Tue, 13 Jan 2026 06:13:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768284833;
	bh=GBw4zWCGkK5GIjNsRYXI1QrMdTiVpNMOHKCjnMweplQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=OesChuQwPqnYR+fUHqA2cCpwNfiscKDponmM9GZS0aTS5OecRloUxaFJ4QzinTdTR
	 MFMLDRgwU3jlixJILyjz5x0sCUhZmUvV+X5sMqyR1Z4yyLZEvcBtwuAbUniEf6u/1x
	 rbt1+OIdzLwJdlJYI9g048Rwls024S4OaOaZ8zlE6JC9B++gGJGPvisEeJVNjy+jk7
	 D9DRn8y5keqvyXic1nj9XN9wVqPnnDwMWDZEvz55P0I10kmRIRHFZqsyni0Zz0JWmg
	 KLwtRBKw7jY7Np+Pu/tl47LJlNBpFaQBBHdgdOzHlVuwzks9M3Oak1hljYY6vQBKOW
	 uyKbPpxFlgESg==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Gang Yan <yangang@kylinos.cn>
Subject: [RFC mptcp-next v7 5/9] mptcp: update mptcp_check_readable
Date: Tue, 13 Jan 2026 14:13:31 +0800
Message-ID: <d25b2b40fe43a4d1edc5b4bea1d4151bba810673.1768284047.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <cover.1768284047.git.tanggeliang@kylinos.cn>
References: <cover.1768284047.git.tanggeliang@kylinos.cn>
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

Signed-off-by: Gang Yan <yangang@kylinos.cn>
---
 net/mptcp/protocol.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index 900f26e21acd..e5b59310bd27 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -3239,9 +3239,11 @@ void __mptcp_unaccepted_force_close(struct sock *sk)
 	__mptcp_destroy_sock(sk);
 }
 
-static __poll_t mptcp_check_readable(struct sock *sk)
+static __poll_t mptcp_stream_is_readable(struct sock *sk)
 {
-	return mptcp_epollin_ready(sk) ? EPOLLIN | EPOLLRDNORM : 0;
+	if (mptcp_epollin_ready(sk))
+		return true;
+	return sk_is_readable(sk);
 }
 
 static void mptcp_check_listen_stop(struct sock *sk)
@@ -4303,7 +4305,8 @@ static __poll_t mptcp_poll(struct file *file, struct socket *sock,
 		mask |= EPOLLIN | EPOLLRDNORM | EPOLLRDHUP;
 
 	if (state != TCP_SYN_SENT && state != TCP_SYN_RECV) {
-		mask |= mptcp_check_readable(sk);
+		if (mptcp_stream_is_readable(sk))
+			mask |= EPOLLIN | EPOLLRDNORM;
 		if (shutdown & SEND_SHUTDOWN)
 			mask |= EPOLLOUT | EPOLLWRNORM;
 		else
-- 
2.51.0

