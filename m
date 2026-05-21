Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8056715E8B
	for <mptcp@lists.linux.dev>; Thu, 21 May 2026 09:30:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779355818; cv=none; b=qNekDBasOIj1X9zr3uDvVgZBxHxzHw+3zCvCCWuVc43U6OjCWICHWnBd1e8PlHDEBNAWQkShLEq6VlEToT27BogkAVthZW1oSlc7F02opd+Qf3P+KCWbHnMEGnxV+kYfxKQedJmaVAh9XMYjMwBjygiWSVYt3UsRvkrHNQnUR+E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779355818; c=relaxed/simple;
	bh=QZcqk7MR7wdDmplYMQxEXzAQLtnPXnYRFCFqR7Dcz0A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NkskoGD0Qp3AJBOQFZKqBYp0igA7xXfKLBZvL0gywixdImgavggkZI+xSOu5Yarif3smESgF77pFAwhpeDazPbw5rpH5xTC9/fkyRleNSYpbEGuo+fWYnlKDq1kas6lx/fJz0WqM+xFpw6jSYXjR2/EerN7qz7ovU8XyQKWx3Gg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=H726t3oN; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="H726t3oN"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B92401F000E9;
	Thu, 21 May 2026 09:30:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779355817;
	bh=LA4mZqUMFsnjmZO2jsCJMgKZNRE5xKZzbra1tRMV0Hk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=H726t3oNN01NFQ+War6y8zNLnpuCXV2K2Wg+sgc0uYWOSm9zqmNlZE03yj10jI5M3
	 U/owuVsGwlJ9mEW3BUBI4zoIy3FV+LJbTEJdxx3RU2QURDNkFDzmgTytKekZkejuOM
	 48EqxJefKuT5jge2fRa/OrvBj84X3j5h9/gbjmgmF7qDuMAM/lSmeR79DyMMRUqkuU
	 xtmPLc7EGh+q6V6icrK6z1RAw0TMJ2c+9Y6n94TCj6EZgho4M9Pc1h6zJPBkZRA4Yi
	 Z3crscEheXGjdPI7dq0jBNV+Hey8uUL7+ZsH82+LkjEnlDt07WznGDvD5HvhUkfMGW
	 LgJbECtckaJkg==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Gang Yan <yangang@kylinos.cn>,
	Geliang Tang <geliang@kernel.org>
Subject: [RFC mptcp-next v19 04/15] mptcp: update mptcp_check_readable
Date: Thu, 21 May 2026 17:29:42 +0800
Message-ID: <c7e6823c3339a143026c3c9099e3ab6d9e29487c.1779355169.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <cover.1779355169.git.tanggeliang@kylinos.cn>
References: <cover.1779355169.git.tanggeliang@kylinos.cn>
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
index ce8372fb3c6a..a36ef97155a7 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -3276,9 +3276,11 @@ void __mptcp_unaccepted_force_close(struct sock *sk)
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
@@ -4342,7 +4344,8 @@ static __poll_t mptcp_poll(struct file *file, struct socket *sock,
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

