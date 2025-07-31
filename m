Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1661829C344
	for <mptcp@lists.linux.dev>; Thu, 31 Jul 2025 07:28:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753946880; cv=none; b=NRg80R2m//bQ6p1+mIuwTvOA3jxbIZ2IiG2WLPPSTKGPbGH/KaaVOTSzDz9a+I6y2I6pOTK4STS2pk+X2NO+B4h8D5zQobdrzTXBjxwbFo8GVwj4GhX33Dg3sOf7asTArGO0Kqf3yWUkAbt1It6uQyOnECJ7Nu2evINSy5mPabw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753946880; c=relaxed/simple;
	bh=uH/A4rjgC5yNN8V6d1q0cBQ6pc0XBRtoWsVL/CAC+Cs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TrhsVKJZ9Y5VyxcbHGU1MmnD/5la7Vxwrk+gEvrGbHc6ygO2ydJcbIk8UhpZCGBXW1VBkS6XMMlIzzanZm3TP+aZe3nEN/+v/q4nCezTOm/kCvO5JAr03LjjD6IAoIDtUl8RKVybV4wb8YCzOBqNPYshha7rXXtH2juIRx6g7Yo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tdYXRPJ7; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tdYXRPJ7"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BBF3EC4CEEF;
	Thu, 31 Jul 2025 07:27:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753946880;
	bh=uH/A4rjgC5yNN8V6d1q0cBQ6pc0XBRtoWsVL/CAC+Cs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=tdYXRPJ7e3tzoscQqHOuMiblKuDIK9sH0AwywxRWjJX/xG9Zdp9iV/Rg0j/G70UL8
	 IZgTewG4EgA1f857H0Hfz8FoifdKJ3Y4Spib5yggBr0KHMML3FtEdwCwHkZw8qIrzx
	 BXfMfRydGuwQgp9z33euPOKTUyVpc7D7mbL5tIIgKKAvN2Mn2tnqNvuqylQu5DJPau
	 OYetB6xR1rIIrUPdiJ/ffssMPKjW7O9D5MqWx02Mv+J/VbOoiNLzoTgNSNrTdD/nWC
	 2QDU+3pzQuqpl7xampnmuOwSxnBQjM48IFydPzZmHSxcZb7eaMLqVEv2ZjbijCGqoX
	 b2vsW7I2TtnKg==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next v2 2/2] mptcp: setsockopt support for TCP_MD5SIG
Date: Thu, 31 Jul 2025 15:27:48 +0800
Message-ID: <291bace9364966f432580ba13121bd59677f5d3e.1753946671.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <cover.1753946671.git.tanggeliang@kylinos.cn>
References: <cover.1753946671.git.tanggeliang@kylinos.cn>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Geliang Tang <tanggeliang@kylinos.cn>

This adds setsockopt support for TCP_MD5SIG and TCP_MD5SIG_EXT options.
The implementation:
- Allows setting these options (getsockopt remains unsupported)
- Applies them only to the first subflow
- Forces fallback to TCP (since MD5 isn't compatible with MPTCP)

Setting these options triggers fallback to TCP to maintain MD5
compatibility.

Note that TCP_MD5SIG and TCP_MD5SIG_EXT are unsupported for TCP too.

Closes: https://github.com/multipath-tcp/mptcp_net-next/issues/575
Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
---
 net/mptcp/sockopt.c | 12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

diff --git a/net/mptcp/sockopt.c b/net/mptcp/sockopt.c
index b264185b810d..3ffdeca694be 100644
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
@@ -830,6 +832,12 @@ static int mptcp_setsockopt_sol_tcp(struct mptcp_sock *msk, int optname,
 		/* See tcp.c: TCP_DEFER_ACCEPT does not fail */
 		mptcp_setsockopt_first_sf_only(msk, SOL_TCP, optname, optval, optlen);
 		return 0;
+#ifdef CONFIG_TCP_MD5SIG
+	case TCP_MD5SIG:
+	case TCP_MD5SIG_EXT:
+		__mptcp_try_fallback(msk, MPTCP_MIB_MD5SIGFALLBACK);
+		fallthrough;
+#endif
 	case TCP_FASTOPEN:
 	case TCP_FASTOPEN_CONNECT:
 	case TCP_FASTOPEN_KEY:
-- 
2.48.1

