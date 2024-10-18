Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE7E1201026
	for <mptcp@lists.linux.dev>; Fri, 18 Oct 2024 10:52:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729248725; cv=none; b=DK9kqr0rDFZE4vNghRHqV+Uvvtkbj36xCr3P8fwJf01/VIs6g5yN9u6GOe3OXDfuH3jtSb7cYzHy0mzsH58w8FiR0FqfD/A5QLzsTIGBP1wUwTAv2on6KkxRjVUofqMivyCadWBQx4wi7bODAytLSq9tc30dhQGT/M+nDoq/poI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729248725; c=relaxed/simple;
	bh=DXk7tD4S//u7Ii+C5JYY7f3Fwv+h0PWlbavPn0NZaqg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=VtKa7kLRPB6kSORp1rY2I2M5YsZXjOZyyZxDKj7py1tDWNUdS/fFNPs2krdug0vxWnPvpNC+VqVChEiM+EamJ4i0yOIqLJ0/7srm6c5L6VmwPrHJagfwz7WKiPgIJR/fgtrI8trvSI7MZplL/TkbyoAg/We4Lq3p8AL7ZlML7Bc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=obgs7SzQ; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="obgs7SzQ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6B3F9C4CEC3;
	Fri, 18 Oct 2024 10:52:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729248725;
	bh=DXk7tD4S//u7Ii+C5JYY7f3Fwv+h0PWlbavPn0NZaqg=;
	h=From:To:Cc:Subject:Date:From;
	b=obgs7SzQirOCsoa1zb2+6tsdpStWjqc7S3qHB8CwBdEKjULim6fyhu+fj4hAQWAQ8
	 hy7z4Dm+StyZxoYGy4BQi0CFoMB7rpotnEZGGwBeN6dZtW2ZeF87GHJNImeKYFHwcB
	 aVKC7neD08G5e23U7qdcgQ04QTa/bkB3RQPxvkRkoJImznrptqVP++31EOhD/JCDbD
	 /7WIuBLA/oEsp+zG4NKAxZSGzU89hfmmrgvmShSkhM3rEJTgwtQ0rWFYmPhO8Ih559
	 ckgNGrw39c19acYnW+Vvbh/3YrsfhcKYMDQTx8FWClFfn0BqUZbsux338tM8l80wWu
	 9tFT2H+tcpvNg==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next 0/6] add mptcp_address bpf_iter
Date: Fri, 18 Oct 2024 18:51:52 +0800
Message-ID: <cover.1729248083.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Geliang Tang <tanggeliang@kylinos.cn>

Another bpf_iter for BPF path manager to traverse all address entries
on userspace_pm_local_addr_list of an MPTCP socket is added in this set.
Userspace pm tool is needed by the self test, so add pm_nl_ctl link in
patch 1.

Depends on:
 - "add mptcp_subflow bpf_iter" v11

Based-on: <cover.1729242644.git.tanggeliang@kylinos.cn>

Geliang Tang (6):
  selftests/bpf: Add mptcp pm_nl_ctl link
  selftests/bpf: Use pm_nl_ctl if ip mptcp not supported
  bpf: Add mptcp_address bpf_iter
  bpf: Export more helpers used by mptcp_address test
  selftests/bpf: Add mptcp_address bpf_iter test prog
  selftests/bpf: Add mptcp_address bpf_iter subtest

 MAINTAINERS                                   |   1 +
 net/mptcp/bpf.c                               |  64 ++++++
 tools/testing/selftests/bpf/Makefile          |   3 +-
 .../testing/selftests/bpf/bpf_experimental.h  |   7 +
 tools/testing/selftests/bpf/mptcp_pm_nl_ctl.c |   1 +
 .../testing/selftests/bpf/prog_tests/mptcp.c  | 198 +++++++++++++++++-
 tools/testing/selftests/bpf/progs/mptcp_bpf.h |   5 +
 .../selftests/bpf/progs/mptcp_bpf_iters.c     |  39 ++++
 8 files changed, 309 insertions(+), 9 deletions(-)
 create mode 120000 tools/testing/selftests/bpf/mptcp_pm_nl_ctl.c

-- 
2.43.0

