Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D6E42E739E
	for <mptcp@lists.linux.dev>; Fri, 26 Jun 2026 07:16:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782458188; cv=none; b=O6Tnhx6YapNlINREwMpsU/wvrUbF9WJJoMDWfV8opqVImJQcWmj5/N2wkoAikUc9KHj0bjvNNGYuzxMMwj8YSKXnFYimv8ixb+nr9rCsSpE/YtYrqpb0VWPjoVdO3J3c8RZ932MXol/oqQm+YysYT4rlJkz47dVd5FuJnE3QIJ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782458188; c=relaxed/simple;
	bh=PN53wKCJ92zomzwbYF+NXsT/3+O8bzAarty9I+RFOms=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=H1nN/PUncGOeyb9i3+powhNh9S7y1EMAfjBlLU28vWYhLfnhhkipEOqsSAayQK9SFRqzaPdzxueK9Qq/J4Dl53AfZgrbJfWXc3mdXdgMADnCx6YGGWSBnVxHWgX5M3WaQKh9N6zUvZ3H0Vz1d5AB5NxJ7yMkdcT/RgBzQDzShxg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RZIsXbu0; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RZIsXbu0"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 987581F000E9;
	Fri, 26 Jun 2026 07:16:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782458186;
	bh=+Mmh9D5G/sdiUT7cyCbi75W9QLmjXZbopIaycw1GdTc=;
	h=From:To:Cc:Subject:Date;
	b=RZIsXbu0FfZC15tnAtDxNEKeiIZgIT3p05YK+Qmfji6iGW7tUt++6wn2YvBhUfqd0
	 aniKkhvM2c4amFtiTxz2yhedjw20FLwfHr1Djer2aArQdiuEFkR5sJaFYEuLnBwCDO
	 7Uu2lk5D+JUG4MoPD3B4VIP3ZHcKjfey6AfwAgE81tP4IEfoJJuHJLvavFJCMcQ7t0
	 Ym+BzQxZUFuja0u4+ZH1s5poyzLo2aHi3SHHLmiSsdnQWDZ+Y1rccuY2OezyoYAm9n
	 nWIpfqnRDi/Kl50HKuCBLNHh3PI7RJ5F3yMvHI6eCz6RTT0pW8jocj33p+SU9RSABt
	 ZsxRwjBN3yRvA==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next v5 0/3] only remove entry from local_addr_list when sending a REMOVE_ADDR
Date: Fri, 26 Jun 2026 15:16:15 +0800
Message-ID: <cover.1782457962.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Geliang Tang <tanggeliang@kylinos.cn>

v5:
 - rebased.
 - add Matt's reviewed tags.
 - add a RM_ADDR from the server to the client as Sashiko suggested.
 - mptcpd tests (make check) are still OK after this modification.

v4:
 - rebased.
 - Link: https://patchwork.kernel.org/project/mptcp/cover/cover.1776466833.git.tanggeliang@kylinos.cn/

v3:
 - update userspace selftests.
 - Link: https://patchwork.kernel.org/project/mptcp/cover/cover.1744787273.git.tanggeliang@kylinos.cn/

v2:
 - squash patch 1 into patch 2 as Mat suggested.

Closes: https://github.com/multipath-tcp/mptcp_net-next/issues/403

Geliang Tang (3):
  mptcp: pm: userspace: drop delete_local_addr helper
  selftests: mptcp: join: update userspace dump_addr outputs
  selftests: mptcp: userspace: send RM_ADDR between server and client

 net/mptcp/pm_userspace.c                      | 35 ++-----------------
 .../testing/selftests/net/mptcp/mptcp_join.sh |  6 ++--
 .../selftests/net/mptcp/userspace_pm.sh       | 16 +++++++++
 3 files changed, 21 insertions(+), 36 deletions(-)

-- 
2.53.0

