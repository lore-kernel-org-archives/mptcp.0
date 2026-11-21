Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795254139;
	b=GjZ/dHsgwv/S6PNXc7gGtW+yR9NkxUs+vu71+WQ62plM9IOl68iJ9KACfiMmbhQ5/lk+
	 nwNMgFKe3+JFAgq0Ru7xs5VRcSrB35467zl+FPXheGbYSwuQoxu8emx1sqaeVw9YzM46Y
	 CAOkvph4RSrIwunVNCP9uyxMANirry7YnF4Gv7gEq4Xqa4wRKLYMAeWLAzzF0OWVJiwT5
	 Q0qnT7mgqrXniEvY5pSfgb3gPFkQ1NFZ1x9kk2oSiyVSoSjprgDMc/u1QoPRn693UbG1B
	 RPLKOy+BS4FiUlnxie9d2htrQpPdw/vBq7S+GyCShorw+IAlYOeVts8U7iqDjatq6+g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795254139;
	h=Received:DKIM-Signature:From:Subject:Date:Message-Id:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:X-B4-Tracking:X-Change-ID:To:
	 Cc:X-Mailer:X-Developer-Signature:X-Developer-Key;
	bh=u3XPDsKr1ak0Y8Ykl8VktMXTwBLhWHzdqBWZHt5DnlI=;
	b=RSvcOn/b9urFzRns8oUeK5Z85yTMu+gw6SwVnXHaIZW0Ma9cXJ+LBZa0uGcSXYfXFTEE
	 Lj9cMZWPFiX6NSqiz0RAKnCkTuQnpk92YRmeRmAvI1LLsuE2iTtzn7KTQurDx3IKW7aVM
	 OidxpmP8btHk5EaZLt0fgVZBufmlbm104B7AfMvsH8EoHj4k9sID/8kspBfbv8MGcwKY8
	 5WOtnx2msofwjENK4nE3Z6vNgs9EDtk8Hnxyyj6A/Md+rVQCMDccl/F5CHvP8cH2ne2Ok
	 QiRn5gu//Yj1ILOSA+doznCNXK70t7SUH3qNYzi8HVsyMtVe+hn0GzJm1OUy4aqhWLg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=XPdZnKoy;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9876E606A320
	for <mptcp@lists.linux.dev>; Sat, 21 Nov 2026 09:42:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=XPdZnKoy
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 354081F000CA;
	Sat, 21 Nov 2026 09:42:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795254139;
	bh=u3XPDsKr1ak0Y8Ykl8VktMXTwBLhWHzdqBWZHt5DnlI=;
	h=From:Subject:Date:To:Cc;
	b=XPdZnKoy01R61GxPOQSe1c/+kcbZgDDJA/K9X/4Qj5hESGiIVNQh8gPUgf34C27sy
	 Km2G5+7rNIcBarJtIkwdkdjp5x6se95Grq/S0S6LvGJfxVhGF/6HpXB650dwo0uNVw
	 ycfRjb48WUVfwNOv53akpHO5GgXDMAnN+qi5szp1fbTENaljGaLyDIF9GyxHFVPuKp
	 HIfWWLP7JcKHwhK4Nu09/0WUwFC1mn3HmCgiMRGvoGglMtSPYBbodzyggjWVCYsr9W
	 QvIhxbEQteJEDXPNo1B6f1/Boy3dmi3Ur4mpC73KOVCWTiiAT1ey9VF3U36qBNvg8U
	 ocFfVlHkounGA==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Subject: [PATCH mptcp-net v2 00/62] mptcp: misc fixes
Date: Sat, 21 Nov 2026 10:40:58 +0100
Message-Id: <20261121-mptcp-cmason-fixes-v2-0-00327fd1de1f@kernel.org>
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
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/22OQQ6CMBREr0L+2pq2ioAr72FYlPqBqrRNfyUaw
 t0t4NLlZObNzASEwSDBOZsg4GjIOJuE3GWge2U7ZOaWNEguT0IIzgYftWd6UOQsa80biSFqzvO
 jLkuuIIE+4Gok7gpb3mKEerPo1dxRx6V0CfeGoguf9cAoVuS3dfi3NQrGWSV53hQFVkq2lwcGi
 8+9Cx3U8zx/AWHcHzbSAAAA
X-Change-ID: 20261110-mptcp-cmason-fixes-eec0054c880a
To: MPTCP Linux <mptcp@lists.linux.dev>
Cc: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>, 
 Chris Mason <mason@kernel.org>, Josef Bacik <josef@toxicpanda.com>, 
 Kyuwon Cho <kyuwoncho18@gmail.com>
X-Mailer: b4 0.17-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=14163; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=mvGL4cjfx30/hhXMRLCN8yUo4yHUrpPc990GssOgMhA=;
 b=owGbwMvMwCVWo/Th0Gd3rumMp9WSGLIZ093T6u/O4U7z5VE0fCVUIyj/f/bWLRffFjyZ9bC80
 GXm6ftRHaUsDGJcDLJiiizSbZH5M59X8ZZ4+VnAzGFlAhnCwMUpABO50cTI0DpbrSJ5DYdC4/Ll
 xls/p+xekv2trqnCxVP0vaRk7Pob9Qz/vbNvT1/2JVGj96RQaItb0+LSHU/5v2X7/ti3bd/N+ww
 X2AE=
