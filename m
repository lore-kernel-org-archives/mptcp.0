Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5ECB93B8944
	for <mptcp@lists.linux.dev>; Sun, 30 Aug 2026 14:33:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788100394; cv=none; b=H0uq7S+Ca3v7/UzfcC7baHEjjLxMqBbYgUq2g3QnZMwSsOc0S8CrWNjk606qUix9MUe0NBTiqEGcIYCDMgf5PINebxVnFnO8Yxv7fUapyXZMiYuwwjaCe4e+v6TirLUCkwuXtYmwD0sxMkUvxQY4t//mqY9aU6I4srSjQt05rRM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788100394; c=relaxed/simple;
	bh=NNm165/+IdnrjUopSYHVmUc/G8hqahUMDUaEM1LBo1E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Mj7bsS9IEhX94iK0HEvG0qlwppQDv1eh6joF1YI44+pSPo0a7Grfu91jRk4Rg7E2J9/4EDkMMqAhE756Zke52lYcx7z8TvNOirzCjNLsfD0kpa+p0LgBFxgImJ+LWQGVKP4bT8fEH05E/jDUldxmSl5iELGlwpOPGkYmW0OPmO0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=O7SdWrlV; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="O7SdWrlV"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 187C61F00A3D;
	Sun, 30 Aug 2026 14:33:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788100392;
	bh=zTKnredNrEC8ElkQca+aE+a1Ea0MncXukOPT097Qm6k=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=O7SdWrlV1MnzrGtsjfTSBGQMIqRJIT4ZbppnoPmwkjjDwQG0X6GR7f2VktEXZEqtz
	 i9j3E8OgQytdFN8fgxAjn85tITc3EBjzMqyOWnH3dN+5Ce0nUM3gCfgF2PE22GOsbH
	 mOuxS0tVCkSVKPS4wWfl6UsdsMF8RsSkNEoV2wHFPgtTF/X2Z7VUeGToS4MYNOHloa
	 ppJoWOynPGfoA/IlCl0Y9LV1UFY/PFzZLAvAKQSfuEL8BXxq/DiAGaXte6f2/QOu/n
	 mCYE77tTuXnmBmdN24NasV+SOeYa5azdU2PK/6EFdwlzRYD9wcvYXUYHcJLV2Zt3IP
	 lVNlUHTIAyIww==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next v11 06/10] mptcp: align FIN handling with TCP via SOCK_DONE
Date: Sun, 30 Aug 2026 22:32:49 +0800
Message-ID: <d75c155d68fe944268388a0d1769756032648573.1788099847.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <cover.1788099847.git.tanggeliang@kylinos.cn>
References: <cover.1788099847.git.tanggeliang@kylinos.cn>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Geliang Tang <tanggeliang@kylinos.cn>

TCP uses SOCK_DONE to mark FIN reception because RCV_SHUTDOWN alone is
ambiguous: it is also set by RST (via SHUTDOWN_MASK) without an ack_seq
increment. mptcp_inq_hint() used the latter as a proxy for "FIN pending",
causing over-count and potentially returning 0 to peek_len() on a
RST-while-data-queued socket, hanging TLS/BPF strparser consumers.

Mirror tcp_fin() / tcp_disconnect() in MPTCP:

- Set SOCK_DONE in mptcp_check_data_fin() next to RCV_SHUTDOWN, strictly
tied to the ack_seq +=1 that counts the FIN byte.
- Test SOCK_DONE in mptcp_inq_hint() and mptcp_recvmsg() so the FIONREAD/
recvmsg FIN-handling only fires on a real DATA_FIN.
- Reset SOCK_DONE in mptcp_disconnect() to mirror tcp_disconnect().

Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
---
 net/mptcp/protocol.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index 9bcca31501e7..2c0822ef4ae3 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -735,6 +735,7 @@ static void mptcp_check_data_fin(struct sock *sk)
 		WRITE_ONCE(msk->rcv_data_fin, 0);
 
 		WRITE_ONCE(sk->sk_shutdown, sk->sk_shutdown | RCV_SHUTDOWN);
+		sock_set_flag(sk, SOCK_DONE);
 		smp_mb__before_atomic(); /* SHUTDOWN must be visible first */
 
 		switch (sk->sk_state) {
@@ -2412,8 +2413,7 @@ static unsigned int mptcp_inq_hint(struct sock *sk)
 	if (hint_val >= INT_MAX)
 		return INT_MAX;
 
-	if (!hint_val &&
-	    (sk->sk_state == TCP_CLOSE || (sk->sk_shutdown & RCV_SHUTDOWN)))
+	if (!hint_val && sock_flag(sk, SOCK_DONE))
 		return 1;
 
 	return (unsigned int)hint_val;
@@ -2485,6 +2485,9 @@ static int mptcp_recvmsg(struct sock *sk, struct msghdr *msg, size_t len,
 			    !timeo)
 				break;
 		} else {
+			if (sock_flag(sk, SOCK_DONE))
+				break;
+
 			if (sk->sk_err) {
 				copied = sock_error(sk);
 				break;
@@ -3729,6 +3732,7 @@ static int mptcp_disconnect(struct sock *sk, int flags)
 	msk->copied_seq = 0;
 
 	WRITE_ONCE(sk->sk_shutdown, 0);
+	sock_reset_flag(sk, SOCK_DONE);
 	sk_error_report(sk);
 	return 0;
 }
-- 
2.53.0

