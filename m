Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795809745;
	b=2D3coUzy7x/Z18HgOriH368H3UlhZ9osO8Wqg+OXcKfhKy+osQjdDNTdQSIgdMfwMmkO
	 Nqo2u+v0MFSn+0yzEKuK3tZwtjGpTZrImGJJwgRkScCbrFAZ7mukyZ4GqDSnp+UjATOgY
	 Z43XvNnwsecZdiTaH5pRIM0IozrUvFe+cbGvPqXSas9eYsBsiydgfrVEhu31a/7lfuWpj
	 MXqWHPIm/NRXtGSds9YQ45RSqsIOTNFRB2rslHjKVBFZOftjb3829O+0WSwOMk2Z676uq
	 aMcru0DMtae+1CsyJO3slNg8cOJ9lift+QuQ7LFDfVcs+a/q9b5A10W6yXvsa70khuw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795809745;
	h=Received:DKIM-Signature:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer:X-Developer-Signature:X-Developer-Key;
	bh=BHulquEU8LRW6mmPrtd2ONn+liazKJY7ArS9TDueTKE=;
	b=2zgEEQC7IxBrn+SVo77Rw/AQDC1N/rcQV4dnOBwLdrgnLvBP1saUJyPu2KZx8GadFQnf
	 EixPzHgQFqsLVdKOuXzKNqE3pMEENWuxRw2LsujZMk15H21OGOZDrXp2HndXUv6pefdAZ
	 n1VtgRyvwUmXMFWU3FYbI7Cv6JCOv41up/Tp2ndNq0aY7HZv1DRHXKwhYMzj236vDYVj6
	 /t0mlSP5e69VINDYkhPz4mhmWuNFsLh6cVPPpq6Rgc88AfX99F8vepCNE+7Siv42+WcU4
	 5XJmMhPieqFx35xStALFVLcMQaCduHG93Kl8Tz4HIkK2/MwRB7CpcWplcXyPzXLaJGQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=GBft89PY;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B71FD606A31C
	for <mptcp@lists.linux.dev>; Fri, 27 Nov 2026 20:02:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=GBft89PY
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 283CB1F00893;
	Fri, 27 Nov 2026 20:02:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795809745;
	bh=BHulquEU8LRW6mmPrtd2ONn+liazKJY7ArS9TDueTKE=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=GBft89PYWa699ESfK9WeV7UqS1dePXny/vRxTVxO57cYvhpxG67P2Km9UEN6exPNj
	 a8igqkEMrVJwXYTahcbzZZgMz+jwoQ8xttnW+ZUEIlI5GJImdBYag3pJjgv+S7A/jJ
	 mtJ0R+zdYHYjQieA+2V35CVJDL/broGLGFIzckeNJ9Tng4USUQrKuXOR0NPqSZzZdw
	 Zm5H/gOilfuy8pmci3TcuqnaYYqzXBYCPjRWc/RC35Whk85pmqsOa5Xuzhl6BjEVdh
	 qLoWcHd6qo4q4ksewumCkshO6ShaoxJpLON/gdJGjClVG4mmCrhQx4JCzLZ+Pfi7xO
	 IWWTTf0fsbePA==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Fri, 27 Nov 2026 21:01:44 +0100