X-Developer-Key: i=matttbe@kernel.org; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

Here are various fixes, many from Chris Mason and Josef Bacik:

- Patches 1-2: drain the queues of a TCP or MPTCP socket when listen()
  fails, not to leak sockets and their netns. Fixes for v4.4 and v5.11.

- Patch 3: clear inet_opt in the child of an IPv6 listener, to avoid a
  double free with SELinux and NetLabel. A fix for v5.6.

- Patches 4-7: do not lose an RM_ADDR, when received in a row, sent with
  a pending ADD_ADDR echo, or when computing the MSS. Fixes for v5.13,
  v5.10, v5.15 and v5.10.

- Patches 8-9: do not leave data unsent after a memory shortage. Fixes
  for another fix introduced in v6.19 and targeting v5.15, and for
  v5.11.

- Patches 10-11: do not leak an orphan moved to the CLOSE state outside
  the worker. Fixes for v6.15, and for another fix introduced in v6.6
  and targeting v5.11.

- Patches 12-17: do not reset an orphan while it can still send its
  data, also after a fallback, but limit it with a closed window, and
  count it as TCP does, so that tcp_max_orphans limits it too. Also
  return EOF after a DATA_FIN followed by a reset, and send a reset
  when aborting after a fallback, as TCP does. Fixes for v5.11, v5.12,
  v6.1, and for another fix introduced in v6.18 and targeting v6.1.

- Patches 18-20: wake up the senders blocked when the connection is
  closed without subflows, after a subflow error, or when the initial
  subflow is only shut down. Fixes for another fix introduced in v6.6
  and targeting v5.11, and for v5.12.

- Patches 21-24: process a DATA_FIN received with old data, and a
  pending MP_FASTCLOSE or DATA_FIN before closing without subflows, also
  at accept() time, instead of ignoring them: the reader could miss the
  end of file or the reset. Fixes for v5.9, v6.6, v6.19 and v6.3.

- Patch 25: clear the socket error on connect(), as TCP does. A fix for
  v5.17.

- Patches 26-27: with TCP_FASTOPEN_CONNECT, clear DEFER_CONNECT on
  disconnect, and report the error of a first subflow aborted before the
  first write(), instead of EINVAL or EISCONN. Fixes for v6.1, and for
  another fix introduced in v7.4-rc3 and targeting v4.11.

- Patch 28: do not send a fastclose reset from a subflow in SYN_SENT, as
  TCP does. A fix for another fix introduced in v6.18 and targeting
  v6.1.

- Patches 29-30: keep listening after a failed sendmsg() with
  MSG_FASTOPEN, as TCP does, and do not let the new sockets created
  meanwhile inherit a flag preventing their disconnection. Fixes for
  another fix introduced in v6.2 and targeting v6.1.

- Patch 31: drop the ACKs with a SYN cookie and no MP_JOIN on PM
  listeners, which could stop accepting new subflows. A fix for v5.12.

- Patches 32-33: do not let PM listeners pin their netns, leaked
  otherwise. A fix for v5.12.

- Patch 34: close a subflow reset because of a bad mapping, not to keep
  the MPTCP socket established without subflows. A fix for v5.12.

- Patch 35: initialize drop_req, not to leak sockets with SO_REUSEPORT
  migration. A fix for v5.14.

- Patches 36-37: count MPTCP listeners correctly in /proc/net/protocols,
  and send their creation event once. Fixes for another fix introduced
  in v6.4 and targeting v5.17, and for v6.2.

- Patches 38-39: send the infinite mapping in a single segment, with
  room for its DSS option, also after a fallback on reception: its
  segments could be bigger than the MTU, and then dropped. Fixes for
  v5.19.

- Patches 40-42: avoid data delivered twice around a fallback to TCP,
  with old data in flight, or resent to a peer that fell back. Fixes for
  v5.19, and for another fix introduced in v6.12 and targeting v5.13.

- Patches 43-44: do not count a signal+subflow ID 0 endpoint as used at
  each re-creation, and validate it. A fix for another fix introduced in
  v6.11 and targeting v6.0.

- Patch 45: do not pass a BPF request sock to an MPTCP listener, to
  avoid a slab-out-of-bounds write. A fix for v6.9.

- Patches 46-49: reclaim the forward memory after coalescing skbs, and
  do not overcharge the memcg at accept(). Fixes for v6.19.

- Patch 50: after a fallback, continue the last mapping. A fix for
  v6.19.

- Patches 51-52: after a simultaneous connect, do not drop the first
  received byte, and move to ESTABLISHED without waiting for the next
  packet. Fixes for v6.19, and for another fix introduced in v6.19 and
  targeting v6.2.

- Patch 53: with MSG_PEEK, do not skip data after a partly peeked skb:
  the peeked data was corrupted. A fix for v6.18.

- Patch 54: send the DATA_ACK of the data moved from the backlog, to
  avoid spurious MPTCP retransmissions, preventing a fallback after an
  MP_FAIL. A fix for v6.15.

