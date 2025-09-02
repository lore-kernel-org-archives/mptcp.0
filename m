Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 121B61DD525
	for <mptcp@lists.linux.dev>; Tue,  2 Sep 2025 02:35:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756780521; cv=none; b=cxRdiUrOH6PniuRZ+RflBwzyRwumWMB5SEXIWYffski9JSOD3ODYRLW1hdRYN12Di/Km8DXgjWw/6HjJj8Q/E5fSi/RNNxbSjRE9JhvprOAOm7vR8eLMZwYfxYL37qM5lccx4CdtB+SCaMJ5VyrzSku1JfY2bm0pfdCB+ow4z5M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756780521; c=relaxed/simple;
	bh=OqnkOlsEHCJSZsIggXb5XZujaunSMz0Dpd8INTwLyfg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Jpo5Y2Z9rpDBCP5cy/i9UZHH9o0cRPAqPahG5H/0W0VB/AkjRHp3/iS6QpOK2zc6GrknWgZ30nJEpBU/T0ihfAngv9x4QbgmlX/2nvyXz4ikIbPLdykxSGLCDJMZUiLfBbArRTpUgZdn7+iDjnWdUX5TlIbl2BBAJcrPuWKdwms=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DWxVndA9; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DWxVndA9"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 63B35C4CEF0;
	Tue,  2 Sep 2025 02:35:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756780520;
	bh=OqnkOlsEHCJSZsIggXb5XZujaunSMz0Dpd8INTwLyfg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=DWxVndA9ovpf8hKUjQGbg2c3fpUm9zbeXRXfHHCwKaFD8GBog85I9c1RbTJNmK0JP
	 NSIRGBZLtCgHys50M+yUidd3EgOTjsO8QI3DgL42Ms4vb0qKNQ80dV1XDt08i2rmgF
	 1l334BzBR9ReS3C4IG71haRFm7jhOLBe9+rZb1e5eyiiNBua4CslrjvTaW5h9Jr8t/
	 aBvs6BSa0hu7lYXZDnKOy4SHe2Y7U335wOgsL2HXv9Bd1Uy0nzRdDwRu1OzNVBppVb
	 aB0DiSv+bzbOE9rylGQ11i7QUc2/lSV62yn0LnHvNl82kTgiNAKmcJfxIce00TQDm7
	 EuXllD3Q/2bHg==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next v10 6/9] mptcp: use recv_should_stop helper
Date: Tue,  2 Sep 2025 10:34:57 +0800
Message-ID: <96089b8fef2d353fc9e0be055e8659a6a1b572de.1756780274.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <cover.1756780274.git.tanggeliang@kylinos.cn>
References: <cover.1756780274.git.tanggeliang@kylinos.cn>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Geliang Tang <tanggeliang@kylinos.cn>

Use the newly added tcp_recv_should_stop() helper in mptcp_recvmsg() to
check whether to stop receiving.

Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
---
 net/mptcp/protocol.c | 32 ++++++--------------------------
 1 file changed, 6 insertions(+), 26 deletions(-)

diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index f55185410e5b..6574f82d59d1 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -2183,20 +2183,12 @@ static int mptcp_recvmsg(struct sock *sk, struct msghdr *msg, size_t len,
 		if (copied >= target)
 			break;
 
-		if (copied) {
-			if (sk->sk_err ||
-			    sk->sk_state == TCP_CLOSE ||
-			    (sk->sk_shutdown & RCV_SHUTDOWN) ||
-			    !timeo ||
-			    signal_pending(current))
-				break;
-		} else {
-			if (sk->sk_err) {
-				copied = sock_error(sk);
+		err = tcp_recv_should_stop(sk, timeo);
+		if (err < 0) {
+			if (copied)
 				break;
-			}
 
-			if (sk->sk_shutdown & RCV_SHUTDOWN) {
+			if (err == -ESHUTDOWN) {
 				/* race breaker: the shutdown could be after the
 				 * previous receive queue check
 				 */
@@ -2205,20 +2197,8 @@ static int mptcp_recvmsg(struct sock *sk, struct msghdr *msg, size_t len,
 				break;
 			}
 
-			if (sk->sk_state == TCP_CLOSE) {
-				copied = -ENOTCONN;
-				break;
-			}
-
-			if (!timeo) {
-				copied = -EAGAIN;
-				break;
-			}
-
-			if (signal_pending(current)) {
-				copied = sock_intr_errno(timeo);
-				break;
-			}
+			copied = err;
+			break;
 		}
 
 		pr_debug("block timeout %ld\n", timeo);
-- 
2.48.1

