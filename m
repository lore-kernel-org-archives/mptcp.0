Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 781FA321B
	for <mptcp@lists.linux.dev>; Mon,  2 May 2022 21:12:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1651525964; x=1683061964;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=kqffaK3daxbD22vmQV/99UWXGn1rJCRY5uMKADdtxY0=;
  b=bwZTS6J4/W4Qt6Y63OZ/vDg3MEhD75LFqin1gm8tRTgTojaHLUzui33u
   FJJWJvFXSTkYtn1nL9W+LhvhXL4hyt+q+GfKTS+ysTqPN7+pMAkRlrVou
   69qm9zaZV1a5C/sOID8mpJe4o+OA/Kml3fO3M8QJKPc1JB/gKY5Uumxkn
   ek279tt0pVKafX20kpEx60724w5dEMiWV8bv5hDv/FX/+Q7zSFUDNYCuK
   ue7gOcMiOuGjp8uzVW+RCeZhKMKQ5DCeydmsS8p8OJojQy8wGGnLwt21b
   C6cCAc0ipdtgpqSvAbFgPE4mnf/A4n7attmXb8OIa80+vcltO73mP5bbj
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10335"; a="247878470"
X-IronPort-AV: E=Sophos;i="5.91,193,1647327600"; 
   d="scan'208";a="247878470"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 May 2022 14:12:42 -0700
X-IronPort-AV: E=Sophos;i="5.91,193,1647327600"; 
   d="scan'208";a="810393794"
Received: from mjmartin-desk2.amr.corp.intel.com (HELO mjmartin-desk2.intel.com) ([10.212.141.55])
  by fmsmga006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 May 2022 14:12:41 -0700
From: Mat Martineau <mathew.j.martineau@linux.intel.com>
To: netdev@vger.kernel.org,
	bpf@vger.kernel.org
Cc: Geliang Tang <geliang.tang@suse.com>,
	ast@kernel.org,
	daniel@iogearbox.net,
	andrii@kernel.org,
	mptcp@lists.linux.dev,
	Matthieu Baerts <matthieu.baerts@tessares.net>,
	Mat Martineau <mathew.j.martineau@linux.intel.com>
Subject: [PATCH bpf-next v3 5/8] selftests: bpf: test bpf_skc_to_mptcp_sock
Date: Mon,  2 May 2022 14:12:31 -0700
Message-Id: <20220502211235.142250-6-mathew.j.martineau@linux.intel.com>
X-Mailer: git-send-email 2.36.0
In-Reply-To: <20220502211235.142250-1-mathew.j.martineau@linux.intel.com>
References: <20220502211235.142250-1-mathew.j.martineau@linux.intel.com>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Geliang Tang <geliang.tang@suse.com>

This patch extends the MPTCP test base, to test the new helper
bpf_skc_to_mptcp_sock().

Define struct mptcp_sock in bpf_tcp_helpers.h, use bpf_skc_to_mptcp_sock
to get the msk socket in progs/mptcp_sock.c and store the infos in
socket_storage_map.

Get the infos from socket_storage_map in prog_tests/mptcp.c. Add a new
function verify_msk() to verify the infos of MPTCP socket, and rename
verify_sk() to verify_tsk() to verify TCP socket only.

v2: Add CONFIG_MPTCP check for clearer error messages

Acked-by: Matthieu Baerts <matthieu.baerts@tessares.net>
Signed-off-by: Geliang Tang <geliang.tang@suse.com>
Signed-off-by: Mat Martineau <mathew.j.martineau@linux.intel.com>
---
 MAINTAINERS                                   |  1 +
 .../testing/selftests/bpf/bpf_mptcp_helpers.h | 14 ++++++++
 .../testing/selftests/bpf/prog_tests/mptcp.c  | 36 +++++++++++++++----
 .../testing/selftests/bpf/progs/mptcp_sock.c  | 24 ++++++++++---
 4 files changed, 65 insertions(+), 10 deletions(-)
 create mode 100644 tools/testing/selftests/bpf/bpf_mptcp_helpers.h

diff --git a/MAINTAINERS b/MAINTAINERS
index 359afc617b92..d48d3cb6abbc 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -13780,6 +13780,7 @@ F:	include/net/mptcp.h
 F:	include/trace/events/mptcp.h
 F:	include/uapi/linux/mptcp.h
 F:	net/mptcp/
