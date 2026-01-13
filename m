Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB471325488
	for <mptcp@lists.linux.dev>; Tue, 13 Jan 2026 09:09:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768295376; cv=none; b=d1xaYT4LPd/NeHp/S1qLY3KfT0eRJuyWpNW5DB8EfoQ1nJALTukSyNgbdSofkxHRaUJTyg7N/oNbf5oAWKR9AiLJDr09fgizASkJXBVGc8eQM3m/VPHXFqSvA1Bau5UeSZ3plXTtHA68MaBWzLqeFHtQuTT16E0gjTeVbHxV+Qo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768295376; c=relaxed/simple;
	bh=n64iqdK9kIbQnTyGOnOCSHHDNP6gVU09yKRuDcObZsw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZV6Lq5eLNqYB8tlstUucBQQf1sQKfnzov9L+ogeKv6zs4db5I7X0Fg205KvH0ML0CxEY7ECZbt3mxjqGnb0yr6IzqvSGv38CA5u9T/ZfmiJhO+f41Lv+kYwJspPuHZy33WSrqqEHAc1qvm4/FiIaJr0kLKvJI/BWy6Cij8P0mjU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fY31AnKo; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fY31AnKo"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6C228C19422;
	Tue, 13 Jan 2026 09:09:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768295375;
	bh=n64iqdK9kIbQnTyGOnOCSHHDNP6gVU09yKRuDcObZsw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=fY31AnKoLxfnBQzBPratsBZDXF+QaUB57PhVnvI1gusiE4u1We7lwWWIhBOAijtlR
	 a3zBqRQEaJTnUerc8iI8YkIbI8jDQ4FNeTlVy6qH0l53uD5QN4bGkkhroTggREgRNv
	 NMf1y63KvPPYRoapRLsqoef1IeneEJqIOfGRmxURAXfBfp+7vJysS+on8VVjhZH9Z/
	 Fs7JN5sUSUIXbWyruWvSiCYUxZaxhtoBBU97glilRxP53qS31LriztnBJvGKPbHJhh
	 38PnCpDgrqbOIoOSD9NkQ2ckfwyc+6x8Gfv4coCXJcKY04M9tibZ2bEzTQQFjrM4uI
	 N3sVY3QWmL72A==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Gang Yan <yangang@kylinos.cn>
Subject: [RFC mptcp-next v8 5/9] mptcp: update mptcp_check_readable
Date: Tue, 13 Jan 2026 17:09:13 +0800
Message-ID: <a2bef0a2891f3f4839d73518747fd2cb43c34368.1768294706.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <cover.1768294706.git.tanggeliang@kylinos.cn>
References: <cover.1768294706.git.tanggeliang@kylinos.cn>
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

Signed-off-by: Gang Yan <yangang@kylinos.cn>
---
 net/mptcp/protocol.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index 900f26e21acd..b10a5e0d808c 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -3239,9 +3239,11 @@ void __mptcp_unaccepted_force_close(struct sock *sk)
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
@@ -4303,7 +4305,8 @@ static __poll_t mptcp_poll(struct file *file, struct socket *sock,
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

