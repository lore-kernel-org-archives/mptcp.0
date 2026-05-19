Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1D072D978A
	for <mptcp@lists.linux.dev>; Tue, 19 May 2026 05:51:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779169880; cv=none; b=uvmPl/d7kNsQcZkHs2AEKiunzVcUOLP50TwBVgILMaDSDYBB99UaiFUfYev+K5KrmL0vgKAwvTofjH6VqaQAN/qOyOwGUCE5WyokEKJAXe1buF9x+C1RI3iN2MAlyR3LSQEtBdMhLQCZlC3uPJYzI79mVfnpOEERNwo53/o7Svc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779169880; c=relaxed/simple;
	bh=JB8b+297YemDz1jE51xtP5O1BhzJqag6MKhooi7Z8Sk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=RdOD/NKTzlXdYAjnyo6juBIu3i92UjDk/OoKPjg8RhNmw2TU0wItg8eQnLc0aAca/KnJCtd1mYilK9u+0Cgew7CvoIY8LHO/gzHv823+I4XmwHpp3StR/QA8lYdncujSoPFPreoZCWArpmzWIawETMgF1rf4jc6lIiEnBor8VJA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=p42qYTNi; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="p42qYTNi"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EB460C2BCC6;
	Tue, 19 May 2026 05:51:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1779169880;
	bh=JB8b+297YemDz1jE51xtP5O1BhzJqag6MKhooi7Z8Sk=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=p42qYTNi6X/N6iw8+UcKqeyQCYXNFhgD8A67APi9rEf2lfXYgPEuMAVTextSwvpdG
	 e7Guu5u6YH4gQCcsqprkD6SBMHeoGXQF+spjnoQP+epNXG5vFKSuE8N9MOXV+3Cn4o
	 aA9P1i/e8VZhiV6Tu40tWV7LuyVRtTo3RKPge8qFRFfzyl44V1JxMIrM0vW0UB7DMt
	 gox1sFyacD3GPjEG2MfYRBKBtj9SfX0gFDGdLeseWkPi1HokXHIRDVcdgsDNhur0sn
	 PwAQAwfVhMGTdkcfZngMKfOWs8TvEeWRWUHubS9+r+7lVpw2VsD8ubkYyuhtBXjVPS
	 +x+358pCLwDqw==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Tue, 19 May 2026 15:51:13 +1000
Subject: [PATCH mptcp-next v2 04/15] mptcp: pm: avoid computing add_addr
 size twice
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260519-mptcp-add-addr6-port-ts-v2-4-3b36a51e6a86@kernel.org>
References: <20260519-mptcp-add-addr6-port-ts-v2-0-3b36a51e6a86@kernel.org>
In-Reply-To: <20260519-mptcp-add-addr6-port-ts-v2-0-3b36a51e6a86@kernel.org>
To: MPTCP Linux <mptcp@lists.linux.dev>
Cc: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=5802; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=JB8b+297YemDz1jE51xtP5O1BhzJqag6MKhooi7Z8Sk=;
 b=owEBbQKS/ZANAwAIAfa3gk9CaaBzAcsmYgBqC/pSw5MSuuNu4zYKreXEBgXlXwWVSSHKD4aG3
 jtridTM47SJAjMEAAEIAB0WIQToy4X3aHcFem4n93r2t4JPQmmgcwUCagv6UgAKCRD2t4JPQmmg
 c0C2D/95fhBorAs6iMtrExPrEJlf9p6eus7GK+aYps6AgbOMBy7dePKbwFz4WswfLiqeV0LZEIP
 TGpeCdGkFaMx1KzlAmgjBnroaFGIKzGFfEoV2XXkKVUKlRi5pCVQ4Liym3ODlXshu/FeS16mfFq
 TR9hT7iRlVgTVtHQi/BKHINfoU8a8ch6PoeH97OrJ1IVw/fP0MJ5RnJcUcJct2xBQ44Zae8pBOE
 mwsJT3O1hmlVi56PLTwNWMSVDx/kxafgalZ0li/oCGolX9oUEZu5aYPTwcxtsBX3EHDoWUoGWwr
 bZHv3hgUmWEgW+UFD9AIcnNX17UCl5g1qVeQjrQ8piHAkoevfXj6uorZDekFsdtE5vDgmsV84EX
 Irv5+CvVxN0F84PkL5V0kFfNuneOrJwNOfn/rQ+2l5HH3H2PhcwtVWF6V8+LqMOHE6QYpYHze/M
 cvGvTGkwLJbkwiPMJj9LNhbCvu9BW3h3RTNqw/XY2pYBSjYCS2rInQa6nOEuXKafh4QTwCrChmH
 Z50ybZyKsbXT5bLsY4bbT5jtJLXtDTszRd4g7X9CXtYuSgiPHDfS33i0WizOneM1ItU0vxGKEgq
 PA0jWAPTk7UMYH6eFiaN+R2m+Va5jgs0rqrkMNG/qc5z1R3IA6u/jwD7eY0zLWnSyM/6dySAyD/
 ljkOtKzQTOh9wQw==
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
index c51e57effbdb..dac76113f79b 100644
--- a/net/mptcp/pm.c
+++ b/net/mptcp/pm.c
@@ -888,14 +888,30 @@ void mptcp_pm_mp_fail_received(struct sock *sk, u64 fail_seq)
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

