Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6286C18633
	for <mptcp@lists.linux.dev>; Mon,  9 Sep 2024 01:55:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725846938; cv=none; b=hPOcLvz0Y2MZD6uVASGAzDhoANXGu5Tais3Ojcin1k/hvk6KA2dBmEIti1YB5xoC5yMv8ZY9XlNvJzwvKS3v3ydE8Cai4+7qrm0133AzzmCABMqj1bimUDzHRuh1BAq6XkeiC+XV3OTMMeRmFnZ2gayUIfSITpyeQmK0eh/5U9c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725846938; c=relaxed/simple;
	bh=sExh27lvS89OeIyNjtDADooUaJ5CuIMoFPpua+KLf5Q=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=hHZ6d5PCUPnulL8Y2lGvnEK4QyXR2QsD+AWXrRnxuCE8vtLieHj8RpHtGe8sGagYdDFWEW60wbwcdalxFsT+R73JXmQSOO+axMpkc7CsPsSaO5v6VNi2KlD1/3HOBzNewhvF8ICrzmWB2/foFCs1rytbhjCnfa0FzcZUhSZLpuU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=stTxxKaf; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="stTxxKaf"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 870B8C4CEC3;
	Mon,  9 Sep 2024 01:55:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725846937;
	bh=sExh27lvS89OeIyNjtDADooUaJ5CuIMoFPpua+KLf5Q=;
	h=From:To:Cc:Subject:Date:From;
	b=stTxxKafGAxdwTxIe6vvYxGEnbjM9HVyaTl8Yxqc6DvRFbkTzsAqUZ1FFeMTy8JUi
	 kIr3b5Kh/YTyxkfZrDnPR7t4Vp62BWsMY+O90CXepNufDC5tcckKh3ULgOyqdMUnQQ
	 K17faVLkBPMGKk/2P4cNLRomPNEKAY3VJ76Lmp+G94UBYEwKFB3EEl11STFSZhhHmU
	 5GVmGmAxUuN8qIYLlvukZquSlTmE4plENiwIJ3aTdzqJZKyXx6xaZESaM10noqyLP5
	 WECRDVSeiKBQjLCvuQaGj5O3u9O4lVDe0ZMD3/PBVPHipYyP3Tq5eWm7gxFhNjA8HC
	 R0GXJpnGgpzag==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next v2 0/4] cleanups for bpf schedulers
Date: Mon,  9 Sep 2024 09:55:28 +0800
Message-ID: <cover.1725846806.git.tanggeliang@kylinos.cn>
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
 - include two more squash-to patches into this set.

Two cleanups for bpf schedulers.

Geliang Tang (4):
  Squash to "bpf: Add bpf_mptcp_sched_ops"
  Squash to "selftests/bpf: Add mptcp subflow subtest"
  Squash to "selftests/bpf: Add bpf scheduler test"
  Squash to "selftests/bpf: Add bpf_burst scheduler & test"

 net/mptcp/bpf.c                                     |  3 ---
 tools/testing/selftests/bpf/prog_tests/mptcp.c      | 10 +++++-----
 tools/testing/selftests/bpf/progs/mptcp_bpf_burst.c |  5 +++--
 3 files changed, 8 insertions(+), 10 deletions(-)

-- 
2.43.0

