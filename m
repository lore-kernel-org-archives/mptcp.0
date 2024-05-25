Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF073125DC
	for <mptcp@lists.linux.dev>; Sat, 25 May 2024 13:02:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716642136; cv=none; b=PKthGQVj/U1E6uPJUJj4Jt3zGJf782cUXZHiHWs7h0KVY3WjeroaqqaQXSzavyHh3tF2kAUvb/5P9WM0Ec7gJLzbHTh6tXuzq8NByCmQT8l5XFNQ7DsmLO70d3eYJT0kgn3KXlTPMNf6AimmiQDCLjCM/Hne4qJvCKOfLJrCdKM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716642136; c=relaxed/simple;
	bh=VwtA1fKMpe/V30yb8aX665801k5AqRGeTUeScwhzpOc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Hr0dxHnwF5KWhEI+znvvGSjs8RY9BIkUig3Gxu09+DCs4j3MyZwXUch6Y+/lciZV0Rcb79HhfKWy91AvnyplttORJIQ5p36lh4+dcIiTkhw3K70xqMkK01Zx/wcu/ZJQEgy7YMCfR0Yhx32lKOdu6wDb1KiKuI8x14N1X+5ezik=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=i2f+XSIh; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="i2f+XSIh"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 89878C2BD11;
	Sat, 25 May 2024 13:02:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1716642135;
	bh=VwtA1fKMpe/V30yb8aX665801k5AqRGeTUeScwhzpOc=;
	h=From:To:Cc:Subject:Date:From;
	b=i2f+XSIhDWS3QU25DkxvO5/O8Paa7n19bP4eaWm/MleN26p3aohwee7nrwyN+VJkd
	 L6Kv9cIo3vd+16z3SBGj8N86Z25IV5t9pcft2MnnhQbzbcdfU7KwQKfgxrR8YX41sM
	 jN8B9laCsxrzyDvf+oDrEfhqobC+CUaDo7QyMOPa/9DoUQuf1ZdZs8anGz1ceiajWm
	 cUU/mNnY9L6o1URP9FZqSCESeCyTHfo2UL/bCXCpJqp0jizKarWSsdG7MUziLCvLBx
	 fYQDPcWX3Jur5vpD8GH/0cy6HOc1Vz07x3/2pq3UgQtJgP8xo0gx5g4vQ457kVn2fX
	 1IbncUblbKjjA==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next 0/4] Squash to "use helpers in lib.sh" v5
Date: Sat, 25 May 2024 21:01:21 +0800
Message-ID: <cover.1716641976.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Geliang Tang <tanggeliang@kylinos.cn>

Squash to:
 v5, use helpers in lib.sh and net_helpers.sh

Based-on: <20240524-selftests-net-lib-fixes-v5-0-b9e0968571a3@kernel.org>

Geliang Tang (4):
  Squash to "selftests: net: lib: rename ns in setup_ns"
  Squash to "selftests: mptcp: lib: use setup/cleanup_ns helpers"
  selftests: mptcp: diag: add ns name empty check in cleanup
  selftests: mptcp: join: print title at the end of reset

 tools/testing/selftests/net/lib.sh             | 18 +++++++++---------
 tools/testing/selftests/net/mptcp/diag.sh      |  1 +
 .../testing/selftests/net/mptcp/mptcp_join.sh  |  4 ++--
 tools/testing/selftests/net/mptcp/mptcp_lib.sh |  5 +----
 4 files changed, 13 insertions(+), 15 deletions(-)

-- 
2.43.0

