Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 636AE2FE594
	for <mptcp@lists.linux.dev>; Wed,  5 Nov 2025 09:29:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762334981; cv=none; b=cK+IePyVxPunkyElfmB3Co6anQnnEWbpA+ruvrNf+KgGBRvrQxkgY4Aneqd9yBHbAGt8Ks5pECgB56zKcVXARGa4DUbjpU1DGZ2jVgQfxmEPW6NFlGG40qihQEwfaqKtUfSiivJY56MJPmUShGoH04bduEQ5t+Lo6OOWghTp0yI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762334981; c=relaxed/simple;
	bh=naOkNDf8EvSxnlW0eJXzyLXgbjn/c3yEGbbtpGn6Ap0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LLIDq+IhEyP/+XoDFbGPfPLh4tjWdK3qF6hnrbIgCaPdCqk/zgev+FUFdIsW0K8t5c6tA3EmMTbvRgBeRrghuHhdUfSx1hyRyLgWIye5GYuBDZaPWzBCBeKwSeJniXxQNLFwRMCk1KeWOZcOa3l4ukarUYCGhxtABpyAapnrheE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dQcu2q8m; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dQcu2q8m"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D6183C4CEF8;
	Wed,  5 Nov 2025 09:29:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762334981;
	bh=naOkNDf8EvSxnlW0eJXzyLXgbjn/c3yEGbbtpGn6Ap0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=dQcu2q8mbFszthpj33uOk7QdaTulNHWGbEjMjjx8nV9dt5L0qmbi3UAcJJvVhVGgH
	 Liv/ztoAzkgetGeAPu9ykInCqptzAE3oyWNzTGRxMsST/UGMSsZq5yglVFcdZYwJG6
	 4CLBVNhtFODSkm3XmdWlUjig4ff56H2bOPOQbThu5NOG3tVRx6R1O8ESIuIYGOnbVx
	 g92nPYbApJ4O2qU84uuSsdB9w/ZXIJDDiRpNN/Abm8LjQb2WqgtaBmI5A5zw/CnNzE
	 9qTLcbioML3+4UfhrDNR5Wc/oNv+C0+JaCz1R3NqdJJZvnQoYNt/SNPVyd2kJ2vnTp
	 zDmoza8Ag5XIg==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next v6 3/7] mptcp: setsockopt support for TCP_MD5SIG
Date: Wed,  5 Nov 2025 17:29:26 +0800
Message-ID: <9e4d438d9e8c4f2babec5d44854d9c0b1c7ef3fa.1762334694.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1762334694.git.tanggeliang@kylinos.cn>
References: <cover.1762334694.git.tanggeliang@kylinos.cn>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Geliang Tang <tanggeliang@kylinos.cn>

Add setsockopt support for TCP_MD5SIG and TCP_MD5SIG_EXT. These options
force fallback to TCP to maintain MD5 compatibility. Apply them only to
the first subflow.

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
index e2d1b4b6b3b2..a3efaf5db256 100644
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
index 7eef4aaf78e2..5e29eee72656 100644
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
2.43.0

