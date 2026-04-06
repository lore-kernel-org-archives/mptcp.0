Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFA1C883F
	for <mptcp@lists.linux.dev>; Mon,  6 Apr 2026 12:20:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775478004; cv=none; b=cC9hKj+x6uOJkWsINSdRj6UBq9GNnBuPnw6UuUcIx1xruUy1V0pqDxPDQaIKxxvATQa5wm4RkCkbagw0YRgcqyGoTY5AbT9AQe4oi8IbgfMNmy+d6A5AINAJBzsk9mUdbAOOMNtsoRlUgmu3NDmwmZJhjVZxs3b4B34fHORDWmU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775478004; c=relaxed/simple;
	bh=yeQQOTcPLG8EDrCGNsPeWyQDSb1Vj5d8bVELg5OxrpM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=OIrT/7kezHZRIFS0MWNUgQzni4BOus19Av8KbOGyD64FD5unui3Qa/uY9W8qdvUFfapWi86GxJ3GQ7fBHmddIx0mu1TltjHrtBg/B0VHhD7whDFipwKNRBb7QVB4EmLvom9FYI2C1EoaWuSFXEUIL4mEMeQC0o73oX7X/3Gj+oc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QBYRxEOy; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QBYRxEOy"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4C711C4CEF7;
	Mon,  6 Apr 2026 12:20:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775478004;
	bh=yeQQOTcPLG8EDrCGNsPeWyQDSb1Vj5d8bVELg5OxrpM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=QBYRxEOyvMpQ1zlzUHRlj9NyDpW72xBcwT646iQh7/jpWT1tkUlc6u82YZH1N2puy
	 oKjQjzN4ysdTVlqO+yI5Hn8z6K7L3u0TETc4MYgbDEURwnQBRTRXK2RRrJqvTbfMzl
	 G5ZZ/c+t3kIr4fSLSYpY4P8DeIMrvQ6sTePKWDnJ65XkuebgR2ocboohCBGdaP3AOu
	 JpcekvjdXxP5DMvWxJexnimt/lklNEBoGlpeQUu6ObKruT5cqkjZYB7bWCWaG1b0Xn
	 99me3TWziP8vSICZ53qsG4iIWfL31PN0H0UR/F2Nl55/D52McqaWXBvYvN+W+sONlJ
	 OIlGRiatHflQA==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Gang Yan <yangang@kylinos.cn>,
	Geliang Tang <geliang@kernel.org>
Subject: [RFC mptcp-next v14 04/15] mptcp: update mptcp_check_readable
Date: Mon,  6 Apr 2026 20:18:44 +0800
Message-ID: <647583579dd73da8f61ce822f87bfc667b79b6a6.1775476921.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <cover.1775476921.git.tanggeliang@kylinos.cn>
References: <cover.1775476921.git.tanggeliang@kylinos.cn>
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

