Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 633E43ADB92
	for <mptcp@lists.linux.dev>; Thu, 28 May 2026 09:27:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779960463; cv=none; b=cHFY75AblIvWf+KtdpHZkoW7HsejISTzn8clo9PQ2W+l7LfRvq6qCHd4PsMpDcjoihMYvgT7qxvHAXhQtLg1XUctMiremZSYgX8LBBdLIYz5hedQi3uxMFRvwCMPwAXFNMHFfsdQHor4I1+xVA0VYfBvdFK2OR1yDj5HXC6mo20=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779960463; c=relaxed/simple;
	bh=KSWWdmAA+QU4+/n0sv9CJVFtFQxUxOQtVSAKMC0D6io=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JblTyBqkDovBav5TZOO9K1P2AzEd6MwUKInjjfyE2Qb/yDisE/6F5ESsDaCi25F5EDBc4+UCAfJhZFJSlOcfY6RU3ZxXp2WAE3ADPwffMkTDeKY8U7JJdV7+dDMKSsbzS3ZY8f9O99cVOoCF35vHXTDQceBGI2/11U/2MmmWCXM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fCPywUbT; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fCPywUbT"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 70E7D1F000E9;
	Thu, 28 May 2026 09:27:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779960460;
	bh=83X1Bc2I/hubj/a7TLvgtRFFBoGoYUs9UrdLsKsBUWw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=fCPywUbTa2r7NI0gNVpuFeRDyn/N2lVCa40ItoTk2gmbe+iJis1/IPwqU3OfzADt3
	 1iWvw+4y2vv8Cf20nJZIQPdZvB9bwxTk7WkJvrURAIcZTlvhwdTSS0rFzIQBU9eiJJ
	 TDVDrtbexpdIzyRrfnqATRAK7MupoFkARWIp75W/nu/xb/fqzlDyj7dxn2ZA6qRDy8
	 5vUyZTuPvRIKJvBswlZgVLi5UNc5sOOqWfndlwo93jY2yG+/ogBuQopetMIN4twQSK
	 e9KXp+NHM7fUpO+3dc9VZXEDMNu0YEztdEvjH4qIvDMeyQ5NDGsNBCns7kuhyBLu5D
	 n1ciijbF9kCfw==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>,
	Gang Yan <yangang@kylinos.cn>
Subject: [RFC mptcp-next v21 10/18] mptcp: enable ulp setsockopt for tls support
Date: Thu, 28 May 2026 17:27:01 +0800
Message-ID: <bd3f73a6927e6e2b2638d9f0ed290d1a25002434.1779959644.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <cover.1779959644.git.tanggeliang@kylinos.cn>
References: <cover.1779959644.git.tanggeliang@kylinos.cn>
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

Co-developed-by: Gang Yan <yangang@kylinos.cn>
Signed-off-by: Gang Yan <yangang@kylinos.cn>
Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
---
 net/mptcp/protocol.c |  1 +
 net/mptcp/sockopt.c  | 40 +++++++++++++++++++++++++++++++++++++++-
 2 files changed, 40 insertions(+), 1 deletion(-)

diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index e68846b8eeb4..c8e3dd367342 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -3648,6 +3648,7 @@ static void mptcp_destroy(struct sock *sk)
 	/* allow the following to close even the initial subflow */
 	msk->free_first = 1;
 	mptcp_destroy_common(msk);
+	tcp_cleanup_ulp(sk);
 	sk_sockets_allocated_dec(sk);
 }
 
diff --git a/net/mptcp/sockopt.c b/net/mptcp/sockopt.c
index ee1e71c178fa..a9fa3af9efcc 100644
--- a/net/mptcp/sockopt.c
+++ b/net/mptcp/sockopt.c
@@ -12,6 +12,7 @@
 #include <net/protocol.h>
 #include <net/tcp.h>
 #include <net/mptcp.h>
+#include <net/tls.h>
 #include "protocol.h"
 
 #define MIN_INFO_OPTLEN_SIZE		16
@@ -573,6 +574,7 @@ static bool mptcp_supported_sockopt(int level, int optname)
 		case TCP_FASTOPEN_CONNECT:
 		case TCP_FASTOPEN_KEY:
 		case TCP_FASTOPEN_NO_COOKIE:
+		case TCP_ULP:
 			return true;
 		}
 
@@ -825,6 +827,42 @@ static int mptcp_setsockopt_all_sf(struct mptcp_sock *msk, int level,
 	return ret;
 }
 
+static int mptcp_setsockopt_tcp_ulp(struct sock *sk, sockptr_t optval,
+				    unsigned int optlen)
+{
+	struct mptcp_sock *msk = mptcp_sk(sk);
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
+	if (__mptcp_check_fallback(msk)) {
+		err = -EOPNOTSUPP;
+		goto out;
+	}
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
@@ -833,7 +871,7 @@ static int mptcp_setsockopt_sol_tcp(struct mptcp_sock *msk, int optname,
 
 	switch (optname) {
 	case TCP_ULP:
-		return -EOPNOTSUPP;
+		return mptcp_setsockopt_tcp_ulp(sk, optval, optlen);
 	case TCP_CONGESTION:
 		return mptcp_setsockopt_sol_tcp_congestion(msk, optval, optlen);
 	case TCP_DEFER_ACCEPT:
-- 
2.53.0

