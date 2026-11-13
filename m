Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794599686;
	b=zgySrX4H87l3Uk5z34UPSYJhztqz5Lj01VUKVSE+W8GtoFK4Yh+hrzvecsky4diTbRu+
	 FruX17xM337eZZtuQHvvbIoeWpi44l1yD+k/FlXAsC+Y9Jq5fATV4XPLiYx5CVycy8qTu
	 g7lIu9+0LmHQfAiCRx/3aLgvbWDmyBUO0v47EB2mkIi9hnbwfFe8ewwatLYDevIhPos3f
	 +M7AOO8nmST5jVCASrPUl6tyoHZNfw7RLp8alcZdIM7p2c/QvQll0RMctb/JOstg/VceT
	 8gq45mUEBceA267ydESqLCvLLR7eFp7KYBIJrhWwDnzlOI3vTlbYqvJi8GcfNkmaHsA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794599686;
	h=Received:DKIM-Signature:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer:X-Developer-Signature:X-Developer-Key;
	bh=LGQziJWXSnuepgQoY91VWzlyQ+xtTmXMbUmaQjznZF8=;
	b=1Q/7TJf3MGM4N1eYerhc5Y49EBtNddLq62+py23NIRe6UPA8QRDum1YFIavv+gB9SvNF
	 0zV9SlI0GhuNMMDD8MPI+i87V7U02wDCVDCfuDnnkC+7TRbmGiRRkPRbyI4mseTuDCb0j
	 MZWovztPCVOuG+chWKB1t7zkp6/JMjCqO8ped6QsNsaUWKgzsQ3DlwC4QpZ3v5bL8vzRh
	 ZmeEmBaruPX/iQhQ/PB4AsaYwlr8yb3eY0MNDNn8OxjBeX/rGviItUTQQ3V0JZefPpvrL
	 sNKjqatVcPpJbA8GZH6ACZvg6iRksbQ6qUi0kSBwhaETSCkLAhOqO3Flwpxg0pdd2Mw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=opettgoH;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38AC5606D0CA
	for <mptcp@lists.linux.dev>; Fri, 13 Nov 2026 19:54:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=opettgoH
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 201D71F000C4;
	Fri, 13 Nov 2026 19:54:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794599685;
	bh=LGQziJWXSnuepgQoY91VWzlyQ+xtTmXMbUmaQjznZF8=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=opettgoH8skBugbRPa9lMrY/8UaMBIP0citcP1q/3F5XQKagmESSQLK5w/X3mNrwi
	 dryyyEmdC5+ZTRUgbEuQTX8TsplmF+RPFyEuWFZvDp4nbUVHGPGLw6QifT0XWEfLpS
	 dGs8YQCfXoT7Bh/dxi4Ot5tnmB8qAxrj9C5Kjku36CmzHf8QDxVnUynUMLDNVH5SxA
	 uDA7dHR7VdKGJNXcUrGjXnLGkZ7rL0eO32HmIdyn4ZtZEnM1DpADrfdp6cCQum77cV
	 4u4IdiqeT08GB9jQiiPazTPohEKTStJlhC3I9dIv6tgc2n/qExSZZe6Kkt7nU5I0mD
	 YdtQQwnm6yrEg==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Fri, 13 Nov 2026 20:53:58 +0100
Subject: [PATCH mptcp-net 20/34] mptcp: stop resending data to a peer that
 fell back
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
Message-Id: <20261113-mptcp-cmason-fixes-v1-20-9205b77e9a2f@kernel.org>
References: <20261113-mptcp-cmason-fixes-v1-0-9205b77e9a2f@kernel.org>
In-Reply-To: <20261113-mptcp-cmason-fixes-v1-0-9205b77e9a2f@kernel.org>
To: MPTCP Linux <mptcp@lists.linux.dev>
Cc: Chris Mason <mason@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
X-Mailer: b4 0.17-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=7336; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=QW3eneUxjiAhekY67A723B56Azcp+iaoyZwE0r4/vYI=;
 b=owGbwMvMwCVWo/Th0Gd3rumMp9WSGLK+Zz3w8DY6O1vu9EcJl5L3gvN1vJeW9X41+3qp4cX1b
 i3LiCkKHaUsDGJcDLJiiizSbZH5M59X8ZZ4+VnAzGFlAhnCwMUpABOZ857hD6euiflFSaa0W593
 Jj26wCSfWTe77LO51VKB7JdvV2/oEWD4Z7WDdZ3CGZ+CbQ6aZzMNeHZ/fvfJS/jcbO38U9kaGu/
 yeAE=
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

This limits the repeats, but does not prevent the first one: data that
was new when it was first sent does not set old_data_pending, so its
first MPTCP-level retransmission is still delivered twice by a peer that
has fallen back. After a failed MP_JOIN, more of the reinjected data can
be.

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
  reset in MPTCP_MIB_FALLBACKFAILED. ]
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
 net/mptcp/options.c  | 12 ++++++------
 net/mptcp/protocol.c | 19 +++++++++++++++++++
 net/mptcp/protocol.h |  2 +-
 3 files changed, 26 insertions(+), 7 deletions(-)

diff --git a/net/mptcp/options.c b/net/mptcp/options.c
index 682a7b93d962..6790c9e15521 100644
--- a/net/mptcp/options.c
+++ b/net/mptcp/options.c
@@ -1271,6 +1271,12 @@ bool mptcp_incoming_options(struct sock *sk, struct sk_buff *skb)
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
@@ -1317,12 +1323,6 @@ bool mptcp_incoming_options(struct sock *sk, struct sk_buff *skb)
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
diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index 7329deb43c62..388e77da8f16 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -1444,6 +1444,7 @@ static int mptcp_sendmsg_frag(struct sock *sk, struct sock *ssk,
 			      struct mptcp_data_frag *dfrag,
 			      struct mptcp_sendmsg_info *info)
 {
+	struct mptcp_subflow_context *subflow = mptcp_subflow_ctx(ssk);
 	u64 data_seq = dfrag->data_seq + info->sent;
 	int offset = dfrag->offset + info->sent;
 	struct mptcp_sock *msk = mptcp_sk(sk);
@@ -1527,11 +1528,29 @@ static int mptcp_sendmsg_frag(struct sock *sk, struct sock *ssk,
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
diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
index 75d4c2f82501..e61b6a3a955d 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -602,7 +602,7 @@ struct mptcp_subflow_context {
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

