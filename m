Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE9751684B0
	for <mptcp@lists.linux.dev>; Fri, 28 Aug 2026 03:50:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787889005; cv=none; b=iWo7QIHgFs0c+4yOZ0dRfPB3G68wd4tUaS9+rDsiuYR2JbQVGP9FxUmqaNCEjcSAYWs/Y3SQtLrtImDAIPDX4KT31PcQ2AA87sDMAgxdtgy/7XKIKNHTY0/MTlkYSZ4MmtNdRf/2efJdg713/fukZUu8T+JjMkDaHHuFctaWx2Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787889005; c=relaxed/simple;
	bh=XV3NRNgxDUKvOh+JPK9Ru0w+4PS+cCR/nPEQnWlCq44=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ksziq7ZaMjhoBafh9nubV+QNaN0fGaBQTJ9y7KZDRDyuBclT004Z3omaLWzCQCkhu/VeYf/fPMesiTXYA4panIu7U/WijS26qi1Jz/tRUBxjuHZUkUeMxkDui+Hwl/iDkkkHiKWiOsqfymS4r0EQmlI7JTp/0CQ02k+enHwFQnI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KS60eIee; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KS60eIee"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 77A8A1F00A3A;
	Fri, 28 Aug 2026 03:50:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787889004;
	bh=D/MlYChVtIFbsKJYwRAxuXWWNybUK4TwW00jCHIRzAU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=KS60eIeeo4d9NS05PTjkAazMYCqWpgeuUpVI7HH/XPXzNpetoft9CozyApbLoxaaB
	 7p2iSm93VPLNbGcTHT8w49zEL+c12Hd0PwDcmbZ6hUA/luRIhtL51i64Yku6PdXKOW
	 trUcuJjesrOwwcRyfG5pS1mtiZePADGvDV5FvahNbKIueE5pK6q/zCcYs5MFQaJVC6
	 EhHqVBSFjbbhjG1dem0zSv1wQDxw9oz2NPkhtwoz1oUe79Yz8tQMjyNBDy2Jwj8PRs
	 lyUeHONN0/UfK+JIEwZoZCrdSVvMZOYR41sp78GWvEpx3QJVxbCvKRN+qAcq4CU3KU
	 PYDjm/EDTRREg==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next v10 7/9] mptcp: add sendmsg_locked to proto_ops
Date: Fri, 28 Aug 2026 11:49:42 +0800
Message-ID: <818d871690900ca5558a86bcff23adae5de280b3.1787888115.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <cover.1787888115.git.tanggeliang@kylinos.cn>
References: <cover.1787888115.git.tanggeliang@kylinos.cn>
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
index 639122b7845a..141d905e4921 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -2048,7 +2048,7 @@ static void mptcp_rps_record_subflows(const struct mptcp_sock *msk)
 	}
 }
 
-static int mptcp_sendmsg(struct sock *sk, struct msghdr *msg, size_t len)
+static int mptcp_sendmsg_locked(struct sock *sk, struct msghdr *msg, size_t len)
 {
 	struct mptcp_sock *msk = mptcp_sk(sk);
 	struct page_frag *pfrag;
@@ -2060,8 +2060,6 @@ static int mptcp_sendmsg(struct sock *sk, struct msghdr *msg, size_t len)
 	msg->msg_flags &= MSG_MORE | MSG_DONTWAIT | MSG_NOSIGNAL |
 			  MSG_FASTOPEN | MSG_EOR;
 
-	lock_sock(sk);
-
 	mptcp_rps_record_subflows(msk);
 
 	if (unlikely(inet_test_bit(DEFER_CONNECT, sk) ||
@@ -2177,7 +2175,6 @@ static int mptcp_sendmsg(struct sock *sk, struct msghdr *msg, size_t len)
 	}
 
 out:
-	release_sock(sk);
 	return copied;
 
 do_error:
@@ -2188,6 +2185,17 @@ static int mptcp_sendmsg(struct sock *sk, struct msghdr *msg, size_t len)
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
@@ -4853,6 +4861,7 @@ static const struct proto_ops mptcp_stream_ops = {
 	.read_sock	   = mptcp_read_sock,
 	.splice_read	   = mptcp_splice_read,
 	.peek_len	   = mptcp_peek_len,
+	.sendmsg_locked	   = mptcp_sendmsg_locked,
 };
 
 static struct inet_protosw mptcp_protosw = {
@@ -4978,6 +4987,7 @@ static const struct proto_ops mptcp_v6_stream_ops = {
 	.read_sock	   = mptcp_read_sock,
 	.splice_read	   = mptcp_splice_read,
 	.peek_len	   = mptcp_peek_len,
+	.sendmsg_locked	   = mptcp_sendmsg_locked,
 };
 
 static struct proto mptcp_v6_prot;
-- 
2.53.0

