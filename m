Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62E0230AAD8
	for <mptcp@lists.linux.dev>; Fri, 17 Apr 2026 23:48:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776469713; cv=none; b=bJjli0+XUUHkOctC4XWxEHvC5KLdA1WCLqGro68yV/ZIoF1Td/e0ufiAvtqe9jHRZXEEzkc65GJpIDqxbTGALtdCh23cnel1HqAGvthpylhUkFYg3DSMhtR/WFVE5K+QbmiaU0FJ//HXRzHcnwUBblP4uOWfnY7kN1pIBY/IejY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776469713; c=relaxed/simple;
	bh=TmMeEzXxt0tSf8YPbt+b0+vQuWNC7fgyuNVaG2w6bgg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YgTyOmmXVHjcqLk5x8HKJQOXsU4fQbP70vvh8Lbi64RzbuwvtVYEVHbz6X9HbOJsnpsh7+B4pvGOlPuvt9IaqEnixqQxkOlqoewj68/Bd3kI3+eCAc+EY4/NC92eIgdsKdF8YATZmz4YQutYnfnJEBAdivK2jhvxIthnCh8K8U8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=i+bhKs3U; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="i+bhKs3U"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 15850C2BCB3;
	Fri, 17 Apr 2026 23:48:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776469713;
	bh=TmMeEzXxt0tSf8YPbt+b0+vQuWNC7fgyuNVaG2w6bgg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=i+bhKs3UIFdakk76EbOi8KV/CHwPlfyOoGNKiBPPqPli/Cklv23yYVaftbICjpczA
	 pgyrqxq2D5jKlK5EFRkUUQQ2WbdEurLfVA0/ZnsWy1g7jCsAH8Q1zlGxEBeVm1clcF
	 ttVnK034O8smoeRhx/Wa43aus3PrFubMeZyibw3NwN3JYJ8UsziJ1CteafhDCw1Szs
	 RaW9aUYF7hklakUwWDccOyw5ka2bDiz2XPua3R3rldZ7E6DLz0YmOcb8hnJ5i3gq1s
	 fU7LlgDUhFJOqwYBucgiV62j14bb41qlGqx7k1x6GEfnlBsPJ+AwZvRdfNIFv+8BBN
	 NyAzVA/aJt3ag==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>,
	Gang Yan <yangang@kylinos.cn>
Subject: [RFC mptcp-next v15 08/15] mptcp: enable ulp setsockopt for tls support
Date: Sat, 18 Apr 2026 07:47:47 +0800
Message-ID: <8bbc703de93b99ed4e44fddc1b0267a86d7ed4e7.1776469068.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <cover.1776469068.git.tanggeliang@kylinos.cn>
References: <cover.1776469068.git.tanggeliang@kylinos.cn>
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
 net/mptcp/sockopt.c  | 35 ++++++++++++++++++++++++++++++++++-
 2 files changed, 35 insertions(+), 1 deletion(-)

diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index a4fda39499b7..f68d93f0b3be 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -3422,6 +3422,7 @@ static void mptcp_destroy_common(struct mptcp_sock *msk)
 
 	__mptcp_clear_xmit(sk);
 	mptcp_backlog_purge(sk);
+	tcp_cleanup_ulp(sk);
 
 	/* join list will be eventually flushed (with rst) at sock lock release time */
 	mptcp_for_each_subflow_safe(msk, subflow, tmp)
diff --git a/net/mptcp/sockopt.c b/net/mptcp/sockopt.c
index 59742c956154..4282b47faed7 100644
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
 
@@ -815,6 +817,37 @@ static int mptcp_setsockopt_all_sf(struct mptcp_sock *msk, int level,
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
@@ -823,7 +856,7 @@ static int mptcp_setsockopt_sol_tcp(struct mptcp_sock *msk, int optname,
 
 	switch (optname) {
 	case TCP_ULP:
-		return -EOPNOTSUPP;
+		return mptcp_setsockopt_tcp_ulp(sk, optval, optlen);
 	case TCP_CONGESTION:
 		return mptcp_setsockopt_sol_tcp_congestion(msk, optval, optlen);
 	case TCP_DEFER_ACCEPT:
-- 
2.51.0

