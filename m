Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F90B20012B
	for <mptcp@lists.linux.dev>; Sat,  2 Aug 2025 12:01:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754136116; cv=none; b=ZZqFjxD4SrRduSgTaRLGnyIOFJyPzKlzmgl4CqmSRNgl8OXC8jR1mQzXJiIODj7oEIDJhgEUtwLn0UVMq9KShp48r2QEbLPcdvyXUgByFBZN/BoHJ6t+q8LwcRpI6A+2wycTuSZGAH3QM4f2nWGOU218MnaBjtKGO9iojCzLEb4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754136116; c=relaxed/simple;
	bh=MW4lu8WWQxRrzIKY/JlFi5wNGIFrXZJy1ipiwHI4QGI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HG+rCvmVofUP1ypzxnndTRNHS0CEOOgw3n1CSoFOouK7o5O5cHGxbKKdzB7RlqVcFMb16tkFPlsiHkgDOF2SvGYjxMViKZr2atUfa6SwI6OxVklV6ceqj4Dp5ZptBRBVOmE5ItSchAQLRP9Bv/Sbpiz7NH/lTqINenrWQ8P3ezs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tN+8aG8g; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tN+8aG8g"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EEDF3C4CEEF;
	Sat,  2 Aug 2025 12:01:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1754136115;
	bh=MW4lu8WWQxRrzIKY/JlFi5wNGIFrXZJy1ipiwHI4QGI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=tN+8aG8gdX3ZyP5uaRHeSZNYO3PugxGRk9ZQaHxLvB6MnOUZEcSNsT+/GRP5MKyBC
	 e2kf3ZF4B1XndCrLLh5Q9/zs5gwjkZC//ZcFk5qJPBV6zYYzOJGdG4KMM/Pxr6IEKz
	 sg4zCPtCWNWsKf+4cgks9JrkoI14gd9HWWkgvD00hLgYNYwb/lRbOICR2zxVUoElgk
	 8LhTckWec1meh4HKh05wUBx+SPEyOkVtaBxgn9+LcdYuoKzRjXFDh0tzo+M3YK3nVI
	 Nbr4qJHQj781Djs+bS4zG4RqdrX/ivLIRWXpsAlAIanvlme+81z2F37s9+8+qpQOkq
	 H6d4Xm6AzaDOA==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next v4 2/2] mptcp: setsockopt support for TCP_MD5SIG
Date: Sat,  2 Aug 2025 20:01:45 +0800
Message-ID: <c17f538373e0489203c3ffbdb5fcb620b65a7640.1754135958.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <cover.1754135958.git.tanggeliang@kylinos.cn>
References: <cover.1754135958.git.tanggeliang@kylinos.cn>
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
 net/mptcp/sockopt.c | 14 ++++++++++++--
 1 file changed, 12 insertions(+), 2 deletions(-)

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
-- 
2.48.1

