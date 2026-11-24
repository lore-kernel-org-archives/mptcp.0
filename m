Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795557694;
	b=0RiqQrZVcx0Z0MjhAhM2gyD4KSMwEqHIwjni5TS/A2d69hAC4c8kQ/be6KwwIE6BUeFq
	 XouOn6agcplDQ9xvzd7h0roWbthzENTqIBd4ZnzVwDc6tV1t5mAh1a4GvnHclH2nOUtJW
	 +ARzH2Vw9+kgXZhTnPixorsWIwfI9HlLLv/kcaTwB0IRATaykR0kgdoURFsGDz2KsOSfv
	 l0bxizyLC2rhQD6cQKY4tUxQ2t/bsXieDMaEqrUwrhnWDvGaL0+3VnkUv/j4c/tH8JJXN
	 yS1ptMJuGN1whldgh/e4SxiGzy4c25zjWlVonaafudsgYAjQA6T6/P4DwmA1BsVSyBw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795557694;
	h=Received:DKIM-Signature:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer:X-Developer-Signature:X-Developer-Key;
	bh=SbaFXsGT7fuPHR5UWWmCiDZfgmps0HkqJ+MfFP3I9xc=;
	b=kR0W1IOc+o0zvrVJ8Y8AHqv4RzPagCZKvPZT7ib01J7yMQrfZFwjuUTUhtHdMOLFblH9
	 GQDAgtFoeyCxOWLnINUST17I4m+czgRyfD9z+Nm+3SrcGQwdGR2xBkMmdFrjHUPkQ0ew4
	 YzdMb+AdjL1KHZSwNuhV1i+avTr2rcK4sY73yxw9l398LmV5TXL+foghT8otopW5Jw7uc
	 q4THJbTB94joPTeLG+o34u3POQhm188FRNomqQoC4yhmyBuSRfuiOK611lJYFmqq7W2bl
	 wfXtySWbHRFJy4I8e5cOvSLblFN/DoFp7xUWnrajbCE6KKZV+UUMhQs3ez9IMDVSNZQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=YOLluSiW;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CBFE606A321
	for <mptcp@lists.linux.dev>; Tue, 24 Nov 2026 22:01:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=YOLluSiW
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 22DD61F000C0;
	Tue, 24 Nov 2026 22:01:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795557693;
	bh=SbaFXsGT7fuPHR5UWWmCiDZfgmps0HkqJ+MfFP3I9xc=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=YOLluSiWqK4LbcUBySL8mnePbSQHpQjCcUeMS9DhJtXDu0nYyUDJYL9y6G1XXb7TN
	 59ZRAnMD2oqtmjuspucOXoD4VX6yBYhseWdPRq9Tr3nWtbmC3gACUsCqMXbJZ9yhoy
	 hU7hKDnXRGhFGvCRjvxAJqQFFTSjzxqmSCo40MFxkxQSZqcGj8vOn/2ToN+7H/hv/+
	 pWsSU/ejUCnA57gYudXmqLD/ijmNZZqibWoM1AUawupVcV99Xg8fxr0AUrR4rWNFTP
	 IkK2j2tRfzgja0J4uEsqIgG3vOUM19zFCBFixa+Mx2PRGLzaoDmmxUfSq4vkuucdML
	 /BMzlTup8qU9Q==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Tue, 24 Nov 2026 22:59:46 +0100
Subject: [PATCH mptcp-net v3 29/50] mptcp: don't resend data acked without
 MPTCP opts
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Post: <mailto:mptcp@lists.linux.dev>
List-Help: <mailto:mptcp+help@lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
List-Owner: <mailto:mptcp+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261124-mptcp-cmason-fixes-v3-29-416c0920c73f@kernel.org>
References: <20261124-mptcp-cmason-fixes-v3-0-416c0920c73f@kernel.org>
In-Reply-To: <20261124-mptcp-cmason-fixes-v3-0-416c0920c73f@kernel.org>
To: MPTCP Linux <mptcp@lists.linux.dev>
Cc: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
X-Mailer: b4 0.17-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=6292; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=b0sbObVPUklcRlQb2fyz6cha546UixdHB43nZqU4gXI=;
 b=owGbwMvMwCVWo/Th0Gd3rumMp9WSGLLZODkOeKxRjgv+1mEVU2bP/uqi0vyf0z0eMvVxSN8TX
 rTsa7JtRykLgxgXg6yYIot0W2T+zOdVvCVefhYwc1iZQIYwcHEKwESeZTAy3NjVx+lmYFN3l7vr
 Umb8vv7gBi7RZG/NN3ZPW8wfbJV+xvBXOMhkAqvQ1y2b2FR8rMwWyD6eZCvYtmG1jODSiBtu2+2
 ZAA==
