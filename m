Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9E6279FD
	for <mptcp@lists.linux.dev>; Thu, 17 Oct 2024 10:22:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729160567; cv=none; b=sof7Vx+WOfWW8kE1LoPh1s7AWNRU+btFkZQ86dtlHl2kitYoNjhoHBgnChjatbCzu+5dVrVSJ4rAexAsKtJAJ8DZ/t/i8CoamulqClsnMLfam93AIDkgkJTxzDc8rvNQ7ARTrcFnJBPYAnMViaxISx4XGGsoAIlJmJu2+bKb/qg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729160567; c=relaxed/simple;
	bh=95br+wrGvTxrD/tq9f7wcTQM2LSC3As8l/npAlnNYpg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=bDqfbgedGmKwvUAjxn0RzD1R5p6Rh7MgIXb6JIv4Fy//z7VAoa3+PSKTIuSfnATZwv0LEya+Pk0OYUR8q43xj+u/L+hwFJCkKgDY2+Y+/KcOmAuvxJzFCoZi3/fA6Q+72z322VpwYDLReokoek6stln6NQ287IFCFM7BREzUi+A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MjnV0uXh; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MjnV0uXh"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 28321C4CEC3;
	Thu, 17 Oct 2024 10:22:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729160567;
	bh=95br+wrGvTxrD/tq9f7wcTQM2LSC3As8l/npAlnNYpg=;
	h=From:To:Cc:Subject:Date:From;
	b=MjnV0uXh10yj7h7wcHk0zwJXqm7ykVac4Q6hVmgSYO5dOGmn6EbZSQpCj7hFAont5
	 eLMvSORRsxz1qYiueXJGW66vsIwmGG2/B4E1d4IZwpzkm9wHkWS5wF6AD+S+0nprrA
	 B3gYqIWG+hq2gslF9p5b0gxS6FqCmYm5aBchpLFCmolxsEnysleoeynXSL79usyiAq
	 /tNtPoz+icvR2ztiHLT9ABs2OJX4luAEr4805Z+Y3lU4M8xrjucKMU6pgJ6pzF09SF
	 sfa5p54ihp+OaJF+0mnpCZ0Zbc3Kuh12lNDO4O1rdpHxt2aw+cauQv5esqoualClxG
	 v5jlSoNA98eMw==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next 0/2] fixes for "add mptcp_subflow bpf_iter" v10
Date: Thu, 17 Oct 2024 18:21:40 +0800
Message-ID: <cover.1729159086.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Geliang Tang <tanggeliang@kylinos.cn>

There's a building error in v10:

progs/mptcp_bpf_iters.c:24:8: error: call to undeclared function 'bpf_mptcp_sk'; ISO C99 and later do not support implicit function declarations [-Wimplicit-function-declaration]
   24 |         msk = bpf_mptcp_sk((struct sock *)sk);
      |               ^
progs/mptcp_bpf_iters.c:24:6: error: incompatible integer to pointer conversion assigning to 'struct mptcp_sock *' from 'int' [-Wint-conversion]
   24 |         msk = bpf_mptcp_sk((struct sock *)sk);


bpf_mptcp_sk() definition is missing. It will be used in patch 4.

Depends on:
 - "add mptcp_subflow bpf_iter" v10

Based-on: <cover.1729063444.git.tanggeliang@kylinos.cn>

Geliang Tang (2):
  Squash to "bpf: Register mptcp common kfunc set"
  Squash to "selftests/bpf: Add mptcp_subflow bpf_iter test prog"

 net/mptcp/bpf.c                               | 6 ++++++
 tools/testing/selftests/bpf/progs/mptcp_bpf.h | 1 +
 2 files changed, 7 insertions(+)

-- 
2.43.0

