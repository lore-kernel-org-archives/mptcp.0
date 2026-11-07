Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794053876;
	b=GKGGdClk6F9qN/qSrvTiPOrazbiH7pFJDCvsvGEusPuWjNvCK0rPnbkUsAmz3IW3HQVM
	 O8Fd1H5zsPBcAZfrqNMxA5gIKue3+7verWCMLO74DP6UwbzaSZ2PKEcQ5bjqWwoTp/upJ
	 MnjANVIPrZdUymtKI39iQnRphTUAKybKJKqjehJdPlo9ppLos76/j5rqm99FVrq+1RYKo
	 /w+SPYYbFfhWVkvQ2d/Olb1ShzwahzL+ImidAzXhT+kgky8l0ZZhiLzLVRhSOFEnegGiS
	 nNBwqTKe2BcVSBU2AJ45xkWPrOZfJBYI/7Miv/nUWy/eHpQteIeQAU3fsIalwbsinNA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794053876;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=PyAIwiSCYTJG+j001SJJStMSKxiyffojwmho016/ZmU=;
	b=rk2ECTO+GhfDStAURvUMNzFezhG7EH7SRt6iVXyr9PRwzam9eC0HnfvzuuKbiYg2d+Jc
	 2Pur5SQp2vxBpS7oF4DU3QgjEXaW19edvGXJFqGtW2NlzEYz9432AqrD2VKzc08cJxPQx
	 1VfI8TsxcAg3WLhJIIbJeqRa2lz1qUPLHmwjU2v6So/RJehse/MY9a6St9WCjRoLOfwJ0
	 jYgSjc/gx8C8tReKF2tMbIvqb7MFhmCX5IWowu8337zVm0np+MOC1DmDqeXa3/mk3QOu1
	 O2jO+dlcgcKC23o/HIgEOBrcufR9qn/mK7wCsp+kfF0aOU+MwbXLzZjPrSewhmSt7Iw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=VK5mejtL;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E91F5606A326
	for <mptcp@lists.linux.dev>; Sat,  7 Nov 2026 12:17:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=VK5mejtL
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B6EDE1F008A2;
	Sat,  7 Nov 2026 12:17:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794053875;
	bh=PyAIwiSCYTJG+j001SJJStMSKxiyffojwmho016/ZmU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=VK5mejtL33z6AikcdG0/oHuuNknZ7W/xHsWGkYSKJMPHPuJhP13VRchcZnICXrMmS
	 EGUnXsA/hj1bSgH2Iq+PRuvhg3llhJekCIKYAWFtS/dl9GiGtgs445VAZaX7wLMMY2
	 zyIrZjUzGK7qX5Bz06pSbKmTDxZYUpdbAyR3Glle5ySVTbFLHmOJdzF5v+/8BROZAA
	 +2Pus+R9owjzFdT6L2mcd39iCtv96UrmmyxNQXYKM4i2wQDiE8vHLhqj+T3+axt/mf
	 FXDVRil9NZRF6GVc9wWhAMjk/lZxlzedH5kIvUR13tka1XWRKmCRINt3/IcrkHji80
	 uk+78d2V71ugQ==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next v7 4/7] mptcp: add sendmsg_locked to proto_ops
Date: Sat,  7 Nov 2026 20:17:17 +0800
Message-ID: <cec6cd455afe93513be5c82d51974efc6aed867f.1794053683.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <cover.1794053683.git.tanggeliang@kylinos.cn>
References: <cover.1794053683.git.tanggeliang@kylinos.cn>
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Post: <mailto:mptcp@lists.linux.dev>
List-Help: <mailto:mptcp+help@lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
List-Owner: <mailto:mptcp+owner@lists.linux.dev>
Precedence: list
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
Add msk_owned_by_me() assertion to enforce the locking requirement.
Expose .sendmsg_locked in both mptcp_stream_ops and mptcp_v6_stream_ops.

Unlike tcp_sendmsg_locked(), mptcp_sendmsg_locked() drops the
MSG_SPLICE_PAGES flag from the mask. Future kTLS and sockmap support
will require additional changes to call through proto_ops->sendmsg_locked
instead of tcp_sendmsg_locked() directly.

Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
---
 net/mptcp/protocol.c | 20 ++++++++++++++++----
 1 file changed, 16 insertions(+), 4 deletions(-)

diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index 585730c30da1..8ea06167b05d 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -2038,7 +2038,7 @@ static void mptcp_rps_record_subflows(const struct mptcp_sock *msk)
 	}
 }
 
-static int mptcp_sendmsg(struct sock *sk, struct msghdr *msg, size_t len)
+static int mptcp_sendmsg_locked(struct sock *sk, struct msghdr *msg, size_t len)
 {
 	struct mptcp_sock *msk = mptcp_sk(sk);
 	struct page_frag *pfrag;
@@ -2046,12 +2046,12 @@ static int mptcp_sendmsg(struct sock *sk, struct msghdr *msg, size_t len)
 	int ret = 0;
 	long timeo;
 
+	msk_owned_by_me(msk);
+
 	/* silently ignore everything else */
 	msg->msg_flags &= MSG_MORE | MSG_DONTWAIT | MSG_NOSIGNAL |
 			  MSG_FASTOPEN | MSG_EOR;
 
-	lock_sock(sk);
-
 	mptcp_rps_record_subflows(msk);
 
 	if (unlikely(inet_test_bit(DEFER_CONNECT, sk) ||
@@ -2167,7 +2167,6 @@ static int mptcp_sendmsg(struct sock *sk, struct msghdr *msg, size_t len)
 	}
 
 out:
-	release_sock(sk);
 	return copied;
 
 do_error:
@@ -2180,6 +2179,17 @@ static int mptcp_sendmsg(struct sock *sk, struct msghdr *msg, size_t len)
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
@@ -4833,6 +4843,7 @@ static const struct proto_ops mptcp_stream_ops = {
 	.read_sock	   = mptcp_read_sock,
 	.splice_read	   = mptcp_splice_read,
 	.peek_len	   = mptcp_peek_len,
+	.sendmsg_locked	   = mptcp_sendmsg_locked,
 };
 
 static struct inet_protosw mptcp_protosw = {
@@ -4946,6 +4957,7 @@ static const struct proto_ops mptcp_v6_stream_ops = {
 	.read_sock	   = mptcp_read_sock,
 	.splice_read	   = mptcp_splice_read,
 	.peek_len	   = mptcp_peek_len,
+	.sendmsg_locked	   = mptcp_sendmsg_locked,
 };
 
 static struct proto mptcp_v6_prot;
-- 
2.55.0

