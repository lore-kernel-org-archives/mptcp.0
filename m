Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 495981FA5
	for <mptcp@lists.linux.dev>; Fri, 29 Apr 2022 22:02:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1651269743; x=1682805743;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=DlnszPk3X2RPEnjbzh3vP3TQq5DteMJxTVw6ps/Fp2w=;
  b=JzmsVuDWZlrZBcTleQv5Q9z3KZEnBDKvfAoZ+dnVFKydXk/KBFy3Y1FE
   FRHOJPWYKTxcsAlnKnW1Tux/ygzVrfCvp5zK8bstvaK1EyR8SbOFKRmoa
   gNAsn3b8izNSkM2DE+CwC17K6ZzIruvO+0hNT6CeT5PKlVPAfnPEXT+9G
   B9O9M51AAvYbmIKrXQ0A5v0oGOhausSeNibI8maIQ+wHkkakUIq5biAIm
   jaLRWD7B9uj84rxwH+cv5UNi72Y7gilqywpeyokNO6jyQqCbMFD80OGQg
   owupLTlJz4USbSgSc2pM3xPPEE9+pUtoat58FE9xNG09AmA/TE1rbGp+x
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10332"; a="246698322"
X-IronPort-AV: E=Sophos;i="5.91,186,1647327600"; 
   d="scan'208";a="246698322"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Apr 2022 15:02:09 -0700
X-IronPort-AV: E=Sophos;i="5.91,186,1647327600"; 
   d="scan'208";a="582419796"
Received: from mjmartin-desk2.amr.corp.intel.com (HELO mjmartin-desk2.intel.com) ([10.212.217.201])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Apr 2022 15:02:09 -0700
From: Mat Martineau <mathew.j.martineau@linux.intel.com>
To: netdev@vger.kernel.org,
	bpf@vger.kernel.org
Cc: Nicolas Rybowski <nicolas.rybowski@tessares.net>,
	ast@kernel.org,
	daniel@iogearbox.net,
	andrii@kernel.org,
	mptcp@lists.linux.dev,
	Matthieu Baerts <matthieu.baerts@tessares.net>,
	Mat Martineau <mathew.j.martineau@linux.intel.com>
Subject: [PATCH bpf-next v2 1/8] bpf: expose is_mptcp flag to bpf_tcp_sock
Date: Fri, 29 Apr 2022 15:01:57 -0700
Message-Id: <20220429220204.353225-2-mathew.j.martineau@linux.intel.com>
X-Mailer: git-send-email 2.36.0
In-Reply-To: <20220429220204.353225-1-mathew.j.martineau@linux.intel.com>
References: <20220429220204.353225-1-mathew.j.martineau@linux.intel.com>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Nicolas Rybowski <nicolas.rybowski@tessares.net>

is_mptcp is a field from struct tcp_sock used to indicate that the
current tcp_sock is part of the MPTCP protocol.

In this protocol, a first socket (mptcp_sock) is created with
sk_protocol set to IPPROTO_MPTCP (=262) for control purpose but it
isn't directly on the wire. This is the role of the subflow (kernel)
sockets which are classical tcp_sock with sk_protocol set to
IPPROTO_TCP. The only way to differentiate such sockets from plain TCP
sockets is the is_mptcp field from tcp_sock.

Such an exposure in BPF is thus required to be able to differentiate
plain TCP sockets from MPTCP subflow sockets in BPF_PROG_TYPE_SOCK_OPS
programs.

The choice has been made to silently pass the case when CONFIG_MPTCP is
unset by defaulting is_mptcp to 0 in order to make BPF independent of
the MPTCP configuration. Another solution is to make the verifier fail
in 'bpf_tcp_sock_is_valid_ctx_access' but this will add an additional
'#ifdef CONFIG_MPTCP' in the BPF code and a same injected BPF program
will not run if MPTCP is not set.

An example use-case is provided in
https://github.com/multipath-tcp/mptcp_net-next/tree/scripts/bpf/examples

Suggested-by: Matthieu Baerts <matthieu.baerts@tessares.net>
Acked-by: Matthieu Baerts <matthieu.baerts@tessares.net>
Signed-off-by: Nicolas Rybowski <nicolas.rybowski@tessares.net>
Signed-off-by: Mat Martineau <mathew.j.martineau@linux.intel.com>
---
 include/uapi/linux/bpf.h       | 1 +
 net/core/filter.c              | 9 ++++++++-
 tools/include/uapi/linux/bpf.h | 1 +
 3 files changed, 10 insertions(+), 1 deletion(-)

diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.h
index 444fe6f1cf35..7043f3641534 100644
--- a/include/uapi/linux/bpf.h
+++ b/include/uapi/linux/bpf.h
@@ -5706,6 +5706,7 @@ struct bpf_tcp_sock {
 	__u32 delivered;	/* Total data packets delivered incl. rexmits */
 	__u32 delivered_ce;	/* Like the above but only ECE marked packets */
 	__u32 icsk_retransmits;	/* Number of unrecovered [RTO] timeouts */
+	__u32 is_mptcp;		/* Is MPTCP subflow? */
 };
 
 struct bpf_sock_tuple {
diff --git a/net/core/filter.c b/net/core/filter.c
index b741b9f7e6a9..b474e5bd1458 100644
--- a/net/core/filter.c
+++ b/net/core/filter.c
@@ -6754,7 +6754,7 @@ bool bpf_tcp_sock_is_valid_access(int off, int size, enum bpf_access_type type,
 				  struct bpf_insn_access_aux *info)
 {
 	if (off < 0 || off >= offsetofend(struct bpf_tcp_sock,
-					  icsk_retransmits))
+					  is_mptcp))
 		return false;
 
 	if (off % size != 0)
@@ -6888,6 +6888,13 @@ u32 bpf_tcp_sock_convert_ctx_access(enum bpf_access_type type,
 	case offsetof(struct bpf_tcp_sock, icsk_retransmits):
 		BPF_INET_SOCK_GET_COMMON(icsk_retransmits);
 		break;
+	case offsetof(struct bpf_tcp_sock, is_mptcp):
+#ifdef CONFIG_MPTCP
+		BPF_TCP_SOCK_GET_COMMON(is_mptcp);
+#else
+		*insn++ = BPF_MOV32_IMM(si->dst_reg, 0);
+#endif
+		break;
 	}
 
 	return insn - insn_buf;
diff --git a/tools/include/uapi/linux/bpf.h b/tools/include/uapi/linux/bpf.h
index 444fe6f1cf35..7043f3641534 100644
--- a/tools/include/uapi/linux/bpf.h
+++ b/tools/include/uapi/linux/bpf.h
@@ -5706,6 +5706,7 @@ struct bpf_tcp_sock {
 	__u32 delivered;	/* Total data packets delivered incl. rexmits */
 	__u32 delivered_ce;	/* Like the above but only ECE marked packets */
 	__u32 icsk_retransmits;	/* Number of unrecovered [RTO] timeouts */
+	__u32 is_mptcp;		/* Is MPTCP subflow? */
 };
 
 struct bpf_sock_tuple {
-- 
2.36.0

