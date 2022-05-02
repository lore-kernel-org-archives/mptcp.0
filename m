Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B0DD3212
	for <mptcp@lists.linux.dev>; Mon,  2 May 2022 21:12:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1651525961; x=1683061961;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=PvDGCGLLuYuPDJStpkzYAsiPIWAWemnXH5cKtMSAIJ8=;
  b=mfSB8MW9PlssL1E+T8Di4KMgECy0SEQoz1Ghkr9P6OiCzavboh33Vc1Z
   HZjA5MBq6qidEReBi2ey1QFVeWrWxVfubAZMaJKWwIXX0qLWNfxfSQuYw
   bUur7cQPBOJKgaR7109HNrDX/IL0oAvfK39YD03puBIovXTU0tTZDfDG7
   9+Zag1xn6vJba+AuWO+9F2dfP5KqrKWNEKb5m+12oCdT0HsvynaW/EYP0
   yrQc58dGzgUUKxmZ1iCEXWAhS9SI+2Uktm7vpqAsfdtcXYJ10sRQq3uVy
   g7wZ+EopglZ6p7v7fUw1KXA6/dhNcI+K3RZb4rYbja0QXNwDdVJp1+En1
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10335"; a="247878458"
X-IronPort-AV: E=Sophos;i="5.91,193,1647327600"; 
   d="scan'208";a="247878458"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 May 2022 14:12:40 -0700
X-IronPort-AV: E=Sophos;i="5.91,193,1647327600"; 
   d="scan'208";a="810393786"
Received: from mjmartin-desk2.amr.corp.intel.com (HELO mjmartin-desk2.intel.com) ([10.212.141.55])
  by fmsmga006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 May 2022 14:12:40 -0700
From: Mat Martineau <mathew.j.martineau@linux.intel.com>
To: netdev@vger.kernel.org,
	bpf@vger.kernel.org
Cc: Mat Martineau <mathew.j.martineau@linux.intel.com>,
	ast@kernel.org,
	daniel@iogearbox.net,
	andrii@kernel.org,
	mptcp@lists.linux.dev
Subject: [PATCH bpf-next v3 0/8] bpf: mptcp: Support for mptcp_sock and is_mptcp
Date: Mon,  2 May 2022 14:12:26 -0700
Message-Id: <20220502211235.142250-1-mathew.j.martineau@linux.intel.com>
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

v2 -> v3: Access sysctl through the filesystem to work around CI use of
the more limited busybox sysctl command.


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
 .../testing/selftests/bpf/prog_tests/mptcp.c  | 272 ++++++++++++++++++
 .../testing/selftests/bpf/progs/mptcp_sock.c  |  80 ++++++
 19 files changed, 497 insertions(+), 10 deletions(-)
 create mode 100644 net/mptcp/bpf.c
 create mode 100644 tools/testing/selftests/bpf/bpf_mptcp_helpers.h
 create mode 100644 tools/testing/selftests/bpf/prog_tests/mptcp.c
 create mode 100644 tools/testing/selftests/bpf/progs/mptcp_sock.c


base-commit: 20b87e7c29dffcfa3f96f2e99daec84fd46cabdb
-- 
2.36.0

