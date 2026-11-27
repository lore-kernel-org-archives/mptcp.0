Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795809723;
	b=atykDUkABdDufp3PYU/0pQnkNEx5ELtIZ8vkrovduUsnVYdhgB3+wFSAkz5yyZN8wqjR
	 HzhjwGWjOvj4sgAWifp7REjvmofkt8JRPrIzUXjrtkp0NYG/QccyyFkVXaz9DcPEEGZUy
	 fwk5TqAi2DEyWeI4vXuDFpoY3tPT3rumTnSZLwrepNRUTakkKOhJG9r6orB+UqGfvpfX0
	 GQecw/eGY4XxHNpzQbLzoWyhIuu+P+gLeYOkoOSu3AsvgokAJ7uw72i7ws1N6vkQUZni2
	 O9i/24FWTBwUNOFXcjKkbzo74XwIH2nhNI5vu44IC40iiVqzQd8OWRzmWb+N3/XLJnw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795809723;
	h=Received:DKIM-Signature:From:Subject:Date:Message-Id:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:X-B4-Tracking:X-Change-ID:To:
	 Cc:X-Mailer:X-Developer-Signature:X-Developer-Key;
	bh=gTOaImylU5HERiMiRFPxqe4vVLn44zTkMmCotFhyFsU=;
	b=QGAwvE+ptj0jhwh3AcPPbFdt08DV8KBU+Q+sUDoQThy1kaQAUHYS7cAVcK3WUqnqDaZi
	 W7iR1rmV1WPffeaUuJX+WjLpZikjVML5aa5CFXl9EmKkXKTtcySGu3w3PG1AOFZc6oK8C
	 nP0Km9RN4L4yK73LclhGC3Pi/OiT2OXCykN8+WGYzoaHVu3O5kNJYXZZg9NHVdiul0MAn
	 rZ1GjMoKI0m6N70IwjQV5Rj2RVQMlbeijUq2Bfa/jkSKecE9UWMeMDLiPFlieHI+3a0mP
	 aIefN+YcG3q1MGQjg0Ic7+PLgFGrGmB37RWR8pzHPEc45TdLUAWMl1RK+kcf8jUaFEg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="Vie/56GD";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB64C606A31C
	for <mptcp@lists.linux.dev>; Fri, 27 Nov 2026 20:02:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Vie/56GD
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C21871F000C1;
	Fri, 27 Nov 2026 20:02:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795809722;
	bh=gTOaImylU5HERiMiRFPxqe4vVLn44zTkMmCotFhyFsU=;
	h=From:Subject:Date:To:Cc;
	b=Vie/56GDFLWorlY785jbKJetFVGrjPAGiKgwJRGo+g0mfJZPaIAc2guFPu1mTXTPm
	 XI3+Us5icrldIk6LqNtp0iAkl9nBsm/m/uv9JtqJmfTXP2IlRtbjANDIrYDCGdranK
	 TXGqKaN1WiWpP2N8eHUu6IlOMWQ8nghsuWl/LIhp+bZGvJRURsZx9TokvDO+l0s1aQ
	 kk/oUW9oR1R6TxlmkjK+VvsM9MXO+SS8Vg0Ef+3uib+KIlrG4KYFiWpqTpyTXq3XBH
	 KNbv9sPbhwp05T1H0HeA/+in0yDEt3DLdOG0aNxCPNO6QsOgwzvY+wrO0b8KRW/WIL
	 L101xVFLKOeEQ==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Subject: [PATCH mptcp-net v4 00/20] mptcp: misc fixes
Date: Fri, 27 Nov 2026 21:01:24 +0100
Message-Id: <20261127-mptcp-cmason-fixes-v4-0-3f393ea8c48d@kernel.org>
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
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/23OTQ6CMBAF4KuQrq2Zafl15T2MCywDVKWQFonGc
 HcLuMDIcjLzvjdv5shqcuwQvJmlQTvdGj+Eu4CpOjcVcV34mQkQMSICb7pedVw1uWsNL/WTHCd
 SAFGo0hRy5oOdpXnhcye23Bvq2XlZucflSqqf0Om41q5v7Wt+YMA58u2SW10DcuCZgOiSJJTlo
 jzeyBq671tbzQ2DWBkCNw3hDQApkrLAgvDfkGsj3DSkN0KMFfhnVCJ/jXEcP7Jj0fxaAQAA