- Patches 55-56: in the selftests, avoid spurious MPTCP retransmissions
  preventing the infinite fallback in the 'Infinite map' subtest, and
  wait for the data to be acked before a fastclose. Fixes for v5.19,
  only effective from v7.3, and for v6.1.

- Patch 57: order the write_seq and DATA_FIN flag updates, not to send a
  FIN before the last byte of data after a fallback, on weakly ordered
  CPUs. A fix for another fix, now in net, and targeting v5.19.

- Patches 58-59: Squash-to patches for the BPF packet schedulers, in the
  MPTCP tree only: stop pushing when they pick no subflow, instead of
  spinning in softirq, and set the rtx timer interval before calling
  them, not to fire the timer every jiffy.

- Patch 60: for mptcp-next: push the pending data, and the FIN, right
  after a fallback on reception, not at the next retransmission timeout.
  A non-urgent fix for v6.12.

- Patch 61: for mptcp-next: report the errors as TCP does when closing:
  ETIMEDOUT after the close timeout or the last subflow's RTO, and the
  reset errors when the last subflow is reset.

- Patch 62: RFC for mptcp-next: reset the subflow when the DSS
  disappears after a DATA_ACK, instead of a fallback to TCP, as
  suggested by RFC 8684.

The Packetdrill tests mptcp/regressions/close_mpj_timeout* will fail
because of patch 61: the Packetdrill patches adapting them will be
shared later.

Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
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
Chris Mason (16):
      tcp: drain the queues of a listen() that fails
      mptcp: drain the queues of a listen() that fails
      mptcp: clear inet_opt in the child of an IPv6 listener
      mptcp: arm the rtx timer if a push leaves data behind
      mptcp: force the charge for the first skb of a subflow
      mptcp: leave an orphan's DATA_FIN to the worker
      mptcp: drop non-MP_JOIN cookie ACKs on PM listeners
      mptcp: close a subflow reset for a bad mapping
      mptcp: initialize drop_req in subflow_init_req()
      mptcp: do not fallback while old data is in flight
      mptcp: stop resending data to a peer that fell back
      tcp: do not pass a BPF reqsk to an MPTCP listener
      mptcp: reclaim forward memory after coalescing skbs
      mptcp: don't charge a shared page twice at accept()
      mptcp: don't charge the backlog twice at accept()
      mptcp: continue the last mapping after a fallback

Josef Bacik (5):
      mptcp: pm: work on a copy of the received RM_ADDR list
      mptcp: pm: don't drop an RM_ADDR behind a pending one
      mptcp: pm: don't drop an RM_ADDR because of an ADD_ADDR
      mptcp: pm: don't let listeners pin their netns
      mptcp: pm: kernel: don't count signal+subflow ID 0 endp

Matthieu Baerts (NGI0) (41):
      mptcp: pm: keep an RM_ADDR when computing the MSS
      mptcp: don't leak an orphan when the PM closes its last subflow
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
      mptcp: clear sk_err on connect(), as TCP does
      mptcp: clear DEFER_CONNECT on disconnect
      mptcp: report sf aborts during deferred connect
      mptcp: no fastclose reset from SYN_SENT subflows
      mptcp: keep listening after MSG_FASTOPEN errors
      mptcp: don't inherit fastopening from a listener
      net: add __sk_net_refcnt_upgrade() with a GFP mask
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
      mptcp: order write_seq and DATA_FIN flag for fallback
      Squash to "bpf: Add mptcp packet scheduler struct_ops"
      Squash to "bpf: Export mptcp packet scheduler helpers"
      [mptcp-next] mptcp: push pending data after a fallback on reception
      [mptcp-next] mptcp: report errors as TCP does when closing
      [RFC mptcp-next] mptcp: reset when the DSS disappears after a DATA_ACK

 include/net/sock.h                                |   1 +
 net/core/sock.c                                   |   9 +-
 net/ipv4/inet_connection_sock.c                   |  12 +-
 net/ipv4/syncookies.c                             |   3 +-
 net/mptcp/mib.h                                   |   2 +-
 net/mptcp/options.c                               |  53 ++-
 net/mptcp/pm.c                                    |  50 ++-
 net/mptcp/pm_kernel.c                             |  15 +-
 net/mptcp/protocol.c                              | 476 ++++++++++++++++++----
 net/mptcp/protocol.h                              |  30 +-
 net/mptcp/sched.c                                 |   3 +
 net/mptcp/subflow.c                               | 115 +++++-
 tools/testing/selftests/net/mptcp/mptcp_connect.c |  24 +-
 tools/testing/selftests/net/mptcp/mptcp_join.sh   |  19 +-
 14 files changed, 671 insertions(+), 141 deletions(-)
---
base-commit: b9620afcd7c2a78410eb68fa5fe70b9da8ce088e
base-tree: https://github.com/multipath-tcp/mptcp_net-next.git t/upstream
change-id: 20261110-mptcp-cmason-fixes-eec0054c880a

Best regards,
--  
Matthieu Baerts (NGI0) <matttbe@kernel.org>

