Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A28493290A5
	for <mptcp@lists.linux.dev>; Mon, 18 May 2026 12:59:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779109158; cv=none; b=K7h+B6MNWJ9PXOendgrHFwGicMLn2iP/YonOqzrLwKWlgcMXB6JXH0QXuGdz8nQsDQq5rxiFaAvFk7TlXOZkrIAK9MjRFt9Ott+zChVXc0okcuh6Nl0Dw4Jp6NCmyUWssTeb0ziqigRj6EL+/YVLyk424gMfdjBvcG6fxR8WH7U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779109158; c=relaxed/simple;
	bh=J6CN+ZPouQmWWw7cjcZgaJm8veufKw97RBBHeBZH4hI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=TOzaPS+5Bd2yDYFBScdPkY/cU2S3A5esilbTd/q1h/P4uZ07jJMzVqYZ42XdaHQQuhRfb+mnIZ5X1QdXI2hbyNuk5G+qpo//FWFqSK4GmJIWP9LtCe70sYAe/ZUWZfcMuGTj+6Z5gNQWFWyfoNOt5u+lZ0d0FBtDG6Wc1M4UH88=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Tp2Wwrqx; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Tp2Wwrqx"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EF720C2BCB7;
	Mon, 18 May 2026 12:59:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1779109157;
	bh=J6CN+ZPouQmWWw7cjcZgaJm8veufKw97RBBHeBZH4hI=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=Tp2WwrqxylqT1xkFN40Jn4baB4KfWucTgHG6nVGFXBASHvewgWZtFYDURMBHd9ud6
	 +CoCITyAWMwkq4a6e0u7uFUGuuto/XSIUm+oWw+Dxh/Y8Jxyx3zKIaULUIlBCOrkLh
	 Nyh7oywT8Z3+eWOciq1bnhiPQHvpj3xEh43WMtoo5OtlJBSSmHs6CdRDoJ833l03++
	 in6IXRKBvs4bIPiG8/Puc9WXFV8fplU04Ns75iI6fz/HL43B43XqAYkltVqq6j+T9E
	 HZnklb8HX2J5o44qSl+R54Z4Ww1AQAEvl+lxffref6YzWDKW/KUFfPebwNA0fATzzp
	 Pi4YKiRAQELdw==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Mon, 18 May 2026 22:59:06 +1000
Subject: [PATCH mptcp-next 02/12] mptcp: pm: avoid computing add_addr size
 twice
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260518-mptcp-add-addr6-port-ts-v1-2-f1ca26977fcd@kernel.org>
References: <20260518-mptcp-add-addr6-port-ts-v1-0-f1ca26977fcd@kernel.org>
In-Reply-To: <20260518-mptcp-add-addr6-port-ts-v1-0-f1ca26977fcd@kernel.org>
To: MPTCP Linux <mptcp@lists.linux.dev>
Cc: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=4810; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=J6CN+ZPouQmWWw7cjcZgaJm8veufKw97RBBHeBZH4hI=;
 b=owEBbQKS/ZANAwAIAfa3gk9CaaBzAcsmYgBqCw0hAn4roTTtdmmcRsVY0pqfCgaeoMwyIFeyA
 FryIefvoLaJAjMEAAEIAB0WIQToy4X3aHcFem4n93r2t4JPQmmgcwUCagsNIQAKCRD2t4JPQmmg
 c+eOEACuaU24CdOUvOe3rm2hrZKFrs8yNmOgi/R4bNNiBlnDNBU7Zrmfjw4wLz9Z/gpnpicHkNn
 EUrwGXduQQNg9lukhO7p1+JjapCyxVnWpeEpLTTQqfVaR9k7FIEPiuGhx+ApxPpQxoborMesS6i
 mbLJuGRkF62smjQmN157WOJQODg9BW4jLFs95mQ1nv/Wq9SWX0tRJp38fuH7PjS3LEAZqkWAY6E
 2eNyheGTjkedfFuT/gKzaeMBkAAl1qxmscT1egA8mcjQmbR/AQ0joTKWhgNQfo0V3/oPxRHeMsp
 k4OJBcehh1eGs46E6zPLUW4d5UrX+pnv0hA8/Oqmsj77y7e57gKG2wdSWh6VdlAqXev2cSn41aO
 DTfo3UavvEknHqd5KHLwGlsQxGGcM9ukIiXj2mRDnwHjntfYlXXyUqtY4sf9JOnXa5YUYNs4pBF
 O9YGEalJNTqWVxERBZar1nGiwgT+bL+S4ihb91ULIP0EX2kHznqtKtpPgHgrSGwP1+7tQE3wsln
 QQZHGs/wWKwpftdeZROZfrp1mjAgYQ6DreBGysXiqu/CBJQ1ckih/QNJ2DIyKE5elLRJam9vWm9
 5o/iQvRkrT61ngOQY19D14jSIAtz+kC4QAc4leKaPwzcKBTQWt020qdjx/upyfPynNxJOK249LG
 ihxC5tKkKCHx7JA==
X-Developer-Key: i=matttbe@kernel.org; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

mptcp_add_addr_len helper was called twice: in mptcp_pm_add_addr_signal,
then just after in mptcp_established_options_add_addr(). Both to check
the remaining space.

The second call is not needed: if there is not enough space,
mptcp_pm_add_addr_signal will return false, and the caller,
mptcp_established_options_add_addr, will do the same without re-checking
the size again. Instead, mptcp_pm_add_addr_signal() can directly set the
size. Compared to before, the size will be set even if there is not
enough space, but that doesn't change anything: if there is not enough
space, the ADD_ADDR is not added, and the size parameter is not used.

