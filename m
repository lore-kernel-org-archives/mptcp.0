Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2778753A7
	for <mptcp@lists.linux.dev>; Fri,  7 Feb 2025 10:36:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738924569; cv=none; b=pKke/jbMj6mpE7LTcvx1JK1bLJyT2M9+aPOA3CJ5qRKZrfkMlusWNrMmXZMEsYyFZ9ZS53acYaScmL+91v83qBh88MbaHPia3oIhr8O6jBr+jshXLgMqYvr8roioGjtyJO6/TSuw2Dh3y5ti1qFwt4Qfr6N2/5fHKlOFqbMzivo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738924569; c=relaxed/simple;
	bh=mwgMkqa1369sdISKtn1ij0xR/QkIM+uRr/lRcyQMOoQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=DCFezIHYRszHJruF+CuDSj/wOJD4k8z0U+SNqXdHvAua+wife1UBXEHY6NRlquINFwVycv52rjXgx3MEb7a1L4E+ouZST0a64NreMjQEhjX3RBqokzdomY3CB7qA4Lm6adRlNdy92Gu90dBS+JshKL1/xFBIPXZrv1ZHG0FnUq0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gpoBptbl; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gpoBptbl"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9CE44C4CED1;
	Fri,  7 Feb 2025 10:36:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738924568;
	bh=mwgMkqa1369sdISKtn1ij0xR/QkIM+uRr/lRcyQMOoQ=;
	h=From:To:Cc:Subject:Date:From;
	b=gpoBptblB8FIdi4d6fpYeNqTINntSWkNL4nTYNu/pbArVsSr1zVKazQXsmSQfhsM5
	 9F83lOJcVcM5EIfogOwEpeT3uhkJVZEnnWNNLRWFh+CHkEBsGH9Cg9YFhbRKv9bPxu
	 Wburcmvpb7ABlqa3nVHaRfN2Dvr6VWUwsrm1zjSp49b17upRxAc1HkLHlMfshpPmBU
	 RKz9cdIZd7lle8GHVfDF7+qo/cgRyY/70HiYVPenNzBdT9KzQ75ek8WxuTMIe3q8hY
	 GZqP9As+6Ae/eTSeob1UhJf5dzOEpJPUcSNvJk2r8Wh1whmCVuH9TCHSi+rRe4E3/u
	 uM14nI/6SFCQg==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next v5 0/5] add mptcp_address bpf_iter
Date: Fri,  7 Feb 2025 18:35:57 +0800
Message-ID: <cover.1738924354.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Geliang Tang <tanggeliang@kylinos.cn>

v5:
 - use "struct sock *sk" instead of "struct mptcp-sock *msk" as the
argument of bpf_iter_mptcp_userspace_pm_addr_new() in patch 3.
 - update patch 5.

v4:
 - patch 3, use spin_is_locked() instead of lockdep_assert_held().
 - patch 5, use ipv4_is_private_10() for the selftests instead of using
   ipv6_addr_v4mapped().

v3:
 - rename mptcp_address to mptcp_userspace_pm_addr as I mentioned in [1].
 - rebased.

[1]
https://patchwork.kernel.org/project/mptcp/patch/b6b53fd730a0edd0024963468d078488ad5e67aa.1729588019.git.tanggeliang@kylinos.cn/

v2:
 - squash patches 5,6 of v1 into one.
 - patch 3, use lockdep_assert_held instead of spin_is_locked.
 - update patch 5 to make it run normally in btf-debug mode.

Another bpf_iter for BPF path manager to traverse all address entries
on userspace_pm_local_addr_list of an MPTCP socket is added in this set.
Userspace pm tool is needed by the self test, so add pm_nl_ctl link in
patch 1.

Geliang Tang (5):
  selftests/bpf: Add mptcp pm_nl_ctl link
  selftests/bpf: Use pm_nl_ctl if ip mptcp not supported
  bpf: Add mptcp_userspace_pm_addr bpf_iter
  bpf: Export more helpers for mptcp_userspace_pm_addr test
  selftests/bpf: Add mptcp_userspace_pm_addr bpf_iter subtest

 MAINTAINERS                                   |   1 +
 net/mptcp/bpf.c                               |  72 ++++++
 tools/testing/selftests/bpf/Makefile          |   4 +-
 .../testing/selftests/bpf/bpf_experimental.h  |   8 +
 tools/testing/selftests/bpf/mptcp_pm_nl_ctl.c |   1 +
 .../testing/selftests/bpf/prog_tests/mptcp.c  | 235 +++++++++++++++++-
 tools/testing/selftests/bpf/progs/mptcp_bpf.h |   5 +
 .../selftests/bpf/progs/mptcp_bpf_iters.c     |  34 +++
 8 files changed, 351 insertions(+), 9 deletions(-)
 create mode 120000 tools/testing/selftests/bpf/mptcp_pm_nl_ctl.c

-- 
2.43.0

