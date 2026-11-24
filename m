Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795557720;
	b=5YxtG6uU3762spT5ohYRvwkpCsSuZu/S2r/Y67RL0DJRPBHIcLoKhjqTMbsVbMMF4LFP
	 0UoAVdkNB7gvE0zwyf2nbfTQvWWW46+5L3NbV4kgvbK3h8SmvClnDSnIx0sJvXI7Z3Prc
	 FCQiwH+Fe0kqe/XDs1G9Y5QihySdE57JGETPvNKGnJiqzbn9z6gjtGjZPVeOAh8709U8r
	 Y4Zvn1dKYnLXJGW5kHOqh32WAAZH0rXU6uksOzRzPWN57/vnEMK/9i7jEqXDEVpSJ6rzl
	 aYwhhJ14kixPJTxNaYzkEL0U1p3o8B0A9QbsrxM/Z38TQ70F7wuBgnxY1uRZ8mO8KAg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795557720;
	h=Received:DKIM-Signature:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer:X-Developer-Signature:X-Developer-Key;
	bh=O16Xz9pcsCpx+Y4NNFZRTY55w9BCwh9Bvb1j8eCRXUs=;
	b=4pH9I+/+WUr9v7bRCuM2khNEKQuRYXSwZqF+UxOrrWAeBikkoAbte3cBAwvSZh4b9fZd
	 FFvL5ReLIm8RHcPDknLKmV7ZGOU3GsZuFunQr9di02WYSw5nUWhZkqdhSL/Oarxdoe4GN
	 jpqsuLriWFdQajqQlEO7S9Ya7H/gmcNVl4ZDOJPt9461n+ftz/j9Kgk3w8na7R84nlR1W
	 Cf28j/FUVwqWFtBiJ7chHmmVW1pXDj5wCIU0AuRSjH8qMqEe01HqPj+p6JGwWWLsvRIg/
	 1PH/A93+/JJsB1lDakkVOO91H+BY8rhBf3o2p8u5RIrxSeJzaiKltm0Ki8WTeGHq3yg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=GGQlrGgK;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03172606A31E
	for <mptcp@lists.linux.dev>; Tue, 24 Nov 2026 22:02:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=GGQlrGgK
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1ED0A1F000C4;
	Tue, 24 Nov 2026 22:01:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795557719;
	bh=O16Xz9pcsCpx+Y4NNFZRTY55w9BCwh9Bvb1j8eCRXUs=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=GGQlrGgK8IeIVhgSHPfLzdwh5LorSA4IbpJqwf8nBuwSVh76pisYgUMaXV+SZUsVP
	 2ZNtFUmwKt/Or6UOPEaoKgT9nfWFel3Mi+FS2Gh+7vXaXdec4JdWyWZndnwU8R84qr
	 TY2eGgrrudxKE5cit134/CrfMw8HzINxWkNFlZRm2DmlNie/ZJOlsKlX2KQvmlVAqi
	 +D1khUepZt22cr8l8jQZxbbvgaEb4xIpLeYOx/fBQSi3qHeWvBxK9WPqzu7cKoGa86
	 zmhR2AJhfklZKU8gfXhaZ3NhIsbSlLaJXDzx3/h1OJlnbRIFReuU0Gezqq5phL5MJ7
	 GtlU0MjTUuoMA==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Tue, 24 Nov 2026 23:00:07 +0100
