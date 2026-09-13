Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54F5A3E1738
	for <mptcp@lists.linux.dev>; Sun, 13 Sep 2026 10:15:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789294511; cv=none; b=uMVD2K2lkpxUmmrc8ySZX6V81nuPba9M44vJ/qFT44/gRh/GMq7B8V2FTcCDtUBNDvVBZXIoQcMLrJ5rYk5fvlKPff+p6m7TKeaWiPc4UM/F/5C2iFcsRHoOIJIkqbd2w/66/p4ilxJXKca6ay68spKrMOtszcSHU2FPjFlZrWo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789294511; c=relaxed/simple;
	bh=jiQUidSXXLPxaF5F14HgG8cepT9dFQX0edTLWMtyjMA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=B0yiYsPUxKzYmXUSnyr2kEvAYUp7xqA3F0mWlk6y8lanHSQqc/d1+ZeMI9kJDpKrcR0G9iIisybFo/qVwK7U4X61Lj6iDMKUzOpUT9uA3cHhEaRG3x2oQQAwcirWyEgm6Kn53pAm2RqSUrtZifTiZg3n7pc2qHr+MfLv7d2l9Q4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GDchv2mt; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GDchv2mt"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E0DBC1F00893;
	Sun, 13 Sep 2026 10:15:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789294509;
	bh=BJa+1gu/avWJhPg1WbSuvfJSkTVa/bw0jUs3Pew+Yyk=;
	h=From:To:Cc:Subject:Date;
	b=GDchv2mtTb2CZX8x2wFWnKFBxZ2OTJZhc8lU+in6VW/ExquHkXCrEMF8oMa4hNJxz
	 lNZNSpb1EljQW05T+Wye27xHuMp5VO9Ig0UGV7U8OCOBimt2it5TnMxxH39TpgAit2
	 n5U3dJPAf0C+Gzs+/tXVKiWH+uvme1jbuPDKP9GixUDbwxqiRJs/MaXkoQ6b0WqKU/
	 I1cOGK59zFBmixsH+WCXL9K0v7IdqpIoCGG8+GW2WtBucVBce1/OL9GAVyrHbKHziR
	 AqtL81Er75Fzs1tKlfaaTMpPdR/dnnFyR3is1NxSaMg8PHetS7+rkn5Dr3UkrX/eXy
	 tMtDcls/hXdNg==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next v5 00/16] MPTCP sockmap support
Date: Sun, 13 Sep 2026 18:14:39 +0800
Message-ID: <cover.1789294365.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Geliang Tang <tanggeliang@kylinos.cn>

v5:
 - Patches 1-4 are from "Reduce the differences between TCP and MPTCP for
   TLS usage" set.
 - More patches for sockmap support.
 - Rename this set from "implement psock_update_sk_prot" to "MPTCP sockmap
   support"

v4:
 - Address Mat's comments: implement .read_skb to make the selftests run.
 - Move mptcp_bpf_update_proto() from protocol.c to bpf.c.
 - Include the "implement .splice_eof" patches in this series, as they
   both modify mptcp_prot, mptcp_stream_ops and mptcp_v6_stream_ops.
 - https://patchwork.kernel.org/project/mptcp/cover/cover.1787554581.git.tanggeliang@kylinos.cn/

v3:
 - Address the comments by ai review.
   - use WRITE_ONCE to set sk->sk_write_space.
   - update the selftest, set a new key for client socket.
 - Fix line length warnings.
 - https://patchwork.kernel.org/project/mptcp/cover/cover.1773826662.git.tanggeliang@kylinos.cn/

RESEND:
 - rebased.
 - to trigger ai review.

v2:
 - Include mptcp_bpf_update_proto within CONFIG_BPF_SYSCALL to fix the
compilation errors reported by the kernel test robot.
 - Add checks for IS_ENABLED(CONFIG_MPTCP_IPV6).

Implement psock_update_sk_prot, for basic MPTCP BPF SOCKMAP support.

Closes: https://github.com/multipath-tcp/mptcp_net-next/issues/521

Geliang Tang (15):
  mptcp: add sendmsg_locked to proto_ops
  mptcp: track app-limited state in mptcp_sendmsg
  selftests: mptcp: sockopt: check app_limited
  bpf: drop duplicate check_app_limited in tcp_bpf_push
  mptcp: implement psock_update_sk_prot for sockmap
  mptcp: add sock_map_update BPF helper
  selftests/bpf: enable MPTCP support in sockmap tests
  mptcp: implement read_skb for sockmap stream verdict
  bpf: export and generalize tcp_bpf_ioctl
  mptcp: add TCP_REPAIR sockopt support
  selftests/bpf: add MPTCP coverage to sockmap_basic
  mptcp: add sk_is_msk() helper and use it in sockmap
  mptcp: add SO_ATTACH_REUSEPORT_EBPF support
  mptcp: add sk_select_reuseport BPF helper
  selftests/bpf: add MPTCP coverage to sockmap_listen

Paolo Abeni (1):
  mptcp: defer read_sock cleanup to mptcp_worker

 include/linux/bpf.h                           |  13 ++
 include/net/mptcp.h                           |  12 ++
 include/net/tcp.h                             |   7 +
 include/uapi/linux/bpf.h                      |  19 ++
 kernel/bpf/verifier.c                         |   8 +-
 net/core/filter.c                             |  60 +++++-
 net/core/sock_map.c                           |  14 +-
 net/ipv4/tcp.c                                |   9 +-
 net/ipv4/tcp_bpf.c                            |  40 ++--
 net/mptcp/bpf.c                               | 172 ++++++++++++++++++
 net/mptcp/protocol.c                          | 114 ++++++++++--
 net/mptcp/protocol.h                          |  20 ++
 net/mptcp/sockopt.c                           |  21 ++-
 .../testing/selftests/bpf/prog_tests/mptcp.c  |  27 +--
 .../selftests/bpf/prog_tests/socket_helpers.h |  25 ++-
 .../selftests/bpf/prog_tests/sockmap_basic.c  |  33 +++-
 .../selftests/bpf/prog_tests/sockmap_listen.c | 122 ++++++++-----
 .../selftests/bpf/progs/mptcp_sockmap.c       |   8 +-
 .../selftests/bpf/progs/test_sockmap_listen.c |  25 +++
 .../selftests/net/mptcp/mptcp_sockopt.c       |   1 +
 20 files changed, 622 insertions(+), 128 deletions(-)

-- 
2.53.0

