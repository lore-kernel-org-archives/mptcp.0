Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 118403E8351
	for <mptcp@lists.linux.dev>; Tue, 19 May 2026 21:25:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779225930; cv=none; b=sYXqIGk131PqRMoPNZoEet4RJvKS/Kd3UhCESxvD88sGghERlUy7dzmih8BpJQ6LJlIwDP50UZyhr9U4W0qdKO//k6/CRaRchkB6R6Gk/XysO4hv8PaM3y0vJGETQnt6KlwgFheC/w7XoxNkoT0vmZympbUrax/5KN1gZLYTOcw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779225930; c=relaxed/simple;
	bh=MRA/5S+yfCdHDYlhXMI4SHgvPdtDpzOdulmVjTbIzQ4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=lIEGqgK0ZyUmt5VwncA31tFGkQpE9e6wL4NGBjf/jx8jhrOjIKj87+uDXnoX5QPRC9lbT6N3Uk8VrGjWRE9vAkOnKK6xAqTsi12niQ8m1bx2KSUstQSDiXJtM4H4u0EJCRPNdWr/Y504HRQj2ttomnvzRwhim9mlzns8kNUIsII=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VD5xwwEF; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VD5xwwEF"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D45361F000E9;
	Tue, 19 May 2026 21:25:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779225928;
	bh=/6eHH2Op8TmbbJIG2liZr4Hv+XSnAUtmEUnowncPPK8=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=VD5xwwEF8n6/tTEYuDDnqdFzeMLcJfPbXTCIQMjnjkk/epnzH513xPwT+1VdgUqd0
	 SMaLf7KMpDPKrrro6bxvYN0XU5ZvQzBCADUcTX1nK1kbH5u48IpAAVMmWX14yfa/x4
	 7JUcK9b3qvnIGDHpTxaIPSHsiw8LyxPAZC9MvGNHE0VgSVcoTW77VcGv0jGSuY34gF
	 W6h5CURKYaK3YLjKXi3J2E6FZtZOumrahiI8shKtZVcewwk5x2Es3KbUkwDUwT+xBD
	 TH7FqMYSdipbC75uRONGdlDp6LCHnD5W1QH4TgjsVp4M0LIJeb6x62KLKrET+uuRfS
	 tJZgu5hp/WBCA==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Wed, 20 May 2026 07:25:15 +1000
Subject: [PATCH mptcp-next v3 04/16] mptcp: pm: avoid computing add_addr
 size twice
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260520-mptcp-add-addr6-port-ts-v3-4-bffa658a7678@kernel.org>
References: <20260520-mptcp-add-addr6-port-ts-v3-0-bffa658a7678@kernel.org>
In-Reply-To: <20260520-mptcp-add-addr6-port-ts-v3-0-bffa658a7678@kernel.org>
To: MPTCP Linux <mptcp@lists.linux.dev>
Cc: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=5802; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=MRA/5S+yfCdHDYlhXMI4SHgvPdtDpzOdulmVjTbIzQ4=;
 b=owEBbQKS/ZANAwAIAfa3gk9CaaBzAcsmYgBqDNVBuywOe1/GiRR9R5VveTavrxWQCJXQ62U7+
 BWROIcWVnyJAjMEAAEIAB0WIQToy4X3aHcFem4n93r2t4JPQmmgcwUCagzVQQAKCRD2t4JPQmmg
 cxduEADb6Mje99X1WScGpl+H+HEsLdr+brrFKLhJ/tFQsVcA8mSm5FZdbOJvyS0IUEohSXdr57v
 rR/AXnAnu1EXC2JWfbo4bSDdfvyfor5fbmradbZxCz+tQjI0HSlq7YrhZX1hbMn2OgxoRYk57Rb
 qF+RC5HF8o96zcfNShPDuXfie5Rgzz+V8If+B/iq4LB/bIfesn0OxH/J3vHjeiJ/iyQa8jK2rFw
 54zjmSL5EGgoPKxkTsHRT4lYGK3vMLmHls6jNfVn6PHkGArPHTwq+Ttpksj1sonTqNMd0mAtF7/
 xyOxWvTgIwFug3nk6r1VM7VlMlz6Mz6f5zRJin04yx88kjCqKSlhTirRtioDpaoLHnaNsJnQVdy
 YL5zyLbpGKK0HMrpqmfkF8Ya0Ob6FsK6BPKw+Ru82ZcFkxvVF13/DVWp2KUHDSh0m5pWu0BY9Qk
 V2OX0hKfUoNOTYw0TN5ZS5Bv/LNyz+s6oarXcdqmdSvQyJ7rY7KAywQzoicCc9XohNM6WRyM8aF
 pNSb3vr1MRt2BEhVVByOHVCNootE57UkHJAXLiRtzn2vpcKifeTdIuR23DKMwyOBnjBvYPMzsIG
 PE8fb4VPQ/MX6wu2NlNT/Fw9RZJa40073GIPzJ2NufhlVPWOwwWfVgJbtARH53ZqIO0p/ZNl4kI
 V504jWikCHQOiIQ==
X-Developer-Key: i=matttbe@kernel.org; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

mptcp_add_addr_len helper was called twice: in mptcp_pm_add_addr_signal,
then just after in mptcp_established_options_add_addr. Both to check
the remaining space.

The second call is not needed: if there is not enough space,
mptcp_pm_add_addr_signal will return false, and the caller,
mptcp_established_options_add_addr, will do the same without re-checking
the size again. Instead, mptcp_pm_add_addr_signal can directly set the
size.

