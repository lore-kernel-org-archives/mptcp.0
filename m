Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B268735B138
	for <mptcp@lists.linux.dev>; Tue, 17 Mar 2026 09:13:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773738820; cv=none; b=reGDptq6MVRwjGvkSrOWezGfBBmer33m2o6uawBYg30/Fh0EhCXiIpl0KkuVDhs8FUmbkbY1Ux0GngA5rFi0GAtN8WIvP7GfEl0nKn898pNQ1wqn16gU7uEohcYJ7IZ5NdWJOsosyCK9eaFN2l/cBPu5DPWu9Dv2vF42dGBCmBk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773738820; c=relaxed/simple;
	bh=gKHyvosmK+Ox2nSYitqTgWp5DrHAaeGPnAjnUS+lgOc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=n4E52h7gnIBufBJKZ0/AaQA8UV0pIFGMbSbXK3uRJ0GXCeKiFF8Ug5m7h5YH0LgY14OsGGZONi6WS3BtnAxlPCY5j5McW8j/d5A14+NjBfkc5RQyzVy8M9pbvs5xwjCMR42th77Gv6Saduze5iAWCL7WR7oRQTk8RCDKMImSaA8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hEAH0eBG; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hEAH0eBG"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A19E0C4CEF7;
	Tue, 17 Mar 2026 09:13:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773738820;
	bh=gKHyvosmK+Ox2nSYitqTgWp5DrHAaeGPnAjnUS+lgOc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=hEAH0eBGL+f0aJPcaiapZ3tVQB3EFn6H3/dJYx0iNlD0R70HhPOz48A1HwVq8W+xB
	 pU198wXy/gLhLKOAJ4oCeGNv+hxshsf+sq5BG57gUgQb02N8lZIdgifOd1AhnNQc4o
	 DajHmwx6qJWeKS1qq0ph47wBNpDgPzPdsprzwntzfyUOM8Jd7rH09a7r3ykp6wdSr0
	 irzGLC6k+a+MpDSvCI2xVsvtIljsRCyYjutVfA5TRuLV5YCFf6J7AC2VF8JVg2n8Gv
	 +ceOCERARp3RWouHcFkI+RG2w7Eq+X19Ie6D9vUBarvU7oFz/yYT5LUh/CUXDHn1eL
	 9igWQdRD7SOIQ==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Gang Yan <yangang@kylinos.cn>,
	Geliang Tang <geliang@kernel.org>
Subject: [RFC mptcp-next v10 04/14] mptcp: update mptcp_check_readable for TLS use
Date: Tue, 17 Mar 2026 17:12:40 +0800
Message-ID: <78af1d93ccd2297c4048528858bc41bbc7663dbc.1773737371.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <cover.1773737371.git.tanggeliang@kylinos.cn>
References: <cover.1773737371.git.tanggeliang@kylinos.cn>
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
index 023a4fb68617..5585f43cf879 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -3309,9 +3309,11 @@ void __mptcp_unaccepted_force_close(struct sock *sk)
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
@@ -4373,7 +4375,8 @@ static __poll_t mptcp_poll(struct file *file, struct socket *sock,
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

