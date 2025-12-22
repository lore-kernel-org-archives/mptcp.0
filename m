Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 607D217BB21
	for <mptcp@lists.linux.dev>; Mon, 22 Dec 2025 03:15:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766373343; cv=none; b=ckqwFQpmGhd4051Sqt61pG1JT4ORBSHJI5uj7waa65aM1Nz4lldVVEIokXLpGzs5hne4VP6OZI7tqD0b8Uk0ghQGAHH7KoTN1LMcT/HCYy3hmCIbi6o2ml0I5Aflch5O+sHzNIJ6W5Q6iipope+syKJiPwruolGlsn07ZiHcyi4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766373343; c=relaxed/simple;
	bh=6ZzMq5fEP+2fejvR6JisFq9v69gXPpr/NCFpMlOdGrI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RSpu+aA1UENBx1huuR5l9zyYBBJmqJVIdb0bsiPv1tBlo7CBBcspFjNIZN6WLKLWF80wRSdU4grIsdZLwZvQ4YCsF33uLH4fs6E59CZDNSdXVEin++pwd5bo8Tlx7/DXj8PgEoQZLAH4A2WHL9dx1PpemcSDEGi+eDkt+KbUpcM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Klx+KQES; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Klx+KQES"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 64B08C4CEFB;
	Mon, 22 Dec 2025 03:15:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1766373342;
	bh=6ZzMq5fEP+2fejvR6JisFq9v69gXPpr/NCFpMlOdGrI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Klx+KQESmDCpfEOrWci57EylgqkeocViskoeGjsT5bUJvJMl4JAb3mHTGZWTsyzU3
	 RjXUZEijezzc4/KHD5A/7pVMNvWBilr0w1MpAVgK7mW5xMrd8HMQI+94y5isiHPT3J
	 5sXSfgmX0Vqu1irozV/8OIiODjI8NX4QO+0CzLRJHSsANkCqU1Lcyw9/XPdrMXxdkv
	 Es5dCnJtRgfHgLtA2+H78PAFPe35Vz+pBzqPqSphbHj/FtJacOOW+iPv/sv39dh92D
	 FlHU+YTKhC0XFbaTshpRNy18l9VXWIg1a/vePf3D874dcMsC2ig9168Mklx+OF9V2g
	 jmaDDYqiDqQmA==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>,
	Gang Yan <yangang@kylinos.cn>
Subject: [RFC mptcp-next v5 4/8] mptcp: enable TLS setsockopt
Date: Mon, 22 Dec 2025 11:15:23 +0800
Message-ID: <3aa05cc662d7874088c23e958d846116a6e4195b.1766372799.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <cover.1766372799.git.tanggeliang@kylinos.cn>
References: <cover.1766372799.git.tanggeliang@kylinos.cn>
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
index 4f805b99742e..62e3f18ba46e 100644
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
+			return -ENOTCONN;
+		return tcp_setsockopt(sk, SOL_TCP, optname, optval, optlen);
 	case TCP_CONGESTION:
 		return mptcp_setsockopt_sol_tcp_congestion(msk, optval, optlen);
 	case TCP_DEFER_ACCEPT:
-- 
2.51.0

