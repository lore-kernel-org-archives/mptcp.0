Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41276232395
	for <mptcp@lists.linux.dev>; Sun, 13 Sep 2026 10:15:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789294514; cv=none; b=CSTBhjPxLlmR2jt/FfZVrKIOJtIujT67vZYuoB4J9WSimDQrZ0N3uqd2se0sRYKL6fhv/rz0jnp298s2POExA3TSu+LUclkOfcCte6tYOVvZEz88o7siIRSio4/8tU3bRh8N8bZc19ehj+2HwppGR28POCNzBAA9Y+1J32J8z3E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789294514; c=relaxed/simple;
	bh=Dkb/v1LvMxv1WKvcJCIrtOMuaUNg2ImBYOoxOiFjPTc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=S/GDYla0vakXzU/aMNVFLY5PyJj4qwtAgOOQsPfyck8iiyMEhLSbMPdrmm5UaL0kO+c0lqhw15qxUh4SBLyIH06gEv5bd582UuBVwPIXIAQB/SY76lZbwcR4gxySOIp4eA0JFey3RmyIJjiNerpIJA01IZxOA/ojNFZzVE6U3CY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YPfjAHDZ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YPfjAHDZ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BDC171F00893;
	Sun, 13 Sep 2026 10:15:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789294512;
	bh=6mdnjTyTsgauAefpBWZeGGkDrXT8VXuHP77m76pO31Y=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=YPfjAHDZDOs6jb1lFbmgescR4nG8a1bjEQIXH68Dl9NiIC/Ah2gO4OhQOljnF1FXR
	 Hh46tSbirisgp6tOM9QI+RmTHKDUwC68zNs93dBPHWP1qgJKiP3+Rl3c85GlE+t1KH
	 qeyOM2IjIgm8qoJSUSWwKTfgeR/RQxDgC8jArAiry9ihGL1juqAzdp/aq9y8j0d+nm
	 4VB4FDI82uOGkAIWbhr/o/gSonnDVeR3VKUVRzjEv7o3YVb8f0MtVxrt6WD0VjWSQn
	 kasZkO6qZzPNtO6bKe670vcIi0+0AwqDM5zlEwFdKEa3LZ+zka8T/lT/PdE4pX5z8m
	 wiTE7tCJnEhpw==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next v5 02/16] mptcp: add sendmsg_locked to proto_ops
Date: Sun, 13 Sep 2026 18:14:41 +0800
Message-ID: <c9c42869f78e0372aceb6674724047e29e8ae32a.1789294365.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <cover.1789294365.git.tanggeliang@kylinos.cn>
References: <cover.1789294365.git.tanggeliang@kylinos.cn>
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
index be1b8e626653..29e2cd2be815 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -2030,7 +2030,7 @@ static void mptcp_rps_record_subflows(const struct mptcp_sock *msk)
 	}
 }
 
-static int mptcp_sendmsg(struct sock *sk, struct msghdr *msg, size_t len)
+static int mptcp_sendmsg_locked(struct sock *sk, struct msghdr *msg, size_t len)
 {
 	struct mptcp_sock *msk = mptcp_sk(sk);
 	struct page_frag *pfrag;
@@ -2042,8 +2042,6 @@ static int mptcp_sendmsg(struct sock *sk, struct msghdr *msg, size_t len)
 	msg->msg_flags &= MSG_MORE | MSG_DONTWAIT | MSG_NOSIGNAL |
 			  MSG_FASTOPEN | MSG_EOR;
 
-	lock_sock(sk);
-
 	mptcp_rps_record_subflows(msk);
 
 	if (unlikely(inet_test_bit(DEFER_CONNECT, sk) ||
@@ -2159,7 +2157,6 @@ static int mptcp_sendmsg(struct sock *sk, struct msghdr *msg, size_t len)
 	}
 
 out:
-	release_sock(sk);
 	return copied;
 
 do_error:
@@ -2170,6 +2167,17 @@ static int mptcp_sendmsg(struct sock *sk, struct msghdr *msg, size_t len)
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
@@ -4795,6 +4803,7 @@ static const struct proto_ops mptcp_stream_ops = {
 	.set_rcvlowat	   = mptcp_set_rcvlowat,
 	.read_sock	   = mptcp_read_sock,
 	.splice_read	   = mptcp_splice_read,
+	.sendmsg_locked	   = mptcp_sendmsg_locked,
 };
 
 static struct inet_protosw mptcp_protosw = {
@@ -4907,6 +4916,7 @@ static const struct proto_ops mptcp_v6_stream_ops = {
 	.set_rcvlowat	   = mptcp_set_rcvlowat,
 	.read_sock	   = mptcp_read_sock,
 	.splice_read	   = mptcp_splice_read,
+	.sendmsg_locked	   = mptcp_sendmsg_locked,
 };
 
 static struct proto mptcp_v6_prot;
-- 
2.53.0

