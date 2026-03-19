Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 702B13AD536
	for <mptcp@lists.linux.dev>; Thu, 19 Mar 2026 10:09:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773914945; cv=none; b=WaUS6uruoqc2TSFwBwpb7+CoOfOZuqyMXLuZJVyMO6N3rJP1/sBEYcCClIcQPi1bTNfz5N6ce4COIrYmSsXfy8yH5WKwqLhkscYbkBm2Dy+9YmSgh+1lLoblRsLCf3vrB7OO33n+2JZzkT+//BdRNZrnlML4uKE6PWzO/Gi2848=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773914945; c=relaxed/simple;
	bh=gKHyvosmK+Ox2nSYitqTgWp5DrHAaeGPnAjnUS+lgOc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NN8y8seRkJO8YhAEj+5JFmhanmVnRWT7404+8JfccK1zxaV+zSQ6wx+TKu1XuKStQ6vX1jIS4geuoUHu9iEeaj3O5qA9H9UjdMr2erBQwEnvngDYoDgbWXWLXiv2YxWhcCO5RrOpioDxLtiVdZm0zguhi4xpFJBOi8xYC7DIIQc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iEPTOOi2; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iEPTOOi2"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CD24FC19424;
	Thu, 19 Mar 2026 10:09:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773914945;
	bh=gKHyvosmK+Ox2nSYitqTgWp5DrHAaeGPnAjnUS+lgOc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=iEPTOOi2lYlqcfJ5yvYSA7nahZP0uUPwfoHwGKKOVXC4vl2NLIG9hcqdq0xtEwFdw
	 53PDpI1CzarYFw6VT0H6MhO0HIQBoWQXnrlGwG8sYpaZzVgPbp+ATD6rvLs9s6ZgqP
	 Sk3isnQb42EJEPU0/e0MpKtRs0UDZvRzdYz1DvHAGl7YvrP+EDLngoL80qIMwkyFMm
	 dK42YFSPYMY+kTdqTCS9Q2NgyunDO0dvQQnFqIozQSH5g5XQx3fecwR+JPLRO9nCEu
	 GjvSDGzvAAh3sA0Ao3SiHjyJ/d4/gbZX8v8oSvMLPfVgZwmoJv/yNPzf8nmtD9jzR8
	 D9FLkW5Rnmg7w==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Gang Yan <yangang@kylinos.cn>,
	Geliang Tang <geliang@kernel.org>
Subject: [RFC mptcp-next v11 04/15] mptcp: update mptcp_check_readable for TLS use
Date: Thu, 19 Mar 2026 18:08:37 +0800
Message-ID: <aa6e51ef0acb14660940e6f0471fd0485583b39a.1773911536.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <cover.1773911536.git.tanggeliang@kylinos.cn>
References: <cover.1773911536.git.tanggeliang@kylinos.cn>
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
index 023a4fb68617..5585f43cf879 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -3309,9 +3309,11 @@ void __mptcp_unaccepted_force_close(struct sock *sk)
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
@@ -4373,7 +4375,8 @@ static __poll_t mptcp_poll(struct file *file, struct socket *sock,
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