X-Developer-Key: i=matttbe@kernel.org; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

The previous commit resets the subflow, instead of resending data that
has been acked without MPTCP options, but only if this data had already
been resent. Data acked without these options the first time was still
resent once: a peer that had fallen back to TCP alone, e.g. because a
middlebox removed the DSS of new data after a zero window probe,
delivered it a second time to the application, without error.

Track the TCP sequence number acked with MPTCP options, to also catch
data acked without them the first time. Only before any MP_JOIN subflow
has been established: after that, the peer can no longer fall back to
TCP, and the Data ACK can be omitted when its value does not advance,
see RFC 8684, sections 3.7 and 3.3.2. On a single subflow, a peer
omitting the Data ACK like this can then see its subflow reset if this
Data ACK is lost, as before at the next resend, or if it drops data
after having acked it at the TCP level.

This issue has been reported by Clashiko, and reproduced with a new
Packetdrill test: data acked without MPTCP options was resent at the
MPTCP level, instead of a reset:

  dss_resend_after_bare_ack_reset_server.pkt:28: error handling packet: live packet payload: expected 0 bytes vs actual 1000 bytes

Two other new tests check that this data is still resent after a join,
but not after a join rejected by the peer.

Fixes: 119d51e225fe ("mptcp: fallback when MPTCP opts are dropped after 1st data")
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
v2: new, for an issue spotted by Clashiko
---
 net/mptcp/options.c  | 19 ++++++++++++++-----
 net/mptcp/protocol.c | 11 ++++++++---
 net/mptcp/protocol.h |  2 ++
 net/mptcp/subflow.c  |  2 ++
 4 files changed, 26 insertions(+), 8 deletions(-)

