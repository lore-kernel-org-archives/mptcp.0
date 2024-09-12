Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C081D18A6A9
	for <mptcp@lists.linux.dev>; Thu, 12 Sep 2024 09:26:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726133161; cv=none; b=sPoIvzJctqI3QNuG40EFqx73cJ5+lLzOTFDjnQr/fVD1BcaRvVoMB/HJxvJ7JhoImCpHTvO0FLtWYlXhzzj6ehVxkE15rzOWAEODmBeU+teW1CtN9rhZupL2GbJDysn9OqyyiGwC0VSJOzH780EnMEs+ot4Znuc/tlixbH4HfNY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726133161; c=relaxed/simple;
	bh=rIOoA29PJV/rwH3q8UliSpaT4hPNDId7c4+0GySDX+Y=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=IGuYjEUiJYtA596XqSnC9cKifOoBozyR2YV1tu0lbRqxXRjnLtctRqvM4A8HQPDtA0e4beuQyS3iVnA6jT8ia9IQsDfe62M0FxXGjmwSgy3FMadb5MU8lytU9e2PEMwsWcfkVMjWrUk1/4iZL5TuJ+EcYWTigippLMlVMPLKNKc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WPe5aznc; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WPe5aznc"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 51415C4CEC3;
	Thu, 12 Sep 2024 09:26:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1726133161;
	bh=rIOoA29PJV/rwH3q8UliSpaT4hPNDId7c4+0GySDX+Y=;
	h=From:To:Cc:Subject:Date:From;
	b=WPe5aznc4KXlFArgpUo1Z8qWti0emLPB87beVaZJ50xzlQayxTNrMZVPSi6mzCUGA
	 6hFijAL5SkS5WGfvyMA3BfEjo4Gi6I22dX+vdbos5yejRhqTBtpJL7H3oQlVD5OZFO
	 hIGIXDEMDHmB0494OwLCejoU6enJDjihmbHoieUpaKN32Rwp3vwMKVhmUIMSGVWIDa
	 MPi8CNAqlJfXEpgB0jU6qbu8g8509gHAS6xUgspVdjgJPwnNfI+vHpvnx52s0yqR9N
	 PkBuSdHWGVdkYfsSFkM28gvBYyUjXzFsksNTDpO+Vj0CW6lT/BBsTeYuTn9DW7Hx2N
	 +qtd6Zy95PHIg==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next v5 0/5] add mptcp_subflow bpf_iter
Date: Thu, 12 Sep 2024 17:25:50 +0800
Message-ID: <cover.1726132802.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Geliang Tang <tanggeliang@kylinos.cn>

v5:
 - update patch 1 as Andrii suggested: if msk is NULL, initialize
kit->msk to NULL in _new() and check it in _next().

v4:
 - squash patch 1/5 and 3/5 in v3 together as Matt suggested.
 - a new squash-to patch to drop mptcp_subflow_active declaration in
   bpf_burst.

v3:
 - drop bpf_iter__mptcp_subflow, __diag_push, __diag_pop and
 __diag_ignore_all
 - drop declarations for bpf kfuncs

v2:
 - update patch 1 as Martin and Andrii suggested.
 - fix warnings and errors reported by MPTCP CI.

This patch set adds a mptcp_subflow type bpf_iter, and self tests.

Geliang Tang (5):
  bpf: Add mptcp_subflow bpf_iter
  selftests/bpf: Add mptcp_subflow bpf_iter test prog
  selftests/bpf: Add mptcp_subflow bpf_iter subtest
  Squash to "mptcp: add sched_data helpers"
  Squash to "selftests/bpf: Add bpf_burst scheduler & test"

 net/mptcp/bpf.c                               | 57 +++++++++++--
 net/mptcp/protocol.h                          |  2 -
 .../testing/selftests/bpf/bpf_experimental.h  |  7 ++
 .../testing/selftests/bpf/prog_tests/mptcp.c  | 85 +++++++++++++++++++
 tools/testing/selftests/bpf/progs/mptcp_bpf.h |  4 +
 .../selftests/bpf/progs/mptcp_bpf_burst.c     |  1 -
 .../selftests/bpf/progs/mptcp_bpf_iter.c      | 38 +++++++++
 7 files changed, 186 insertions(+), 8 deletions(-)
 create mode 100644 tools/testing/selftests/bpf/progs/mptcp_bpf_iter.c

-- 
2.43.0

