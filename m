Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A88237EFED
	for <mptcp@lists.linux.dev>; Fri, 17 Apr 2026 23:06:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776467209; cv=none; b=fePsAMHreBsT1BkgCyNSl/B6cNAL/6CrQwxW88dxZ30ZSPeu2FhhJkoJ4pbHN3REtA4AfmHiJE0AC7kw0YH0b+ieUFLMbCnhvgFK/h6pJeBNw9NooEruEbBNuiyVP/6fcZDJyEbFfvTIa6z/Y2j19vvq/FekeBlf1xP/95a3za0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776467209; c=relaxed/simple;
	bh=kdWx20YscStcA/CGTg+H/e/zeMbgNoXxluMw/4FBfNs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=rICVRCqpzskl2WRvIAYIXsMJ/yVMRPBtypcG4toBAaiv98SI4O+k2+WaZYfgcAp649qNgGewXIeGBR2IJDggF+aibBneVmywHJIFu034dVxN/Us3gwiA9+yMSX0GTud1zpv7RdqsjFTl3W/sD2X+e2bSG3t3f4OlIXsNbGVQZgg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gQ4Ih6AA; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gQ4Ih6AA"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 69105C19425;
	Fri, 17 Apr 2026 23:06:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776467209;
	bh=kdWx20YscStcA/CGTg+H/e/zeMbgNoXxluMw/4FBfNs=;
	h=From:To:Cc:Subject:Date:From;
	b=gQ4Ih6AAsCw4pGsq8LKx08hvCxCCsu1jjzTo49LMtAiNTV7dCPGpUoLirlo5ZGg9s
	 3jdj4OpCQZmMwqJt7PaYi3bftCAv3a+UTdMLmggeNkXdHbN1jLPCJ+iD1RoDRHTnqN
	 Zz+SRGsRqcxzYvoAj334X5iveqMxbkQ5a/gdfCOoR6ttf56lO6ugZ6T2k3FwszzIFV
	 T90y6+ioPE4CuYvbFRECJ5i6Fm80brGDEa8h7af2aACtfcugaBqxF509kefFlk3p2K
	 uU8WMqZQXvgkhb4Ty3Kv6bXRED8Yx3EsC6o8kK/9arZA1XMzSW/i/ffPOGQ8DyrCe/
	 llDQMkMB0sqAA==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next v4 0/3] only remove entry from local_addr_list when sending a REMOVE_ADDR
Date: Sat, 18 Apr 2026 07:06:21 +0800
Message-ID: <cover.1776466833.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Geliang Tang <tanggeliang@kylinos.cn>

v4:
 - rebased.

v3:
 - update userspace selftests.
 - Link: https://patchwork.kernel.org/project/mptcp/cover/cover.1744787273.git.tanggeliang@kylinos.cn/

v2:
 - squash patch 1 into patch 2 as Mat suggested.

Closes: https://github.com/multipath-tcp/mptcp_net-next/issues/403

Geliang Tang (3):
  mptcp: pm: userspace: drop delete_local_addr helper
  selftests: mptcp: join: update userspace dump_addr outputs
  selftests: mptcp: userspace: send RM_ADDR between server and client

 net/mptcp/pm_userspace.c                      | 37 +++----------------
 .../testing/selftests/net/mptcp/mptcp_join.sh |  6 +--
 .../selftests/net/mptcp/userspace_pm.sh       | 12 ++++++
 3 files changed, 20 insertions(+), 35 deletions(-)

-- 
2.51.0

