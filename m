Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 568C718D650
	for <mptcp@lists.linux.dev>; Wed,  9 Oct 2024 10:29:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728469798; cv=none; b=XODaVBX0L3ARUCKHB2i+vop5sr3G7jbEQwsnUA9yTjhK4wdcQHTUmCnVMp6FeJPEB0O/pDyxm1KcnwKm2Bzhpp6Nr6kTqiyZQ2S1sNYjgMejXqeCZJDSFYfxhiUQGUCbHXZjDZyES6OmG1bvfoJ4W8QRdwpdOd2xAqMU0kl2wck=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728469798; c=relaxed/simple;
	bh=sd0Bqi/Q56nc9/agDannmNj5smq2TocrwqhQj0jMIuE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=a22ai6dzYUR2Xgj/UbEjzu38saAK9DG+QiH8bv8vb/xaL7XPcFhOy4aJ5YpAopNHEmSFwpE6ufM1DD0TKvyLYHQIRR3WNCuSKJ0srMPPZ1A918SAY5nkZ1bX868mZspKDBV4dRDX5VNu4nnUkpPeIJtsdRrQazIoGJJ6rhrnnNo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tAazoH8d; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tAazoH8d"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B4D86C4CECC;
	Wed,  9 Oct 2024 10:29:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728469797;
	bh=sd0Bqi/Q56nc9/agDannmNj5smq2TocrwqhQj0jMIuE=;
	h=From:To:Cc:Subject:Date:From;
	b=tAazoH8dDXMAK71RfsioFPEDz32J6P7rxrVMEM9kHkv3BwNu7WNv6BkZRXMawOsX8
	 54435oz8Nvw6h5viKhlrCVna31vrydS/pPKmdv1CHkjskc1MKF8e4t26B8XM4evliq
	 TJplm+HoZQELkqQ68iJ3Xi41ZYZKOb/GAuCcOZfI9qTK3dtP+GtWpM4ccb/JQfSyAB
	 efiYbtOJGgLIXEMEkYKB1s8CyhEcTDtzzfDfZce5gnGT6OECGRAgpvh4pL44j0Qrrn
	 Xm/QTUQcJCApgxWauySr1CQVQLKXonBn+f2HI0Dfy87ORgsPoSBPgRkoc57LfWngev
	 I66BczMEj6QIA==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next v3 00/10] use bpf_iter in bpf schedulers
Date: Wed,  9 Oct 2024 18:29:41 +0800
Message-ID: <cover.1728469555.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Geliang Tang <tanggeliang@kylinos.cn>

v3:
 - rebased.
 - put the "drop has_bytes_sent" squash-to patch into this set.

v2:
 - update bpf_rr and bpf_burst

With the newly added mptcp_subflow bpf_iter, we can get rid of the
subflows array "contexts" in struct mptcp_sched_data. This set 
uses bpf_for_each(mptcp_subflow) helper to update all the bpf
schedules:

	bpf_for_each(mptcp_subflow, subflow, msk) {
		... ...
		mptcp_subflow_set_scheduled(subflow, true);
	}

Depends on:
 - "add mptcp_subflow bpf_iter" v9

Based-on: <cover.1728466623.git.tanggeliang@kylinos.cn>

Geliang Tang (10):
  Squash to "bpf: Add bpf_mptcp_sched_kfunc_set"
  Squash to "selftests/bpf: Add bpf_first scheduler & test"
  Squash to "selftests/bpf: Add bpf_bkup scheduler & test"
  Squash to "selftests/bpf: Add bpf_rr scheduler & test"
  Squash to "selftests/bpf: Add bpf_red scheduler & test"
  Squash to "bpf: Export more bpf_burst related functions"
  Squash to "selftests/bpf: Add bpf_burst scheduler & test"
  Revert "mptcp: add sched_data helpers"
  mptcp: drop subflow contexts in mptcp_sched_data
  Squash to "selftests/bpf: Add bpf scheduler test" - drop
    has_bytes_sent

 include/net/mptcp.h                           |  2 -
 net/mptcp/bpf.c                               | 19 ++---
 net/mptcp/protocol.h                          |  3 -
 net/mptcp/sched.c                             | 22 ------
 .../testing/selftests/bpf/prog_tests/mptcp.c  | 48 ++++++------
 tools/testing/selftests/bpf/progs/mptcp_bpf.h |  3 -
 .../selftests/bpf/progs/mptcp_bpf_bkup.c      | 16 +---
 .../selftests/bpf/progs/mptcp_bpf_burst.c     | 78 +++++++++----------
 .../selftests/bpf/progs/mptcp_bpf_bytes.c     | 39 ++++++++++
 .../selftests/bpf/progs/mptcp_bpf_first.c     |  8 +-
 .../selftests/bpf/progs/mptcp_bpf_red.c       |  8 +-
 .../selftests/bpf/progs/mptcp_bpf_rr.c        | 24 +++---
 12 files changed, 132 insertions(+), 138 deletions(-)
 create mode 100644 tools/testing/selftests/bpf/progs/mptcp_bpf_bytes.c

-- 
2.43.0

