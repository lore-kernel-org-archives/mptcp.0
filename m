Received: from out-172.mta1.migadu.com (out-172.mta1.migadu.com [95.215.58.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55CE884A35
	for <mptcp@lists.linux.dev>; Thu,  5 Feb 2026 06:42:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770273733; cv=none; b=lHjh/w2lGvowopA/my+Sq5vpc4XaD2ePSsnuMX6e2yGTdfryPwZt5Cch90K09KHyuuVfX0cHxo0NKor43DdEGPoXohlHKFMnt9YK17P81lr7TXBzOlI8NWfxh9UZ1VBXNZ1bOlTyR+eFbrc0HAGWXZbsQrKTT3UIHhXOIWmVU6M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770273733; c=relaxed/simple;
	bh=Dh1p3mXzhs4Q4Ypf0hf5QErW/qi5sjjajF/yhlT2s7o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=AJ4phXzjMS2PpOCBCqhPa+hayim12BHSDStBBkiHa3R9z4tR++zfHQSANt8l7KYl6ps1fKTehtyO6FzcBesRF5epDpDjB42sYoL6RIhpOGNriTHjHmamlxjalOqcfm779DWPuWIcSfAErTTwZNTXsUGzpxwExtvmT/jygzOBzco=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=CbDaiZ1P; arc=none smtp.client-ip=95.215.58.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="CbDaiZ1P"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1770273731;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Wdw8TkhBhXjG4s+5wegI9V+rVUeqLUJsdmljdZr6kIk=;
	b=CbDaiZ1Pcb6Sy3eZm6DT0eyBWquEfcbMq43VB03xKeFLPpkb4dmh2V/WcGtgqvBrEfEqjR
	n+HjWzQlK1HB4Sag3vMSdANG5kapGimbHLreH0MZSzhqI05icGZoNSCNocnm9dDuJe9Wlw
	KpZUys8BASYWx6davzD0ZuxGeGvc6uA=
From: Gang Yan <gang.yan@linux.dev>
To: mptcp@lists.linux.dev,
	pabeni@redhat.com
Cc: Gang Yan <yangang@kylinos.cn>,
	Geliang Tang <tanggeliang@kylinos.cn>
Subject: [Patch mptcp-net 2/3] mptcp: fix receive stalls when 'ack_seq' in backlog_list
Date: Thu,  5 Feb 2026 14:41:30 +0800
Message-ID: <7bee08bb168041f1fa0440b1b605548bdc03f241.1770273341.git.yangang@kylinos.cn>
In-Reply-To: <cover.1770273341.git.yangang@kylinos.cn>
References: <cover.1770273341.git.yangang@kylinos.cn>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

From: Gang Yan <yangang@kylinos.cn>

This patch fixes the first backlog_list issue, which can be 100%
reproduced by the multi_chunk.sh test case.

The problem occurs when out-of-order (OFO) queue data accumulates,
causing sk_rmem_alloc to exceed sk_rcvbuf. In this condition, skbs
in backlog_list fail to move to sk->receive_queue even when the
receive queue is empty, leading to transmission stalls.

This patch adds an empty check for sk->receieve_queue, when it is empty,
the skb should moved too.

Co-developed-by: Geliang Tang <tanggeliang@kylinos.cn>
Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
Signed-off-by: Gang Yan <yangang@kylinos.cn>
---
 net/mptcp/protocol.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index ff06bbee7781..b6bafc37eea4 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -2176,7 +2176,8 @@ static bool __mptcp_move_skbs(struct sock *sk, struct list_head *skbs, u32 *delt
 	*delta = 0;
 	while (1) {
 		/* If the msk recvbuf is full stop, don't drop */
-		if (sk_rmem_alloc_get(sk) > sk->sk_rcvbuf)
+		if (sk_rmem_alloc_get(sk) > sk->sk_rcvbuf &&
+		    !skb_queue_empty(&sk->sk_receive_queue))
 			break;
 
 		prefetch(skb->next);
@@ -2208,7 +2209,8 @@ static bool mptcp_can_spool_backlog(struct sock *sk, struct list_head *skbs)
 
 	/* Don't spool the backlog if the rcvbuf is full. */
 	if (list_empty(&msk->backlog_list) ||
-	    sk_rmem_alloc_get(sk) > sk->sk_rcvbuf)
+	    (sk_rmem_alloc_get(sk) > sk->sk_rcvbuf &&
+	     !skb_queue_empty(&sk->sk_receive_queue)))
 		return false;
 
 	INIT_LIST_HEAD(skbs);
-- 
2.43.0

