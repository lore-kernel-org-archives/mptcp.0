Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75F5660DFD
	for <mptcp@lists.linux.dev>; Tue, 20 Feb 2024 09:58:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708423114; cv=none; b=ikkI/+jUwZ/kA5NhvTjvJcYPcFaSdEMK0SlOK+65eqOb6S4Dq6LiPldpOHCBpIMNAvkakIRxTJac5/H0b3CSwdFRBMeEO8MK+n5oiufkC1j0kH/PWIRQdCGzdFOSh1PBJ/kXbEvlxvuRW6M7EpwJl86stFap5Cu+MK2+/caXPNw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708423114; c=relaxed/simple;
	bh=Cpd8UR91kw696Ox3y2mTfBEj5WxI5aGnqfWo0NNBcQI=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=gMMHEt4nyNx9Tm1os04YOiS8nKdGVrDJYOg45CGRaQ3gdQxwbg5ZDlxiuHULKbswYhBwTJT+EK3I4bZJ8xXBwYvNd2Uvb5wFrnpElVJ6RmLDUlrFt7bdjYc7H/E+ikXutlRkk03nY2zasw6KgPVCoV/SyPYabwsOA7Hj4kCGaws=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CyY+V4dy; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CyY+V4dy"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3EA75C43394;
	Tue, 20 Feb 2024 09:58:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708423114;
	bh=Cpd8UR91kw696Ox3y2mTfBEj5WxI5aGnqfWo0NNBcQI=;
	h=From:To:Cc:Subject:Date:From;
	b=CyY+V4dyDOP7yrUwt6WxOcryt5K0uez98Toz8bN5/a2rKUZ7S2OP3nkrWwGDGsoE4
	 EyfJ/hMB7T3eqkEUdABk7uemdttjP1DEWW4d3daVMYj3mkvPjIJrEleaeQd7KjFvP3
	 ac4K81R3PN8/jFWfwFvkQZdxydXIT4oR0ej4fCHGOw+3yLb/BEOLovHv0bkGGwnCuc
	 HgJdyfrgv5EpR44i+tD+Gsr95Yl0OVDnmjIUqhbMcSEu9zMOyojZriuU1fcbxONcQ6
	 ytxKHVhrEoJQiQgZQ+e2d1/IuH+EMGKCwBuqEepXm9RNcSWQABGyaXeDjCcGym4xOs
	 gi0xU8o6Itoqw==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next v14 00/14] dump for userspace pm
Date: Tue, 20 Feb 2024 17:58:14 +0800
Message-Id: <cover.1708422758.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.40.1
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Geliang Tang <tanggeliang@kylinos.cn>

v14:
 - address Matt's comments in v13.
 - I have to use these lines in patch #8:

      local cmd_ret=0
      local out=$(${cmd} 2>${err}) || cmd_ret=${?}

   The following expected code breaks pm_netlink.sh, I don't know why:

      local out cmd_ret=0
      out=$(${cmd} 2>${err}) || cmd_ret=${?}

   If this is still a problem, I'll send a squash-to patch to fix it.

Geliang Tang (14):
  mptcp: export mptcp_genl_family & mptcp_nl_fill_addr
  mptcp: implement mptcp_userspace_pm_dump_addr
  mptcp: add token for get-addr in yaml
  mptcp: dump addrs in userspace pm list
  mptcp: check userspace pm flags
  selftests: mptcp: add userspace pm subflow flag
  selftests: mptcp: add token for dump_addr
  selftests: mptcp: add mptcp_lib_check_output helper
  selftests: mptcp: dump userspace addrs list
  mptcp: add userspace_pm_lookup_addr_by_id helper
  mptcp: implement mptcp_userspace_pm_get_addr
  mptcp: get addr in userspace pm list
  selftests: mptcp: add token for get_addr
  selftests: mptcp: userspace pm get addr tests

 Documentation/netlink/specs/mptcp_pm.yaml     |   3 +-
 net/mptcp/mptcp_pm_gen.c                      |   7 +-
 net/mptcp/mptcp_pm_gen.h                      |   2 +-
 net/mptcp/pm.c                                |  16 ++
 net/mptcp/pm_netlink.c                        |  26 ++-
 net/mptcp/pm_userspace.c                      | 180 ++++++++++++++++--
 net/mptcp/protocol.h                          |  13 ++
 .../testing/selftests/net/mptcp/mptcp_join.sh |  91 +++++++++
 .../testing/selftests/net/mptcp/mptcp_lib.sh  |  19 ++
 .../testing/selftests/net/mptcp/pm_netlink.sh |  18 +-
 tools/testing/selftests/net/mptcp/pm_nl_ctl.c |  39 +++-
 11 files changed, 368 insertions(+), 46 deletions(-)

-- 
2.40.1

