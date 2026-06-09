Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C7F1264A97
	for <mptcp@lists.linux.dev>; Tue,  9 Jun 2026 02:19:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780971590; cv=none; b=eioFoCDj9IMcRwdEKdsBLupsSe+K+JuZm4dzGNPdfu0qSeb8ohXsb5ePzLK/H+33xHSV85cHfbR+0hu508B1OdcgZOwzBZ8fUYpLg9wCP4od2f4Z0UNqkWIFjrUiSzRqrtX461PkzkgSBA3YYgOEInvScycSOGobL8WYTpzEt3g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780971590; c=relaxed/simple;
	bh=sGz3OO2IgIUsz7E0+PlicNJvuOcjAbshlgLTXQ3g6uU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FMtoQ5ItHm3x8JBg/YraAFwpOPrIq8kj6qnFvBhiS3XDRyj6OzQ+D4XCjNZJy4ssV6T4Zlu4ZwXCiyUvZwMHZSZ8dVt/Xg/Pnwxrmkj8IZLSRgilvWW71y31fCpHfbj29XfDQDyjJ2PS9PahonWu94GanDChRTlWOnCJ0C2FHjQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AI+OtRjE; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AI+OtRjE"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B1CD81F00893;
	Tue,  9 Jun 2026 02:19:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780971589;
	bh=zIjPeZmlfN3afVBgqzrgpnKBqA/zf/ZD+cs5aWtqvgs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=AI+OtRjEbiIq8eTIf5UtVoY5bc6W3IlGuDUWcS7tPpCGlTVvfOaDN88tYIvonwOCR
	 88Jq2K8A596h+3jiyToeMLHL1PS9BQAv5snWLcx2nLmyLptb4j0buJHXu59e5yZlSl
	 JNk8ZjIgtg84pHkmfFU2FV6m1DczYq7R9KPblbCU3X3PuJFy7VriTKxBiBjbFGCFfd
	 HfXu/WQC+O0nK6Gy1Rp4gqLR/C41+wA43CW/07lTrQHeLB0DDtk6dgC6ZA2lKUdsSa
	 sLVPM3L9vhQ7pQM5kaOmCEVMQH7Qaa7TGhOct6sWPtkrcltOG4Xwl982lkEAlGQwik
	 M9Jc7OzPABieg==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Gang Yan <yangang@kylinos.cn>,
	Geliang Tang <geliang@kernel.org>
Subject: [RFC mptcp-next v25 12/22] mptcp: update mptcp_check_readable helper
Date: Tue,  9 Jun 2026 10:18:38 +0800
Message-ID: <11d376b04e2b0f440da0513b76c19acc0ef6d577.1780970284.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1780970284.git.tanggeliang@kylinos.cn>
References: <cover.1780970284.git.tanggeliang@kylinos.cn>
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
index f4cd7a6e5770..88504af790f9 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -3410,9 +3410,11 @@ void __mptcp_unaccepted_force_close(struct sock *sk)
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
@@ -4476,7 +4478,8 @@ static __poll_t mptcp_poll(struct file *file, struct socket *sock,
 		mask |= EPOLLIN | EPOLLRDNORM | EPOLLRDHUP;
 
 	if (state != TCP_SYN_SENT && state != TCP_SYN_RECV) {
-		mask |= mptcp_check_readable(sk);
+		if (mptcp_stream_is_readable(sk))
+			mask |= EPOLLIN | EPOLLRDNORM;
 		if (shutdown & SEND_SHUTDOWN)
 			mask |= EPOLLOUT | EPOLLWRNORM;
 		else
-- 
2.43.0

