Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792720761;
	b=W8MPL5h+5pFPfJtCghBbocpzfsWmbIe4lzNAmbqjjeNzxABya3zlLLplOv/VscT6ZnES
	 WfliB90x3X2uUG4oyL6Y1l7UkOo9jCD/fkVlccx3LT9XAvxEF/IniNXgLxECIOmfQcN2F
	 MAxUq+B842dayoMtf8i2h4PqdSkOqHAg/5iCNDOGDiGooP9VysnvizSc1X99Eo21YdjwP
	 xS2SWlCYTEXMWEMC9BF6AI7/fYT15eQeF56eDBPlYP8epYf9a23IuxwcHJz5QP3iNAXAh
	 TLHRqh4RxH8Ti+JB8CwF8Vb02xoGjuQ5far2VvQ3stnFfEicOutOEylu4EYbzcYnEtg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792720761;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=QLA8nRp+J+ZN/0Lmikqab9RD9h6hAbJWHw0a5dRFjPo=;
	b=BoEcFdt6bjoSxCDYWUbdjI9EYVrn5sFC1yAXXvFsyd6o2piFG8HR8XK9Z0sKJyAGSA6b
	 cw5StRPwtBCgkWJuUCrsvOC3HOeMDxmGXyFq/98h4SA1CRIAoDiXTTwMNQsaT0WQXF0YO
	 qiAQhq/tkLv7K7q6P4C5U/YFv6wl8MmYHtacKqm8/S7V+tXHLFaNPuPY232Zhn+Jo8uN8
	 KE6bnq/Hgg+G4TIM+VYDp0cMRwTVWM3ZDNlr9RokAFWglSeb/LVnIc9Pw697Aiy5Si/kw
	 7iYN+IWqAZxFrOE1eKeE+PjCr+0A5xDLPPWkvAB8pHa9fiB/53WXnBoA8A/M2g4B3jA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=LWFgfggD;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72659606A319
	for <mptcp@lists.linux.dev>; Fri, 23 Oct 2026 01:59:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=LWFgfggD
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 27A521F031E4;
	Fri, 23 Oct 2026 01:59:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792720761;
	bh=QLA8nRp+J+ZN/0Lmikqab9RD9h6hAbJWHw0a5dRFjPo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=LWFgfggDbr9e3IxXMOeA2VugjEVv6ZFHU4HtlH5H3xrgQWe14Iv383+M8T3dwvrTx
	 de3w8I7Dfw3szRQNKpmbGeH+XGEXeN7PvhOY7EbCPIocVRf4JNW/w/BmNVfDG5lh6W
	 VZnwwNx14AAOWLuEGJsIxS4LZjoSYBx1n2PjgVC+OG04QR7OG3AlV4RJarS8Kuy9ZC
	 Olt4up40HCTG5I7+lZ4fH2PRdxluu43M8ajOlTH2yy4BCUdUafmQelxoc8TTmclklY
	 koIZfEc6rynM7NKLI1J9DZC8qEDDVbdMU6UzokSl7C7paWOBPAvu5Mfs/HYIRuwZVh
	 4f7UUNANzro9A==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Gang Yan <yangang@kylinos.cn>,
	Geliang Tang <geliang@kernel.org>
Subject: [PATCH mptcp-next v15 11/11] mptcp: update mptcp_check_readable
Date: Fri, 23 Oct 2026 09:58:52 +0800
Message-ID: <318e9e95ab018136db65e2c82a7718687cae755a.1792718041.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <cover.1792718041.git.tanggeliang@kylinos.cn>
References: <cover.1792718041.git.tanggeliang@kylinos.cn>
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
index 7870b9be76c7..b224b53c0888 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -3550,9 +3550,11 @@ void __mptcp_unaccepted_force_close(struct sock *sk)
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
@@ -4666,7 +4668,8 @@ static __poll_t mptcp_poll(struct file *file, struct socket *sock,
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

