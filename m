Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795254176;
	b=YjqZQefXFLJJvF6by1/iZwQLeDRS48EZIMCYOQtsZavZhfC2m4Mg69uevBws2HDZ4Bj6
	 SwuWJgkIHAwZjxTvI26bElH7+LlK/TWnJoSUETIWXdHwMVBwUKhrnN9Hca7Vh1lAPJURn
	 vNGx+ubJWD2xg9gIk30Gpb5jr4KKBdXEUn9+9I7Wq05ZrPymfvGRfzJPXD9Ge2EiGTw5d
	 munhmTkXkKRjPrwfVk8bsBHsOwiodZih0M6Ov8PfBSWwXnQ3EkOjZ0F4TqMVN3o0fA2Ks
	 lfIrz4V7SuubQpZn2qMKaDRBiRcRMQYCqjnLrS6Kud9b05zysqnR3pcSzeWuLSccSsA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795254176;
	h=Received:DKIM-Signature:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer:X-Developer-Signature:X-Developer-Key;
	bh=Xdrt5w1R5LjP+KDKrix57OSRRqEUv4PvitUriQVLBuU=;
	b=H++6M3hW8hucWgepFPxUqa8SY2v1szW38NzWwpc7o2Axc493k2EUDh2hPEA5X1aZRVJW
	 BNjrvxMh19Cauz4Hw3rxIdRYYk7GBc5T5qyx3lWMOB0z8BwrcmtLXi6IvRhXGyBd0qH/m
	 Mzw9Td7mye+Fbyk0jjnRlO8Iim0FSb02kllQOhRGl6fmZROY2X/ns3T4yVELB4XQfINZ5
	 b3Xdd2GbSvwka93stdImn4Xsr1A8jK14NtbHd0Oe4V89d+fZbKUmh6Gg65emiG+fbrQjM
	 YQi+mM5GArRcX+69AT/2/foIEMOLNWOo0QVe4o7D1Hl+7SQZY/ZywB1kQ6OwJN7wW/g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=nwzSDAiJ;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F347F606A325
	for <mptcp@lists.linux.dev>; Sat, 21 Nov 2026 09:42:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=nwzSDAiJ
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6B78D1F000C6;
	Sat, 21 Nov 2026 09:42:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795254175;
	bh=Xdrt5w1R5LjP+KDKrix57OSRRqEUv4PvitUriQVLBuU=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=nwzSDAiJthWjHk0JAueF4wbEq5+M2Kcyr8QehF34eo7B+zfUMp1qGUT1Ca7gvSOv4
	 tK/2tCaa1EWKhOCQVeFoSMuSlPWtL4fcZtIb4jjfhy/IqUp3HT9ltvZASDvGJiaxBW
	 rQUhZwWdj0ZWESqGcc+vRuuo3W8PVAtKCCUPy6Kp91JLMVX7pEEsgqd5g3Z/aWfKul
	 qEhXmMj0mjqbXY/gZJcsKNE99Oo0LZVZxvud6CLL0eBk/8FQNfLy84rW5u6LMy+G9/
	 KzpagyYFlA9UACoPoZgUbwoC0PCy8EQLxqUfkDdMQon7XcbKsJhw6UjTC7BRTZC6Dj
	 asC9Aw1f5bFGQ==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Sat, 21 Nov 2026 10:41:40 +0100
Subject: [PATCH mptcp-net v2 42/62] mptcp: don't resend data acked without
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
Message-Id: <20261121-mptcp-cmason-fixes-v2-42-00327fd1de1f@kernel.org>
References: <20261121-mptcp-cmason-fixes-v2-0-00327fd1de1f@kernel.org>
In-Reply-To: <20261121-mptcp-cmason-fixes-v2-0-00327fd1de1f@kernel.org>
To: MPTCP Linux <mptcp@lists.linux.dev>
Cc: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
X-Mailer: b4 0.17-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=6292; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=nsoQ9WbBTuzw4hzMhdIsx19IcJEBMKWOCXo6iCfMQhE=;
 b=owGbwMvMwCVWo/Th0Gd3rumMp9WSGLIZ09PVN8yt3nuksfutSaDoHDGuuSLcxh+Znmy+Wnfr4
 kZLuQPvO0pZGMS4GGTFFFmk2yLzZz6v4i3x8rOAmcPKBDKEgYtTACaiGsrwv5Djs1L01L9evxYk
 Kmn9L3x9fboyq9xqwbvvUiyirmqub2b4py2rv/mSuv/TncY6sgyLNY8anFsj0v5LxHrXfq4/14L
 iWQE=
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
index b60c54ea4d3f..d90e6a5cc9ff 100644
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

