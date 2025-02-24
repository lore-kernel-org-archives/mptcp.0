Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48F3517548
	for <mptcp@lists.linux.dev>; Mon, 24 Feb 2025 08:13:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740384829; cv=none; b=G8BCX41lom1bkgbYDmvvYSC21msYrxYb0gzPmfTzjj4Pmf24tPZ6QXk8U/m+zoXq1Tg/EFQC5wk4byap3UpHHr+htHx7g6v6+ZHvTa1EeDRoOYb2CdgVd+46GCggwwtrullCpyS2wfNZJ4exnguB7vmjoyVtMal6nTRNQfpbabw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740384829; c=relaxed/simple;
	bh=cJOllgbI+E80+KHnhcS/GeTwpjba7yoiBqFbUAZsbDQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=EGRx2x9dY3e91FyAMsLfucpF2qvDSu4nDAIwRszfR+aeG508L60C81BNlUHTEGOFzTWeSJAJysAt5Fz9Fvbxmveuk8RA96U7DHQVzAuRf8R+h0JH1+3Fneq8iMF6MxRQCP9YE/mbGy0dWjKkn00iVRHJrfu7eo7IPDSFE+odWWc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=J/0LPBfy; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="J/0LPBfy"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9E3F3C4CED6;
	Mon, 24 Feb 2025 08:13:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740384828;
	bh=cJOllgbI+E80+KHnhcS/GeTwpjba7yoiBqFbUAZsbDQ=;
	h=From:To:Cc:Subject:Date:From;
	b=J/0LPBfyDwQO7OjoR6XvLprftBy+7LfEH2HWJV9ZRyjll2GTlnD8NL/gLQoH8KI1i
	 oX7QVR5O2+hvD3yODaYD9TNTk0H3z9QcIEpyCf/Q2rgj3ylC9/FZguU2VjyXKvZfax
	 58Lc8n1aMnf9DGoEPhiKfSNpNgdOYQ3Sd0c7qu4PZHaYUcRo3zfqkaCb/T2PSZ+phy
	 U3R2QyJKMoKagiYcV9OP1/jRfG1Ov0z+S5yyUFvMb52h8gthZOoS0etkTE0N2IPDm2
	 QPwPODWtpIl5Kd4YfZ9jQauVw6OV+b6/+QW6Pe2c+UKH+zKw5lXiJsFBT0fWW0zUA7
	 LAyJtenhX7diA==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next v1 0/6] BPF path manager, part 4
Date: Mon, 24 Feb 2025 16:13:32 +0800
Message-ID: <cover.1740384564.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Geliang Tang <tanggeliang@kylinos.cn>

Some path manager related refactoring and cleanups.

Geliang Tang (6):
  mptcp: pm: in-kernel: avoid access entry without lock
  mptcp: pm: in-kernel: reduce parameters of set_flags
  mptcp: pm: use addr entry for get_local_id
  mptcp: pm: in-kernel: use kmemdup helper
  sock: add sock_kmemdup helper
  mptcp: pm: userspace: use sock_kmemdup helper

 include/net/sock.h       |  1 +
 net/core/sock.c          | 23 +++++++++++++++++++++++
 net/mptcp/pm.c           |  9 ++++++---
 net/mptcp/pm_netlink.c   | 30 +++++++++++++-----------------
 net/mptcp/pm_userspace.c | 20 +++++++-------------
 net/mptcp/protocol.h     |  6 ++++--
 6 files changed, 54 insertions(+), 35 deletions(-)

-- 
2.43.0

