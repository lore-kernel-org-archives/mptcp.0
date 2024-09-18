Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 264072233A
	for <mptcp@lists.linux.dev>; Wed, 18 Sep 2024 08:25:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726647926; cv=none; b=OUusd3RMV5S3Br2prDF1WoCWTvQ1+5geIxeJDDR/HGcWUoFJvWHR2OIZ3dNVaRQK8XdZoIMtsRBlD71tlq2nsvTMQQXI++fQjwAoRTXjEARrDx0hOs2SgKRVbDnztxJzpnODGIhj9ERrGepfFF94GGgkCNN/7/uMJ/lQOXDjvqE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726647926; c=relaxed/simple;
	bh=ZUXfjEgwZLJ97CD5fEnjUy1S8BMxS9i6ZHKP89IO080=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=UhyyCB6LDbBaVyu8tjvEPWg0FCT3xCDrdV5a/GrZex2wai+nQHqXfSt0HaYkTczFAYb0jnn8Lr5SQncwBvgCVMBtpFjj42sn+31DZbID3RHkbVIl+ZQrFcAsumXPwWPL8qUxc2AqrtGAr7v+sBTl70wuc3PBbyXfiwHR8W+MH4Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lhKmXiI9; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lhKmXiI9"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6D963C4CEC3;
	Wed, 18 Sep 2024 08:25:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1726647925;
	bh=ZUXfjEgwZLJ97CD5fEnjUy1S8BMxS9i6ZHKP89IO080=;
	h=From:To:Cc:Subject:Date:From;
	b=lhKmXiI9uxsMc2I7PRIHE2v9cuZYC4+4nBI+8VEm6jO8w+clNR+vE10s9mb5FjjK7
	 QUXsJnTXpvwJoryaRsbsg3JhtKCUm+ZBvdRYyma/Faj5MLiOM2iW1klpB/iYdiQFmM
	 eSIs7/TkwDAgvzA6pjTef0yyDtqomt5ZKJBa4btAtypWTnFYCDetj8hIDaZz7VgNmP
	 ttvZagsIqdz5HeWtnFlIN1xWOkL5HOm7o3qDb5yp/Ugg145E+NejrSX2X5WQM20baf
	 OM/lON/xhniQp28kaas8Vb5NXPwAY9PwiLqqKtTizrajl9z55lzyx9/2A7nQCLGfRq
	 zynxz9IIkAnrw==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next v2 0/6] fixes for "new MPTCP subflow subtest v6"
Date: Wed, 18 Sep 2024 16:25:12 +0800
Message-ID: <cover.1726647599.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Geliang Tang <tanggeliang@kylinos.cn>

v2:
 - two more cleanups, 5-6, use __bpf_kfunc_start_defs/__bpf_kfunc_end_defs
 and drop the declarations of __bpf_kfunc.

1-2 address Martin's comments
3-4 cleanups for endpoint_init

Geliang Tang (6):
  Squash to "selftests/bpf: Add getsockopt to inspect mptcp subflow"
  Squash to "selftests/bpf: Add mptcp subflow subtest"
  selftests/bpf: More subflows for endpoint_init
  Squash to "selftests/bpf: Add bpf scheduler test"
  Squash to "mptcp: add sched_data helpers"
  Squash to "bpf: Export more bpf_burst related functions"

 net/mptcp/bpf.c                               |  6 +--
 net/mptcp/protocol.h                          |  3 --
 .../testing/selftests/bpf/prog_tests/mptcp.c  | 47 ++++++++++++-------
 tools/testing/selftests/bpf/progs/mptcp_bpf.h |  4 +-
 4 files changed, 34 insertions(+), 26 deletions(-)

-- 
2.43.0

