Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E64E5211276
	for <mptcp@lists.linux.dev>; Fri,  7 Mar 2025 11:36:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741347420; cv=none; b=QiRbSeJFzCkzBbUdcU/mB9qYyVJnJnV/OvNw+ynjnjIgFEWEN6Nu+mN1oMKPBsnyAbWNT+msB9Zo6OdaMZ5YxJu9PEv0z0O5NV/WGQiPj8TLMVHTYbE1Hu/rvv8OC0U3etlsv4xeNsLpSyDcbeJOng0r0gv8Yc46OO1WfcHXV2s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741347420; c=relaxed/simple;
	bh=lW94eREPLPJSib5+FoNdZYjIEsjgXUHQP6hPFbVCEQM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=NtX/ImJy9PUFtd55qBxoJO3rjImlTYKFTCSWv0qZcLO37qrI3Eah12KA/x6bPg9Pbpek2u4FcYYwPWefemmvCD6Kkj8czWBGWaF18YtZ6y6/tKu9+FWZ4zAt5UZcfiDcYoqE5UvS/Ym1z6mjjpG5NcPZv86KKHe4/zsoiK/V2KI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=X4PKbMFQ; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="X4PKbMFQ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3415DC4CED1;
	Fri,  7 Mar 2025 11:36:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741347419;
	bh=lW94eREPLPJSib5+FoNdZYjIEsjgXUHQP6hPFbVCEQM=;
	h=From:To:Cc:Subject:Date:From;
	b=X4PKbMFQdP+LXhS1dKLTWmX3qziDMdm+1ZEqK+zODG/8c8oNpqRaa8+1Tf2dfiQGV
	 ZuQ9uD3F+wDmH0nSdTF+6q7zBfSp3e87wH4m/Y3Wp9b9NhGkjkQR0v58HqnoEcjtxc
	 An71BzD9diinQ10CTiXHvLCQBRQmkp4mkJhMi582GmALMnczsk4dMpiUgm34VEJMWb
	 WsqGLwB8L5ZkXc2tSNLVBhxF1bLoKgtmAa3tK407XKoh3WbWITEdK3JuyK/wxMbni9
	 JgjmdaWRLym4beH5Hxy0CZNIabByhwG3YMhQ+185JWZxOry83EI5UWc0ImhzeGmqt+
	 Has1VDGdMTCkg==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next v2 00/11] add bpf_iter_task
Date: Fri,  7 Mar 2025 19:36:41 +0800
Message-ID: <cover.1741347233.git.tanggeliang@kylinos.cn>
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
 - Keep mptcp scheduler API unchanged.
 - Add back struct mptcp_sched_data.
 - add bpf_iter_task in mptcp_sched_data instead of mptcp_sock
 - Add wrapper bpf_iter mptcp_subflow_sched.
 - Use mptcp_subflow_sched iter instead of mptcp_subflow.

v1:
 - https://patchwork.kernel.org/project/mptcp/cover/cover.1740997925.git.tanggeliang@kylinos.cn/

Geliang Tang (11):
  Revert "mptcp: sched: remove mptcp_sched_data"
  Squash to "bpf: Add bpf_mptcp_sched_ops"
  mptcp: add bpf_iter_task for mptcp_sched_data
  mptcp: set and clear bpf_iter_task
  mptcp: add mptcp_subflow_sched bpf_iter
  Squash to "selftests/bpf: Add bpf_first scheduler & test"
  Squash to "selftests/bpf: Add bpf_bkup scheduler & test"
  Squash to "selftests/bpf: Add bpf_rr scheduler & test"
  Squash to "selftests/bpf: Add bpf_red scheduler & test"
  Squash to "selftests/bpf: Add bpf_burst scheduler & test"
  mptcp: drop subflow contexts in mptcp_sched_data

 include/net/mptcp.h                           | 10 ++++--
 net/mptcp/bpf.c                               | 34 +++++++++++++++++--
 net/mptcp/protocol.h                          | 19 +++++++++++
 net/mptcp/sched.c                             | 31 +++++++++++++----
 .../testing/selftests/bpf/bpf_experimental.h  |  9 +++++
 .../selftests/bpf/progs/mptcp_bpf_bkup.c      |  5 +--
 .../selftests/bpf/progs/mptcp_bpf_burst.c     | 10 +++---
 .../selftests/bpf/progs/mptcp_bpf_first.c     |  3 +-
 .../selftests/bpf/progs/mptcp_bpf_red.c       |  5 +--
 .../selftests/bpf/progs/mptcp_bpf_rr.c        |  7 ++--
 10 files changed, 110 insertions(+), 23 deletions(-)

-- 
2.43.0

