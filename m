Received: from out-188.mta0.migadu.com (out-188.mta0.migadu.com [91.218.175.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F1581B26C
	for <mptcp@lists.linux.dev>; Tue, 19 Dec 2023 13:31:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="Rtf/M9JD"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1702992705;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=I4R6nto86j8WU80R9oxeWpi52Zo+MQ2Qp3I+na/FSe0=;
	b=Rtf/M9JDg6GLaVvOtC936qZaXdu3D2FeFWzQJGm33Nvn+nCWn/kRoXb/vZTeM65rdzquZR
	civNmyHVf31sHg5GoCtoV7IkSQ/KZYKM5vzLhisGu/tdcwGunBxmRpJPgc7+xKhaC+4pGn
	sBE42Sp0+Pkl0NP3LhkojG9TA6/Ox3U=
From: Geliang Tang <geliang.tang@linux.dev>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliang.tang@linux.dev>
Subject: [PATCH mptcp-next v4 00/14] dump for userspace pm
Date: Tue, 19 Dec 2023 21:32:04 +0800
Message-Id: <cover.1702992525.git.geliang.tang@linux.dev>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

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
  mptcp: dump addrs in userspace pm list
  mptcp: check userspace pm subflow flag
  mptcp: add token for get-addr in yaml
  selftests: mptcp: add userspace pm subflow flag
  selftests: mptcp: add token for dump_addr
  selftests: mptcp: add check_output helper
  selftests: mptcp: dump userspace addrs list
  mptcp: add userspace_pm_lookup_addr_by_id helper
  mptcp: implement mptcp_userspace_pm_get_addr
  mptcp: get addr in userspace pm list
  selftests: mptcp: add token for get_addr
  selftests: mptcp: userspace pm get addr tests

 Documentation/netlink/specs/mptcp_pm.yaml     |   5 +-
 net/mptcp/mptcp_pm_gen.c                      |   7 +-
 net/mptcp/mptcp_pm_gen.h                      |   2 +-
 net/mptcp/pm_netlink.c                        |  34 +++-
 net/mptcp/pm_userspace.c                      | 155 ++++++++++++++++--
 net/mptcp/protocol.h                          |   8 +
 .../testing/selftests/net/mptcp/mptcp_join.sh |  99 +++++++++++
 tools/testing/selftests/net/mptcp/pm_nl_ctl.c |  39 ++++-
 8 files changed, 317 insertions(+), 32 deletions(-)

-- 
2.35.3

