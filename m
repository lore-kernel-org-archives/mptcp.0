Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D7AE19D8AC
	for <mptcp@lists.linux.dev>; Fri,  1 Aug 2025 23:43:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754091787; cv=none; b=hBxF1EYzsRI/GhWmDcQBUibTtL+EcYMHqrhYCxNojLhPJIydIW9J9w5c8WN536Qhr7wt0PAToE3JKlGnM8jMGd1huTQePHs73MHiq2Ljn7KVeDppx0+WzcJZuXUUlrgUa/vcOzKtZY/iFj+nvQO3XnE3o5FhEQks6e+OYWcEe9s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754091787; c=relaxed/simple;
	bh=c9cwKbeK41U0E7n+E2ZjEEcWPo+44alPYoSfiC9gfaU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZMQ03vSq7vRYm1xQfmfyW8y3VHxfr4V5yjuCJP+zJIM+qNoSQlRbT9FWdUlWc4y3m2fVFSITX6MMXFKQ0jNFsXB+s+iTtD7+dJH9pa6EZJVVA8ekYgaqXSwtrqL7/9O30ziGeWjjYSj50HlhetLE1XtjcKaanv4ZPQ9U3CQRtFM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RDwsDUlG; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RDwsDUlG"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B5CDBC4CEEB;
	Fri,  1 Aug 2025 23:43:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1754091786;
	bh=c9cwKbeK41U0E7n+E2ZjEEcWPo+44alPYoSfiC9gfaU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=RDwsDUlGreuNtEdjxLZCM3ndXxdZZsXKpBMzvxD/jQznhxKA+H9V7OHUHISHHNO+P
	 BvxGvvkF6gw2Bb5i+q2e0Rpwhj30G2qzFt/df/6kCR+CFZxtjmEkZzh0mE8TwWroKr
	 wQEU6+qUC+r3SxX/9HM63y5Q9Y7AQ8qPn0LNDrLciNTusMKB4tq6Xa9rkmvw7d3Sjc
	 PoAekttXpbfuGnzLtZ8XckrV6s71Mq063Jdbmb/6SWKBLwzBt/FNb1Fo2YUL0JNfRM
	 WFdCBL9XI5D/oNvHZfF1COrVKs64HoE3TwB+8YuDcJfosUB8kx9cAMTN3g+qoavlxN
	 +zP8C7q9O/z0g==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next v3 2/2] mptcp: setsockopt support for TCP_MD5SIG
Date: Sat,  2 Aug 2025 07:42:56 +0800
Message-ID: <8bba29599d026ff96f5b4d5aaf90f087137fc578.1754091681.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <cover.1754091681.git.tanggeliang@kylinos.cn>
References: <cover.1754091681.git.tanggeliang@kylinos.cn>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Geliang Tang <tanggeliang@kylinos.cn>

Supporting TCP_MD5 socket option is required when MPTCP is used by
default when creating a socket, to keep the same behaviour as with
TCP. TCP_MD5 is not compatible with MPTCP, and it will cause a
fallback to TCP at the connection request, if MPTCP was requested.
This then fixes a "regression" compared to TCP.

This patch adds setsockopt support for TCP_MD5SIG and TCP_MD5SIG_EXT
options. The implementation:
 - Allow setting these options (getsockopt remains unsupported)
 - Apply them only to the first subflow
 - Trigger fallback to TCP to maintain MD5 compatibility

Note that getsockopt for these options remains unsupported, consistent
with TCP.

Closes: https://github.com/multipath-tcp/mptcp_net-next/issues/575
Fixes: d9e4c1291810 ("mptcp: only admit explicitly supported sockopt")
Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
---
 net/mptcp/sockopt.c | 19 +++++++++++++++++--
 1 file changed, 17 insertions(+), 2 deletions(-)

diff --git a/net/mptcp/sockopt.c b/net/mptcp/sockopt.c
index 006849741813..4dec3c372772 100644
--- a/net/mptcp/sockopt.c
+++ b/net/mptcp/sockopt.c
@@ -13,6 +13,7 @@
 #include <net/tcp.h>
 #include <net/mptcp.h>
 #include "protocol.h"
+#include "mib.h"
 
 #define MIN_INFO_OPTLEN_SIZE		16
 #define MIN_FULL_INFO_OPTLEN_SIZE	40
@@ -596,11 +597,12 @@ static bool mptcp_supported_sockopt(int level, int optname)
 		case TCP_FASTOPEN_CONNECT:
 		case TCP_FASTOPEN_KEY:
 		case TCP_FASTOPEN_NO_COOKIE:
+		/* MD5 will force a fallback to TCP: OK to set while not connected */
+		case TCP_MD5SIG:
+		case TCP_MD5SIG_EXT:
 			return true;
 		}
 
-		/* TCP_MD5SIG, TCP_MD5SIG_EXT are not supported, MD5 is not compatible with MPTCP */
-
 		/* TCP_REPAIR, TCP_REPAIR_QUEUE, TCP_QUEUE_SEQ, TCP_REPAIR_OPTIONS,
 		 * TCP_REPAIR_WINDOW are not supported, better avoid this mess
 		 */
@@ -865,6 +867,19 @@ static int mptcp_setsockopt_sol_tcp(struct mptcp_sock *msk, int optname,
 	case TCP_FASTOPEN_NO_COOKIE:
 		return mptcp_setsockopt_first_sf_only(msk, SOL_TCP, optname,
 						      optval, optlen);
+#ifdef CONFIG_TCP_MD5SIG
+	case TCP_MD5SIG:
+	case TCP_MD5SIG_EXT:
+		if (!((1 << sk->sk_state) & (TCPF_CLOSE | TCPF_LISTEN)))
+			return -EINVAL;
+		ret = mptcp_setsockopt_first_sf_only(msk, SOL_TCP, optname,
+						     optval, optlen);
+		if (ret)
+			return ret;
+		if (!__mptcp_try_fallback(msk, MPTCP_MIB_MD5SIGFALLBACK))
+			return -EINVAL;
+		return 0;
+#endif
 	}
 
 	ret = mptcp_get_int_option(msk, optval, optlen, &val);
-- 
2.48.1

