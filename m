Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C152EC5
	for <mptcp@lists.linux.dev>; Tue, 11 Mar 2025 09:32:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741685559; cv=none; b=uTzcTKUSNp8vz4rFM0+I+nq1EJcg0fqnzWvFg6XAOjNYbOR+WWGFnHhbWGXFexlW2TvHHiYcxhSBb0rho1P6NuEJefoifUp8lFxV8O/kzYwxYj/ba0OUFyqhEmV9u7vGoumTboMRAp5f13BxXnF1ieYdHZFFWnKUwLaCD2d+SV0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741685559; c=relaxed/simple;
	bh=KpA57v+PEYNG8VaQUU/wgOjrFYAy12n/e1yy/BuJeuM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=daN466AHU/laNLBULKB/s+go+A9nMYwODDNR+0O/SicHzXf/CAiM5wTn4+vqIwgts9DCZvl+HLc5d6+vxwjNtto/n4C1I0zXetd3VvLlvuocLypsbKb1sK5vq5ITuXxbpEMhocGImw9hTj9vNizWQ1qbWpPKoc8+rbUUbSITy50=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=A7IpLrGV; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="A7IpLrGV"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A4BA9C4CEE9;
	Tue, 11 Mar 2025 09:32:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741685558;
	bh=KpA57v+PEYNG8VaQUU/wgOjrFYAy12n/e1yy/BuJeuM=;
	h=From:To:Cc:Subject:Date:From;
	b=A7IpLrGVl1t/Iw0syDXLGv7uaqN1YrvWSm4DtyMoUDJ1EoWdaCVGjA/+FoerjpPYl
	 AxwrzBZqH3yxx5YeNtr6kTQ8E9NFpkFGTBMcaCIu0Unq28qtqIxhqN439oCk1voVaX
	 h4OlnJig1C/8DZrhcqfEgTrM+5guUYX/BJRiWZRTs4gNEp5GGgyTJ4YvgHts9Pv+j+
	 f8ZsOfXm6IJBCyTlsq7ZUE+BNpHsBnJlrbL8gZxUvuFSRiPRoFLoWBMfTRvIB6bc8L
	 bOgL7i2tTrFEY/5aTUaU8UjX0aoXtQVyCIGHpR+Z7blHEfZL3BZDWf8jjxf2mfr6NW
	 KM8dWnki6oLKA==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next v1 0/6] BPF path manager, part 6
Date: Tue, 11 Mar 2025 17:32:24 +0800
Message-ID: <cover.1741685260.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Geliang Tang <tanggeliang@kylinos.cn>

New interfaces for struct mptcp_pm_ops.

Depends on:
 - BPF path manager, part 5, v11

Based-on: <cover.1741674285.git.tanggeliang@kylinos.cn>

Geliang Tang (6):
  mptcp: pm: add allow_new_subflow() interface
  mptcp: pm: add accept_new_subflow() interface
  mptcp: pm: add subflow_check_next() interface
  mptcp: pm: add add_addr_echo() interface
  mptcp: pm: add established() interface
  mptcp: pm: add subflow_established() interface

 include/net/mptcp.h      |  11 ++++
 net/mptcp/pm.c           | 105 +++++++++++----------------------------
 net/mptcp/pm_kernel.c    |  74 +++++++++++++++++++++++----
 net/mptcp/pm_userspace.c |  47 ++++++++++++++++++
 net/mptcp/protocol.h     |   2 +
 net/mptcp/subflow.c      |   4 +-
 6 files changed, 155 insertions(+), 88 deletions(-)

-- 
2.43.0

