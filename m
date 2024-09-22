Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1520F1917C4
	for <mptcp@lists.linux.dev>; Sun, 22 Sep 2024 01:00:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726966832; cv=none; b=iR1Yc4sb24KF55Bf3eHge6lO7yNcKsfpgrcLhrQ65W21A47dt46KDygksDvnXyldH2H/b+DI0vptsI4xtcx63wMnMQFUL5oppSvCKeTQY/QGktt6cQ1/NftKiE6Oai0EOcxgaeoRYkNYa6gCF/n2ilhMqr5WMgDOa/D51Gfamzc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726966832; c=relaxed/simple;
	bh=a/dEE3hWPns0fAy4xKHVzFrtUeO5JjhQE+pm1ZNq8tI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=h2RM3BWGxoOUxJNd8HaZ4dh7kLG4x5LpW7SB21dfzPyTipdOg4iMwsbzexQqRj7OjiEStdDyujv4r9jF8/90MV40R1YRgGJsrBvdokKylCqoFSWOb6SuEePJnkhe8Mi8Sm+FZvFRYaphlhz/+NELsblSivXr4f/WPt7pmFs26Mw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=R1/8YiGU; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="R1/8YiGU"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 76972C4CEC2;
	Sun, 22 Sep 2024 01:00:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1726966831;
	bh=a/dEE3hWPns0fAy4xKHVzFrtUeO5JjhQE+pm1ZNq8tI=;
	h=From:To:Cc:Subject:Date:From;
	b=R1/8YiGUCk5gjBePmnoD04IKDddm7kQlguXHtuJdNnaMon0dYHwruh0i7yDVRU5jh
	 8WOKmFdJIZyxMMd5zyOPF9crC968zRe1B0986ELb/i0fWo5j5Qv6V945m+8l1EOFQo
	 ZQnJDdgx5egDD4LYE4JkGy6/ej+EnzsrJamMonnL7QDAZ9koXxINgO+H4igmvDvBGJ
	 17dMdqivQ+Ye/wlluwN0POcRBKnAID3xwZ2NGmueB0S/bI0khIekDUjufXw9dbARxT
	 EDGA4YAIEogQ4GDhvcJxRc8il0S+aAMCNWbFhKz2/oc1kOvndxjvb6x4eyzzh4cxSo
	 K2azS15xsG/JA==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next v3 0/3] fixes for "new MPTCP subflow subtest v6"
Date: Sun, 22 Sep 2024 09:00:23 +0800
Message-ID: <cover.1726966638.git.tanggeliang@kylinos.cn>
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
 - update endpoint_init
 - squash 2-3 into one
 - drop 5-6, they will be sent in the next series.

v2:
 - two more cleanups, 5-6, use __bpf_kfunc_start_defs/__bpf_kfunc_end_defs
 and drop the declarations of __bpf_kfunc.

1-2 address Martin's comments
3-4 cleanups for endpoint_init

Geliang Tang (3):
  Squash to "selftests/bpf: Add getsockopt to inspect mptcp subflow"
  Squash to "selftests/bpf: Add mptcp subflow subtest"
  Squash to "selftests/bpf: Add bpf scheduler test"

 .../testing/selftests/bpf/prog_tests/mptcp.c  | 58 +++++++++++++------
 tools/testing/selftests/bpf/progs/mptcp_bpf.h |  4 +-
 2 files changed, 41 insertions(+), 21 deletions(-)

-- 
2.43.0

