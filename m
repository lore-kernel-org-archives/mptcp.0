Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793588346;
	b=uNhrImORjLguFRY30Ll0E0VFH65uw7PNYdO58KNiEcGa1/1y5BMpJQ3O3aFVIZ/4mefU
	 TlWp3BnnO9y59MKIquV8w3i8jcK56TIYfWL7RoFC/O/TzKwD1gf5vuxiBRrR9YK6QCFfk
	 FNb/9OvZIhHV8TAHTJOp60MvXk8iUyJouSa75X3zo1MIlK32LZUWWMdto3Cy9tow+E/mK
	 YsOc63qTQQeBKq8e0wbydO7KOvkOsgu2q2H4F34RZg9MDyW/GDaUSL+i9iJ8ZTaS+fh1I
	 nEq/z74mvcG0b9NYLuhk1JMr6tfUue++JKHscZPf6OXJ2XzcoKW4rMdIZzUxcAxyMBA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793588346;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=FcyZ/23EO9wCaimpG8uixyj/1tWZ+pqjTJz3x+0Dc/c=;
	b=vbl/fM6QBL4YkVzWEHLw1XGisiHY10UmTkofNfdhdjxusPNs+pEpQ4B7ijHY9AyjS0HB
	 6rSEo025jAYvjBgNIl2sJv8CzuNmeOoyzt4hSmiNlO71oU6AcyK1DbV3zXdRfBI62ewED
	 TGZQRZcXA1L023kkXfkDqBJqIO47XfUqNbmOy8QY9zpGMTUZGOiInQ5ShkigVKyszrtxd
	 EZGIyKl5idr577n2q0gXX2YoC5Q7lwnkS9X5lxaL+pyvGi0AKWxnvIW/xEyuz/W7xtLqL
	 wKJR0AflcUaEUW86qsqz1+kJzk8S7My7hxzoO5NvJqtJKihFdcw8IRo6B2m5sSH6Uhg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=TEOqH5ni;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F5E5606A324
	for <mptcp@lists.linux.dev>; Mon,  2 Nov 2026 02:59:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=TEOqH5ni
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BA9B21F00919;
	Mon,  2 Nov 2026 02:59:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793588345;
	bh=FcyZ/23EO9wCaimpG8uixyj/1tWZ+pqjTJz3x+0Dc/c=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=TEOqH5ni7CWZV9tz4xnNGfBDPtyVFG6N9ssS2HALUAIh1oP3I/xrs2vEuJw3jax8g
	 LimWJE640DJl9VDBCBeWGV7g/xtZQ/3hbqaVV4uF3ml8rBzHm6MXHYd/d0wCMwSAum
	 e1k2F2sJiynak3wM4g4/B694sctkALxwNjjOxmkS6mFGen4IRU58HJFLcmJKJe/gwD
	 Sl4PjiBMIv5cwdY9rKuqdC5jpsNquNwBuFKnTfqQ4XFiPDxEFCjttzUW8JKNTwD3N0
	 99wXyXlHanI9A1Xkluzk5U15sbUthnViYQjAWOpP9L3fHi9vg53QKFUSytQxr7wElC
	 FU949jIJWh1lA==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Gang Yan <yangang@kylinos.cn>,
	Geliang Tang <geliang@kernel.org>
Subject: [PATCH mptcp-next v4 1/5] mptcp: update mptcp_check_readable
Date: Mon,  2 Nov 2026 10:58:54 +0800
Message-ID: <79b5374c1e38dcbc2b50f129b4269340352fb44f.1793588257.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <cover.1793588257.git.tanggeliang@kylinos.cn>
References: <cover.1793588257.git.tanggeliang@kylinos.cn>
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
index 02a4f479d9d8..0caa31525b90 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -3476,9 +3476,11 @@ void __mptcp_unaccepted_force_close(struct sock *sk)
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
@@ -4580,7 +4582,8 @@ static __poll_t mptcp_poll(struct file *file, struct socket *sock,
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