diff --git a/net/mptcp/options.c b/net/mptcp/options.c
index f9b65d0c6290..05b9c66aaed6 100644
--- a/net/mptcp/options.c
+++ b/net/mptcp/options.c
@@ -1055,6 +1055,10 @@ static bool check_fully_established(struct mptcp_sock *msk, struct sock *ssk,
 		WARN_ONCE(1, "bogus mpc option on established client sk");
 
 set_fully_established:
+	/* the peer can no longer fall back to TCP */
+	if (subflow->request_join)
+		set_bit(MPTCP_JOINED, &msk->flags);
+
 	if (mp_opt->deny_join_id0)
 		WRITE_ONCE(msk->pm.remote_deny_join_id0, true);
 
@@ -1287,11 +1291,16 @@ bool mptcp_incoming_options(struct sock *sk, struct sk_buff *skb)
 	if (!check_fully_established(msk, sk, subflow, skb, &mp_opt))
 		return sk->sk_state != TCP_CLOSE;
 
-	/* MPTCP opt acking the old data, not an infinite map: no fallback */
-	if (unlikely(subflow->old_data_pending) && mp_opt.suboptions &&
-	    !(mp_opt.use_map && !mp_opt.data_len) &&
-	    !before(TCP_SKB_CB(skb)->ack_seq, subflow->old_data_end))
-		subflow->old_data_pending = 0;
+	/* MPTCP opts, not an infinite map: the peer did not fall back */
+	if (mp_opt.suboptions && !(mp_opt.use_map && !mp_opt.data_len)) {
+		u32 ack_seq = TCP_SKB_CB(skb)->ack_seq;
+
+		if (after(ack_seq, subflow->opt_ack_seq))
+			subflow->opt_ack_seq = ack_seq;
+		if (unlikely(subflow->old_data_pending) &&
+		    !before(ack_seq, subflow->old_data_end))
+			subflow->old_data_pending = 0;
+	}
 
 	if (unlikely(mp_opt.suboptions != OPTION_MPTCP_DSS)) {
 		if ((mp_opt.suboptions & OPTION_MPTCP_FASTCLOSE) &&
diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index 61cc4ae2a7b8..f3dd15293bc8 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -1090,6 +1090,9 @@ static void mptcp_subflow_joined(struct mptcp_sock *msk, struct sock *ssk)
 {
 	mptcp_subflow_ctx(ssk)->map_seq = READ_ONCE(msk->ack_seq);
 	msk->allow_infinite_fallback = false;
+	/* an active join is added once fully established, see options.c */
+	if (!mptcp_subflow_ctx(ssk)->request_join)
+		set_bit(MPTCP_JOINED, &msk->flags);
 	mptcp_event(MPTCP_EVENT_SUB_ESTABLISHED, msk, ssk, GFP_ATOMIC);
 }
 
@@ -1557,10 +1560,12 @@ static int mptcp_sendmsg_frag(struct sock *sk, struct sock *ssk,
 		copy = 1;
 	}
 
-	/* old data acked without MPTCP opts: the peer may have fallen back */
+	/* data acked without MPTCP opts: the peer may have fallen back, only
+	 * possible before a join, see RFC 8684
+	 */
 	if (unlikely(before64(data_seq, msk->snd_nxt) &&
-		     subflow->old_data_pending &&
-		     !before(tcp_sk(ssk)->snd_una, subflow->old_data_end))) {
+		     !test_bit(MPTCP_JOINED, &msk->flags) &&
+		     after(tcp_sk(ssk)->snd_una, subflow->opt_ack_seq))) {
 		tcp_remove_empty_skb(ssk);
 		MPTCP_INC_STATS(sock_net(ssk), MPTCP_MIB_FALLBACKFAILED);
 		subflow->reset_transient = 0;
diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
index dfeabe03180b..d0ae782c9ade 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -118,6 +118,7 @@
 #define MPTCP_WORK_CLOSE_SUBFLOW 3
 #define MPTCP_RTX_ENABLED	4
 #define MPTCP_ORPHAN_COUNTED	5
+#define MPTCP_JOINED		6
 
 /* MPTCP socket release cb flags */
 #define MPTCP_PUSH_PENDING	1
@@ -648,6 +649,7 @@ struct mptcp_subflow_context {
 	int     cached_sndbuf;	    /* sndbuf size when last synced with the msk sndbuf,
 				     * protected by the msk socket lock
 				     */
+	u32	opt_ack_seq;	    /* highest TCP ack_seq with MPTCP opts */
 
 	struct	sock *tcp_sock;	    /* tcp sk backpointer */
 	struct	sock *conn;	    /* parent mptcp_sock */
diff --git a/net/mptcp/subflow.c b/net/mptcp/subflow.c
index a216d88d35ee..3590c1207e88 100644
--- a/net/mptcp/subflow.c
+++ b/net/mptcp/subflow.c
@@ -587,6 +587,7 @@ static void subflow_finish_connect(struct sock *sk, const struct sk_buff *skb)
 
 	msk = mptcp_sk(parent);
 	subflow->rel_write_seq = 1;
+	subflow->opt_ack_seq = tcp_sk(sk)->snd_una;
 	subflow->conn_finished = 1;
 	subflow->ssn_offset = TCP_SKB_CB(skb)->seq;
 	pr_debug("subflow=%p synack seq=%x\n", subflow, subflow->ssn_offset);
@@ -2161,6 +2162,7 @@ static void subflow_ulp_clone(const struct request_sock *req,
 	new_ctx->tcp_state_change = old_ctx->tcp_state_change;
 	new_ctx->tcp_error_report = old_ctx->tcp_error_report;
 	new_ctx->rel_write_seq = 1;
+	new_ctx->opt_ack_seq = tcp_rsk(req)->snt_isn + 1;
 
 	if (subflow_req->mp_capable) {
 		/* see comments in subflow_syn_recv_sock(), MPTCP connection

-- 
2.55.0

