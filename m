Received: from Chamillionaire.breakpoint.cc (Chamillionaire.breakpoint.cc [193.142.43.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB8E53FC1
	for <mptcp@lists.linux.dev>; Mon,  6 Sep 2021 13:10:55 +0000 (UTC)
Received: from fw by Chamillionaire.breakpoint.cc with local (Exim 4.92)
	(envelope-from <fw@breakpoint.cc>)
	id 1mNEOk-0001oE-2Z; Mon, 06 Sep 2021 15:10:54 +0200
From: Florian Westphal <fw@strlen.de>
To: <mptcp@lists.linux.dev>
Cc: Florian Westphal <fw@strlen.de>,
	Paolo Abeni <pabeni@redhat.com>
Subject: [PATCH mptcp-next v2 1/2] mptcp: remove tx_pending_data
Date: Mon,  6 Sep 2021 15:10:44 +0200
Message-Id: <20210906131045.18513-2-fw@strlen.de>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20210906131045.18513-1-fw@strlen.de>
References: <20210906131045.18513-1-fw@strlen.de>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The update on recovery is not correct.

msk->tx_pending_data += msk->snd_nxt - rtx_head->data_seq;

will update tx_pending_data multiple times when a subflow is declared
stale while earlier recovery is still in progress.
This means that tx_pending_data will still be positive even after
all data as has been transmitted.

Rather than fix it, remove this field: there are no consumers.
The outstanding data byte count can be computed either via

 "msk->write_seq - rtx_head->data_seq" or
 "msk->write_seq - msk->snd_una".

The latter is more recent/accurate estimate as rtx_head adjustment
is deferred until mptcp lock can be acquired.

Signed-off-by: Florian Westphal <fw@strlen.de>
Acked-by: Paolo Abeni <pabeni@redhat.com>
---
 No changes in v2.

 net/mptcp/protocol.c | 4 ----
 net/mptcp/protocol.h | 1 -
 2 files changed, 5 deletions(-)

diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index 2a525c7ae920..c0e0ee4cb24f 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -1531,7 +1531,6 @@ static void mptcp_update_post_push(struct mptcp_sock *msk,
 	dfrag->already_sent += sent;
 
 	msk->snd_burst -= sent;
-	msk->tx_pending_data -= sent;
 
 	snd_nxt_new += dfrag->already_sent;
 
@@ -1761,7 +1760,6 @@ static int mptcp_sendmsg(struct sock *sk, struct msghdr *msg, size_t len)
 		frag_truesize += psize;
 		pfrag->offset += frag_truesize;
 		WRITE_ONCE(msk->write_seq, msk->write_seq + psize);
-		msk->tx_pending_data += psize;
 
 		/* charge data on mptcp pending queue to the msk socket
 		 * Note: we charge such data both to sk and ssk
@@ -2254,7 +2252,6 @@ bool __mptcp_retransmit_pending_data(struct sock *sk)
 	mptcp_data_unlock(sk);
 
 	msk->first_pending = rtx_head;
-	msk->tx_pending_data += msk->snd_nxt - rtx_head->data_seq;
 	msk->snd_burst = 0;
 
 	/* be sure to clear the "sent status" on all re-injected fragments */
@@ -2525,7 +2522,6 @@ static int __mptcp_init_sock(struct sock *sk)
 	msk->first_pending = NULL;
 	msk->wmem_reserved = 0;
 	WRITE_ONCE(msk->rmem_released, 0);
-	msk->tx_pending_data = 0;
 	msk->timer_ival = TCP_RTO_MIN;
 
 	msk->first = NULL;
diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
index 99a23fff7b03..8416810afa8e 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -254,7 +254,6 @@ struct mptcp_sock {
 	struct sk_buff  *ooo_last_skb;
 	struct rb_root  out_of_order_queue;
 	struct sk_buff_head receive_queue;
-	int		tx_pending_data;
 	struct list_head conn_list;
 	struct list_head rtx_queue;
 	struct mptcp_data_frag *first_pending;
-- 
2.32.0

