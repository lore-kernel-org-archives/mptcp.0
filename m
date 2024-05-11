Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02DA614269
	for <mptcp@lists.linux.dev>; Sat, 11 May 2024 12:42:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715431376; cv=none; b=gVF/Isg266pZ5AqUH9tAyTemLmv34V4aox1BHmcPo7KIJVxEKe3rf/PIxfz8/+kGxrh9kksnBKAeDUj7e3reNfGnGTNQL21n9XBhu4GjeqNQ+lHZl0suJ/Abai3t0uiO84ss4R8Z/ypMF7//UMkKVd+RdERsYYpOXc4y5Pei2m0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715431376; c=relaxed/simple;
	bh=nelWJBPy4bioqX976VDUtk31Rk/u62XeVCGF5TAISv4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=FKYOEzmSRo7FwLaw8lnjQygI774kkxy+ehXQSypCbE8DjDpm8fDx5xiwSv1Su8J6SwRHMF9GPS036D5SIOD7x13tHcMhm6xv9Mv4gM7gVOE3Pr7MVYPGtd/hpcJqPi3QhP5dWPggtVZUgWJL+/Mz2PrEM2WE4oaD1mrxauFY1mg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fmZbivwX; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fmZbivwX"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 543AFC2BBFC;
	Sat, 11 May 2024 12:42:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715431375;
	bh=nelWJBPy4bioqX976VDUtk31Rk/u62XeVCGF5TAISv4=;
	h=From:To:Cc:Subject:Date:From;
	b=fmZbivwXDTQ099NmmtWNkasljTlY5wE/EukbqmbVaI90/Uvbj6T4jOxnl2080a12x
	 XB0J9BCjMOUZDpePJ6eV/FMTCKgEDKvPbKzTbvMqG4MZr8CUfiK5Jlp/ZjzlcVQvxg
	 HgZ/2nIuY91+SPzzWDcah5K00/MS9XN3qTiousbFk+9PoI9GTR+6/uQKpXYGOQr1GQ
	 4VPW44NUpcNmyIdgNSd0y0Yt29yyddEygr4c06quME+Ugt3L9XnrTSwwU3EGEcmdCB
	 x0qLbrM4LlweRgZaLe48nowVvA1b/PKI8tyiel9dN0DdYFZpa0f1/mLeS+5A/kzPbQ
	 6I0SQAkA+N4YA==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next v2 0/2] patches for new MPTCP subflow subtest
Date: Sat, 11 May 2024 20:42:04 +0800
Message-ID: <cover.1715431177.git.tanggeliang@kylinos.cn>
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
 - rename pm_nl_ctl to mptcp_pm_nl_ctl.

Geliang Tang (2):
  selftests/bpf: Add mptcp pm_nl_ctl link
  Squash to "selftests/bpf: Add mptcp subflow subtest"

 tools/testing/selftests/bpf/Makefile           |  2 +-
 tools/testing/selftests/bpf/mptcp_pm_nl_ctl.c  |  1 +
 tools/testing/selftests/bpf/prog_tests/mptcp.c | 17 ++++++-----------
 3 files changed, 8 insertions(+), 12 deletions(-)
 create mode 120000 tools/testing/selftests/bpf/mptcp_pm_nl_ctl.c

-- 
2.43.0

