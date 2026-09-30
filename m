Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83793343D7F
	for <mptcp@lists.linux.dev>; Wed, 30 Sep 2026 02:28:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790735319; cv=none; b=GXymnME7tXpVw45Gq5S2mxG5vQIf/yeyvMxNRWpmY1lQFUmfEmvm83NmpyAqC30xkHLrSd2PMKydP0KWegYcQeTLqpH21Q/ZJ1k8QMhn1EOxpHOSi/dN9kYkqd66y1fO3bYKaGMQpQO5J1iHRZrpqGielyJro4fL/m6SuyQGVK0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790735319; c=relaxed/simple;
	bh=dJZrfDdLb3oB8i8462pwur9aJJtTE1FN/cqQQndIbJo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=k5FjTfyN23+mwB7CVh+JyGU9vVgcUJ+zZSfhYMre0ePnL2X+NQn6Vm1FkWaBmxiaD84CDfZ4zEyNSnaHUjE51ioUfhMzg0FpNPU42/lzwbpJ2cBRZEiiXN+OcgZRH4L98LMQCZr+y+wb+EHD5tshA9MMyoe0myrXr2Fn3a4p43I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=L1KE8QkT; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="L1KE8QkT"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E9CC21F000FF;
	Wed, 30 Sep 2026 02:28:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790735318;
	bh=XyYHALBCJLBoigAJCfiubsqfrmLE1AI6hptc5h3Tq9U=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=L1KE8QkT5yw0XhrD70TJK4RbXzKJYqri62F1RybofZu3CloiqPlA3oHpeFfuBDdym
	 TFylEhikfQ4KPi5vU+pbbW+cHTivGF/UwR55NpsiV3UGrbJqitxWjKW7aKq8A5zkGY
	 Ek8m/L6rKql6gCC3YXXFzL5B/LyU1YKP8ELtGtXudPdidMRNoE+4GovUJElejgQRbs
	 ZDZ9mPs5cKct+WmeFYyWYfdL2zQCJo1rw0M1Ovv50KSI5BmDb3C0g9j4pMu8Bc4Vsx
	 5W55tcMUCMocUfWYJWQFfavE0qHt82PtNP22W1FX0uyhvsNllvKeRS/drAC+GUY+zM
	 8s+e852tq8FaQ==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev,
	pabeni@redhat.com
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next v14 08/11] mptcp: add sendmsg_locked to proto_ops
Date: Wed, 30 Sep 2026 10:23:42 +0800
Message-ID: <36a2670793444666d78b4e197a28e2308f21b273.1790734083.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <cover.1790734083.git.tanggeliang@kylinos.cn>
References: <cover.1790734083.git.tanggeliang@kylinos.cn>
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
index 84478bace0ab..319339be8076 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -2055,7 +2055,7 @@ static void mptcp_rps_record_subflows(const struct mptcp_sock *msk)
 	}
 }
 
-static int mptcp_sendmsg(struct sock *sk, struct msghdr *msg, size_t len)
+static int mptcp_sendmsg_locked(struct sock *sk, struct msghdr *msg, size_t len)
 {
 	struct mptcp_sock *msk = mptcp_sk(sk);
 	struct page_frag *pfrag;
@@ -2067,8 +2067,6 @@ static int mptcp_sendmsg(struct sock *sk, struct msghdr *msg, size_t len)
 	msg->msg_flags &= MSG_MORE | MSG_DONTWAIT | MSG_NOSIGNAL |
 			  MSG_FASTOPEN | MSG_EOR;
 
-	lock_sock(sk);
-
 	mptcp_rps_record_subflows(msk);
 
 	if (unlikely(inet_test_bit(DEFER_CONNECT, sk) ||
@@ -2184,7 +2182,6 @@ static int mptcp_sendmsg(struct sock *sk, struct msghdr *msg, size_t len)
 	}
 
 out:
-	release_sock(sk);
 	return copied;
 
 do_error:
@@ -2195,6 +2192,17 @@ static int mptcp_sendmsg(struct sock *sk, struct msghdr *msg, size_t len)
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
@@ -4877,6 +4885,7 @@ static const struct proto_ops mptcp_stream_ops = {
 	.read_sock	   = mptcp_read_sock,
 	.splice_read	   = mptcp_splice_read,
 	.peek_len	   = mptcp_peek_len,
+	.sendmsg_locked	   = mptcp_sendmsg_locked,
 };
 
 static struct inet_protosw mptcp_protosw = {
@@ -5002,6 +5011,7 @@ static const struct proto_ops mptcp_v6_stream_ops = {
 	.read_sock	   = mptcp_read_sock,
 	.splice_read	   = mptcp_splice_read,
 	.peek_len	   = mptcp_peek_len,
+	.sendmsg_locked	   = mptcp_sendmsg_locked,
 };
 
 static struct proto mptcp_v6_prot;
-- 
2.53.0

