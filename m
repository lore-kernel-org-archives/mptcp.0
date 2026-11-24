Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795557658;
	b=jpKLiAKRIMh8uMvrBHMVWMYJFyO4FtaUSjhiiElI7X39PU8LSwC6awhVbEW7CxJfisgD
	 KMvW4TY4Xs94i27Nj+jxYzWlttQ1wuNmJlEK9gs1zSlRyM4x3TeoPsTKYbonC20FMPgyh
	 vZ2qpV0te9/wjraoqqnUDmkH4ZRw15kZFO9AVCpG12fe+lL0VYTfu8f5bYyMlnUh+i60i
	 A3MuRK6j0UAMOmXH0iRXvDW3G0BLusBtjN512eLzKuY9TmOdPHmgkOSJirwzznd2yZglS
	 a8RxavvbVj4+fmJ5NC5bAGRDTGon6javVq3B+FhytaQ+SLhAQZj1Dl1LHpN4fRvdfbg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795557658;
	h=Received:DKIM-Signature:From:Subject:Date:Message-Id:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:X-B4-Tracking:X-Change-ID:To:
	 Cc:X-Mailer:X-Developer-Signature:X-Developer-Key;
	bh=opauoFSxKWsj3/fHcaHSAMnY5xeL3zswYiKs92l9WQI=;
	b=yAnYOYWYjjay+S88tEkljT9W3n7jzo8WL0qTwjelW3dTkKncc4PF1VigSe8C5ZFDTuZK
	 bvfY+KNKPFVUSmzVSi9dWzBgt9CgjlsfT5XmVdK7ikTTjAHzhxvl9/Q5LHL7mM+ogx/Ew
	 j4oq/Zb3HA2Ej5sCg0FoTo9xfc1l7cKSsyHt2Ffg9MCif85TL+vN7VEtCwoS79tRm+0dl
	 rwK8+F9R/gqTGvyOBg1K5U2NZkMG1hf3PYwywinVltT43AI/4e5Irde8KAq+mGeN8FPwV
	 eTWQJ3pmyRoVnzISbQMkazQTHEl4YRnFForduGuATAMxtgEyUpebC3BqhV/xAeB0H6g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=h6y1e5ee;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93B51606A32A
	for <mptcp@lists.linux.dev>; Tue, 24 Nov 2026 22:00:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=h6y1e5ee
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 385351F000C6;
	Tue, 24 Nov 2026 22:00:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795557658;
	bh=opauoFSxKWsj3/fHcaHSAMnY5xeL3zswYiKs92l9WQI=;
	h=From:Subject:Date:To:Cc;
	b=h6y1e5ee9JYtQQ5cPxaNinS4kmsA8Lv5YI5UPipgrCEW45fylCnDmoL0i2Fr7TPen
	 JzTw7s+5oDJ6gB9k/sQn7kw6s+GAH1Oy/46Qy4YSvOjvr5nGZuZk++QIYDA6X6RgQh
	 cA1gbKTaNBdsHd6N7XdLLBcij5lGKidGs3l0OfTEotK+sc3t8m0tnXFtM0zI0VEBrL
	 OSxh90E4IGBYpPjxF7Rk73G0/wn3qhZLtTJ5QzFBTSMSNkeXb9yg+RMvNJ8LJCxuxr
	 ANWMZ0SS2rirAbCWPWlccbJ6qM+JzRZe3RJlNiAL3EQ0AOSAnTmYL7c8oXyCTANUfi
	 zLJQHb1cZVMww==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Subject: [PATCH mptcp-net v3 00/50] mptcp: misc fixes
Date: Tue, 24 Nov 2026 22:59:17 +0100
Message-Id: <20261124-mptcp-cmason-fixes-v3-0-416c0920c73f@kernel.org>
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
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/22OQQ6CMBREr0K6tua3iIAr72FclPKBqrSkrY2Gc
 HcLuNCE5WRm3sxIHFqFjpySkVgMyimjo0h3CZGd0C1SVUdNOPAjYwxoP3g5UNkLZzRt1AsdRZQ
 A2UEWBQgSi4PFxYi9C1nzGj25rpZ7VjeUfobO4U45b+x7ORDYUvlupVtbgVGgJYesynMsBW/Od
 7QaH3tj22Uh8B8GZ5sMHhkAKc+bmtXI/hnTNH0AxZh0sBYBAAA=
X-Change-ID: 20261110-mptcp-cmason-fixes-eec0054c880a
To: MPTCP Linux <mptcp@lists.linux.dev>
Cc: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>, 
 Chris Mason <mason@kernel.org>, Kyuwon Cho <kyuwoncho18@gmail.com>, 
 Josef Bacik <josef@toxicpanda.com>
