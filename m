Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com [209.85.208.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00CF170
	for <mptcp@lists.linux.dev>; Wed, 26 May 2021 16:08:38 +0000 (UTC)
Received: by mail-ed1-f51.google.com with SMTP id h16so2190613edr.6
        for <mptcp@lists.linux.dev>; Wed, 26 May 2021 09:08:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares-net.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=uIJFUwijX50mP5Q9l/5wpCyBfe8A+wRv7ItEf9DzwAE=;
        b=bGF3mTHD78UL3O6DR4qp9Omy0YiA2MCsxTXjWi1dRAhZYt9JGrm4KT4NxhWzIU71FF
         2ilOZcw7TuiKBkOpDGKYFe/XaEeOp8+yE4vjNkCkbUAzkg+PAur2t4dPMIseVNQY9sfl
         08mOkv8NFDpK+39HfvxjLiHdQ5ZmVsDWeKFI2knLv+/XV3kQH9YjDrbJXqssSGzYDepD
         TfoiC7devJkj+jT8/FXmVwkcyE7t976uLAe+YyJUP/RzGz2QQ13EZLRN1q9lK1Qn+T/P
         l1rQh46fDUKTyQUwh1+62ZGHFSik1ZibEPGQUoWMvPbHubxWmvW/23XA738k/DpGF2yJ
         nu+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=uIJFUwijX50mP5Q9l/5wpCyBfe8A+wRv7ItEf9DzwAE=;
        b=Nqyn9odnahXwo0h5uO6SJs/tNRLYwzqwOEc0vPGkzVi1h8Vgs9CrelHlAMa3jbpckD
         ynn6FsneNVex61lvXeih6E76+L7o2KPPeeQhnMa3PWuQCU3pE0yqqhS5ipRLUysU3VvF
         dajLTlaiKomaPSBVnrTf6am5LmzCBuPBGvqQL3Qy4zjzxpEM2FY1tt9UqGK1qQf6Kp5g
         2x2nLuCPkPNPxnN60YFw14zcxnhGSw+NTHV/+ZtSq4HpP89xdotir0CGieRlYXjYubk+
         0lv6cADFZ4ms41Q9lCCW4Gds18rpzSCd3vuV5QpGtHN1jiCLjhTWh7GOPyl4QhgWyvL4
         SZVQ==
X-Gm-Message-State: AOAM5332/o00AL1TZieqS4Tj3op/Z20V4JCszk6Oek4FjqoSyJRdwRgc
	ZxWQl5oaC0/L2NLN+bXJxDiZZ1aZwRrXT+Z3
X-Google-Smtp-Source: ABdhPJz4byPTXeF25LlRZsV+YOa+47y5564YlGA4gUwa5EFLLFrX8pdXkhO7sjUIqmL5sprcrzE71w==
X-Received: by 2002:a05:6402:518f:: with SMTP id q15mr38828981edd.345.1622045317199;
        Wed, 26 May 2021 09:08:37 -0700 (PDT)
Received: from tsr-vdi-mbaerts.nix.tessares.net (static.23.216.130.94.clients.your-server.de. [94.130.216.23])
        by smtp.gmail.com with ESMTPSA id j7sm931655ejk.51.2021.05.26.09.08.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 May 2021 09:08:36 -0700 (PDT)
From: Matthieu Baerts <matthieu.baerts@tessares.net>
To: mptcp@lists.linux.dev
Cc: Florian Westphal <fw@strlen.de>
Subject: [RESEND] [MPTCP] [RFC mptpcp-next] mptcp: add ooo prune support
Date: Wed, 26 May 2021 18:08:08 +0200
Message-ID: <20201002154535.28412-1-fw@strlen.de>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210526160813.4160315-1-matthieu.baerts@tessares.net>
References: <20210526160813.4160315-1-matthieu.baerts@tessares.net>
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Message-ID: <20210526160808.UOg3X-SCnjVAmC0qouTk8IltwdlX4Nxma8bMylqBzOs@z>

From: Florian Westphal <fw@strlen.de>

It might be possible that entire receive buffer is occupied by
skbs in the OOO queue.

In this case we can't pull more skbs from subflows and the holes
will never be filled.

If this happens, schedule the work queue and prune ~12% of skbs to
make space available. Also add a MIB counter for this.

Signed-off-by: Florian Westphal <fw@strlen.de>
---
 Paolo, this does relate a bit to our discussion wrt. oow
 tracking.  I thought we might need to add some sort of cushion to
 account for window discrepancies, but that might then get us
 in a state where wmem might be full...

 What do you think?

 I did NOT see such a problem in practice, this is a theoretical "fix".
 TCP has similar code to deal with corner cases of small-oow packets.

 net/mptcp/mib.c      |  1 +
 net/mptcp/mib.h      |  1 +
 net/mptcp/protocol.c | 48 ++++++++++++++++++++++++++++++++++++++++++--
 net/mptcp/protocol.h |  1 +
 4 files changed, 49 insertions(+), 2 deletions(-)

diff --git a/net/mptcp/mib.c b/net/mptcp/mib.c
index 84d119436b22..65c575e3af60 100644
--- a/net/mptcp/mib.c
+++ b/net/mptcp/mib.c
@@ -25,6 +25,7 @@ static const struct snmp_mib mptcp_snmp_list[] = {
 	SNMP_MIB_ITEM("OFOQueueTail", MPTCP_MIB_OFOQUEUETAIL),
 	SNMP_MIB_ITEM("OFOQueue", MPTCP_MIB_OFOQUEUE),
 	SNMP_MIB_ITEM("OFOMerge", MPTCP_MIB_OFOMERGE),
+	SNMP_MIB_ITEM("OFOPrune", MPTCP_MIB_OFOPRUNE),
 	SNMP_MIB_ITEM("NoDSSInWindow", MPTCP_MIB_NODSSWINDOW),
 	SNMP_MIB_ITEM("DuplicateData", MPTCP_MIB_DUPDATA),
 	SNMP_MIB_ITEM("AddAddr", MPTCP_MIB_ADDADDR),
diff --git a/net/mptcp/mib.h b/net/mptcp/mib.h
index 47bcecce1106..75a7fb3a87db 100644
--- a/net/mptcp/mib.h
+++ b/net/mptcp/mib.h
@@ -18,6 +18,7 @@ enum linux_mptcp_mib_field {
 	MPTCP_MIB_OFOQUEUETAIL,	/* Segments inserted into OoO queue tail */
 	MPTCP_MIB_OFOQUEUE,		/* Segments inserted into OoO queue */
 	MPTCP_MIB_OFOMERGE,		/* Segments merged in OoO queue */
+	MPTCP_MIB_OFOPRUNE,		/* Segments pruned from OoO queue */
 	MPTCP_MIB_NODSSWINDOW,		/* Segments not in MPTCP windows */
 	MPTCP_MIB_DUPDATA,		/* Segments discarded due to duplicate DSS */
 	MPTCP_MIB_ADDADDR,		/* Received ADD_ADDR with echo-flag=0 */
diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index 79cd8e879c10..4cc30a3d426c 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -658,8 +658,17 @@ void mptcp_data_ready(struct sock *sk, struct sock *ssk)
 		sk_rbuf = ssk_rbuf;
 
 	/* over limit? can't append more skbs to msk */
-	if (atomic_read(&sk->sk_rmem_alloc) > sk_rbuf)
-		goto wake;
+	if (atomic_read(&sk->sk_rmem_alloc) > sk_rbuf) {
+		if (likely(!skb_queue_empty(&sk->sk_receive_queue)))
+			goto wake;
+
+		/* Entire recvbuf occupied by OOO skbs? Prune time. */
+		if (!test_and_set_bit(MPTCP_WORK_PRUNE_OFO, &msk->flags) &&
+		     schedule_work(&msk->work))
+			sock_hold(sk);
+
+		return;
+	}
 
 	if (move_skbs_to_msk(msk, ssk))
 		goto wake;
@@ -1797,6 +1806,38 @@ static bool mptcp_check_close_timeout(const struct sock *sk)
 	return true;
 }
 
+static void mptcp_prune_ofo(struct mptcp_sock *msk)
+{
+	struct sock *sk = &msk->sk.icsk_inet.sk;
+	struct sk_buff *skb, *prev = NULL;
+	int goal;
+
+	if (!skb_queue_empty(&sk->sk_receive_queue) ||
+	    atomic_read(&sk->sk_rmem_alloc) <= sk->sk_rcvbuf)
+		return;
+
+	if (WARN_ON_ONCE(RB_EMPTY_ROOT(&msk->out_of_order_queue)))
+		return;
+
+	MPTCP_INC_STATS(sock_net(sk), MPTCP_MIB_OFOPRUNE);
+
+	goal = READ_ONCE(sk->sk_rcvbuf) >> 3;
+	skb = msk->ooo_last_skb;
+
+	while (skb) {
+		prev = skb_rb_prev(skb);
+		rb_erase(&skb->rbnode, &msk->out_of_order_queue);
+		goal -= skb->truesize;
+		mptcp_drop(sk, skb);
+
+		if (goal <= 0)
+			break;
+		skb = prev;
+	}
+
+	msk->ooo_last_skb = prev;
+}
+
 static void mptcp_worker(struct work_struct *work)
 {
 	struct mptcp_sock *msk = container_of(work, struct mptcp_sock, work);
@@ -1819,6 +1860,9 @@ static void mptcp_worker(struct work_struct *work)
 	if (mptcp_send_head(sk))
 		mptcp_push_pending(sk, 0);
 
+	if (test_and_clear_bit(MPTCP_WORK_PRUNE_OFO, &msk->flags))
+		mptcp_prune_ofo(msk);
+
 	if (msk->pm.status)
 		pm_work(msk);
 
diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
index d33e9676a1a3..360441fdaa93 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -91,6 +91,7 @@
 #define MPTCP_WORK_EOF		3
 #define MPTCP_FALLBACK_DONE	4
 #define MPTCP_WORKER_RUNNING	5
+#define MPTCP_WORK_PRUNE_OFO	6
 
 static inline bool before64(__u64 seq1, __u64 seq2)
 {
