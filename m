Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795254175;
	b=nJcj/Uv4vojv3RP9l4pmhWJnBZ78WQx9/EIp8/uHCSc0SonOmD8c29O1G4rRjBldvTgA
	 gU2TRhiieJuMXDEiahU9nRmnAS3WRioIprr45wG4MDyG9VnRvfr7I8YBMKkD4ULg8GSkb
	 Cgn0pcfHoIdN9h/sTGF+V30EBh8g2/DHd8kv1Sn0Z2S335DJAQEe7zklgcYqSnOMk5hhn
	 rZZcO63vQLWlf9a+HnBQvMK0Sxvr3QYnvLkfjJd8Mp+6YvYMjAD8Xud6RDckqUT4jkGZE
	 we3mzSib72icCM1HzLTY4X4gLuO9WI6dotIgPqRCbbWkYtKitG0SPimCpndxigtmcNg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795254175;
	h=Received:DKIM-Signature:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer:X-Developer-Signature:X-Developer-Key;
	bh=yRbhiilys0oSt9BKa7QHoKoIKuCcRWp7Gg11zfsm08E=;
	b=jJAJY779qs2U/ZCckZIXygoBZHLgkizLA2+FePMluBEPix++RQkgt+hchLwPUQ7TPSMU
	 oAmhp0S7zxm6ox+kb1QSuMFO+pj+FRebdXicxhCH5ZlIooFZcUDNJR0LEDgD3g6f3xiQO
	 w/iD/+x0Amfap6EEhYNr3VWV4fiwidrB83pNs+3tZB5ehrcsTkNU5PcEiDaXIQvOHJgvM
	 TrWU9DOSNQvaMFoYb1UwO3mvGBN3ERpoJmlfHhMWWl/g+/LiCw3wwYabPvgvHi7F58pxm
	 XdthtG5MG665r8yR2Ili+KhCPvdnsIFUdE9sxlGINuozVyVrL5/tIDwhQC3frHz8IYA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=d+DKiprI;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D56B606A336
	for <mptcp@lists.linux.dev>; Sat, 21 Nov 2026 09:42:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=d+DKiprI
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 742721F000D2;
	Sat, 21 Nov 2026 09:42:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795254175;
	bh=yRbhiilys0oSt9BKa7QHoKoIKuCcRWp7Gg11zfsm08E=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=d+DKiprIGgNDRqO3+mWlzpJhuODagjq82d4ui6syVxbUFxCc8rRq0MhXTKYSa3/TS
	 W66R9KeAQFFQgtuOorCdiiB729GE5fOJwo9OKfdbpTKrTTlEQ4684Vo1PdJlacXmSA
	 OZaR1G99FjPbInjIDZlKlKNNTjwtJnmjlhu8zHXOn9d6EFOgT8KqQWx4XgBJ8nI0wI
	 HYdwcRD9rW0T9wW1eL8jR+qfQOCxhqeeVJihko6gkHg8Bo74OQV6OROZirEMka6kMH
	 htmevowR6TLo7gQG0AylXCi+cisWOHTrnBsu4aZg7vH3M2XgyrjHg8/Y737Ew6WsWo
	 csR2ipTQoVemw==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Sat, 21 Nov 2026 10:41:39 +0100
Subject: [PATCH mptcp-net v2 41/62] mptcp: stop resending data to a peer
 that fell back
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
Message-Id: <20261121-mptcp-cmason-fixes-v2-41-00327fd1de1f@kernel.org>
References: <20261121-mptcp-cmason-fixes-v2-0-00327fd1de1f@kernel.org>
In-Reply-To: <20261121-mptcp-cmason-fixes-v2-0-00327fd1de1f@kernel.org>
To: MPTCP Linux <mptcp@lists.linux.dev>
Cc: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>, 
 Chris Mason <mason@kernel.org>
X-Mailer: b4 0.17-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=9462; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=8sWwY6sUY8nKBbcUHPWKI6SHrxHl0Algv14kpg7K4gY=;
 b=owGbwMvMwCVWo/Th0Gd3rumMp9WSGLIZ09PFGj1nvZ0Zzcbz87Xm0aJqjqwgA2l5l9glu2Tcv
 r0v+nyzo5SFQYyLQVZMkUW6LTJ/5vMq3hIvPwuYOaxMIEMYuDgFYCKLJRkZFuV5zvmn9HuxrHHP
 G9OC29YMR6arX7zwbO4Ltzfth/OmTmFkmHy6K6yua5b9b271aJ8Te7qXXTszbXc6f5PxFXHdU0d
 zOQE=
X-Developer-Key: i=matttbe@kernel.org; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

From: Chris Mason <mason@kernel.org>

recv() on an established MPTCP connection can silently return data that
it has returned before, again and again, if the receiver falls back to
TCP and the sender does not.

