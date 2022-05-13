Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A150256E
	for <mptcp@lists.linux.dev>; Fri, 13 May 2022 22:48:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1652482115; x=1684018115;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=jknNG3mEEPgr4q3ixj78wwwHeBd+dIoANpLZX+rO+Ek=;
  b=Jm9v6jzSjXPvaqITmUQXfd/68dNQ7+LN/1opakeR++ywXJ8ZKuekpNEF
   6UUS4EOYoFlEgBPYlJDzEfOfIIQlsY6bqsTWN4HtbruHyxcyVz56qOxbS
   jpvHCz4pi2KLwDAX9i9IF7hFBKMiDTdHW7fhpxRvS3RoVV0tTeFoMMc+s
   MJ95gmQPbMPGKkogmxn0VFPOjFVRhaFo1iP8hNeFUhKGf7U/ETonxatHH
   m6qjOZhJjGbG02CzVlY9WwaTOZPHlxWK/i8GaI10PCqJOxEF/kybPxsPx
   Tc68bVCVTBMGNDI0iTR4eKr04Z3MqNGiYBkky/IvLgxA5wwleSo8E4gdo
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10346"; a="333462005"
X-IronPort-AV: E=Sophos;i="5.91,223,1647327600"; 
   d="scan'208";a="333462005"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 May 2022 15:48:33 -0700
X-IronPort-AV: E=Sophos;i="5.91,223,1647327600"; 
   d="scan'208";a="815588245"
Received: from clakshma-mobl1.amr.corp.intel.com (HELO mjmartin-desk2.intel.com) ([10.212.160.121])
  by fmsmga006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 May 2022 15:48:33 -0700
From: Mat Martineau <mathew.j.martineau@linux.intel.com>
To: netdev@vger.kernel.org,
	bpf@vger.kernel.org
Cc: Mat Martineau <mathew.j.martineau@linux.intel.com>,
	ast@kernel.org,
	daniel@iogearbox.net,
	andrii@kernel.org,
	mptcp@lists.linux.dev,
	geliang.tang@suse.com
Subject: [PATCH bpf-next v4 0/7] bpf: mptcp: Support for mptcp_sock
Date: Fri, 13 May 2022 15:48:20 -0700
Message-Id: <20220513224827.662254-1-mathew.j.martineau@linux.intel.com>
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
 net/mptcp/bpf.c                               |  22 ++
 scripts/bpf_doc.py                            |   2 +
 tools/include/uapi/linux/bpf.h                |   7 +
 tools/testing/selftests/bpf/bpf_tcp_helpers.h |  13 +
 tools/testing/selftests/bpf/config            |   3 +
 tools/testing/selftests/bpf/network_helpers.c |  43 ++-
 tools/testing/selftests/bpf/network_helpers.h |   4 +
 .../testing/selftests/bpf/prog_tests/mptcp.c  | 265 ++++++++++++++++++
 .../testing/selftests/bpf/progs/mptcp_sock.c  |  82 ++++++
 18 files changed, 473 insertions(+), 9 deletions(-)
 create mode 100644 net/mptcp/bpf.c
 create mode 100644 tools/testing/selftests/bpf/prog_tests/mptcp.c
 create mode 100644 tools/testing/selftests/bpf/progs/mptcp_sock.c


base-commit: 0d2d2648931bdb1a629bf0df4e339e6a326a6136
-- 
2.36.1

