Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 202DE264A97
	for <mptcp@lists.linux.dev>; Tue,  9 Jun 2026 02:19:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780971596; cv=none; b=XzpgMHnd4EAau66mIpaxSUHgco+NRo7/Vie0qwtp6l/QI3hJf/gmj0rJ5ajp7T/+4rX6iaR08kkFLNRE+WcwavVLQdGvUibzRzXtPO/TWyNRpPLi3e5ioAZ1OjGP+VpWkXc3zimt/h7lL9zYDqEd+sEN6Uk+TqWbrReLISuR3aA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780971596; c=relaxed/simple;
	bh=swfeOdHLEl1rDpl7MZcXTVp2mCA5RHUXYCHRAsrBahw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Mcyi85AOoL5HQZ487rOdPeIRDpw5qGZqYCqSGVgxcrNyLwD80fL9y8Fx1p7464IpSfq9no9Qnu5CFT6O4Rm+r8dGPPucxh4uXVSw3Ja7kYqaa6foF3BKd9iNJAwFs/20zzx2te3OBFlmHJ212GOZ8iMFkpul/QPMxbnZLpCRn9w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MVsJFObr; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MVsJFObr"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5862B1F00893;
	Tue,  9 Jun 2026 02:19:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780971595;
	bh=JbsUoq7re+mhcfBBOJ0bGg2qYw4kHDSd2iSXk7JPTfQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=MVsJFObrlUPIn+dMgEX6Xq7cYUP+VpM60aoiu/qkhNkb9XhG5szGuwcpzGr6WYXnV
	 osFx2uBRYiOrLb0Z6HdFNulOxcvTlRvF2ixB8G0cgP9WMvkOpiD0gM68gYP71r+84X
	 PEChxZ3kj2j00iHWEJbpGHsrxmWRaydT8ab1YeMXOX7eEISp7YHGFB2TcoB3tCrdPr
	 YQLGsS8YU5UI2yr1HDuWsE9izcno44c/2wY3m+dLgTAk4py0tzM21uJOT0zVRu58Nn
	 1MkA+ScBe5iAndm2ySoJMQXZ9ifKpCZsu8wCpRI9s6/b8sGHwWH7BnrnKQqpYmarQp
	 whdYmzy5tunmg==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>,
	Gang Yan <yangang@kylinos.cn>
Subject: [RFC mptcp-next v25 14/22] mptcp: implement ulp setsockopt for tls support
Date: Tue,  9 Jun 2026 10:18:40 +0800
Message-ID: <6d43a45b24785b4111d13b074a879b61c8eeed62.1780970284.git.tanggeliang@kylinos.cn>
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
index 88504af790f9..79432b139fe0 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -3765,6 +3765,7 @@ static void mptcp_destroy(struct sock *sk)
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
2.43.0