X-Change-ID: 20261110-mptcp-cmason-fixes-eec0054c880a
To: MPTCP Linux <mptcp@lists.linux.dev>
Cc: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>, 
 Shardul Bankar <shardul.b@mpiricsoftware.com>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=11158; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=evGp1O3UZXTdZS/mDZIxX7v7RYadINcz68NOlIdcW90=;
 b=owGbwMvMwCVWo/Th0Gd3rumMp9WSGLI5Hy41Prpk+XvtSYvm2BYVyk34asPF0r5hjeFF+4VSn
 A/8dha7d5SyMIhxMciKKbJIt0Xmz3xexVvi5WcBM4eVCWQIAxenAEzkWx0jw/0uRWWGJRcetRrd
 ulnz4pDvHgM9JuaWfVNKMv/mFsqw3mBkmOXh83cTT9+Ls75VoS4nFQ/UcDqGi+UKbpxzleHk3Zo
 NLAA=
X-Developer-Key: i=matttbe@kernel.org; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

Here are various fixes, one from Shardul Bankar:

- Patches 1-3: after a simultaneous connect, reset the MP_JOIN subflows,
  which could trigger a warning, or make the connection fall back to
  TCP, do not drop the first received byte, and move to ESTABLISHED
  without waiting for the next packet. Fixes for v5.7, v6.19, and for
  another fix introduced in v6.19 and targeting v6.2.

- Patch 4: with MSG_PEEK, do not skip data after a partly peeked skb:
  the peeked data was corrupted. A fix for v6.18.

- Patch 5: send the DATA_ACK of the data moved from the backlog, to
  avoid spurious MPTCP retransmissions, preventing a fallback after an
  MP_FAIL. A fix for v6.15.

- Patches 6-9: in the selftests, avoid spurious MPTCP retransmissions
  preventing the infinite fallback in the 'Infinite map' subtest, wait
  for the data to be acked before a fastclose, read the reply in the
  splice mode with MPTFO and a small file, and keep the connections open
  until the end of the diag checks with many connections. Fixes for
  v5.19, only effective from v7.3, for v6.1, v7.0, and v6.8.

- Patches 10-11: order the write_seq and DATA_FIN flag updates, not to
  send a DATA_FIN with the sequence number of the last byte, or a FIN
  before this byte after a fallback, on weakly ordered CPUs. Fixes for
  v5.9, and for another fix, now in net, and targeting v5.19.

- Patch 12: retransmit the DATA_FIN after the RTO, not at the next tick,
  once all the data has been acked. A fix for v5.15.

- Patch 13: in the default scheduler, do not truncate the pacing rates
  above 4 GB/s, nor let their running average wrap, which could make the
  fastest subflow look like the slowest one. A fix for v5.10.

- Patches 14-15: Squash-to patches for the BPF packet schedulers, in the
  MPTCP tree only: stop pushing when they pick no subflow, or one that
  cannot send, instead of spinning, and set the rtx timer interval
  before calling them, as done with the default scheduler.

- Patch 16: for mptcp-next: push the pending data, and the FIN, right
  after a fallback on reception, not at the next retransmission timeout.
  A non-urgent fix for v6.12.

- Patch 17: for mptcp-next: report the errors as TCP does when closing:
  ETIMEDOUT after the close timeout or the last subflow's RTO, and the
  reset errors when the last subflow is reset.

- Patch 18: for mptcp-next: name all the mapping statuses in a
  tracepoint.

- Patch 19: for mptcp-next: set ECONNRESET when a disconnect aborts a
  connection, as TCP does.

- Patch 20: RFC for mptcp-next: reset the subflow when the DSS
  disappears after a DATA_ACK, instead of a fallback to TCP, as
  suggested by RFC 8684.

The Packetdrill tests mptcp/regressions/close_mpj_timeout* will fail
because of patch 17, and
mptcp/fastopen/client-TCP_FASTOPEN_CONNECT-disconnect.pkt because of
patch 19: the Packetdrill patches adapting them will be shared later.

Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
Changes in v4:
- Patch 1: new, for an issue spotted by Sashiko.
- Patch 8: new, for a failure observed with the selftests.
- Patch 9: new, for a failure observed in the CI.
- Patch 12: new, for an issue spotted by Sashiko.
- Patch 13: new, Shardul's patch from the v5 of another series, with
  fixes, one for an issue reported by Clashiko and Abdul:
  https://patch.msgid.link/20261028-mptcp_penalise_send_v2-v5-1-32fb379ce117@mpiricsoftware.com
