Received: from out-194.mta0.migadu.com (out-194.mta0.migadu.com [91.218.175.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE22763D1
	for <mptcp@lists.linux.dev>; Tue, 17 Oct 2023 03:02:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="c8INxjBl"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1697511768;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=F383O71MynAvx8Y0nyjOSnQwbox380w0S/77QEf4dfc=;
	b=c8INxjBlqOaiNFpra41JpjdUaEMy345Z2t9LOU8nz/N9Ilr3NCjBe+h6a/WoA9K8AZbjj6
	l7l3M/m9fUr7jjGgW4AabUUr6bOhsibQxZTq8IJdWqSAfH7ilWvmFpq9wCVDzbVugitkg3
	B8PNQRKiIXXSkK2uwVPlTtQNXc2TsLA=
From: Geliang Tang <geliang.tang@linux.dev>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next v17 0/9] userspace pm remove id 0 subflow & address
Date: Tue, 17 Oct 2023 11:00:19 +0800
Message-Id: <cover.1697511436.git.geliang.tang@suse.com>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

From: Geliang Tang <geliang.tang@suse.com>

v17:
 - include "fix userspace pm CI failures" series.
 - update __mptcp_has_initial_subflow as Paolo suggested.
 - update chk_subflows_total.
 - update selftests.

v16:
 - address Matt's comments in v15.

v15:
 - update __mptcp_has_initial_subflow
 - address Matt's comments in v14.

v14:
 - reuse MPTCP_CF_FASTCLOSE flag.
 - use tcp_shutdown instead of mptcp_subflow_shutdown.

v13:
 - invoke mptcp_subflow_shutdown() in patch 1 as Paolo suggested.

v12:
 - address Matt's comments in v11.

v11:
 - avoid sending RSTs.
 - rename 'id 0 subflow' to 'inital subflow'.

Geliang Tang (9):
  selftests: mptcp: run userspace pm tests slower
  selftests: mptcp: fix wait_rm_addr/sf parameters
  Squash to "selftests: mptcp: userspace pm create id 0 subflow"
  Squash to "mptcp: add mptcpi_subflows_total counter"
  Squash to "selftests: mptcp: add chk_subflows_total helper"
  selftests: mptcp: userspace pm remove initial subflow
  mptcp: userspace pm send RM_ADDR for ID 0
  mptcp: userspace pm rename remove_err to out
  selftests: mptcp: userspace pm send RM_ADDR for ID 0

 net/mptcp/pm_userspace.c                      | 45 +++++++++++-
 net/mptcp/protocol.h                          |  4 +-
 .../testing/selftests/net/mptcp/mptcp_join.sh | 70 +++++++++++++++++--
 3 files changed, 108 insertions(+), 11 deletions(-)

-- 
2.35.3

