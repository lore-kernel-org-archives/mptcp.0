Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D78A67F
	for <mptcp@lists.linux.dev>; Sat, 11 May 2024 08:37:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715416662; cv=none; b=jYizgPh96PnuZWA/jVrVDzDXFMTO4V7mU+xyyPgKtTnc1RGY96+6i60AY8ZwnQKx/RYpq4h5tdOW5f8slLfNkBd+BjxOb2u7a0WegbYdbvTlOSD/ubjyRIeC8owVioxFz+656epuAWTIylCOyAOOny0kI4D8+nnExb444uKT1HY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715416662; c=relaxed/simple;
	bh=llhXym/slEhIQMmoJInaTajVtpk8Nff3zeApqrmoDn0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CtX3RTPBNG04pzfU66TgV7pWYF9rPDl/vTa45LtHuva6p6cWdzmn/OHqJTjmhF/xM/JYvnfWe8aRHdrbRLMSrCwNrkYgzlyYUQPnFwO8jcPwc6F6ou+t42uHisjWvYMZd0/M2h+d4Ix0Vl+lUGX56g8tU2Bs8A8i10jij0bglkA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HhggVTDS; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HhggVTDS"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7C8B6C2BBFC;
	Sat, 11 May 2024 08:37:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715416662;
	bh=llhXym/slEhIQMmoJInaTajVtpk8Nff3zeApqrmoDn0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=HhggVTDSyHFmYGlVATq+ins8L+NibqHpx13YmjxQkQDIzqwuPBVl/6cIgcJM6AaMY
	 oKCu/wut9uTC31GVqjoz/04CMg8TUbOohEnh1lF3O+u3wtVtULRYGljjYyWU6ke1nZ
	 EZE1Q0kGMeSHxvu7V0D/Cl/B2reB+qHCYtU1ZBy+uHbZgp07Ir9lZOaOZHvQspqfCp
	 bZpQp8GXwBsnUXYVxoPFiHlHx8B7i1pzp0ZRrj0Lj2QJH6JU35ZZV/oO7jd5i/XwCw
	 6cjOviA5P9CizqDKfLIW7rJdnYC3cRJ3KaTrgzMDAIiI17R85FCrKvmTyjVP+jjMD8
	 m2DzILR6XLY6g==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next 2/2] mptcp: add mptcp_space_from_win helper
Date: Sat, 11 May 2024 16:37:31 +0800
Message-ID: <866617e1d8b5a3d7c800e03a1948be7b6bc7c234.1715416511.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1715416511.git.tanggeliang@kylinos.cn>
References: <cover.1715416511.git.tanggeliang@kylinos.cn>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Geliang Tang <tanggeliang@kylinos.cn>

As a wrapper of __tcp_space_from_win(), this patch adds a MPTCP dedicated
space_from_win helper mptcp_space_from_win() in protocol.h to paired with
mptcp_win_from_space().

Use it instead of __tcp_space_from_win() in both mptcp_rcv_space_adjust()
and mptcp_set_rcvlowat().

Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
---
 net/mptcp/protocol.c | 2 +-
 net/mptcp/protocol.h | 5 +++++
 net/mptcp/sockopt.c  | 2 +-
 3 files changed, 7 insertions(+), 2 deletions(-)

diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index 04dda32ccbef..8b0a5b74a3b1 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -2040,7 +2040,7 @@ static void mptcp_rcv_space_adjust(struct mptcp_sock *msk, int copied)
 		do_div(grow, msk->rcvq_space.space);
 		rcvwin += (grow << 1);
 
-		rcvbuf = min_t(u64, __tcp_space_from_win(scaling_ratio, rcvwin),
+		rcvbuf = min_t(u64, mptcp_space_from_win(sk, rcvwin),
 			       READ_ONCE(sock_net(sk)->ipv4.sysctl_tcp_rmem[2]));
 
 		if (rcvbuf > sk->sk_rcvbuf) {
diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
index b5fb26ece2b8..19d60b6d5b45 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -386,6 +386,11 @@ static inline int mptcp_win_from_space(const struct sock *sk, int space)
 	return __tcp_win_from_space(mptcp_sk(sk)->scaling_ratio, space);
 }
 
+static inline int mptcp_space_from_win(const struct sock *sk, int win)
+{
+	return __tcp_space_from_win(mptcp_sk(sk)->scaling_ratio, win);
+}
+
 static inline int __mptcp_space(const struct sock *sk)
 {
 	return mptcp_win_from_space(sk, READ_ONCE(sk->sk_rcvbuf) - __mptcp_rmem(sk));
diff --git a/net/mptcp/sockopt.c b/net/mptcp/sockopt.c
index 7265b6733f5a..00e06c698415 100644
--- a/net/mptcp/sockopt.c
+++ b/net/mptcp/sockopt.c
@@ -1581,7 +1581,7 @@ int mptcp_set_rcvlowat(struct sock *sk, int val)
 	if (sk->sk_userlocks & SOCK_RCVBUF_LOCK)
 		return 0;
 
-	space = __tcp_space_from_win(mptcp_sk(sk)->scaling_ratio, val);
+	space = mptcp_space_from_win(sk, val);
 	if (space <= sk->sk_rcvbuf)
 		return 0;
 
-- 
2.43.0

