Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B0FC18E3A
	for <mptcp@lists.linux.dev>; Sun, 24 Mar 2024 16:02:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711296126; cv=none; b=iv+cER20ieOYQ/KLpR9GIHX7rOoEnAETTSfF2GrqEUffH6eQi7jTPLR7Uz6zgYDbCpgztixptg6wUuPuDlAFCgK/Lc/r4dMDwTgWEYzgccz7IkvR6J0GnOv1bjCrRrDROviFS2l7LKaByVfBzG50xQr0RQjPjWihZE7mcfE28sY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711296126; c=relaxed/simple;
	bh=whdlNdkldUJJR8dPNZTy7Pz00pZNEfFTm7VHzC8GoGQ=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=BuDnHqyZrRHY1dTT3nAZoksTrZ3gtBBjNh/3yVQRop2+xvmHhOCiHdglamXU818z3cwFHj/kqOtRzMmkU9JDq8nYUFRvLVpeX3n+RkvAzBD/WcoknkWy0zXLKd1FKaLwauXUSA8ZFw1HhX0eEC9pY/cIBKx4str9TE709nqZx/w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DVyQjrQx; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DVyQjrQx"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9A36DC433C7;
	Sun, 24 Mar 2024 16:02:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711296125;
	bh=whdlNdkldUJJR8dPNZTy7Pz00pZNEfFTm7VHzC8GoGQ=;
	h=From:To:Cc:Subject:Date:From;
	b=DVyQjrQxGLSPNMQQq5cwhsGHnZOtSbhw3z+AT+1dgQ9k3gxQf+NS3SNOJ1B0C22es
	 ue2RzuFquSa3lQzafCHHv8KeTA/LnGcObcDbVeY9PzXmAcbq8DoKgs3zgxcAeLFTpt
	 nWhATfn4RYUyDmwNMM5FF60p5JyT7pTIZzugyRS88vjP+/src4nvWgh45fP48y2gEs
	 S85XOBC2lYCuywqgolNi67GIlajjEIYmYLIBpdJk1l7+yFeiD4h/QgmuRvOPI+HQCC
	 SPI4EyxJ1foHsZn6Ewp66ZiSQegeW//xJhpwor7EGk0x9Kx57OrE1e0nDjri7JJT+o
	 Iyda2IiWoqK6Q==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next v3 0/4] setsockopt per subflow: BPF
Date: Mon, 25 Mar 2024 00:01:13 +0800
Message-Id: <cover.1711296000.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.40.1
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Geliang Tang <tanggeliang@kylinos.cn>

Address #76.

v3:
 - deal with EAGAIN.
 - add _ss_search helper.

v2:
 - fix checkpatch warnings.
 - cleanups.

Geliang Tang (4):
  Squash to "selftests/bpf: Add bpf scheduler test" fix
  selftests/bpf: Add mptcp subflow example
  selftests/bpf: Add mptcp subflow subtest
  Squash to "selftests/bpf: Add bpf scheduler test"

 .../testing/selftests/bpf/prog_tests/mptcp.c  | 138 ++++++++++++++----
 .../selftests/bpf/progs/mptcp_subflow.c       |  73 +++++++++
 2 files changed, 182 insertions(+), 29 deletions(-)
 create mode 100644 tools/testing/selftests/bpf/progs/mptcp_subflow.c

-- 
2.40.1

