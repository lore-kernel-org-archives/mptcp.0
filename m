Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D0162701B1
	for <mptcp@lists.linux.dev>; Wed, 23 Apr 2025 09:40:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745401255; cv=none; b=ZcxB0ChL2s1F2LqFl4/TBtySPEWTL8BxuqekIxPJcG7+lRmrBQh6toIXOSTKfdCcs27wNUbB3Y4bJjgLmQ4+eM8ErHJAHQFN1V1cNFxGijFS9rf22g6fFr/bSgN0EzxVGbY5m8IQr5B8MRSaBp12fNA89QEfyUHxE8tmrs7AW10=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745401255; c=relaxed/simple;
	bh=itfQbPsn1BntUraeR373sWvbaxL8NsijCSxuKEkhTgE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Ex3eKoZujAE4oUp6+5eWMmmfOrQCXV79sqtXIEx2hrbZvWEP9HfkFtbgKSx8ds2a8+u/yyk9olMMihFaMHuhdLVnkznQe0oy/5n0ja59YZhRZuKhbaEt1vbXMC4ZHFCowBn4kI1PenBVGrXG3PstgG5c5j3IXJzaebXuvBvQ4Ho=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=e0sEFbIQ; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="e0sEFbIQ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 52920C4CEEC;
	Wed, 23 Apr 2025 09:40:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745401253;
	bh=itfQbPsn1BntUraeR373sWvbaxL8NsijCSxuKEkhTgE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=e0sEFbIQDFJt0upXQAJuoUx7mx3MuDBEaXTF+s3r0hoOfYF2XRcrOqzbTbH2EOzQL
	 kZsUJGIS7UeWslB8tlEZFkOc+sJ7rcGLAseEB+wQUtgO9olDiswAVW+JWNSeArymx5
	 b8Itiwb3snVTLzWizt6mtkhTrj+Fn2iuUJ5jKLnbVlEbLrmWlrXzZuU4QbQY7WDRfU
	 8jgEmmBhI2THp6aPCvquyGWwkFRPDmv0xVMbgq+daSXnQB+wBKmqlOscrhKuC/5NkD
	 zUK8YgnSrvPPihKtzE1v6iX0Uv4tL4aO9pkKcMMqjv7UkBmezzSEApYF8ZaEE2X69q
	 WpZ0L1ZG+fVXA==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next v2 2/3] mptcp: add TCP_MAXSEG sockopt support
Date: Wed, 23 Apr 2025 17:40:41 +0800
Message-ID: <8160ae5fd83c0815cee2f5998948199200574bc7.1745401025.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1745401025.git.tanggeliang@kylinos.cn>
References: <cover.1745401025.git.tanggeliang@kylinos.cn>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Geliang Tang <tanggeliang@kylinos.cn>

The TCP_MAXSEG socket option is currently not supported by MPTCP, mainly
because it has never been requested before. But there are still valid
use-cases, e.g. with HAProxy.

This patch adds its support in MPTCP by propagating the value to all
subflows.

Similar to mptcp_setsockopt_first_sf_only(), a generic helper
mptcp_setsockopt_all_subflows() is added to set sockopt for each
subflows of the mptcp socket.

Add a new member for struct mptcp_sock to store the TCP_MAXSEG value,
and return this value in getsockopt.

Closes: https://github.com/multipath-tcp/mptcp_net-next/issues/515
Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
---
 net/mptcp/protocol.h |  1 +
 net/mptcp/sockopt.c  | 24 ++++++++++++++++++++++++
 2 files changed, 25 insertions(+)

diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
index 64aa091cb685..91aaed17fe56 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -327,6 +327,7 @@ struct mptcp_sock {
 	int		keepalive_cnt;
 	int		keepalive_idle;
 	int		keepalive_intvl;
+	int		maxseg;
 	struct work_struct work;
 	struct sk_buff  *ooo_last_skb;
 	struct rb_root  out_of_order_queue;
diff --git a/net/mptcp/sockopt.c b/net/mptcp/sockopt.c
index 3caa0a9d3b38..a7992cbc5ed9 100644
--- a/net/mptcp/sockopt.c
+++ b/net/mptcp/sockopt.c
@@ -798,6 +798,22 @@ static int mptcp_setsockopt_first_sf_only(struct mptcp_sock *msk, int level, int
 	return ret;
 }
 
+static int mptcp_setsockopt_all_subflows(struct mptcp_sock *msk, int level, int optname,
+					 sockptr_t optval, unsigned int optlen)
+{
+	struct mptcp_subflow_context *subflow;
+
+	mptcp_for_each_subflow(msk, subflow) {
+		struct sock *ssk = mptcp_subflow_tcp_sock(subflow);
+		int ret = 0;
+
+		ret = tcp_setsockopt(ssk, level, optname, optval, optlen);
+		if (ret)
+			return ret;
+	}
+	return 0;
+}
+
 static int mptcp_setsockopt_sol_tcp(struct mptcp_sock *msk, int optname,
 				    sockptr_t optval, unsigned int optlen)
 {
@@ -859,6 +875,11 @@ static int mptcp_setsockopt_sol_tcp(struct mptcp_sock *msk, int optname,
 						 &msk->keepalive_cnt,
 						 val);
 		break;
+	case TCP_MAXSEG:
+		msk->maxseg = val;
+		ret = mptcp_setsockopt_all_subflows(msk, SOL_TCP, optname,
+						    optval, optlen);
+		break;
 	default:
 		ret = -ENOPROTOOPT;
 	}
@@ -1407,6 +1428,8 @@ static int mptcp_getsockopt_sol_tcp(struct mptcp_sock *msk, int optname,
 		return mptcp_put_int_option(msk, optval, optlen, msk->notsent_lowat);
 	case TCP_IS_MPTCP:
 		return mptcp_put_int_option(msk, optval, optlen, 1);
+	case TCP_MAXSEG:
+		return mptcp_put_int_option(msk, optval, optlen, msk->maxseg);
 	}
 	return -EOPNOTSUPP;
 }
@@ -1553,6 +1576,7 @@ static void sync_socket_options(struct mptcp_sock *msk, struct sock *ssk)
 	tcp_sock_set_keepidle_locked(ssk, msk->keepalive_idle);
 	tcp_sock_set_keepintvl(ssk, msk->keepalive_intvl);
 	tcp_sock_set_keepcnt(ssk, msk->keepalive_cnt);
+	tcp_sock_set_maxseg(ssk, msk->maxseg);
 
 	inet_assign_bit(TRANSPARENT, ssk, inet_test_bit(TRANSPARENT, sk));
 	inet_assign_bit(FREEBIND, ssk, inet_test_bit(FREEBIND, sk));
-- 
2.43.0

