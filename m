Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD48139E162
	for <mptcp@lists.linux.dev>; Mon, 22 Jun 2026 09:39:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782121157; cv=none; b=t2p/qVzkeBZxGyJGgYopUiN61r1jCtyhdXJreJNpZrbrGtis/PjRD9VnssM1WqR/eFR/b7y8a30eLJYwqE4krraR/o1Aa/2gx+0015/xJzCmlBJPFuOK//jIsvUYPb8Kw13t75L2OX71bpNdll+yLN1CnX90GrSz6sQ3b5/i/5k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782121157; c=relaxed/simple;
	bh=Z94LrUs/da9AbJKe9HvadD1vaoGK+AmOVnSTpVf+6T8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=nMrUHLerW/tElKAaxaKIoROtgQK65JaP5h/bKJpocLT7agcw3HoiNQJErOl47FesWuLg7xcqEApKOhbg6cir28+4QOdQ64pplsBm1mQr1Lu+yTzgIgJrxx7lpIay53tJZOkXsbBwjd06JQcSoOg3P15FVa04ZKI8GzUrkXSHhow=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=j1UKQXjf; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="j1UKQXjf"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 157F21F000E9;
	Mon, 22 Jun 2026 09:39:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782121156;
	bh=deeg6a4ayJmCQ0QubTFx+qiFO4YwECfjO8tMkuWFPUY=;
	h=From:To:Cc:Subject:Date;
	b=j1UKQXjf9PaJJFJtF+1YUSmBHHX6UQaqsn30IHKnacHkFuTXZQGmCtZnJOFphPkGI
	 isopfBwnQumLsLXrDKAu7jp7gvq1KLgbSiuv90EuCdqB3k2inFvTmjUPEjsLRHwUOj
	 THa2sszhSyJffHvv8QWIIBhb9b2gL0v/QK0OiflkKB2aZA7ZcefGm60nxhcvkeIDA0
	 +7GGbWMWBKdoBEK8Q2eUfvaxrB4hj9Eh1So5j+0pThdfx/Y/T93WCV5j/n0yUfV4FS
	 AW57Q1tON8cBfS32r9ak47S20ob+Khk2Yo1l2uap1LpHmJq1CbWXvjbREqbKFqfAFn
	 SQbmltCQn6rqQ==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next v3 0/6] bpf sched updates
Date: Mon, 22 Jun 2026 17:38:57 +0800
Message-ID: <cover.1782120674.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Geliang Tang <tanggeliang@kylinos.cn>

v3:
 - Add sk_type == SOCK_STREAM check in bpf_iter_mptcp_subflow_new() to
   prevent raw sockets from bypassing validation (new patch 1).
 - Zero iterator state (kit->msk, kit->pos) on error paths in
   bpf_iter_mptcp_subflow_new() to avoid uninitialized dereference.
 - Change bpf_sk_stream_memory_free() signature to accept
   struct mptcp_subflow_context * instead of struct sock *, to make it
   work with burst scheduler.

v2:
 - new patches 2-7, address Sashiko's comments to drop __ign in
   arguments of bpf_sk_stream_memory_free() and bpf_mptcp_subflow_ctx().
 - Link: https://patchwork.kernel.org/project/mptcp/cover/cover.1782106180.git.tanggeliang@kylinos.cn/

v1:
 - Link: https://patchwork.kernel.org/project/mptcp/patch/10a30ed6484cc4d48009625f1ed8e12802e78e94.1781699193.git.tanggeliang@kylinos.cn/

This series addresses BPF verifier issues in the MPTCP packet scheduler
helpers and their selftests.

The initial motivation was to fix an incorrect return value in
bpf_sk_stream_memory_free(): the function returns bool but erroneously
returned NULL. This was fixed by changing it to false and dropping the
KF_RET_NULL flag.

However, further review revealed that both bpf_sk_stream_memory_free()
and bpf_mptcp_subflow_ctx() used the __ign suffix on their pointer
arguments to bypass verifier checks. This approach is unsafe because it
allows untrusted pointers to be passed into kfuncs, potentially leading
to verifier rejection or runtime issues. In practice, passing pointers
like msk->first (which are not marked as trusted) to these kfuncs
triggers the verifier error "R1 must be referenced or trusted".

To resolve this cleanly, the series:

- Removes bpf_sk_stream_memory_free() entirely, as its functionality can
  be implemented inline in the BPF scheduler (burst) using MPTCP-specific
  memory checks (msk->notsent_lowat and subflow send buffer).

- Removes the __ign suffix from bpf_mptcp_subflow_ctx() and updates all
  BPF schedulers (first, rr, burst) to avoid calling it. Instead, they
  use bpf_for_each(mptcp_subflow) iterations to obtain trusted subflow
  pointers directly, eliminating the need for reverse lookup from an
  untrusted sock pointer.

With these changes, all BPF scheduler tests pass verification and
function correctly.

Geliang Tang (6):
  Squash to "bpf: Add mptcp_subflow bpf_iter"
  Squash to "bpf: Export mptcp packet scheduler helpers"
  Squash to "selftests/bpf: Add bpf_burst scheduler & test"
  Squash to "bpf: Export mptcp packet scheduler helpers" 2
  Squash to "selftests/bpf: Add bpf_first scheduler & test"
  Squash to "selftests/bpf: Add bpf_rr scheduler & test"

 net/mptcp/bpf.c                               | 28 ++++++++++-------
 .../selftests/bpf/progs/mptcp_bpf_burst.c     | 25 ++++++++--------
 .../selftests/bpf/progs/mptcp_bpf_first.c     | 17 ++++++-----
 .../selftests/bpf/progs/mptcp_bpf_rr.c        | 30 +++++++++++--------
 4 files changed, 57 insertions(+), 43 deletions(-)

-- 
2.53.0

