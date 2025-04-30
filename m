Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C67BB1E32D3
	for <mptcp@lists.linux.dev>; Wed, 30 Apr 2025 05:49:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745992195; cv=none; b=Htgt8c1L+sykAXuMQHVCRObn+3rEvGf17/cC/2Ip70HiG+ywRejlWf0fuSlvIlDq8W8dA4bSBesK33HeJyb/3UUo5Mo6PRpBze4r2xilGHOub7/O6Fxkd2YUdc/kUSM2d4tFQS/0Lej4DMKRJEM0JOdJK1jr9gHRTF6xNrsdr0w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745992195; c=relaxed/simple;
	bh=3VYPnAy6jQfXdvjrxqQcao6d89NaXnZKASEGyczSm3A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=T7os6jSpHGl2PnJ8MXN9TNqiMDRw3W6BeTZSz8czj8OnAFkyPyh0QGJa8vFQqrpB64u6gOlc5zvbon+foSCcCQ3gIOpiqTqasggnhyGNMsNJ6CyR3OK/ped1L9KEoVUm9MsAL8pJDJYdKxGBZoTkIDehdxIinoma7W9NZbBoJGI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gyibBAEr; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gyibBAEr"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 24BC0C4CEEC;
	Wed, 30 Apr 2025 05:49:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745992195;
	bh=3VYPnAy6jQfXdvjrxqQcao6d89NaXnZKASEGyczSm3A=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=gyibBAErQFcbVIIFgj/OuOXME3jaHPABHhralkm9W+q90exdKI0qFZqMIdiKZlnkH
	 9Jrk581qcyMMuUWxUeLTr5C9wfdo2989rak+0XRrjkz8XpOJmUaY5FDuDJTrzFhZTf
	 bfUBiAKo8+zws2rm4lc6pNyNNQ5EjjQMDUggES0mI0eNa302G0sfUv742Y1H7FeTab
	 Ohi5Dl25zROQEWJp4Q3rLmvnSmWIK9X0cyaOX/EmRXEEX+naD/OA1v/o25mXVysJY1
	 OZSoh8YsrplqiOZu+LUvFz9ziugIdgGkkN0CVZsegNF9LTFEHUNUtc+bjH9Pc2+8pJ
	 9CFeSgvPv+wLw==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next v3 2/2] mptcp: add TCP_MAXSEG sockopt support
Date: Wed, 30 Apr 2025 13:49:45 +0800
Message-ID: <cdc5f6389f230f8c1eec4332c27efbf51c734a51.1745991978.git.geliang@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1745991978.git.geliang@kernel.org>
References: <cover.1745991978.git.geliang@kernel.org>
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
 net/mptcp/sockopt.c  | 25 +++++++++++++++++++++++++
 2 files changed, 26 insertions(+)

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
index afa54fba51e2..5a002dd05cc9 100644
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
@@ -1406,6 +1427,9 @@ static int mptcp_getsockopt_sol_tcp(struct mptcp_sock *msk, int optname,
 		return mptcp_put_int_option(msk, optval, optlen, msk->notsent_lowat);
 	case TCP_IS_MPTCP:
 		return mptcp_put_int_option(msk, optval, optlen, 1);
+	case TCP_MAXSEG:
+		return mptcp_getsockopt_first_sf_only(msk, SOL_TCP, optname,
+						      optval, optlen);
 	}
 	return -EOPNOTSUPP;
 }
@@ -1552,6 +1576,7 @@ static void sync_socket_options(struct mptcp_sock *msk, struct sock *ssk)
 	tcp_sock_set_keepidle_locked(ssk, msk->keepalive_idle);
 	tcp_sock_set_keepintvl(ssk, msk->keepalive_intvl);
 	tcp_sock_set_keepcnt(ssk, msk->keepalive_cnt);
+	tcp_sock_set_maxseg(ssk, msk->maxseg);
 
 	inet_assign_bit(TRANSPARENT, ssk, inet_test_bit(TRANSPARENT, sk));
 	inet_assign_bit(FREEBIND, ssk, inet_test_bit(FREEBIND, sk));
-- 
2.43.0

