Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D76833C3
	for <mptcp@lists.linux.dev>; Thu, 19 May 2022 23:30:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1653003041; x=1684539041;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=bIAkoA2BETm+H6tzNSJD8IT8c+t3sI9/4fSrTSTd5TU=;
  b=aFge/gyo9jIZ2bVIr4ku1JVq2UmkKHdpbfrphjFLfsqKYYKhhix6ikmZ
   4KcC0PyLT0NAaS3O/ZpfgPBk5LoZPi1qc8QdD/8OwkLurIQ3ayTe3wyrm
   npwQxLcDSbHpsIOflRACw44+Ga7zTP8J0wC6bXDYubu5FfP0of5zyDCvS
   xsG+ACPMoYnjmOvbk/gP8wsgji3KAKrkNESku4jMlkNs4uLHBEuyTTSZD
   rPgbjWePERxA6z7O6Soeb8Rz72Sn9lGttnxRirfESiD2k6s7wTrrxkSEK
   avQlQ7lKSHJXtd0KHW0SZnqtT1p60UAfOxN4i6aB41NqLC3zo5Fqq/vkq
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10352"; a="272381760"
X-IronPort-AV: E=Sophos;i="5.91,238,1647327600"; 
   d="scan'208";a="272381760"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 May 2022 16:30:21 -0700
X-IronPort-AV: E=Sophos;i="5.91,238,1647327600"; 
   d="scan'208";a="570491188"
Received: from mjmartin-desk2.amr.corp.intel.com (HELO mjmartin-desk2.intel.com) ([10.252.132.179])
  by orsmga007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 May 2022 16:30:21 -0700
From: Mat Martineau <mathew.j.martineau@linux.intel.com>
To: netdev@vger.kernel.org,
	bpf@vger.kernel.org
Cc: Mat Martineau <mathew.j.martineau@linux.intel.com>,
	ast@kernel.org,
	daniel@iogearbox.net,
	andrii@kernel.org,
	geliang.tang@suse.com,
	mptcp@lists.linux.dev
Subject: [PATCH bpf-next v5 0/7] bpf: mptcp: Support for mptcp_sock
Date: Thu, 19 May 2022 16:30:09 -0700
Message-Id: <20220519233016.105670-1-mathew.j.martineau@linux.intel.com>
X-Mailer: git-send-email 2.36.1
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This patch set adds BPF access to mptcp_sock structures, along with
associated self tests. You may recognize some of the code from earlier
(https://lore.kernel.org/bpf/20200918121046.190240-6-nicolas.rybowski@tessares.net/)
but it has been reworked quite a bit.


v1 -> v2: Emit BTF type, add func_id checks in verifier.c and bpf_trace.c,
remove build check for CONFIG_BPF_JIT, add selftest check for CONFIG_MPTCP,
and add a patch to include CONFIG_IKCONFIG/CONFIG_IKCONFIG_PROC for the
BPF self tests.

v2 -> v3: Access sysctl through the filesystem to work around CI use of
the more limited busybox sysctl command.

v3 -> v4: Dropped special case kernel code for tcp_sock is_mptcp, use
existing bpf_tcp_helpers.h, and add check for 'ip mptcp monitor' support.

v4 -> v5: Use BPF test skeleton, more consistent use of ASSERT macros,
drop some unnecessary parameters / checks, and use tracing to acquire
MPTCP token.

Geliang Tang (6):
  bpf: add bpf_skc_to_mptcp_sock_proto
  selftests/bpf: Enable CONFIG_IKCONFIG_PROC in config
  selftests/bpf: test bpf_skc_to_mptcp_sock
  selftests/bpf: verify token of struct mptcp_sock
  selftests/bpf: verify ca_name of struct mptcp_sock
  selftests/bpf: verify first of struct mptcp_sock

Nicolas Rybowski (1):
  selftests/bpf: add MPTCP test base

 MAINTAINERS                                   |   1 +
 include/linux/bpf.h                           |   1 +
 include/linux/btf_ids.h                       |   3 +-
 include/net/mptcp.h                           |   6 +
 include/uapi/linux/bpf.h                      |   7 +
 kernel/bpf/verifier.c                         |   1 +
 kernel/trace/bpf_trace.c                      |   2 +
 net/core/filter.c                             |  18 ++
 net/mptcp/Makefile                            |   2 +
 net/mptcp/bpf.c                               |  21 +++
 scripts/bpf_doc.py                            |   2 +
 tools/include/uapi/linux/bpf.h                |   7 +
 tools/testing/selftests/bpf/bpf_tcp_helpers.h |  13 ++
 tools/testing/selftests/bpf/config            |   3 +
 tools/testing/selftests/bpf/network_helpers.c |  40 +++-
 tools/testing/selftests/bpf/network_helpers.h |   2 +
 .../testing/selftests/bpf/prog_tests/mptcp.c  | 174 ++++++++++++++++++
 .../testing/selftests/bpf/progs/mptcp_sock.c  |  89 +++++++++
 18 files changed, 382 insertions(+), 10 deletions(-)
 create mode 100644 net/mptcp/bpf.c
 create mode 100644 tools/testing/selftests/bpf/prog_tests/mptcp.c
 create mode 100644 tools/testing/selftests/bpf/progs/mptcp_sock.c


base-commit: 834650b50ed283d9d34a32b425d668256bf2e487
-- 
2.36.1

