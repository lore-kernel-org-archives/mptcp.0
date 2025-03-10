Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70AAA22EE4
	for <mptcp@lists.linux.dev>; Mon, 10 Mar 2025 03:30:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741577418; cv=none; b=j2ICilwmXU9qvYEBhN2vZyEWZxjmS44Dqh+Gs7WAIRvZ4Oj5oN+13+t/w+UMy2z1WrWwPrFKfS06uX5t08AhgJtfXUI2KcEFDNLR9jxNtqVYicHYZiFVAEcOQdDYcdr/9skYv2lLmGjxNs22MkNHl7hhqFk66iJf67N7ktx0oH4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741577418; c=relaxed/simple;
	bh=KMd+sOlfD+rgmE0SD1GKvFZYuGiBvYGpmysplbAGd1g=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Dq0oN9lD6zRqMAHmPw8UjvyOFQAw5wuujRHovxdGMezV+Jddc9L4braE6uizBmUqbtoQBXNl280MdZTN0IyGsq9pd0yJMcDM5h2M4okPB7krQffCalrTHne0xKgeMN0o1VHG0mz6m+BqikSenidTLer9uBgn4tPVZElCeFqsQ/Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KbNtuCPy; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KbNtuCPy"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CDF52C4CEE3;
	Mon, 10 Mar 2025 03:30:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741577417;
	bh=KMd+sOlfD+rgmE0SD1GKvFZYuGiBvYGpmysplbAGd1g=;
	h=From:To:Cc:Subject:Date:From;
	b=KbNtuCPyvv9TOQK5R8OOpDG7ePwgVBlZl2jUEKaQpsvlx1AUpF/o1LZ6OBjvL6pd7
	 AeWuHrVcTz18SlPD902KPc3RJ69D98q/s1LreiiwTqsWbSebVWF0LGZ4Pq5so6OLkU
	 E0j/2kOpPrd9KJ+TTyys6gQfesjGVHF0Ey3upvFADaHPTBvhmlPhSK3ZMfZjkwT5wX
	 ycNMYYr1eB0JLYLwI0CuOlUz4chwU+tbXh+uWbEBGsS9eLKKZd8lQAWypA7eJuEJha
	 9jEgARlaRGLwB3OvTL3ozuJvGiZ0QCFy/GBkb0+dmInubz/RoJuupHHwh5d49rjlu6
	 f9KncZzYYLmGw==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next v3 0/2] add bpf_iter_task
Date: Mon, 10 Mar 2025 11:30:08 +0800
Message-ID: <cover.1741577149.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Geliang Tang <tanggeliang@kylinos.cn>

v3:
 - add bpf_iter_task in mptcp_sock, no need to add back struct
   mptcp_sched_data then.
 - add sk_lock_sock() and sk_release_sock() for struct sock.
 - set and clear bpf_iter_task for MPTCP BPF Cgroup getsockopt
   and setsockopt.

v2:
 - Keep mptcp scheduler API unchanged.
 - Add back struct mptcp_sched_data.
 - add bpf_iter_task in mptcp_sched_data instead of mptcp_sock
 - Add wrapper bpf_iter mptcp_subflow_sched.
 - Use mptcp_subflow_sched iter instead of mptcp_subflow.
 - https://patchwork.kernel.org/project/mptcp/cover/cover.1741347233.git.tanggeliang@kylinos.cn/

v1:
 - https://patchwork.kernel.org/project/mptcp/cover/cover.1740997925.git.tanggeliang@kylinos.cn/

Geliang Tang (2):
  mptcp: add bpf_iter_task for mptcp_sock
  bpf: Customize mptcp's own sock lock

 include/net/sock.h   |  2 ++
 kernel/bpf/cgroup.c  |  8 ++++----
 net/mptcp/bpf.c      |  2 ++
 net/mptcp/protocol.c | 16 ++++++++++++++++
 net/mptcp/protocol.h | 20 ++++++++++++++++++++
 net/mptcp/sched.c    | 15 +++++++++++----
 6 files changed, 55 insertions(+), 8 deletions(-)

-- 
2.43.0

