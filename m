Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D75EF17DFFD
	for <mptcp@lists.linux.dev>; Tue, 10 Sep 2024 08:53:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725958431; cv=none; b=Ir0jUkwx8ivujThQODbhBH5uaLLs48XWEPPZX8BJzr7iaVtzrfEMJs4139BSK09hiBVX5m51nelm7paSrGN2iaI4HSyLoUVQeUnqogz3rsiuEbRVdRdeFWape2+OtwnwiC4yaG7Yo0Fh3zDFKJm94X/D2T4FmOgtgosCbL3Uses=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725958431; c=relaxed/simple;
	bh=lZuyDp0S5MUti0chVUFZ7dICXqgAB0rn6gspLODNbNM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=hG9/lWMrneVJOp0Pv8PUitgBgTW7bN6+EWe2TNQTrureqd+Vgot0Fu5i+Mfe47B8G9k7HXG0mNrqe6F6pGnkHBWtKCGPR+o9+E9DMQ76yGlHvbVOSBog9bn8JVlIizoEDMkxFUTiE6Eb76s7qAfpyg+l9jbB5/rnf1eqrDfJUKA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ILJkF17t; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ILJkF17t"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2AFE1C4CEC3;
	Tue, 10 Sep 2024 08:53:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725958431;
	bh=lZuyDp0S5MUti0chVUFZ7dICXqgAB0rn6gspLODNbNM=;
	h=From:To:Cc:Subject:Date:From;
	b=ILJkF17t52cH5XJj5Ot742kSzZ7EXXIyeHeOkhaLtYOeeSm7paoHyWKj9QQorelxq
	 soOViP4icR+4Ev/c8i7Kw2BOAYlYHoA449+rdlDSWhYyelu1ABHOPbCBU5kKVfHfAW
	 nhw3BMt7AbsYVHkazy4KZ9XVs71Ir4FmLMZabDrSqluYzdbL2LEBvKrFIMuZ7b6Zfz
	 ihevtg3VrKKRv2j4aPM6QxmDpL806/Sa/5luTy9M328CnYh5puV6qBks6F+uTvxz+B
	 srC00FJn6raeOBdHvHt9shhCDA14GJz8OK56/2sRkHJ7D/C8xmL+eXO3gbaqPQm4y6
	 MwAS2NI1tObkg==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next 0/2] "add mptcp_subflow bpf_iter v3" fixes
Date: Tue, 10 Sep 2024 16:53:40 +0800
Message-ID: <cover.1725958296.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Geliang Tang <tanggeliang@kylinos.cn>

It's better to register mptcp_subflow bpf_iter helpers in common_btf_ids
in kernel/bpf/helpers.c, not in bpf_mptcp_sched_kfunc_ids in
net/mptcp/bpf.c.

Geliang Tang (2):
  Squash to "bpf: Add mptcp_subflow bpf_iter"
  Squash to "bpf: Register mptcp tracing kfunc set"

 kernel/bpf/helpers.c | 5 +++++
 net/mptcp/bpf.c      | 3 ---
 2 files changed, 5 insertions(+), 3 deletions(-)

-- 
2.43.0

