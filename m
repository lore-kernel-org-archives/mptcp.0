Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A50B91869
	for <mptcp@lists.linux.dev>; Fri, 29 Apr 2022 22:02:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1651269741; x=1682805741;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=e4ZQJt8QmkUQW3Q2NfOKvHTzJhDCEuC7kAGZGauFlKI=;
  b=V9s9n9CHnAvFjfkUFeFRAvR7LiKL9MLb+ukLI6lewQ0V4A6ynTARkU7M
   X2Jh0JfwNGLdXBv4CQl3AHraQeOsyTCKsNimF4tKcbDF+LTWTyhCzmkD/
   xLDt9C5TTX0pomio8Hlqrn0sKRFQP8OA1W9ceryrRoc0jTfxqOVjbbL91
   /egAaCYin0LWmS+Zoyn+YPSL0OcNJrGnFZUmdH21nHpqKYJU182PBw3QA
   xMLd9khpRFmgLb1B2OMRH0VG1hLoZ4NVYf8xPY5ryIFcB17nRhvF4uDG2
   5WXgyXxKOWkpWvB03pUHsisPBldVoeloW5HNcpbt51G0ZDJE+4F/Vmh+J
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10332"; a="246698320"
X-IronPort-AV: E=Sophos;i="5.91,186,1647327600"; 
   d="scan'208";a="246698320"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Apr 2022 15:02:09 -0700
X-IronPort-AV: E=Sophos;i="5.91,186,1647327600"; 
   d="scan'208";a="582419795"
Received: from mjmartin-desk2.amr.corp.intel.com (HELO mjmartin-desk2.intel.com) ([10.212.217.201])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Apr 2022 15:02:09 -0700
From: Mat Martineau <mathew.j.martineau@linux.intel.com>
To: netdev@vger.kernel.org,
	bpf@vger.kernel.org
Cc: Mat Martineau <mathew.j.martineau@linux.intel.com>,
	ast@kernel.org,
	daniel@iogearbox.net,
	andrii@kernel.org,
	mptcp@lists.linux.dev
Subject: [PATCH bpf-next v2 0/8] bpf: mptcp: Support for mptcp_sock and is_mptcp
Date: Fri, 29 Apr 2022 15:01:56 -0700
Message-Id: <20220429220204.353225-1-mathew.j.martineau@linux.intel.com>
X-Mailer: git-send-email 2.36.0
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This patch set adds BPF access to the is_mptcp flag in tcp_sock and
access to mptcp_sock structures, along with associated self tests. You
may recognize some of the code from earlier
(https://lore.kernel.org/bpf/20200918121046.190240-6-nicolas.rybowski@tessares.net/)
but it has been reworked quite a bit.


v1 -> v2: Emit BTF type, add func_id checks in verifier.c and bpf_trace.c,
remove build check for CONFIG_BPF_JIT, add selftest check for CONFIG_MPTCP,
and add a patch to include CONFIG_IKCONFIG/CONFIG_IKCONFIG_PROC for the
BPF self tests.


Geliang Tang (6):
  bpf: add bpf_skc_to_mptcp_sock_proto
  selftests: bpf: Enable CONFIG_IKCONFIG_PROC in config
  selftests: bpf: test bpf_skc_to_mptcp_sock
  selftests: bpf: verify token of struct mptcp_sock
  selftests: bpf: verify ca_name of struct mptcp_sock
  selftests: bpf: verify first of struct mptcp_sock

Nicolas Rybowski (2):
  bpf: expose is_mptcp flag to bpf_tcp_sock
  selftests: bpf: add MPTCP test base

 MAINTAINERS                                   |   2 +
 include/linux/bpf.h                           |   1 +
 include/linux/btf_ids.h                       |   3 +-
 include/net/mptcp.h                           |   6 +
 include/uapi/linux/bpf.h                      |   8 +
 kernel/bpf/verifier.c                         |   1 +
 kernel/trace/bpf_trace.c                      |   2 +
 net/core/filter.c                             |  27 +-
 net/mptcp/Makefile                            |   2 +
 net/mptcp/bpf.c                               |  22 ++
 scripts/bpf_doc.py                            |   2 +
 tools/include/uapi/linux/bpf.h                |   8 +
 .../testing/selftests/bpf/bpf_mptcp_helpers.h |  17 ++
 tools/testing/selftests/bpf/bpf_tcp_helpers.h |   4 +
 tools/testing/selftests/bpf/config            |   3 +
 tools/testing/selftests/bpf/network_helpers.c |  43 ++-
 tools/testing/selftests/bpf/network_helpers.h |   4 +
 .../testing/selftests/bpf/prog_tests/mptcp.c  | 258 ++++++++++++++++++
 .../testing/selftests/bpf/progs/mptcp_sock.c  |  80 ++++++
 19 files changed, 483 insertions(+), 10 deletions(-)
 create mode 100644 net/mptcp/bpf.c
 create mode 100644 tools/testing/selftests/bpf/bpf_mptcp_helpers.h
 create mode 100644 tools/testing/selftests/bpf/prog_tests/mptcp.c
 create mode 100644 tools/testing/selftests/bpf/progs/mptcp_sock.c


base-commit: 20b87e7c29dffcfa3f96f2e99daec84fd46cabdb
-- 
2.36.0

