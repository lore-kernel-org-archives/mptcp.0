Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5118201244
	for <mptcp@lists.linux.dev>; Tue,  3 Sep 2024 08:05:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725350707; cv=none; b=FjoOQ7TvfI8o6duMIEObhgPNFEu/ESgzU9HBElpQhGbEJkYECGjPN4RuB5YAkf7iFUELuhdu7e80t5sBk76yyehFp7n+cHDL54OpfEfcovaCqW6KWTW94b0KAS5MTbkjfTQ3iNfCcoCq8u/jmGrVM0d4IZVuouuLHZ51Pb10zXg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725350707; c=relaxed/simple;
	bh=9Y6U8y9tb0MvpLvXGlzc2sLE1wByoO/VwYkx2/S51qM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=KRoQjyK8JHakRoavhwljVK7gs+tLGq6dGp9+FyGLyfBs0o3qcbmVSRrpKUekCeOrpwlCuu2zc3l3RkTAMeyhi46TtYVRdAVyaERbb6wDFtuuL6HK1J9b3bGYH+sU+CGwn/PLQz//lvpAEByRZ5pEeLoksVd5OmlC88nXYtty8iY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PfsSKCa7; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PfsSKCa7"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B5161C4CEC5;
	Tue,  3 Sep 2024 08:05:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725350707;
	bh=9Y6U8y9tb0MvpLvXGlzc2sLE1wByoO/VwYkx2/S51qM=;
	h=From:To:Cc:Subject:Date:From;
	b=PfsSKCa77OZGGUiV/QC8te2ynwwJxzGlDoYy8kHdQsEPke1p5hRKF/yvECM+mTFDg
	 1hSs5irkPkP3vNSL356139r2k6x57tqQMlXrR3BXZe2aSNDWMfYq/JNoTZYqkoHK1Y
	 z4vUKx45iqscLmD1QP4NJLO5hCVLdMkmL426m3jTYw83Zq6mZpQjdCOWYUvqsOeLf8
	 MKH0StpogBaSX/CxtSl2AgqCRawwttfyuTy+GD5bj0BVrQdsKE0ueThQtb1k6EiUzS
	 52nuK6PRg9XeyfgSnT1m4peXp5KiOXTERlejEghliSt2sdyUfxcTI+R52hOyeZ6LFw
	 p2FF6a1JQbLAw==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next v7 0/4] fixes for "new MPTCP subflow subtest v4"
Date: Tue,  3 Sep 2024 16:04:56 +0800
Message-ID: <cover.1725350462.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Geliang Tang <tanggeliang@kylinos.cn>

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

 .../testing/selftests/bpf/prog_tests/mptcp.c  | 65 ++++++++-----
 tools/testing/selftests/bpf/progs/mptcp_bpf.h | 27 ++++++
 .../selftests/bpf/progs/mptcp_subflow.c       | 92 ++++++++++++++++++-
 3 files changed, 162 insertions(+), 22 deletions(-)

-- 
2.43.0

