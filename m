Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88CA3156653
	for <mptcp@lists.linux.dev>; Wed,  8 Jan 2025 04:21:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736310080; cv=none; b=DCMUR876G7jsR/2u2Wi0fN7zx/2nDB69Vr6wTHZo+syxrVEoSsk0VfrBlFqCXq8HeqR/3HdeEjNo3ZMQVKfQsOWRBYi4f+HaVD+szIlJdmJ9rDL5ahoMunubd+qyfSSCspuo2IdSoIc7AFgq94Cf2lSzhMwRlPWqiugxBEapbSg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736310080; c=relaxed/simple;
	bh=feqimisN9IpNvT8D6SYZQ1d/fQ27kTnJZ41aYXIkmAM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=qPFNKyCUlZfzAigOydfH+jZqy4uAJKu3tgvsUlM7Sg55/vAhHL/oBLMIbGA8SfnN3OSOdREx9zM+TpZDPemAeVEc1NrhJW4kFBrRnSPrFUh9BfVEI5lHbLt1MxZiuJnaMabuB1PoKmECYny9TV4g/XmUinaKo533f+PHCVpvg9o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QRoQqRms; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QRoQqRms"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CFF8DC4CED0;
	Wed,  8 Jan 2025 04:21:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736310078;
	bh=feqimisN9IpNvT8D6SYZQ1d/fQ27kTnJZ41aYXIkmAM=;
	h=From:To:Cc:Subject:Date:From;
	b=QRoQqRmsWU5EpCZANZL59/fXTWkq9x0JMc1rb48DzFguvpC53cHZeuPaRh4PopHM4
	 7WeoOz1rT05I5FVoObXS8Z5tSeB3fdG7FItkE318xLbXpc4JlLD8103KqPhBXe6GIi
	 MSQa/o4bYrIvLqx0dtopv/vrPj62w2oHCOD9T/SEZ/N9kXV2etrmp6vENirCAjUOxu
	 UXZxDo+SPIKlSOTNJfF1c40B4n8Dg1NUwgOlK0XiY2fsmPCNZYX6aCA5tDAkr86CGL
	 glLgpP8dnWA/FeNa43b9V46r1rOJDcgLlsHYdVU3rHV4LuVM9T1NtcXycO1yQFPR35
	 6c02sBPEm1p/A==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next v3 0/8] BPF path manager, part 2
Date: Wed,  8 Jan 2025 12:21:04 +0800
Message-ID: <cover.1736308884.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Geliang Tang <tanggeliang@kylinos.cn>

v3:
 - Thanks Matt for the review on dump_addr interfaces. It seems that
it needs more time to be modified. In this version, I removed the
patches for dump_addr interfaces from this set and added the patches
for set_flags interfaces.
 - set_flags interfaces patches address Matt's comments on the set
"mptcp: use GENL_REQ_ATTR_CHECK in userspace pm" v2.

Based-on: <cover.1736299989.git.tanggeliang@kylinos.cn>

v2:
 - split patch 7 of v1 into two.
 - patches 1-6 have no code changes, only the commit logs have been
updated.
 - more commit log to explain why mptcp_pm_addr_id_bitmap_t needs to
be defined.
 - use mptcp_pm_addr_id_bitmap_t in userspace_pm_append_new_local_addr
too.

In order to implement BPF userspace path manager, it is necessary to
unify the interfaces of the path manager. This set updates get_addr()
and dump_addr() interfaces.

Geliang Tang (8):
  mptcp: make three pm wrappers static
  mptcp: drop skb parameter of get_addr
  mptcp: add id parameter for get_addr
  mptcp: reuse sending nlmsg code in get_addr
  mptcp: userspace pm set_flags id support
  mptcp: drop skb parameter of set_flags
  mptcp: change rem type of set_flags
  mptcp: add local & remote parameters for set_flags

 net/mptcp/pm.c           | 114 ++++++++++++++++++++++++++++++++++++---
 net/mptcp/pm_netlink.c   | 108 ++++++++-----------------------------
 net/mptcp/pm_userspace.c |  99 ++++++----------------------------
 net/mptcp/protocol.h     |  16 +++---
 4 files changed, 154 insertions(+), 183 deletions(-)

-- 
2.45.2

