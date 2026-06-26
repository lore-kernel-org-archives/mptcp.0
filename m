Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8F3121CC71
	for <mptcp@lists.linux.dev>; Fri, 26 Jun 2026 22:46:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782513982; cv=none; b=kswP/twCkifjc5jGpJEk+1IHeU60y3QGyeSwo4mzMszLIdA1j2jEHOc8TfP071aMBRZ9yYuu+7wOtqsszQByhCXgW/AxzoklcrlYCFGn/LUcGyDh659l2flwt3IbPoXDQUPBdqCHyAFrAqwbkVYCWwTe+r7nLt/CXBEe/Bu/aP4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782513982; c=relaxed/simple;
	bh=VjJCIcKvMJAIwVsv0WNGNO1Zlz6yk4yMGGY5HWtFdvc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=RuiEVxeZ8R05b0zr7/scG8sg96LEorKPslz5BZAoBCr9F93UOkJWTq8Yh5OST9A73VoLJVRgoXAc1XNCKggzj73WESOiWHqV4bsiCGobWqJx3/t/QG2h7DaywJ3og8RDd/TknQIFmeHPVKTibY2G98G0B8Uypv9VmQW0vemZsh8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=e4+XZj81; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="e4+XZj81"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4E56D1F000E9;
	Fri, 26 Jun 2026 22:46:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782513981;
	bh=vdOCBFhRw5SHsMSskvR+lyMCy1dijwZ33wFpUt9DAK0=;
	h=From:To:Cc:Subject:Date;
	b=e4+XZj81LGbsnidFulg/+i1JdNhEtM2bAy5Ad30o6I+lFvmYQt6cNxWNzaMJ8E9RF
	 BP3lfcwAAn9IKi1bMOIlCk1KuErRsX0Ou+pWG0OuukuvVJkrfkZ/AZjAU65fpOLbR+
	 8wJK5thSAoYczhu1fqLFpd2bytU8+Ex9gbGQ3UuAT85ldqD7WSFwGX58wdlxi2Mc+c
	 nGc6dCV0nwRgEOoURj9d6r051y99Rnsk1nWL8ykkYGxoU7+nP/bTE1nKLMv0G4HLWT
	 KhC41k1FtBovAzbIdJMfhAgpD4b5NYae7VTkcuQL6n1kYMsCG9cWtFbCm6LKLOHWuT
	 eJUu27e+qPXiQ==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next v6 0/3] only remove entry from local_addr_list when sending a REMOVE_ADDR
Date: Sat, 27 Jun 2026 06:45:52 +0800
Message-ID: <cover.1782513313.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Geliang Tang <tanggeliang@kylinos.cn>

v6:
 - patch 2: now explicitly removes userspace pm addresses using
   userspace_pm_rm_addr, instead of merely updating dump_addr expectations.
 - patch 3: dropped duplicate "sleep 0.5".
 - The pre-existing issue Sashiko mentioned in v5, "it's not safe to
   decrement sk->sk_omem_alloc synchronously while deferring the actual
   memory free via kfree_rcu_mightsleep(match)", will be addressed in a
   separate patch.

v5:
 - rebased.
 - add Matt's reviewed tags.
 - add a RM_ADDR from the server to the client as Sashiko suggested.
 - mptcpd tests (make check) are still OK after this modification.
 - Link: https://patchwork.kernel.org/project/mptcp/cover/cover.1782457962.git.tanggeliang@kylinos.cn/

v4:
 - rebased.
 - Link: https://patchwork.kernel.org/project/mptcp/cover/cover.1776466833.git.tanggeliang@kylinos.cn/

v3:
 - update userspace selftests.
 - Link: https://patchwork.kernel.org/project/mptcp/cover/cover.1744787273.git.tanggeliang@kylinos.cn/

v2:
 - squash patch 1 into patch 2 as Mat suggested.

Closes: https://github.com/multipath-tcp/mptcp_net-next/issues/403

Geliang Tang (3):
  mptcp: pm: userspace: drop delete_local_addr helper
  selftests: mptcp: join: explicitly remove userspace pm addresses
  selftests: mptcp: userspace: send RM_ADDR between server and client

 net/mptcp/pm_userspace.c                      | 35 ++-----------------
 .../testing/selftests/net/mptcp/mptcp_join.sh |  4 ++-
 .../selftests/net/mptcp/userspace_pm.sh       | 14 ++++++++
 3 files changed, 19 insertions(+), 34 deletions(-)

-- 
2.53.0

