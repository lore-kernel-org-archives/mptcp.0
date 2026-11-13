Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794599662;
	b=hUozLjFXmlp8//prbxrS3M2DWJ92CmQLuOZIYT/WgvDspBlA1M2fSiS6vxOTaSkI1Xv9
	 H2F9rRMCoF7N4wkD9PlZF5VzAzyFRaa8AMOQATpScw07On4P2iisbAaze6o6dYm58d0qF
	 iP99pzG7ol7FiJIR7AjTo3X8H1GyYnf8m8TVwee+KaVqobm4nNtz7QA7dD8wjTC6zJznz
	 EPReD/05hehXh+iCh+LafshS9datai7OXLTSu/ZjmzdzwmTgQMtXxOgCUz3tmeeDxL1Us
	 6kGH2VMvNKWzgbL0m0Z0b2XMxUgT5VZfbXhJMpCS2E9t0RRQOdaweSfwYYo80XO0LiA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794599662;
	h=Received:DKIM-Signature:From:Subject:Date:Message-Id:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:X-B4-Tracking:X-Change-ID:To:
	 Cc:X-Mailer:X-Developer-Signature:X-Developer-Key;
	bh=drUh5Ee5kguQt8Pkev3+FuoKbVbuNmmJcvCeXgBei+g=;
	b=VpVd2o6zgh71ambOZ/doyhGSjkBHIIm9PgzMf8EzqpDYF/CHTyeEwD/4FvuRa877c0zl
	 hS9H7DpRq4KU38w8psMRSFQMcHUnZUP0+nUz8eX3meOAj84wq3bx9JTf2taPd+DfmtwQt
	 eZAJslBH+yot4TsD1I0CCOoSFdCLRZdJRKuTe0lUGh3Uxo9O/uxiRXAzYRugxfshrQh8C
	 y5kxbFbNY40zWDoAdnosbL0xSeeRU6OhlGk99tq5vSWwkQWBcGpI1XCRhGLHj6WymhITz
	 zT8MMfKWZggRdpUMS+M3e5Sz/voYsMTvHZLt12bpLQUBvgGMshQUkDxed82uxsepsmA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=MoKF61Hz;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D27FD60A6F56
	for <mptcp@lists.linux.dev>; Fri, 13 Nov 2026 19:54:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=MoKF61Hz
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 587F11F000C4;
	Fri, 13 Nov 2026 19:54:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794599662;
	bh=drUh5Ee5kguQt8Pkev3+FuoKbVbuNmmJcvCeXgBei+g=;
	h=From:Subject:Date:To:Cc;
	b=MoKF61HzXTlETSqDnv+j+JATTwxGRrUzGk3gQXEeXVQGDp/xRvq06e03XCFh91Sdh
	 B77st2qPDUADYwufv+kur3H17SGzXRcgC7WK57E6EcTKMKJ/BRIz6tImn4SecIxgdD
	 DCaqitBT6aERRVboZlVZTBWpeTW0cTTMfTiMSlczdLd6F8C76FPAoI1clRvbH3liCc
	 Ypcuwh/1sPpiyN+1Vj+q98xxoVTyAt27diKx6Ct5JTtBdy/bWpbcfdFHtulzka2rwP
	 NhyBcbie5jKdV+X5o5fFLhIUUEqneRb4IbQYXOxn51mAyBw0T0/x6L9/rcO8KDXF0z
	 lT1gxSZE9Oq/A==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Subject: [PATCH mptcp-net 00/34] mptcp: misc fixes
Date: Fri, 13 Nov 2026 20:53:38 +0100
Message-Id: <20261113-mptcp-cmason-fixes-v1-0-9205b77e9a2f@kernel.org>
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
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/yWM0QrCMBAEf6XcsweXolL8FfEhnque0DTkUhFK/
 91oH4fZ2YUcxeB06hYqeJvblBqEXUf6jOkBtltj6qU/hhCEx1w1s47Rp8R3+8AZUJHDXodBIrU
 wF/xF68607RMqXTbl8/UFrb9TWtcvSHvLm4EAAAA=
X-Change-ID: 20261110-mptcp-cmason-fixes-eec0054c880a
To: MPTCP Linux <mptcp@lists.linux.dev>
Cc: Chris Mason <mason@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 "Matthieu Baerts (NGI0)" <matttbe@kernel.org>, 
 Josef Bacik <josef@toxicpanda.com>, Petar Sakic <petar.sakic@ink.fish>, 
 T S Rameshkumar <rameshkumar.t@phytecembedded.in>, 
 Geliang Tang <geliang@kernel.org>
X-Mailer: b4 0.17-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=6048; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=owOAciXYuzIPBL4BL+LanfKw2OuKDKLRiciueatEapc=;
 b=owGbwMvMwCVWo/Th0Gd3rumMp9WSGLK+Z12c/9525s4q1ZXlD3hzmo5yvax47tHho5Sq9Idt8
 mQ3Z3arjlIWBjEuBlkxRRbptsj8mc+reEu8/Cxg5rAygQxh4OIUgIkI7GH47z9zT7r21OTJi78f
 3sjvmbh+cZr++uYutaz3CWelI89JnGf473Ytj0FE8MsFK73myY/ry+68Wv7qZl3gsaWyr4t3CSq
 kMwIA
X-Developer-Key: i=matttbe@kernel.org; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

