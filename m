Received: from sender4-of-o54.zoho.com (sender4-of-o54.zoho.com [136.143.188.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72CDC40314D
	for <mptcp@lists.linux.dev>; Mon, 29 Jun 2026 12:08:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782734895; cv=pass; b=CHAo2/bIRpHvtW2WDnkx5FjpK6pNsBlhSbeK641Nlr0RResFSWhLMiAaHEQnmuWzjSqTLRoQUBW27HeMZssQU2FLabOVsp4d1tbk9tz/Pan44tG6CQviD+sdAEJ+CpCqc+dOp6T9gaY+ncjeJO6w3+I9K+Q4S9/Pa9mxJ/ZTrmM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782734895; c=relaxed/simple;
	bh=LtY03LacRsqZCFGAiFuewJPFQFiJsw5HM5xWYlWq+xc=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=DKlyn7vY7ZeSuodxZymM+O7/SewVRICocFFh87CbyfgvLDIfBRuN5oj2KyWBPDe4dLQV7EpI0TN+FypAE7TIDI6tdsllVjRYfwZzV8t887iUOVUdQ0Sp1ym+KXlPnRsMQMdnt/B3YY2D0csPY0VqicWQ1+98z8gs2QO2pzPs0Ug=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mpiricsoftware.com; spf=pass smtp.mailfrom=mpiricsoftware.com; dkim=fail (0-bit key) header.d=mpiricsoftware.com header.i=shardul.b@mpiricsoftware.com header.b=ruAvschc reason="key not found in DNS"; arc=pass smtp.client-ip=136.143.188.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mpiricsoftware.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mpiricsoftware.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=mpiricsoftware.com header.i=shardul.b@mpiricsoftware.com header.b="ruAvschc"
ARC-Seal: i=1; a=rsa-sha256; t=1782734888; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=KBQEx+fGORKCd/vEUgk1fx5f7F81EmWvYaOSP2qiLtLkiQWbTSN4NmV28z3FMUWZlfCSsyBFLfblf5E2dYC4tmt2QaGifyXpqHLU283UIk1jCmkPaI63OpZCxAX0VAmUT3dKfag1s67w/nonqaMfc0D6WKHNC/zkquZEwmoAvYI=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1782734888; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=PlCiubdth8LinbxhM1RdFTl0xkm/ucZXgSPXfr7RYrk=; 
	b=f/jRVnJcvLCJvJYyfW7FfiXZNvAb69TMKZM3C8UNDROUkYUfhqd2C/r9Kdw/xyiv4bCs1JD1DuHhJh7g2ynaaVVTbDJQWTH1kJjnFAf6JbeqP34IjtUE2kAgwWRTT3UntK5DO5g8Uos4lFbMHTVprGaZhBfFQmtGfWwX5T/EhTU=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=mpiricsoftware.com;
	spf=pass  smtp.mailfrom=shardul.b@mpiricsoftware.com;
	dmarc=pass header.from=<shardul.b@mpiricsoftware.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1782734888;
	s=mpiric; d=mpiricsoftware.com; i=shardul.b@mpiricsoftware.com;
	h=From:From:Subject:Subject:Date:Date:Message-Id:Message-Id:MIME-Version:Content-Type:Content-Transfer-Encoding:To:To:Cc:Cc:Reply-To;
	bh=PlCiubdth8LinbxhM1RdFTl0xkm/ucZXgSPXfr7RYrk=;
	b=ruAvschcVG3L/bkm6FbB7prEvmLgEZwpheCNNye9Io8YuzzSwDyAtcflJjz0hsnw
	OvLYW4+yhCU4aCCX5jI/ibAtU4DnDT0i4S2GCO0NmnLXzGEs1vHp+oCf9apo/u7E6aB
	p2Yhx55HkPMbuUqRKycUUv9soOSPkr9cPJRaUkRM=
Received: by mx.zohomail.com with SMTPS id 1782734886466268.9234734190816;
	Mon, 29 Jun 2026 05:08:06 -0700 (PDT)
From: Shardul Bankar <shardul.b@mpiricsoftware.com>
Subject: [PATCH mptcp-next 0/4] mptcp: bpf: fix scheduler kfunc socket type
 confusion
Date: Mon, 29 Jun 2026 17:37:33 +0530
Message-Id: <20260629-mptcp_bpf_kfunc_fixes-v1-0-8cc875f36f53@mpiricsoftware.com>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAVgQmoC/yWMQQrCMBAAv1L2bCDuIVK/IhKa7aauYgzZVAqlf
 ze2x2GYWUG5CCtcuxUKf0XlkxqcTx3QY0gTGxkbA1p01mFv3rlS9iFH/4pzIh9lYTWXITjLI2F
 vEVqbC++ipTfYE5N4qXA/nM7hyVT/Y9i2HzGZoiCFAAAA
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

Patch 1: mptcp_set_timeout() expects the msk. A subflow socket passed
  instead is cast via mptcp_sk() and walked as msk->conn_list, causing a
  GPF. Found by an MPTCP protocol-flow harness extending BRF
  (arXiv:2305.08782). Fixed by narrowing the kfunc arg to
  struct mptcp_sock *, so the verifier rejects a non-msk socket at load.

Patch 2: mptcp_pm_subflow_chk_stale()'s ssk arg is a subflow TCP
  socket; a non-subflow socket passed in is reinterpreted via
  mptcp_subflow_ctx() and both read and written through. This kfunc
  legitimately takes a generic socket, so it is fixed with a runtime
  role check in a __bpf_kfunc wrapper, like bpf_mptcp_subflow_ctx().

Patch 3: adds a negative selftest: a scheduler that passes a subflow
  socket to the narrowed bpf_mptcp_set_timeout() must be rejected by the
  verifier; the test asserts the specific load-time type-mismatch
  message.

Patch 4: extends that selftest into a small suite guarding both socket
  type-confusion directions across the narrow-typed scheduler kfunc
  surface (mptcp_wnd_end and mptcp_subflow_set_scheduled), so the
  contract cannot silently regress.

Patches 1 and 2 are squash-to "bpf: Export mptcp packet scheduler
helpers" and update the in-tree burst scheduler selftest to the new
kfunc names.

Signed-off-by: Shardul Bankar <shardul.b@mpiricsoftware.com>
---
Shardul Bankar (4):
      Squash to "bpf: Export mptcp packet scheduler helpers"
      Squash to "bpf: Export mptcp packet scheduler helpers"
      selftests/bpf: mptcp: verify scheduler rejects non-msk socket to set_timeout
      selftests/bpf: mptcp: extend bad scheduler test to the kfunc type contract

 net/mptcp/bpf.c                                    |  17 +++-
 tools/testing/selftests/bpf/prog_tests/mptcp.c     |  57 ++++++++++++
 .../selftests/bpf/progs/mptcp_bpf_bad_sched.c      | 100 +++++++++++++++++++++
 .../testing/selftests/bpf/progs/mptcp_bpf_burst.c  |   8 +-
 4 files changed, 176 insertions(+), 6 deletions(-)
---
base-commit: ba8940c77ff7e7f3081e7e3d8a9146000a3ff2aa
change-id: 20260629-mptcp_bpf_kfunc_fixes-7ab60edc2902

Best regards,
--  
Shardul Bankar <shardul.b@mpiricsoftware.com>

