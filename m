Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793324664;
	b=kq7BQFESz0/Aii7pOafRgn+PYjQo/k30D2uRH26uq00+WSfs65flJ3fUz20PRV5kBbyA
	 V0KtGfPumY+0pEkreIJsbmyVZEyeSOBuipaXB0458w+vj0h79lfZ+3I/OICvr4MCjjZ07
	 7MRLEf1uTaZoKIvP8/TpFIURImtNtP1/yk4S/KfqWsFRMrJyInsQryHvJzowWbCCNAqiJ
	 0pN92LZ4PxDwUrpLtbgpAKV9dF1XTUEtCozuUTIcsYjgIxKLw7ycmErt2Rk4A9CaJbdwB
	 xtiuIttF+x/ZChgvGEaDxn8l5oDGAa8jWL9HAU69IgSpvoO8pwpL1SsEGKdfnGKQDdg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793324664;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=FcyZ/23EO9wCaimpG8uixyj/1tWZ+pqjTJz3x+0Dc/c=;
	b=0ntEF5CosSrcAvWWnDBeoCdLjym0/ZNzYbYHxVn7NVcvyAry7DrtgXxGX55MjgzTiHv5
	 0ETVMXn3XU6c1+E1u97APBCHGFh3ZXaaNhOjDTZrHVeqH5zob9kp8rAMTvnGkI3RRb1aS
	 Lnyort+YwZGSO3Riesp3oTjkEMEr0sksZXZDkeIMV/zD5wPHsHccXNE7ciA7UbdR/ugmv
	 97ctIB1NGpihuN8uDX2Ki4XW54zIGQT4gWWDxq9g7Tj5i95bOY5o5M1+l4xSpItdvrwEp
	 OmGlMAsqGviLvo+HWlLmeyBZ8Al7ct2wVOW0gDxHqd8TUIKO14tL/quhtz6t7sGgHMw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Nds8eudH;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23A1D606A31C
	for <mptcp@lists.linux.dev>; Fri, 30 Oct 2026 01:44:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Nds8eudH
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C4A721F00A1C;
	Fri, 30 Oct 2026 01:44:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793324663;
	bh=FcyZ/23EO9wCaimpG8uixyj/1tWZ+pqjTJz3x+0Dc/c=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Nds8eudHkIIVr1sBXy+q/O1e626DYYEbZ6e25N6MqJx2Hk67R7nVgEuBvUf7jfCU6
	 Ao7LZE9lRVZjT8B3BWYezjY5ZD9koZFgy1r7XBfVJQWKXPHztIpS2QXduqwF+1cu81
	 RijPfXgt9T3ednwSZwRCppHiARFYIzO8rROhcevNRW7nEehYGLpXoERXGvzGJXc/Wy
	 powoMG6GHbFPXa0JPz53abCCIAeT/nEMOT0Uh2INy47yJINUr1q8B0gOXHTv3rbqiA
	 QWbo5bMXUzl8qHQTVBsEK7KS+ZDCrgNH6RvP/yhbrdAPJfmB1+vMEvWiQAmVFYUxlK
	 ejeU8nFdkfl/Q==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Gang Yan <yangang@kylinos.cn>,
	Geliang Tang <geliang@kernel.org>
Subject: [PATCH mptcp-next v3 1/5] mptcp: update mptcp_check_readable
Date: Fri, 30 Oct 2026 09:44:13 +0800
Message-ID: <a7ca187973c3370796b98495b4601139f2682b87.1793324316.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <cover.1793324316.git.tanggeliang@kylinos.cn>
References: <cover.1793324316.git.tanggeliang@kylinos.cn>
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

