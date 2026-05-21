Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2447A376A10
	for <mptcp@lists.linux.dev>; Thu, 21 May 2026 09:30:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779355826; cv=none; b=AJqa+hZmUVJyB+dWX4EW7lrhV0ImNJg1kL31w0iXa5A5htimwR0GsHQ2L1lVfK91a5asskwZdpqlwHaEste6PXQ34te5NJ6s2ls6ope0B1yxt/rT00+8qWJJrZrRRTPgFxHPeYN9p0uaUTDJTN3M81BivTL8wLM5L+uDBm578NY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779355826; c=relaxed/simple;
	bh=NuWjWY7Q5T1hYxmP3Yj55SeP5llNdvWWdVmUAI/frm4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BPiBAcZ4vp4/dbkwj1uFt3dbQVoEcgppfTdN8bBw0rWepwSzyU1MfxJJJdIQcdqdqWiGPkKXLgzdUgI1+LmR/BQLCNFPaB0tK7O+DQ1XVDvmkCsKtWumw/lMKv9Pr/9uC8AwNvi9A5+EY1r4Dvg8bU/2+XAQ5kjETbtdeR5hls4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Z33W7+90; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Z33W7+90"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 506C81F000E9;
	Thu, 21 May 2026 09:30:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779355824;
	bh=putIHX1AtnfG1C3wmO7MHUYjFwRdFcEnc6YQS6tTcJY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Z33W7+90QBtE7vcWaI+7seiuYWEKOL5u/vZJwA5E/A0xkii4v+tKNRjhSI+ZD+qHJ
	 dw2HELCkyZxqlRaFGcIuVNnJrfi92uEbKEF6Ly0QYPZqD5iOD+FfcIoFLSFKDkkIVM
	 I85VleHPADI3moEZAofDN4DGyHOxcqR1AoU4ZfFlLlD2UbznrtUkmI9ZES9eoOYlFX
	 ZK+931XCpPLyQ6FVy3yPg5wzhDBea10cdT2yTCan8IM57NAKca0KUDJZqjk8WGO/EO
	 nHY72E2YnB2JvaIMrs8+cmxht9OzWu65Xob8t85zr7ADFv+ZLzK42Enphlbn+jYQBh
	 vP7Gjz1EN8IVg==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>,
	Gang Yan <yangang@kylinos.cn>
Subject: [RFC mptcp-next v19 08/15] mptcp: enable ulp setsockopt for tls support
Date: Thu, 21 May 2026 17:29:46 +0800
Message-ID: <ca3973cbd6e52974f0fc01209190eda3646907d0.1779355169.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <cover.1779355169.git.tanggeliang@kylinos.cn>
References: <cover.1779355169.git.tanggeliang@kylinos.cn>
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
 net/mptcp/sockopt.c  | 37 ++++++++++++++++++++++++++++++++++++-
 2 files changed, 37 insertions(+), 1 deletion(-)

diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index 505eac23f35d..06e037fe8807 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -3640,6 +3640,7 @@ static void mptcp_destroy(struct sock *sk)
 	/* allow the following to close even the initial subflow */
 	msk->free_first = 1;
 	mptcp_destroy_common(msk);
+	tcp_cleanup_ulp(sk);
 	sk_sockets_allocated_dec(sk);
 }
 
diff --git a/net/mptcp/sockopt.c b/net/mptcp/sockopt.c
index ee1e71c178fa..8fcd736fae37 100644
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
 
@@ -825,6 +827,37 @@ static int mptcp_setsockopt_all_sf(struct mptcp_sock *msk, int level,
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
@@ -833,7 +866,9 @@ static int mptcp_setsockopt_sol_tcp(struct mptcp_sock *msk, int optname,
 
 	switch (optname) {
 	case TCP_ULP:
-		return -EOPNOTSUPP;
+		if (__mptcp_check_fallback(msk))
+			return -EOPNOTSUPP;
+		return mptcp_setsockopt_tcp_ulp(sk, optval, optlen);
 	case TCP_CONGESTION:
 		return mptcp_setsockopt_sol_tcp_congestion(msk, optval, optlen);
 	case TCP_DEFER_ACCEPT:
-- 
2.53.0

