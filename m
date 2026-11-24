Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795557714;
	b=MgPacSG++EhkSz4yQ/9EDW+y8LZZYr/gSn0nKe6k8chELYOn4kRJFicxMwaKY1BHUQqR
	 myF49MUH5KPx4Nr/+0WrPqkeztIOaRc7TVt8qg1541RsrtpZbZ/KzXw9pl3EiUn/unlco
	 OPoz2hfVB18tjlnP4ohJUsdWLwwzf4mncc4PPNIm/xmwNM7mZNyRJHj3xTtWoxJ9bDvrg
	 eFIl5baBsYr4FUm7sTp7M8+Zfk+/THrAWETRrwLchs/tM8coktjdwHd2p0t3CtlBRNaaO
	 ow0fh23JER6vC5OaUFW/Lwemb1L/6jkh1btf5eEdz+OTIGlBPDK2aveHfiGNpOgk8mQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795557714;
	h=Received:DKIM-Signature:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer:X-Developer-Signature:X-Developer-Key;
	bh=bRj+iw09z95Vt4m3slu/ZkNAqRgTDYxqJvcCjFrJfQU=;
	b=zVD5KZKPC6uPPoDWMWKxOHAnN3ESd8YHCbOpMHNwqIDTiUHe/BDArdRewOEOilNNpJtA
	 FOJXtABCjecQY9OUsqOcP7aoOpaH8sCLY1tszjnqsyhXVAYcHTMrFJazBbOwJNHJyCe1U
	 W1++2fGGPnEPW2qGLoDJayhwrECYtbJjdTXoNosh3sRFaj4pc6GNrsYIzhjNNV0gCtmM7
	 c5S+jJQJuaO8SAvm66/tMapOLybxDcnfbU8aP72l6TgSbZ7YYZ8AA5hSGJ1B2UJ9GexDM
	 ktjlqoqe8LxqhLtWxDi7u9tv2fsF5dttQl979J0JIaQHCudwQPh6o5Gwk5e5KS/XsiA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=g8jTetPY;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29968606A31E
	for <mptcp@lists.linux.dev>; Tue, 24 Nov 2026 22:01:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=g8jTetPY
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4DA511F000C4;
	Tue, 24 Nov 2026 22:01:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795557713;
	bh=bRj+iw09z95Vt4m3slu/ZkNAqRgTDYxqJvcCjFrJfQU=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=g8jTetPYHgNhwYC+ZMg3Wfj1fzQbIs+VmqhnBUMmwBSXOwIiDhTCOonqcgKdEF5ee
	 LmQnffQmZ5UPA3rr1N5af38WZ7F7Ys5v5V4W0j67cYB8Nx4VZgC33B0zon711aNrW6
	 hN6MK4LF1v9kS0ZNN2/sK1PZNrJc4h2kZjFsqPapMLpovLx8wba/LZz5wNFSn3+iN7
	 MWNNEak1AGekdnTWJoaSpbSVwxWn0wwcEi3MR59LeljOwciQHcvYAz5C8CxttqZbGd
	 YeUrfroGPpMEpBuzaV+gKNmRM76DI3XZ0+AWnORCuVsnizlKhl3D1cbGjiF9iEfdGe
	 O3h89Yq9ytC/w==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Tue, 24 Nov 2026 23:00:02 +0100
Subject: [PATCH mptcp-net v3 45/50] Squash to "bpf: Add mptcp packet
 scheduler struct_ops"
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
Message-Id: <20261124-mptcp-cmason-fixes-v3-45-416c0920c73f@kernel.org>
References: <20261124-mptcp-cmason-fixes-v3-0-416c0920c73f@kernel.org>
In-Reply-To: <20261124-mptcp-cmason-fixes-v3-0-416c0920c73f@kernel.org>
To: MPTCP Linux <mptcp@lists.linux.dev>
Cc: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
X-Mailer: b4 0.17-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=3205; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=2q1ai/hXQweAc/Y1uF2TOJhqJ0hbp/UliAcw49JGtR4=;
 b=owGbwMvMwCVWo/Th0Gd3rumMp9WSGLLZOIULEngrpe9yas9+sVF6ymeTTeximYsfpzqZMpl9y
 fR6kD6jo5SFQYyLQVZMkUW6LTJ/5vMq3hIvPwuYOaxMIEMYuDgFYCI7FzP8T2ds3Jyy/f/W2VPt
 VqRtcby7n91bY8bXsvwzpnuTvl89/Jnhf7K1/cUvSTFHrMN/H6s3frfJ+I/zDDMWI+ZnLK94r0X
 KMAEA
