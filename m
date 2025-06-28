Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 904184A08
	for <mptcp@lists.linux.dev>; Sat, 28 Jun 2025 06:58:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751093885; cv=none; b=quTjge8h9gT0b7LQqa6DWqWW1juGOK+oS3cXeJlesi9jD9u+VrYMxpx6vclCJK8y/CJVRDy9xwyLTUier33g/rn6ynCndJb4o6xBhBLQePpFHwdIhFNaQydBPeNCPW9hYddh/L0rEbYiD8Pgh9G4M+9a87yyUc0J6KUMVuYrbqk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751093885; c=relaxed/simple;
	bh=OXE1AbtxVH9Hj+m4RuvIjuM0TYnpxQbR7eBWUYi84C0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WhnwW3AB1zTFjQwBeGj1fS4gdmOTgxsTASEO2m2QcqbRvz7qYChxTBu/5RG1GdyLRfg/91GoDyzTF7FLQGGbuD4N0fQZ46tT5M5th4X3QGOK3EO3zgDhaEta/T9Wt1SvjStDSjtcB6ak7u4lUs6XZlhma7+40P9znoyObF5qcO4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=j7S5Jp2n; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="j7S5Jp2n"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EF8B2C4CEEE;
	Sat, 28 Jun 2025 06:58:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751093885;
	bh=OXE1AbtxVH9Hj+m4RuvIjuM0TYnpxQbR7eBWUYi84C0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=j7S5Jp2nlGfTJXd1Gyq8HZrkj0PxiKdUij36wfKc5m/s4NQJf90/v0rzK2CDaj4Y3
	 z1EmKTEPzlmqxL1ajDKEVfCdYR7S3PWs9bHFyUK5P0tC0ikhygDkypIyIgdSoqvfyC
	 SPCVDo4f1lFQvdI1Ag9SwzzaqOziROHGRYyGUXzrqDJftDTpnPml0Jm/TeFz4UASWg
	 a6C6uovwkDrZvS/RtPB5sBuWUs4Y2kdFgrMTIV7EBtnrqWsZCtWjcqcCCFFGOe3vye
	 x8XawX7I2Zqi96S9/tGneiRd8E0WcGWGDEsscluCKzg5ZWwKx9WWO+1fIkBc+McTGh
	 F/LxqHLJT+u8A==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev,
	hare@kernel.org
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next v5 4/5] mptcp: set .splice_read
Date: Sat, 28 Jun 2025 14:57:12 +0800
Message-ID: <2074c7e5977c170bf5d2cb990bc2523130a9cc8d.1751093346.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <cover.1751093346.git.tanggeliang@kylinos.cn>
References: <cover.1751093346.git.tanggeliang@kylinos.cn>
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

v2:
 - use INDIRECT_CALL_INET_1.

Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
---
 net/ipv4/tcp.c       | 4 +++-
 net/mptcp/protocol.c | 2 ++
 2 files changed, 5 insertions(+), 1 deletion(-)

diff --git a/net/ipv4/tcp.c b/net/ipv4/tcp.c
index c18682c3fa33..97175b75796b 100644
--- a/net/ipv4/tcp.c
+++ b/net/ipv4/tcp.c
@@ -774,13 +774,15 @@ static int tcp_splice_data_recv(read_descriptor_t *rd_desc, struct sk_buff *skb,
 
 static int __tcp_splice_read(struct sock *sk, struct tcp_splice_state *tss)
 {
+	const struct proto_ops *ops = READ_ONCE(sk->sk_socket->ops);
 	/* Store TCP splice context information in read_descriptor_t. */
 	read_descriptor_t rd_desc = {
 		.arg.data = tss,
 		.count	  = tss->len,
 	};
 
-	return tcp_read_sock(sk, &rd_desc, tcp_splice_data_recv);
+	return INDIRECT_CALL_INET_1(ops->read_sock, tcp_read_sock,
+				    sk, &rd_desc, tcp_splice_data_recv);
 }
 
 /**
diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index 1a1cfa1ff376..a8de9ee45aa5 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -4033,6 +4033,7 @@ static const struct proto_ops mptcp_stream_ops = {
 	.mmap		   = sock_no_mmap,
 	.set_rcvlowat	   = mptcp_set_rcvlowat,
 	.read_sock	   = mptcp_read_sock,
+	.splice_read	   = tcp_splice_read,
 };
 
 static struct inet_protosw mptcp_protosw = {
@@ -4138,6 +4139,7 @@ static const struct proto_ops mptcp_v6_stream_ops = {
 #endif
 	.set_rcvlowat	   = mptcp_set_rcvlowat,
 	.read_sock	   = mptcp_read_sock,
+	.splice_read	   = tcp_splice_read,
 };
 
 static struct proto mptcp_v6_prot;
-- 
2.48.1

