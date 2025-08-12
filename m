Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8D6E27450
	for <mptcp@lists.linux.dev>; Tue, 12 Aug 2025 08:17:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754986660; cv=none; b=a3sqTtR0Ejt6TRpTiZqewe3OHlGVbEf+cVhVye1D+/t9feXOojSNPw8wHm7g9JQiQZmEc2cMYoJpp2zPJhg/rIfG+eybi888CSGVmRvyHEIpe+//jPdblc94jVtI3+A4YlWEKmXW+xQp5n3zkTW8cVJ5PBCzPlOCWYCAhLBYGkw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754986660; c=relaxed/simple;
	bh=d4eHyUsqEWuxFUzViw5b3YGCaJ/gGgIn6GDpMFCj5HI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=sjSgUEE0RECpxLA0x9rHSMqYsGJUUQstl4dw33uhI1ZsdAZX05rnfh2SckhADJ1S7ZM1OjpUyFLvj5mOH9jr4od1xOk4teXFY0TmSgBXNL8ygdsQqq1UG5rso7LGo8YY4kOrMjj/9FVAv2wulDL8fqEi+RyIz+b5fwXp20XdQdI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jLVDVm1l; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jLVDVm1l"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5A5C2C4CEF4;
	Tue, 12 Aug 2025 08:17:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1754986660;
	bh=d4eHyUsqEWuxFUzViw5b3YGCaJ/gGgIn6GDpMFCj5HI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=jLVDVm1lMfWmGbisMpPFgabTTyDolYtj19/EUbqh0LM0YKED//QJnponE2YEVsz0I
	 dItXd8sBd6r9uzJjWyQw7+Eto4ax5wnp9+GTOEzIb1gd/tj530oaerqX/azQKe+c4z
	 2KniZn2d+vWxGUeBmgbjxHWW1RQviCuSythOo/QBvs6NUciHsoq8i23BR1NMdx6fzp
	 OLXxmc9I7rbtOJKo4f3x9iMsy7AfJid0TqpxnhHLsfsOrutASII8b5zG7Y45YcUay1
	 PdO490Nfxsg0ZsbKhwUdL9QWGzc0DFsj5gKhTfNla9yZxZLDvARYwsff/63y+fRTV1
	 kXvAg1U0hrwkA==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next 6/6] mptcp: handle IP socket options on all subflows
Date: Tue, 12 Aug 2025 16:17:21 +0800
Message-ID: <921e437a6902a35ef313fd4fd50933fa95fa1d8f.1754986557.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <cover.1754986557.git.tanggeliang@kylinos.cn>
References: <cover.1754986557.git.tanggeliang@kylinos.cn>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Geliang Tang <tanggeliang@kylinos.cn>

Introduce mptcp_ip_setsockopt_all_sf() helper to consistently apply IP
socket options across all MPTCP subflows. This helper:
1. Sets options on the main MPTCP socket
2. Propagates values to all existing subflows
3. Uses lock synchronization for atomic updates
4. Maintains option sequence counters

Centralizes IP-level option handling for future options requiring subflow
propagation.

Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
---
 net/mptcp/sockopt.c | 22 +++++++++++++++++-----
 1 file changed, 17 insertions(+), 5 deletions(-)

diff --git a/net/mptcp/sockopt.c b/net/mptcp/sockopt.c
index 81cc24125c29..f5579fd8b70d 100644
--- a/net/mptcp/sockopt.c
+++ b/net/mptcp/sockopt.c
@@ -20,6 +20,9 @@
 static int mptcp_setsockopt_first_sf_only(struct mptcp_sock *msk, int level,
 					  int optname, sockptr_t optval,
 					  unsigned int optlen);
+static int mptcp_setsockopt_all_sf(struct mptcp_sock *msk, int level,
+				   int optname, sockptr_t optval,
+				   unsigned int optlen);
 
 static struct sock *__mptcp_tcp_fallback(struct mptcp_sock *msk)
 {
@@ -760,13 +763,17 @@ static int mptcp_setsockopt_sol_ip_first_sf_only(struct mptcp_sock *msk, int opt
 	return 0;
 }
 
-static int mptcp_setsockopt_v4_set_tos(struct mptcp_sock *msk, int optname,
-				       sockptr_t optval, unsigned int optlen)
+static int mptcp_setsockopt_sol_ip_all_sf(struct mptcp_sock *msk,
+					  int optname, sockptr_t optval,
+					  unsigned int optlen)
 {
 	struct mptcp_subflow_context *subflow;
 	struct sock *sk = (struct sock *)msk;
 	int err, val;
 
+	if (optname != IP_TOS)
+		return -EOPNOTSUPP;
+
 	err = ip_setsockopt(sk, SOL_IP, optname, optval, optlen);
 
 	if (err != 0)
@@ -774,13 +781,15 @@ static int mptcp_setsockopt_v4_set_tos(struct mptcp_sock *msk, int optname,
 
 	lock_sock(sk);
 	sockopt_seq_inc(msk);
-	val = READ_ONCE(inet_sk(sk)->tos);
+	if (optname == IP_TOS)
+		val = READ_ONCE(inet_sk(sk)->tos);
 	mptcp_for_each_subflow(msk, subflow) {
 		struct sock *ssk = mptcp_subflow_tcp_sock(subflow);
 		bool slow;
 
 		slow = lock_sock_fast(ssk);
-		__ip_sock_set_tos(ssk, val);
+		if (optname == IP_TOS)
+			__ip_sock_set_tos(ssk, val);
 		unlock_sock_fast(ssk, slow);
 	}
 	release_sock(sk);
@@ -798,7 +807,7 @@ static int mptcp_setsockopt_v4(struct mptcp_sock *msk, int optname,
 	case IP_LOCAL_PORT_RANGE:
 		return mptcp_setsockopt_first_sf_only(msk, SOL_IP, optname, optval, optlen);
 	case IP_TOS:
-		return mptcp_setsockopt_v4_set_tos(msk, optname, optval, optlen);
+		return mptcp_setsockopt_all_sf(msk, SOL_IP, optname, optval, optlen);
 	}
 
 	return -EOPNOTSUPP;
@@ -873,6 +882,9 @@ static int mptcp_setsockopt_all_sf(struct mptcp_sock *msk, int level,
 	case SOL_TCP:
 		return mptcp_setsockopt_sol_tcp_all_sf(msk, optname,
 						       optval, optlen);
+	case SOL_IP:
+		return mptcp_setsockopt_sol_ip_all_sf(msk, optname,
+						      optval, optlen);
 	}
 
 	return -EOPNOTSUPP;
-- 
2.48.1

