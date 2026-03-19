Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 287CF3A255D
	for <mptcp@lists.linux.dev>; Thu, 19 Mar 2026 10:09:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773914954; cv=none; b=pMyMJEZWo6zDYkCb1UoZzw3gVJyXeiZv4ahgXZ4YBDJY3meWcpDefturcXD3veUNOu/cZIsYiEGJDfybsBvScD8vb0lMukM9KOLgj9RfjoPj8xrnU5rhIEsYynOdxBVipcBg9I12LjG9ENyVU8+KXJSYUvaOaS0cApNdOWcDReU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773914954; c=relaxed/simple;
	bh=+0BOLVFV8WRz9YaB5apP5PLt30g76/hz+1Ru+LI4UNk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Va7pTO9BBbG9DLDGU2J4gRvhlHrOgCxHGPGFWHuIDGVp8bvSLOaGjnZ9DeTcZxSx34hMb54PE2E4fH+d635oFvzYZBdSIb1kWY5V8GhokyQDz8XEzbBF37sGxr40SXqb9AG733ORRDQuoh/p+Dai1CkcDo1zJmimPUSRCDQRt2s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JKdL7SeF; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JKdL7SeF"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A50FBC2BC87;
	Thu, 19 Mar 2026 10:09:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773914953;
	bh=+0BOLVFV8WRz9YaB5apP5PLt30g76/hz+1Ru+LI4UNk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=JKdL7SeF1t7m1Eyhh9vQ4YTxgoLqAXtQRuG4LUQF925K4iv6i6bBHhkTA9yUNIjd/
	 F98ilALgO8TZXVnpW132XspqwxOAr40eEZHb4KGAcoSQg/UD3XCApMCHL+GooLLp7o
	 Xlli4zQIvxwuQ8QdqpJVgzB3D3n00E8SXHphMxnOP+38Kzg8l4Dl6OA1vW0Ay8JXJQ
	 Zy0t7MX/HAE5OsTsATfegTs2puxZMhha3MsD7VW9+SAwOyQbYsnH2t0aGVUlq7QcjV
	 t1AcyOumXfs/uJG5zS44eEDlckv4hY2wVKc4tPciR6yJhILf45/A02uAxqWQEWXQ0P
	 TxnK9DmrN+FIQ==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>,
	Gang Yan <yangang@kylinos.cn>
Subject: [RFC mptcp-next v11 09/15] mptcp: enable ULP setsockopt for TLS support
Date: Thu, 19 Mar 2026 18:08:42 +0800
Message-ID: <434a1d953278303dee02053f25abee2b2967117a.1773911536.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <cover.1773911536.git.tanggeliang@kylinos.cn>
References: <cover.1773911536.git.tanggeliang@kylinos.cn>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Geliang Tang <tanggeliang@kylinos.cn>

This patch extracts TCP_ULP setsockopt operation into a tcp_sock_set_ulp()
helper so that it can also be used in MPTCP.

Add MPTCP ULP setsockopt support in mptcp_setsockopt_sol_tcp().

This option cannot be set when the socket is in CLOSE or LISTEN state.

Co-developed-by: Gang Yan <yangang@kylinos.cn>
Signed-off-by: Gang Yan <yangang@kylinos.cn>
Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
---
 include/linux/tcp.h |  1 +
 net/ipv4/tcp.c      | 42 ++++++++++++++++++++++++------------------
 net/mptcp/sockopt.c | 27 ++++++++++++++++++++++++++-
 3 files changed, 51 insertions(+), 19 deletions(-)

diff --git a/include/linux/tcp.h b/include/linux/tcp.h
index 2bb1cbd3eeab..00538b1aa2f0 100644
--- a/include/linux/tcp.h
+++ b/include/linux/tcp.h
@@ -654,6 +654,7 @@ int tcp_sock_set_syncnt(struct sock *sk, int val);
 int tcp_sock_set_user_timeout(struct sock *sk, int val);
 int tcp_sock_set_maxseg(struct sock *sk, int val);
 int tcp_sock_get_ulp(struct sock *sk, sockptr_t optval, sockptr_t optlen);
