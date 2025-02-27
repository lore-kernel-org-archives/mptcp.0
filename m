Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFC9015B102
	for <mptcp@lists.linux.dev>; Thu, 27 Feb 2025 06:44:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740638657; cv=none; b=Zd08hqryfTEdP12n/g7WWW/Z9Dcxtv0h1HIcaOVn1Du6B944L4qWOADFA/9RDmTSS78iubpzHEfptskKIyvbR/lbC1dkNRSHBAWyBzza7Shim8pdNRPhkE0fDNhVQi5cnaGw7TWFp/1cn0VsDjb0QeF1NZRUl5M3dqq7U4D7YOI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740638657; c=relaxed/simple;
	bh=IGrpQc/d3Hm+M6/KPW4f4sMnmTMUCmhafUpEzV07va0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=eRjcV+tm4fS4rsiZ5jsvBqUPggEw+UAKCjqIA8W4bQ5g7947tb3KwGcA33NXiXuTZOVRSKG6ELEOfHtQ85K6nSvHoHR6F8v7XiLpydybrsnDDmV7cDJGBH1MN5lZriM6j4wQyLTylFOmZ4FNmnxa8rPXVvHOCQpf8sLKak2szPI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WmzW/KMu; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WmzW/KMu"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3FF74C4CEDD;
	Thu, 27 Feb 2025 06:44:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740638655;
	bh=IGrpQc/d3Hm+M6/KPW4f4sMnmTMUCmhafUpEzV07va0=;
	h=From:To:Cc:Subject:Date:From;
	b=WmzW/KMudr47ls/Q2dKiSbMjMfkrBvPax8u8gCK+3z45XcRsW+zaScNEj/xbnxKWS
	 9LGE8OHUOU0EpRirjpZbGI5IeYispv6YcPll7jO4MITiz2+NTyuQbCH/fnBhZPUM62
	 DOTEY4mM+pvCeSKYrWuVIf0oZ272kCeMJGkQvDbENLNXAzcXfS/YYLGusx5TQYjKLv
	 162Df8ZBTPu4s6RI+q+HArfyAEv8Gl2hi8wEpNwHlg5QxbVImjim/OTNQTBrDReO0M
	 rxl78MLzJuTwNZ/78n1NozxvJfGHJvXBS2odVMzV5fCFLkrsNEqeiW4uOOimicekpm
	 MqQcZm8ydWadg==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next v1 0/6] BPF path manager, part 5
Date: Thu, 27 Feb 2025 14:43:51 +0800
Message-ID: <cover.1740638334.git.tanggeliang@kylinos.cn>
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
 - patch 1, a cleanup.
 - patches 2-4, drop mptcp_pm_is_userspace() and mptcp_pm_is_kernel().
 - patches 5-6, change remote of set_flags as mptcp_pm_addr_entry type.

Geliang Tang (6):
  mptcp: pm: use pm variable instead of msk->pm
  mptcp: pm: userspace: drop is_userspace in free_local_addr_list
  mptcp: pm: drop is_kernel in alloc_anno_list
  mptcp: pm: in-kernel: drop is_userspace in remove_id_zero
  mptcp: pm: add remote parameter for set_flags
  mptcp: pm: in-kernel: drop changed parameter of set_flags

 net/mptcp/pm.c           | 28 ++++++++----
 net/mptcp/pm_netlink.c   | 93 +++++++++++++++++++++-------------------
 net/mptcp/pm_userspace.c | 25 +++--------
 net/mptcp/protocol.h     |  5 ++-
 4 files changed, 77 insertions(+), 74 deletions(-)

-- 
2.43.0

