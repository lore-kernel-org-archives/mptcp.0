Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A33E03A9852
	for <mptcp@lists.linux.dev>; Tue,  2 Jun 2026 07:14:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780384468; cv=none; b=sRoYc47C/KmJUiVMHqpdnS54NT4ckejlWxQc9WdGcMbIsUccxXnJZLs9EN+gwz4ULvh4h4EdOXoeeDwjAgIr34zw+XE23jrFUnfAZD6UbAhanrIAg6Dc2vu3CRxFTAZYCKr2ByPs1nIttADmkuMfSifdn4wP77dboI4o3h0GyIo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780384468; c=relaxed/simple;
	bh=iXmZI/N80mfFrrEza02xBEDdaxq4DcEucSmq0+8fD8A=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=MaHWhjCE3DzBG8doSOFdiY5bZ1qqU+Dz4+8zaN2ta77uy2XDSZNdwdgIsWyYZT3bA7gWlHICMvZlW1lt2cpagDXtiiQHScP6DrhMmbvZ9xiM/tKxfLY0SuKYRh9ZSNLaG+o8thRxSxlFt/fOzYwRNidl1coqfIzp3Wqc5a6Y1Cg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=j7IBuWvA; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="j7IBuWvA"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6533E1F00893;
	Tue,  2 Jun 2026 07:14:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780384464;
	bh=QQdI368AaAeF7nfkX3xtF/u8bZzKjGhjwhDy8K9JDUQ=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=j7IBuWvAy3chAFU0RI60fCp0kwy1GyjihwKJn1Ks7RuQ9c3Hgc4FD9O0/kExuk8eD
	 QU4geuLPe4OvyIY09xCdHIq8bi5jGHNuXUD1OemZLZJXGJnSqDjUAu2BgvcSb6f5yG
	 hmN5D/+YGkAKluENDBmE1YiFI6ZYvlt0RMNqzNWmHDXnLIoDTudCEnjRZawfJc7D9E
	 qxajdjQqFn0h4PQkCLDq7vGBHUqjj1pZsVa/2Doq9qT5G8pAaQ8MyU3Nb90svLhSWA
	 GjCbohMEHSWbSIt8o/FD9fJO0fq0nxQqoA8zK9Um7e4DwFmFFfVwUUOXJi4sDOcDkB
	 LWrQKrdxE/BHg==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Tue, 02 Jun 2026 17:12:37 +1000
Subject: [PATCH mptcp-net 1/2] mptcp: add-addr: always drop other
 suboptions
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260602-mptcp-add-addr-always-drop-subopt-v1-1-4cb4b5f446c2@kernel.org>
References: <20260602-mptcp-add-addr-always-drop-subopt-v1-0-4cb4b5f446c2@kernel.org>
In-Reply-To: <20260602-mptcp-add-addr-always-drop-subopt-v1-0-4cb4b5f446c2@kernel.org>
To: MPTCP Linux <mptcp@lists.linux.dev>
Cc: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=6022; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=iXmZI/N80mfFrrEza02xBEDdaxq4DcEucSmq0+8fD8A=;
 b=owEBbQKS/ZANAwAIAfa3gk9CaaBzAcsmYgBqHoLNa6RfasK1+ljZYI2saL5E8DZaIkx9qFTYC
 u61oA4KYIKJAjMEAAEIAB0WIQToy4X3aHcFem4n93r2t4JPQmmgcwUCah6CzQAKCRD2t4JPQmmg
 c2gsD/wI6osthbfpy9QbbNF/TIUdNZOrdZehP+oylFwnDZcj1w4/IhQNdYriXQUm34iwfjt/BIl
 naAfLUXp1kuMuMSB6D2Ib4xKQv+ZXvVxuFqe/ooGFnytjhq7kU5ccmxql27Gl2h4HAy8WLcZqin
 igzZ3Mra/4rEQ91a9MzVpa4qv7fhuGvcEJM0f6mz328pzMIoROdpwP1LZb6UFjWL9gXoLdLXz/x
 rBO2obZAClplfVkJyH+hrGa0Yv/Sp987ZqpWOFWLx1DW5c3Rx3u+Wbnzvj6+UZ2IwNTRuX6k2Zs
 p8TtyT9ZSwB+3XQd6VaCgmX3Nofz+WrLpjiOTKTgA2lMRa+e3vDSme+IRZW2VTSOzHJzxo4sHYN
 pZ97DCqumhCK2dygAUvSBxVF+lUTzDPMK7x+7GnbdoEH8d6ur64BKAdu7weWHLVeKcpWgCc7LQF
 ufdgvWVXnoae1ToMSZ//atA/QNpRuNm5Va5hFvoTIkarroCqiJ+CmJCGtSYpUakbTBUur42ktIp
 pfx5jFO0xSpnaCFBFbcbmz+hELxLMH8O8brkRaDMuHXc/31zcj/wjVcsl+80uOq+WPjoHpp0fTY
 Ef2zeYZZhW/70CZXlAA6skcv2LmkSqMAitm9DF0wnNbXTjzX3v69sORY+hDuNH5XSdt+N5rxMkz
 FsT6NySF04CK3jw==
