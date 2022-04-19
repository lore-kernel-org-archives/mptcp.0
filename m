Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FF2D1374
	for <mptcp@lists.linux.dev>; Tue, 19 Apr 2022 17:19:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1650388741;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=+OY+yFzsQIMqQoPMP1panGUfFqcHdiP2vcaSQtdolkA=;
	b=WV4+kT1oMuaLMN1ysLTELzFeXwqTD0mqI7gljvbK4RKDDy+MUHmNR0J6gUsnJfjzUrplxG
	9/9Vy+CdaUOP6eokG0J5e0NK3zHSC/8tN+zk2DvUJeU/A98ILv6fZH7I/Iu29zyz0z4Bp0
	AywgUYmZr979/gmeqbf0GJBhfdq4u04=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-496-03ZBCMCGNd2K67i1YWzM7Q-1; Tue, 19 Apr 2022 13:18:59 -0400
X-MC-Unique: 03ZBCMCGNd2K67i1YWzM7Q-1
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.rdu2.redhat.com [10.11.54.10])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id D3DBF8517FB;
	Tue, 19 Apr 2022 17:18:47 +0000 (UTC)
Received: from gerbillo.redhat.com (unknown [10.39.193.165])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 2199F40146E;
	Tue, 19 Apr 2022 17:18:46 +0000 (UTC)
From: Paolo Abeni <pabeni@redhat.com>
To: netdev@vger.kernel.org
Cc: Eric Dumazet <eric.dumazet@gmail.com>,
	mptcp@lists.linux.dev
Subject: [RFC PATCH 2/2] mptcp: never shrink offered window
Date: Tue, 19 Apr 2022 19:18:24 +0200
Message-Id: <4742d835a4550db1a6f6f8ac6eea3433f819c36a.1650386197.git.pabeni@redhat.com>
In-Reply-To: <cover.1650386197.git.pabeni@redhat.com>
References: <cover.1650386197.git.pabeni@redhat.com>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.85 on 10.11.54.10

As per RFC, the offered MPTCP-level window should never shrink.
While we currently track the right edge, we don't enforce the
above constraint on the wire.
Additionally, concurrent xmit on different subflows can end-up in
erroneous right edge update.
Address the above explicitly updating the announced window and
protecting the update with an additional atomic operation (sic)

Signed-off-by: Paolo Abeni <pabeni@redhat.com>
---
 net/mptcp/options.c | 52 +++++++++++++++++++++++++++++++++++++++------
 1 file changed, 45 insertions(+), 7 deletions(-)

diff --git a/net/mptcp/options.c b/net/mptcp/options.c
index 9d6f14b496df..86d67ad41266 100644
--- a/net/mptcp/options.c
+++ b/net/mptcp/options.c
@@ -1224,20 +1224,58 @@ bool mptcp_incoming_options(struct sock *sk, struct sk_buff *skb)
 	return true;
 }
 
-static void mptcp_set_rwin(const struct tcp_sock *tp)
+static void mptcp_set_rwin(struct tcp_sock *tp, struct tcphdr *th)
 {
 	const struct sock *ssk = (const struct sock *)tp;
-	const struct mptcp_subflow_context *subflow;
+	struct mptcp_subflow_context *subflow;
+	u64 ack_seq, rcv_wnd_old, rcv_wnd_new;
 	struct mptcp_sock *msk;
-	u64 ack_seq;
+	u32 new_win;
+	u64 win;
 
 	subflow = mptcp_subflow_ctx(ssk);
 	msk = mptcp_sk(subflow->conn);
 
-	ack_seq = READ_ONCE(msk->ack_seq) + tp->rcv_wnd;
+	ack_seq = READ_ONCE(msk->ack_seq);
+	rcv_wnd_new = ack_seq + tp->rcv_wnd;
+
+	rcv_wnd_old = READ_ONCE(msk->rcv_wnd_sent);
+	if (after64(rcv_wnd_new, rcv_wnd_old)) {
+		u64 rcv_wnd;
+
+		for (;;) {
+			rcv_wnd = cmpxchg64(&msk->rcv_wnd_sent, rcv_wnd_old, rcv_wnd_new);
+
+			if (rcv_wnd == rcv_wnd_old)
+				break;
+			if (before64(rcv_wnd_new, rcv_wnd))
+				goto raise_win;
+			rcv_wnd_old = rcv_wnd;
+		};
+		return;
+	}
+
+	if (rcv_wnd_new != rcv_wnd_old) {
+raise_win:
+		win = rcv_wnd_old - ack_seq;
+		tp->rcv_wnd = min_t(u64, win, U32_MAX);
+		new_win = tp->rcv_wnd;
 
-	if (after64(ack_seq, READ_ONCE(msk->rcv_wnd_sent)))
-		WRITE_ONCE(msk->rcv_wnd_sent, ack_seq);
+		/* Make sure we do not exceed the maximum possible
+		 * scaled window.
+		 */
+		if (unlikely(th->syn))
+			new_win = min(new_win, 65535U) << tp->rx_opt.rcv_wscale;
+		if (!tp->rx_opt.rcv_wscale &&
+		    sock_net(ssk)->ipv4.sysctl_tcp_workaround_signed_windows)
+			new_win = min(new_win, MAX_TCP_WINDOW);
+		else
+			new_win = min(new_win, (65535U << tp->rx_opt.rcv_wscale));
+
+		/* RFC1323 scaling applied */
+		new_win >>= tp->rx_opt.rcv_wscale;
+		th->window = htons(new_win);
+	}
 }
 
 u16 __mptcp_make_csum(u64 data_seq, u32 subflow_seq, u16 data_len, __wsum sum)
@@ -1550,7 +1588,7 @@ void mptcp_write_options(struct tcphdr *th, __be32 *ptr, struct tcp_sock *tp,
 	}
 
 	if (tp)
-		mptcp_set_rwin(tp);
+		mptcp_set_rwin(tp, th);
 }
 
 __be32 mptcp_get_reset_option(const struct sk_buff *skb)
-- 
2.35.1

