Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C69161FA7
	for <mptcp@lists.linux.dev>; Fri, 29 Apr 2022 22:02:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1651269746; x=1682805746;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=aLkF5iautQtoCByDZ1EM15ok+OCMKaaRGi5jkl6MJpQ=;
  b=GxRDfNvr9yXCC/pn5bbHhhfk3j/AS/4KT5NeTwgjk1MU3kDZGM6sbZ8G
   FUFInemE3tye9+WjtY7tJKMJ/QT+0SPxXyZhsBuLSXAvePGyS94NwcqTo
   ploj2c4hrDRWySMsWwyo1GLM8AukTGIi5Mn78kLp2Mbmxaywv44mtbvhH
   ePSZG62bahj+Ic0L5NdGfRqifc5UtlsFwxXQk7xQhrO4vIc5Im20sBFkn
   njfzH0n7sZKltQTtCXnvsNdxMDlkXAcZeum53i2UvUAFzITS1UXKtkO3P
   veXK+x9PRn6da3OEI2dcPYyfyd24vMJG4TtfJkr9KKMAgaIt3ZKRXJH7b
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10332"; a="246698330"
X-IronPort-AV: E=Sophos;i="5.91,186,1647327600"; 
   d="scan'208";a="246698330"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Apr 2022 15:02:10 -0700
X-IronPort-AV: E=Sophos;i="5.91,186,1647327600"; 
   d="scan'208";a="582419804"
Received: from mjmartin-desk2.amr.corp.intel.com (HELO mjmartin-desk2.intel.com) ([10.212.217.201])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Apr 2022 15:02:10 -0700
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
Subject: [PATCH bpf-next v2 7/8] selftests: bpf: verify ca_name of struct mptcp_sock
Date: Fri, 29 Apr 2022 15:02:03 -0700
Message-Id: <20220429220204.353225-8-mathew.j.martineau@linux.intel.com>
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

From: Geliang Tang <geliang.tang@suse.com>

This patch verifies another member of struct mptcp_sock, ca_name. Add a
new function get_msk_ca_name() to read the sysctl tcp_congestion_control
and verify it in verify_msk().

Acked-by: Matthieu Baerts <matthieu.baerts@tessares.net>
Signed-off-by: Geliang Tang <geliang.tang@suse.com>
Signed-off-by: Mat Martineau <mathew.j.martineau@linux.intel.com>
---
 .../testing/selftests/bpf/bpf_mptcp_helpers.h |  1 +
 tools/testing/selftests/bpf/bpf_tcp_helpers.h |  4 ++++
 .../testing/selftests/bpf/prog_tests/mptcp.c  | 24 +++++++++++++++++++
 .../testing/selftests/bpf/progs/mptcp_sock.c  |  4 ++++
 4 files changed, 33 insertions(+)

diff --git a/tools/testing/selftests/bpf/bpf_mptcp_helpers.h b/tools/testing/selftests/bpf/bpf_mptcp_helpers.h
index 87e15810997d..463e4e061c96 100644
--- a/tools/testing/selftests/bpf/bpf_mptcp_helpers.h
+++ b/tools/testing/selftests/bpf/bpf_mptcp_helpers.h
@@ -10,6 +10,7 @@ struct mptcp_sock {
 	struct inet_connection_sock	sk;
 
 	__u32		token;
+	char		ca_name[TCP_CA_NAME_MAX];
 } __attribute__((preserve_access_index));
 
 #endif
diff --git a/tools/testing/selftests/bpf/bpf_tcp_helpers.h b/tools/testing/selftests/bpf/bpf_tcp_helpers.h
index b1ede6f0b821..89750d732cfa 100644
--- a/tools/testing/selftests/bpf/bpf_tcp_helpers.h
+++ b/tools/testing/selftests/bpf/bpf_tcp_helpers.h
@@ -16,6 +16,10 @@ BPF_PROG(name, args)
 #define SOL_TCP 6
 #endif
 