- Patch 15: commit msg: the rtx interval is no longer 0 since patch 12.
- Patch 17: process the ack of our DATA_FIN before picking the error,
  and comment in mptcp_poll() (Clashiko).
- Patch 19: new, for mptcp-next, for a difference with TCP found by a
  review agent.
- Patch 20: also reset on data past its mapping, but fall back after an
  infinite mapping without data (Sashiko, Clashiko).
- Other comments from Clashiko and Sashiko: notes under the "---" of the
  patches.
- Patches 1-36 from v3: dropped, applied in the MPTCP tree, with the
  modifications of v4 for patches 4, 6, 10, 12, 26, 29, 33, 34 and 36.
- Link to v3: https://patch.msgid.link/20261124-mptcp-cmason-fixes-v3-0-416c0920c73f@kernel.org

Changes in v3:
- Patch 4: process the DATA_FIN before the disconnect of the first
  subflow, which clears its FIN (Clashiko).
- Patch 5: stop passing data to the MPTCP socket before checking for
  unread data (Clashiko).
- Patch 6: no second reset for the children of a closed listener, also
  without fallback (Clashiko).
- Patch 11: commit msg: the flaky subtest is fixed by patch 7, and the
  remaining issue (Clashiko).
- Patch 14: new, for an issue spotted by Clashiko.
- Patch 17: comment and commit msg: also after a disconnect, and what
  write() does without the race (Clashiko).
- Patch 18: move the subflow to TCP_CLOSE at once (Clashiko).
- Patch 19: also skip the disconnect for a connected socket, not to
  drop data to read (Clashiko).
- Patch 21: commit msg: the netns pinned by the queued children
  (Clashiko).
- Patches 25-26: commit msg: why an MSS decrease before the infinite
  mapping is acked is not handled (Clashiko).
- Patch 38: also check if MPTCP is blocked (Clashiko).
- Patch 43: new, for an issue spotted by Clashiko.
- Patch 44: only the acquire, the release being in patch 43.
- Patches 45-46: stop the push loop of __mptcp_push_pending() too, and
  set the rtx timer interval when a subflow is already scheduled
  (Clashiko).
- Patch 49: new, for an issue spotted by Clashiko.
- Patch 50: name the new mapping status in the tracepoint, and commit
  msg: all invalid mappings (Clashiko).
- Other comments from Clashiko: notes under the "---" of the patches.
- Patches 1-11, 32-33, 35 and 45 from v2: dropped, applied in the MPTCP
  tree, with the modifications of v3 for patches 6, 7 and 45.
- Link to v2: https://patch.msgid.link/20261121-mptcp-cmason-fixes-v2-0-00327fd1de1f@kernel.org

