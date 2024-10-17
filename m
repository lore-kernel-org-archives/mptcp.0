Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E76AB1D8DEE
	for <mptcp@lists.linux.dev>; Thu, 17 Oct 2024 10:55:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729162551; cv=none; b=DV1LtAJOqo/zpYJ3/7p4lX4L05Eb4rhcH3NCx47nxqe2VOUVsbfY/zVwUI/ePFSOHhBzCrAiAQGcP1SzPX4NqCqVy/SNfkS+3W18dVrHan+uDyx1e8s1+ASjCnsOx3aMNCGwPboSyS/Q+v4msfj8H9Cp2nlGIeYNwU4CTKi8Yxc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729162551; c=relaxed/simple;
	bh=CY5WqHjOeRVqzj5f2FOcrJFiB37xkC+TOXHzZUpdg1I=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=AbxIDB4jBJcM6+0sLSXLreD5z232VdPLoevY8HQVpjtho4tKPcs5utzQqbjIrDWNPyMEMX72tzG3VoLBz7U9amrUdT3vOIUon/QPEo8njq30kgmLrrE3dGSmrLt4jcjKka6ZoaPNn4ycs7FXcSw2a10DBrq8YshSn3EpZnTEMlg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JfMUBrPA; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JfMUBrPA"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 12A9DC4CEC3;
	Thu, 17 Oct 2024 10:55:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729162550;
	bh=CY5WqHjOeRVqzj5f2FOcrJFiB37xkC+TOXHzZUpdg1I=;
	h=From:To:Cc:Subject:Date:From;
	b=JfMUBrPAFo5JoPPeNl4Kxp+eYgNSiXnank8cOacLzg4KlpPMDhHAIybVKOJNd0n3B
	 d+ajOJkcLoeCqTUyuEZ0gkQYt0lXtDKAdXokdxD3xpkbVzhfoWuKlicYCFVKwRatFU
	 7dKQUWQbQouktZFepxuoa576qz76tTcKpDXhDzzm6N5Sjc41MMLUSbISecGen2paxP
	 VT0fAKyyKZB2mb06+pSai3iZL3oWUi5JSkX484/XaQmbCvBWXKOeeyv0FWMyvFc5dc
	 4ySkb/mgy0bufNWMHxDCjxDDLQVrmV3McNCypZI5TSry68Z11B5mivkZlZ6B5XuNkX
	 2y4gxlKTTWG+w==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next v2 0/3] fixes for "add mptcp_subflow bpf_iter" v10
Date: Thu, 17 Oct 2024 18:55:29 +0800
Message-ID: <cover.1729162349.git.tanggeliang@kylinos.cn>
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
 - drop unused variable 'err'.

There are two building errors in v10:

progs/mptcp_bpf_iters.c:24:8: error: call to undeclared function 'bpf_mptcp_sk'; ISO C99 and later do not support implicit function declarations [-Wimplicit-function-declaration]
   24 |         msk = bpf_mptcp_sk((struct sock *)sk);
      |               ^
progs/mptcp_bpf_iters.c:24:6: error: incompatible integer to pointer conversion assigning to 'struct mptcp_sock *' from 'int' [-Wint-conversion]
   24 |         msk = bpf_mptcp_sk((struct sock *)sk);


tools/testing/selftests/bpf/prog_tests/mptcp.c: In function 'test_iters_subflow':
tools/testing/selftests/bpf/prog_tests/mptcp.c:546:13: error: unused variable 'err' [-Werror=unused-variable]
  546 |         int err;
      |             ^~~
  TEST-OBJ [test_progs] pe_preserve_elems.test.o

bpf_mptcp_sk() definition is missing. It will be used in patch 4.
An unused variable 'err' needs to be dropped.

Depends on:
 - "add mptcp_subflow bpf_iter" v10

Based-on: <cover.1729063444.git.tanggeliang@kylinos.cn>

Geliang Tang (3):
  Squash to "bpf: Register mptcp common kfunc set"
  Squash to "selftests/bpf: Add mptcp_subflow bpf_iter test prog"
  Squash to "selftests/bpf: Add mptcp_subflow bpf_iter subtest"

 net/mptcp/bpf.c                                | 6 ++++++
 tools/testing/selftests/bpf/prog_tests/mptcp.c | 1 -
 tools/testing/selftests/bpf/progs/mptcp_bpf.h  | 1 +
 3 files changed, 7 insertions(+), 1 deletion(-)

-- 
2.43.0

