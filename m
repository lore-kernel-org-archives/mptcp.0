Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1006A35E1B8
	for <mptcp@lists.linux.dev>; Tue, 26 May 2026 09:46:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779788815; cv=none; b=qfXXlsO6WnlUHtSzjqmGGHP97SBOALv2gcjAwuCzt/zHE7BqG0ljlS2/zvROb5AqkFWuYzPdvtarFiG7UW283euzkZn+0cmsWdJhWtWFTvr0KNpevdBrwwbso4OGBx271yewlRhtiYetvln5kMPLwvPUvswW0cuQkgx7kixYPMM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779788815; c=relaxed/simple;
	bh=QZcqk7MR7wdDmplYMQxEXzAQLtnPXnYRFCFqR7Dcz0A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JkQbP9tEQHXtBfhqEFlQxPhd/VvhOpx0DcItQ1em+Wruw8AK9l8TCyBj4AmGnlBX/3IUfWdSfNIDa0ThXs4XOoxgSxHt19mOfrKgNltrpUrqaNX8NbrtT0kjpuoC09fHGSFzUti1yW6VtxA/olnaK/CUr1dCFn+E7DoPdejU6+U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=a3DRJSoJ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="a3DRJSoJ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 975421F000E9;
	Tue, 26 May 2026 09:46:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779788813;
	bh=LA4mZqUMFsnjmZO2jsCJMgKZNRE5xKZzbra1tRMV0Hk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=a3DRJSoJuypEMLpB8oJeL/MgbL2UK5szm6kHe8AfTg4Awg31/u43y0qXt6Anp/bnH
	 ZHQDJr8jAjVwnqye0YcFwKtoBFIxetjRr/q0UW89Vxf//63elnfVq8f+5WnYPHwKTg
	 GqvhHdovrnJvX2nIgNXDt0qZ5q31i67YAv5KH2SeVoIwKDw1AcrrBwQqEKvmS9wC6R
	 qmNqtwAEl+Eda5fglFNic6016t324aYZAJw9jcavSNrK1tTUYJAEbaeqF2kufYyqZu
	 WSRwg8BwsPTwQyq0rJHOhEmNg6qxMT3Gz2fTweTdGhawPYjAl+LltDzTLq+LjBxKOo
	 xhLmaky7F4caw==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Gang Yan <yangang@kylinos.cn>,
	Geliang Tang <geliang@kernel.org>
Subject: [RFC mptcp-next v20 04/15] mptcp: update mptcp_check_readable
Date: Tue, 26 May 2026 17:46:22 +0800
Message-ID: <c663bfa6b017dcb90145daa577ac2c8ebe94221d.1779788090.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <cover.1779788090.git.tanggeliang@kylinos.cn>
References: <cover.1779788090.git.tanggeliang@kylinos.cn>
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

