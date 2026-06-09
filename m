Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 954B02F8E98
	for <mptcp@lists.linux.dev>; Tue,  9 Jun 2026 02:19:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780971559; cv=none; b=IRyvilRazwnplbRsMZofuS+oCF1fyK7WuQqbBDn49L73l3Uq97G690cs5viCjdAp+D9D5ts1orhaPxj/swLvmRjKdh2aC1uuuRR538VTngs9vWRNQoTy1IzdxfbyX2S5sMruujOK2sV9WVePGUqQ7kRWMGLf0yNy1AoV3FzpHMM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780971559; c=relaxed/simple;
	bh=guQnhnLaYe5q+Cyyel5GQphphPBrwj42TA4e/kkaE0Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fvjCHMKuoQKttWyuePJuPcDAgOGyA0GUF7nI8laigxct9A6aC/Nv90nyINi74V+Lzc7ycH0Ixp4o5lIo0FUG90ENvmCSr1m90C/Qrw/fXBmu9wOmGYmul76Q/p/IFZSIlqEAWpL+h3HQ11jqtU3X/SqJsFixu/cT2q++kElgTPo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dQRvo2uZ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dQRvo2uZ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 52F0C1F00898;
	Tue,  9 Jun 2026 02:19:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780971558;
	bh=dvwBBzQGkwhG03Uvq2YTmN8ktK6fIV80vm3uPhbs+D0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=dQRvo2uZKLhlUo++PWsp2kwTpqNaMN0QX2jK0tBmPCRcFNqbr4pNVy05PbgfanyQ/
	 QRkhWVfNoDJTd3G2n1DyYlo06m3Ns8/VjWHZH6LVnvyz2KRHPTrUEVOHX90n4mf5Q8
	 ahfxkBZIqEjXJDvFQyyhXUsoTP0EWsyJDy4KZ0rLIle+RZA7pbdcvqLWdmZVi1E+ug
	 lGuTQ5hwcmGzhgiLPP3PZrWVOp/wnfXmdSdCPR3q8B2/xRGtdAZS8/MstfCl/bs0YP
	 lsxlK8XkvEMdUrjbO+w7Wj9bGOed3nMViLmvS+CxXjOklEnQAbcX7rpcf5mbSLZA9K
	 losWw1E9Kg0Pw==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [RFC mptcp-next v25 01/22] mptcp: add sendmsg_locked to proto_ops
Date: Tue,  9 Jun 2026 10:18:27 +0800
Message-ID: <ed204110f6d5bfcd8ae4d8d55739fa59a5f56a83.1780970284.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1780970284.git.tanggeliang@kylinos.cn>
References: <cover.1780970284.git.tanggeliang@kylinos.cn>
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
upper layers (e.g., TLS) need to call the sendmsg method while the
socket lock is already held.

Split the existing mptcp_sendmsg() into mptcp_sendmsg_locked() which
assumes the caller holds the socket lock, and a tiny wrapper
mptcp_sendmsg() that acquires the lock and calls the locked version.

Expose .sendmsg_locked in both mptcp_stream_ops and mptcp_v6_stream_ops.

Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
---
 net/mptcp/protocol.c | 18 ++++++++++++++----
 1 file changed, 14 insertions(+), 4 deletions(-)

diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index a4f7e99b30db..7f0c560f6b7e 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -1967,7 +1967,7 @@ static void mptcp_rps_record_subflows(const struct mptcp_sock *msk)
 	}
 }
 
-static int mptcp_sendmsg(struct sock *sk, struct msghdr *msg, size_t len)
+static int mptcp_sendmsg_locked(struct sock *sk, struct msghdr *msg, size_t len)
 {
 	struct mptcp_sock *msk = mptcp_sk(sk);
 	struct page_frag *pfrag;
@@ -1979,8 +1979,6 @@ static int mptcp_sendmsg(struct sock *sk, struct msghdr *msg, size_t len)
 	msg->msg_flags &= MSG_MORE | MSG_DONTWAIT | MSG_NOSIGNAL |
 			  MSG_FASTOPEN | MSG_EOR;
 
-	lock_sock(sk);
-
 	mptcp_rps_record_subflows(msk);
 
 	if (unlikely(inet_test_bit(DEFER_CONNECT, sk) ||
@@ -2096,7 +2094,6 @@ static int mptcp_sendmsg(struct sock *sk, struct msghdr *msg, size_t len)
 	}
 
 out:
-	release_sock(sk);
 	return copied;
 
 do_error:
@@ -2107,6 +2104,17 @@ static int mptcp_sendmsg(struct sock *sk, struct msghdr *msg, size_t len)
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
@@ -4703,6 +4711,7 @@ static const struct proto_ops mptcp_stream_ops = {
 	.set_rcvlowat	   = mptcp_set_rcvlowat,
 	.read_sock	   = mptcp_read_sock,
 	.splice_read	   = mptcp_splice_read,
+	.sendmsg_locked	   = mptcp_sendmsg_locked,
 };
 
 static struct inet_protosw mptcp_protosw = {
@@ -4815,6 +4824,7 @@ static const struct proto_ops mptcp_v6_stream_ops = {
 	.set_rcvlowat	   = mptcp_set_rcvlowat,
 	.read_sock	   = mptcp_read_sock,
 	.splice_read	   = mptcp_splice_read,
+	.sendmsg_locked	   = mptcp_sendmsg_locked,
 };
 
 static struct proto mptcp_v6_prot;
-- 
2.43.0

