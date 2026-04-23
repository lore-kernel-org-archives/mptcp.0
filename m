Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 787CD1DC9B5
	for <mptcp@lists.linux.dev>; Thu, 23 Apr 2026 06:33:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776926010; cv=none; b=nKxm3lodHAsJMVoiyHP0B4XTjboSSgk5/GKJaDduF/Ki3pYqH2MX0G/TJ7DpSXVogphtaOq1d0OJMszlIG6NvMzk4LMOPGqkshF9KYyKXjgEvPFoBUM2qIAu+EuzE7vxBCMWRSfZ+tRrHjA3A3tUh6ZkY/jNaWFzvo1Ua3XP3xk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776926010; c=relaxed/simple;
	bh=gFNaHC4jX1G27NDSP4EeMEXhgxH8h7Jo8CcgYg/VRTI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=aGZsTshzMA2oaRAqm7WEYLSMrI10O5IAOeJ2uyAsTBCT8n7AQEsagsLO23eYG0+VleVywGErfvim24UJfvNjHV9yrv720ayCK0Ik6owhAYOGtSlpxCdVqRXbM0/dg0D+VC3M1kD+D5PaYGxu7dxTpohrfnKHQbnb0Eo06MM0wbo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eLDzfQMu; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eLDzfQMu"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 444EEC2BCB7;
	Thu, 23 Apr 2026 06:33:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776926010;
	bh=gFNaHC4jX1G27NDSP4EeMEXhgxH8h7Jo8CcgYg/VRTI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=eLDzfQMuu32LAOSr86pjvbVPwE/yW4JAxRGgEuK2WgwPMLHdNPweSYgffESmjRPCB
	 +6cEX6f/DES7GBwboB2hWgfazUr2mv37bsTPQ/kkzCsYDeN8FW8wptchwed96plYWA
	 DKd3E4B17fSJMpRZ1U+4zT7kJeDH3d80ShaD59vNUdB3AFR5aatDk18ymA9EKsoUNV
	 wwbF0xihmCcdTIks+5cqUgZ9pk/e5EpU5FoG3IU+f3voWPASB9RQskoUjg7dpGDmRU
	 rp4TAfFJTrW2QP54zQUpmtns0e7ZZdQGofTvGxidsaNlPhP6ClF4ZTTx6pvFALoTxi
	 F5lcXC7aAQXuQ==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Gang Yan <yangang@kylinos.cn>,
	Geliang Tang <geliang@kernel.org>
Subject: [PATCH mptcp-next v16 05/16] mptcp: update mptcp_check_readable
Date: Thu, 23 Apr 2026 14:32:58 +0800
Message-ID: <79e867ea83ae7db0da0c0b0b80246f28dc90cca1.1776924681.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <cover.1776924681.git.tanggeliang@kylinos.cn>
References: <cover.1776924681.git.tanggeliang@kylinos.cn>
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
2.51.0

