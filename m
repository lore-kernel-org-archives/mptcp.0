Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 031E7371CFC
	for <mptcp@lists.linux.dev>; Tue, 17 Mar 2026 09:41:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773740512; cv=none; b=KVq4H4q/DWLVUY7w/mHiDQV58mKYbMCupGCBJ+4TflCvLc2s5zrBfIxhOYnCAULbj/o9Aj/n7ewmHlKw9JsiVp28Mby/k/2PKLCAkzgfLx6uuO+1FPHek5/0mi1lB+Aq/3pGPT8iPlQDeKUNX/1CQy8bPdlKe7RCdoFhkjivfhg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773740512; c=relaxed/simple;
	bh=0JD/xP3fPHNwI9KH3JxQenrEEIm10rhTRKU6iDLLfz0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cLlFhc+G/SjTCFx7lgfDsxQUynNVJbkudU9P8kwmu2ItC9o9ucx/vSzbQgZLSJVSyXvovoi6hn0pdG0E1n7waRpQp/eG2kNMYRyWZOo4Fs2N5df6EyiNzBEkCViERoUMaPM8YJIuk2fnLdXwfwobYSoabkFtXqU0dT6wfEna2ok=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pV6woyWa; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pV6woyWa"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D4E64C19425;
	Tue, 17 Mar 2026 09:41:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773740511;
	bh=0JD/xP3fPHNwI9KH3JxQenrEEIm10rhTRKU6iDLLfz0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=pV6woyWaUEhb+pmF7BY5ULsP5JjXlwOlK7pmJAJoDEpQWl1dZmJgcyS3S+XFqo/YW
	 gBrH/Za/2BMMy1G9UwmDXAY4Q1jnz8ulHbaDt7Z6+Ll2H5KQ+10FA28eMFQVlcnnDf
	 4kTnyY1D/ZfFV24uCg41dcvMBQ3I0NOjeyMVBpACMERAeRTYsdkLAjLkdEIGHQTYnX
	 f1CAUdLoYMvyR2/ZwwY0rewmbcLi/lVs77rxW+TaFwiQFRcZHj8fZqatZ1DurGNj8N
	 WK0w8VhLT6Gv4lE8xPqSitoqyy89YbSrCA5KPXDDa16aiF+YfPpUB3TVVHcjI9zfDc
	 73/FU7jHPD3JA==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [RESEND PATCH mptcp-next v2 1/3] tcp: export do_tcp_splice_eof
Date: Tue, 17 Mar 2026 17:41:26 +0800
Message-ID: <f2a70d62f633f4f56e4d1ff862022672d64a7069.1773740361.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <cover.1773740361.git.tanggeliang@kylinos.cn>
References: <cover.1773740361.git.tanggeliang@kylinos.cn>
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
index f87bdacb5a69..af2e4b61bf23 100644
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
index dfd677c689ef..2ffad80c1c28 100644
--- a/net/ipv4/tcp.c
+++ b/net/ipv4/tcp.c
@@ -1469,9 +1469,8 @@ int tcp_sendmsg(struct sock *sk, struct msghdr *msg, size_t size)
 }
 EXPORT_SYMBOL(tcp_sendmsg);
 
-void tcp_splice_eof(struct socket *sock)
+void do_tcp_splice_eof(struct sock *sk)
 {
-	struct sock *sk = sock->sk;
 	struct tcp_sock *tp = tcp_sk(sk);
 	int mss_now, size_goal;
 
@@ -1483,6 +1482,11 @@ void tcp_splice_eof(struct socket *sock)
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
2.53.0

