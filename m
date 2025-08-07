Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7A601F956
	for <mptcp@lists.linux.dev>; Thu,  7 Aug 2025 02:44:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754534678; cv=none; b=mRctsFpIBYCmWVyu4mxOlpnMtL/8nNzoWNhEROV2V2GpfzH7frNWqtyLXrl7U3671/qpmN6Sxgb7lZo2HjXTuShbCkJcBfsSp+3jf0fS/GGNJ54JynKJv+jOfjkcNIUIS1+X3F1MlJ3odnB07CLzP3luPMVq2yMGYblx+yqS9uA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754534678; c=relaxed/simple;
	bh=AyBoN55lhPa4F/ivqWWQbQrYaFuGq+957jZbn/+ch6k=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=SOS1rnC6XwH5tcDQYWXiRaqfhO8P8fuxo7fyRmkBiwgrLjo1v8B0Su4t5bGSlOlP/TTlEvR81O1MAAbgHwYTca6Gp30MC7P4oDj1L/FmcR2C1VXfMVMCPK0sinaPidyFad9d0CX2gJov24Fb3D7SOX4cujwRd17SOxQNkNy1SiY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=o3eaAhLi; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="o3eaAhLi"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C1B83C4CEEB;
	Thu,  7 Aug 2025 02:44:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1754534677;
	bh=AyBoN55lhPa4F/ivqWWQbQrYaFuGq+957jZbn/+ch6k=;
	h=From:To:Cc:Subject:Date:From;
	b=o3eaAhLir92viEVW6DnDoi2zRUd5OyzSV3YUsZU7UZqLzHCKybdwVb6yI0HFqiH+m
	 b2uAiiGOZxxE5kSe/ySN4YBFu0lrc/y7Ta3ZaGz42hPx+cAAhqgIym3Sw9s2ZNr7WD
	 QjB70WoWOguwq8/s+AypbMJOLPM5hvbk8jYsutSUsUtFcSulAcTRGGuLXRaM4C6K93
	 P0oHSa42Y9d/rTyDQPOYWIUCY1jEaY4EJeV5YqEFoyz+ifydAKj2sd7sGyoaePaksR
	 pjsJhXykq/Ze3pH0rwz5XM42oH9VB77Csd5ADfgPLaN9xfkTrdyANxmg0z3Js2BaDR
	 GrqdrMsaVSmsw==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-net v2 0/3] mptcp: disable add_addr retrans
Date: Thu,  7 Aug 2025 10:44:22 +0800
Message-ID: <cover.1754534416.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Geliang Tang <tanggeliang@kylinos.cn>

v2:
 - move "remove duplicate sk_reset_timer call" into this set.
 - check add_addr timeout value in mptcp_pm_alloc_anno_list() too.

This series enhances MPTCP's ADD_ADDR retransmission mechanism by:

1. Adding support for disabling retransmissions when add_addr_timeout
is set to 0
2. Modifying the self-tests to leverage this new capability

The first patch implements the core functionality change in the MPTCP
subsystem, while the second patch updates the selftests to use this
feature for stabilizing a specific test case.

These changes provide more control over ADD_ADDR behavior and improve
test reliability by eliminating race conditions caused by unexpected
retransmissions.

Patch 1: Remove duplicate sk_reset_timer call
Patch 2: When add_addr_timeout is 0, skip retransmission entirely
Patch 3: Disable retransmissions in "delete re-add signal" test

Geliang Tang (3):
  mptcp: remove duplicate sk_reset_timer call
  mptcp: disable add_addr retransmission when timeout is 0
  selftests: mptcp: disable add_addr retrans in endpoint_tests

 Documentation/networking/mptcp-sysctl.rst      |  2 ++
 net/mptcp/pm.c                                 | 18 ++++++++++++------
 .../testing/selftests/net/mptcp/mptcp_join.sh  |  1 +
 3 files changed, 15 insertions(+), 6 deletions(-)

-- 
2.48.1

