Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DE6919ABD8
	for <mptcp@lists.linux.dev>; Tue, 18 Nov 2025 04:02:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763438522; cv=none; b=T9OJYp6R/IK2I/1gzZgzp+5fh9HZSrwqaEVOvj9u1iOa1ZqIRoNkI+GCuPlbq2HNr6KpPQNxusehXk4PRynM9KVgaNLwqDcN8uFkM8fT74zCXuYW5OpUvLAeLjds7ahoVUFD2TFTAWPILdhBSgj4CiHBLZdvTQs9Me+eP6iVm4g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763438522; c=relaxed/simple;
	bh=W9cahuU0I7Ph94IaasA30gbJYlR40HUYX2bb/Tpkdy8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ULDJsT1ISRMeZwDX6j2vy/bBwv0dGyV2TxBeDxhEa5PSXwYgJ2adJ6HDkLuf/1flE2KSbEQ+6fVOcQ5Z0YSNTnxkrqaFhLcy4chl0+goMoe7e86NhiMv3csjl4E3JHWmI7731KQp92bWmYwJJqSheR/826/+0hgWt99Ux/r5Gzs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NwKhJPU4; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NwKhJPU4"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 350F5C116D0;
	Tue, 18 Nov 2025 04:01:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763438520;
	bh=W9cahuU0I7Ph94IaasA30gbJYlR40HUYX2bb/Tpkdy8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=NwKhJPU484UA4b73Ns5+KVJpobnTLoYcAK+BDic+JyaKTrCqeZ9y4NOimzFoGyxWb
	 HUjzwRFJpawrE0jjdJOnQFg+afhzDS8tCb8upUb+AKugfgV7xAGFuP5RLHtOXDgUkE
	 H5B05WNwUQWWPdNoLY6XwPgafnyKMpI+kGLPhQjMTRmxnnXT8eHqQ9H7fbXvoPvS5F
	 wBWT1PrtjJ23iVAaDWdJJ7TWqLJpamGfu00Jvcr4D9hTqsOFj4SnKreRYZcr0OZ+D0
	 /M/0k4FoG4jtUebeJL7MDns2HUMfcjhDyhKpYXcH1T9/qTrThRnsuzTnO314DPkhcz
	 2LkTgfq1vE2yg==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>,
	Gang Yan <yangang@kylinos.cn>
Subject: [RFC mptcp-next 06/10] mptcp: enable TLS socket options
Date: Tue, 18 Nov 2025 12:01:27 +0800
Message-ID: <56793a0ef12b64376651aefaabe67963728e8635.1763438045.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <cover.1763438045.git.tanggeliang@kylinos.cn>
References: <cover.1763438045.git.tanggeliang@kylinos.cn>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Geliang Tang <tanggeliang@kylinos.cn>

Add support for TLS-related socket options in MPTCP protocol:
- Allow TCP_ULP option with "tls" parameter
- Support TLS_TX and TLS_RX options from SOL_TLS level
- Delegate TLS option handling to underlying TCP implementation

Signed-off-by: Gang Yan <yangang@kylinos.cn>
Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
---
 net/mptcp/sockopt.c | 18 +++++++++++++++++-
 1 file changed, 17 insertions(+), 1 deletion(-)

diff --git a/net/mptcp/sockopt.c b/net/mptcp/sockopt.c
index de90a2897d2d..6a5ce43e611a 100644
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
+	char __user ulp[4] = "";
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