+F:	tools/testing/selftests/bpf/bpf_mptcp_helpers.h
 F:	tools/testing/selftests/bpf/*/*mptcp*.c
 F:	tools/testing/selftests/net/mptcp/
 
diff --git a/tools/testing/selftests/bpf/bpf_mptcp_helpers.h b/tools/testing/selftests/bpf/bpf_mptcp_helpers.h
new file mode 100644
index 000000000000..18da4cc65e89
--- /dev/null
+++ b/tools/testing/selftests/bpf/bpf_mptcp_helpers.h
@@ -0,0 +1,14 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/* Copyright (c) 2022, SUSE. */
+
+#ifndef __BPF_MPTCP_HELPERS_H
+#define __BPF_MPTCP_HELPERS_H
+
+#include "bpf_tcp_helpers.h"
+
+struct mptcp_sock {
+	struct inet_connection_sock	sk;
+
+} __attribute__((preserve_access_index));
+
+#endif
diff --git a/tools/testing/selftests/bpf/prog_tests/mptcp.c b/tools/testing/selftests/bpf/prog_tests/mptcp.c
index cd548bb2828f..4b40bbdaf91f 100644
--- a/tools/testing/selftests/bpf/prog_tests/mptcp.c
+++ b/tools/testing/selftests/bpf/prog_tests/mptcp.c
@@ -10,14 +10,12 @@ struct mptcp_storage {
 	__u32 is_mptcp;
 };
 
-static int verify_sk(int map_fd, int client_fd, const char *msg, __u32 is_mptcp)
+static int verify_tsk(int map_fd, int client_fd)
 {
+	char *msg = "plain TCP socket";
 	int err = 0, cfd = client_fd;
 	struct mptcp_storage val;
 
-	if (is_mptcp == 1)
-		return 0;
-
 	if (CHECK_FAIL(bpf_map_lookup_elem(map_fd, &cfd, &val) < 0)) {
 		perror("Failed to read socket storage");
 		return -1;
@@ -38,6 +36,32 @@ static int verify_sk(int map_fd, int client_fd, const char *msg, __u32 is_mptcp)
 	return err;
 }
 
+static int verify_msk(int map_fd, int client_fd)
+{
+	char *msg = "MPTCP subflow socket";
+	int err = 0, cfd = client_fd;
+	struct mptcp_storage val;
+
+	if (CHECK_FAIL(bpf_map_lookup_elem(map_fd, &cfd, &val) < 0)) {
+		perror("Failed to read socket storage");
+		return -1;
+	}
+
+	if (val.invoked != 1) {
+		log_err("%s: unexpected invoked count %d != 1",
+			msg, val.invoked);
+		err++;
+	}
+
+	if (val.is_mptcp != 1) {
+		log_err("%s: unexpected bpf_tcp_sock.is_mptcp %d != 1",
+			msg, val.is_mptcp);
+		err++;
+	}
+
+	return err;
+}
+
 static int run_test(int cgroup_fd, int server_fd, bool is_mptcp)
 {
 	int client_fd, prog_fd, map_fd, err;
@@ -88,8 +112,8 @@ static int run_test(int cgroup_fd, int server_fd, bool is_mptcp)
 		goto out;
 	}
 
-	err += is_mptcp ? verify_sk(map_fd, client_fd, "MPTCP subflow socket", 1) :
-			  verify_sk(map_fd, client_fd, "plain TCP socket", 0);
+	err += is_mptcp ? verify_msk(map_fd, client_fd) :
+			  verify_tsk(map_fd, client_fd);
 
 	close(client_fd);
 
diff --git a/tools/testing/selftests/bpf/progs/mptcp_sock.c b/tools/testing/selftests/bpf/progs/mptcp_sock.c
index 0d65fb889d03..7b6a25e37de8 100644
--- a/tools/testing/selftests/bpf/progs/mptcp_sock.c
+++ b/tools/testing/selftests/bpf/progs/mptcp_sock.c
@@ -3,9 +3,11 @@
 
 #include <linux/bpf.h>
 #include <bpf/bpf_helpers.h>
+#include "bpf_mptcp_helpers.h"
 
 char _license[] SEC("license") = "GPL";
 __u32 _version SEC("version") = 1;
+extern bool CONFIG_MPTCP __kconfig;
 
 struct mptcp_storage {
 	__u32 invoked;
@@ -24,6 +26,7 @@ int _sockops(struct bpf_sock_ops *ctx)
 {
 	struct mptcp_storage *storage;
 	struct bpf_tcp_sock *tcp_sk;
+	struct mptcp_sock *msk;
 	int op = (int)ctx->op;
 	struct bpf_sock *sk;
 
@@ -38,11 +41,24 @@ int _sockops(struct bpf_sock_ops *ctx)
 	if (!tcp_sk)
 		return 1;
 
-	storage = bpf_sk_storage_get(&socket_storage_map, sk, 0,
-				     BPF_SK_STORAGE_GET_F_CREATE);
-	if (!storage)
-		return 1;
+	if (!tcp_sk->is_mptcp) {
+		storage = bpf_sk_storage_get(&socket_storage_map, sk, 0,
+					     BPF_SK_STORAGE_GET_F_CREATE);
+		if (!storage)
+			return 1;
+	} else {
+		if (!CONFIG_MPTCP)
+			return 1;
+
+		msk = bpf_skc_to_mptcp_sock(sk);
+		if (!msk)
+			return 1;
 
+		storage = bpf_sk_storage_get(&socket_storage_map, msk, 0,
+					     BPF_SK_STORAGE_GET_F_CREATE);
+		if (!storage)
+			return 1;
+	}
 	storage->invoked++;
 	storage->is_mptcp = tcp_sk->is_mptcp;
 
-- 
2.36.0