Subject: [PATCH RFC mptcp-next mptcp-net v3 50/50] mptcp: reset when the
 DSS disappears after a DATA_ACK
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
Message-Id: <20261124-mptcp-cmason-fixes-v3-50-416c0920c73f@kernel.org>
References: <20261124-mptcp-cmason-fixes-v3-0-416c0920c73f@kernel.org>
In-Reply-To: <20261124-mptcp-cmason-fixes-v3-0-416c0920c73f@kernel.org>
To: MPTCP Linux <mptcp@lists.linux.dev>
Cc: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
X-Mailer: b4 0.17-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=9776; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=nOnbLzuo+GXABWI9YVoTiXdZ4ouMQ6YwdR/jgxDXZ6k=;
 b=owGbwMvMwCVWo/Th0Gd3rumMp9WSGLLZOMWmJQibrQ7Rmp4uq3hnb4uuekRO+waOfd8lNor4M
 1ju+jupo5SFQYyLQVZMkUW6LTJ/5vMq3hIvPwuYOaxMIEMYuDgFYCLvwxkZtiWe52x7EuPWcTZa
 b4PM92OVfHbP7W4crxY5w/LpmUfZBIa/YqvXvf/CxMtpodv0s4RD/ZHyxlXTRFuvn7oqca4uMGg
 hGwA=
X-Developer-Key: i=matttbe@kernel.org; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

RFC 8684, section 3.7, describes a fallback to TCP for the case where
the MPTCP options get through on the SYN, but not on the next packets.
A sender includes a DSS option in each segment "until one of the sent
segments has been acknowledged with a DSS option containing a Data
ACK": it then has "the confirmation that the DSS option passes in both
directions". After that, a subflow that loses its MPTCP options "SHOULD
be treated as broken and closed with a RST", with the "Middlebox
interference" reason. It's a *SHOULD*.

