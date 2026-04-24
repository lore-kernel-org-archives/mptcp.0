Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51B07382F15
	for <mptcp@lists.linux.dev>; Fri, 24 Apr 2026 10:39:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777027142; cv=none; b=OzwA3v37dsU0VzY69OPz7m9fvrXajlrL7uJScVvDFcMwhv7jDJzC1pn3TJpCcRQ/vB2pDwAt4cJtQTQq7UFgRt2/g+g9EuhtTfGXYlfBrqLGog6dk+As6K8M75qnW3zEo0y7PGtwJxMfbtLhXTsrREuAuk7FwbixKYk7JJMqYJc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777027142; c=relaxed/simple;
	bh=TWUMxOA29PdbpJEVwwkjAYfIP9tKyfs8M9pBX6ufxuk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KgILPuisLuwNq+BP51WDjDehQrDH6lA9NCJi2sQJHWdbVrT/Mg/YmbbhPdm1hiLbmrYg0N+2qtih0K5odQt4zx7R2ghSOclMr0pNbwURjl+tjVeFjsM4zTazaQicM6etjBTT7CrWdPAbgcPucSEgL7iNCQ2weaVHkTB1sBC/ZBY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=J02WXyHF; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="J02WXyHF"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AF502C2BCB4;
	Fri, 24 Apr 2026 10:39:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777027141;
	bh=TWUMxOA29PdbpJEVwwkjAYfIP9tKyfs8M9pBX6ufxuk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=J02WXyHFlAtjOoftCUy6rry/yUA9DM1qZS0t9532Vo2RH6bVRUHIuWHMqyDDBq7qW
	 9FZb6uPfmmbdWIDbfu6AaBMpcn4g33MBofzLx7mP3nIpfql6pPb7ib7DisVIdDb1sg
	 dE0TQfY1MlYlkmEm8zVUrmWaEzHLmVA1DpMwuZYMvhTpzPe4o5yNMKW8QXYd9njT2z
	 Iq9ZbQBkgMpP9GJ88V4vrOdKn6rVh0dVRra4ed65SDjLVAe9UALT0f7vPcldvxP0Md
	 vCCgNDNv+Hen9455RPwiRukg3N5DR9iQDFP/NlN+8hqnhT4e491Z3OedH93TaJ0M6J
	 znQhUw+G2dgwQ==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Gang Yan <yangang@kylinos.cn>,
	Geliang Tang <geliang@kernel.org>
Subject: [RFC mptcp-next v17 04/15] mptcp: update mptcp_check_readable
Date: Fri, 24 Apr 2026 18:38:28 +0800
Message-ID: <6a90b28bbdaba8d6112770ffa37a0b787b9b2cef.1777026753.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <cover.1777026753.git.tanggeliang@kylinos.cn>
References: <cover.1777026753.git.tanggeliang@kylinos.cn>
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

