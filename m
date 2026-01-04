Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE602248F47
	for <mptcp@lists.linux.dev>; Sun,  4 Jan 2026 09:35:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767519330; cv=none; b=hQhJE5FOGUMxOELd9OWJeWZVNr2/EWgDxGpu21NeBE5VxmnIQBJNC7reHITTvFG9BCI1rntq46nlAMk29BtzF/7rxfodAnBFoI7V+vwPt9hQyT+EDkc6uSkfTUnc7/EOxM1vSPkQPET59fSzEIDW/ELJBXwBBFAN6VdJqA86/zA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767519330; c=relaxed/simple;
	bh=uWL3fO1iDoOzolqOJnBXMAGcRaBP1c1QBpJbhFJbSfg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Ol77R18vlRQkLQsUxcS5FCXJoB3I8d2VsjintCyg5czN1hBOYVjss7DyoIIeFpsEz8M9tvbcBdm8uvQ3sLvS0IVAkLBCMArZ7nBTm1acFOalkiwE3dyRdKupjLQ2hIuTJApoVY5Z+msocFI3nm0KduUycbs33AtqAm5vY0eRgaM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=r1jW/aIe; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="r1jW/aIe"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4B910C4CEF7;
	Sun,  4 Jan 2026 09:35:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767519330;
	bh=uWL3fO1iDoOzolqOJnBXMAGcRaBP1c1QBpJbhFJbSfg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=r1jW/aIeTOeUj9QNmqLoy9yGbB43txlYHq5McSk2ejcr7c0WHRXSaSzqw8O0yFqOT
	 cejpQoJbEnVyKaQ8EPmcx1IzFfVKUOWrMpUyBwAN/oiINNCtrtwtN5H4Conqo9r/04
	 vczKwRGumX3nkV/jd91ESt/oiqNYGbA43nZX6/7ws/pbzUpOCDvSNxydgZ0eZ35UKB
	 GNgAXqpTBp0iPSn/49rNkqNxmFg0dhFLpsROzscTWOFD49y/2Jb5NmHvILhpX1TEr5
	 1g/U+xbs61WfoN/PUmySqobIXuEhgzigQHSKsnqP38Nyx26OTRe2GNl3eDfv514pUk
	 cbDpzIujLbIpA==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>,
	Gang Yan <yangang@kylinos.cn>
Subject: [RFC mptcp-next v6 07/10] mptcp: enable TLS setsockopt
Date: Sun,  4 Jan 2026 17:35:08 +0800
Message-ID: <fc85f7184251bc82d9fa268d399ed312e5b2b827.1767518836.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <cover.1767518836.git.tanggeliang@kylinos.cn>
References: <cover.1767518836.git.tanggeliang@kylinos.cn>
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
 net/mptcp/sockopt.c | 24 +++++++++++++++++++++++-
 1 file changed, 23 insertions(+), 1 deletion(-)

diff --git a/net/mptcp/sockopt.c b/net/mptcp/sockopt.c
index a6230f7910fd..c0c95c405b43 100644
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
 
@@ -815,6 +824,19 @@ static int mptcp_setsockopt_all_sf(struct mptcp_sock *msk, int level,
 	return ret;
 }
 
+static int mptcp_setsockopt_tcp_ulp(struct sock *sk, sockptr_t optval, unsigned int optlen)
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
@@ -823,7 +845,7 @@ static int mptcp_setsockopt_sol_tcp(struct mptcp_sock *msk, int optname,
 
 	switch (optname) {
 	case TCP_ULP:
-		return -EOPNOTSUPP;
+		return mptcp_setsockopt_tcp_ulp(sk, optval, optlen);
 	case TCP_CONGESTION:
 		return mptcp_setsockopt_sol_tcp_congestion(msk, optval, optlen);
 	case TCP_DEFER_ACCEPT:
-- 
2.51.0