Commit 119d51e225fe ("mptcp: fallback when MPTCP opts are dropped after
1st data") did this fallback as long as allow_infinite_fallback is set,
i.e. also after this confirmation, and left the check of the DATA_ACK
for later [1]. Such a late fallback is fragile: the peer might still
resend data that was mapped before, or a zero window probe might have
mapped old data again. The previous commits "mptcp: do not fallback
while old data is in flight", "mptcp: stop resending data to a peer that
fell back", "mptcp: don't resend data acked without MPTCP opts" and
"mptcp: continue the last mapping after a fallback" handle these cases,
except one: if only the receiver falls back, it can deliver data resent
at the MPTCP level as new data, if the sender does not reset the subflow
before, e.g. with an older kernel. Yeah, a very specific corner case.

Now, when data without DSS is found on a subflow, the subflow is reset
if a DATA_ACK received on it acknowledged data that had been sent: the
MPTCP options then passed in both directions. Except after an MP_FAIL
exchange: a fallback to TCP is then in progress, so data without DSS is
expected, even if the infinite mapping has not been seen. This also
closes the case above, but only for a receiver whose data has been
acknowledged.

Receiving a DATA_ACK is not enough: when the MPTCP options are only
dropped in one direction, the peer can fall back while the DATA_ACKs it
sent before acknowledged no data. A client that is not fully
established falls back when a packet from the server has no MPTCP
options, e.g. an ACK of its data, and the other hosts when they receive
data without DSS. Except after an MP_FAIL, Linux falls back without
sending an infinite mapping, then sends data without DSS: the other
side can only fall back too, as before, if its data had not been
acknowledged. For the same reason, the amount of received data -- e.g.
more than an initial window -- is not used.

The same is done when a mapping is invalid, e.g. when it does not cover
the received data after a resegmentation by a middlebox, but not for an
infinite mapping, the fallback signal from the RFC: it gets a new
MAPPING_INFINITE status, also named in the tracepoint.

When a middlebox starts dropping the MPTCP options in the middle of a
connection, after a DATA_ACK acknowledged data, the subflow is then
reset, instead of falling back to TCP when it was safe. If it was the
only subflow, the MPTCP connection stays without subflow until the
close timeout -- 60 seconds by default, see net.mptcp.close_timeout --
unless a new one is created in between.

New Packetdrill tests check these resets.

Closes: https://github.com/multipath-tcp/mptcp_net-next/issues/519 [1]
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
v2: also reset on an invalid mapping (Clashiko), and commit message: the
    remaining case is now handled by the sender
v3: name MAPPING_INFINITE in the tracepoint, and msg: all the invalid
    mappings (Clashiko)

Note: this commit changes the behaviour, it is for next. It fixes a very
specific corner case (but it follows what the RFC 8684 recommends to do)
but for that it needs an extra flag and more checks. Is it worth it? (I
think so, but that's why it is flagged as RFC.)

Note (Clashiko on v2): subflow_nodss_is_fatal() also handles the invalid
mappings, and the description of MPTCP_MIB_DSSRESET is imprecise: to be
improved if this RFC is accepted.

Note (Sashiko on v2): an skb going past the end of its mapping is still
handled by mptcp_dss_corruption(), which falls back, even after a
DATA_ACK: to be covered too if this RFC is accepted.
---
 include/trace/events/mptcp.h |  3 ++-
 net/mptcp/options.c          | 11 +++++++----
 net/mptcp/protocol.h         |  3 ++-
 net/mptcp/subflow.c          | 29 +++++++++++++++++++++++++----
 4 files changed, 36 insertions(+), 10 deletions(-)

diff --git a/include/trace/events/mptcp.h b/include/trace/events/mptcp.h
index ebc7408c1fa6..527eb7a18528 100644
--- a/include/trace/events/mptcp.h
+++ b/include/trace/events/mptcp.h
@@ -21,7 +21,8 @@
 		{ 3, "MAPPING_DATA_FIN" },				\
 		{ 4, "MAPPING_DUMMY" },					\
 		{ 5, "MAPPING_BAD_CSUM" },				\
-		{ 6, "MAPPING_NODSS" })
+		{ 6, "MAPPING_NODSS" },					\
+		{ 7, "MAPPING_INFINITE" })
 
 TRACE_EVENT(mptcp_subflow_get_send,
 
diff --git a/net/mptcp/options.c b/net/mptcp/options.c
index 41eb39968a9a..e561143dd121 100644
--- a/net/mptcp/options.c
+++ b/net/mptcp/options.c
@@ -1144,7 +1144,7 @@ static void rwin_update(struct mptcp_sock *msk, struct sock *ssk,
 	subflow->rcv_wnd_sent = mptcp_rcv_wnd;
 }
 
-static void ack_update_msk(struct mptcp_sock *msk,
+static bool ack_update_msk(struct mptcp_sock *msk,
 			   struct sock *ssk,
 			   const struct sk_buff *skb,
 			   struct mptcp_options_received *mp_opt)
@@ -1153,6 +1153,7 @@ static void ack_update_msk(struct mptcp_sock *msk,
 	u32 win = ntohs(tcp_hdr(skb)->window);
 	struct sock *sk = (struct sock *)msk;
 	u64 snd_nxt;
+	bool acked;
 
 	mptcp_data_lock(sk);
 
@@ -1185,7 +1186,8 @@ static void ack_update_msk(struct mptcp_sock *msk,
 	if (after64(msk->wnd_end, snd_nxt))
 		__mptcp_check_push(sk, ssk);
 
-	if (after64(new_snd_una, old_snd_una)) {
+	acked = after64(new_snd_una, old_snd_una);
+	if (acked) {
 		__mptcp_snd_una_update(msk, new_snd_una);
 		__mptcp_data_acked(sk);
 	}
@@ -1195,6 +1197,7 @@ static void ack_update_msk(struct mptcp_sock *msk,
 	trace_ack_update_msk(mp_opt->data_ack,
 			     old_snd_una, new_snd_una,
 			     new_wnd_end, READ_ONCE(msk->wnd_end));
+	return acked;
 }
 
 bool mptcp_update_rcv_data_fin(struct mptcp_sock *msk, u64 data_fin_seq, bool use_64bit)
@@ -1356,8 +1359,8 @@ bool mptcp_incoming_options(struct sock *sk, struct sk_buff *skb)
 	/* we can't wait for recvmsg() to update the ack_seq, otherwise
 	 * monodirectional flows will stuck
 	 */
-	if (mp_opt.use_ack)
-		ack_update_msk(msk, sk, skb, &mp_opt);
+	if (mp_opt.use_ack && ack_update_msk(msk, sk, skb, &mp_opt))
+		subflow->dss_confirmed = 1; /* MPTCP opts pass both ways */
 	rwin_update(msk, sk, skb);
 
 	/* Zero-data-length packets are dropped by the caller and not
diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
index 59ddf3dafeba..70cd119bdbb8 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -609,7 +609,8 @@ struct mptcp_subflow_context {
 		resetting : 1,	    /* subflow is resetting */
 		old_data_pending : 1, /* old data not acked with MPTCP opts */
 		map_old : 1,	    /* MPC: peer's last map is below dsn_end */
-		__unused : 7;
+		dss_confirmed : 1,  /* a DATA_ACK acked our data */
+		__unused : 6;
 	bool	data_avail;
 	bool	scheduled;
 	bool	pm_listener;	    /* a listener managed by the kernel PM? */
diff --git a/net/mptcp/subflow.c b/net/mptcp/subflow.c
index 190c75311ff6..efbd3efd379e 100644
--- a/net/mptcp/subflow.c
+++ b/net/mptcp/subflow.c
@@ -1072,7 +1072,8 @@ enum mapping_status {
 	MAPPING_DATA_FIN,
 	MAPPING_DUMMY,
 	MAPPING_BAD_CSUM,
-	MAPPING_NODSS
+	MAPPING_NODSS,
+	MAPPING_INFINITE
 };
 
 static void dbg_bad_map(struct mptcp_subflow_context *subflow, u32 ssn)
@@ -1242,7 +1243,7 @@ static enum mapping_status get_mapping_status(struct sock *ssk,
 	if (data_len == 0) {
 		pr_debug("infinite mapping received\n");
 		MPTCP_INC_STATS(sock_net(ssk), MPTCP_MIB_INFINITEMAPRX);
-		return MAPPING_INVALID;
+		return MAPPING_INFINITE;
 	}
 
 	if (mpext->data_fin == 1) {
@@ -1453,6 +1454,22 @@ static void subflow_update_dsn_base(struct mptcp_subflow_context *subflow)
 		subflow->dsn_end = end;
 }
 
+/* RFC 8684, 3.7: no fallback once a DATA_ACK acked our data, except MP_FAIL */
+static bool subflow_nodss_is_fatal(struct mptcp_sock *msk,
+				   const struct mptcp_subflow_context *subflow)
+{
+	bool fatal;
+
+	if (!subflow->dss_confirmed)
+		return false;
+
+	/* before a fallback, only an MP_FAIL clears allow_subflows */
+	spin_lock_bh(&msk->fallback_lock);
+	fatal = msk->allow_subflows;
+	spin_unlock_bh(&msk->fallback_lock);
+	return fatal;
+}
+
 static bool subflow_check_data_avail(struct sock *ssk)
 {
 	struct mptcp_subflow_context *subflow = mptcp_subflow_ctx(ssk);
@@ -1473,7 +1490,9 @@ static bool subflow_check_data_avail(struct sock *ssk)
 		status = get_mapping_status(ssk, msk);
 		trace_subflow_check_data_avail(status, skb_peek(&ssk->sk_receive_queue));
 		if (unlikely(status == MAPPING_INVALID || status == MAPPING_DUMMY ||
-			     status == MAPPING_BAD_CSUM || status == MAPPING_NODSS))
+			     status == MAPPING_BAD_CSUM ||
+			     status == MAPPING_NODSS ||
+			     status == MAPPING_INFINITE))
 			goto fallback;
 
 		if (status != MAPPING_OK)
@@ -1523,7 +1542,9 @@ static bool subflow_check_data_avail(struct sock *ssk)
 			return true;
 		}
 
-		if (!mptcp_try_fallback(ssk, MPTCP_MIB_DSSFALLBACK)) {
+		if (((status == MAPPING_NODSS || status == MAPPING_INVALID) &&
+		     subflow_nodss_is_fatal(msk, subflow)) ||
+		    !mptcp_try_fallback(ssk, MPTCP_MIB_DSSFALLBACK)) {
 			/* fatal protocol error, reset the subflow and let the
 			 * worker close it
 			 */

-- 
2.55.0

