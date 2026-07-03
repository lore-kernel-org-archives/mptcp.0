Received: from sender4-of-o54.zoho.com (sender4-of-o54.zoho.com [136.143.188.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 675FA307481
	for <mptcp@lists.linux.dev>; Fri,  3 Jul 2026 16:57:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783097850; cv=pass; b=SyxSIgUHPjLD/s+RnTSRBa4d1rJMUbiWZqpkeeK2xrrOVCG3UppOp/42rM4PKjwfIBINmyqF5fTBY8HNWXIGr73xHg4UM59ok1Lq9Cz8v5gicclue3HM9EvniB/2LgotpQA8vGWICeGPc1zGrUSTcqc1w9uwSFUZCUhic4jjvqg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783097850; c=relaxed/simple;
	bh=k97E3BJCL7bx29ez/mY8JjeTqa/Qnzk4h8X4P05aa6M=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=q2XlETYuEXMLr44twPQJfTthEIQ+0IfVXfFIcMBtfE4L8FfWEzcgYzMEH7bNwBfEROCj495Rp7gbcUOfiylrAKl7foh9ZOnZIFjOl2pLi/4zwO2FWLiXOcCw+pqc5dlxRCKrtzSVEjFauYZoDsRarygall/exzVHuiBvmegzDHo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mpiricsoftware.com; spf=pass smtp.mailfrom=mpiricsoftware.com; dkim=fail (0-bit key) header.d=mpiricsoftware.com header.i=shardul.b@mpiricsoftware.com header.b=bhRmjUOB reason="key not found in DNS"; arc=pass smtp.client-ip=136.143.188.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mpiricsoftware.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mpiricsoftware.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=mpiricsoftware.com header.i=shardul.b@mpiricsoftware.com header.b="bhRmjUOB"
ARC-Seal: i=1; a=rsa-sha256; t=1783097843; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=B4B9tX03UOEXMVtmIu6QdQqujygaYXVv8GCPamhfJ0waMPIvTjrAXnHsU4FB9ltSFZBKqHWEwZqf1mSyEdTTpDSTHi9AWyen4VqGIanS3CavN/HwcQIHDBHL8k9YE5q+Yqnk3P3QvdjyxtSycDcWSHexmViIdSj30Tm3MQtT5vY=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1783097843; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=D3BjUXQV3UCZIvigAanm52bNLFe2Zf73L4PNCsgFyq4=; 
	b=CoSvoQlb2MywMpl1GhO/5934YV+wU+PwXfGWGPTsq4HfGi8BlfcxnQEJdZ2pFY7gXVMupl5JYyh/JAydXosPeymXO0C6qWoZewpwq/gEcLL6rWWRTSocPTOAxD8xBSROj+e0Hfl7+NLQVwJ2aFIgtF/mKt2YCUl4CjtyHUvz+4Y=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=mpiricsoftware.com;
	spf=pass  smtp.mailfrom=shardul.b@mpiricsoftware.com;
	dmarc=pass header.from=<shardul.b@mpiricsoftware.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1783097843;
	s=mpiric; d=mpiricsoftware.com; i=shardul.b@mpiricsoftware.com;
	h=From:From:Subject:Subject:Date:Date:Message-Id:Message-Id:MIME-Version:Content-Type:Content-Transfer-Encoding:To:To:Cc:Cc:Reply-To;
	bh=D3BjUXQV3UCZIvigAanm52bNLFe2Zf73L4PNCsgFyq4=;
	b=bhRmjUOB+fJF0z1cQDfFBiUtigBy+cRLQYyQkyC2G8a3eESdrDOLDFxA7KLQoaPP
	muuH3wKMsrGXY0f3lRm8LmjuB8nU3rxxoTQrSWTwMWqGBSfGi0d6mjFdOaN6l55PyB0
	G5SkgjaH1SNGcGJ5lFAmJbzqQDw+JoNSEIdrJlh8=
Received: by mx.zohomail.com with SMTPS id 1783097842067135.09057339370872;
	Fri, 3 Jul 2026 09:57:22 -0700 (PDT)
From: Shardul Bankar <shardul.b@mpiricsoftware.com>
Subject: [PATCH mptcp-next v2 0/5] mptcp: bpf: fix scheduler kfunc socket
 type confusion
Date: Fri, 03 Jul 2026 22:27:08 +0530
Message-Id: <20260703-mptcp_bpf_kfunc_fixes-v2-0-87ae3c64dc7e@mpiricsoftware.com>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAOTpR2oC/4WOQQ6CMBREr2L+2ppSQgFX3sMQAp9fqYbStAUxh
 LsL9QAuJzNvZlbw5DR5uJ5WcDRrr0ezC3E+AfaNeRDT3a5BcCG5FCUbbEBbt1bVLzUZrJVeyLO
 8aSWnDkXJBeysdRSNHb1DRJihJUD18/zUPgnDUXyke+3D6D7xxJxE5s/enDDOCsQiz1QqVZbeB
 qudRj+q8G4cXXAcoNq27QtiPI6J4QAAAA==
X-Change-ID: 20260629-mptcp_bpf_kfunc_fixes-7ab60edc2902
To: mptcp@lists.linux.dev, Geliang Tang <geliang@kernel.org>
Cc: Matthieu Baerts <matttbe@kernel.org>, 
 Mat Martineau <martineau@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 kalpan.jani@mpiricsoftware.com, janak@mpiric.us, shardulsb08@gmail.com, 
 Shardul Bankar <shardul.b@mpiricsoftware.com>
X-Mailer: b4 0.15.2
X-ZohoMailClient: External

Two BPF MPTCP packet-scheduler kfuncs accept a generic "struct sock *"
but internally reinterpret it as a specific role (the MPTCP-level
socket, or a subflow's TCP socket). The verifier only enforces that the
argument is a trusted struct sock, so a scheduler struct_ops program can
pass the wrong kind of socket; the kfunc then upcasts and dereferences
it, causing wild pointer use. Both are reachable from a scheduler hook
with no privilege beyond loading the scheduler.

Patch 1 (squash-to "bpf: Export mptcp packet scheduler helpers"):
  mptcp_set_timeout() expects the msk. A subflow socket passed
  instead is cast via mptcp_sk() and walked as msk->conn_list, causing a
  GPF. Found by an MPTCP protocol-flow harness extending BRF
  (arXiv:2305.08782). Fixed by narrowing the kfunc arg to
  struct mptcp_sock *, so the verifier rejects a non-msk socket at load.

Patch 2 (squash-to "bpf: Export mptcp packet scheduler helpers"):
  mptcp_pm_subflow_chk_stale()'s ssk arg is a subflow TCP
  socket; a non-subflow socket passed in is reinterpreted via
  mptcp_subflow_ctx() and both read and written through. This kfunc
  legitimately takes a generic socket, so it is fixed with a runtime
  role check in a __bpf_kfunc wrapper, like bpf_mptcp_subflow_ctx().
  The wrapper also confirms ssk belongs to the passed msk; this is
  hardening for a currently-unreachable surface, kept correct if it
  widens.

Patch 3 (squash-to "selftests/bpf: Add bpf_burst scheduler & test"):
  update the in-tree burst scheduler selftest to the new wrapper kfunc
  names so it keeps building and loading. Split from patches 1 and 2 so
  each squash-to lands on the commit it fixes.

Patches 4 and 5 (DO-NOT-MERGE): negative selftests validating the
  verifier rejects the type confusion. Not intended for propagation to
  net-next; like the other DO-NOT-MERGE checks they can live in the
  MPTCP tree so the CI keeps exercising the kfunc type contract (per the
  v1 review).

Signed-off-by: Shardul Bankar <shardul.b@mpiricsoftware.com>
---
Changes in v2:
- Split the burst-scheduler selftest kfunc rename out of the two
  net/mptcp/bpf.c squash-tos into its own squash-to targeting
  "selftests/bpf: Add bpf_burst scheduler & test" (Geliang).
- Patch 2: the wrapper now also verifies the subflow belongs to the
  msk (subflow->conn == msk) and NULL-checks the context (the
  Sashiko/Geliang ownership point).
- Marked the two negative selftests DO-NOT-MERGE so they are not
  propagated to net-next (Geliang: the dedicated bad scheduler is not
  for integration).
- Link to v1: https://patch.msgid.link/20260629-mptcp_bpf_kfunc_fixes-v1-0-8cc875f36f53@mpiricsoftware.com

---
Shardul Bankar (5):
      Squash to "bpf: Export mptcp packet scheduler helpers"
      Squash to "bpf: Export mptcp packet scheduler helpers"
      Squash to "selftests/bpf: Add bpf_burst scheduler & test"
      DO-NOT-MERGE: selftests/bpf: mptcp: verify scheduler rejects non-msk socket to set_timeout
      DO-NOT-MERGE: selftests/bpf: mptcp: extend bad scheduler test to the kfunc type contract

 net/mptcp/bpf.c                                    |  21 ++++-
 tools/testing/selftests/bpf/prog_tests/mptcp.c     |  58 ++++++++++++
 .../selftests/bpf/progs/mptcp_bpf_bad_sched.c      | 104 +++++++++++++++++++++
 .../testing/selftests/bpf/progs/mptcp_bpf_burst.c  |   8 +-
 4 files changed, 185 insertions(+), 6 deletions(-)
---
base-commit: 0d7f76b2394b7a20a1ec100557cd7905ee0ab40e
change-id: 20260629-mptcp_bpf_kfunc_fixes-7ab60edc2902

Best regards,
--  
Shardul Bankar <shardul.b@mpiricsoftware.com>