X-Mailer: b4 0.17-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=14104; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=Whi9N9byEMjw2Yi8DOX10XHbr/CcIb+kbBmEmO8rz6k=;
 b=owGbwMvMwCVWo/Th0Gd3rumMp9WSGLLZOF4lqJSv2zjrKr9qJ9O5jVLiqit2r4pL+Gw1cQG/3
 DP7Qzv7OkpZGMS4GGTFFFmk2yLzZz6v4i3x8rOAmcPKBDKEgYtTACaSlMHIsO/RtQnXGTt6p158
 Pf9Ls/GvgH/K17eE3LQyjt65Wne14AaG/4kztWY3Betbbmk7q32uazF39zE2l/iyNbZ+E5fuEan
 fzgIA
X-Developer-Key: i=matttbe@kernel.org; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

Here are various fixes, some from Chris Mason and Josef Bacik:

- Patches 1-6: do not reset an orphan while it can still send its data,
  also after a fallback, but limit it with a closed window, and count it
  as TCP does, so that tcp_max_orphans limits it too. Also return EOF
  after a DATA_FIN followed by a reset, and send a reset when aborting
  after a fallback, as TCP does. Fixes for v5.11, v5.12, v6.1, and for
  another fix introduced in v6.18 and targeting v6.1.

- Patches 7-9: wake up the senders blocked when the connection is closed
  without subflows, after a subflow error, or when the initial subflow
  is only shut down. Fixes for another fix introduced in v6.6 and
  targeting v5.11, and for v5.12.

- Patches 10-14: process a DATA_FIN received with old data, and a
  pending MP_FASTCLOSE or DATA_FIN before closing without subflows, also
  at accept() time, instead of ignoring them, and report a reset
  received before accept(): the reader could miss the end of file or
  the reset. Fixes for v5.9, v6.6, v6.19 and v6.3.

- Patch 15: clear the socket error on connect(), as TCP does. A fix for
  v5.17.

- Patches 16-17: with TCP_FASTOPEN_CONNECT, clear DEFER_CONNECT on
  disconnect, and report the error of a first subflow aborted before the
  first write(), instead of EINVAL or EISCONN. Fixes for v6.1, and for
  another fix introduced in v7.4-rc3 and targeting v4.11.

- Patch 18: do not send a fastclose reset from a subflow in SYN_SENT, as
  TCP does. A fix for another fix introduced in v6.18 and targeting
  v6.1.

- Patches 19-20: keep listening, or keep the data to read, after a
  failed sendmsg() with MSG_FASTOPEN, as TCP does, and do not let the
  new sockets created meanwhile inherit a flag preventing their
  disconnection. Fixes for another fix introduced in v6.2 and targeting
  v6.1.

- Patch 21: drop the ACKs with a SYN cookie and no MP_JOIN on PM
  listeners, which could stop accepting new subflows, and pin their
  netns. A fix for v5.12.

- Patch 22: close a subflow reset because of a bad mapping, not to keep
  the MPTCP socket established without subflows. A fix for v5.12.

- Patches 23-24: count MPTCP listeners correctly in /proc/net/protocols,
  and send their creation event once. Fixes for another fix introduced
  in v6.4 and targeting v5.17, and for v6.2.

- Patches 25-26: send the infinite mapping in a single segment, with
  room for its DSS option, also after a fallback on reception: its
  segments could be bigger than the MTU, and then dropped. Fixes for
  v5.19.

- Patches 27-29: avoid data delivered twice around a fallback to TCP,
  with old data in flight, or resent to a peer that fell back. Fixes for
  v5.19, and for another fix introduced in v6.12 and targeting v5.13.

- Patches 30-31: do not count a signal+subflow ID 0 endpoint as used at
  each re-creation, and validate it. A fix for another fix introduced in
  v6.11 and targeting v6.0.

- Patches 32-35: reclaim the forward memory after coalescing skbs, and
  do not overcharge the memcg at accept(). Fixes for v6.19.

- Patch 36: after a fallback, continue the last mapping. A fix for
  v6.19.

- Patches 37-38: after a simultaneous connect, do not drop the first
  received byte, and move to ESTABLISHED without waiting for the next
  packet. Fixes for v6.19, and for another fix introduced in v6.19 and
  targeting v6.2.

- Patch 39: with MSG_PEEK, do not skip data after a partly peeked skb:
  the peeked data was corrupted. A fix for v6.18.

- Patch 40: send the DATA_ACK of the data moved from the backlog, to
  avoid spurious MPTCP retransmissions, preventing a fallback after an
  MP_FAIL. A fix for v6.15.

- Patches 41-42: in the selftests, avoid spurious MPTCP retransmissions
  preventing the infinite fallback in the 'Infinite map' subtest, and
  wait for the data to be acked before a fastclose. Fixes for v5.19,
  only effective from v7.3, and for v6.1.

- Patches 43-44: order the write_seq and DATA_FIN flag updates, not to
  send a DATA_FIN with the sequence number of the last byte, or a FIN
  before this byte after a fallback, on weakly ordered CPUs. Fixes for
  v5.9, and for another fix, now in net, and targeting v5.19.

