Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DAD011185
	for <mptcp@lists.linux.dev>; Sat, 13 Sep 2025 00:39:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757723954; cv=none; b=F7CKzW2jk9T5pmvPCQTaGsiVAciMBjBu/fgqWYhtVbX3Ia8Cq4nxJLQxJ8finjwSXkjQ6ne23eWnM1wFJmgIvyOCR3U6lnZUzcJ1hpiVLffxjnyYaeK2XoSgDxUky3hXmtr/oho1tVYot54dFQkHkY/vcpFZOGdynTOWn8G1Fn0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757723954; c=relaxed/simple;
	bh=a1wkl3z3gdzHoObtVAwTVrxi3rVt7rgpVMkphlb+Fb0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FduI3iXkvb2YGbYh8QXw0olQB90Ka/J0O8fOGAoJlqPhgo7dDfNdYnR+ET+IvYJ9Mekh5lQyQY4meM5mUj3kRg1AAk3lEzRJ3F15cu4BnuWkKNsiS7/LJJzGZjWZRm9+QbncOXvBO2MXGDPjFmqGDFIcMrBZGnaf6X5HD4rEpSI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=guaYuxl4; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="guaYuxl4"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0EBEFC4CEF1;
	Sat, 13 Sep 2025 00:39:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757723953;
	bh=a1wkl3z3gdzHoObtVAwTVrxi3rVt7rgpVMkphlb+Fb0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=guaYuxl4npt3fdwwLuzJqH73/JNsYpLIKItKNBx2EHVda1z0y5u1ArqduroipVwEH
	 gg4++zSh/75J/zeltMpcJx5lMnDjr0iZRuOYxyAG3Iqspo2U09wcwJUv4HN7ce2J7S
	 8gV+JgRGgpbRtDIG4Vivsv8hHJQ4m0a2UFh2xbKEoMj1eLx3AUOpGQAlVX5T2jeTWb
	 exPkvwwBSd5kieAwB8Kb0K3X5E6lukGboH4LBhp7tWtmK7Spn+cbyZz9WX8fheQb5K
	 Mw7ZdR84qZOBBVblA+oj3AH6pQdXJZIEHsbPEFQmd8ibbNWPJNwTXV2TbNmAcJOKMH
	 coYdrR8mCTbrQ==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev,
	hare@kernel.org
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next v11 5/8] mptcp: use recv_should_stop helper
Date: Sat, 13 Sep 2025 08:37:24 +0800
Message-ID: <db23004289850e1c9b162ca450b6b515889dfd28.1757723270.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <cover.1757723270.git.tanggeliang@kylinos.cn>
References: <cover.1757723270.git.tanggeliang@kylinos.cn>
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
index 00fe7531ba8d..2288ceda45ce 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -2196,20 +2196,12 @@ static int mptcp_recvmsg(struct sock *sk, struct msghdr *msg, size_t len,
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
@@ -2218,20 +2210,8 @@ static int mptcp_recvmsg(struct sock *sk, struct msghdr *msg, size_t len,
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