While at it, move mptcp_add_addr_len() to pm.c, as it is now only used
from there, once.

Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
 net/mptcp/options.c  |  8 +-------
 net/mptcp/pm.c       | 20 ++++++++++++++++++--
 net/mptcp/protocol.h | 17 +----------------
 3 files changed, 20 insertions(+), 25 deletions(-)

diff --git a/net/mptcp/options.c b/net/mptcp/options.c
index d97205707647..6990d6171980 100644
--- a/net/mptcp/options.c
+++ b/net/mptcp/options.c
@@ -662,7 +662,6 @@ static bool mptcp_established_options_add_addr(struct sock *sk, struct sk_buff *
 	unsigned int opt_size = *size;
 	struct mptcp_addr_info addr;
 	bool echo;
-	int len;
 
 	/* add addr will strip the existing options, be sure to avoid breaking
 	 * MPC/MPJ handshakes
@@ -670,7 +669,7 @@ static bool mptcp_established_options_add_addr(struct sock *sk, struct sk_buff *
 	if (!mptcp_pm_should_add_signal(msk) ||
 	    (opts->suboptions & (OPTION_MPTCP_MPJ_ACK | OPTION_MPTCP_MPC_ACK)) ||
 	    !mptcp_pm_add_addr_signal(msk, skb, opt_size, remaining, &addr,
-		    &echo, &drop_other_suboptions))
+		    &echo, size, &drop_other_suboptions))
 		return false;
 
 	/*
@@ -682,11 +681,6 @@ static bool mptcp_established_options_add_addr(struct sock *sk, struct sk_buff *
 	else if (opts->suboptions & OPTION_MPTCP_DSS)
 		return false;
 
-	len = mptcp_add_addr_len(addr.family, echo, !!addr.port);
-	if (remaining < len)
-		return false;
-
-	*size = len;
 	if (drop_other_suboptions) {
 		pr_debug("drop other suboptions\n");
 		opts->suboptions = 0;
diff --git a/net/mptcp/pm.c b/net/mptcp/pm.c
index bd6f1b35acc5..a44b1c8acf8f 100644
--- a/net/mptcp/pm.c
+++ b/net/mptcp/pm.c
@@ -887,10 +887,25 @@ void mptcp_pm_mp_fail_received(struct sock *sk, u64 fail_seq)
 	}
 }
 
+static unsigned int mptcp_add_addr_len(int family, bool echo, bool port)
+{
+	u8 len = TCPOLEN_MPTCP_ADD_ADDR_BASE;
+
+	if (family == AF_INET6)
+		len = TCPOLEN_MPTCP_ADD_ADDR6_BASE;
+	if (!echo)
+		len += MPTCPOPT_THMAC_LEN;
+	/* account for 2 trailing 'nop' options */
+	if (port)
+		len += TCPOLEN_MPTCP_PORT_LEN + TCPOLEN_MPTCP_PORT_ALIGN;
+
+	return len;
+}
+
 bool mptcp_pm_add_addr_signal(struct mptcp_sock *msk, const struct sk_buff *skb,
 			      unsigned int opt_size, unsigned int remaining,
 			      struct mptcp_addr_info *addr, bool *echo,
-			      bool *drop_other_suboptions)
+			      unsigned int *len, bool *drop_other_suboptions)
 {
 	bool skip_add_addr = false;
 	int ret = false;
@@ -926,7 +941,8 @@ bool mptcp_pm_add_addr_signal(struct mptcp_sock *msk, const struct sk_buff *skb,
 		family = msk->pm.local.family;
 	}
 
-	if (remaining < mptcp_add_addr_len(family, *echo, port)) {
+	*len = mptcp_add_addr_len(family, *echo, port);
+	if (remaining < *len) {
 		struct net *net = sock_net((struct sock *)msk);
 
 		if (!*drop_other_suboptions)
diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
index 6f3c73ad4284..37255da6c0ed 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -1209,25 +1209,10 @@ static inline bool mptcp_pm_is_kernel(const struct mptcp_sock *msk)
 	return READ_ONCE(msk->pm.pm_type) == MPTCP_PM_TYPE_KERNEL;
 }
 
-static inline unsigned int mptcp_add_addr_len(int family, bool echo, bool port)
-{
-	u8 len = TCPOLEN_MPTCP_ADD_ADDR_BASE;
-
-	if (family == AF_INET6)
-		len = TCPOLEN_MPTCP_ADD_ADDR6_BASE;
-	if (!echo)
-		len += MPTCPOPT_THMAC_LEN;
-	/* account for 2 trailing 'nop' options */
-	if (port)
-		len += TCPOLEN_MPTCP_PORT_LEN + TCPOLEN_MPTCP_PORT_ALIGN;
-
-	return len;
-}
-
 bool mptcp_pm_add_addr_signal(struct mptcp_sock *msk, const struct sk_buff *skb,
 			      unsigned int opt_size, unsigned int remaining,
 			      struct mptcp_addr_info *addr, bool *echo,
-			      bool *drop_other_suboptions);
+			      unsigned int *len, bool *drop_other_suboptions);
 bool mptcp_pm_rm_addr_signal(struct mptcp_sock *msk, unsigned int remaining,
 			     struct mptcp_rm_list *rm_list, unsigned int *len);
 int mptcp_pm_get_local_id(struct mptcp_sock *msk, struct sock_common *skc);

-- 
2.53.0

