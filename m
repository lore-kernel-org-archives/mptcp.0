Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 192D72FC881
	for <mptcp@lists.linux.dev>; Fri, 13 Mar 2026 01:43:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773366209; cv=none; b=SoKSO4Y3Li12Os4g1kpB3Mi852bo+Sp13GnM5nDCDqbw9eaM7/T0KSaDUbyTUTpBoxIL6wg9xArq6YVN2hqmnfUw/a3QVwVXIqJiO7rZrey/A9B9XyarcLtsSQUPi6hyXNDh8L7clSbC2G5QA+CD7j45dXOJvAisqyk9eu7OXUU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773366209; c=relaxed/simple;
	bh=/0ztLZK2AsduRGL4EJz/5PARAS04RD6fMRVCyipRjLo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TqCUURwUbk5NoiqogjsOMsj/9pi5uccaLtNBMOc42oZ+h9efqDYT8GFVUbLB+tr6+dNYhpoRm8fPvBjk8MggyGIH1GDMC1obnzVck2e/6FPLvHykIpNkoV7dVhRzZxX9V2lw2Y2KX0ZJYBWzwTpGR9dRyL0hmwCAYwDIelLY/5A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Z+/UEaQT; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Z+/UEaQT"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 706C8C116C6;
	Fri, 13 Mar 2026 01:43:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773366209;
	bh=/0ztLZK2AsduRGL4EJz/5PARAS04RD6fMRVCyipRjLo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Z+/UEaQTt6jGNB4x3keM08Y6fRhRTdsWSE6NGgLHHNh9w+MnBaLm7EpoNTzJGPV8/
	 mZjYvFnXHaZDW8suitzR+Zno0h1RndNv0aaUOuWx7oXXiFsW0uEjcFW9Ovi98LAw3N
	 i5fenmpP0ZsTLv+yE2f8WTpzioGFQ7LRQoL8dtbo/HfWgvvldXndqRlW2ioGDztxfI
	 HwJIoNSYdvKDUnVIKWycWqECX6bwfZFAAk62i2M7Eni0YySUzOTJ5nb2SJDRPUYJHO
	 kbVbEGwrxTbmXbVTughANsSAony6Wkf12ffMByNQN2xyynqz6/1ftAYoH7C0KaTFMR
	 YaIj3S8qMaCgA==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>,
	Gang Yan <yangang@kylinos.cn>
Subject: [RFC mptcp-next v9 08/10] mptcp: enable TLS setsockopt
Date: Fri, 13 Mar 2026 09:42:50 +0800
Message-ID: <dda2773e5f0d3614ff25527cc901cee3573f97a5.1773365606.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <cover.1773365606.git.tanggeliang@kylinos.cn>
References: <cover.1773365606.git.tanggeliang@kylinos.cn>
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

Add MPTCP TLS setsockopt support in mptcp_setsockopt_sol_tcp(). It allows
setting the TCP_ULP option to 'tls' exclusively, and enables configuration
of the TLS_TX and TLS_RX options at the SOL_TLS level.

This option cannot be set when the socket is in CLOSE or LISTEN state.

Co-developed-by: Gang Yan <yangang@kylinos.cn>
Signed-off-by: Gang Yan <yangang@kylinos.cn>
Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
---
 include/linux/tcp.h |  1 +
 net/ipv4/tcp.c      | 42 ++++++++++++++++++++++++------------------
 net/mptcp/sockopt.c | 25 ++++++++++++++++++++++++-
 3 files changed, 49 insertions(+), 19 deletions(-)

diff --git a/include/linux/tcp.h b/include/linux/tcp.h
index 2e673f7b10ef..79bf6356b98f 100644
--- a/include/linux/tcp.h
+++ b/include/linux/tcp.h
@@ -644,6 +644,7 @@ int tcp_sock_set_syncnt(struct sock *sk, int val);
 int tcp_sock_set_user_timeout(struct sock *sk, int val);
 int tcp_sock_set_maxseg(struct sock *sk, int val);
 int tcp_sock_get_ulp(struct sock *sk, sockptr_t optval, sockptr_t optlen);
+int tcp_sock_set_ulp(struct sock *sk, sockptr_t optval, unsigned int optlen);
 
 static inline bool dst_tcp_usec_ts(const struct dst_entry *dst)
 {
diff --git a/net/ipv4/tcp.c b/net/ipv4/tcp.c
index 63b576eebae6..6cfb2e3faf73 100644
--- a/net/ipv4/tcp.c
+++ b/net/ipv4/tcp.c
@@ -3857,6 +3857,28 @@ int tcp_sock_set_maxseg(struct sock *sk, int val)
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
@@ -3890,24 +3912,8 @@ int do_tcp_setsockopt(struct sock *sk, int level, int optname,
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
index a6230f7910fd..aafc627b3da9 100644
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
 
@@ -576,6 +578,13 @@ static bool mptcp_supported_sockopt(int level, int optname)
 		 * TCP_REPAIR_WINDOW are not supported, better avoid this mess
 		 */
 	}
+	if (level == SOL_TLS) {
+		switch (optname) {
+		case TLS_TX:
+		case TLS_RX:
+			return true;
+		}
+	}
 	return false;
 }
 
@@ -815,6 +824,20 @@ static int mptcp_setsockopt_all_sf(struct mptcp_sock *msk, int level,
 	return ret;
 }
 
+static int mptcp_setsockopt_tcp_ulp(struct sock *sk, sockptr_t optval,
+				    unsigned int optlen)
+{
+	char ulp[4] = "";
+
+	if (copy_from_user(ulp, optval.user, 4))
+		return -EFAULT;
+	if (strcmp(ulp, "tls\0"))
+		return -EOPNOTSUPP;
+	if ((1 << sk->sk_state) & (TCPF_CLOSE | TCPF_LISTEN))
+		return -ENOTCONN;
+	return tcp_sock_set_ulp(sk, optval, optlen);
+}
+
 static int mptcp_setsockopt_sol_tcp(struct mptcp_sock *msk, int optname,
 				    sockptr_t optval, unsigned int optlen)
 {
@@ -823,7 +846,7 @@ static int mptcp_setsockopt_sol_tcp(struct mptcp_sock *msk, int optname,
 
 	switch (optname) {
 	case TCP_ULP:
-		return -EOPNOTSUPP;
+		return mptcp_setsockopt_tcp_ulp(sk, optval, optlen);
 	case TCP_CONGESTION:
 		return mptcp_setsockopt_sol_tcp_congestion(msk, optval, optlen);
 	case TCP_DEFER_ACCEPT:
-- 
2.53.0

