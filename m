Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B374A36D506
	for <mptcp@lists.linux.dev>; Fri, 29 May 2026 03:22:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780024930; cv=none; b=uHmMnAFsCfXg8Ko/vUrsr66AL2oiAORneA30hVOaakVlkM/HPSXU0Vs1kG0Uet1OeabaR8ZPn/VMENsNvrh3f0VWbODBA65pwCuT4KqaKvBTEWtQmUYAkfGQJubiRVndXkYozF4OxiNvcWRVDxy4mIg6zIaOpuL1ZTecxgAL9u8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780024930; c=relaxed/simple;
	bh=4KYzjII7LngqTrNcmnHgBg1pFSxsyuqSO5EiItHvIg4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Sx7+1uGONol7tGIgDvmLRA8Z2j2JV1O54oXQvZVnPcuO8bnTM/nbVrJJBStWs2M09cE/VDrkLs2EfcONqudo0E8lruTKzFwenRmTyX65MaYDOU1d8ASwXAy7k+qxxEhYUJlZdQP1x32+/Qlm/xXWmMacacU5MN04b0UY0WMIM5g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BsbpQ4gZ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BsbpQ4gZ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 99E8A1F000E9;
	Fri, 29 May 2026 03:22:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780024925;
	bh=ZaiHpqlp53GpRtbcezmr7De43YTyQn9MV0vopVhtZFA=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=BsbpQ4gZ7INfu3PNKSa8+1oRX0FDnlB9MmGSjSVQYvD1nInzJUO+yLp23JipQ7g9J
	 Y6hWoAT2EBMryqKVInt8/etgKrUVr+pgAgdQUDY0FCmPDL3EefC2x0SJ23boRbO1Pu
	 d/E8cnTqrDHJbYbc5xERATKXdQDgG8FIe+PWwcc7yQwJk9q2NKlvXlhTzL7nXTwLCw
	 mK9fVZfF+OSIez2hQm++bj68SseHhaNOmIg+Mlugnp9djC7t7r+t+LnfIOx96GcoNL
	 6bxFTKhgapFuHwj9vnfxl4w8zjfiZufqh8DCCPVGAaqN7gozN8jiAjdO8sTIbgJGaa
	 urCWFwESatT0w==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Fri, 29 May 2026 13:21:42 +1000
Subject: [PATCH mptcp-next v4 04/15] mptcp: pm: avoid computing add_addr
 size twice
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260529-mptcp-add-addr6-port-ts-v4-4-cea393fa33a2@kernel.org>
References: <20260529-mptcp-add-addr6-port-ts-v4-0-cea393fa33a2@kernel.org>
In-Reply-To: <20260529-mptcp-add-addr6-port-ts-v4-0-cea393fa33a2@kernel.org>
To: MPTCP Linux <mptcp@lists.linux.dev>
Cc: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=5869; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=4KYzjII7LngqTrNcmnHgBg1pFSxsyuqSO5EiItHvIg4=;
 b=owEBbQKS/ZANAwAIAfa3gk9CaaBzAcsmYgBqGQZWkbtujNXp+SUlApnyrClFsRWFNy4rS/VuA
 StPyizwhkeJAjMEAAEIAB0WIQToy4X3aHcFem4n93r2t4JPQmmgcwUCahkGVgAKCRD2t4JPQmmg
 c7OXD/9ctvQVU2PaYfxC8UYbMr0zKBulK7x84j3sh5SSgFzwm9a8qa4Iha7PBk6n3NO+Ai4RZW6
 Ygha25QXmO8WsU6C30JVMViUJ3CGefv2dkqkVc7L4brs/9rmbDixaX87Gg7bG18SYqLQSNdBbe/
 0xuzSiRs8rU7Us2oEXSSA46bunsW1VN9Cxoz1aGOVFIhzL/14S8cCXVa0hm2HrtJogWe1V/Uf+S
 wtF77nIHH+hfAaqpp4suXmErCU0LmkVkSF9ftIMwkWj+CBBHS05spCRsZQSCi3va7fSxLM2eFfx
 0b3EIZU+TiTo/kjRcnxRt3r3W52olnhUT1jqTRQpfjvxkmcurGXECuQ545ywonb2L8Eu0yFLESo
 IWvtHT6KcX3Vdx0EuzC6D3MaKBzFjT8hfIB5E5GRrP14dMrm+F73tuLiquRDPrqNx7NKFaBwIkg
 poZiMKSMWFzjgu4hkGDBcV8JXUOlt3ItHDyQEUGPOf3qu31S5wM21g2CcfF2EU2MkuJXP3VU/WZ
 DJpoH/xiH7egC6snsRGkzCnlCJC4YWhS9NWIYxGxzzBhBjuGcABcNub82STOhk9hyFXlCim24TD
 dnwK7eM0Guj8phcO9TaDZR0N+4p7BS3SL7fT4kaZ0jnsajn6ZFe375N8qPKC2TO/iYcOt+Sulal
 gRaE8QBnE1WrbFA==
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

