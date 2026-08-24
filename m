Received: from sender6-of-o54.zoho.com (sender6-of-o54.zoho.com [165.173.180.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC2E83EE1E4
	for <mptcp@lists.linux.dev>; Mon, 24 Aug 2026 10:27:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=165.173.180.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787567278; cv=pass; b=FRjYNKF3lfxP+CaEZmwWQ5SQ68KAEVJzLA659plzLRXj/mlaz8H51OwTXHXQoqLnZsS1MEZI7cNr2W1cCRBG7uMtGXZsX3TvKLR4mEsR06k0mSnWCU3hL2bfaJCmySwqAlsU3+/yvkvZ+2pHlPMHHj1XU/OkoBKuPrMAfp5dznI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787567278; c=relaxed/simple;
	bh=6+CysDWa7dzRo81iFPTBdg7IRo38CMo3KaH1ncfrTBI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Ex2KQ70FQXTyNcIN+ail4Sc0XrdDwEseUel1HPg46/36Uyg6ut62ng5O5gfBR9g6N3gB9ss79VbGqYjA4IJVHyE5p/j7v8/b0lmFliyTa30OEoDnNgAuaslc0W4BXisZhvNhjA2whdiOZ/Xbt1nEhMSDqIMciukLJNSo/q7mhME=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mpiricsoftware.com; spf=pass smtp.mailfrom=mpiricsoftware.com; dkim=fail (0-bit key) header.d=mpiricsoftware.com header.i=kalpan.jani@mpiricsoftware.com header.b=NeVeDHPu reason="key not found in DNS"; arc=pass smtp.client-ip=165.173.180.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mpiricsoftware.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mpiricsoftware.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=mpiricsoftware.com header.i=kalpan.jani@mpiricsoftware.com header.b="NeVeDHPu"
ARC-Seal: i=1; a=rsa-sha256; t=1787567271; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=ZpIKwwMCGtxT2/N2dqdbt0DizmYfRTrgDvDNAO5QcNizbe6ut+RMdZGY5nO2jY11tjZff2vhdt7lzflVyLjobl4/8RdEstsAQ6g2nL6w5Y7pLxSJ6BKe2QWl4N91YAzTU2vybtfonS446VkOOk/nfz+F2pqBXpaN0iyogGSSa5E=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1787567271; h=Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=7hEmoFyvrrb/cVCkpX+mLHeCwqxFMkPnNml1O1mbyTg=; 
	b=ng+wU6QpYJnIbegNBtIgZvG3j2D3eOVQEkW8KqR73YhOQo7HW57oq5EL/FQfPWHYjC+ndztm2piBP+KiYveAuqCDam2vomfAkBVOKntfxQcQZx4M6SDlo0Rjvv3wMy72737rvSFxNLWeKqO93d6IX+SopZyaKYM5oUK2P3bVBLU=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=mpiricsoftware.com;
	spf=pass  smtp.mailfrom=kalpan.jani@mpiricsoftware.com;
	dmarc=pass header.from=<kalpan.jani@mpiricsoftware.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1787567271;
	s=mpiric; d=mpiricsoftware.com; i=kalpan.jani@mpiricsoftware.com;
	h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-ID:MIME-Version:Content-Transfer-Encoding:Message-Id:Reply-To;
	bh=7hEmoFyvrrb/cVCkpX+mLHeCwqxFMkPnNml1O1mbyTg=;
	b=NeVeDHPuEPo8dMlY4rT6s6cgzUb6CTngDGrqGuueKVC1EzkUXalXE3pEVjxAKnhY
	YXYob+wEqEiC6yNjubCAIO6ZadpU/VZZe4o5dwBW+0JZtc4IbYngs+S6GolOTovl3BC
	8Cx43AX3dChUtvEbbIJ+TphoDzmW7hG+qWN/5ztA=
Received: by mx.zohomail.com with SMTPS id 1787567269628633.7935214925235;
	Mon, 24 Aug 2026 03:27:49 -0700 (PDT)
From: Kalpan Jani <kalpan.jani@mpiricsoftware.com>
To: mptcp@lists.linux.dev
Cc: matttbe@kernel.org,
	martineau@kernel.org,
	pabeni@redhat.com,
	shardul.b@mpiricsoftware.com,
	janak@mpiric.us,
	kalpanjani009@gmail.com
Subject: [PATCH mptcp-next v2 0/2] mptcp: sched: add subflow avoid flag
Date: Mon, 24 Aug 2026 15:57:39 +0530
Message-ID: <20260824102741.347492-1-kalpan.jani@mpiricsoftware.com>
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

Changes since v1:

- avoid now lives in the existing __unused:8 bitfield padding instead
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

base-commit: 490b4823cb98b233af2b7562bddc90ecb5dfbf4e

-- 
2.43.0

