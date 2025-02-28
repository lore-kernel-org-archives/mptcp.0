Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6EB914A91
	for <mptcp@lists.linux.dev>; Fri, 28 Feb 2025 13:31:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740749513; cv=none; b=YkEPMic6D4mgXkuAp11z7Fo5oc+R9I4aoZODOlPPJe0bO2BYmN/AvO5ynmjRVbZ83bwopL8oOSLUCxU/VJX0JCS5cblcEnua6LCcu0o9+X2aHLnUl5PflGj0W0qzgVEc8XGRuHLIjuPzUioZ9QvR7eTJofcIOBqTjnu4/vSKpcs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740749513; c=relaxed/simple;
	bh=nALcNyoZo1hooQw6fHjLHuK2PlwFBU3OlmEKa/btHHE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=kfXuBwlitdSdRNOEhT4IlK6US7HKrfmZADL5ZiwoW6LwmelLFhbyX8DGHkQaPkeXpDW1VR7cfPC4UVtpddUwKuwVYKjUS9LAgvzRHHVOFH1zecKFvRams+IPeGDOOcXy3vpICBQkG/vhPxTt4iTigewmjWvaejRjg2LdTnPN+OY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JueCb2Jc; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JueCb2Jc"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E576EC4CEE2;
	Fri, 28 Feb 2025 13:31:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740749513;
	bh=nALcNyoZo1hooQw6fHjLHuK2PlwFBU3OlmEKa/btHHE=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=JueCb2JcqhMs3LztbJll67Or3/UzsWXPuIaeTsBWWk4ti0g1Pc4zgZWu+pmXjcpuZ
	 LdjOtqjnC4kaUrRgai4L5WChOrFdR0Seu1TsZHLuI6S7DMp+i70hOx//teWnMbuvYm
	 iWsGLg0mIUNTDi1nwG4TiVMVoIPxWn9rT0wulkJIm0FT6tWGb4Zl4V4rgwnzYViivX
	 m3OWRolB2IqvGiH01K23rFXfHglXTDol2rzOdjST739z/TXJmMILH3Zdgiw0XrPWXU
	 +nnvYMdS6ZkVmo9vjDpiZCEV8KJuv2GYXPUeOXy3CJMcaA2xDZ0l8ZGRytAqgEO8sR
	 hsT2nXrGEJVtA==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Fri, 28 Feb 2025 14:31:31 +0100
Subject: [PATCH mptcp-next v2 11/14] mptcp: pm: move generic helper at the
 top
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250228-mptcp-pm-reorg-code-v2-11-fa8b2542b7a5@kernel.org>
References: <20250228-mptcp-pm-reorg-code-v2-0-fa8b2542b7a5@kernel.org>
In-Reply-To: <20250228-mptcp-pm-reorg-code-v2-0-fa8b2542b7a5@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliang@kernel.org>, 
 "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=2810; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=nALcNyoZo1hooQw6fHjLHuK2PlwFBU3OlmEKa/btHHE=;
 b=owEBbQKS/ZANAwAIAfa3gk9CaaBzAcsmYgBnwbq6snD3JJZXqYASajuwkkhBPP5zRqxu2CGh/
 fyobhsRIQGJAjMEAAEIAB0WIQToy4X3aHcFem4n93r2t4JPQmmgcwUCZ8G6ugAKCRD2t4JPQmmg
 c/XPEACLrcQZFY6+4DOXYYjc5Oj8k45Oi+d0U/7DVmonWVzppmh+/wY8XX4dSTGeqzt0oo83uBy
 LXrmMz9ps63gxvq4rgLuLxhAypRRxSGHlhe9gEPRU7IDyQEnIIr+3TY7xxBr18RN0v9xlnCCf6E
 HtzhlbwivGvUAIcVJJdFmF4w4xYBAZP8qVlCUqQyeVNrPwgb/7t2+ZTz3yQKgjjIz3V8lNYZPih
 95eeAsubzi7OmAzwxngOSLiThvQo8C+tGY66EscX164G8a6sC1wIPCDaN3wQRavvKitaH3H2+6y
 N+OOYnlPwylkDtIMQvOER+yZy642LziqFZeVwgAiVpmr+X0aSTkSKACQFKhPMJ5/zFOIDjdn9MR
 unTa5X1CYUA8sqN8YR7PYIqsSGOKYYffK8qmbEi3PQ0MIolQkFzWJuEhNcu5aGVABFjGOLuoDjQ
 6dJKTFIcv4Fiy4LhpZUrGPI6UGPZWtMZw8r4I/UHEOMDejKDfCVa5Z9H20sPoqbniCz1YOh5ANS
 Jxc0JKQgacVqTn/f3Qdoa9yUMcy5z24+PiE3DNWbY7L+jqi023DytBEZh30Ul65eK7FN/o0abVc
 4cqKf5Tce4jtO4yz2ysTMRfmNXDoVpjrpEGcJUoRDMBuYjRDntlJFV2cSz2FzCjaoEO17iJS/dD
 JHIb0Rw7YwZy7tg==
