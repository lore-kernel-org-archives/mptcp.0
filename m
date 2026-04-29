Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1DB82D7D27
	for <mptcp@lists.linux.dev>; Wed, 29 Apr 2026 10:47:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777459645; cv=none; b=hVynU39Ko+8seOsgKy46w6uQcUw18kJSUqFZ2oc7dfkz9klurW7hVR+nkqpDfMhCeMypFSVHn3sFVA6J5vQwAW9S6YUIjhqIf8LhJwZsqAvHB9Rt11T/3wIs5Hqhb6SmMRsZdfyrV8Y67F1NR8dW06lNbvOdg/9ZmgrbtJ11mXg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777459645; c=relaxed/simple;
	bh=TWUMxOA29PdbpJEVwwkjAYfIP9tKyfs8M9pBX6ufxuk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JsBXvEJ1fXrmDM5LPcU79JUCZieTyUH0iEf/m1DVZzn1GSJ8el4e+sWLTB3Cqx0mfJFjIq7AJ+l+BOibyWm3FyEkNbanYdZ93tDPYLnnrjgjO5B6dPKOA6qr2CHyRk3HFIH1oKl62/XM48oKtQGgDANHCb/ttXCwIHpj/2qMMa4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=j418wzw3; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="j418wzw3"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6EA19C2BCB3;
	Wed, 29 Apr 2026 10:47:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777459644;
	bh=TWUMxOA29PdbpJEVwwkjAYfIP9tKyfs8M9pBX6ufxuk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=j418wzw3BSLOE91XFYfE22t859dWcs534nCGAlAOziILBjQeH5vOeXf0EAdBYNjHW
	 YC/Oej8abnm1SqhcBxJ4qAlc8nEEEW5n1zgGG8+zsAsPwn7g0dqUkSsmPWeDLRbfnG
	 rrpF2V5wVFPhamFpbO2AmslQbG1KSTcjSr3Lq4O0MbbOn8IX4IiKEJAK4X157/5SFN
	 NcaCg/piYKRDTFCE3duYa0SFOpPoo6XTRnxRyVeIJODObxERk462LIYbgfyJ+Xmjua
	 GMgeuuEgP2tdhRg0I9r3YApKEWPg1+CDIsoRqsFJ+NHMZhe0JQgTAk512Qe2ajFEsk
	 DmLUtdjO0/cug==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Gang Yan <yangang@kylinos.cn>,
	Geliang Tang <geliang@kernel.org>
Subject: [RFC mptcp-next v18 04/15] mptcp: update mptcp_check_readable
Date: Wed, 29 Apr 2026 18:44:52 +0800
Message-ID: <7a40b902e14aae603cfd915672ed32cc9d821cde.1777459066.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <cover.1777459066.git.tanggeliang@kylinos.cn>
References: <cover.1777459066.git.tanggeliang@kylinos.cn>
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
index 0db50e3715c3..5d4f0bc08973 100644
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
@@ -4327,7 +4329,8 @@ static __poll_t mptcp_poll(struct file *file, struct socket *sock,
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

