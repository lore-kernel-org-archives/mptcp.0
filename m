Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 310AD38FA3
	for <mptcp@lists.linux.dev>; Sun, 10 Aug 2025 15:03:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754838198; cv=none; b=gDITtMbWf6u73nUBtGbwZhUMQ63XxeOj8xRbu5bl+GpBAiysVFiH3CcNqSPruZSpbsiSboekWT1NaUx9ot2HnQxXuV1DZkYXR4POBlXgialvrko07oVPTT1DY0TsitwmtoYcRi6I115b7LHKkY3Zf/aWYpVIaLpip5PwYDqtZWE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754838198; c=relaxed/simple;
	bh=G2PzOok5Ha2pjUTO/O8vmuTQP8A713vYzYLr46WqtLE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=i+KkALCG9baR1lpMKv7xCPLatJUCNlZ6YFB20aTQYG6ia5v43JWVSqEwdOWS34DvW9kUV9gVlN0vcVdh9xqHyzik7uAHheT9wel/MN9wgCNJyYQlPhaIwZQuCa0hap8DqYQvuRVpQ+qoz2nRk8eshEjpExXAF685kVCckuZPwSo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=n0BOLaR0; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="n0BOLaR0"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4C63CC4CEEB;
	Sun, 10 Aug 2025 15:03:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1754838196;
	bh=G2PzOok5Ha2pjUTO/O8vmuTQP8A713vYzYLr46WqtLE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=n0BOLaR0nKtzyptZ+Qn0cYdz/5D2zTE17E1qFla2TX0cFQMyOGiNAEin9HTZSlC1F
	 5rJM88rolRYPulPv1vLOXBpNFnUsTND7xdX6Pirp6/yCnYKkVEOGfPdpEh7rpIrhzA
	 SjPNUsQrhupWeRFtf9mFmYJaW23m57zL8Zz8kbU2NNlaKZ2WWUvhqWn71cKVtSvx1d
	 FcBePA0z6v58rinGXIXD0i9dHEUUk210VHLzSdbcPHzqQe2BUK+QManDXPzPBmfuhp
	 PxxspSkml5VODZVO6yr9fE+ItgwbmEkpa+RkXAnWmp7Ix7HUVBRfVgF95XDbMLeWP8
	 DwRLXKLtSbMhA==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next v5 2/8] mptcp: setsockopt support for TCP_MD5SIG
Date: Sun, 10 Aug 2025 23:02:21 +0800
Message-ID: <46161eda1da80e0525986aa9aed8e024b39b6850.1754837808.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <cover.1754837808.git.tanggeliang@kylinos.cn>
References: <cover.1754837808.git.tanggeliang@kylinos.cn>
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
 - Check if fallback has already occurred in subflow_check_req(). If so,
return immediately

Note that getsockopt for these options remains unsupported, consistent
with TCP.

Closes: https://github.com/multipath-tcp/mptcp_net-next/issues/575
Fixes: d9e4c1291810 ("mptcp: only admit explicitly supported sockopt")
Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
---
 net/mptcp/sockopt.c | 14 ++++++++++++--
 net/mptcp/subflow.c |  3 +++
 2 files changed, 15 insertions(+), 2 deletions(-)

diff --git a/net/mptcp/sockopt.c b/net/mptcp/sockopt.c
index b264185b810d..f2f0b475c8d6 100644
--- a/net/mptcp/sockopt.c
+++ b/net/mptcp/sockopt.c
@@ -13,6 +13,7 @@
 #include <net/tcp.h>
 #include <net/mptcp.h>
 #include "protocol.h"
+#include "mib.h"
 
 #define MIN_INFO_OPTLEN_SIZE		16
 #define MIN_FULL_INFO_OPTLEN_SIZE	40
@@ -567,11 +568,12 @@ static bool mptcp_supported_sockopt(int level, int optname)
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
@@ -836,6 +838,14 @@ static int mptcp_setsockopt_sol_tcp(struct mptcp_sock *msk, int optname,
 	case TCP_FASTOPEN_NO_COOKIE:
 		return mptcp_setsockopt_first_sf_only(msk, SOL_TCP, optname,
 						      optval, optlen);
+	case TCP_MD5SIG:
+	case TCP_MD5SIG_EXT:
+		ret = mptcp_setsockopt_first_sf_only(msk, SOL_TCP, optname,
+						     optval, optlen);
+		if (ret == 0)
+			WARN_ON_ONCE(!__mptcp_try_fallback(msk,
+							   MPTCP_MIB_MD5SIGFALLBACK));
+		return ret;
 	}
 
 	ret = mptcp_get_int_option(msk, optval, optlen, &val);
diff --git a/net/mptcp/subflow.c b/net/mptcp/subflow.c
index 3f1b62a9fe88..3c8bbd5d8bf5 100644
--- a/net/mptcp/subflow.c
+++ b/net/mptcp/subflow.c
@@ -155,6 +155,9 @@ static int subflow_check_req(struct request_sock *req,
 
 	pr_debug("subflow_req=%p, listener=%p\n", subflow_req, listener);
 
+	if (__mptcp_check_fallback(mptcp_sk(listener->conn)))
+		return 0;
+
 #ifdef CONFIG_TCP_MD5SIG
 	/* no MPTCP if MD5SIG is enabled on this socket or we may run out of
 	 * TCP option space.
-- 
2.48.1

