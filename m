Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 709653D810C
	for <mptcp@lists.linux.dev>; Mon, 31 Aug 2026 10:28:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788172097; cv=none; b=KFNUHbsn2KmFQgkCGehj0P5I+57GbmHuentEdzkeiSIooEqGqiJnJFIh4E/0rY/UGIegYijP+Ye74bDUqYUvli6l81UvQWXXDuH8MOFYP9u1fh5kTPKO8z4EnA6ByN2KBcK/PYoIDKceT1M/+MOuX0Sa0oGFj4SDIq29NTkYj6E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788172097; c=relaxed/simple;
	bh=3KsSD8H04DszMv6GeLFyER8theRT1QuiY5GDKbMRQUU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JC9eXkRdmHAgI+2CjFcQa9nWnrkAUGRd4vDwLg+6kzKAQlJfhyfp7T2HNeFlHbWIRrrT8AytHZ1E2aWCEJJoFYZekHzMtpjURlYqYMfJtpOUSGzxF0D8a42MB5YnQgXrHE6PsnNOt4R8yiIkBc8bdo92FqYrkGfndC9st2q6H4w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hzSk0mGr; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hzSk0mGr"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7EA841F000E9;
	Mon, 31 Aug 2026 10:28:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788172096;
	bh=VkwJVo+QBu2Un4UEzrr8OXKxhFzZJGKNhtQHCFiwfH4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=hzSk0mGrLPkWdm8gIzYIuD5XQJL66jjv0xwCF6fkqfPlbJVHylL3WpYQPZjC4wJPB
	 zYTsnURCj0HHz8r0jfzOX30EQZc7qjh52C9gBquuwo1/mTPCgIvlywH0v9qSF3ayla
	 bVBTpAwDvZ/Hwj1ucm2urt4CpEMFHKPAoO2Cpjn2cEXm55kKxeGNNQRefhqlJ/485c
	 GVdHnp8zxXGpM5XutJlzXDwkzsI6Z8RlhsUMko0EQBqN2t6LI5oKcjlyKWS3p3fhMI
	 JPyQLBKzRbNR1P0jAyf3Uw3x8AlVx7y23uQZgUwvBwTHtkonYthJlZCTIB1JD2rTaF
	 gDOuN1QdWw2AQ==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next v12 08/10] mptcp: add sendmsg_locked to proto_ops
Date: Mon, 31 Aug 2026 18:27:16 +0800
Message-ID: <7a08cd68e6ba9a7f81044d8e7dce0a05c59e2d65.1788171508.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <cover.1788171508.git.tanggeliang@kylinos.cn>
References: <cover.1788171508.git.tanggeliang@kylinos.cn>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Geliang Tang <tanggeliang@kylinos.cn>

MPTCP currently provides a standard sendmsg() implementation which
acquires and releases the socket lock internally. However, certain
upper layers need to call the sendmsg method while the socket lock
is already held.

Split the existing mptcp_sendmsg() into mptcp_sendmsg_locked() which
assumes the caller holds the socket lock, and a tiny wrapper
mptcp_sendmsg() that acquires the lock and calls the locked version.

Expose .sendmsg_locked in both mptcp_stream_ops and mptcp_v6_stream_ops.

Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
---
 net/mptcp/protocol.c | 18 ++++++++++++++----
 1 file changed, 14 insertions(+), 4 deletions(-)

diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index d34c32fc1adf..9c3f1225e333 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -2049,7 +2049,7 @@ static void mptcp_rps_record_subflows(const struct mptcp_sock *msk)
 	}
 }
 
-static int mptcp_sendmsg(struct sock *sk, struct msghdr *msg, size_t len)
+static int mptcp_sendmsg_locked(struct sock *sk, struct msghdr *msg, size_t len)
 {
 	struct mptcp_sock *msk = mptcp_sk(sk);
 	struct page_frag *pfrag;
@@ -2061,8 +2061,6 @@ static int mptcp_sendmsg(struct sock *sk, struct msghdr *msg, size_t len)
 	msg->msg_flags &= MSG_MORE | MSG_DONTWAIT | MSG_NOSIGNAL |
 			  MSG_FASTOPEN | MSG_EOR;
 
-	lock_sock(sk);
-
 	mptcp_rps_record_subflows(msk);
 
 	if (unlikely(inet_test_bit(DEFER_CONNECT, sk) ||
@@ -2178,7 +2176,6 @@ static int mptcp_sendmsg(struct sock *sk, struct msghdr *msg, size_t len)
 	}
 
 out:
-	release_sock(sk);
 	return copied;
 
 do_error:
@@ -2189,6 +2186,17 @@ static int mptcp_sendmsg(struct sock *sk, struct msghdr *msg, size_t len)
 	goto out;
 }
 
+static int mptcp_sendmsg(struct sock *sk, struct msghdr *msg, size_t len)
+{
+	int ret;
+
+	lock_sock(sk);
+	ret = mptcp_sendmsg_locked(sk, msg, len);
+	release_sock(sk);
+
+	return ret;
+}
+
 static void mptcp_rcv_space_adjust(struct mptcp_sock *msk, int copied);
 
 static void mptcp_eat_recv_skb(struct sock *sk, struct sk_buff *skb)
@@ -4871,6 +4879,7 @@ static const struct proto_ops mptcp_stream_ops = {
 	.read_sock	   = mptcp_read_sock,
 	.splice_read	   = mptcp_splice_read,
 	.peek_len	   = mptcp_peek_len,
+	.sendmsg_locked	   = mptcp_sendmsg_locked,
 };
 
 static struct inet_protosw mptcp_protosw = {
@@ -4996,6 +5005,7 @@ static const struct proto_ops mptcp_v6_stream_ops = {
 	.read_sock	   = mptcp_read_sock,
 	.splice_read	   = mptcp_splice_read,
 	.peek_len	   = mptcp_peek_len,
+	.sendmsg_locked	   = mptcp_sendmsg_locked,
 };
 
 static struct proto mptcp_v6_prot;
-- 
2.53.0

