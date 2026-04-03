Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 852A82DCF67
	for <mptcp@lists.linux.dev>; Fri,  3 Apr 2026 14:52:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775227972; cv=none; b=Z+kJBvTb2a/etUn9TF+O3KPd4TtMURI+rGB9KP9HHwG2uWBdeoE7v3e7+NvHmgpKX1xTt/SQ177WH54+Qm4mMMH8HEQjNv2bx4AhRxcJAH0NQgn6jwdAOP7WvtPe64YnInXuGzSkoqzXOzOCtBjpzGnNIuzPGmQARRr5tjwOG94=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775227972; c=relaxed/simple;
	bh=yeQQOTcPLG8EDrCGNsPeWyQDSb1Vj5d8bVELg5OxrpM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GS6F+3KqQ465RaNtmq/F2yTf7BLOMRbK5gj4G/X1ER2AiY89gnT+yp+XfkHVrb5JWr5hy3jVyNn01pjTl84/UC67n67ubMMLMARh/fSt0Q/ueeFYi2aSHZWOEkP6jmpc+emXe88T/S2lZzurdAsACkA9c6nuEjwSRWidQ2Vv4f0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gHLkFi/L; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gHLkFi/L"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2D693C19421;
	Fri,  3 Apr 2026 14:52:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775227972;
	bh=yeQQOTcPLG8EDrCGNsPeWyQDSb1Vj5d8bVELg5OxrpM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=gHLkFi/LSR5SpzwIUxSivvnir57cz3uO5DZ0+/txxyQy99k8WsWnVw1m7UXoAEyuP
	 ye0HZPo+5N02NqJA7JoCMBvZ0JWeBsch6M4ztrAfr6o4wbJFnhVyZcuL72DieWkKxD
	 dRNsEH0Qe2u3zF5dyZ4sVdSpfYF71I1LvcntsaO+LfD5Z3dEge5f9ugHiMovXUxKSi
	 bh9kdj7geasrlpYVuO7KXZyHqTybwYEesNHX7xR5vf3DbY9YV+Ykq5lmtbo4f/gqDM
	 wlX5D5aXozSwWEBOFiLB4ip5oy+osCZ7IXBnGgts1NUPYNjb0O6xx7Cr+GMT1ww3Ia
	 XINdb+84ma00w==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Gang Yan <yangang@kylinos.cn>,
	Geliang Tang <geliang@kernel.org>
Subject: [RFC mptcp-next v13 05/16] mptcp: update mptcp_check_readable
Date: Fri,  3 Apr 2026 22:51:23 +0800
Message-ID: <19468165c121d4507dcc1f71486b5aa6aa99f238.1775227717.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <cover.1775227717.git.tanggeliang@kylinos.cn>
References: <cover.1775227717.git.tanggeliang@kylinos.cn>
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
index 6ce0d18c86b6..f0afd06e2494 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -3262,9 +3262,11 @@ void __mptcp_unaccepted_force_close(struct sock *sk)
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
@@ -4326,7 +4328,8 @@ static __poll_t mptcp_poll(struct file *file, struct socket *sock,
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

