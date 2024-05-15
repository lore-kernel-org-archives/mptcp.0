Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6511A3EA7B
	for <mptcp@lists.linux.dev>; Wed, 15 May 2024 10:38:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715769518; cv=none; b=G9yH+vpW+IDfF9wHrmaOel5CsG5DyxBgYDEzZkJH2yWSYi3tlCGRhC8K+Eo1qKGpA18JI4eM7G4Qw5UtBkrRMV4BX81z8zvJVBjpeb17XZIrkIJ+xlZETDcuWwz6fK4QGydKyn4VoYpNFFHj5JAjhweZLYk21e8WqRJ7RH1uIWA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715769518; c=relaxed/simple;
	bh=uO+SBtRBLyW6Fe4UU9IpKPxL3Mjpk5CONL28+fjQ0RA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=g5hsVNamXRvg8RAZZwjNybPLPX9A2zCObCEDrI5QrCmBn7WXzqI191w8/v7kdnS6hSFhJQ1m5BuUYBfVQGWtf6sosFyBK7Kd08qmlHykht4FwkbTUqSdrgF3W24y8tVAN4/YzdzCnqmXxtUNc1kIEyNdw24CtuAZ1Fow4fn2zdA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aWYACD2b; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aWYACD2b"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1E982C116B1;
	Wed, 15 May 2024 10:38:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715769517;
	bh=uO+SBtRBLyW6Fe4UU9IpKPxL3Mjpk5CONL28+fjQ0RA=;
	h=From:To:Cc:Subject:Date:From;
	b=aWYACD2bfDp/J9qE+ljNGqJKuxaBDxoiiRbhD86R5VP9Ww3wHUODDsXQWERy2UWi1
	 c8T+puyXPQqO0dBtX9eTO7AWQg/5zZFCjg7zxo0af5jUhjf7ZtJ2d1eM25WVTZ0uID
	 AGHvTGaKtHBpdB2ziF/+pc39QV6kigjo8DEG+7TuM46CGgn0BNYjRgPZvUnKE6wl8x
	 S8flFvElHwXW4NgSYCQeKjjG0ti+pRxeSiazswoLQg56Nlp2M1Uw22/L3nby3FsqkI
	 vkRP+s3lf75mXNeLDyggvVMBPtIPUhlrKoN9NuUJdHe7q1KAGzJfxxJEP7klV2Ag0s
	 65OJD8z7T9rwQ==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next v6 0/2] patches for new MPTCP subflow subtest
Date: Wed, 15 May 2024 18:38:29 +0800
Message-ID: <cover.1715769419.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Geliang Tang <tanggeliang@kylinos.cn>

v6:
 - fix CI errors.
 - rebased.

v5:
 - move checkpatch.pl fix out of this set.
 - update patch 2 as Matt suggested.

v4:
 - "{*/,}" can't be used in MAINTAINERS, fix it.
 - fix checkpatch too.

v3:
 - update MAINTAINERS.
 - drop '-M' in _ss_search() as Matt suggested.

v2:
 - rename pm_nl_ctl to mptcp_pm_nl_ctl.

Geliang Tang (2):
  selftests/bpf: Add mptcp pm_nl_ctl link
  Squash to "selftests/bpf: Add mptcp subflow subtest"

 MAINTAINERS                                    |  1 +
 tools/testing/selftests/bpf/Makefile           |  3 ++-
 tools/testing/selftests/bpf/mptcp_pm_nl_ctl.c  |  1 +
 tools/testing/selftests/bpf/prog_tests/mptcp.c | 17 ++++++-----------
 4 files changed, 10 insertions(+), 12 deletions(-)
 create mode 120000 tools/testing/selftests/bpf/mptcp_pm_nl_ctl.c

-- 
2.43.0

