Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADDC4371CF4
	for <mptcp@lists.linux.dev>; Fri, 17 Apr 2026 23:48:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776469706; cv=none; b=fbuoPRQXrshRMk5D94AxZZUf30skepF0Mc5k9xqvdq+CW4AgKfzwKK/b8eux8ysztASR/8VVeJndgmE3K5dWb8kqimXmF/cNkrkbLJUuzfQT3WcH33U8rkHK+O3b57iXP+ae9tX4NAAMvhrLeE4O2h3+InHAK+PMCNIJZCftZk0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776469706; c=relaxed/simple;
	bh=r8MNZp5WgROb15YVC5fOdejPhTj9GUw9kijbF96W7ZI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FXDtg86Uel8Rg1nkjSC2yv/Y4UUgL+Jw1dk3xtQc9daJpuvTi6suCUQTfca5yl2rHuN9PAoCYJXEdu+4m5ihwB18hKdFOZnwa8V2K+5KELTAw/n7/nKiyduXxmA+A/a1/y25DErU+b3ywQS83DEedhBdjXJ54yXPZAKJkDQTAFo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HTiWrcN2; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HTiWrcN2"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4F801C2BCB3;
	Fri, 17 Apr 2026 23:48:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776469706;
	bh=r8MNZp5WgROb15YVC5fOdejPhTj9GUw9kijbF96W7ZI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=HTiWrcN2W7cwnCR3hu3BLFhWM2LCetx/2YcOALvzDl7JIvTkTLGxBg7K3niGQd5rI
	 m9s6JYa+NOU+BDj8GcdIeYwpZsLj2KI4suQ7ta7rsvWWn5CXD8YjRuL24xgcm6Vjod
	 Md1tPVo/nRScZsiojIWiQsUfK8BIggzGzKXh519uSECU7engocXpvVphVAh4WAoa2I
	 pCMe19+RqeDyUbpW7Tx2d/CgDJWQb0Lwwfpwr6CI/LEfaZX1uKrVjfkbN69fhRfEji
	 ptN69OtJgLgL61Bh/jyliPlMfNDosMNVxthAJGa9jNdSGwVwRpu57BXySvG/mFH2w+
	 7jPsQLYd7GwUA==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Gang Yan <yangang@kylinos.cn>,
	Geliang Tang <geliang@kernel.org>
Subject: [RFC mptcp-next v15 04/15] mptcp: update mptcp_check_readable
Date: Sat, 18 Apr 2026 07:47:43 +0800
Message-ID: <dd04d9fdbad9b7d3fa10b3401ed85265e137894f.1776469068.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <cover.1776469068.git.tanggeliang@kylinos.cn>
References: <cover.1776469068.git.tanggeliang@kylinos.cn>
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
index 6b486fc94c16..b08010040b07 100644
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

