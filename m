Received: from out-174.mta0.migadu.com (out-174.mta0.migadu.com [91.218.175.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38F3512B8C
	for <mptcp@lists.linux.dev>; Mon, 18 Dec 2023 09:25:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="qPFtJPPy"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1702891512;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=eZQ1cqPZ0YjWmUuSg4ptBH00G/NN8At3fKmtcx6H/us=;
	b=qPFtJPPyYwIJ5Pezgk3/HimrflQpGdOf5evJ6Eg8qHG/cjq8TbUzo0N09IRgKkpI35VBXS
	zNkzgXPITB9/sTFye3BWiXF5TihFZhMsQavzkfY7stlKRqK1FZuGDgHSL5cMyiqYRyH19T
	XBuQWNXfqj8QILwc80Zu7QdQoJRhYOY=
From: Geliang Tang <geliang.tang@linux.dev>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliang.tang@linux.dev>
Subject: [PATCH mptcp-next v2 00/15] dump for userspace pm
Date: Mon, 18 Dec 2023 17:23:29 +0800
Message-Id: <cover.1702891194.git.geliang.tang@linux.dev>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

v2:
Address Mat's comments in v1:
 - patch 2: pass token to dump_addr too.
 - patch 2: add back id in mptcp_userspace_pm_dump_addr().
 - patch 5: pdate mptcp.yaml

v1:
Address Mat's comments in "userspace pm enhancements" v14.

Geliang Tang (15):
  mptcp: add mptcp_pm_nl_put_entry_msg helper
  mptcp: implement mptcp_userspace_pm_dump_addr
  mptcp: dump addrs in userspace pm list
  mptcp: check userspace pm subflow flag
  mptcp: add token for get-addr in yaml
  selftests: mptcp: add userspace pm subflow flag
  selftests: mptcp: add token for dump_addr
  selftests: mptcp: add check_output helper
  selftests: mptcp: dump userspace addrs list
  mptcp: add userspace_pm_lookup_addr_by_id helper
  mptcp: add mptcp_pm_nl_put_entry_info helper
  mptcp: implement mptcp_userspace_pm_get_addr
  mptcp: get addr in userspace pm list
  selftests: mptcp: add token for get_addr
  selftests: mptcp: userspace pm get addr tests

 Documentation/netlink/specs/mptcp.yaml        |   5 +-
 net/mptcp/mptcp_pm_gen.c                      |   7 +-
 net/mptcp/mptcp_pm_gen.h                      |   2 +-
 net/mptcp/pm_netlink.c                        |  95 +++++++++++-----
 net/mptcp/pm_userspace.c                      | 103 +++++++++++++++---
 net/mptcp/protocol.h                          |   9 ++
 .../testing/selftests/net/mptcp/mptcp_join.sh |  99 +++++++++++++++++
 tools/testing/selftests/net/mptcp/pm_nl_ctl.c |  39 ++++++-
 8 files changed, 306 insertions(+), 53 deletions(-)

-- 
2.35.3

