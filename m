Received: from out-173.mta1.migadu.com (out-173.mta1.migadu.com [95.215.58.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3FE2208C4
	for <mptcp@lists.linux.dev>; Thu, 21 Dec 2023 09:04:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="Ac0IQ/jL"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1703149477;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=0YwkiifBD0Wikh0p83Mm2aGgdOHYI9iFKsoHm78MfS0=;
	b=Ac0IQ/jL645CCN367CpX7+W6SKHm/1PY8Nzh3EyxptaNxRNEcSHG6VynE5gFP4brcuJlGn
	YkJck6hWNBlz/CKsfApYuiO9mHexCY53qMSxTxyH5jrlUH096klJWF8ctl0hbOGn1qpDR9
	fuFQxU0GcBpWDW1ZoMhIXNeNYtdTGBo=
From: Geliang Tang <geliang.tang@linux.dev>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliang.tang@linux.dev>
Subject: [PATCH mptcp-next v5 00/14] dump for userspace pm
Date: Thu, 21 Dec 2023 17:03:14 +0800
Message-Id: <cover.1703149203.git.geliang.tang@linux.dev>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

v5:
 - patch 2, save bitmap instead of id.
 - patch 3, drop token in reply.
 - update patch 4 and patch 12, add mptcp_pm_dump_addr and
   mptcp_pm_get_addr wrappers in pm.c

v4:
 - update patch 2, patch 3 and patch 12.
 - fix the warnings reported by CI in v3:

Unable to validate one commit: 7633a101a mptcp: get addr in userspace pm list
Unable to compile mptcp source code with make W=1 net/mptcp/pm_netlink.o
Unable to compile mptcp source code with make C=1 net/mptcp/pm_netlink.o: net/mptcp/pm_netlink.c:1656:5: warning: symbol 'mptcp_pm_nl_get_addr' was not declared. Should it be static?

v3:
 - fix the errors reported by CI in v2:

[10:55:51.288] [  897.523894][ T5664] BUG: sleeping function called from invalid context at include/linux/sched/mm.h:306
[10:55:51.288] [  897.532157][ T5664] in_atomic(): 1, irqs_disabled(): 0, non_block: 0, pid: 5664, name: pm_nl_ctl
[10:55:51.289] [  897.539503][ T5664] preempt_count: 201, expected: 0

 - drop mptcp_pm_nl_put_entry_msg and mptcp_pm_nl_put_entry_info
   helpers.

v2:
Address Mat's comments in v1:
 - patch 2: pass token to dump_addr too.
 - patch 2: add back id in mptcp_userspace_pm_dump_addr().
 - patch 5: update mptcp.yaml

v1:
Address Mat's comments in "userspace pm enhancements" v14.

Geliang Tang (14):
  mptcp: export mptcp_genl_family & mptcp_nl_fill_addr
  mptcp: implement mptcp_userspace_pm_dump_addr
  mptcp: add token for get-addr in yaml
  mptcp: dump addrs in userspace pm list
  mptcp: check userspace pm subflow flag
  selftests: mptcp: add userspace pm subflow flag
  selftests: mptcp: add token for dump_addr
  selftests: mptcp: add check_output helper
  selftests: mptcp: dump userspace addrs list
  mptcp: add userspace_pm_lookup_addr_by_id helper
  mptcp: implement mptcp_userspace_pm_get_addr
  mptcp: get addr in userspace pm list
  selftests: mptcp: add token for get_addr
  selftests: mptcp: userspace pm get addr tests

 Documentation/netlink/specs/mptcp_pm.yaml     |   3 +-
 net/mptcp/mptcp_pm_gen.c                      |   7 +-
 net/mptcp/mptcp_pm_gen.h                      |   2 +-
 net/mptcp/pm.c                                |  18 ++
 net/mptcp/pm_netlink.c                        |  26 ++-
 net/mptcp/pm_userspace.c                      | 169 ++++++++++++++++--
 net/mptcp/protocol.h                          |  13 ++
 .../testing/selftests/net/mptcp/mptcp_join.sh |  99 ++++++++++
 tools/testing/selftests/net/mptcp/pm_nl_ctl.c |  39 +++-
 9 files changed, 344 insertions(+), 32 deletions(-)

-- 
2.35.3

