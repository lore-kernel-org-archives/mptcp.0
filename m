Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794053881;
	b=3lQz5Do3q/E59I5V32ku+JCfBMxD6/3tNUGDg6MuwA+mb1L7DFJTVu5uowhNjAVR0T1T
	 2xz+jDvkNMcPOn0UwdTuvfwzG9TfVFloOCPXts9ItOieEiaQOr7uNx2reIFWGldJTMjqw
	 jw+zbMOXXdKZWXi8sKj0UVXeMUajg/iR+mUvQk3Kvr+M/yG2KXRB1/USLKGoKg9suo6lU
	 79WtMmRiso/hg6OKT1LAhutKN6sLXmnqlSTGLejKpya21LIO66nylYtl1k6ZE7XWuzHUy
	 hDvRUKgKfJYSUcR3TMMj4PJtAZDwYDidaXooSSSMPil8HE8ptnnct1UvYINxKUOHRdQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794053881;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=BEEQjrDENStsvPilDaZcVgNONSjjIsuhAoizVLfTPeg=;
	b=e5MYd94Woc5PyLhDAO9ERhc6QcEATkzmfHfspmkVLaoxfXzTl9fNLmqc3ny/yp+FdBpt
	 /CSY2GMWIxA4zlTZ58oA8/Xi1b49zZxpHoON41QV/ghxkeK8wKxoGhGslU9NDx9AHmaNR
	 mDC27KZqnLcyn9rsDBpKMxiNFqB5WXUU7g0DLa2OMQT/IEgNrt/rDRsR8qGOoKzUSzXwD
	 YUlmLB3MmRFpH8yOTT3R0m7hJic/3mBay/QtlozTSW3ShLLM7Du4wJzXv0nWGBme5ikm+
	 1FUst1sluZB/8ZxSw+5W9Wrs1T2Z3EKqAW02N9HBXAdomgpAKsfwHPoCMqaepLw0nhw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ajyny5zj;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F41CF606A326
	for <mptcp@lists.linux.dev>; Sat,  7 Nov 2026 12:18:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ajyny5zj
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A31031F0089F;
	Sat,  7 Nov 2026 12:17:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794053880;
	bh=BEEQjrDENStsvPilDaZcVgNONSjjIsuhAoizVLfTPeg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=ajyny5zj7rY5d894d0j4UbSy4Iir42lDFi7tBWVyfz1cIZaJ8JbRxq5w2yS3uIe26
	 e3VzYDwCPgNQYcpEXeIYV+0HG2Cabj8Vv0l02OycHAXI05Y51ThcQ0g4d6kDnXMGPL
	 jMpSBRdvOzNikeY/uzxSguq85DLVVJvtxh/j/C0lw7LBnfE7Y2Xurq8HQ1ZJPpUme6
	 9tEZ+a6/3lrNkf4h1kZVujTw8hWTnPIJHFu0CL48QsKmq/zLR667YHWkW0TcgXozBB
	 9RKuAGhX3lrR7IiuXdDaNAcwWAbpl5cTtWUhIUL4XhvCMXlAvA7N69POVCQo9vcX6p
	 l1+bSYxyMbnMQ==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Gang Yan <yangang@kylinos.cn>,
	Geliang Tang <geliang@kernel.org>
Subject: [PATCH mptcp-next v7 7/7] mptcp: update mptcp_check_readable
Date: Sat,  7 Nov 2026 20:17:20 +0800
Message-ID: <12d1312985430db3db37a0f2af487ca915169113.1794053683.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <cover.1794053683.git.tanggeliang@kylinos.cn>
References: <cover.1794053683.git.tanggeliang@kylinos.cn>
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
index 0c933bd6ad44..0d5012caf42d 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -3509,9 +3509,11 @@ void __mptcp_unaccepted_force_close(struct sock *sk)
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
@@ -4613,7 +4615,8 @@ static __poll_t mptcp_poll(struct file *file, struct socket *sock,
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

