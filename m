Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795557702;
	b=YnXPP/q2t3eKX5Pk/LbdAaHQ2fOZv0vEbq1uClfrr5apvReTPzy6i7vlzCZQw9OdKILe
	 TZgGTrQbFiDrq6LTIVw/TYuQaZlFfZn6rw6IeO13hwpyvDLQf0WTtFHd89dF8sgw0ZSt5
	 WQa9VVvnMhuMp7/uxUKWpP/yFxGP8HempOa/COMm0xv8Gt4I+ap3aExt0W+B6+/Nngg2l
	 tK660AtpB54VBaLbiCo4ailPBWSY1275ir8cneyYauyoaIJzyWhqGJT4E1FAiRapgjOzZ
	 ZDaCflGu2xWnAg6cYoWmoOHXCb7aPI/si2kF++1LF6GOE1VW6S0Kts3BkmJD3v3zbzw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795557702;
	h=Received:DKIM-Signature:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer:X-Developer-Signature:X-Developer-Key;
	bh=SEWviBA1IHkhnuFBT21PVfMjaLqut6QpPzbT5sjLphc=;
	b=Zt6lx7UYlRarTxJ14VCcvQhdm/gqt5z4K7NssrxzSyTPuDx2/iwxJ7u9egZOoboHR0mh
	 D3QmLiRRZlQVqfEUoVZIKZTm9JdWiu8gkPO2sjdG4azUjObzgH4lfMaetAE36oeGjGl6b
	 3M9ZTh2/CV8Q1rDG6ja8tHFApiK24OKEkTiBh4X0WIEkFpGGKoX1tAfqDiZJDMfdeK3AE
	 T2kGkq3mzZx8ckKUwL+2zZmFtX31x+9E7VOhplxUODyzMIpDmnV+FqkFgog1/4d2/qVUE
	 XJet2aqNQIoh231CTQpnNh4L/5hODokfczzkypoxd8JUov09MJ+nCYZwM9SqV5jAvog==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ZexiKdZk;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF3AD606A31E
	for <mptcp@lists.linux.dev>; Tue, 24 Nov 2026 22:01:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ZexiKdZk
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B56C71F000C0;
	Tue, 24 Nov 2026 22:01:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795557702;
	bh=SEWviBA1IHkhnuFBT21PVfMjaLqut6QpPzbT5sjLphc=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=ZexiKdZkCVn6MEg66VXU9o9zeSPcwdxx0tYOpD5wMP1HFrzAsZd9D29Ylz4Fhf69p
	 8KCSvmG9nDoeEBnaDDLRu1Rdnv/FD2rN+PPMD1AHPCzu7l83+fDuWUHHFZ5H5FPPLh
	 rzZnSC4J5seelTd6GAfnoMD5XkIrzYsQNVAGWeJ5jd4/zCxWvLIc/sNsCMoH1Tq1kN
	 mQ1Lo5rY4LEMxIvcc+53ty1zCqR4Lj54j2wWfbY52vR1QpmgKbHYnKlF2L9ydjmcbR
	 zDAwN+bQ7PWWsymqdWV9G8qVT+hRUiTOsJSjcevdG1ObqrXhkZx/tm3eWS8OdVKVvF
	 vVN2nBbZ/IhZQ==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Tue, 24 Nov 2026 22:59:53 +0100
Subject: [PATCH mptcp-net v3 36/50] mptcp: continue the last mapping after
 a fallback
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
Message-Id: <20261124-mptcp-cmason-fixes-v3-36-416c0920c73f@kernel.org>
References: <20261124-mptcp-cmason-fixes-v3-0-416c0920c73f@kernel.org>
In-Reply-To: <20261124-mptcp-cmason-fixes-v3-0-416c0920c73f@kernel.org>
To: MPTCP Linux <mptcp@lists.linux.dev>
Cc: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>, 
 Chris Mason <mason@kernel.org>
X-Mailer: b4 0.17-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=7612; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=+E6PYDVDucCbo1N+J8lQKS7FwLVyR9iD4U1CCHdjtUE=;
 b=owGbwMvMwCVWo/Th0Gd3rumMp9WSGLLZOHlld3oxmRxunr97FU/7nKM2v/Y0x31SWHpRWCT+X
 1JzTLlLRykLgxgXg6yYIot0W2T+zOdVvCVefhYwc1iZQIYwcHEKwEQM7jP8U4/fs6dcyUpn45Wp
 lTqe9nedmT8JZ4UESOVt+HowqX7hKkaGhyu3TXx+JP3WjK3ap7efPX1gXp3NzcWe0rvk+8W1ayQ
 e8AEA
