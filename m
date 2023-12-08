Received: from out-178.mta1.migadu.com (out-178.mta1.migadu.com [95.215.58.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C1F512B9D
	for <mptcp@lists.linux.dev>; Fri,  8 Dec 2023 10:07:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="N5j5rTXr"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1702030028;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=ecMAR/w7rilAA89ET4pxScc+at0o33dbkWhjHq7p8VQ=;
	b=N5j5rTXrtmUmoUv4q0XWT26zVnytLtTpM8lrZJqgGq7gyA7W1kcuxLphywJSANAdIj6Fpg
	fkAi+9z9eNKHddbPEs/ZI12NRWeRU4jBYbSUE/uehUhNXDe6cQHL+eHiQLE+cm3LhfzETt
	nZ4on/GAXYXBcycu7RCCU2df2kOq/JU=
From: Geliang Tang <geliang.tang@linux.dev>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliang.tang@linux.dev>
Subject: [PATCH mptcp-next v14 00/25] userspace pm enhancements
Date: Fri,  8 Dec 2023 18:07:13 +0800
Message-Id: <cover.1702029538.git.geliang.tang@linux.dev>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

v14:
 - implement flush operation in user space as Mat suggested.
 - update selftests.
 - Now this series includes five parts:

Part 1: dump for userspace pm (patches 1-9)
Part 2: fixes for creating id 0 subflow (patches 10-13)
Part 3: v4-mapped addr support (patches 14-15)
Part 4: flush for userspace pm (patches 16-18)
Part 5: address entry refcount for userspace pm (patches 19-25)

v13:
 - add 4 patches: 10, 11, 31, 32.
 - update selftests.

v12:
 - add pm_remove_subflows, instead of changing
   pm_remove_addrs_and_subflows.

v11:
 - add a patch "mptcp: userspace pm send RM_ADDR for conn_list addr" to
   fix selftests failures reported by CI.

v10:

 - add "fixes for creating id 0 subflow" part.

v9:
 - Fix typos reported by CI.
 - Squash two patches
        "selftests: mptcp: pm_netlink: print colored output"
        "selftests: mptcp: add mptcp_lib_check helper"
   into one:
        "selftests: mptcp: add mptcp_lib_check helper"

v8:
 - add mptcp_lib_check helper

v7:
 - merge 'Squash to "mptcp: add use_id parameter for addresses_equal
   v6"', fix packetdrill_add_addr error.
 - fix memleak error in "mptcp: add netlink pm addr entry refcount".
 - split "selftests: mptcp: flush and dump userspace addrs list" into
   two patches.

v6:
 - fix kmemleak errors reported by CI.
 - drop a patch "mptcp: add netlink pm addr entry refcount".

v5:
- Put the two series "add flush and dump for userspace" and
 "add refcount for address entry" together for better CI testing.

Patches 1-12: add flush and dump for userspace

v4:
 - fix the deadlock issue in v3 reported by CI.

v3:
 - fix warnings reported by CI.
 - get id_bitmap using pm_nl_get_pernet_from_msk.

v2:
 - add two patches: "mptcp: check userspace pm subflow flag"
                    "selftests: mptcp: add userspace pm subflow flag"

This series adds flush and dump commands support for userspace pm.

Patches 13-21: add refcount for address entry

v4:
 - move two patches here from "add flush and dump for userspace pm":
  mptcp: add userspace_pm_get_entry helper
  mptcp: drop addr_match and id_match

v3:
 - add four selftests patches:
  selftests: mptcp: export event macros in mptcp_lib
  selftests: mptcp: extract mptcp_lib_check_expected
  selftests: mptcp: add mptcp_lib_verify_listener_events
  selftests: mptcp: add mptcp_lib_init_ns

v2:
 - rebased with "add flush and dump for userspace pm" series.

Add refcount for address entry.

Geliang Tang (25):
  mptcp: export pm_nl_get_pernet_from_msk
  mptcp: drop mptcp_pm_get_* helpers
  mptcp: use pernet id_bitmap in userspace pm
  mptcp: add userspace_pm_lookup_addr_by_id helper
  mptcp: drop lookup_by_id parameter in lookup_addr
  mptcp: dump addrs in userspace pm list
  mptcp: check userspace pm subflow flag
  selftests: mptcp: add userspace pm subflow flag
  selftests: mptcp: dump userspace addrs list
  mptcp: set set_id flag when parsing addr
  mptcp: use set_id flag when appending addr
  mptcp: check addrs list in userspace_pm_get_local_id
  selftests: mptcp: dump after creating id 0 subflow
  mptcp: map v4 address to v6 when destroying subflow
  selftests: mptcp: rm subflow with v4/v4mapped addr
  mptcp: make pm_remove_addrs_and_subflows static
  mptcp: add a prefix for free_local_addr_list
  selftests: mptcp: flush userspace addrs list
  mptcp: add use_id parameter for addresses_equal
  mptcp: add check_id for lookup_anno_list_by_saddr
  mptcp: add userspace_pm_get_entry helper
  mptcp: drop addr_match and id_match
  mptcp: dup an entry when removing it
  mptcp: add userspace pm addr entry refcount
  selftests: mptcp: rm userspace addr with random order

 net/mptcp/pm.c                                |  16 +-
 net/mptcp/pm_netlink.c                        | 170 +++++++---------
 net/mptcp/pm_userspace.c                      | 189 ++++++++++++------
 net/mptcp/protocol.c                          |   2 +-
 net/mptcp/protocol.h                          |  42 +++-
 net/mptcp/sockopt.c                           |   9 +-
 .../testing/selftests/net/mptcp/mptcp_join.sh | 128 +++++++++++-
 tools/testing/selftests/net/mptcp/pm_nl_ctl.c |   8 +
 8 files changed, 381 insertions(+), 183 deletions(-)

-- 
2.35.3

