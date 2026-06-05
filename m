Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B780351C17
	for <mptcp@lists.linux.dev>; Fri,  5 Jun 2026 01:24:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780622666; cv=none; b=UBATPFAbYnGyChvxpylZ+bXUNZwa6qdf+53PkPmH07IOxGyd1AWPeQ0UCo0QAbVya3Yhmr6INr2OIujdWGBoC1PMGNZIn19X8ZfpxrjoAitpNLGFR6eZ7+4JmfSa0e1g/ineXa0LaX2bbL0q8JibNkN/GUt04SKKi+r/FhknHB8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780622666; c=relaxed/simple;
	bh=Iklzlhbp9JBQW7xMm6FoVauQGvLCZTYoh4fjbav/F70=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KW0UH+bVNUxjo+SamSZYxu7NVZMIEh3b42l2VLO95QAxK7ZhbizO++4c/JbCehvRbWRMpn3KWInufZnjnK6nY9Omnz54kY8byqWDi10mDsaARqjLhwZeStVWnNmKMssknK0Bmmzc1y7+7Gg09by2/bTmqpm39OCjwXUGmFu22Fs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Day36RyW; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Day36RyW"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 385E11F0089C;
	Fri,  5 Jun 2026 01:24:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780622659;
	bh=rTJGMb0aZHFaedbBgeubqLAdlseOZ+DRKD2fOMx3DyA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Day36RyWQm8alrr/ic3pJRuNiUYJfD/3SvLfAwyzIt0ofjFezQnifWVIf2QttNlPj
	 adfjgTvk5kXEic3ZM6M9KZAAIk/Fmtx10+bQZFtH+wxYDKPvZh9aw4CWgh/+dGnz6a
	 KwmtzVlRUvaj7hs9nE4BaidycSf0euhay8hwnQBUmHWnSFwthz4ijcssGHqCoFojRf
	 iIUUno5rZg1Ejt4QiK56XBw20ayw/CB3+/yVkXAOwnAblIslHwJVSwnxxZ6xK0T/jq
	 iCxLq7mp2E3t5RAnRAnHPSlBg2X5EuZUv1nDs5VxMKMhnbxF5iWEVXxXfHdt8oZEcV
	 g0d9gCBCAApSA==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev,
	yangang@kylinos.cn,
	qiang.zhang@linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [RFC mptcp-next v24 10/18] mptcp: implement ulp setsockopt for tls support
Date: Fri,  5 Jun 2026 09:22:50 +0800
Message-ID: <c3e6750d99caf374b333ddf090553e210d8759f5.1780621326.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <cover.1780621326.git.tanggeliang@kylinos.cn>
References: <cover.1780621326.git.tanggeliang@kylinos.cn>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Geliang Tang <tanggeliang@kylinos.cn>

Allow MPTCP sockets to set the TCP_ULP socket option to enable TLS.
Add mptcp_setsockopt_tcp_ulp() which validates the socket state (must
not be CLOSE or LISTEN), only accepts "tls" as the ULP name, and then
calls tcp_set_ulp().

Include TCP_ULP in the list of supported options in supported_sockopt(),
and handle it in setsockopt_sol_tcp() instead of returning -EOPNOTSUPP.

Call tcp_cleanup_ulp() in mptcp_destroy_common() to release ULP module's
reference count.

On a fallback MPTCP socket, the ULP is already set to "mptcp". Setting
"tls" will fail with -EEXIST, so no special handling is needed.

Co-developed-by: Gang Yan <yangang@kylinos.cn>
Signed-off-by: Gang Yan <yangang@kylinos.cn>
Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
---
 net/mptcp/protocol.c |  1 +
 net/mptcp/sockopt.c  | 34 +++++++++++++++++++++++++++++++++-
 2 files changed, 34 insertions(+), 1 deletion(-)

diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index 55cc68c460b6..a2972e70aa84 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -3772,6 +3772,7 @@ static void mptcp_destroy(struct sock *sk)
 	/* allow the following to close even the initial subflow */
 	msk->free_first = 1;
 	mptcp_destroy_common(msk);
+	tcp_cleanup_ulp(sk);
 	sk_sockets_allocated_dec(sk);
 }
 
diff --git a/net/mptcp/sockopt.c b/net/mptcp/sockopt.c
index cc45491cd3b2..eeb348336195 100644
--- a/net/mptcp/sockopt.c
+++ b/net/mptcp/sockopt.c
@@ -577,6 +577,7 @@ static bool mptcp_supported_sockopt(int level, int optname)
 		case TCP_FASTOPEN_CONNECT:
 		case TCP_FASTOPEN_KEY:
 		case TCP_FASTOPEN_NO_COOKIE:
+		case TCP_ULP:
 			return true;
 		}
 
@@ -830,6 +831,37 @@ static int mptcp_setsockopt_all_sf(struct mptcp_sock *msk, int level,
 	return ret;
 }
 
+static int mptcp_setsockopt_tcp_ulp(struct sock *sk, sockptr_t optval,
+				    unsigned int optlen)
+{
+	char name[TCP_ULP_NAME_MAX];
+	int err = 0;
+	size_t len;
+	int val;
+
+	if (optlen < 1)
+		return -EINVAL;
+
+	len = min_t(long, TCP_ULP_NAME_MAX - 1, optlen);
+	val = strncpy_from_sockptr(name, optval, len);
+	if (val < 0)
+		return -EFAULT;
+	name[val] = 0;
+
+	if (strcmp(name, "tls"))
+		return -EOPNOTSUPP;
+
+	sockopt_lock_sock(sk);
+	if ((1 << sk->sk_state) & (TCPF_CLOSE | TCPF_LISTEN)) {
+		err = -ENOTCONN;
+		goto out;
+	}
+	err = tcp_set_ulp(sk, name);
+out:
+	sockopt_release_sock(sk);
+	return err;
+}
+
 static int mptcp_setsockopt_sol_tcp(struct mptcp_sock *msk, int optname,
 				    sockptr_t optval, unsigned int optlen)
 {
@@ -838,7 +870,7 @@ static int mptcp_setsockopt_sol_tcp(struct mptcp_sock *msk, int optname,
 
 	switch (optname) {
 	case TCP_ULP:
-		return -EOPNOTSUPP;
+		return mptcp_setsockopt_tcp_ulp(sk, optval, optlen);
 	case TCP_CONGESTION:
 		return mptcp_setsockopt_sol_tcp_congestion(msk, optval, optlen);
 	case TCP_DEFER_ACCEPT:
-- 
2.53.0

