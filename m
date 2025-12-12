Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 018A3299948
	for <mptcp@lists.linux.dev>; Fri, 12 Dec 2025 02:27:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765506463; cv=none; b=cwgC6MB0dtxmE2s6lllbU7tMr+F96Q0X9JvGqpiYxigzle0mhRkSTJahW3ZLAdQLHRNhDPb6T2sj74H7/fjQNcrsMFI0VeqEp4X7tY1u1SrxNBBmABCTj9cnWTYk4nhEstNCsWE+AmjAXuDYrwGo4fA1nYy+v1FK2m9kV6RaH08=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765506463; c=relaxed/simple;
	bh=oq0zKgX05uRcbn7PAy3rOmQlIOOnqg7bERQHSUE3Ymo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=j+Aj2HsIX0E9BT9MmCnaPHGSEmxE77EU+KoIABcU2sJ5xyyDJ+vmOvfNysbWBDwSwiqzEJ9IAJcXm0gJcmKfj4jdCkGmVN562j1vkK8CjxR43Gft0yGRN7E+knJeUcypEhVQX4XLyVMEGWpN9Y+6P1pucUoiKjwxUwy9sexC3fQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UegESR2y; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UegESR2y"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1CE12C19422;
	Fri, 12 Dec 2025 02:27:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1765506462;
	bh=oq0zKgX05uRcbn7PAy3rOmQlIOOnqg7bERQHSUE3Ymo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=UegESR2ySt9tgMzlJcQx6af0aOzf1tZJHijBhX2Z6Y3ObYcT+ESeP53HacLd6dZr4
	 JOGnN90DUdXP4DGBQ/DMGJjUKyVWbGVoVypMd4Po0GI8KGDelGPT25dkCYS0Gf8FmT
	 LeRzi2To76z4NP4Bnf8ha0KGcQGDnWE3RRmop6+AZB9EtQLh1vX51u4hovgm59dZNZ
	 vWYKfN2QwEUR9BPHWktj4joBHAJENr7PzCR+h81zuXVXgoFpBYsv9NipaPJhG4vWnZ
	 tiaU8lhyAUz2h/J5/SgbTnTv/AJprdOo1nw7wBBUCVJ1mBjsvrHiPVVYvgnn+VOczk
	 FEv7NJoBg7dbQ==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>,
	Gang Yan <yangang@kylinos.cn>
Subject: [RFC mptcp-next v4 08/10] mptcp: enable TLS setsockopt
Date: Fri, 12 Dec 2025 10:27:18 +0800
Message-ID: <03bbe5c5fa031651f0796c30f3c64a74083d8a7f.1765505775.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <cover.1765505775.git.tanggeliang@kylinos.cn>
References: <cover.1765505775.git.tanggeliang@kylinos.cn>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Geliang Tang <tanggeliang@kylinos.cn>

This patch adds MPTCP TLS setsockopt support. It allows setting the TCP_ULP
option to 'tls' exclusively, and enables configuration of the TLS_TX and
TLS_RX options at the SOL_TLS level.

This option cannot be set when the socket is in CLOSE or LISTEN state.

Co-developed-by: Gang Yan <yangang@kylinos.cn>
Signed-off-by: Gang Yan <yangang@kylinos.cn>
Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
---
 net/mptcp/sockopt.c | 18 +++++++++++++++++-
 1 file changed, 17 insertions(+), 1 deletion(-)

diff --git a/net/mptcp/sockopt.c b/net/mptcp/sockopt.c
index f3db4f2e8f81..52ff75702404 100644
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
 
@@ -819,11 +828,18 @@ static int mptcp_setsockopt_sol_tcp(struct mptcp_sock *msk, int optname,
 				    sockptr_t optval, unsigned int optlen)
 {
 	struct sock *sk = (void *)msk;
+	char ulp[4] = "";
 	int ret, val;
 
 	switch (optname) {
 	case TCP_ULP:
-		return -EOPNOTSUPP;
+		if (copy_from_user(ulp, optval.user, 4))
+			return -EFAULT;
+		if (strcmp(ulp, "tls\0"))
+			return -EOPNOTSUPP;
+		if ((1 << sk->sk_state) & (TCPF_CLOSE | TCPF_LISTEN))
+			return -EINVAL;
+		return tcp_setsockopt(sk, SOL_TCP, optname, optval, optlen);
 	case TCP_CONGESTION:
 		return mptcp_setsockopt_sol_tcp_congestion(msk, optval, optlen);
 	case TCP_DEFER_ACCEPT:
-- 
2.51.0

