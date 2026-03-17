Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6243371CFE
	for <mptcp@lists.linux.dev>; Tue, 17 Mar 2026 09:41:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773740513; cv=none; b=Lard/IkoOZ1S8X+NxkbsQlj5rsSMX5Vjf5cgE8WOHmURc6MJumKaAPTMIhyItK0vegww6oK2BOHoSSl4ZkcYbczRyRw1+poTJboCmVHmGJ+9TGvfiitS3Dh7lQy81yKq6Rey4EUXIwjsuH/nhzh8FQQhibnd6iyfiqQ6/3O4pCI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773740513; c=relaxed/simple;
	bh=jTnH2QoepueJ2x5uSuq0yrNfahpgJYxJ7NDC2NmqbOI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XQL9kFdCoh52HNnaPHnSGdtQ1JYm44AJ6OQ76oY2fP5mtuUWSWZDFOeAb01mTEnV8yc0guzw8ijvJ73G1GKzwg54mXRgzMcgC/HOJWanlnRtb8uz6d7cdGMceF+KMvn2KRawBtxJkpMgA8DZs8CvwLXZO04E1KETeGlgnj2HLR8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Li4rqMAT; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Li4rqMAT"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7DEA5C19425;
	Tue, 17 Mar 2026 09:41:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773740513;
	bh=jTnH2QoepueJ2x5uSuq0yrNfahpgJYxJ7NDC2NmqbOI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Li4rqMATJmwYC+BqMQWV5SsEDxR0H+VDgDh870RWY1OOMD4EnxRurK0xwQXyQMjiK
	 Q4ugMLMQTs0d4IJRtXkKEIVQUFsP0gXzPTmiYXls4X5HpwU3/pmASw1BbP9CPXJDnP
	 nrwTKwDos93oH494G2yv/twkr3u7VLja7flsrrIQ0cchhpQGaxVbpF8IkVfijj2J9Q
	 14lm/eMYon8CWbUxTml8X6uq6/IvYOvET+jQx0rXT+1Wpd/hpiGOQ7UF62l7Ux8U+O
	 EfXq94rzMeausCgM+fSgyFSRgAXXmYIbrhbFk9lSXR7CtPhbD9bCaqMKuO1eUT3pUp
	 h5DVl4a3sOkSg==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>,
	Matthieu Baerts <matttbe@kernel.org>
Subject: [RESEND PATCH mptcp-next v2 2/3] mptcp: implement .splice_eof
Date: Tue, 17 Mar 2026 17:41:27 +0800
Message-ID: <e4666472729bc32c8a4d5ec2692bdecec4dbb4b6.1773740361.git.tanggeliang@kylinos.cn>
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

This patch implements the .splice_eof interface for MPTCP, namely
mptcp_splice_eof(), which calls do_tcp_splice_eof() for each active
subflow when a sendfile() operation reaches end-of-file.

do_tcp_splice_eof() flushes any remaining data in the TCP send queue.
MPTCP operates over multiple TCP subflows, and each subflow may have
pending data in its send buffer that needs to be properly finalized
when splicing data through an MPTCP socket.

sock_splice_eof() calls the .splice_eof interface from struct proto_ops.
To maintain consistency with regular TCP behavior, the .splice_eof
interface of mptcp_stream_ops is set to inet_splice_eof, which will
switch to the protocol-specific implementation (sk->sk_prot->splice_eof)
- for MPTCP, that is mptcp_splice_eof().

This is an improvement; nothing was broken before. MPTCP previously did not
handle the splice EOF notification, while TCP did. Without .splice_eof()
support, the queue is not flushed immediately when sendfile() reaches EOF,
but it will eventually be flushed after a small delay.

Suggested-by: Matthieu Baerts <matttbe@kernel.org>
Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
---
 net/mptcp/protocol.c | 23 +++++++++++++++++++++++
 1 file changed, 23 insertions(+)

diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index b5676b37f8f4..ee6d5b4edd1e 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -4020,6 +4020,27 @@ static int mptcp_connect(struct sock *sk, struct sockaddr_unsized *uaddr,
 	return 0;
 }
 
+static void mptcp_splice_eof(struct socket *sock)
+{
+	struct mptcp_subflow_context *subflow;
+	struct sock *sk = sock->sk, *ssk;
+	struct mptcp_sock *msk;
+
+	msk = mptcp_sk(sk);
+
+	lock_sock(sk);
+	mptcp_rps_record_subflows(msk);
+	mptcp_for_each_subflow(msk, subflow) {
+		ssk = mptcp_subflow_tcp_sock(subflow);
+
+		if (ssk->sk_state == TCP_CLOSE)
+			continue;
+
+		do_tcp_splice_eof(ssk);
+	}
+	release_sock(sk);
+}
+
 static struct proto mptcp_prot = {
 	.name		= "MPTCP",
 	.owner		= THIS_MODULE,
@@ -4051,6 +4072,7 @@ static struct proto mptcp_prot = {
 	.obj_size	= sizeof(struct mptcp_sock),
 	.slab_flags	= SLAB_TYPESAFE_BY_RCU,
 	.no_autobind	= true,
+	.splice_eof	= mptcp_splice_eof,
 };
 
 static int mptcp_bind(struct socket *sock, struct sockaddr_unsized *uaddr, int addr_len)
@@ -4542,6 +4564,7 @@ static const struct proto_ops mptcp_stream_ops = {
 	.set_rcvlowat	   = mptcp_set_rcvlowat,
 	.read_sock	   = mptcp_read_sock,
 	.splice_read	   = mptcp_splice_read,
+	.splice_eof	   = inet_splice_eof,
 };
 
 static struct inet_protosw mptcp_protosw = {
-- 
2.53.0

