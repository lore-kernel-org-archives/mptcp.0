Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82A511AA7A6
	for <mptcp@lists.linux.dev>; Sat, 22 Nov 2025 08:45:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763801142; cv=none; b=qcLbeBw9kerhkq+2zA6gdIavy5s23SMuCkBy74jnPPRwgAo52ADL0REVVtDYAs3TOEQcAEsAX7LGbL2i+IFdry2xzryUCeWxftMRTI6dpQUhd7iwmG0eB5vyuUdiDLogDJ7WpuUgQ1LyqRM8WC0wkjGa0f0m7InyakxnS0I6024=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763801142; c=relaxed/simple;
	bh=oq0zKgX05uRcbn7PAy3rOmQlIOOnqg7bERQHSUE3Ymo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QJpIYf3/Y95VNexA+uzA2TkMK0EsBAv7vkgrgutPtOSm0jK+LxkVVwvLq7lSTxGfOtBAY/PS4R5C1UWHHy6d/4o/WJNAxlJkctFMYlvBpr9CjsTECyiiQ9Si7y2Lee3wKWh2vf+IpM/TnizJI7XL6Kf7Wss2U7IAJR68goB2ecQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bA4ujQY6; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bA4ujQY6"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1F28AC4CEFB;
	Sat, 22 Nov 2025 08:45:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763801142;
	bh=oq0zKgX05uRcbn7PAy3rOmQlIOOnqg7bERQHSUE3Ymo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=bA4ujQY6V2a2WempFfWuQjLF7Y10FwjW2RvwW2OUZhQ+ngR+Zzsjk9BaQDrA9VQqL
	 ch99I70CUQl6X4VA9ugRIyvjPBTDcFwkPKySgjeMGRck6fZFn6P/IoZqvP6Et9+Ka7
	 rf1DO2glYtENIFELSEwWnpYq/YJT2nDwatkBNtHaifRF2qHHbQAoFBHHi0y4NuKEF2
	 B3U815uIkTu9BKAflYIXkDXKtzBKeigvmHrW1kf5VsXWhfDatABVX2LK+VC06wwExY
	 +12Ws8ADsmBBT72JnvOubTrWf+Z3ShaD54o58ZCKzgXAwPVAWwAEQ4dYUw19YE0v9Z
	 EebB4EIRmcEfQ==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>,
	Gang Yan <yangang@kylinos.cn>
Subject: [RFC mptcp-next v3 6/8] mptcp: enable TLS setsockopt
Date: Sat, 22 Nov 2025 16:45:25 +0800
Message-ID: <968e3f9c2a71a8a7a9a7009ac9930400ccc34c64.1763800601.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <cover.1763800601.git.tanggeliang@kylinos.cn>
References: <cover.1763800601.git.tanggeliang@kylinos.cn>
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

