Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8112A883F
	for <mptcp@lists.linux.dev>; Mon,  6 Apr 2026 12:20:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775478013; cv=none; b=OzyMzIIWomedocC7dajlt1Gr30UNYJRhU7MURSpGAO4uXT6fof3MHyK18ccXzspgd+fciG0x43m9YyP/7RQ9EZTDpVKR4RFxNbnopbMBxdHKrXQZs4w58rcxMvmAZ2Ft6OEu+WenCw4lPqup13SxG/VdqlFAuUNeF5aMBqnuJqc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775478013; c=relaxed/simple;
	bh=8R0gwC10MPXxQTKOuAEK0LeR4U2c+0HW+4yOws5HdEY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZqgVAZDETzwJ216JyTgWfIbk2HAsyKQiXjPK7caeXRHjnzBrPnHZL6sK9Qmr//x6VRhBgUcDn2T9+oeNehhoUZ6VavqXq7Q/dpvmXquHJKwIGDm7V2WdwTuFxAewHfLt90K3ZzIleuW0RHqQbrPVJN6f3JTrM2f97GelIre/YCc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fl+FH+11; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fl+FH+11"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DDE71C4CEF7;
	Mon,  6 Apr 2026 12:20:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775478013;
	bh=8R0gwC10MPXxQTKOuAEK0LeR4U2c+0HW+4yOws5HdEY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=fl+FH+11ZkAp26BbRw0aQ0/sS7QEgIi5gjt3M1FO2TYbfygPeoSWg6vWpCC4w7GiV
	 12e3rNEl9BjmLLBSZxYG5yosUi6FLTvJle3cx/NhPfr+suCPZN1oxVyek/4/n0H/U6
	 Z4SjHAaCdbDxe0iz9M0Vdx+W28I5gZ5PEyMeBmkvtYW/tZQH/SFqxRtcwOG+b5FFNR
	 7fGnVvdlBJOcc+vBv3rPqs3xCwGZtmSudOXj+jporE6ZnwDYeNUgPTiaGfEnp8lvi9
	 wF0c4Nky3SKlSqLODcqzVNfzpTtnbJyGMVWzTvfFYAmRqmjb/FCqgzKISNle66FYia
	 xSfzeeaLn1JFA==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>,
	Gang Yan <yangang@kylinos.cn>
Subject: [RFC mptcp-next v14 08/15] mptcp: enable ulp setsockopt for tls support
Date: Mon,  6 Apr 2026 20:18:48 +0800
Message-ID: <64b14fd17fcc2ab5860fcc22c02e4d7c0a3fe569.1775476921.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <cover.1775476921.git.tanggeliang@kylinos.cn>
References: <cover.1775476921.git.tanggeliang@kylinos.cn>
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
index d780989679a1..59fdc12f35c9 100644
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