While no DATA_ACK arrives, the MPTCP retransmit timer makes
mptcp_sendmsg_frag() queue old data on the subflow again: either
fragments from __mptcp_retrans(), or a zero window probe. That is only
correct while the receiver reads the DSS mapping of these bytes and
drops them as duplicates: a receiver that has fallen back to TCP
delivers them as new data. But mptcp_incoming_options() ignores a bare
ACK, one with no MPTCP option, on a fully established subflow, so a
sender that gets only bare ACKs from that receiver stays in MPTCP mode:

    sender                            receiver
    ======                            ========
    send bytes N to M
    (a middlebox removes the DSS)
                                      no DSS: fall back
                                      deliver N to M, send a bare ACK
    no DATA_ACK, the timer expires
    send bytes N to M again
                                      deliver N to M again  <-- wrong
                                      send a bare ACK

The fix used here is to:
- reset the subflow, with the reason "middlebox interference", when
  mptcp_sendmsg_frag() has more old data to queue and only bare ACKs
  have acknowledged the old data queued so far. The test reads
  old_data_pending, which the earlier commit "mptcp: do not fallback
  while old data is in flight" sets when old data is queued. That commit
  clears it when a segment with a DSS, other than an infinite mapping,
  acknowledges old_data_end, the TCP sequence number after that data.
  The reset is counted in FallbackFailed: the peer has likely fallen
  back, but this side cannot
- clear old_data_pending for a segment with any other MPTCP option too,
  in mptcp_incoming_options(). An infinite mapping stays the exception
- skip a zero window probe while the TCP retransmit queue of the subflow
  holds data: the MPTCP retransmit timer, armed when a push leaves data
  behind, tries again later
- drop the segment in mptcp_incoming_options() if the push done when
  processing its DATA_ACK resets the subflow: it is not queued on the
  closed subflow then, as with a reset done earlier

This limits the repeats, but does not prevent the first one: data that
was new when it was first sent does not set old_data_pending, so its
first MPTCP-level retransmission is still delivered twice by a peer that
has fallen back. After a failed MP_JOIN, more of the reinjected data can
be. The same is true for a zero window probe whose DSS is removed: a
peer falling back on it delivers it as the next byte, then this byte
again, when it is sent as new data.

A consequence: a peer still in MPTCP mode, whose options are removed on
the way back for a while only, recovered once the options came back.
Its subflow is now reset as soon as more old data is due.

This issue has been found with the help of an LLM, and reproduced in a
VM, with the reproducer shared with the original version of this patch:
between two unmodified Linux hosts, nftables removing the MPTCP options
in the middle of the transfer, so that only the receiver falls back.
Without this patch, the reader got the same data again and again, here
65 MB more than once in 120 seconds:

  receiver 127.514: READ-TOTAL outcome iii-repeat-or-gap bytes 68255744 of 8388608 missing 0 twice 65650688 [...]
  [...] took 120.0 s end: limit: still data after 120 s

Fixes: 119d51e225fe ("mptcp: fallback when MPTCP opts are dropped after 1st data")
Signed-off-by: Chris Mason <mason@kernel.org>
[ Shorter comments, also in struct mptcp_subflow_context. No timer
  arming when a probe is skipped: "mptcp: arm the rtx timer if a push
  leaves data behind" already does it. Commit message: the first repeat
  is still delivered, and a peer that loses its options for a while only
  is now reset + how the issue was found, and its symptoms. Count the
  reset in MPTCP_MIB_FALLBACKFAILED. Drop the segment if the push resets
  the subflow, update comments, and commit message: the zero window probe
  whose DSS is removed. ]
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
v2: drop the segment if the push resets the subflow, update comments,
    and mention the probe case (Sashiko, Clashiko)
---
 net/mptcp/mib.h      |  2 +-
 net/mptcp/options.c  | 16 ++++++++++------
 net/mptcp/protocol.c | 21 ++++++++++++++++++++-
 net/mptcp/protocol.h |  2 +-
 4 files changed, 32 insertions(+), 9 deletions(-)

