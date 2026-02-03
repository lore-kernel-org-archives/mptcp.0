Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CED2273D6F
	for <mptcp@lists.linux.dev>; Tue,  3 Feb 2026 10:19:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770113962; cv=none; b=ZB8/Sd3qdd2Fu18BwH1iLmZexSs1LbuemeXaEoM7YUHzzBSJbnB97uImdTp4AltCTeCQFNEnjahey5+3MRBmkfXUmeNfTHucSB4lxzJHTkkEx749J356UhXE3skSUugWQFjygOD4jy0qZTzrergeDuRPenc+0z3N9hhs9B99MYk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770113962; c=relaxed/simple;
	bh=xs2O9udPOPXInB7C8lcL6Nd3DQsIXb/6bBWZg2OGO7Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=oKqlucJ4jSl07lZrh2vOkHs9IR43vA8otR5m6NIKZ+hN4YfwZ7Hsj0ugoUiEaCguQX2iE4+H+NndvIF33wvpJDYhF9dce6xe17xetCGhbc8PtPbhkOzTVPWuzfkMpWHhUjLoGKj+m8EQzmJXTDeKFhj59z6o7jCqhgZ+lkwT0Z8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uiU6MtZr; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uiU6MtZr"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D9E15C116D0;
	Tue,  3 Feb 2026 10:19:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770113962;
	bh=xs2O9udPOPXInB7C8lcL6Nd3DQsIXb/6bBWZg2OGO7Q=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=uiU6MtZr5WOWfR5z6PP4rR0Ccl05IbZ5mCckVKRt56HKDqSXksc1F6loKeSZakEYA
	 fkKcc0RlwAyqBE0tUzGfh+nM8ZJZQe/uLrzvLMDCJMMQltaPU3Izd7hsao9Om/xE9g
	 pO1VED7S5CE1enAjH3ZaCUA0FUZdbxi6FCYQiTnqYpp9E/5qHrqdiw43Gs8YVTL5/+
	 kRRllOdm8cgL9tJDAT00QSvIn/ERDPBUmlB8FjQp5uc5AmRVTES6obOJEYPEIbppOt
	 n9FmKR0uSKbS6QcXyM12hsrsKxQjgvSTff5EeN6Ub/j496a7A65hWEJMSdECrSvEvO
	 EASmZjDkziMtg==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next v2 1/3] tcp: export do_tcp_splice_eof
Date: Tue,  3 Feb 2026 18:19:07 +0800
Message-ID: <f6e88d31a52d519c3d9b6857ba0096c8dd8f082d.1770113743.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <cover.1770113743.git.tanggeliang@kylinos.cn>
References: <cover.1770113743.git.tanggeliang@kylinos.cn>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Geliang Tang <tanggeliang@kylinos.cn>

Extract a do_tcp_splice_eof() helper from tcp_splice_eof() and export it to
net/tcp.h, so that it can be used in MPTCP.

Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
---
 include/net/tcp.h | 1 +
 net/ipv4/tcp.c    | 8 ++++++--
 2 files changed, 7 insertions(+), 2 deletions(-)

diff --git a/include/net/tcp.h b/include/net/tcp.h
index cecec1a92d5e..9564fd7b73c7 100644
--- a/include/net/tcp.h
+++ b/include/net/tcp.h
@@ -370,6 +370,7 @@ int tcp_sendmsg(struct sock *sk, struct msghdr *msg, size_t size);
 int tcp_sendmsg_locked(struct sock *sk, struct msghdr *msg, size_t size);
 int tcp_sendmsg_fastopen(struct sock *sk, struct msghdr *msg, int *copied,
 			 size_t size, struct ubuf_info *uarg);
+void do_tcp_splice_eof(struct sock *sk);
 void tcp_splice_eof(struct socket *sock);
 int tcp_send_mss(struct sock *sk, int *size_goal, int flags);
 int tcp_wmem_schedule(struct sock *sk, int copy);
diff --git a/net/ipv4/tcp.c b/net/ipv4/tcp.c
index ae0000215ff4..80d374fe6543 100644
--- a/net/ipv4/tcp.c
+++ b/net/ipv4/tcp.c
@@ -1468,9 +1468,8 @@ int tcp_sendmsg(struct sock *sk, struct msghdr *msg, size_t size)
 }
 EXPORT_SYMBOL(tcp_sendmsg);
 
-void tcp_splice_eof(struct socket *sock)
+void do_tcp_splice_eof(struct sock *sk)
 {
-	struct sock *sk = sock->sk;
 	struct tcp_sock *tp = tcp_sk(sk);
 	int mss_now, size_goal;
 
@@ -1482,6 +1481,11 @@ void tcp_splice_eof(struct socket *sock)
 	tcp_push(sk, 0, mss_now, tp->nonagle, size_goal);
 	release_sock(sk);
 }
+
+void tcp_splice_eof(struct socket *sock)
+{
+	do_tcp_splice_eof(sock->sk);
+}
 EXPORT_IPV6_MOD_GPL(tcp_splice_eof);
 
 /*
-- 
2.52.0