+int tcp_sock_set_ulp(struct sock *sk, sockptr_t optval, unsigned int optlen);
 
 static inline bool dst_tcp_usec_ts(const struct dst_entry *dst)
 {
diff --git a/net/ipv4/tcp.c b/net/ipv4/tcp.c
index 55d8fb848842..8ebd2402847e 100644
--- a/net/ipv4/tcp.c
+++ b/net/ipv4/tcp.c
@@ -3858,6 +3858,28 @@ int tcp_sock_set_maxseg(struct sock *sk, int val)
 	return 0;
 }
 
+int tcp_sock_set_ulp(struct sock *sk, sockptr_t optval, unsigned int optlen)
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
+	sockopt_lock_sock(sk);
+	err = tcp_set_ulp(sk, name);
+	sockopt_release_sock(sk);
+	return err;
+}
+
 /*
  *	Socket option code for TCP.
  */
@@ -3891,24 +3913,8 @@ int do_tcp_setsockopt(struct sock *sk, int level, int optname,
 		sockopt_release_sock(sk);
 		return err;
 	}
-	case TCP_ULP: {
-		char name[TCP_ULP_NAME_MAX];
-
-		if (optlen < 1)
-			return -EINVAL;
-
-		val = strncpy_from_sockptr(name, optval,
-					min_t(long, TCP_ULP_NAME_MAX - 1,
-					      optlen));
-		if (val < 0)
-			return -EFAULT;
-		name[val] = 0;
-
-		sockopt_lock_sock(sk);
-		err = tcp_set_ulp(sk, name);
-		sockopt_release_sock(sk);
-		return err;
-	}
+	case TCP_ULP:
+		return tcp_sock_set_ulp(sk, optval, optlen);
 	case TCP_FASTOPEN_KEY: {
 		__u8 key[TCP_FASTOPEN_KEY_BUF_LENGTH];
 		__u8 *backup_key = NULL;
diff --git a/net/mptcp/sockopt.c b/net/mptcp/sockopt.c
index a6230f7910fd..d04eb98aaa32 100644
--- a/net/mptcp/sockopt.c
+++ b/net/mptcp/sockopt.c
@@ -12,6 +12,7 @@
 #include <net/protocol.h>
 #include <net/tcp.h>
 #include <net/mptcp.h>
+#include <net/tls.h>
 #include "protocol.h"
 
 #define MIN_INFO_OPTLEN_SIZE		16
@@ -567,6 +568,7 @@ static bool mptcp_supported_sockopt(int level, int optname)
 		case TCP_FASTOPEN_CONNECT:
 		case TCP_FASTOPEN_KEY:
 		case TCP_FASTOPEN_NO_COOKIE:
+		case TCP_ULP:
 			return true;
 		}
 
@@ -815,6 +817,29 @@ static int mptcp_setsockopt_all_sf(struct mptcp_sock *msk, int level,
 	return ret;
 }
 
+static int mptcp_setsockopt_tcp_ulp(struct sock *sk, sockptr_t optval,
+				    unsigned int optlen)
+{
+	char name[TCP_ULP_NAME_MAX];
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
+	if (strcmp(name, "tls\0"))
+		return -EOPNOTSUPP;
+	if ((1 << sk->sk_state) & (TCPF_CLOSE | TCPF_LISTEN))
+		return -ENOTCONN;
+	return tcp_sock_set_ulp(sk, optval, optlen);
+}
+
 static int mptcp_setsockopt_sol_tcp(struct mptcp_sock *msk, int optname,
 				    sockptr_t optval, unsigned int optlen)
 {
@@ -823,7 +848,7 @@ static int mptcp_setsockopt_sol_tcp(struct mptcp_sock *msk, int optname,
 
 	switch (optname) {
 	case TCP_ULP:
-		return -EOPNOTSUPP;
+		return mptcp_setsockopt_tcp_ulp(sk, optval, optlen);
 	case TCP_CONGESTION:
 		return mptcp_setsockopt_sol_tcp_congestion(msk, optval, optlen);
 	case TCP_DEFER_ACCEPT:
-- 
2.53.0