Note that the returned size can be negative when other suboptions are
dropped, e.g. to send an echo ADD_ADDR with a v4 address, and no port.

While at it, move mptcp_add_addr_len to pm.c, as it is now only used
from there, once, and use a bool for 'ret' in mptcp_pm_add_addr_signal.

Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
v2: reset size in mptcp_pm_add_addr_signal if other options are dropped.
---
 net/mptcp/options.c  | 16 +++-------------
 net/mptcp/pm.c       | 26 ++++++++++++++++++++++----
 net/mptcp/protocol.h | 17 +----------------
 3 files changed, 26 insertions(+), 33 deletions(-)

diff --git a/net/mptcp/options.c b/net/mptcp/options.c
index 231010aaf163..c6d57997110d 100644
--- a/net/mptcp/options.c
+++ b/net/mptcp/options.c
@@ -659,34 +659,25 @@ static bool mptcp_established_options_add_addr(struct sock *sk,
 	struct mptcp_subflow_context *subflow = mptcp_subflow_ctx(sk);
 	struct mptcp_sock *msk = mptcp_sk(subflow->conn);
 	bool drop_other_suboptions = false;
-	unsigned int opt_size = *size;
 	struct mptcp_addr_info addr;
 	bool echo;
-	int len;
 
 	/* add addr will strip the existing options, be sure to avoid breaking
 	 * MPC/MPJ handshakes
 	 */
 	if (!mptcp_pm_should_add_signal(msk) ||
 	    (opts->suboptions & (OPTION_MPTCP_MPJ_ACK | OPTION_MPTCP_MPC_ACK)) ||
-	    !mptcp_pm_add_addr_signal(msk, skb, opt_size, remaining, &addr,
-		    &echo, &drop_other_suboptions))
+	    !mptcp_pm_add_addr_signal(msk, skb, size, remaining, &addr, &echo,
+				      &drop_other_suboptions))
 		return false;
 
 	/*
 	 * Later on, mptcp_write_options() will enforce mutually exclusion with
 	 * DSS, bail out if such option is set and we can't drop it.
 	 */
-	if (drop_other_suboptions)
-		remaining += opt_size;
-	else if (opts->suboptions & OPTION_MPTCP_DSS)
+	if (!drop_other_suboptions && opts->suboptions & OPTION_MPTCP_DSS)
 		return false;
 
-	len = mptcp_add_addr_len(addr.family, echo, !!addr.port);
-	if (remaining < len)
-		return false;
-
-	*size = len;
 	if (drop_other_suboptions) {
 		pr_debug("drop other suboptions\n");
 		opts->suboptions = 0;
@@ -697,7 +688,6 @@ static bool mptcp_established_options_add_addr(struct sock *sk,
 		 * options
 		 */
 		opts->ahmac = 0;
-		*size -= opt_size;
 	}
 	opts->addr = addr;
 	opts->suboptions |= OPTION_MPTCP_ADD_ADDR;
diff --git a/net/mptcp/pm.c b/net/mptcp/pm.c
index e78a248414fb..07536d5ba1ab 100644
--- a/net/mptcp/pm.c
+++ b/net/mptcp/pm.c
@@ -887,14 +887,30 @@ void mptcp_pm_mp_fail_received(struct sock *sk, u64 fail_seq)
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
-			      unsigned int opt_size, unsigned int remaining,
+			      int *size, int remaining,
 			      struct mptcp_addr_info *addr, bool *echo,
 			      bool *drop_other_suboptions)
 {
 	bool skip_add_addr = false;
-	int ret = false;
+	bool ret = false;
 	u8 add_addr;
+	int len = 0;
 	u8 family;
 	bool port;
 
@@ -909,7 +925,7 @@ bool mptcp_pm_add_addr_signal(struct mptcp_sock *msk, const struct sk_buff *skb,
 	 * if any, will be carried by the 'original' TCP ack
 	 */
 	if (skb && skb_is_tcp_pure_ack(skb)) {
-		remaining += opt_size;
+		len -= *size;
 		*drop_other_suboptions = true;
 	}
 
@@ -926,7 +942,8 @@ bool mptcp_pm_add_addr_signal(struct mptcp_sock *msk, const struct sk_buff *skb,
 		family = msk->pm.local.family;
 	}
 
-	if (remaining < mptcp_add_addr_len(family, *echo, port)) {
+	len += mptcp_add_addr_len(family, *echo, port);
+	if (len > remaining) {
 		struct net *net = sock_net((struct sock *)msk);
 
 		if (!*drop_other_suboptions)
@@ -942,6 +959,7 @@ bool mptcp_pm_add_addr_signal(struct mptcp_sock *msk, const struct sk_buff *skb,
 	}
 
 	ret = true;
+	*size = len;
 
 drop_signal_mark:
 	WRITE_ONCE(msk->pm.addr_signal, add_addr);
diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
index 6f3c73ad4284..6fb5caeebc35 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -1209,23 +1209,8 @@ static inline bool mptcp_pm_is_kernel(const struct mptcp_sock *msk)
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
-			      unsigned int opt_size, unsigned int remaining,
+			      int *size, int remaining,
 			      struct mptcp_addr_info *addr, bool *echo,
 			      bool *drop_other_suboptions);
 bool mptcp_pm_rm_addr_signal(struct mptcp_sock *msk, unsigned int remaining,

-- 
2.53.0

