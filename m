Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B74B71DAC9F
	for <mptcp@lists.linux.dev>; Thu, 17 Oct 2024 10:56:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729162561; cv=none; b=Psl3wOzyVDJAGR2+3EZC/XZTJu48j9urLRcjEUeQ5+tqP9ivgCv882HWhkw6DkIIMKOi0lmC0Yd78j0A//J50xelBFcTKYHd5ksf26TP+mWRscTWVcCwVBSgxHtqOwO+VCwhnAfAhN8F9UhbbtBjHbsa8bpz2zb1YCLMPj6K7eI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729162561; c=relaxed/simple;
	bh=hKQHcwvQPd4LoZMLqmnoTXI6VkLicWJ3JecdnYNwr68=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GqWQb2DzJj0j1m2jcJUwty7Sz+m5kJfyaDEUgARJoQOt4fuaaYRWzP5roLHsihbcpRt4bjnUYu4eWy0w9lywZy2qPVXfRHnF9G6HwbPFm1wLrf/eFK+YB75Wd2OKpjJlgtnmcFAsE6Rd8S8ghrv54QqYFUwwlMCniSdGiUdpe/o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dFLJ7YZ9; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dFLJ7YZ9"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3A6D8C4CEC3;
	Thu, 17 Oct 2024 10:55:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729162561;
	bh=hKQHcwvQPd4LoZMLqmnoTXI6VkLicWJ3JecdnYNwr68=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=dFLJ7YZ96R76Fg/FZ+cW+ooYESvumjPrfywS4JTwft5nXDK6o1dxkDfDrQUHy3oju
	 S7+58jPWZSpp3m7+ylY/EKed1RbYiRWJKJ/6ffMTiuS/y7a2MvrNlboYyelzdI5tnZ
	 k9MymnGhrZb2iD0eIzd1DTb0DpIzzbw6vBZ1iG3YtuTkpfJNWOYb2jkwUkZ8RMztWV
	 zdQnf36jy9zkxKIFCBeWbvMpVNgd4SS32jErSuOjUALOhzDwU7BTuKDRH7AyCQK8yV
	 mDLdP7sULi9U2RV1NWHsIp77kjrpZoyPaX4Hl2++u+T+fxC+t86dEvTbcrwMUB367p
	 +JOIv4GlmLTJg==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next v2 3/3] Squash to "selftests/bpf: Add mptcp_subflow bpf_iter subtest"
Date: Thu, 17 Oct 2024 18:55:32 +0800
Message-ID: <5c6243ea7e2429c75ff2cba228416194601d7ae6.1729162349.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1729162349.git.tanggeliang@kylinos.cn>
References: <cover.1729162349.git.tanggeliang@kylinos.cn>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Geliang Tang <tanggeliang@kylinos.cn>

/home/tgl/mptcp_net-next/tools/testing/selftests/bpf/prog_tests/mptcp.c: In function 'test_iters_subflow':
/home/tgl/mptcp_net-next/tools/testing/selftests/bpf/prog_tests/mptcp.c:546:13: error: unused variable 'err' [-Werror=unused-variable]
  546 |         int err;
      |             ^~~
  TEST-OBJ [test_progs] pe_preserve_elems.test.o

Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
---
 tools/testing/selftests/bpf/prog_tests/mptcp.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/tools/testing/selftests/bpf/prog_tests/mptcp.c b/tools/testing/selftests/bpf/prog_tests/mptcp.c
index 6644fdaa10a5..7282e98a8f51 100644
--- a/tools/testing/selftests/bpf/prog_tests/mptcp.c
+++ b/tools/testing/selftests/bpf/prog_tests/mptcp.c
@@ -543,7 +543,6 @@ static void test_iters_subflow(void)
 	struct mptcp_bpf_iters *skel;
 	struct nstoken *nstoken;
 	int cgroup_fd;
-	int err;
 
 	cgroup_fd = test__join_cgroup("/iters_subflow");
 	if (!ASSERT_OK_FD(cgroup_fd, "join_cgroup: iters_subflow"))
-- 
2.43.0

