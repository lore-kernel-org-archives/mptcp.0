Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55B0818A6D8
	for <mptcp@lists.linux.dev>; Tue, 20 Aug 2024 08:44:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724143499; cv=none; b=daPiiiDES+5CPlFxxGEJYyXdZblLRVC3e56QX5NfE5cxdxyiYZ8waKPBb5ohLswwvSuOwAPBlCuUo/iAt8yi8sQMVA5WfavY7LP8L4S1uqCBj3AqQfks1EXoKhftzoJ3KJOUblZ2iXowC22stSfsbQDPHbbSxWGoyY6w+77FXUA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724143499; c=relaxed/simple;
	bh=nM5CGekxbjZOX9/2MRJrkhGApUBSQZsxzwNO37Sfiy0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Xb3m0jPBAjg3rUGhm3ond+RwtrOfvSQUvWfDQB9NgShtYq7hbGtrqr7jt2bNlKqDReYiicErWd8Qjd6vlCm2rr4VDAYpuR7/r6hFPHuiO58cI+sRInRecR+N8AoZaD2oxfA7HiKPyNWvdpts4n011hqLxeIDiC1c0pBZtdW2uXQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rDJ4quh3; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rDJ4quh3"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 07A43C4AF09;
	Tue, 20 Aug 2024 08:44:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724143498;
	bh=nM5CGekxbjZOX9/2MRJrkhGApUBSQZsxzwNO37Sfiy0=;
	h=From:To:Cc:Subject:Date:From;
	b=rDJ4quh3QTtnC+zLXSy1fUGNE9sakHcnssH1O8600kr5Oed2F/28GPINM3nz9GDgu
	 WL5GaJT6qGj8O20OaRY6QYBaBP3s2+MmthWBg3fh1g2etMle1R6BV+q8ToBCwrCgB8
	 GBKdRl8RGT/dzPlv3+uyB1e04nST421b14yO+4anZNvAUIEr05n8bfwp3sWOKl77hn
	 s7jNuDPigPrJUXZmrE2FdTpv8WBAYeKkjH/jXPDUQTZ7T+sicj5BIHM4m+p0GevRvu
	 WWUgumDCA5QV26hvkuClDXJMhhYyUwqIWzmuLrqherb5O11dBo/sokzE5upt4tQbbd
	 SWefPpElYAgnw==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next 0/2] fixes for "new MPTCP subflow subtest v4"
Date: Tue, 20 Aug 2024 16:44:52 +0800
Message-ID: <cover.1724142917.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Geliang Tang <tanggeliang@kylinos.cn>

Two fixes address Martin's comments in "new MPTCP subflow subtest" v4.
Patch 2 will conflict with "selftests/bpf: Add bpf_first scheduler & test".

Geliang Tang (2):
  Squash to "selftests/bpf: Add mptcp subflow subtest"
  selftests/bpf: Add getsockopt to inspect mptcp subflow

 .../testing/selftests/bpf/prog_tests/mptcp.c  | 18 +++++++++--
 tools/testing/selftests/bpf/progs/mptcp_bpf.h | 26 +++++++++++++++
 .../selftests/bpf/progs/mptcp_subflow.c       | 32 +++++++++++++++++++
 3 files changed, 74 insertions(+), 2 deletions(-)

-- 
2.43.0

