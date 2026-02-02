Received: from out-174.mta1.migadu.com (out-174.mta1.migadu.com [95.215.58.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BEA3F27B340
	for <mptcp@lists.linux.dev>; Mon,  2 Feb 2026 04:09:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770005383; cv=none; b=SQPeKWSVN00ismeuwjz9ae/O5MounYmONKx+NbD50SzTCvhx30SYMQdPfztF2RASoazVI7NE/DOLT+Hx6QKLbbz3PIjkJ8j+vyh5aXiL/rPMzxOkz5r6Wy15lZyy7y0cyYmUpFVJosKw/nqlryNDeBfoUBnLkftCR+iiGORJnT0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770005383; c=relaxed/simple;
	bh=Wyu4FKDv+MFdKrMgzrmO+F3M7C0+O1fm63Od7bEhY8s=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=HVoywEWFZ+Q74qd+go5YEed8GJ2p7wne0KwEGnfUGbA1nUS+jViFXfhoQefbFB4+ctudflfwEF3oTxMImFvSOwSsjIDFkY5zICWnSNx1O8fsPNu0ov/fxo7Q904W6XFTbdBAHWRJrYL5HqwxeEPfLu5BIOblUW3fUXaHRiHvqhs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=G0IFV5NX; arc=none smtp.client-ip=95.215.58.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="G0IFV5NX"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1770005378;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=vNMw5kb69nXvr8is55X99V56X/bzXgYFf3HN99L26Os=;
	b=G0IFV5NXzW9RrhNy0vYaZ/Do2jt6dZpF42GD7hwtHYOZydD2lEoTVGOp/WhjAo/EgAANo+
	POrFbkUty53DboQjr50Ag95/9ObrCa1UliYagfMKPUUTyKib7aBtusFwRlAtQ16CJ/feeU
	nQUfEfUIDZbrLgbBF7Trjc/MIFd4H1Y=
From: Gang Yan <gang.yan@linux.dev>
To: mptcp@lists.linux.dev
Cc: Gang Yan <yangang@kylinos.cn>
Subject: [RFC mptcp-next] mptcp: support MSG_EOR in mptcp_sendmsg
Date: Mon,  2 Feb 2026 12:09:16 +0800
Message-ID: <20260202040916.626066-1-gang.yan@linux.dev>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

From: Gang Yan <yangang@kylinos.cn>

This patch adds support for the MSG_EOR flag in MPTCP's sendmsg path,
ensuring that data fragments marked with MSG_EOR are properly handled
to prevent coalescing with subsequent data.

Key changes:
1. Added an 'eor' field to struct mptcp_data_frag to track MSG_EOR marking
2. Initialize the eor field to 0 in mptcp_carve_data_frag()
3. In mptcp_sendmsg_frag(), when sending the last chunk of a data fragment
   that has MSG_EOR set, mark the corresponding skb with TCP_SKB_CB(skb)->eor = 1
   to prevent coalescing with subsequent data
4. Modified mptcp_sendmsg() to:
   - Preserve MSG_EOR flag in msg_flags filtering
   - Mark the last pending data fragment with eor = 1 when MSG_EOR is set
     in the message flags

This ensures that applications using MSG_EOR to indicate record boundaries
have their intent preserved across MPTCP subflows, maintaining proper
message segmentation semantics.

Signed-off-by: Gang Yan <yangang@kylinos.cn>
---

Notes:
    Hi Matt,
    
    I create two packetdrill scripts to test the 'MSG_EOR' in
    single/multi subflow(s). The link is attached below:
    https://github.com/multipath-tcp/packetdrill/compare/mptcp-net-next...Dwyane-Yan:packetdrill:mptcp-net-next
    
    Please ignore the indent problems, I will fix them when
    the 'MSG_EOR' patch is accepted.
    
    Thanks

 net/mptcp/protocol.c | 22 +++++++++++++++++++---
 net/mptcp/protocol.h |  1 +
 2 files changed, 20 insertions(+), 3 deletions(-)

diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index c88882062c40..b8200765506f 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -1174,6 +1174,7 @@ mptcp_carve_data_frag(const struct mptcp_sock *msk, struct page_frag *pfrag,
 	dfrag->offset = offset + sizeof(struct mptcp_data_frag);
 	dfrag->already_sent = 0;
 	dfrag->page = pfrag->page;
+	dfrag->eor = 0;
 
 	return dfrag;
 }
@@ -1434,6 +1435,13 @@ static int mptcp_sendmsg_frag(struct sock *sk, struct sock *ssk,
 		mptcp_update_infinite_map(msk, ssk, mpext);
 	trace_mptcp_sendmsg_frag(mpext);
 	mptcp_subflow_ctx(ssk)->rel_write_seq += copy;
+
+	 /* If this is the last chunk of a dfrag with MSG_EOR set
+	  * mark the skb to prevent coalescing with subsequent data
+	  */
+	if (dfrag->eor && info->sent + copy >= dfrag->data_len)
+		TCP_SKB_CB(skb)->eor = 1;
+
 	return copy;
 }
 
@@ -1894,7 +1902,8 @@ static int mptcp_sendmsg(struct sock *sk, struct msghdr *msg, size_t len)
 	long timeo;
 
 	/* silently ignore everything else */
-	msg->msg_flags &= MSG_MORE | MSG_DONTWAIT | MSG_NOSIGNAL | MSG_FASTOPEN;
+	msg->msg_flags &= MSG_MORE | MSG_DONTWAIT | MSG_NOSIGNAL |
+			  MSG_FASTOPEN | MSG_EOR;
 
 	lock_sock(sk);
 
@@ -2001,9 +2010,16 @@ static int mptcp_sendmsg(struct sock *sk, struct msghdr *msg, size_t len)
 			goto do_error;
 	}
 
-	if (copied)
-		__mptcp_push_pending(sk, msg->msg_flags);
+	if (copied) {
+		/* Mark the last dfrag with EOR if MSG_EOR was set */
+		if (msg->msg_flags & MSG_EOR) {
+			struct mptcp_data_frag *dfrag = mptcp_pending_tail(sk);
 
+			if (dfrag)
+				dfrag->eor = 1;
+		}
+		__mptcp_push_pending(sk, msg->msg_flags);
+	}
 out:
 	release_sock(sk);
 	return copied;
diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
index cd5266099993..5bfe1002242d 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -267,6 +267,7 @@ struct mptcp_data_frag {
 	u16 overhead;
 	u16 already_sent;
 	struct page *page;
+	u8 eor;					/* Is MSG_EOR marked? Prevents coalescing with next frag */
 };
 
 /* Arbitrary compromise between as low as possible to react timely to subflow
-- 
2.43.0

