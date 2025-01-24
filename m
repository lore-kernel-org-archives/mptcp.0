Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C4A021A433
	for <mptcp@lists.linux.dev>; Fri, 24 Jan 2025 10:28:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737714529; cv=none; b=bmS3S2plYiHZOMiITszyDiHQK5yIhYy+XmpjXXrpF0KKslk3i9aDndWVO3vE9seP82fj1yxSJU4OGAmtBKPeI3s914BRyU93SADQdYik3zKrCHC4uT4vDncGw/4CFEVaw0cF3mzLLrhDH4R+iEMEb0Ppjr9syqdLQK2LvHn8KVI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737714529; c=relaxed/simple;
	bh=PRh85fZ7mTqn82hnHl+fgoM7hEE2gag0b+5NO+M4Y/M=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=tjlJYyQKq/O4uJRMrZJQNzai+IqGUrPH2heA9Z88A2kt4NEXGSZ+/YFkAAv4un0eZh/S4sONWtzwRREBN2Ctal5mWRLhWxA4P6YCPKRPpnL9q//hGviCY0rXdQSHvEHPU87jPYPMSr8+ithptf4L62CbpXtvu6jDM6YFg9iE3Lk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DCEBve4G; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DCEBve4G"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3A503C4CED2;
	Fri, 24 Jan 2025 10:28:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1737714528;
	bh=PRh85fZ7mTqn82hnHl+fgoM7hEE2gag0b+5NO+M4Y/M=;
	h=From:To:Cc:Subject:Date:From;
	b=DCEBve4Gi0a0spzp23lG3sNkubr1YezNTuaxgmxmSk4zOOMisB70dLqK1l1VrpsXk
	 Qcb78vLkPlQmi1fgSWW//THPkMDDRg9cGXIEr/YXhUZ+BLnMpAR57lROq2VA8+FE06
	 XUrbEq6kD4UtkAi+op3Wafgf9/Vrje+xqTXhHJYfyhTDJagybCEeNPFkBGplXazY5s
	 7TYuNFJLZ7kSkpJo9dV5h+wY0I8bRi6Q9Qll+FdHJhKHocIgSnSBk4WpRUaVpZnykQ
	 BGhIS+yLxsfeWCyE6FGeIvvBjJtnQ/f8mA6ydmFb/n7lu6EvXJHBmwHQKnfgyVJqj2
	 ybW/Dz1XkJkYQ==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next 0/3] Squash to "Add mptcp_subflow bpf_iter support"
Date: Fri, 24 Jan 2025 18:28:38 +0800
Message-ID: <cover.1737714424.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Geliang Tang <tanggeliang@kylinos.cn>

Address Martin's suggestions for v2.

Geliang Tang (3):
  Squash to "bpf: Add mptcp_subflow bpf_iter"
  Revert "bpf: Acquire and release mptcp socket"
  Squash to "selftests/bpf: Add mptcp_subflow bpf_iter subtest"

 net/mptcp/bpf.c                               | 34 +++++--------------
 .../testing/selftests/bpf/bpf_experimental.h  |  2 +-
 tools/testing/selftests/bpf/progs/mptcp_bpf.h |  3 --
 .../selftests/bpf/progs/mptcp_bpf_iters.c     |  6 +---
 4 files changed, 11 insertions(+), 34 deletions(-)

-- 
2.43.0

