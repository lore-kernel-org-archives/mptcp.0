Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794599702;
	b=JCZP0BvZKXR8Ysxfsb/Hi7LSc1Kh4nrJGEynd6l6l2lXHDDyBVCpfo0M1yj1gwV3FB0f
	 1EmhAjuO5XaizlGs/LID+zYZpyB+AkBaBvMndMlcsm9nJ5tnxrOQARLFOnwDJWk9CSXqL
	 0ipp8H3+LegNNbfSN3PbjICSDJTf1FMSG38VUlGBLqkpnk/MJ+x9VgA7C1uR9EsdGT9KR
	 CyYV/YdEL1PD7+A+Ti4vqSg2MRaK6kJW5orqZsvJBtt/3fmr93Gk4Vo3jIXl+9uGAIpn2
	 x6T5WxIwhy2DEHcr3baGWsrhNnQbiC7R9wDnnItw5gV448WhfKxopWI118DDQ+ClnGQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794599702;
	h=Received:DKIM-Signature:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer:X-Developer-Signature:X-Developer-Key;
	bh=pqCJR/YB4QEUGRx9TZbdxFYPz4oF6qjROWr/evWSeIM=;
	b=D2UsrrBRHOePJg6IxfUF0YWzsNwtbeqiLL+KT1DVkZCjDkwegABfW7uXBE/84zcHnzMg
	 5vmDj+VIMp9aO25xhW6BtfA8kwkxADEEByFnf7nKsYebp3MjtgTm/H5m/zeg4TYMMQnS6
	 j2qHhFYWtWBAh0ooj0wfOkHjWJsuABNEsOxq5LI5Oe8hiRn/QSAHBAezmbrJ82s98wAOj
	 bOwd6ufq+mK2g7ep68ND5URsZNpjUPp01kBVCwk2IL4V1G9x9pzYAoWQ1hNDgiBykSS1v
	 1G5DAjL9lFJWgJVJSTXmKjmm0/UZKM/jWjgKo1Om0LDZGaK0hQ7kyVpWGAshciA7D/Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=mg+H+M+U;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C745606BCDE
	for <mptcp@lists.linux.dev>; Fri, 13 Nov 2026 19:55:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=mg+H+M+U
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 880381F000C5;
	Fri, 13 Nov 2026 19:55:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794599702;
	bh=pqCJR/YB4QEUGRx9TZbdxFYPz4oF6qjROWr/evWSeIM=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=mg+H+M+UMYjOwD525kH2jNRyhNiug1ZEOwlloIDstgrbSykhPh2Ccd/k6/P6Kca2Z
	 YIRrseLqB4yjAQR2+EEvqeWPGU/neThs8+SEWknfz6zAQ7M6MOBJDEl4PWEx04oYwW
	 1pZYwqfhJ1UjI84Jm31ff+9MCl2uT3FUbq5P9mlltyiCRDBnnhgaYM9cUl/bue739A
	 /qZI8TRMKxuaScr/LASj0eafkUGlsmdFGbU1W1NmEJRXIVxhGQEZZeazVZgl6f0u17
	 Olp18bw4oS5Vxux1tLi9LCulD2J8cJ1IcG4Sdk8SBpeMVM+XR6oGE3P8UIffFJkZQF
	 eTiN7SNKGMpSA==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Fri, 13 Nov 2026 20:54:12 +0100
Subject: [PATCH RFC mptcp-next mptcp-net 34/34] mptcp: reset when the DSS
 disappears after a DATA_ACK
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
Message-Id: <20261113-mptcp-cmason-fixes-v1-34-9205b77e9a2f@kernel.org>
References: <20261113-mptcp-cmason-fixes-v1-0-9205b77e9a2f@kernel.org>
In-Reply-To: <20261113-mptcp-cmason-fixes-v1-0-9205b77e9a2f@kernel.org>
To: MPTCP Linux <mptcp@lists.linux.dev>
Cc: Chris Mason <mason@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
X-Mailer: b4 0.17-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=7176; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=6t2iomXzM8pmkeOteBrBXdcJQNsYEX+nNmLMGt1qr1s=;
 b=owGbwMvMwCVWo/Th0Gd3rumMp9WSGLK+Z736rvU6gLn24pw9reyNGkysJtsTY75at0epFm/x5
 lo3kSuio5SFQYyLQVZMkUW6LTJ/5vMq3hIvPwuYOaxMIEMYuDgFYCKbChn+x5UWlOzxm3N0z4TJ
 Tn7HftoULOldJuV+55Pvx8vf0lsOrWX4p676btPl8AT18oumT+yOpxYwivlwsep8O8yzaovbmv8
 NvAA=
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
while old data is in flight", "mptcp: stop resending data to a peer
that fell back" and "mptcp: continue the last mapping after a fallback"
handle these cases, except one: if only the receiver falls back, it can
deliver the first MPTCP-level retransmission of the sender as new data,
before the sender resets the subflow. Yeah, a very specific corner case.

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
side can only fall back too, as before. For the same reason, the amount
of received data -- e.g. more than an initial window -- is not used.

