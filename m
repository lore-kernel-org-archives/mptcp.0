Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0E9D29993E
	for <mptcp@lists.linux.dev>; Mon,  2 Feb 2026 09:22:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770024125; cv=none; b=UKP5MGQ+u0vQlgh3MICeESJTHvFStJzwGkYYIcs5drJrZ7JBHhanC/eM0x+aIF4kPEr1BvdL2+j4LMwgCS1fNpZxfUWMkszSs2KXfqb4odvdO+e2xtbj3JCdaAME+jRkbD1y+9D43C9zKPC4qtq5ajf/CXz050CkTmmw8MXuGaY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770024125; c=relaxed/simple;
	bh=CaLBCBga42CsLOU6PcsL5+S7QjugBExe4T/ZY/Qh0Js=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=uC4bLDtzZA1Su7KNtQRjF95TNy5VZx1N48I26Qg+lBNU80WOXjhQ5QH8P441eb3w8XPr7OR/8NePSJgFIJe9M9qw4Dn8c00Ovc7aiJWdk8sgsa8GyKcky1K6k0aC7F6ov7LtShg5iKB0dh4vmis2i9M6F9Kb1Zp0/gJ8c/INo9k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DAVwamP8; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DAVwamP8"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 96122C116D0;
	Mon,  2 Feb 2026 09:22:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770024124;
	bh=CaLBCBga42CsLOU6PcsL5+S7QjugBExe4T/ZY/Qh0Js=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=DAVwamP8iqbUDp1ehCPTOtN92rnzv55ZV7dQRjdKRD69u+Ftfh771OjHvXlP+vlBS
	 eA7D5NYeCjvLU/OuUlOG8TGNQwSRl/q62YP8gw+dgVf5ZCMt7KEJ5I+usmR+vlHmX7
	 JiWf0BsCrls9SxvSwo38zpgtuEJmPWp4ohy/PPkXpCP7OKQ+3SXSYPieT8zzySrqDn
	 g+vc2Ny9RDOIMUIK3rYVQ2HjvFJd2K4TzLXxz3ypCCkxNQysW+WtQSwRGwYvD9Am3Z
	 KCumGf9KotTYwe9HXUoMzVzW7GP50LD321WLAHoVpeLr1GslmXU2ZOa/hA9c8wKFES
	 llC42rtkKlmTQ==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next 1/3] tcp: export do_tcp_splice_eof
Date: Mon,  2 Feb 2026 17:21:49 +0800
Message-ID: <d4f0e9c14217851cd83d8a3d5ae829cca7519362.1770023932.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <cover.1770023932.git.tanggeliang@kylinos.cn>
References: <cover.1770023932.git.tanggeliang@kylinos.cn>
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
2.51.0