diff --git a/net/mptcp/mib.h b/net/mptcp/mib.h
index 1ebdb55e9534..34a065b9e8dd 100644
--- a/net/mptcp/mib.h
+++ b/net/mptcp/mib.h
@@ -93,7 +93,7 @@ enum linux_mptcp_mib_field {
 	MPTCP_MIB_DSSFALLBACK,		/* Bad or missing DSS */
 	MPTCP_MIB_DSSRESET,		/* MP_RST: bad data mapping */
 	MPTCP_MIB_SIMULTCONNFALLBACK,	/* Simultaneous connect */
-	MPTCP_MIB_FALLBACKFAILED,	/* Can't fallback due to msk status */
+	MPTCP_MIB_FALLBACKFAILED,	/* Can't fallback: msk/subflow status */
 	MPTCP_MIB_WINPROBE,		/* MPTCP-level zero window probe */
 	MPTCP_MIB_BACKLOGDROP,		/* Backlog over memory limit */
 	MPTCP_MIB_RCVPRUNED,		/* Dropped due to memory constraints */
diff --git a/net/mptcp/options.c b/net/mptcp/options.c
index 9133e3d6e5d9..f9b65d0c6290 100644
--- a/net/mptcp/options.c
+++ b/net/mptcp/options.c
@@ -1287,6 +1287,12 @@ bool mptcp_incoming_options(struct sock *sk, struct sk_buff *skb)
 	if (!check_fully_established(msk, sk, subflow, skb, &mp_opt))
 		return sk->sk_state != TCP_CLOSE;
 
+	/* MPTCP opt acking the old data, not an infinite map: no fallback */
+	if (unlikely(subflow->old_data_pending) && mp_opt.suboptions &&
+	    !(mp_opt.use_map && !mp_opt.data_len) &&
+	    !before(TCP_SKB_CB(skb)->ack_seq, subflow->old_data_end))
+		subflow->old_data_pending = 0;
+
 	if (unlikely(mp_opt.suboptions != OPTION_MPTCP_DSS)) {
 		if ((mp_opt.suboptions & OPTION_MPTCP_FASTCLOSE) &&
 		    READ_ONCE(msk->local_key) == mp_opt.fc_recv_key) {
@@ -1333,12 +1339,6 @@ bool mptcp_incoming_options(struct sock *sk, struct sk_buff *skb)
 			return true;
 	}
 
-	/* DSS acking the old data, not an infinite map: no peer fallback */
-	if (unlikely(subflow->old_data_pending) &&
-	    !(mp_opt.use_map && !mp_opt.data_len) &&
-	    !before(TCP_SKB_CB(skb)->ack_seq, subflow->old_data_end))
-		subflow->old_data_pending = 0;
-
 	/* we can't wait for recvmsg() to update the ack_seq, otherwise
 	 * monodirectional flows will stuck
 	 */
@@ -1359,6 +1359,10 @@ bool mptcp_incoming_options(struct sock *sk, struct sk_buff *skb)
 		return true;
 	}
 
+	/* the push from ack_update_msk() can reset the subflow */
+	if (unlikely(sk->sk_state == TCP_CLOSE))
+		return false;
+
 	mpext = skb_ext_add(skb, SKB_EXT_MPTCP);
 	if (!mpext)
 		return false;
diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index 95257ec8537a..b60c54ea4d3f 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -1455,6 +1455,7 @@ static int mptcp_sendmsg_frag(struct sock *sk, struct sock *ssk,
 			      struct mptcp_data_frag *dfrag,
 			      struct mptcp_sendmsg_info *info)
 {
+	struct mptcp_subflow_context *subflow = mptcp_subflow_ctx(ssk);
 	u64 data_seq = dfrag->data_seq + info->sent;
 	int offset = dfrag->offset + info->sent;
 	struct mptcp_sock *msk = mptcp_sk(sk);
@@ -1545,11 +1546,29 @@ static int mptcp_sendmsg_frag(struct sock *sk, struct sock *ssk,
 			return 0;
 		}
 
+		/* a new probe would move old_data_end: one at a time */
+		if (!tcp_rtx_queue_empty(ssk)) {
+			tcp_remove_empty_skb(ssk);
+			return 0;
+		}
+
 		zero_window_probe = true;
 		data_seq = snd_una - 1;
 		copy = 1;
 	}
 
+	/* old data acked without MPTCP opts: the peer may have fallen back */
+	if (unlikely(before64(data_seq, msk->snd_nxt) &&
+		     subflow->old_data_pending &&
+		     !before(tcp_sk(ssk)->snd_una, subflow->old_data_end))) {
+		tcp_remove_empty_skb(ssk);
+		MPTCP_INC_STATS(sock_net(ssk), MPTCP_MIB_FALLBACKFAILED);
+		subflow->reset_transient = 0;
+		subflow->reset_reason = MPTCP_RST_EMIDDLEBOX;
+		mptcp_subflow_reset(ssk);
+		return -EAGAIN;
+	}
+
 	copy = min_t(size_t, copy, info->limit - info->sent);
 
 	/* like TCP, allow some progress up to tcp_wmem[0] */
@@ -1576,7 +1595,7 @@ static int mptcp_sendmsg_frag(struct sock *sk, struct sock *ssk,
 	TCP_SKB_CB(skb)->end_seq += copy;
 	tcp_skb_pcount_set(skb, 0);
 
-	/* old data mapped again: no fallback until acked with a DSS */
+	/* old data mapped again: no fallback until acked with MPTCP opts */
 	if (unlikely(before64(data_seq, msk->snd_nxt))) {
 		mptcp_subflow_ctx(ssk)->old_data_end = tcp_sk(ssk)->write_seq;
 		mptcp_subflow_ctx(ssk)->old_data_pending = 1;
diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
index 6dbd912e08d8..dfeabe03180b 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -605,7 +605,7 @@ struct mptcp_subflow_context {
 		is_mptfo : 1,	    /* subflow is doing TFO */
 		mpc_drop : 1,	    /* the MPC option has been dropped in a rtx */
 		resetting : 1,	    /* subflow is resetting */
-		old_data_pending : 1, /* old_data_end not acked with a DSS */
+		old_data_pending : 1, /* old data not acked with MPTCP opts */
 		__unused : 8;
 	bool	data_avail;
 	bool	scheduled;

-- 
2.55.0

