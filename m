Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47D753BE65C
	for <mptcp@lists.linux.dev>; Fri, 29 May 2026 11:14:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780053279; cv=none; b=F457+OlU8TsbuZQsmJx2BXFCibKxuHzBOV7CHVIgNslCbYve7Dw1V+yurV29V4SMADEFuVezaOFIKihoScZ9gMhTgFwhHT5gphrHu7gdmEkqS7NCfiiIKomG6RbOK10DfqP65sHqG1kaHdNxCahqj4dynBGHf+K7FbH7ayjQGPA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780053279; c=relaxed/simple;
	bh=4izWaohbT9APxn0iR8ureinX623jq3pJmCSnPaSDjcY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CvuGl67pLqm1tkFY58+QvyYPDZACDUTDX067qjf9Q470xe7Xnl2fLJRfYLth2wwPUebdULfrPGWgrQccoExGgqsMiS/TrjUFa6cuWS/PfveH4R2aRidSRt8NPdeVzlh5mYxHJl+MZpDEVGmgppxNBa67/JXaXp4sQVXksIWyv7g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IDYU9VrJ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IDYU9VrJ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5CA7C1F00899;
	Fri, 29 May 2026 11:14:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780053277;
	bh=GLT8fng9KbiEqiwXafGg/LxgIWTnPbGX0DiZpooAGoI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=IDYU9VrJs5NFOFYa+yDf4yLaoRmzcw4kTyjVDd/uQkddBSrLpMS5z+D1I39Rg/Cec
	 ZXfnVfy2Yw55PqMvK4hNGNQhACW+odvt5HXJB4rn0rt68bRma8B+p7g8o+/wU1QEMF
	 0Ts2dKA3HDTIvlOyyHOhRpBhoALyrtCKGN6+5R9N11Jwn2xqSDj/+lNDJIavIKHbhe
	 kY3fd2mUloSZRelm7AwAQW42QkQICsZIkjTQiRxlscFG9pQ4kehN4lEzscZvij5l06
	 +5q+uNssIv7u8NnhzZUyrSnSGJi8gpujL+sxskusXu7ADbIusTWH6uxj7V/U824OTg
	 mzSkRvT/KaL8Q==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>,
	Gang Yan <yangang@kylinos.cn>
Subject: [RFC mptcp-next v22 12/20] mptcp: enable ulp setsockopt for tls support
Date: Fri, 29 May 2026 19:13:54 +0800
Message-ID: <67118c759fba8945088e496c5dff2e8af7c1ca44.1780052851.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <cover.1780052851.git.tanggeliang@kylinos.cn>
References: <cover.1780052851.git.tanggeliang@kylinos.cn>
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
index f9dbe3a1e57b..26a9b0df5808 100644
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
index b7eccade1f90..d692bca17adf 100644
--- a/net/mptcp/sockopt.c
+++ b/net/mptcp/sockopt.c
@@ -12,6 +12,7 @@
 #include <net/protocol.h>
 #include <net/tcp.h>
 #include <net/mptcp.h>
+#include <net/tls.h>
 #include "protocol.h"
 
 #define MIN_INFO_OPTLEN_SIZE		16
@@ -577,6 +578,7 @@ static bool mptcp_supported_sockopt(int level, int optname)
 		case TCP_FASTOPEN_CONNECT:
 		case TCP_FASTOPEN_KEY:
 		case TCP_FASTOPEN_NO_COOKIE:
+		case TCP_ULP:
 			return true;
 		}
 
@@ -830,6 +832,42 @@ static int mptcp_setsockopt_all_sf(struct mptcp_sock *msk, int level,
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
@@ -838,7 +876,7 @@ static int mptcp_setsockopt_sol_tcp(struct mptcp_sock *msk, int optname,
 
 	switch (optname) {
 	case TCP_ULP:
-		return -EOPNOTSUPP;
+		return mptcp_setsockopt_tcp_ulp(sk, optval, optlen);
 	case TCP_CONGESTION:
 		return mptcp_setsockopt_sol_tcp_congestion(msk, optval, optlen);
 	case TCP_DEFER_ACCEPT:
-- 
2.53.0