Here are various fixes, mostly from Chris Mason and Josef Bacik:

- Patches 1-2: drain the queues of a TCP or MPTCP socket when listen()
  fails, not to leak sockets and their netns. Fixes for v3.7 and v5.11.

- Patch 3: clear inet_opt in the child of an IPv6 listener, to avoid a
  double free with SELinux and NetLabel. A fix for v5.6.

- Patches 4-6: do not lose an RM_ADDR, when received in a row, or sent
  with a pending ADD_ADDR echo. Fixes for v5.13, v5.10 and v5.15.

- Patches 7-8: do not leave data unsent after a memory shortage. Fixes
  for another fix introduced in v6.19 and targeting v5.15, and for
  v5.11.

- Patches 9-10: do not leak an orphan moved to the CLOSE state outside
  the worker. Fixes for v6.15, and for another fix introduced in v6.6
  and targeting v5.11.

- Patch 11: do not send data beyond the window announced by the peer. A
  fix for v5.11.

- Patch 12: drop the ACKs with a SYN cookie and no MP_JOIN on PM
  listeners, which could stop accepting new subflows. A fix for v5.12.

- Patches 13-14: do not let PM listeners pin their netns, leaked
  otherwise. A fix for v5.12.

- Patch 15: close a subflow reset because of a bad mapping, not to keep
  the MPTCP socket established without subflows. A fix for v5.12.

- Patch 16: initialize drop_req, not to leak sockets with SO_REUSEPORT
  migration. A fix for v5.14.

- Patches 17-18: count MPTCP listeners correctly in /proc/net/protocols,
  and send their creation event once. Fixes for another fix introduced
  in v6.4 and targeting v5.17, and for v6.2.

- Patches 19-20: avoid data delivered twice around a fallback to TCP,
  with old data in flight, or resent to a peer that fell back. Fixes for
  v5.19, and for another fix introduced in v6.12 and targeting v5.13.

- Patches 21-22: do not count a signal+subflow ID 0 endpoint as used at
  each re-creation, and validate it. A fix for other fixes introduced in
  v6.11 and v7.0, and targeting v6.0 and v6.11.

- Patches 23-26: with TFO, send the data written by a server before the
  third ACK as soon as this ACK arrives, also in case of fallback to
  TCP, even if the connection was shut down. Fixes for v6.2 and v5.19.

- Patch 27: do not pass a BPF request sock to an MPTCP listener, to
  avoid a slab-out-of-bounds write. A fix for v6.9.

- Patches 28-31: reclaim the forward memory after coalescing skbs, and
  do not overcharge the memcg at accept(). Fixes for v6.19.

- Patches 32-33: after a fallback, fix the dummy mapping of overlapping
  segments, and continue the last mapping. Fixes for v6.19.

- Patch 34: RFC for mptcp-next: reset the subflow when the DSS
  disappears after a DATA_ACK, instead of a fallback to TCP, as
  suggested by RFC 8684.

Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
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

Geliang Tang (1):
      mptcp: fix dummy mapping of overlapping segments

Josef Bacik (5):
      mptcp: pm: work on a copy of the received RM_ADDR list
      mptcp: pm: don't drop an RM_ADDR behind a pending one
      mptcp: pm: don't drop an RM_ADDR because of an ADD_ADDR
      mptcp: pm: don't let listeners pin their netns
      mptcp: pm: kernel: don't count signal+subflow ID 0 endp

Matthieu Baerts (NGI0) (12):
      mptcp: don't leak an orphan when the PM closes its last subflow
      mptcp: do not use a raised snd_wnd for the send window
      net: add __sk_net_refcnt_upgrade() with a GFP mask
      mptcp: pm: kernel: count endpoint listeners as sockets in use
      mptcp: count a listener once when listen() is called again
      selftests: mptcp: join: check re-adding signal+subflow ID 0 endp
      mptcp: use sk instead of casting msk in check_fully_established()
      mptcp: push queued data on passive TFO subflows becoming established
      mptcp: push queued data on passive TFO subflows falling back to TCP
      mptcp: don't send a FIN before the pending data on fallback
      mptcp: don't charge a subflow twice when it joins during accept()
      [RFC mptcp-next] mptcp: reset when the DSS disappears after a DATA_ACK

 include/net/sock.h                              |   1 +
 net/core/sock.c                                 |   9 +-
 net/ipv4/inet_connection_sock.c                 |   8 +-
 net/ipv4/syncookies.c                           |   3 +-
 net/mptcp/options.c                             |  39 +++++-
 net/mptcp/pm.c                                  |  24 +++-
 net/mptcp/pm_kernel.c                           |   7 +-
 net/mptcp/protocol.c                            | 175 ++++++++++++++++--------
 net/mptcp/protocol.h                            |  23 +++-
 net/mptcp/subflow.c                             |  81 +++++++++--
 tools/testing/selftests/net/mptcp/mptcp_join.sh |  10 +-
 11 files changed, 290 insertions(+), 90 deletions(-)
---
base-commit: 168bc9ace0731cc00cfabb8198231e577df8efaf
base-tree: https://github.com/multipath-tcp/mptcp_net-next.git t/upstream
change-id: 20261110-mptcp-cmason-fixes-eec0054c880a

Best regards,
--  
Matthieu Baerts (NGI0) <matttbe@kernel.org>