Subject: [PATCH RFC mptcp-next mptcp-net v4 20/20] mptcp: reset when the
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
Message-Id: <20261127-mptcp-cmason-fixes-v4-20-3f393ea8c48d@kernel.org>
References: <20261127-mptcp-cmason-fixes-v4-0-3f393ea8c48d@kernel.org>
In-Reply-To: <20261127-mptcp-cmason-fixes-v4-0-3f393ea8c48d@kernel.org>
To: MPTCP Linux <mptcp@lists.linux.dev>
Cc: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=13224; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=f5rKuTiRS5QGmSICJmW6AVlBbi6XeFJuFW7wBsLzbms=;
 b=owGbwMvMwCVWo/Th0Gd3rumMp9WSGLI5H+4UCDMoTHd+XF/QtcJ/bVzMJhndzPyrW77cdP67o
 XbifremjlIWBjEuBlkxRRbptsj8mc+reEu8/Cxg5rAygQxh4OIUgIl80mRkOPrvtsSNDrvZh1a/
 +dnuG+LEqfd42le3WzWsm7dlnHJeeJ+RYa2OaZrB6aR7t/yXlIW+2HEqcI6Q/Iv5yqzHLjqkhYa
 ysQIA
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
the received data after a resegmentation by a middlebox, or when the
received data goes past the end of its mapping. But not after an
infinite mapping, the fallback signal from the RFC: it gets a new
MAPPING_INFINITE status, also named in the tracepoint, and when it comes
without data, e.g. on a pure ACK, the next data without DSS can still
fall back.

For data going past the end of its mapping, the reset now sends the
"MPTCP-specific error" reason, as for an invalid mapping, instead of
"Unspecified error", also when a fallback is not possible, e.g. on
MP_JOIN subflows.

When a middlebox starts dropping the MPTCP options in the middle of a
connection, after a DATA_ACK acknowledged data, the subflow is then
reset, instead of falling back to TCP when it was safe. If it was the
only subflow, the MPTCP connection stays without subflow until the
close timeout -- 60 seconds by default, see net.mptcp.close_timeout --
unless a new one is created in between.

New Packetdrill tests check these resets, and the fallback after an
infinite mapping without data.

Closes: https://github.com/multipath-tcp/mptcp_net-next/issues/519 [1]
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
v2: also reset on an invalid mapping (Clashiko), and commit message: the
    remaining case is now handled by the sender
v3: name MAPPING_INFINITE in the tracepoint, and msg: all the invalid
    mappings (Clashiko)
v4: also reset on data past its mapping, with the MPTCP-specific error
    reason, but fall back after an infinite mapping without data; helper
    name, MIB comments (Sashiko, Clashiko)

