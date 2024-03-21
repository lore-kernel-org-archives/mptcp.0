Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38F7AB641
	for <mptcp@lists.linux.dev>; Thu, 21 Mar 2024 03:42:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710992566; cv=none; b=NaGg+j4Y6DupPIxozGVzQrnKswvdvzSShu8bx8bqiCqdKj2o+/kP/YtUhCUvXrzY6fL99Ux/G8fsL7KOJ122EVOOPgvHopyO6X/cyD3ndzn7LR1Rl5OH8/99mRpbqwFAwxggJkYuYtZqgeOHnwk1yxgNTOdYz2QYIs7WKCB349g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710992566; c=relaxed/simple;
	bh=lRI+q3Oic4IDxP8LWm3gvcwBoxr+d8sv4rwfNlENhWo=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=oGjAroCmIITQ47d9Zwc9E3IH0MdLWMuEvWTsCuM2uyjZ1IVSZauGH1ozulbPpJLCgnVy3npu2PqIm6QQJMcYEx+LQpfqBOa5WCcuojfqYWZwd8H6OiO49JAIhHSerBQfMt5sTsaFgdo8nK/e327VFD8EVxG+KuH7O26iY5XWZj8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dctE4hvn; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dctE4hvn"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DD0ECC433F1;
	Thu, 21 Mar 2024 03:42:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710992565;
	bh=lRI+q3Oic4IDxP8LWm3gvcwBoxr+d8sv4rwfNlENhWo=;
	h=From:To:Cc:Subject:Date:From;
	b=dctE4hvndIO4941xcn9gaWMUHEATLiNq0ZgT9jLdWLXQYyZg6L0cOv9vjZkz+tjwi
	 sUn+LMJ9R8XicsX8MGO1L+u1kDa8RijTTfP/FqeXf7aPytQWTl8Q1ybtJxGaw+Asif
	 N2eAhAOt3Zd2df6VeLiZtOknkEQ1oIIDU4AH4JUdu9eIDV5MJsBP71chtugU2nH9+I
	 z64Be9kSiRHqqBc5wyfVMTiKG97/V/6AOUG0mlxzLApPMYycsgwQ9KCqXpSVHHfBQt
	 3EqKe3EBSXTApwtyBFM/+qzz5eL3C1MHkvyBLkF2OeICiRnOm3EuMSVaRiFwBj2NCH
	 W/W2WNE0xv9WQ==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next v2 0/4] setsockopt per subflow: BPF
Date: Thu, 21 Mar 2024 11:42:36 +0800
Message-Id: <cover.1710992399.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.40.1
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Geliang Tang <tanggeliang@kylinos.cn>

Address #76.

v2:
 - fix checkpatch warnings.
 - cleanups.

Geliang Tang (4):
  Squash to "selftests/bpf: Add bpf scheduler test" fix
  selftests/bpf: Add mptcp subflow example
  selftests/bpf: Add mptcp subflow subtest
  Squash to "selftests/bpf: Add bpf scheduler test" cleanup

 .../testing/selftests/bpf/prog_tests/mptcp.c  | 131 +++++++++++++++---
 .../selftests/bpf/progs/mptcp_subflow.c       |  73 ++++++++++
 2 files changed, 183 insertions(+), 21 deletions(-)
 create mode 100644 tools/testing/selftests/bpf/progs/mptcp_subflow.c

-- 
2.40.1

