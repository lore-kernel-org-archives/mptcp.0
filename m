Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4365F3346A6
	for <mptcp@lists.linux.dev>; Wed, 19 Nov 2025 10:05:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763546733; cv=none; b=Jv89IYhzGQae2UWet/94XVfkCV4A3BL+bIUFxjwXPeslp+IAqfOMQfj8DwM02vILHIQ9Ktpe9e9UAFgH+Q2U+lQSZvZM2Rj3fZGH4TkOQojJXd76zC9oDjkhKIUB57cboRIenajaBQ3ANyEZ8/ntxdrgXlhMkP5QWa4tET9yvEw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763546733; c=relaxed/simple;
	bh=wI41m9xxWX7xZoCdF0d8Q5gacVsSsY3DvlvG83+6MQo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=L1Gut50Vm1lU1agtmOZiEoYbqAyWIWLlMZEqDZiypAVIhhW6vtoaw7mlREflAMclu4mBtNT5X/jiyOnhFlV0DySnltWFR/zk3paxRK3kiXVKnEW64rGUtd063RJf9f+vPAPiRWAYOvS+heE/DTFNmZS8pZybBt5eXA4s28CqfD4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HETb3KkF; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HETb3KkF"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 06844C2BC87;
	Wed, 19 Nov 2025 10:05:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763546733;
	bh=wI41m9xxWX7xZoCdF0d8Q5gacVsSsY3DvlvG83+6MQo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=HETb3KkFHDUi6cIKVsnH2Nr2nx89cMy094sNb+sbOtrHU+lU3Fqx7u9rNier04JM3
	 MA0YxpijkY2XiszUCGKrZKUQ/kZxc8l6C7p3E7l1oJR8Colqt8d3MCtaJl8FFY0YzU
	 l4omZv5e4+Y2GU4ON38fOk+Ivs3B2oynhGo8lvlKzlHcmHvCj+AP/7CY+UeCHbSSmF
	 y5FnHrwoo8q4FIY45fsZuH2CZYofoSHRbTccdeFLAlqPcGkQ9rl8OU3S1OjkccNH4Z
	 KfeEsaI1K0oBcbNezKThIKmseui6u7R6d1umF/5eRlhORZkQwG8arRmMCrLE7yi1f9
	 v2BYAk26S9Z2g==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev,
	hare@kernel.org,
	hare@suse.com
Cc: Geliang Tang <tanggeliang@kylinos.cn>,
	Gang Yan <yangang@kylinos.cn>
Subject: [RFC mptcp-next v2 2/8] mptcp: enable TLS setsockopt
Date: Wed, 19 Nov 2025 18:05:01 +0800
Message-ID: <7332355ce3ab08926cc4c18a12ff7daed239cff5.1763546473.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <cover.1763546473.git.tanggeliang@kylinos.cn>
References: <cover.1763546473.git.tanggeliang@kylinos.cn>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Geliang Tang <tanggeliang@kylinos.cn>

Add support for TLS-related socket options in MPTCP protocol:

- Allow TCP_ULP option with "tls" parameter;
- Support TLS_TX and TLS_RX options from SOL_TLS level;
- Delegate TLS option handling to underlying TCP implementation.

Signed-off-by: Gang Yan <yangang@kylinos.cn>
Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
---
 net/mptcp/sockopt.c | 18 +++++++++++++++++-
 1 file changed, 17 insertions(+), 1 deletion(-)

diff --git a/net/mptcp/sockopt.c b/net/mptcp/sockopt.c
index de90a2897d2d..54ad674da151 100644
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