- Patches 45-46: Squash-to patches for the BPF packet schedulers, in the
  MPTCP tree only: stop pushing when they pick no subflow, or one that
  cannot send, instead of spinning, and set the rtx timer interval
  before calling them, not to fire the timer every jiffy.

- Patch 47: for mptcp-next: push the pending data, and the FIN, right
  after a fallback on reception, not at the next retransmission timeout.
  A non-urgent fix for v6.12.

- Patch 48: for mptcp-next: report the errors as TCP does when closing:
  ETIMEDOUT after the close timeout or the last subflow's RTO, and the
  reset errors when the last subflow is reset.

- Patch 49: for mptcp-next: name all the mapping statuses in a
  tracepoint.

- Patch 50: RFC for mptcp-next: reset the subflow when the DSS
  disappears after a DATA_ACK, instead of a fallback to TCP, as
  suggested by RFC 8684.

The Packetdrill tests mptcp/regressions/close_mpj_timeout* will fail
because of patch 48: the Packetdrill patches adapting them will be
shared later.

Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
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
Chris Mason (8):
      mptcp: drop non-MP_JOIN cookie ACKs on PM listeners
      mptcp: close a subflow reset for a bad mapping
      mptcp: do not fallback while old data is in flight
      mptcp: stop resending data to a peer that fell back
      mptcp: reclaim forward memory after coalescing skbs
      mptcp: don't charge a shared page twice at accept()
      mptcp: don't charge the backlog twice at accept()
      mptcp: continue the last mapping after a fallback

Josef Bacik (1):
      mptcp: pm: kernel: don't count signal+subflow ID 0 endp

Matthieu Baerts (NGI0) (41):
      mptcp: keep an orphan while it can send its data
      mptcp: limit an orphan probing a zero window
      mptcp: count orphans as TCP does
      mptcp: return EOF after a DATA_FIN, as TCP does
      mptcp: let TCP send orphan data after fallback
      mptcp: reset the subflow on abort after fallback
      mptcp: wake up blocked senders when no sf left
      mptcp: set SEND_SHUTDOWN on close by an sf error
      mptcp: start close timeout on initial sf shutdown
      mptcp: process a DATA_FIN received with old data
      mptcp: no sf left: process pending MP_FASTCLOSE
      mptcp: no sf left: process pending DATA_FIN
      mptcp: process pending close events at accept()
      mptcp: report errors received before accept()
      mptcp: clear sk_err on connect(), as TCP does
      mptcp: clear DEFER_CONNECT on disconnect
      mptcp: report sf aborts during deferred connect
      mptcp: no fastclose reset from SYN_SENT subflows
      mptcp: fastopen: keep listeners and connections
      mptcp: don't inherit fastopening from a listener
      mptcp: pm: kernel: count endpoint listeners as sockets in use
      mptcp: count a listener once when listen() is called again
      mptcp: send the infinite map in a single segment
      mptcp: keep room for infinite map after fallback
      mptcp: don't resend data acked without MPTCP opts
      selftests: mptcp: join: check re-adding signal+subflow ID 0 endp
      mptcp: don't charge a subflow twice when it joins during accept()
      mptcp: keep the first byte after a simult connect
      mptcp: move to ESTABLISHED after a simult connect
      mptcp: fix MSG_PEEK after a partly peeked skb
      mptcp: send the DATA_ACK after moving the backlog
      selftests: mptcp: join: infinite map: no spurious rtx
      selftests: mptcp: connect: trunc: wait for acks
      mptcp: order write_seq and DATA_FIN flag
      mptcp: order write_seq and DATA_FIN flag for fallback
      Squash to "bpf: Add mptcp packet scheduler struct_ops"
      Squash to "bpf: Export mptcp packet scheduler helpers"
      [mptcp-next] mptcp: push pending data after a fallback on reception
      [mptcp-next] mptcp: report errors as TCP does when closing
      [mptcp-next] mptcp: trace: name all the mapping statuses
      [RFC mptcp-next] mptcp: reset when the DSS disappears after a DATA_ACK

 include/trace/events/mptcp.h                      |   5 +-
 net/mptcp/mib.h                                   |   2 +-
 net/mptcp/options.c                               |  41 +-
 net/mptcp/pm_kernel.c                             |  15 +-
 net/mptcp/protocol.c                              | 456 ++++++++++++++++++----
 net/mptcp/protocol.h                              |  30 +-
 net/mptcp/sched.c                                 |   5 +
 net/mptcp/subflow.c                               |  90 ++++-
 tools/testing/selftests/net/mptcp/mptcp_connect.c |  24 +-
 tools/testing/selftests/net/mptcp/mptcp_join.sh   |  19 +-
 10 files changed, 577 insertions(+), 110 deletions(-)
---
base-commit: e1364181a6bba3b954d621abfd5f2e866128e32e
base-tree: https://github.com/multipath-tcp/mptcp_net-next.git t/upstream
change-id: 20261110-mptcp-cmason-fixes-eec0054c880a

Best regards,
--  
Matthieu Baerts (NGI0) <matttbe@kernel.org>

