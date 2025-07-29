Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F410E19F13F
	for <mptcp@lists.linux.dev>; Tue, 29 Jul 2025 08:22:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753777361; cv=none; b=A3F8Qz1MxggHrK5yXxLk4wUbJc+Fd+B00XKMrZXmfxkjaztj1WHhGcr1brMX70g71Ja63HvHI3hBZg4mbhjtc76wiXyuguDXDg/MMiLIwGXRE4/5p8kZ653SbV5BH+eijTpVF67Qzp4pksS8Q3RG71XTb3IQPR83kHWYXOyYrKI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753777361; c=relaxed/simple;
	bh=r4MLQMuE8FXnReqfak6sYzmuB1mOubMf7cBjOVz2UWg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=UUvs2Ap3ibO/MX+dd6xMP1I5SYQESuIYR8/80u7b5CPccLaX2sFcpAytANPaPzN05nT8t+omCkx+tBEPBACmjgTXXVB2eqRwrujvnNpMZfetsfav5deTKjdLYv5O4QZVckPLzQuFPKr9KevsGccIL0bjzsVCDUV4CeK/YQH6Tns=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nnQKx9wG; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nnQKx9wG"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A783AC4CEEF;
	Tue, 29 Jul 2025 08:22:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753777360;
	bh=r4MLQMuE8FXnReqfak6sYzmuB1mOubMf7cBjOVz2UWg=;
	h=From:To:Cc:Subject:Date:From;
	b=nnQKx9wGmGrIbzFECIlNIqTa4o11APf+h+M7Y7Q8JS33xK986onifJOz28ROAi+pK
	 CbsJrfMPKTMIKtbm23Rx9fyriU1pGfM8fSOsw0yw/EkKpyA3eC6yRPUlvQ+rlP9fYQ
	 ZlZ/2q7c2FTsQiZ6JDVqltrC8oJtnzCZ/O3VdMqWiQYZco3XVgdhKt5slVV3JmwAcW
	 JVMrmw58aq9m9xLKOjI/HqjDB+1z2ET4iFgl1mbD+e3KJl8MJTB0FqjRh7f+afXuwW
	 WUl/YgILLxNMC3Qvi1Are7l1LsFnIN2FL7iGBDS06U6G+PHzMpv+Uodph4m6Tfidj0
	 qR/pVJf2Eo3Pg==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next 0/3] mptcp: improve ADD_ADDR timeout handling
Date: Tue, 29 Jul 2025 16:22:30 +0800
Message-ID: <cover.1753777199.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Geliang Tang <tanggeliang@kylinos.cn>

This series optimizes MPTCP's ADD_ADDR retransmission timeout:

1. Renames sysctl to add_addr_timeout_max for clearer semantics
2. Makes timeout adaptive to subflow RTT
3. Updates selftests for the rename

The adaptive timeout improves subflow establishment responsiveness
while maintaining reliability through the max timeout cap. The rename
provides better configuration clarity.

Closes: https://github.com/multipath-tcp/mptcp_net-next/issues/576

Geliang Tang (3):
  mptcp: rename add_addr_timeout to add_addr_timeout_max
  mptcp: make ADD_ADDR timeout adaptive to subflow RTT
  selftests: mptcp: update for add_addr_timeout_max rename

 Documentation/networking/mptcp-sysctl.rst     |  6 ++---
 net/mptcp/ctrl.c                              | 12 ++++-----
 net/mptcp/pm.c                                | 27 ++++++++++++++++---
 net/mptcp/protocol.h                          |  2 +-
 .../testing/selftests/net/mptcp/mptcp_join.sh |  8 +++---
 5 files changed, 38 insertions(+), 17 deletions(-)

-- 
2.48.1