Note: this commit changes the behaviour, it is for next. It fixes a very
specific corner case (but it follows what the RFC 8684 recommends to do)
but for that it needs an extra flag and more checks. Is it worth it? (I
think so, but that's why it is flagged as RFC.)

Note: no Packetdrill test for data past its mapping: it triggers the
DEBUG_NET_WARN_ON_ONCE() in __mptcp_move_skbs_from_subflow().
---
 include/trace/events/mptcp.h |  3 ++-
 net/mptcp/mib.h              |  4 ++--
 net/mptcp/options.c          | 14 ++++++++++----
 net/mptcp/protocol.c         |  7 ++++++-
 net/mptcp/protocol.h         |  5 ++++-
 net/mptcp/subflow.c          | 29 +++++++++++++++++++++++++----
 6 files changed, 49 insertions(+), 13 deletions(-)

diff --git a/include/trace/events/mptcp.h b/include/trace/events/mptcp.h
index c181fdfcecf0..1c1147f0eacf 100644
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
 
diff --git a/net/mptcp/mib.h b/net/mptcp/mib.h
index 34a065b9e8dd..47dde8bd19e4 100644
--- a/net/mptcp/mib.h
+++ b/net/mptcp/mib.h
@@ -35,7 +35,7 @@ enum linux_mptcp_mib_field {
 	MPTCP_MIB_JOINSYNTXCONNECTERR,	/* Not able to connect() when sending a SYN + MP_JOIN */
 	MPTCP_MIB_DSSNOMATCH,		/* Received a new mapping that did not match the previous one */
 	MPTCP_MIB_DSSCORRUPTIONFALLBACK,/* DSS corruption detected, fallback */
-	MPTCP_MIB_DSSCORRUPTIONRESET,	/* DSS corruption detected, MPJ subflow reset */
+	MPTCP_MIB_DSSCORRUPTIONRESET,	/* DSS corruption detected, subflow reset */
 	MPTCP_MIB_INFINITEMAPTX,	/* Sent an infinite mapping */
 	MPTCP_MIB_INFINITEMAPRX,	/* Received an infinite mapping */
 	MPTCP_MIB_DSSTCPMISMATCH,	/* DSS-mapping did not map with TCP's sequence numbers */
@@ -91,7 +91,7 @@ enum linux_mptcp_mib_field {
 	MPTCP_MIB_MD5SIGFALLBACK,	/* Conflicting TCP option enabled */
 	MPTCP_MIB_MD5SIGRESET,		/* MP_RST: MD5SIG enabled on listener */
 	MPTCP_MIB_DSSFALLBACK,		/* Bad or missing DSS */
-	MPTCP_MIB_DSSRESET,		/* MP_RST: bad data mapping */
+	MPTCP_MIB_DSSRESET,		/* MP_RST: bad or missing DSS */
 	MPTCP_MIB_SIMULTCONNFALLBACK,	/* Simultaneous connect */
 	MPTCP_MIB_FALLBACKFAILED,	/* Can't fallback: msk/subflow status */
 	MPTCP_MIB_WINPROBE,		/* MPTCP-level zero window probe */
diff --git a/net/mptcp/options.c b/net/mptcp/options.c
index 0d73d02cad86..9d5126584209 100644
--- a/net/mptcp/options.c
+++ b/net/mptcp/options.c
@@ -1148,7 +1148,7 @@ static void rwin_update(struct mptcp_sock *msk, struct sock *ssk,
 	subflow->rcv_wnd_sent = mptcp_rcv_wnd;
 }
 
-static void ack_update_msk(struct mptcp_sock *msk,
+static bool ack_update_msk(struct mptcp_sock *msk,
 			   struct sock *ssk,
 			   const struct sk_buff *skb,
 			   struct mptcp_options_received *mp_opt)
@@ -1157,6 +1157,7 @@ static void ack_update_msk(struct mptcp_sock *msk,
 	u32 win = ntohs(tcp_hdr(skb)->window);
 	struct sock *sk = (struct sock *)msk;
 	u64 snd_nxt;
+	bool acked;
 
 	mptcp_data_lock(sk);
 
@@ -1189,7 +1190,8 @@ static void ack_update_msk(struct mptcp_sock *msk,
 	if (after64(msk->wnd_end, snd_nxt))
 		__mptcp_check_push(sk, ssk);
 
-	if (after64(new_snd_una, old_snd_una)) {
+	acked = after64(new_snd_una, old_snd_una);
+	if (acked) {
 		__mptcp_snd_una_update(msk, new_snd_una);
 		__mptcp_data_acked(sk);
 	}
@@ -1199,6 +1201,7 @@ static void ack_update_msk(struct mptcp_sock *msk,
 	trace_ack_update_msk(mp_opt->data_ack,
 			     old_snd_una, new_snd_una,
 			     new_wnd_end, READ_ONCE(msk->wnd_end));
+	return acked;
 }
 
 bool mptcp_update_rcv_data_fin(struct mptcp_sock *msk, u64 data_fin_seq, bool use_64bit)
@@ -1360,8 +1363,8 @@ bool mptcp_incoming_options(struct sock *sk, struct sk_buff *skb)
 	/* we can't wait for recvmsg() to update the ack_seq, otherwise
 	 * monodirectional flows will stuck
 	 */
-	if (mp_opt.use_ack)
-		ack_update_msk(msk, sk, skb, &mp_opt);
+	if (mp_opt.use_ack && ack_update_msk(msk, sk, skb, &mp_opt))
+		subflow->dss_confirmed = 1; /* MPTCP opts pass both ways */
 	rwin_update(msk, sk, skb);
 
 	/* Zero-data-length packets are dropped by the caller and not
@@ -1374,6 +1377,9 @@ bool mptcp_incoming_options(struct sock *sk, struct sk_buff *skb)
 		    mptcp_update_rcv_data_fin(msk, mp_opt.data_seq, mp_opt.dsn64))
 			mptcp_schedule_work((struct sock *)msk);
 
+		if (mp_opt.use_map && !mp_opt.data_len)
+			subflow->dss_confirmed = 0; /* infinite map: fallback */
+
 		return true;
 	}
 
diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index fd6a72d375aa..51598217ad85 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -795,8 +795,13 @@ static void mptcp_check_data_fin(struct sock *sk)
 
 static void mptcp_dss_corruption(struct mptcp_sock *msk, struct sock *ssk)
 {
-	if (!mptcp_try_fallback(ssk, MPTCP_MIB_DSSCORRUPTIONFALLBACK)) {
+	struct mptcp_subflow_context *subflow = mptcp_subflow_ctx(ssk);
+
+	if (mptcp_dss_fallback_is_fatal(msk, subflow) ||
+	    !mptcp_try_fallback(ssk, MPTCP_MIB_DSSCORRUPTIONFALLBACK)) {
 		MPTCP_INC_STATS(sock_net(ssk), MPTCP_MIB_DSSCORRUPTIONRESET);
+		subflow->reset_transient = 0;
+		subflow->reset_reason = MPTCP_RST_EMPTCP;
 		mptcp_subflow_reset(ssk);
 	}
 }
diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
index 59ddf3dafeba..79403d163e02 100644
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
@@ -864,6 +865,8 @@ void mptcp_close_ssk(struct sock *sk, struct sock *ssk,
 		     struct mptcp_subflow_context *subflow);
 void __mptcp_subflow_send_ack(struct sock *ssk);
 void mptcp_subflow_reset(struct sock *ssk);
+bool mptcp_dss_fallback_is_fatal(struct mptcp_sock *msk,
+				 const struct mptcp_subflow_context *subflow);
 void mptcp_subflow_queue_clean(struct sock *sk, struct sock *ssk);
 void mptcp_sock_graft(struct sock *sk, struct socket *parent);
 u64 mptcp_wnd_end(const struct mptcp_sock *msk);
diff --git a/net/mptcp/subflow.c b/net/mptcp/subflow.c
index 330971e817c4..8a21118e9182 100644
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
@@ -1454,6 +1455,22 @@ static void subflow_update_dsn_base(struct mptcp_subflow_context *subflow)
 		subflow->dsn_end = end;
 }
 
+/* RFC 8684, 3.7: no fallback once a DATA_ACK acked our data, except MP_FAIL */
+bool mptcp_dss_fallback_is_fatal(struct mptcp_sock *msk,
+				 const struct mptcp_subflow_context *subflow)
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
@@ -1474,7 +1491,9 @@ static bool subflow_check_data_avail(struct sock *ssk)
 		status = get_mapping_status(ssk, msk);
 		trace_subflow_check_data_avail(status, skb_peek(&ssk->sk_receive_queue));
 		if (unlikely(status == MAPPING_INVALID || status == MAPPING_DUMMY ||
-			     status == MAPPING_BAD_CSUM || status == MAPPING_NODSS))
+			     status == MAPPING_BAD_CSUM ||
+			     status == MAPPING_NODSS ||
+			     status == MAPPING_INFINITE))
 			goto fallback;
 
 		if (status != MAPPING_OK)
@@ -1524,7 +1543,9 @@ static bool subflow_check_data_avail(struct sock *ssk)
 			return true;
 		}
 
-		if (!mptcp_try_fallback(ssk, MPTCP_MIB_DSSFALLBACK)) {
+		if (((status == MAPPING_NODSS || status == MAPPING_INVALID) &&
+		     mptcp_dss_fallback_is_fatal(msk, subflow)) ||
+		    !mptcp_try_fallback(ssk, MPTCP_MIB_DSSFALLBACK)) {
 			/* fatal protocol error, reset the subflow and let the
 			 * worker close it
 			 */

-- 
2.55.0

