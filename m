Received: from sender4-of-o54.zoho.com (sender4-of-o54.zoho.com [136.143.188.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6A9B3E0C44
	for <mptcp@lists.linux.dev>; Mon, 31 Aug 2026 09:47:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788169632; cv=pass; b=TpOn5C08QhGXxc+DXv5lh0evBlIQW+QGVKn9IIeuqWh5VeL6UBX1FIKE4G3aEYOk6EgcxjT9DlE2usopPV2tXqZ74AdF0r3GOXYTu2mpm9wD3+SjTj3Ld4Ivtfz5QMHVkl8knWr0WQaHJX8VfiLce3sJ1a63JY5gKqPLHldYf0Y=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788169632; c=relaxed/simple;
	bh=/KREpmDjQPtoo8JqjhwlHIIh72i64c+r3knhD+okFJo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=SSg1/A2oUK4bE4aUnzKlzquNq7m94gUoR6Y5qTuPb4D40L8Fkvv78cUqDEFlOSP8zvsPOCFG7XT30Z4hQI29nBocW4UpBK20TKlvzfwGxf+CQvcfp/QhGtOJ3pvaSrCBK4ZNrb5//vL7C7soLBXRL4lsLT625xP6Te7Sc/B6XAY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mpiricsoftware.com; spf=pass smtp.mailfrom=mpiricsoftware.com; dkim=fail (0-bit key) header.d=mpiricsoftware.com header.i=kalpan.jani@mpiricsoftware.com header.b=hr3805IH reason="key not found in DNS"; arc=pass smtp.client-ip=136.143.188.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mpiricsoftware.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mpiricsoftware.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=mpiricsoftware.com header.i=kalpan.jani@mpiricsoftware.com header.b="hr3805IH"
ARC-Seal: i=1; a=rsa-sha256; t=1788169621; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=ZRp+vPXgZUBd/Y2b9Y7J1r4NUEscwn3bY6I0Ke7lKjbj3I2qAwxvCFYvn31jJvEpIss76Mi7JzsANr/MS1/GkDCXU9bqg5jCi8x6FidxwqlXkBH+6F09nGL+0Z0LmVDERW3FKACOryhJZLcYQ+awPjQGCnRGeUV1cS+P4RaK7XA=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1788169621; h=Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=qvu8VFY1brCKJUrJXx40O8s5PijLTT2UBko/0fFG24A=; 
	b=cieihXT0xJCsGY77qMvHIyGN+9QXa77ovlTnN47tVO2U+w6ow3kE5LXKKB+8ts/RbXwvqZzEjLcaiXwfcB4vfPS+YeLwk6dcHHy76AtqPB/GlMQgraZY8s2seGdqKCaG/IEFEsu9xG6YNgSvwwoL1QjhAck3o7BEip89EPtnVh4=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=mpiricsoftware.com;
	spf=pass  smtp.mailfrom=kalpan.jani@mpiricsoftware.com;
	dmarc=pass header.from=<kalpan.jani@mpiricsoftware.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1788169621;
	s=mpiric; d=mpiricsoftware.com; i=kalpan.jani@mpiricsoftware.com;
	h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-ID:MIME-Version:Content-Transfer-Encoding:Message-Id:Reply-To;
	bh=qvu8VFY1brCKJUrJXx40O8s5PijLTT2UBko/0fFG24A=;
	b=hr3805IHVnHljtjLPqlWmDKq7SyCX0BY9Cs4D5fQ+wLwy9H7LkKpb8IX3+4TQ1ku
	K7JYgm625Jwz95atVs5pTU2BUI+rPO42nJy0H4efctNpuHl3voqr0e22rDOyocGm78r
	It4m7xWukwWaTG87xUixFTiuz6k6tFymzFWUF+xc=
Received: by mx.zohomail.com with SMTPS id 1788169619713283.4551359976592;
	Mon, 31 Aug 2026 02:46:59 -0700 (PDT)
From: Kalpan Jani <kalpan.jani@mpiricsoftware.com>
To: mptcp@lists.linux.dev
Cc: matttbe@kernel.org,
	martineau@kernel.org,
	pabeni@redhat.com,
	shardul.b@mpiricsoftware.com,
	janak@mpiric.us,
	kalpanjani009@gmail.com
Subject: [PATCH mptcp-next v3 0/2] mptcp: sched: add subflow avoid flag
Date: Mon, 31 Aug 2026 15:16:49 +0530
Message-ID: <20260831094651.2682660-1-kalpan.jani@mpiricsoftware.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-ZohoMailClient: External

The core benches a subflow via the "stale" bit after
net.mptcp.stale_loss_cnt retransmission intervals without progress.
That bit is core-owned and RTO-coupled -- cleared as soon as a packet
is acked on the subflow. A scheduler has no way to bench a subflow for
its own reasons (high latency, instability) independently of ack
traffic.

"scheduled" doesn't help either: the core clears it after every
send/retrans pass, so it can't hold a standing "leave this alone"
decision, and nothing outside the scheduler that set it can see it.

Changes since v2:

v2 was generated against a stale local snapshot that predated several
unrelated upstream commits touching the same bitfield region in
mptcp_subflow_context; applying v2 against the real export tree
produced a merge conflict in protocol.h. This series is a straight
rebase onto the current export tree -- no functional change from v2.
Only two things differ as a result of the rebase itself:

- avoid now leaves __unused:8 instead of __unused:7, since the real
  tree has 9 unused bits available at this point rather than 8.
- line offsets throughout protocol.c/protocol.h shifted to match
  current export.

Changes since v1:

- avoid now lives in the existing __unused bitfield padding instead
  of its own bool. No struct growth (Paolo).
- the selftest scheduler sets avoid once, on the first get_send()
  call, and only reads it back afterward -- proving persistence
  scheduled can't do, instead of just claiming it. A get_send_calls
  counter, asserted >1, makes sure multiple rounds actually ran
  (Paolo).
- mptcp_subflow_get_send() and mptcp_subflow_get_retrans() -- the
  default subflow picker, active with or without a custom scheduler
  -- now skip an avoided subflow next to the existing active-subflow
  check. avoid is also exposed via MPTCP diag (Paolo).
- set_avoid() marked __bpf_kfunc: it has no C callers, unlike
  set_scheduled(), and could be dropped under LTO before
  resolve_btfids finds it in BTF (review bot).
- added the missing extern __ksym for mptcp_subflow_active() in the
  selftest, matching mptcp_bpf_burst.c (review bot).
- moved the set_avoid extern out of mptcp_bpf.h into
  mptcp_bpf_avoid.c: checkpatch flags new externs in shared headers,
  and it has only the one caller.

Probing an avoided subflow to decide when to clear it (issue #348) is
left out on purpose -- that's scheduler policy, not core mechanism.

Patch 1 adds the flag, the kfunc, default-scheduler enforcement, and
diag support. Patch 2 reworks the selftest to prove persistence and
picks up the missing extern.

Ran the full suite through mptcp-upstream-virtme-docker (auto-normal
and auto-btf) -- selftests, packetdrill, and BPF tests pass, avoid
subtest included.

Link: https://github.com/multipath-tcp/mptcp_net-next/issues/349

Kalpan Jani (2):
  mptcp: sched: add subflow avoid flag and enforce it in core
  selftests: mptcp: bpf: exercise the subflow avoid flag across rounds

 include/uapi/linux/mptcp.h                    |  1 +
 net/mptcp/bpf.c                               |  1 +
 net/mptcp/diag.c                              |  2 +
 net/mptcp/protocol.c                          |  4 +-
 net/mptcp/protocol.h                          |  5 +-
 net/mptcp/sched.c                             |  6 ++
 .../testing/selftests/bpf/prog_tests/mptcp.c  | 16 +++++
 .../selftests/bpf/progs/mptcp_bpf_avoid.c     | 70 +++++++++++++++++++
 8 files changed, 102 insertions(+), 3 deletions(-)
 create mode 100644 tools/testing/selftests/bpf/progs/mptcp_bpf_avoid.c

base-commit: 21f4dd6665f74afe8fe39591e4abd5971828cf08
-- 
2.43.0
