Received: from mail-ot1-f43.google.com (mail-ot1-f43.google.com [209.85.210.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E016387346
	for <mptcp@lists.linux.dev>; Sat, 14 Mar 2026 20:14:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773519296; cv=none; b=cnCdK7OvmXydv1PgpjeTWdP4Gs4826kv94xKJvRImfkQvPwrZFvEEnwGeTLtIvK2fI4Q0p+M9NXBVqCYjLDUM4YOftnK+32U6YlN2tL3vIq1I5rAB48eYyCG3HxwMeB9U0hPDuKqB1zx58uqZeIcbm1O8RQAbu0b8NaSeax5kIk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773519296; c=relaxed/simple;
	bh=ww0RG9/Q0OVKyskNxv3bbhNoq1jg/FnsAuo6CN8DsUQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=T8Kb4FDUyzk2Q2dZGVNFSLailWDlys7QJTsnTITqU8L5+f3em64DiVGaGuRPj7ri9bO+VT/PY0oS7p1b65DIgyjK/uEDcggaw/GQtbym+cou1/Prhtt68x/02F/Tbqr6EwX3NVocjJUpYoATRksdoIAaaeEIqaaCD9YnEGi7UUc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eHLejRVL; arc=none smtp.client-ip=209.85.210.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eHLejRVL"
Received: by mail-ot1-f43.google.com with SMTP id 46e09a7af769-7d743cd9e5bso2272428a34.2
        for <mptcp@lists.linux.dev>; Sat, 14 Mar 2026 13:14:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773519292; x=1774124092; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LSj81+CF0f4yFIE+he2UWBsfbEKSyH1G8KBdb3oc/PY=;
        b=eHLejRVLqU9dYFkUftIWzMt3ctY7QpkF58kOEWioDjykSVs3mwS0CM3hFeavIqtzyD
         76DAntxN+dCSO3fQ3KHfYc9bgC3N0IXMP3rDXasmq482YVSy+Mb1DavFfJAEwCWo21hm
         L9WgWyD7hGinnwuTJ0FOKljhdxY3B5eNPqqnCyCSFqKMESLr8iS84YHTcZraBNpkWRWk
         o7rxpNBKLf7HyZjf/hZ55JrsQAhKg5ktDr2weUtFGndl3Can014sQ95QesY0/I3rKtUp
         DgpJoGp/iaiIvuTeL5TMPRi59B0+RMz7S61lbrBaZ582kvyzuRsraQSx2biBnSqTasHR
         YHzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773519292; x=1774124092;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=LSj81+CF0f4yFIE+he2UWBsfbEKSyH1G8KBdb3oc/PY=;
        b=o1j3BAaqp4bhX25TmGM2C7WAbuNcpV7DFFbUGHNjqIIyb5ZrsAo4s1PtxxCxLkR66q
         Gmv/t7R0JVc7Es8O/X2eEnATdSa5h6ujLVWkh7dNrzlLUIFLxfqignly43cFXVyxrUE8
         FKYB34LluZRBVZjtR7HCXErZ6OsSgTq2y0wWoT6temQfG3b/dGJHjyOg7Io+MrN2rEP6
         vP6JblelrgebqqcqjOGtOVjUbDDLr98nbN7kYh3oDkbGynhjW/yJg7FXNwiOLfRe5XDe
         7Nho6bALRD9FcKqvfwrI2j2PDSAZvYVXz6APAe5z4Qm5pk0Fl7DGNs0v5npn6MjfIS/C
         SxDw==
X-Forwarded-Encrypted: i=1; AJvYcCWYPZJG0MNMispBKyvCk1dfsdQMg6ec7y1RhbZwRP+HIyT0wVpP8xZij2BMqv2M2pJcOhVg5w==@lists.linux.dev
X-Gm-Message-State: AOJu0YyRGeJ3DCAITSx/fOPHRbeDxVPSyC5tyQoaxuS1YziT41YvJqy5
	krZ18Qq7BJUdK/VZnAi6GtAy5XEhMojJJGAB7zF9agTQMjVnULIvYSCU
X-Gm-Gg: ATEYQzwrsAwOqxscSBXDbTeMi70/vVMmP5s/elK1tpMOVPqIpmhMpj7RP9eD6N3m8WY
	VhAuvQsnyDJOvXaqUksvXKCcRhOjU4nISzj9N7wWrRE7YSbDM+uRluscxujrFHxfs0AUeFd9Oll
	yaJop/qFTdPxnJqsbeHzC6cHf3ZLJj0mSwLKhhHNa9QemkT/2PQMKLa2YUZwXdFUC+AC/gh4yOZ
	haBfWp6UhjBzWr1qWIcqMSRFiw2Z2a8kJKhjTN0k9oB3IwjwnRl1Mfj2N2yTV7XV+Lg/DU148jC
	J0isGf2ONTD7WZ8XJHQDMmigvMpntdTleQ8kwt9s2JSvpE5lnNVFElWUP8MH7PcnD4A2C00cK56
	1TnNSykQPY9JtzwOGsTx/FXfSNo5pn8jaOBxvRtQ+WMDDfrwLWgxBCMTepGkGyajY8zn78706Dw
	jNGOn4pWHfLrh1wTAa5E+dZvmJjsTOReSTHeZ05dxItajDlGgsLE9QEVy0cHU5ePgD+Ftyrn+pB
	VyyfQ6rHsTjtkeIfo6sGr8PFl/SOWFLzDo+NCJptJT3V+CJZGI=
X-Received: by 2002:a05:6870:309:b0:40e:95b9:40e6 with SMTP id 586e51a60fabf-417b946c51fmr4109655fac.40.1773519292142;
        Sat, 14 Mar 2026 13:14:52 -0700 (PDT)
Received: from Atwell-Laptop.. (108-212-132-20.lightspeed.irvnca.sbcglobal.net. [108.212.132.20])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-4177e5e8185sm11914165fac.12.2026.03.14.13.14.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 14 Mar 2026 13:14:51 -0700 (PDT)
From: atwellwea@gmail.com
To: netdev@vger.kernel.org,
	davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	edumazet@google.com,
	ncardwell@google.com
Cc: linux-kernel@vger.kernel.org,
	linux-api@vger.kernel.org,
	linux-doc@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	mptcp@lists.linux.dev,
	dsahern@kernel.org,
	horms@kernel.org,
	kuniyu@google.com,
	andrew+netdev@lunn.ch,
	willemdebruijn.kernel@gmail.com,
	jasowang@redhat.com,
	skhan@linuxfoundation.org,
	corbet@lwn.net,
	matttbe@kernel.org,
	martineau@kernel.org,
	geliang@kernel.org,
	rostedt@goodmis.org,
	mhiramat@kernel.org,
	mathieu.desnoyers@efficios.com,
	0x7f454c46@gmail.com
Subject: [PATCH net-next v2 07/14] tcp: honor the maximum advertised window after live retraction
Date: Sat, 14 Mar 2026 14:13:41 -0600
Message-ID: <20260314201348.1786972-8-atwellwea@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260314201348.1786972-1-atwellwea@gmail.com>
References: <20260314201348.1786972-1-atwellwea@gmail.com>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Wesley Atwell <atwellwea@gmail.com>

If receive-side accounting retracts the live rwnd below a larger
sender-visible window that was already advertised, allow one in-order
skb within that historical bound to repair its backing and reach the
normal receive path.

Hard receive-memory admission is still enforced through the existing
prune and collapse path. The rescue only changes how data already
inside sender-visible sequence space is classified and backed.

Signed-off-by: Wesley Atwell <atwellwea@gmail.com>
---
 net/ipv4/tcp_input.c | 92 +++++++++++++++++++++++++++++++++++++++++---
 1 file changed, 86 insertions(+), 6 deletions(-)

diff --git a/net/ipv4/tcp_input.c b/net/ipv4/tcp_input.c
index d76e4e4c0e57..4b9309c37e99 100644
--- a/net/ipv4/tcp_input.c
+++ b/net/ipv4/tcp_input.c
@@ -5376,24 +5376,86 @@ static void tcp_ofo_queue(struct sock *sk)
 static bool tcp_prune_ofo_queue(struct sock *sk, const struct sk_buff *in_skb);
 static int tcp_prune_queue(struct sock *sk, const struct sk_buff *in_skb);
 
+/* Sequence checks run against the sender-visible receive window before this
+ * point. If later receive-side accounting retracts the live receive window
+ * below the maximum right edge we already advertised, allow one in-order skb
+ * which still fits inside that sender-visible bound to reach the normal
+ * receive queue path.
+ *
+ * Keep receive-memory admission itself on the legacy hard-cap path so prune
+ * and collapse behavior stay aligned with the established retracted-window
+ * handling.
+ */
+static bool tcp_skb_in_retracted_window(const struct tcp_sock *tp,
+					const struct sk_buff *skb)
+{
+	u32 live_end = tp->rcv_nxt + tcp_receive_window(tp);
+	u32 max_end = tp->rcv_nxt + tcp_max_receive_window(tp);
+
+	return after(max_end, live_end) &&
+	       after(TCP_SKB_CB(skb)->end_seq, live_end) &&
+	       !after(TCP_SKB_CB(skb)->end_seq, max_end);
+}
+
 static bool tcp_can_ingest(const struct sock *sk, const struct sk_buff *skb)
 {
-	unsigned int rmem = atomic_read(&sk->sk_rmem_alloc);
+	return tcp_rmem_used(sk) <= READ_ONCE(sk->sk_rcvbuf);
+}
+
+/* Caller already established that @skb extends into the retracted-but-still-
+ * valid sender-visible window. For in-order progress, regrow sk_rcvbuf before
+ * falling into prune/forced-mem handling.
+ *
+ * This path intentionally repairs backing for one in-order skb that is already
+ * within sender-visible sequence space, rather than treating it like ordinary
+ * receive-buffer autotuning.
+ *
+ * Keep this rescue bounded to the span accepted by this skb instead of the
+ * full historical tp->rcv_mwnd_seq. However, never grow below skb->truesize,
+ * because sk_rmem_schedule() still charges hard memory, not sender-visible
+ * window bytes.
+ */
+static void tcp_try_grow_retracted_skb(struct sock *sk,
+				       const struct sk_buff *skb)
+{
+	struct tcp_sock *tp = tcp_sk(sk);
+	int needed = skb->truesize;
+	int span_space;
+	u32 span_win;
+
+	if (TCP_SKB_CB(skb)->seq != tp->rcv_nxt)
+		return;
+
+	span_win = TCP_SKB_CB(skb)->end_seq - tp->rcv_nxt;
+	if (TCP_SKB_CB(skb)->tcp_flags & TCPHDR_FIN)
+		span_win--;
+
+	if (tcp_space_from_rcv_mwnd(tp, span_win, &span_space))
+		needed = max_t(int, needed, span_space);
 
-	return rmem <= sk->sk_rcvbuf;
+	tcp_try_grow_rcvbuf(sk, needed);
 }
 
+/* Sender-visible window rescue does not relax hard receive-memory admission.
+ * If growth did not make room, fall back to the established prune/collapse
+ * path.
+ */
 static int tcp_try_rmem_schedule(struct sock *sk, const struct sk_buff *skb,
 				 unsigned int size)
 {
-	if (!tcp_can_ingest(sk, skb) ||
-	    !sk_rmem_schedule(sk, skb, size)) {
+	bool can_ingest = tcp_can_ingest(sk, skb);
+	bool scheduled = can_ingest && sk_rmem_schedule(sk, skb, size);
+
+	if (!scheduled) {
+		int pruned = tcp_prune_queue(sk, skb);
 
-		if (tcp_prune_queue(sk, skb) < 0)
+		if (pruned < 0)
 			return -1;
 
 		while (!sk_rmem_schedule(sk, skb, size)) {
-			if (!tcp_prune_ofo_queue(sk, skb))
+			bool pruned_ofo = tcp_prune_ofo_queue(sk, skb);
+
+			if (!pruned_ofo)
 				return -1;
 		}
 	}
@@ -5629,6 +5691,7 @@ void tcp_data_ready(struct sock *sk)
 static void tcp_data_queue(struct sock *sk, struct sk_buff *skb)
 {
 	struct tcp_sock *tp = tcp_sk(sk);
+	bool retracted;
 	enum skb_drop_reason reason;
 	bool fragstolen;
 	int eaten;
@@ -5647,6 +5710,7 @@ static void tcp_data_queue(struct sock *sk, struct sk_buff *skb)
 	}
 	tcp_cleanup_skb(skb);
 	__skb_pull(skb, tcp_hdr(skb)->doff * 4);
+	retracted = skb->len && tcp_skb_in_retracted_window(tp, skb);
 
 	reason = SKB_DROP_REASON_NOT_SPECIFIED;
 	tp->rx_opt.dsack = 0;
@@ -5667,6 +5731,9 @@ static void tcp_data_queue(struct sock *sk, struct sk_buff *skb)
 			    (TCP_SKB_CB(skb)->tcp_flags & TCPHDR_FIN))
 				goto queue_and_out;
 
+			if (retracted)
+				goto queue_and_out;
+
 			reason = SKB_DROP_REASON_TCP_ZEROWINDOW;
 			NET_INC_STATS(sock_net(sk), LINUX_MIB_TCPZEROWINDOWDROP);
 			goto out_of_window;
@@ -5674,7 +5741,20 @@ static void tcp_data_queue(struct sock *sk, struct sk_buff *skb)
 
 		/* Ok. In sequence. In window. */
 queue_and_out:
+		if (unlikely(retracted))
+			tcp_try_grow_retracted_skb(sk, skb);
+
 		if (tcp_try_rmem_schedule(sk, skb, skb->truesize)) {
+			/* If the live rwnd collapsed to zero while rescuing an
+			 * skb that still fit in sender-visible sequence space,
+			 * report zero-window rather than generic proto-mem.
+			 */
+			if (unlikely(!tcp_receive_window(tp) && retracted)) {
+				reason = SKB_DROP_REASON_TCP_ZEROWINDOW;
+				NET_INC_STATS(sock_net(sk),
+					      LINUX_MIB_TCPZEROWINDOWDROP);
+				goto out_of_window;
+			}
 			/* TODO: maybe ratelimit these WIN 0 ACK ? */
 			inet_csk(sk)->icsk_ack.pending |=
 					(ICSK_ACK_NOMEM | ICSK_ACK_NOW);
-- 
2.43.0