Changes in v2:
- Patches 1-2: on top of commit 342e62fd34c2 ("tcp: purge Fast Open RST
  queue when listen() fails"), which purges the RST queue: only the
  accept queue is left. Patch 2 is now reproduced, with MPTCP sockets.
- Patch 5: no netlink event for the dropped ids (Clashiko), but still
  for the next pending ones (Sashiko).
- Patch 6: send the RM_ADDR at once (Clashiko).
- Patch 7: new, for an issue spotted by Clashiko.
- Patch 12: new, for issue #647 reported on GitHub.
- Patch 13: new, to limit the orphans kept by patch 12, as TCP does,
  for an issue found by a review agent.
- Patch 14: new, spotted by a review agent.
- Patch 15: new, for issue #647 reported on GitHub.
- Patch 16: new, for a similar issue found by a review agent.
- Patch 17: new, for an issue found by a review agent.
- Patch 18: new, for issue #648 reported on GitHub.
- Patch 19: new, for a similar issue found by a review agent.
- Patch 20: new, for an issue found by a review agent and Sashiko.
- Patches 21-23: new, for issues causing flaky selftests.
- Patches 24-25: new, for issues found by a review agent.
- Patch 26: new, for an issue found by a review agent.
- Patch 27: new, for an issue spotted by Sashiko.
- Patch 28: new, for an issue found by a review agent.
- Patches 29-30: new, for issues found by a review agent.
- Patch 34: commit msg: the reset after a bad checksum too (Sashiko).
- Patch 36: count the listener once listen() succeeded, and restore
  TCP_CLOSE otherwise (Sashiko, Kyuwon Cho).
- Patch 37: commit msg: explain the two Fixes tags.
- Patch 38: new, for an issue causing a flaky selftest.
- Patch 39: new, for an issue spotted by Sashiko.
- Patch 40: commit msg: the peer can still fall back alone (Clashiko),
  and only clamp to one MSS when sending the infinite mapping (Sashiko).
- Patch 41: drop the segment if the push resets the subflow (Sashiko,
  Clashiko).
- Patch 42: new, for an issue spotted by Clashiko.
- Patch 44: skip a part if the nft rule cannot be added (Clashiko).
- Patch 49: update a comment (Clashiko).
- Patch 50: commit msg: the sender now resets in the remaining case
  (Clashiko).
- Patch 51: new, for an issue spotted by Sashiko.
- Patch 52: new, for an issue found by a review agent, after a Sashiko
  review.
- Patch 53: new, for an issue causing a flaky selftest.
- Patch 54: new, for an issue causing a flaky selftest.
- Patches 55-56: new, for flaky selftests.
- Patch 57: new, for an issue spotted by Clashiko in a fix pending in
  net.
- Patch 58: new, for an issue found by a review agent.
- Patch 59: new, for an issue spotted by Clashiko.
- Patch 60: new, for mptcp-next, for an issue spotted by Clashiko in a
  fix pending in net.
- Patch 61: new, for mptcp-next, as suggested in the GitHub issue #648.
- Patch 62: also reset on an invalid mapping (Clashiko).
- Patches 11, 23-26 and 32 from v1: dropped, applied in the MPTCP tree.
- Link to v1: https://patch.msgid.link/20261113-mptcp-cmason-fixes-v1-0-9205b77e9a2f@kernel.org

---
Matthieu Baerts (NGI0) (19):
      mptcp: reset MP_JOIN subflows on simult connect
      mptcp: keep the first byte after a simult connect
      mptcp: move to ESTABLISHED after a simult connect
      mptcp: fix MSG_PEEK after a partly peeked skb
      mptcp: send the DATA_ACK after moving the backlog
      selftests: mptcp: join: infinite map: no spurious rtx
      selftests: mptcp: connect: trunc: wait for acks
      selftests: mptcp: connect: splice: handle MPTFO
      selftests: mptcp: diag: wait longer before closing
      mptcp: order write_seq and DATA_FIN flag
      mptcp: order write_seq and DATA_FIN flag for fallback
      mptcp: reset the rtx interval to the min RTO
      Squash to "bpf: Add mptcp packet scheduler struct_ops"
      Squash to "bpf: Export mptcp packet scheduler helpers"
      [mptcp-next] mptcp: push pending data after a fallback on reception
      [mptcp-next] mptcp: report errors as TCP does when closing
      [mptcp-next] mptcp: trace: name all the mapping statuses
      [mptcp-next] mptcp: set ECONNRESET on disconnect, as TCP does
      [RFC mptcp-next] mptcp: reset when the DSS disappears after a DATA_ACK

Shardul Bankar (1):
      mptcp: sched: avoid truncating the pacing rate in the scheduler

 include/trace/events/mptcp.h                      |  13 +-
 net/mptcp/mib.h                                   |   4 +-
 net/mptcp/options.c                               |  23 ++-
 net/mptcp/protocol.c                              | 177 +++++++++++++++++-----
 net/mptcp/protocol.h                              |  14 +-
 net/mptcp/sched.c                                 |   5 +
 net/mptcp/subflow.c                               |  55 ++++++-
 tools/testing/selftests/net/mptcp/diag.sh         |  10 +-
 tools/testing/selftests/net/mptcp/mptcp_connect.c |  41 ++++-
 tools/testing/selftests/net/mptcp/mptcp_join.sh   |   6 +
 10 files changed, 284 insertions(+), 64 deletions(-)
---
base-commit: 3af60e2b875037f465ca2fb7894b86e97befe8c0
change-id: 20261110-mptcp-cmason-fixes-eec0054c880a

Best regards,
--  
Matthieu Baerts (NGI0) <matttbe@kernel.org>