X-Developer-Key: i=matttbe@kernel.org; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

From: Chris Mason <mason@kernel.org>

An established MPTCP connection that falls back to TCP after a zero
window probe or a reinjection can stall in one direction, so that recv()
returns neither the remaining data nor end of file.

After a fallback, subflow_check_data_avail() gives each skb a dummy
mapping, at the data sequence number (DSN) iasn + SSN - 1, where iasn is
the DSN of the peer's first byte and SSN is the subflow sequence number.
This is right only as long as DSNs and SSNs advance together, but a zero
window probe or a reinjection maps old data a second time, which takes
new SSNs and no new DSN. Each later dummy mapping is then too high, so
__mptcp_move_skb() treats all further data as out of order:

    data    SSN 1 to 1000    DSN iasn to iasn + 999
    probe   SSN 1001         DSN iasn + 999, dropped
    ack_seq                  iasn + 1000, the next DSN expected
    dummy   SSN 1002         DSN iasn + 1001

The fix used here is to:
- keep in the new member dsn_base of the subflow context the first DSN
  of the peer's last mapping, minus its first SSN, plus 1
- compute the DSN of a dummy mapping as dsn_base + SSN - 1
- keep in the new member dsn_end the highest end of a mapping of the
  peer so far
- make mptcp_try_fallback() fail while the peer's last mapping ends
  below dsn_end, so that the caller resets the subflow

32 bits are enough for both: the dummy mapping only takes the lower 32
bits of its DSN, see __mptcp_expand_seq(), and the end of a mapping
stays within a window of dsn_end.

One case is left: if only the receiver falls back after a zero window
probe or a reinjection, it now delivers data resent at the MPTCP level
as new data, unless the sender resets the subflow before, as it does
since "mptcp: don't resend data acked without MPTCP opts". Without this
patch, the receiver stalled instead.

This issue has been found with the help of an LLM, and reproduced in a
VM, with the reproducer shared with the original version of this patch,
and with a new Packetdrill test: between two unmodified Linux hosts,
nftables removing the MPTCP options after a zero window probe, a DSS
checksum failure, or a failed MP_JOIN. Without this patch, the reader
stalled for good, the data staying in the out-of-order queue:

  receiver  22.764: READ-TOTAL outcome ii-right-so-far-then-nothing bytes 2670592 of 8388608 [...]
  [...] end: hang: no data and no end of file for 20 s
  RESULT [...] R: DssFallback=1 [...] OFOQueue=204 NoDSSInWindow=145 [...]

And with the Packetdrill test:

  dss_fallback_after_probe_server.pkt:25: runtime error in read call: Expected result 2000 but got 1000 with errno 22 (Invalid argument)

Fixes: 2834f8edd74d ("mptcp: cleanup fallback dummy mapping generation")
Signed-off-by: Chris Mason <mason@kernel.org>
[ dsn_base and dsn_end on 32 bits: struct mptcp_subflow_context grows by
  8 bytes instead of 16, and lent_mem_frag stays in the same cacheline.
  Shorter comments. Moved after "mptcp: stop resending data to a peer
  that fell back": alone, this patch turns a stall into data delivered
  twice, when only the receiver falls back after a probe or a
  reinjection. Commit message: mention the remaining case + how the
  issue was found, and its symptoms. ]
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
v2: msg: the sender now resets in the remaining case (Clashiko)

Note (Sashiko): the remaining case, when only the receiver falls back,
needs a sender not resetting the subflow, e.g. with an older kernel: the
data is then delivered twice, instead of a stall before this patch. The
RFC at the end of this series resets instead of falling back.

Note (Clashiko on v2): a reinjection of old data with a bad checksum is
reset one RTT later, after the MP_FAIL: theoretical, it needs DSS
checksums, a reinjection and a corruption.
---
 net/mptcp/protocol.h |  9 ++++++++-
 net/mptcp/subflow.c  | 21 ++++++++++++++++++---
 2 files changed, 26 insertions(+), 4 deletions(-)

diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
index 9a9dbab672af..7cdd0a7e8296 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -582,6 +582,8 @@ struct mptcp_subflow_context {
 	__wsum	map_data_csum;
 	u32	map_csum_len;
 	u32	prev_rtt_seq;
+	u32	dsn_base;	    /* MPC: DSN - SSN + 1 of peer's last map */
+	u32	dsn_end;	    /* MPC: highest end of the peer's maps */
 	u32	request_mptcp : 1,  /* send MP_CAPABLE */
 		request_join : 1,   /* send MP_JOIN */
 		request_bkup : 1,
@@ -606,7 +608,8 @@ struct mptcp_subflow_context {
 		mpc_drop : 1,	    /* the MPC option has been dropped in a rtx */
 		resetting : 1,	    /* subflow is resetting */
 		old_data_pending : 1, /* old data not acked with MPTCP opts */
-		__unused : 8;
+		map_old : 1,	    /* MPC: peer's last map is below dsn_end */
+		__unused : 7;
 	bool	data_avail;
 	bool	scheduled;
 	bool	pm_listener;	    /* a listener managed by the kernel PM? */
@@ -1350,6 +1353,10 @@ static inline bool mptcp_try_fallback(struct sock *ssk, int fb_mib)
 
 	msk = mptcp_sk(sk);
 
+	/* the peer might still be resending old data */
+	if (subflow->map_old && !__mptcp_check_fallback(msk))
+		return false;
+
 	/* queued old data would be sent without mapping after a fallback */
 	if (subflow->old_data_pending && !__mptcp_check_fallback(msk))
 		return false;
diff --git a/net/mptcp/subflow.c b/net/mptcp/subflow.c
index 3590c1207e88..f73e4b8deca4 100644
--- a/net/mptcp/subflow.c
+++ b/net/mptcp/subflow.c
@@ -540,6 +540,8 @@ static void subflow_set_remote_key(struct mptcp_sock *msk,
 
 	/* for fallback's sake */
 	subflow->map_seq = subflow->iasn;
+	subflow->dsn_base = subflow->iasn;
+	subflow->dsn_end = subflow->iasn;
 
 	WRITE_ONCE(msk->remote_key, subflow->remote_key);
 	WRITE_ONCE(msk->ack_seq, subflow->iasn);
@@ -1438,6 +1440,17 @@ static bool mptcp_subflow_fail(struct mptcp_sock *msk, struct sock *ssk)
 	return true;
 }
 
+/* Fallback: dummy maps go on from the last valid one, unless it is old */
+static void subflow_update_dsn_base(struct mptcp_subflow_context *subflow)
+{
+	u32 end = subflow->map_seq + subflow->map_data_len;
+
+	subflow->dsn_base = subflow->map_seq - subflow->map_subflow_seq + 1;
+	subflow->map_old = before(end, subflow->dsn_end);
+	if (!subflow->map_old)
+		subflow->dsn_end = end;
+}
+
 static bool subflow_check_data_avail(struct sock *ssk)
 {
 	struct mptcp_subflow_context *subflow = mptcp_subflow_ctx(ssk);
@@ -1471,6 +1484,8 @@ static bool subflow_check_data_avail(struct sock *ssk)
 		if (unlikely(!READ_ONCE(msk->can_ack)))
 			goto fallback;
 
+		subflow_update_dsn_base(subflow);
+
 		old_ack = READ_ONCE(msk->ack_seq);
 		ack_seq = mptcp_subflow_get_mapped_dsn(subflow);
 		pr_debug("msk ack_seq=%llx subflow ack_seq=%llx\n", old_ack,
@@ -1501,6 +1516,7 @@ static bool subflow_check_data_avail(struct sock *ssk)
 				subflow->reset_reason = MPTCP_RST_EMIDDLEBOX;
 				goto reset;
 			}
+			subflow_update_dsn_base(subflow);
 			WRITE_ONCE(subflow->data_avail, true);
 			return true;
 		}
@@ -1532,9 +1548,8 @@ static bool subflow_check_data_avail(struct sock *ssk)
 	subflow->map_data_len = skb->len;
 	subflow->map_subflow_seq = TCP_SKB_CB(skb)->seq - subflow->ssn_offset;
 	subflow->map_seq = __mptcp_expand_seq(subflow->map_seq,
-					      subflow->iasn +
-					      TCP_SKB_CB(skb)->seq -
-					      subflow->ssn_offset - 1);
+					      subflow->dsn_base +
+					      subflow->map_subflow_seq - 1);
 	WRITE_ONCE(subflow->data_avail, true);
 	return true;
 }

-- 
2.55.0

