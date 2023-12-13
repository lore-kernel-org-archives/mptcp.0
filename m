Received: from out-170.mta0.migadu.com (out-170.mta0.migadu.com [91.218.175.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B53DCA59
	for <mptcp@lists.linux.dev>; Wed, 13 Dec 2023 05:57:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="eD9/mBTm"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1702447048;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=kL7av8Eq8w09CkbWnKtxbrOKfp9Lzm9h7ZZEdMWuZvg=;
	b=eD9/mBTmuresY+kERO+e2TFel5gSme2B3s4BpVcnF9tRHnndHR8lgXP9FgqVLxy7sQthRd
	qfC4NgVIg35/YxMSwST2ylaxFghWqR2SXq2wY8Aee2doVfaHhYWyyuVoK2f5+zpNz7i9gg
	Gx3PtJWdK1gWGfvSHdzFfRlqsgO2tO4=
From: Geliang Tang <geliang.tang@linux.dev>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliang.tang@linux.dev>
Subject: [PATCH mptcp-next v5 1/3] mptcp: add mptcp_set_state
Date: Wed, 13 Dec 2023 13:56:37 +0800
Message-Id: <fae21f165c0148f4602a6ca16fa0b82bb4e33026.1702446832.git.geliang.tang@linux.dev>
In-Reply-To: <cover.1702446832.git.geliang.tang@linux.dev>
References: <cover.1702446832.git.geliang.tang@linux.dev>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

Similar to MPTCP_INC_STATS(), add a new helper named MPTCP_DEC_STATS()
to decrement a MIB counter.

And add a new MIB counter named MPTCP_MIB_CURRESTAB to count current
established MPTCP connections.

This patch adds a new function mptcp_set_state(), in it if switch from
or to ESTABLISH state, increment or decrement this newly added counter
MPTCP_MIB_CURRESTAB.

Closes: https://github.com/multipath-tcp/mptcp_net-next/issues/460
Signed-off-by: Geliang Tang <geliang.tang@linux.dev>
---
 net/mptcp/mib.c      |  1 +
 net/mptcp/mib.h      |  8 ++++++++
 net/mptcp/protocol.c | 18 ++++++++++++++++++
 net/mptcp/protocol.h |  1 +
 4 files changed, 28 insertions(+)

diff --git a/net/mptcp/mib.c b/net/mptcp/mib.c
index a0990c365a2e..c30405e76833 100644
--- a/net/mptcp/mib.c
+++ b/net/mptcp/mib.c
@@ -66,6 +66,7 @@ static const struct snmp_mib mptcp_snmp_list[] = {
 	SNMP_MIB_ITEM("RcvWndShared", MPTCP_MIB_RCVWNDSHARED),
 	SNMP_MIB_ITEM("RcvWndConflictUpdate", MPTCP_MIB_RCVWNDCONFLICTUPDATE),
 	SNMP_MIB_ITEM("RcvWndConflict", MPTCP_MIB_RCVWNDCONFLICT),
+	SNMP_MIB_ITEM("MPCurrEstab", MPTCP_MIB_CURRESTAB),
 	SNMP_MIB_SENTINEL
 };
 
diff --git a/net/mptcp/mib.h b/net/mptcp/mib.h
index cae71d947252..dd7fd1f246b5 100644
--- a/net/mptcp/mib.h
+++ b/net/mptcp/mib.h
@@ -65,6 +65,7 @@ enum linux_mptcp_mib_field {
 					 * conflict with another subflow while updating msk rcv wnd
 					 */
 	MPTCP_MIB_RCVWNDCONFLICT,	/* Conflict with while updating msk rcv wnd */
+	MPTCP_MIB_CURRESTAB,		/* Current established MPTCP connections */
 	__MPTCP_MIB_MAX
 };
 
@@ -95,4 +96,11 @@ static inline void __MPTCP_INC_STATS(struct net *net,
 		__SNMP_INC_STATS(net->mib.mptcp_statistics, field);
 }
 
+static inline void MPTCP_DEC_STATS(struct net *net,
+				   enum linux_mptcp_mib_field field)
+{
+	if (likely(net->mib.mptcp_statistics))
+		SNMP_DEC_STATS(net->mib.mptcp_statistics, field);
+}
+
 bool mptcp_mib_alloc(struct net *net);
diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index 4fc038d29623..b0b149cc89aa 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -2885,6 +2885,24 @@ void mptcp_subflow_shutdown(struct sock *sk, struct sock *ssk, int how)
 	release_sock(ssk);
 }
 
+void mptcp_set_state(struct sock *sk, int state)
+{
+	int oldstate = sk->sk_state;
+
+	switch (state) {
+	case TCP_ESTABLISHED:
+		if (oldstate != TCP_ESTABLISHED)
+			MPTCP_INC_STATS(sock_net(sk), MPTCP_MIB_CURRESTAB);
+		break;
+
+	default:
+		if (oldstate == TCP_ESTABLISHED)
+			MPTCP_DEC_STATS(sock_net(sk), MPTCP_MIB_CURRESTAB);
+	}
+
+	inet_sk_state_store(sk, state);
+}
+
 static const unsigned char new_state[16] = {
 	/* current state:     new state:      action:	*/
 	[0 /* (Invalid) */] = TCP_CLOSE,
diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
index ac11044bef1d..f7b9c1b995df 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -646,6 +646,7 @@ bool __mptcp_close(struct sock *sk, long timeout);
 void mptcp_cancel_work(struct sock *sk);
 void __mptcp_unaccepted_force_close(struct sock *sk);
 void mptcp_set_owner_r(struct sk_buff *skb, struct sock *sk);
+void mptcp_set_state(struct sock *sk, int state);
 
 bool mptcp_addresses_equal(const struct mptcp_addr_info *a,
 			   const struct mptcp_addr_info *b, bool use_port);
-- 
2.35.3

