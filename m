Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9531510E9
	for <mptcp@lists.linux.dev>; Sat, 14 Sep 2024 08:59:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726304376; cv=none; b=CjPoRjFKDGyFSefJZgOEXm2oHIRXacGzHx9burDJubXbVwL63JNlgQu0P0DTkMGNBvGOE7oJVJtSGS3gOdTscxKEpQbqUdfKzJhPHRq2W+ZVa7lnmPe5dkY7AKFNMqKl0oUUGeuXJB+2OgpZWLtKVpWa1DwVoTFJTVu7wLQzCno=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726304376; c=relaxed/simple;
	bh=gL7f/a0zhOCZp5YlmX3uebNTtduVJMmEMSpJHT8hH80=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=gVLtXoA9RIODWHHkBCURoRRciAYwINjjqFaZpXR2GWZJsDOoZw7tpdA1lcv8QWHtN2F8ICKtw9/6e6ptcWH8Xdnr2OO6VSNgUMyiL3XoolneAR+4Kxb2tnTrIxoLQtdEIIdePD4ZTI7HMaJWtE3tLy8gCBi7pl+f8w4ihuEy+iY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UlPrXzLT; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UlPrXzLT"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E69CFC4CEC0;
	Sat, 14 Sep 2024 08:59:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1726304376;
	bh=gL7f/a0zhOCZp5YlmX3uebNTtduVJMmEMSpJHT8hH80=;
	h=From:To:Cc:Subject:Date:From;
	b=UlPrXzLTVj+MXgT7ogkAjgYwlVMpGeSL9zYq6CDq/na37tkv690RrpyNFAXfQ9D9s
	 Y1FnrMlgrEE6R0hPh5/vVr+cDydMvMS90AAAa7I1BEiNf6TCLNLbgb4AkKNkkoyC0l
	 4DSMoPnklcna8uVRQka4G/76o8ewjZqwxcPbJNcjntrxeXyYvuGElMFbGvBjjq6cNv
	 ZvS/Qm9T1vAfqwTEAEb2L6Mb3CjdHvQUnnhJbpo26fpcnkzzvBqa8CftAUH4UtvUYJ
	 QV2rbmmJF1/VvEfNDCoPFy/GMOKFU7Rk3MI9ZwcR5mL/xawEcy212y7vHf4ynF2ntf
	 mFsJF+CA9WMmQ==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next 0/4] fixes for "new MPTCP subflow subtest" v6
Date: Sat, 14 Sep 2024 16:59:26 +0800
Message-ID: <cover.1726304196.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Geliang Tang <tanggeliang@kylinos.cn>

1-2 address Martin's comments
3-4 cleanups for endpoint_init

Geliang Tang (4):
  Squash to "selftests/bpf: Add getsockopt to inspect mptcp subflow"
  Squash to "selftests/bpf: Add mptcp subflow subtest"
  selftests/bpf: More subflows for endpoint_init
  Squash to "selftests/bpf: Add bpf scheduler test"

 .../testing/selftests/bpf/prog_tests/mptcp.c  | 47 ++++++++++++-------
 tools/testing/selftests/bpf/progs/mptcp_bpf.h |  4 +-
 2 files changed, 32 insertions(+), 19 deletions(-)

-- 
2.43.0

