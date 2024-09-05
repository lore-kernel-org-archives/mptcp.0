Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D438412FF71
	for <mptcp@lists.linux.dev>; Thu,  5 Sep 2024 02:27:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725503229; cv=none; b=GGsmFilCE1Rygot5gqXMdPjYSiwUly3ASmLECR/GW34/4swMFCEKsYr3OTzcW+mn4xqk3ZwRX6iXTs4i0j/XLvEkKnaKRjLgu7uN2TbpjH4LvdUx56KbMGiMj1R7FZpiQ6WS/3lPy+JFB1d+Jk8Ed877MLqLacVIM+kthu+se+o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725503229; c=relaxed/simple;
	bh=cV+CQttez36r9A57v+HRgOgNsUJ5tqIXbTTbll4W0DE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=madsZbq/lC9zck74vMVhU8mSrx/rFoQ328w+xgpK24jdocvveg03w8Jp/y5ffaGBDcqZ6Cy2RcyCuiUAAGSOAZidmLJcvcqa2Wzgdrtk2DaQdS0xy/s0V8g/0JySgxUw4nFcwEfTdoxOcrfb6hmnP4xeVjvzuzXWv55nxVsFK3Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OJDVge3a; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OJDVge3a"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 45975C4CEC8;
	Thu,  5 Sep 2024 02:27:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725503229;
	bh=cV+CQttez36r9A57v+HRgOgNsUJ5tqIXbTTbll4W0DE=;
	h=From:To:Cc:Subject:Date:From;
	b=OJDVge3aLG1bV0YwGEEucRqLoaHV1OXnxc/QVqNJjG36RavnApdN2h73AG2GywMa4
	 WOO+TUVst1YDtzvXhmRtf9saGuQEOCZ43JvR2A+w2sujCqYUpGPXm4HYsZyTmjL/ch
	 vkY9/f+vCvSVwJdt0T7gmbVehrpgiE7ig6Y88vMND6GQlGemxRi2u2dHQft0SVDZ3x
	 EXtEa3rEPe6TlAKymuKds9tfjvWpD+dUFKxqlEueQSCQP9eK5pnuTDl/Pw9sx7Le2j
	 tmME7nu5UuwfC3J7aVSYMhcjtFI6jGAlq/HIeBAuZWKatdh5TFAGguN/anqXnC4wrC
	 p902krE84gvqQ==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next v8 0/4] fixes for "new MPTCP subflow subtest v4"
Date: Thu,  5 Sep 2024 10:26:55 +0800
Message-ID: <cover.1725502822.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Geliang Tang <tanggeliang@kylinos.cn>

v8:
 - drop bpf_printk, use different errnos (-1, -2) instead for debugging:

run_subflow:FAIL:getsockopt(client_fd, SO_MARK) unexpected error: -1 (errno 1)
run_subflow:FAIL:getsockopt(client_fd, TCP_CONGESTION) unexpected error: -1 (errno 1)
run_subflow:FAIL:getsockopt(client_fd, SO_MARK) unexpected error: -1 (errno 2)
run_subflow:FAIL:getsockopt(client_fd, TCP_CONGESTION) unexpected error: -1 (errno 2)

 - move more duplicate code into _getsockopt_subflow.

v7:
 - drop helpers mptcp_for_each_subflow_safe and
   list_for_each_entry_safe.
 - update parameters of _check_getsockopt_subflow_mark/cc.
 - print more messages in the logs as Matt suggested.

v6:
 - address Matt's comments in v5.
 - use mptcp_for_each_subflow in _check_getsockopt_subflow_mark.
 - check msk->pm.subflows in _check_getsockopt_subflow_mark/cc.
 - add wait_for_new_subflows helper.

v5:
 - rename _check_getsockopt_subflows_mark in patch 1.
 - address Matt's comments in v4.

v4:
 - address Matt's comments in v3.

v3:
 - drop "ss_search" from subflow subtest
 - fix mptcp_for_each_subflow_safe
 - add cond_break in list_for_each_entry/_safe

Two fixes address Martin's comments in "new MPTCP subflow subtest" v4.
Patch 2 will conflict with "selftests/bpf: Add bpf_first scheduler & test".

Geliang Tang (4):
  Squash to "selftests/bpf: Add mptcp subflow example"
  selftests/bpf: Add getsockopt to inspect mptcp subflow
  Squash to "selftests/bpf: Add mptcp subflow subtest"
  Squash to "selftests/bpf: Add bpf scheduler test"

 .../testing/selftests/bpf/prog_tests/mptcp.c  | 67 +++++++++++------
 tools/testing/selftests/bpf/progs/mptcp_bpf.h | 27 +++++++
 .../selftests/bpf/progs/mptcp_subflow.c       | 71 ++++++++++++++++++-
 3 files changed, 143 insertions(+), 22 deletions(-)

-- 
2.43.0

