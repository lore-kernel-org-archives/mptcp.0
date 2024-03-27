Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BBD5364D6
	for <mptcp@lists.linux.dev>; Wed, 27 Mar 2024 09:01:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711530119; cv=none; b=LP0DSnVheJbAvAu5zxD6cveP6pJO1EyWnB+bdaCmVas3SmrG2hvZIvYZEBiSocQe0cp0IQLh1Y8FiGP9Q06C1k2L6cShfk5fkMqzzK8SPwAfLj3OEXzsmBC0IFxaril/d1WcnLyjecMn54a0ZMYOQuJNzCLWwByzKqw1Fbw8clg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711530119; c=relaxed/simple;
	bh=ghzdqCt7rkhMOEBHj43mdLUn48JKN+BP101ffp7CaWI=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=iv62RI7dSTuWqz+IbPpvSpC7zfo8WeYyYCJr5M88anQuJnd3OsUrS5iZbHXEqL7xILIKzx4T4kcjsx02VkJLNAdT8XuRvtkNOumw80b6Lkt0IIoEn2nNrPPiOtRv3CyXzekb71fDdPIAZSJ0FxRb+s/yXEgaoybIP8z/XlNYVQk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=d2AozeZj; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="d2AozeZj"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BEB18C433F1;
	Wed, 27 Mar 2024 09:01:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711530119;
	bh=ghzdqCt7rkhMOEBHj43mdLUn48JKN+BP101ffp7CaWI=;
	h=From:To:Cc:Subject:Date:From;
	b=d2AozeZjLd0rsAHi9j99AR/mtrHK9brF6Pk/qyowXr53bpQ95xAT55zAqgeWYIi8y
	 vGlJvptKR9yUM0dwWZnpGaKlpO0kYM/QibcOV9kmULphsWTIDs0Z5Qt1XOe8QyCzDT
	 0lz6iFhf8Wlp4ahbbsREgUJVbIFbibHciWSWBTIGnOTtI1ItUTgCKJHEjv4RGhypI+
	 YD2hg4P03tH3KK9o46TFNYKBvB1nrYoBh99VvxmjiXJb5FyR4L/R6nfjNjgXQb7bpr
	 oOZe9vDgXPEAKv1rRuZr6DRHULOf+3rzlZCAKqTfrP1WIqWLx5kNpKa4O4jwT92c7Y
	 9AYDEgprFze9Q==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next v4 00/11] setsockopt per subflow: BPF
Date: Wed, 27 Mar 2024 17:01:38 +0800
Message-Id: <cover.1711529752.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.40.1
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Geliang Tang <tanggeliang@kylinos.cn>

v4:
 - #1-#5 Address #76: add a new macro RUN_MPTCP_TEST.
 - #6-#11 Cleanups: add send_data_and_verify and SCHED_TEST.

v3:
 - deal with EAGAIN.
 - add _ss_search helper.

v2:
 - fix checkpatch warnings.
 - cleanups.

Geliang Tang (11):
  Squash to "selftests/bpf: Add bpf scheduler test" fix
  selftests/bpf: Add RUN_MPTCP_TEST macro
  selftests/bpf: Add mptcp subflow example
  selftests/bpf: Add mptcp subflow subtest
  Squash to "selftests/bpf: Add bpf scheduler test" - cleanups
  Squash to "selftests/bpf: Add bpf scheduler test" - add
    send_data_and_verify
  Squash to "selftests/bpf: Add bpf_first test"
  Squash to "selftests/bpf: Add bpf_bkup test"
  Squash to "selftests/bpf: Add bpf_rr test"
  Squash to "selftests/bpf: Add bpf_red test"
  Squash to "selftests/bpf: Add bpf_burst test"

 .../testing/selftests/bpf/prog_tests/mptcp.c  | 381 ++++++++----------
 .../selftests/bpf/progs/mptcp_subflow.c       |  73 ++++
 2 files changed, 242 insertions(+), 212 deletions(-)
 create mode 100644 tools/testing/selftests/bpf/progs/mptcp_subflow.c

-- 
2.40.1