X-Developer-Key: i=matttbe@kernel.org; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

A BPF scheduler can return 0 from get_send() without picking any
subflow, e.g. the bkup one from the BPF selftests, when all the subflows
are backup on both sides. With data to send, a DATA_ACK received while
the msk is not owned by the user then makes the push loop of
__mptcp_subflow_push_pending() spin forever, in softirq:

  watchdog: BUG: soft lockup - CPU#2 stuck for 49s! [python3:182]
  (...)
  RIP: 0010:bpf_iter_mptcp_subflow_next+0xf/0x40
  (...)
  Call Trace:
   <IRQ>
   bpf_prog_bf2471f1d206d5cc_bpf_bkup_get_send+0x78/0xd7
   bpf__mptcp_sched_ops_get_send+0x4c/0xb0
   __mptcp_subflow_push_pending+0x148/0x390
   mptcp_incoming_options+0x836/0xba0
   tcp_data_queue+0x6da/0x10c0
   tcp_rcv_established+0x2d5/0xce0
   tcp_v4_do_rcv+0x13f/0x300
   tcp_v4_rcv+0xbff/0x1200
   (...)

Stop this loop when the current subflow is not picked: if another one
is, the loop already stops after delegating the push to it. The default
scheduler always picks a subflow when returning 0: not affected.

This issue has been found by an AI code review agent, while reviewing a
patch for the BPF schedulers, and confirmed with a reproducer: the bkup
scheduler on the client side, its only subflow marked as backup on both
sides, data queued by the client, then data sent by the server, carrying
the DATA_ACK causing the soft lockup above.

Similarly, the push loop of __mptcp_push_pending() spins forever, with
the msk and subflow locks held, when a BPF scheduler keeps picking a
subflow that cannot send, e.g. a new subflow in SYN_SENT picked by the
bkup scheduler before its backup flag is set: mptcp_sendmsg_frag() then
returns -EAGAIN, which does not decrease push_count in this state.
Decrease it after any failure: -EAGAIN is only returned for a subflow
that cannot send, or that has just been reset. The default scheduler
does not pick such subflows: not affected.

This second issue has been found by an AI code review agent (Clashiko),
while reviewing a previous version of this patch.

Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
v2: new, for an issue found by a review agent
v3: also stop the push loop of __mptcp_push_pending() when the picked
    subflow cannot send (Clashiko)
---
 net/mptcp/protocol.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index f361cd40a8e4..a3c2d8f93bd7 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -1901,10 +1901,7 @@ void __mptcp_push_pending(struct sock *sk, unsigned int flags)
 
 				ret = __subflow_push_pending(sk, ssk, &info);
 				if (ret <= 0) {
-					if (ret != -EAGAIN ||
-					    (1 << ssk->sk_state) &
-					     (TCPF_FIN_WAIT1 | TCPF_FIN_WAIT2 | TCPF_CLOSE))
-						push_count--;
+					push_count--;
 					continue;
 				}
 				copied = true;
@@ -1961,6 +1958,9 @@ static void __mptcp_subflow_push_pending(struct sock *sk, struct sock *ssk, bool
 				keep_pushing = false;
 			else
 				copied += ret;
+		} else {
+			/* a BPF scheduler might not pick any subflow */
+			keep_pushing = false;
 		}
 
 		mptcp_for_each_subflow(msk, subflow) {

-- 
2.55.0

