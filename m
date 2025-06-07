Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6643D1F1315
	for <mptcp@lists.linux.dev>; Sat,  7 Jun 2025 08:55:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749286512; cv=none; b=q4ucvFKbHhOs2lIUc/PIq6HWUQkY3G5Ol6Pb7qWy5PbzK9N7cEJ38j3RJauLd8MIyW5ouvjI0pI0U0G2MYPf4eBdCS3xEfNeKyfHCsD+wL5snPiV2xeMiiO633xZFHbhEHHIWi6NmfZHsliYJVYRNMO0o4fmcuR/CtUwJ23AKS4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749286512; c=relaxed/simple;
	bh=Goj/UNQF3rHpV/V+ozNJvLsBVhQLUnwuzBq9mk1aa2g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=s60k6iG0OB94NMAhCsO5x7IHAFyGchX2tJHZHFIFEJXXGhfr8hgvlLwp8a351Eb/ftoCMX99d4s1xUI/ltVlBhZKohU5NiftA3s7Z0psGieZUaPsKPpqUx3m83PnZmnMO009IlviPSkpw8cnhGeL0oET7Y2gEsGAPHznRmimS9s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WHYD5f7R; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WHYD5f7R"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8DB68C4CEED;
	Sat,  7 Jun 2025 08:55:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749286512;
	bh=Goj/UNQF3rHpV/V+ozNJvLsBVhQLUnwuzBq9mk1aa2g=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=WHYD5f7RqzD5fCLgLIjDVXihg5MHWuk400h4r8RDjjQ+ekohvNIm5mP107eD954Lz
	 b4SUoAwuEKSY7BdyKFzynyupit30Cm2WrXK3L4+f0U/Dgnb0e7hGK5EmdJzrHkVxkA
	 rUi+bJ5L9fzPUuefJOOReJRJ+pp0JGt4u+JpBCCvQb2KDWjG8hZK3uERnhS5Qd5cku
	 ZH57v3qiX4XFdL+Znv51x1eOfkKhYQ7k6qaAAZTMpSooD1ejlQvEBshpawGBAcrlaY
	 rWbM8SGnB3imxtNweQtRacafa07hMdyF593gN+a1oeQV5wQw5VHF/7+/BF20BQ61ZO
	 Ni01vHg2fadTw==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev,
	hare@kernel.org
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next v2 3/4] mptcp: set .splice_read
Date: Sat,  7 Jun 2025 08:54:18 +0000
Message-ID: <e0bcc114f5fee3568d7547e61936325c1bec2ac9.1749286212.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1749286212.git.tanggeliang@kylinos.cn>
References: <cover.1749286212.git.tanggeliang@kylinos.cn>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Geliang Tang <tanggeliang@kylinos.cn>

This patch sets .splice_read interface of mptcp struct proto_ops as
tcp_splice_read. And invoke .read_sock in __tcp_splice_read().

Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
---
 net/ipv4/tcp.c       | 6 ++++++
 net/mptcp/protocol.c | 2 ++
 2 files changed, 8 insertions(+)

diff --git a/net/ipv4/tcp.c b/net/ipv4/tcp.c
index f2916aef1cf9..f9a9f8726be5 100644
--- a/net/ipv4/tcp.c
+++ b/net/ipv4/tcp.c
@@ -779,6 +779,12 @@ static int __tcp_splice_read(struct sock *sk, struct tcp_splice_state *tss)
 		.arg.data = tss,
 		.count	  = tss->len,
 	};
+	const struct proto_ops *ops;
+
+	ops = READ_ONCE(sk->sk_socket->ops);
+
+	if (likely(ops->read_sock))
+		return ops->read_sock(sk, &rd_desc, tcp_splice_data_recv);
 
 	return tcp_read_sock(sk, &rd_desc, tcp_splice_data_recv);
 }
diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index da4242e48246..32d389329262 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -4036,6 +4036,7 @@ static const struct proto_ops mptcp_stream_ops = {
 	.mmap		   = sock_no_mmap,
 	.set_rcvlowat	   = mptcp_set_rcvlowat,
 	.read_sock	   = mptcp_read_sock,
+	.splice_read	   = tcp_splice_read,
 };
 
 static struct inet_protosw mptcp_protosw = {
@@ -4141,6 +4142,7 @@ static const struct proto_ops mptcp_v6_stream_ops = {
 #endif
 	.set_rcvlowat	   = mptcp_set_rcvlowat,
 	.read_sock	   = mptcp_read_sock,
+	.splice_read	   = tcp_splice_read,
 };
 
 static struct proto mptcp_v6_prot;
-- 
2.43.0

