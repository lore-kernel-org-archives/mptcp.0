Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A53412C234A
	for <mptcp@lists.linux.dev>; Tue,  2 Jun 2026 02:33:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780367595; cv=none; b=mMQBaL2S7fC9ma8OBuT99SwNsCV+jauDGjgF9+HZ60ZmMGQ1OFsYY6DIwxgNmEbFNVxorSL4Sy6P2SngMlayqmMRjjB7yZ0/heDEkpTtr5CRTJ0Kce3h8V4B+AA3MOrw8CIl4K3n2klwpv6zq497erZPzF0CJDB3mzpYn3MI1V8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780367595; c=relaxed/simple;
	bh=+JQVOl96ECamJsqouYmqcp9F3wpxk7t2HlN8ghsQMgs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HnbV9iz2jQud0MOjSv1SEV+TiIc4A0MPzvHkZV7lJL6UNd7ACnQVaR+wDSj8FWf0q6K+vdNNYuWpVnwO7qMrE08mjWr1XtKjEMnWcuMOo1Fw+445XkyFrWAqF3rsjX9MAbxGQf/fFnTZE9HjcHmvppA0iRw4o5LqccpApsmDU+A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kN1RfbWb; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kN1RfbWb"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B02141F00893;
	Tue,  2 Jun 2026 02:33:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780367594;
	bh=YptEY7JszF1atx6+IwVbZvwpCUwjJrxVe8ZBhhToby0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=kN1RfbWbp9beuEjGmAoW4heB0Q3QCDYbSciK7riFntEMbik6XcQGmm4qcEp0VvWZV
	 65zJPEzAiHyjQyYqIJvR8hh2mRnrjaPsX7A47v46KlFKk6vFiViGIuBjO4XEG1NToL
	 UcTplj2CAAC97W/9zoBqkbm0ta9VRVBgEeINTvTv6Owv/nU3SZxR6Yc3XqXfsFm0P+
	 9OxXO/zZhWjfsZTqEqaPVN6TuxQNeHRU1jHqdB4IAJbnNGBUyCepwk6gN83gEBf8q6
	 GG8XIPn3QXeJUQI8VVj3KYE1mhzBqdpj8JFSlXmo5q3NXw+ilkmTXVhomYHbzM2Ii1
	 HMHn5N27tYw2A==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Gang Yan <yangang@kylinos.cn>,
	Geliang Tang <geliang@kernel.org>
Subject: [RFC mptcp-next v23 04/16] mptcp: update mptcp_check_readable helper
Date: Tue,  2 Jun 2026 10:32:45 +0800
Message-ID: <5e7b5b20e620017ec8432e9cf2a3e0f3cf11f217.1780362942.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <cover.1780362942.git.tanggeliang@kylinos.cn>
References: <cover.1780362942.git.tanggeliang@kylinos.cn>
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
index f1d74d4b28cf..5446e8a841f9 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -3334,9 +3334,11 @@ void __mptcp_unaccepted_force_close(struct sock *sk)
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
@@ -4400,7 +4402,8 @@ static __poll_t mptcp_poll(struct file *file, struct socket *sock,
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

