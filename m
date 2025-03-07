Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C8892153D5
	for <mptcp@lists.linux.dev>; Fri,  7 Mar 2025 11:39:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741347562; cv=none; b=mCyQdn/shmUAe96dACvhYmwkvm13YPDhrX7APtHXv+35TxDjLG/t69BJrzgR4uHeMQryEnoKPEgVmlADStSMMGirA8Wjb+jbXEelb4mtUG1LyEmOYGrRzrbKpQ+lxVdswWcyybR4CHJ3H2BQ8BEqKWRUsHMzlHta/5iYtSh7Q8E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741347562; c=relaxed/simple;
	bh=KMtpRp50sQb4DzL91pgPQ0UxDIDygE67dyTRJPWIqHE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=fmjm08BoRwW66nIskRQTWjA+dXyj3/fPVMuQvb3MrRpKlooY213PcDhBS/E3c0FF4tQcN1IWpZP5JVwPrSReIPCrgthDuXUmRfomWQbyzNGh9hzeMapRDwB0HFi8iPu5iq/3jSpNJhxu7Mj/jbmY+8eXVeZ6Cc83HLGgji+NH2M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Q4tzC1oF; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Q4tzC1oF"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EF918C4CEE5;
	Fri,  7 Mar 2025 11:39:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741347562;
	bh=KMtpRp50sQb4DzL91pgPQ0UxDIDygE67dyTRJPWIqHE=;
	h=From:To:Cc:Subject:Date:From;
	b=Q4tzC1oF85JaqmbOHgpNKQFJkitMTK/HS90Z3FmRb9IG1UOaKWDndjQ3eeUaXjnDh
	 SNDxdX6/hj0+G5ojIFPwTK3yaO8Usang157cc9QBIJPWKYQ0aQAtq6QvjcfLrUgLqZ
	 /2lCSDmgrbvTxLOVE+qIdNSIl0vLSwClmzDLAPEoUxLbLUC1tJrXsJTUqjrfgc0ac6
	 9LSMBv1NrSoFr0WCzAraNx4qVMCJCAUt0+1WyfnMGcbDkLacNhKcr3wvcavIkc7y3s
	 7IPqvrm4b48hVUa93hZd/WJWy17SPuquajQWUuYBHV4Fxjbs8UtqN9nDJd/FDlkwBI
	 0t8Wy4p+UdFdQ==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next v1 0/2] cleanups for BPF PM part 5 v10
Date: Fri,  7 Mar 2025 19:39:13 +0800
Message-ID: <cover.1741347453.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Geliang Tang <tanggeliang@kylinos.cn>

Two cleanups for "BPF path manager, part 5 v10".

Geliang Tang (2):
  Squash to "mptcp: sysctl: set path manager by name"
  Squash to "selftests: mptcp: add path_manager sysctl tests"

 net/mptcp/ctrl.c                              |  6 ++---
 .../testing/selftests/net/mptcp/mptcp_lib.sh  | 13 +++++++++++
 .../selftests/net/mptcp/userspace_pm.sh       | 22 ++++---------------
 3 files changed, 20 insertions(+), 21 deletions(-)

-- 
2.43.0