X-Developer-Key: i=matttbe@kernel.org; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

When an ADD_ADDR needs to be sent, it could be prepared if there is
enough remaining space and even if the packet is not a pure ACK. But it
would be dropped soon after.

Indeed, in mptcp_pm_add_addr_signal(), there is enough space to fit a
DSS of 20 octets and an ADD_ADDR echo containing an IPv4 address on 8
octets for example. In this case, the packet would be prepared, the
MPTCP_ADD_ADDR_ECHO bit would be removed from pm->addr_signal, but the
option would be silently dropped in mptcp_established_options_add_addr()
not to override DSS info in the union from 'struct mptcp_out_options',
and also because mptcp_write_options() will enforce mutually exclusion
with DSS.

Instead, don't even try to send an ADD_ADDR if it is not a pure ACK.
Retry for each new packet until a pure-ACK is emitted. That's fine to do
that, because each time an ADD_ADDR (echo) is scheduled, a pure ACK is
queued.

This also simplifies the code, and the skb checks can be done earlier,
before the lock.

Note: also, since commit 6d0060f600ad ("mptcp: Write MPTCP DSS headers
to outgoing data packets"), opts->ahmac would not have been set to 0
when other suboptions were not dropped, and when sending an ADD_ADDR
echo. That would have resulted in sending an ADD_ADDR using garbage
info, where there was not enough space, instead of an echo one without
the ADD_ADDR HMAC.

Fixes: 1bff1e43a30e ("mptcp: optimize out option generation")
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
 net/mptcp/options.c  | 27 ++++++---------------------
 net/mptcp/pm.c       | 13 +++----------
 net/mptcp/protocol.h |  5 ++---
 3 files changed, 11 insertions(+), 34 deletions(-)

diff --git a/net/mptcp/options.c b/net/mptcp/options.c
index 09e78f5bc446..b0f6a60f8560 100644
--- a/net/mptcp/options.c
+++ b/net/mptcp/options.c
@@ -664,7 +664,6 @@ static bool mptcp_established_options_add_addr(struct sock *sk,
 {
 	struct mptcp_subflow_context *subflow = mptcp_subflow_ctx(sk);
 	struct mptcp_sock *msk = mptcp_sk(subflow->conn);
-	bool drop_other_suboptions = false;
 	struct mptcp_addr_info addr;
 	bool drop_ts = has_ts;
 	bool echo;
@@ -674,28 +673,13 @@ static bool mptcp_established_options_add_addr(struct sock *sk,
 	 */
 	if (!mptcp_pm_should_add_signal(msk) ||
 	    (opts->suboptions & (OPTION_MPTCP_MPJ_ACK | OPTION_MPTCP_MPC_ACK)) ||
-	    !mptcp_pm_add_addr_signal(msk, skb, size, remaining, &addr, &echo,
-				      &drop_other_suboptions, &drop_ts))
+	    !skb || !skb_is_tcp_pure_ack(skb) ||
+	    !mptcp_pm_add_addr_signal(msk, size, remaining, &addr, &echo,
+				      &drop_ts))
 		return false;
 
-	/*
-	 * Later on, mptcp_write_options() will enforce mutually exclusion with
-	 * DSS, bail out if such option is set and we can't drop it.
-	 */
-	if (!drop_other_suboptions && opts->suboptions & OPTION_MPTCP_DSS)
-		return false;
-
-	if (drop_other_suboptions) {
-		pr_debug("drop other suboptions\n");
-		opts->suboptions = 0;
-
-		/* note that e.g. DSS could have written into the memory
-		 * aliased by ahmac, we must reset the field here
-		 * to avoid appending the hmac even for ADD_ADDR echo
-		 * options
-		 */
-		opts->ahmac = 0;
-	}
+	pr_debug("drop other suboptions\n");
+	opts->suboptions = 0;
 	opts->drop_ts = drop_ts;
 	opts->addr = addr;
 	opts->suboptions |= OPTION_MPTCP_ADD_ADDR;
@@ -706,6 +690,7 @@ static bool mptcp_established_options_add_addr(struct sock *sk,
 						     &opts->addr);
 	} else {
 		MPTCP_INC_STATS(sock_net(sk), MPTCP_MIB_ECHOADDTX);
+		opts->ahmac = 0;
 	}
 	pr_debug("addr_id=%d, ahmac=%llu, echo=%d, port=%d\n",
 		 opts->addr.id, opts->ahmac, echo, ntohs(opts->addr.port));
diff --git a/net/mptcp/pm.c b/net/mptcp/pm.c
index 452b17b9330c..7260f3347446 100644
--- a/net/mptcp/pm.c
+++ b/net/mptcp/pm.c
@@ -907,10 +907,9 @@ static int mptcp_add_addr_len(int family, bool echo, bool port)
 	return len;
 }
 
-bool mptcp_pm_add_addr_signal(struct mptcp_sock *msk, const struct sk_buff *skb,
-			      int *size, int remaining,
+bool mptcp_pm_add_addr_signal(struct mptcp_sock *msk, int *size, int remaining,
 			      struct mptcp_addr_info *addr, bool *echo,
-			      bool *drop_other_suboptions, bool *drop_ts)
+			      bool *drop_ts)
 {
 	bool skip_add_addr = false;
 	bool ret = false;
@@ -929,10 +928,7 @@ bool mptcp_pm_add_addr_signal(struct mptcp_sock *msk, const struct sk_buff *skb,
 	 * plain dup-ack from TCP perspective. The other MPTCP-relevant info,
 	 * if any, will be carried by the 'original' TCP ack
 	 */
-	if (skb && skb_is_tcp_pure_ack(skb)) {
-		len -= *size;
-		*drop_other_suboptions = true;
-	}
+	len -= *size;
 
 	*echo = mptcp_pm_should_add_signal_echo(msk);
 	if (*echo) {
@@ -951,9 +947,6 @@ bool mptcp_pm_add_addr_signal(struct mptcp_sock *msk, const struct sk_buff *skb,
 	if (len > remaining) {
 		struct net *net = sock_net((struct sock *)msk);
 
-		if (!*drop_other_suboptions)
-			goto out_unlock;
-
 		if (*drop_ts && mptcp_add_addr_v6_port_drop_ts(net)) {
 			/* OK without TCP Timestamps? */
 			len -= TCPOLEN_TSTAMP_ALIGNED;
diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
index b63571400c6a..da40c6f3705f 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -1206,10 +1206,9 @@ static inline bool mptcp_pm_is_kernel(const struct mptcp_sock *msk)
 	return READ_ONCE(msk->pm.pm_type) == MPTCP_PM_TYPE_KERNEL;
 }
 
-bool mptcp_pm_add_addr_signal(struct mptcp_sock *msk, const struct sk_buff *skb,
-			      int *size, int remaining,
+bool mptcp_pm_add_addr_signal(struct mptcp_sock *msk, int *size, int remaining,
 			      struct mptcp_addr_info *addr, bool *echo,
-			      bool *drop_other_suboptions, bool *drop_ts);
+			      bool *drop_ts);
 bool mptcp_pm_rm_addr_signal(struct mptcp_sock *msk, unsigned int remaining,
 			     struct mptcp_rm_list *rm_list, int *len);
 int mptcp_pm_get_local_id(struct mptcp_sock *msk, struct sock_common *skc);

-- 
2.53.0

