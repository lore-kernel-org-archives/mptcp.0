Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FB899444
	for <mptcp@lists.linux.dev>; Thu, 18 Jan 2024 06:12:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705558329; cv=none; b=hBIkLhYgmwg7hNJ4F66XNmp3XDfQ3XIktDiafbe4KL0kyZJyl3e4rWbm/VVY5fmhF30ho9HRlEi/bEAGgiDGKqYK0yTX96msowlIPg5GLcJSWfxwl0GC182KNDPCYYo+Zdi+k22B5FFpUvnj635OdONBaCJVxOVlE2qb5tMaiHo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705558329; c=relaxed/simple;
	bh=NqkUNjnb/+0ojlKFCdvv7IOnY+fZmZLtSlWbLv0cuDI=;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-Id:
	 X-Mailer:MIME-Version:Content-Transfer-Encoding; b=OqsiDiCCoRZw8f6ZNbpb9EG2cQcuRJM92Tg6rFTHG3SGLXiADm8VStjeqV+KStJXo/oimAloouaKDa6GCGirG7kDObPAaa1cF21dulEhxE0MAxZp6KGwV5q4M7qgqpJ00BAu7klFZl/ngLgxoF8ljKjnFJ/lPot1AVHI8fqQvSY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aQgOJjkw; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aQgOJjkw"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DD12EC433C7;
	Thu, 18 Jan 2024 06:12:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705558328;
	bh=NqkUNjnb/+0ojlKFCdvv7IOnY+fZmZLtSlWbLv0cuDI=;
	h=From:To:Cc:Subject:Date:From;
	b=aQgOJjkwoskiG/samu1js9H6AItoK491Qu6J1VQzjB7qTGJvE7cufDani/6phxzDT
	 NSxQ4j+iaLvDJFid/cnS1bjXtvgiE3y+E1DOP4KnFdvYRqaj9hR6MWJYz51SqmtsCN
	 PtJQQd4xsTyBskDapFO5bYsb+0Zf2IEGg4vOKJxjjf05x4axZsCRj5w9UDIo4Gdnbx
	 Db///za9jDdnxLQ04k9NrpumA953+fCKxjG/c862vN6n9z/nufWK8oD1dN7FSBdnbU
	 9mB6ZmeH0+DIAKOmoaVXOKSrs94x+ffNiOoYxQcA/X+t4viWWhhMGQaZImQxVv0TdM
	 NEc9A+PrTjZBA==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next v10 00/23] dump for userspace pm
Date: Thu, 18 Jan 2024 14:11:40 +0800
Message-Id: <cover.1705558030.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.40.1
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Geliang Tang <tanggeliang@kylinos.cn>

v10:
 - fix a checkpatch.sh warning reported by CI.
 - fix build warnings reported by kernel test robot <lkp@intel.com>.

v9:
 - add missing "sock_put(sk)" in patch 7, 17 and 21 to fix the "kmemleak"
   errors reported by CI.
 - rename the helper to mptcp_pm_has_addr_attr_id.
 - use my new mail address.

v8:
 - Address Mat's comments in v7

v7:
 - fix checkpatch.sh warning reported by CI.
 - fix build errors reported by CI.

v6:
 - patches 1-5, fixes for -net
 - patches 6, 15, selftests for "fixes for -net".
 - patches 7-14, 16-21, update "dump for userspace pm v5"
 - patches 22, 23, cleanups for set_flags
 - patch 24, flush selftest.

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

Geliang Tang (23):
  mptcp: add pm_has_addr_attr_id helper
  mptcp: add needs_id for userspace appending addr
  mptcp: add needs_id for netlink appending addr
  mptcp: map v4 address to v6 when destroying subflow
  selftests: mptcp: rm subflow with v4/v4mapped addr
  mptcp: export mptcp_genl_family & mptcp_nl_fill_addr
  mptcp: implement mptcp_userspace_pm_dump_addr
  mptcp: add token for get-addr in yaml
  mptcp: dump addrs in userspace pm list
  mptcp: check userspace pm subflow flag
  selftests: mptcp: add userspace pm subflow flag
  selftests: mptcp: add token for dump_addr
  selftests: mptcp: add check_output helper
  selftests: mptcp: dump after creating id 0 subflow
  selftests: mptcp: dump userspace addrs list
  mptcp: add userspace_pm_lookup_addr_by_id helper
  mptcp: implement mptcp_userspace_pm_get_addr
  mptcp: get addr in userspace pm list
  selftests: mptcp: add token for get_addr
  selftests: mptcp: userspace pm get addr tests
  mptcp: update set_flags interfaces
  mptcp: set error messages for set_flags
  selftests: mptcp: flush userspace addrs list

 Documentation/netlink/specs/mptcp_pm.yaml     |   3 +-
 net/mptcp/mptcp_pm_gen.c                      |   7 +-
 net/mptcp/mptcp_pm_gen.h                      |   2 +-
 net/mptcp/pm.c                                |  38 ++-
 net/mptcp/pm_netlink.c                        | 100 ++++----
 net/mptcp/pm_userspace.c                      | 241 +++++++++++++++---
 net/mptcp/protocol.h                          |  25 +-
 .../testing/selftests/net/mptcp/mptcp_join.sh | 150 ++++++++++-
 tools/testing/selftests/net/mptcp/pm_nl_ctl.c |  39 ++-
 9 files changed, 505 insertions(+), 100 deletions(-)

-- 
2.40.1

