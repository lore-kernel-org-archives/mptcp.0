Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C2B9329E49
	for <mptcp@lists.linux.dev>; Wed, 29 Apr 2026 10:47:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777459653; cv=none; b=S1GIR5OXjQX1tiA/XqtfRA2sn7u+93x5MOT6vnwyvfCCfTrRUk0E+MSOWc7pshoFwJIIfJG7BeaE1/5i1akxM5muP3HIqqJgEsBtsv7GdfuY8dwFEb7cZLMDT+QPcbeM5ZW3zPHHvWBJCdrTxGVYVKBFLPQHB3WVbH6f0yqxPEQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777459653; c=relaxed/simple;
	bh=cF3MEYE3ZvQOGmen2U+zSPTQGK09OR7pQ1vas4Jiwlo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jP06lKMgxfsP/YGSL3ssukgQ198OwHKC0WfsGGdqhFD9v6rYKCOFrRMkEwX+vhAF53bC+vVg7cwDBugOWPTB7Qj7kPV0QEOl1e8QunvGWmVrjRVog0uYw3a4hnAhVSLFY+jlOVR2egOqK+snKHJ/Z9M3gSW0MgUu6qpDtRE+Ymc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QVg68C1h; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QVg68C1h"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3950BC2BCC4;
	Wed, 29 Apr 2026 10:47:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777459652;
	bh=cF3MEYE3ZvQOGmen2U+zSPTQGK09OR7pQ1vas4Jiwlo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=QVg68C1hpdIXZfMIEmxQ2Avtzj4/GaoKzHpkDNqYfVHPpf2Gvf8EYi/DNIPq23D9d
	 rkHzpz8TaPaFmeYeeGl7tDqHTgMSpIX9DVI4GmtN3juSb67aX8x8mAa0T5PZVk1Q5p
	 KdGHKudjBEHocIRH5ZPhf3TegcXx7wXCCszwKTkwQy/+IvGtqYfpfwMJPMZ0QCrilU
	 uR8f3ZMZ1f9P5Fth9/+dISZ0i2vlihc5HLpYra/iXp1VfJ+vSdsFUqE51tlbzGK5L8
	 mpdyqRiGOl3XDURNS86/hDoBRZYG9CxtCHbQjd17PWT2RbOxp66SP3DG0lGD7eGxyg
	 yUswac9Mn448g==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>,
	Gang Yan <yangang@kylinos.cn>
Subject: [RFC mptcp-next v18 08/15] mptcp: enable ulp setsockopt for tls support
Date: Wed, 29 Apr 2026 18:44:56 +0800
Message-ID: <80342a9357fe2bd820213dc8dea00c9051c327db.1777459066.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <cover.1777459066.git.tanggeliang@kylinos.cn>
References: <cover.1777459066.git.tanggeliang@kylinos.cn>
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
index f9ac87dd4ff1..0ea63098e351 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -3625,6 +3625,7 @@ static void mptcp_destroy(struct sock *sk)
 	/* allow the following to close even the initial subflow */
 	msk->free_first = 1;
 	mptcp_destroy_common(msk);
+	tcp_cleanup_ulp(sk);
 	sk_sockets_allocated_dec(sk);
 }
 
diff --git a/net/mptcp/sockopt.c b/net/mptcp/sockopt.c
index bea55b1608f0..6eee830f1d36 100644
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
2.53.0

