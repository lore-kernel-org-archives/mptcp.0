Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 326D535E1BD
	for <mptcp@lists.linux.dev>; Tue, 26 May 2026 09:47:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779788821; cv=none; b=hcW/aShueb4komrBEz4mKpNcwqFE+Ra5qO/I3BHg+f3K3LBHcUNsAwyFk9DwxzSuGGMqTz5T/Z600gp7IQUlTFjXRvM1xeaLIvnpjRR7OTmT0pt+RGBMjmetAduo8mTrL1KIw/2DARwQpvAgCuLopv9uQ3V8kzde4eWTlB+qMMw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779788821; c=relaxed/simple;
	bh=Wy7VLSXPC2bbiYqyPjPSsy6+7t7CGv539x4lLZ5K35k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kxsVKzRvgKgSaSWugg4BS8XRTQ31gze6arsdy3V0RcWa6F3zOWI63II2zQrHmLNRNPSgdGsgWRMMwIZ2QMDxY7dtLCwF97ekMzZuNI0/dhMbAvHAMYO+yr0V4ZgWGwkfb+gXJ1RqBYe6/JynPy0fKBVsKNSVnNp6MpfEtSS6OBk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aKf73kZM; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aKf73kZM"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 064BB1F000E9;
	Tue, 26 May 2026 09:46:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779788820;
	bh=uU5BhttnPbiTiRS3eNSnwf2yEUfMRb2GML1RoQrsHz0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=aKf73kZMH40Kb2fgfa1jV1CpQtKNGfIwSXGVAXLimSUfNCSkbyJs/bYoi7OIeyUqx
	 KP+EDAmN/20eTpzZx6fNUlFX4yk1kHIDXFj9jzGpBP/SX68wkUE1BARBvOxUlyelEo
	 X7mKzv0fW1C66NxYQNqus8C2cdNh8JYRFhzfp8h2u3eQKBn58SQx6p+RmvIFisjg9l
	 4dmw+ZpjT1JuwSC2QPAa5EQfP6MXIdHJD/163EQ/5qsVdvxfkbh9DZduj30d3Kd3La
	 l/6y6nAPVstkoMM+zjUF1N8vc4wOsIpLpbEU/pgD86eYxxMKbJOKKUOHlU7uhW3nxS
	 GQzGey4BRoIrA==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>,
	Gang Yan <yangang@kylinos.cn>
Subject: [RFC mptcp-next v20 08/15] mptcp: enable ulp setsockopt for tls support
Date: Tue, 26 May 2026 17:46:26 +0800
Message-ID: <5050a6aa86a71ac2fb1bec422543755bb744cf34.1779788090.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <cover.1779788090.git.tanggeliang@kylinos.cn>
References: <cover.1779788090.git.tanggeliang@kylinos.cn>
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