While at it:

 - move mptcp_add_addr_len to pm.c, as it is now only used from there

 - use 'int' in mptcp_add_addr_len for the size, instead of having a mix

 - use a bool for 'ret' in mptcp_pm_add_addr_signal

Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
v2: reset size in mptcp_pm_add_addr_signal if other options are dropped.
---
 net/mptcp/options.c  | 16 +++-------------
 net/mptcp/pm.c       | 26 ++++++++++++++++++++++----
 net/mptcp/protocol.h | 17 +----------------
 3 files changed, 26 insertions(+), 33 deletions(-)

diff --git a/net/mptcp/options.c b/net/mptcp/options.c
index 3960c6d93177..9525b22c3db8 100644
--- a/net/mptcp/options.c
+++ b/net/mptcp/options.c
@@ -660,34 +660,25 @@ static bool mptcp_established_options_add_addr(struct sock *sk,
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
@@ -698,7 +689,6 @@ static bool mptcp_established_options_add_addr(struct sock *sk,
 		 * options
 		 */
 		opts->ahmac = 0;
-		*size -= opt_size;
 	}
 	opts->addr = addr;
 	opts->suboptions |= OPTION_MPTCP_ADD_ADDR;
diff --git a/net/mptcp/pm.c b/net/mptcp/pm.c
index 3d5dc711a866..ae6eabdc2ac1 100644
--- a/net/mptcp/pm.c
+++ b/net/mptcp/pm.c
@@ -888,14 +888,30 @@ void mptcp_pm_mp_fail_received(struct sock *sk, u64 fail_seq)
 	}
 }
 
+static int mptcp_add_addr_len(int family, bool echo, bool port)
+{
+	int len = TCPOLEN_MPTCP_ADD_ADDR_BASE;
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
 
@@ -910,7 +926,7 @@ bool mptcp_pm_add_addr_signal(struct mptcp_sock *msk, const struct sk_buff *skb,
 	 * if any, will be carried by the 'original' TCP ack
 	 */
 	if (skb && skb_is_tcp_pure_ack(skb)) {
-		remaining += opt_size;
+		len -= *size;
 		*drop_other_suboptions = true;
 	}
 
@@ -927,7 +943,8 @@ bool mptcp_pm_add_addr_signal(struct mptcp_sock *msk, const struct sk_buff *skb,
 		family = msk->pm.local.family;
 	}
 
-	if (remaining < mptcp_add_addr_len(family, *echo, port)) {
+	len += mptcp_add_addr_len(family, *echo, port);
+	if (len > remaining) {
 		struct net *net = sock_net((struct sock *)msk);
 
 		if (!*drop_other_suboptions)
@@ -943,6 +960,7 @@ bool mptcp_pm_add_addr_signal(struct mptcp_sock *msk, const struct sk_buff *skb,
 	}
 
 	ret = true;
+	*size = len;
 
 drop_signal_mark:
 	WRITE_ONCE(msk->pm.addr_signal, add_addr);
diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
index e9d97fb471ce..7379a49342e6 100644
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

