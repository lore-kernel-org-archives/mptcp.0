Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795254193;
	b=1ME55vAgSFs6OxdcB+63sxuneQWo7JfY8rO+TRocJ1vW6s9vvCWpWRjqkUNoy9yVJZcU
	 FAE2S6kDJ0pmnDLQDyNZ8mUuTy3kv+qnapTfxHEnsOL1iYMCF/kEJ3TZtX5DCwGbyLBEn
	 9inSoFsiwtjqSUHlPSJ2NUwvVFY6a9L4x1cEQS6gBHRZ3iodJXr6aV/j6f5oJfZaagD09
	 +/zEhsPtjZRpTy+TOvj882ePDXS4216LTDmOmdZduZBY0Xri2YesKcj7Lv32jwkGlLibj
	 XRaFoWK3V8wIQVtQcwcPhPTasfH0bnWaojsUUZ8L+vrfDgDwxknD7Nlobg0LImt8QTA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795254193;
	h=Received:DKIM-Signature:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer:X-Developer-Signature:X-Developer-Key;
	bh=ENSKVcPqGzuSWPAKYp6yC5K80U42bHSo3RTecnzQUIA=;
	b=oWXn8NxZAleI60AJjgH/FAkpcDcu1e5218Ozl92CxoKSGVM1esIs6sjJuaNaE1oNjyYF
	 afr5LyfZrRqHwP6Qa7ujcLemGsvtNQM7c7RYp9d4T+sYguagDh/kVDBdBNpsRYI1RJk7s
	 wUL0iqgEJZDZhv5ZfFojpbP34lusIjC1fqBocrKJFmK1PTWqcCzRputA1M0Ur+Rhgkyi4
	 LwAcbwnqnOM/5pTSf9wekDvlNiC6oyEwyniCehABx2hAbMkkr4KlE2D/J8DymLJR9Jc3/
	 QbuL6AYcxM1ow4LAl4KQAEFQWhv6LF/vDzgzxHI0tXIy4d+9UsE4ReEoG+DKz8pushA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=o3iYIPa8;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DC4F606A320
	for <mptcp@lists.linux.dev>; Sat, 21 Nov 2026 09:43:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=o3iYIPa8
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 99C2C1F000C0;
	Sat, 21 Nov 2026 09:43:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795254193;
	bh=ENSKVcPqGzuSWPAKYp6yC5K80U42bHSo3RTecnzQUIA=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=o3iYIPa82PVS550Jji7IXBfa98uQArReK7Fj4L86Nu7T6Brx6yLhHu8Wg+EMwGUs7
	 ecTcgnyF9P/R8faUBtqe522+YZcMgxmnt8Nuly6CpP6sMamwk6HVOz3gNpthwwJtV9
	 MLv+F6vApgBh5ERiDksQuY9owR94OEjNslELInLgNlPv9FHgDdoGAhDESXg+/G1Dow
	 2aaq/IveLWEw/RQFusuyiSRjwEPZllm7qsuwlvb43Q047Zx93LCPn0Wda/LvNQIzVx
	 Z2UFB10vtnRLC5gmuipQ2syE2ukNzJKD7y8J9tSQYakDqpPAnJZrthdRHCAQUfOEZo
	 Oxrv/w50HYPtg==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Sat, 21 Nov 2026 10:42:00 +0100
Subject: [PATCH RFC mptcp-next mptcp-net v2 62/62] mptcp: reset when the
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
Message-Id: <20261121-mptcp-cmason-fixes-v2-62-00327fd1de1f@kernel.org>
References: <20261121-mptcp-cmason-fixes-v2-0-00327fd1de1f@kernel.org>
In-Reply-To: <20261121-mptcp-cmason-fixes-v2-0-00327fd1de1f@kernel.org>
To: MPTCP Linux <mptcp@lists.linux.dev>
Cc: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
X-Mailer: b4 0.17-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=8736; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=uVxd7KP5vm2zoaapmPspZW7xACOPgZWdcZBhBVTLY9c=;
 b=kA0DAAoWfCLwwvNHCpcByyZiAGsBZ3fIp0K/pImH8vWUcvDXDGq/8b1L0KmCgp8MxBfq4yeVj
 4h1BAAWCgAdFiEEG4ZZb5nneg10Sk44fCLwwvNHCpcFAmsBZ3cACgkQfCLwwvNHCpdvywD/QefN
 KtT/MrgL8oQh4/Zp8eU14DuQkQHjV4NY7lz2M0kBAMxN8obHCW3yuYfTL3oQ15KC77RpFiwlPIS
 kkMiImRkN
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

The same is done when a mapping does not cover the received data, e.g.
after a resegmentation by a middlebox, but not for an infinite mapping,
the fallback signal from the RFC: it gets a new MAPPING_INFINITE status.

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

Note: this commit changes the behaviour, it is for next. It fixes a very
specific corner case (but it follows what the RFC 8684 recommends to do)
but for that it needs an extra flag and more checks. Is it worth it? (I
think so, but that's why it is flagged as RFC.)
---
 net/mptcp/options.c  | 11 +++++++----
 net/mptcp/protocol.h |  3 ++-
 net/mptcp/subflow.c  | 29 +++++++++++++++++++++++++----
 3 files changed, 34 insertions(+), 9 deletions(-)

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
index be57804f1bb3..7bc45ce0d47c 100644
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
index 7dbad6debdf0..e66d8416fe79 100644
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

