Received: from out-178.mta1.migadu.com (out-178.mta1.migadu.com [95.215.58.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9365720B30
	for <mptcp@lists.linux.dev>; Mon, 11 Dec 2023 08:18:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="O8R85hGI"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1702282716;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=OokwiNdb6UheDfJKpzvgIojrXXv0rBKbElg1ZYBVBwU=;
	b=O8R85hGIIIRuEmJ94SacaByYMB5cPv5eO1sHD5oMO/myHo07hduQL2r19yoBy0QRcrAiHO
	NXTxkvr25M+BWO/sbJxJ7pjErOl+k3Wf1wlcsAOq7N62M/gUUPMuP5MbRObqY9pxScKmFk
	kcfMJlF0CX/63wp2K/nuheGGZBNWOxw=
From: Geliang Tang <geliang.tang@linux.dev>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliang.tang@linux.dev>
Subject: [PATCH mptcp-next v4 3/5] mptcp: add mptcp_set_state helper
Date: Mon, 11 Dec 2023 16:19:15 +0800
Message-Id: <912d0df208a0fe5d146620cbc8f121b5e68e4985.1702282650.git.geliang.tang@linux.dev>
In-Reply-To: <cover.1702282650.git.geliang.tang@linux.dev>
References: <cover.1702282650.git.geliang.tang@linux.dev>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

This patch adds a new function mptcp_set_state(), in it if switch from
or to ESTABLISH state, increment or decrement the newly added counter
MPTCP_MIB_CURRESTAB.

Closes: https://github.com/multipath-tcp/mptcp_net-next/issues/460
Signed-off-by: Geliang Tang <geliang.tang@linux.dev>
---
 net/mptcp/protocol.c | 19 +++++++++++++++++++
 net/mptcp/protocol.h |  1 +
 2 files changed, 20 insertions(+)

diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index 4fc038d29623..23727f7394b6 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -2885,6 +2885,25 @@ void mptcp_subflow_shutdown(struct sock *sk, struct sock *ssk, int how)
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
+EXPORT_SYMBOL_GPL(mptcp_set_state);
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

