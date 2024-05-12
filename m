Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D510DCA40
	for <mptcp@lists.linux.dev>; Sun, 12 May 2024 08:42:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715503342; cv=none; b=QzaIACfbHASIdIcJOGM0H9FAmUIo5efmN1cb1RmS/iQGbBJstNCDl8U9mWRHqMlZPBQ0CcfRCHY/I6pdczA1ZrGKOfIbyVEv6ku4yPvBg5uVsr4eTJcwj6t5nIh3K/l+qTjKVojXyq3GAEaTpWDLjcYZtWAkgv5mrWFISnJsEAY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715503342; c=relaxed/simple;
	bh=Y5DNsuvORvIhl016v7EYLeFjoISQGhjeiV8fW1R7rdE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=rdiOjP2Vp3MhBV1XWTTU+3wTqBS6p9anBx/ZJoYfPqA2qUp6CtPrl8cQoGbt/E2gBsWej1z5z7JWTo3jnihqtSxIfAGvjp9v+NbkJ24J9J/NceEnWmyw6xbvutchi6WPdatUYwdfOm+0IYFZynoWN33I79X9Q16JWNjT5ki7yNY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lL58kFsQ; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lL58kFsQ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2AC63C116B1;
	Sun, 12 May 2024 08:42:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715503342;
	bh=Y5DNsuvORvIhl016v7EYLeFjoISQGhjeiV8fW1R7rdE=;
	h=From:To:Cc:Subject:Date:From;
	b=lL58kFsQfrwqt/G8RUtmqW/qsvWxwW4430SWxWfMC+nVN5e2WcH+4mK7IlxJG+ssi
	 GBCx9XdhmBVZc2QAhsFvaiJuqm8W9dpRfMoKiTqW3u71y6sELrffNEYzAM1oqbU9/A
	 1LUlAKXYEgzblVdYMHsgIw7qN8Nj9/pv42T5by+EG53+1+nGS02gmvCmr//kzKreNk
	 eKXgU7Ae3mt6i0+XMLlxjV11U6agZkchCEzYnrWp9aM6nODAaFc+6Qlbr+j9KognT6
	 U7nAq8lXA5rZaViYoMt09ECMm8Lim5BhHlOMjXSwizHZIfaBUukdMc1HZOIzuLzM28
	 iWZ042Nw3hI/g==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next v4 0/3] patches for new MPTCP subflow subtest
Date: Sun, 12 May 2024 16:41:33 +0800
Message-ID: <cover.1715503185.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Geliang Tang <tanggeliang@kylinos.cn>

v4:
 - "{*/,}" can't be used in MAINTAINERS, fix it.
 - fix checkpatch too.

v3:
 - update MAINTAINERS.
 - drop '-M' in _ss_search() as Matt suggested.

v2:
 - rename pm_nl_ctl to mptcp_pm_nl_ctl.

Geliang Tang (3):
  selftests/bpf: Add mptcp pm_nl_ctl link
  Squash to "selftests/bpf: Add mptcp subflow subtest"
  checkpatch: skip warnings for symbol links

 MAINTAINERS                                    |  1 +
 scripts/checkpatch.pl                          | 11 +++++++++--
 tools/testing/selftests/bpf/Makefile           |  2 +-
 tools/testing/selftests/bpf/mptcp_pm_nl_ctl.c  |  1 +
 tools/testing/selftests/bpf/prog_tests/mptcp.c | 17 ++++++-----------
 5 files changed, 18 insertions(+), 14 deletions(-)
 create mode 120000 tools/testing/selftests/bpf/mptcp_pm_nl_ctl.c

-- 
2.43.0