When a middlebox starts dropping the MPTCP options in the middle of a
connection, after a DATA_ACK acknowledged data, the subflow is then
reset, instead of falling back to TCP when it was safe. If it was the
only subflow, the MPTCP connection stays without subflow until the
close timeout -- 60 seconds by default, see net.mptcp.close_timeout --
unless a new one is created in between.

A new Packetdrill test checks this reset.

Closes: https://github.com/multipath-tcp/mptcp_net-next/issues/519 [1]
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
Note: this commit changes the behaviour, it is for next. It fixes a very
specific corner case (but it follows what the RFC 8684 recommends to do)
but for that it needs an extra flag and more checks. Is it worth it? (I
think so, but that's why it is flagged as RFC.)
---
 net/mptcp/options.c  | 11 +++++++----
 net/mptcp/protocol.h |  3 ++-
 net/mptcp/subflow.c  | 20 +++++++++++++++++++-
 3 files changed, 28 insertions(+), 6 deletions(-)

diff --git a/net/mptcp/options.c b/net/mptcp/options.c
index c56ca5e4df14..ccd30e110934 100644
--- a/net/mptcp/options.c
+++ b/net/mptcp/options.c
@@ -1128,7 +1128,7 @@ static void rwin_update(struct mptcp_sock *msk, struct sock *ssk,
 	subflow->rcv_wnd_sent = mptcp_rcv_wnd;
 }
 
-static void ack_update_msk(struct mptcp_sock *msk,
+static bool ack_update_msk(struct mptcp_sock *msk,
 			   struct sock *ssk,
 			   const struct sk_buff *skb,
 			   struct mptcp_options_received *mp_opt)
@@ -1137,6 +1137,7 @@ static void ack_update_msk(struct mptcp_sock *msk,
 	u32 win = ntohs(tcp_hdr(skb)->window);
 	struct sock *sk = (struct sock *)msk;
 	u64 snd_nxt;
+	bool acked;
 
 	mptcp_data_lock(sk);
 
@@ -1169,7 +1170,8 @@ static void ack_update_msk(struct mptcp_sock *msk,
 	if (after64(msk->wnd_end, snd_nxt))
 		__mptcp_check_push(sk, ssk);
 
-	if (after64(new_snd_una, old_snd_una)) {
+	acked = after64(new_snd_una, old_snd_una);
+	if (acked) {
 		__mptcp_snd_una_update(msk, new_snd_una);
 		__mptcp_data_acked(sk);
 	}
@@ -1179,6 +1181,7 @@ static void ack_update_msk(struct mptcp_sock *msk,
 	trace_ack_update_msk(mp_opt->data_ack,
 			     old_snd_una, new_snd_una,
 			     new_wnd_end, READ_ONCE(msk->wnd_end));
+	return acked;
 }
 
 bool mptcp_update_rcv_data_fin(struct mptcp_sock *msk, u64 data_fin_seq, bool use_64bit)
@@ -1335,8 +1338,8 @@ bool mptcp_incoming_options(struct sock *sk, struct sk_buff *skb)
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
index f0b93c31b16e..36121de59ab9 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -605,7 +605,8 @@ struct mptcp_subflow_context {
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
index 728b27be1ad0..68a9fe29a5e8 100644
--- a/net/mptcp/subflow.c
+++ b/net/mptcp/subflow.c
@@ -1447,6 +1447,22 @@ static void subflow_update_dsn_base(struct mptcp_subflow_context *subflow)
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
@@ -1517,7 +1533,9 @@ static bool subflow_check_data_avail(struct sock *ssk)
 			return true;
 		}
 
-		if (!mptcp_try_fallback(ssk, MPTCP_MIB_DSSFALLBACK)) {
+		if ((status == MAPPING_NODSS &&
+		     subflow_nodss_is_fatal(msk, subflow)) ||
+		    !mptcp_try_fallback(ssk, MPTCP_MIB_DSSFALLBACK)) {
 			/* fatal protocol error, reset the subflow and let the
 			 * worker close it
 			 */

-- 
2.55.0

