Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB3592EB10
	for <mptcp@lists.linux.dev>; Mon,  6 Jan 2025 08:16:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736151384; cv=none; b=ajl79YqcMTtiMmN60gaUGNlep2/C7Ag3pFmCxzxjz+sKMdMH/X/2GU2yrGjhZjTKPfvNYpGuTzokKLxyX2ZH0hvnVdkZEryAJBFgsao36YTz5euvJQvhdj3kbDdsXDfZediZnbBL10PkAv7CMH4YpEg+/21qKB3OM+xaaqi4J1E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736151384; c=relaxed/simple;
	bh=HQKgkOWyvj7kc9pf9DNhZW1JsDYpPbU8+yTurJh6G5E=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=o+07pGrcuPEfryo2WSsR+r0uGAlEeXHUXKPSDI6srHx2vB+sTaK1J6e1HBl35MYFm+nyABEnC41YiXR0n7xB5aADLkyC0/INnrUT+8SyTB5QHARIE3+zrbFYEg3fbgwjn4b2KJWf38AfkIgEz2uyYZPMIQH3HU7oTKRQjbpnLLg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=vF/zHRz5; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="vF/zHRz5"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DF861C4CED2;
	Mon,  6 Jan 2025 08:16:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736151384;
	bh=HQKgkOWyvj7kc9pf9DNhZW1JsDYpPbU8+yTurJh6G5E=;
	h=From:To:Cc:Subject:Date:From;
	b=vF/zHRz5tuu9/vH4n/W2hIGDqR+iiUSHTVMpUszQLvlrIFeqWVvCKGQgEbwUYGpHl
	 2QpnDZv1aEayZJINLzcqolS8qDcIUy12tWm2T8OxeOcDP/JtIhiKv2mfjXudHFmIwF
	 NJZKUP+yuHFtCaPBf0fMNkKENadKp70k4hBBy6PVN7zvF10kfXPCwELGT2y+ow2yi+
	 SAuomV4FZ50CmL4aMraCSYDmSZoTm+LhL6EQmBR6srHcGVYndqcWbMCQ1BOF0xx8Y1
	 DcFwtKu/XOxgqajgwlGbYqL/mW3yijVXuu2mSZfs1NMbQUT18WRaYcCXx0eqSRcZ+w
	 6N22c5eM9n/1w==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next v7 00/11] mptcp: use GENL_REQ_ATTR_CHECK in userspace pm
Date: Mon,  6 Jan 2025 16:16:05 +0800
Message-ID: <cover.1736150983.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Geliang Tang <tanggeliang@kylinos.cn>

v7:
 - update set_flags() interface.
 - drop 'info' parameter of userspace_pm_remove_id_zero_address().
 - rebase v6 on top of these changes.

This is a newer version of the series started by Geliang, now making
them more uniform on how the NL errors are set, and giving more hints to
the userspace about what's wrong.

Geliang Tang (6):
  mptcp: userspace pm set_flags id support
  mptcp: drop skb parameter of set_flags
  mptcp: change rem type of set_flags
  mptcp: add local & remote parameters for set_flags
  mptcp: drop info of userspace_pm_remove_id_zero_address
  mptcp: pm: userspace: use GENL_REQ_ATTR_CHECK

Matthieu Baerts (NGI0) (5):
  mptcp: pm: more precise error messages
  mptcp: pm: use NL_SET_ERR_MSG_ATTR when possible
  mptcp: pm: improve error messages
  mptcp: pm: remove duplicated error messages
  mptcp: pm: mark missing address attributes

 net/mptcp/pm.c           |   8 +-
 net/mptcp/pm_netlink.c   | 107 +++++++++++++++++--------
 net/mptcp/pm_userspace.c | 165 ++++++++++++++++++++-------------------
 net/mptcp/protocol.h     |  12 ++-
 4 files changed, 171 insertions(+), 121 deletions(-)

-- 
2.45.2