X-Developer-Key: i=matttbe@kernel.org; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

In prevision to another change importing all generic PM helpers from
pm_netlink.c to there.

Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
 net/mptcp/pm.c | 54 +++++++++++++++++++++++++++---------------------------
 1 file changed, 27 insertions(+), 27 deletions(-)

diff --git a/net/mptcp/pm.c b/net/mptcp/pm.c
index ddf9d0dc6274535b7d061c0c3b3258ec7dc7576c..cd50c5a0c78e83acd469050e177d6ee551f20f61 100644
--- a/net/mptcp/pm.c
+++ b/net/mptcp/pm.c
@@ -12,6 +12,33 @@
 #include "mib.h"
 #include "mptcp_pm_gen.h"
 
+/* path manager helpers */
+
+/* if sk is ipv4 or ipv6_only allows only same-family local and remote addresses,
+ * otherwise allow any matching local/remote pair
+ */
+bool mptcp_pm_addr_families_match(const struct sock *sk,
+				  const struct mptcp_addr_info *loc,
+				  const struct mptcp_addr_info *rem)
+{
+	bool mptcp_is_v4 = sk->sk_family == AF_INET;
+
+#if IS_ENABLED(CONFIG_MPTCP_IPV6)
+	bool loc_is_v4 = loc->family == AF_INET || ipv6_addr_v4mapped(&loc->addr6);
+	bool rem_is_v4 = rem->family == AF_INET || ipv6_addr_v4mapped(&rem->addr6);
+
+	if (mptcp_is_v4)
+		return loc_is_v4 && rem_is_v4;
+
+	if (ipv6_only_sock(sk))
+		return !loc_is_v4 && !rem_is_v4;
+
+	return loc_is_v4 == rem_is_v4;
+#else
+	return mptcp_is_v4 && loc->family == AF_INET && rem->family == AF_INET;
+#endif
+}
+
 /* path manager command handlers */
 
 int mptcp_pm_announce_addr(struct mptcp_sock *msk,
@@ -325,8 +352,6 @@ void mptcp_pm_mp_fail_received(struct sock *sk, u64 fail_seq)
 	}
 }
 
-/* path manager helpers */
-
 bool mptcp_pm_add_addr_signal(struct mptcp_sock *msk, const struct sk_buff *skb,
 			      unsigned int opt_size, unsigned int remaining,
 			      struct mptcp_addr_info *addr, bool *echo,
@@ -574,31 +599,6 @@ void mptcp_pm_subflow_chk_stale(const struct mptcp_sock *msk, struct sock *ssk)
 	}
 }
 
-/* if sk is ipv4 or ipv6_only allows only same-family local and remote addresses,
- * otherwise allow any matching local/remote pair
- */
-bool mptcp_pm_addr_families_match(const struct sock *sk,
-				  const struct mptcp_addr_info *loc,
-				  const struct mptcp_addr_info *rem)
-{
-	bool mptcp_is_v4 = sk->sk_family == AF_INET;
-
-#if IS_ENABLED(CONFIG_MPTCP_IPV6)
-	bool loc_is_v4 = loc->family == AF_INET || ipv6_addr_v4mapped(&loc->addr6);
-	bool rem_is_v4 = rem->family == AF_INET || ipv6_addr_v4mapped(&rem->addr6);
-
-	if (mptcp_is_v4)
-		return loc_is_v4 && rem_is_v4;
-
-	if (ipv6_only_sock(sk))
-		return !loc_is_v4 && !rem_is_v4;
-
-	return loc_is_v4 == rem_is_v4;
-#else
-	return mptcp_is_v4 && loc->family == AF_INET && rem->family == AF_INET;
-#endif
-}
-
 void mptcp_pm_worker(struct mptcp_sock *msk)
 {
 	struct mptcp_pm_data *pm = &msk->pm;

-- 
2.47.1