+#ifndef TCP_CA_NAME_MAX
+#define TCP_CA_NAME_MAX	16
+#endif
+
 #define tcp_jiffies32 ((__u32)bpf_jiffies64())
 
 struct sock_common {
diff --git a/tools/testing/selftests/bpf/prog_tests/mptcp.c b/tools/testing/selftests/bpf/prog_tests/mptcp.c
index c5d96ba81e04..4518aa6e661e 100644
--- a/tools/testing/selftests/bpf/prog_tests/mptcp.c
+++ b/tools/testing/selftests/bpf/prog_tests/mptcp.c
@@ -5,10 +5,15 @@
 #include "cgroup_helpers.h"
 #include "network_helpers.h"
 
+#ifndef TCP_CA_NAME_MAX
+#define TCP_CA_NAME_MAX	16
+#endif
+
 struct mptcp_storage {
 	__u32 invoked;
 	__u32 is_mptcp;
 	__u32 token;
+	char ca_name[TCP_CA_NAME_MAX];
 };
 
 static char monitor_log_path[64];
@@ -79,11 +84,22 @@ static __u32 get_msk_token(void)
 	return token;
 }
 
+void get_msk_ca_name(char ca_name[])
+{
+	FILE *stream = popen("sysctl -b net.ipv4.tcp_congestion_control", "r");
+
+	if (!fgets(ca_name, TCP_CA_NAME_MAX, stream))
+		log_err("Failed to read ca_name");
+
+	pclose(stream);
+}
+
 static int verify_msk(int map_fd, int client_fd)
 {
 	char *msg = "MPTCP subflow socket";
 	int err = 0, cfd = client_fd;
 	struct mptcp_storage val;
+	char ca_name[TCP_CA_NAME_MAX];
 	__u32 token;
 
 	token = get_msk_token();
@@ -92,6 +108,8 @@ static int verify_msk(int map_fd, int client_fd)
 		return -1;
 	}
 
+	get_msk_ca_name(ca_name);
+
 	if (CHECK_FAIL(bpf_map_lookup_elem(map_fd, &cfd, &val) < 0)) {
 		perror("Failed to read socket storage");
 		return -1;
@@ -115,6 +133,12 @@ static int verify_msk(int map_fd, int client_fd)
 		err++;
 	}
 
+	if (strncmp(val.ca_name, ca_name, TCP_CA_NAME_MAX)) {
+		log_err("Unexpected mptcp_sock.ca_name %s != %s",
+			val.ca_name, ca_name);
+		err++;
+	}
+
 	return err;
 }
 
diff --git a/tools/testing/selftests/bpf/progs/mptcp_sock.c b/tools/testing/selftests/bpf/progs/mptcp_sock.c
index c58c191d8416..226571673800 100644
--- a/tools/testing/selftests/bpf/progs/mptcp_sock.c
+++ b/tools/testing/selftests/bpf/progs/mptcp_sock.c
@@ -1,6 +1,7 @@
 // SPDX-License-Identifier: GPL-2.0
 /* Copyright (c) 2020, Tessares SA. */
 
+#include <string.h>
 #include <linux/bpf.h>
 #include <bpf/bpf_helpers.h>
 #include "bpf_mptcp_helpers.h"
@@ -13,6 +14,7 @@ struct mptcp_storage {
 	__u32 invoked;
 	__u32 is_mptcp;
 	__u32 token;
+	char ca_name[TCP_CA_NAME_MAX];
 };
 
 struct {
@@ -49,6 +51,7 @@ int _sockops(struct bpf_sock_ops *ctx)
 			return 1;
 
 		storage->token = 0;
+		bzero(storage->ca_name, TCP_CA_NAME_MAX);
 	} else {
 		if (!CONFIG_MPTCP)
 			return 1;
@@ -63,6 +66,7 @@ int _sockops(struct bpf_sock_ops *ctx)
 			return 1;
 
 		storage->token = msk->token;
+		memcpy(storage->ca_name, msk->ca_name, TCP_CA_NAME_MAX);
 	}
 	storage->invoked++;
 	storage->is_mptcp = tcp_sk->is_mptcp;
-- 
2.36.0

