Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A3331FAA
	for <mptcp@lists.linux.dev>; Fri, 29 Apr 2022 22:02:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1651269747; x=1682805747;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=46TkvwVe6kT2QHU1dppM94+iRV+lM/Q9yXNhuJoxKAY=;
  b=McozTu7mP+m7Wj/zr2hebE5NMezShD07N9IzXhNx64HOrV4KRzH1JXRn
   4ptZMl8wVkNG2g2I3C7OXk3op20MGTJGEEGunatdvvtOwdkG5fX4Yi4Gk
   YQE6ExxQgqDBFm0rZPE2D64LChQQA9qNpox4n3vOQWHfYyQkhXqw+tROk
   lTjFaSshV76ZQeNGosMOrkf2D8esL+nNbApD1pcfkx7L2D4nWiKBxHH1Z
   SXdPn8sPjWIumZHJX/aVgVdYEFtdq8N48SIW3p+ZVB0iMGg6luLPUaKya
   oGN3EJUyyrMlCjIYB25hcwrvOXLzwBpcAXIScCnS1V9nxHwS3si+/mDrN
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10332"; a="246698331"
X-IronPort-AV: E=Sophos;i="5.91,186,1647327600"; 
   d="scan'208";a="246698331"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Apr 2022 15:02:10 -0700
X-IronPort-AV: E=Sophos;i="5.91,186,1647327600"; 
   d="scan'208";a="582419805"
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
Subject: [PATCH bpf-next v2 8/8] selftests: bpf: verify first of struct mptcp_sock
Date: Fri, 29 Apr 2022 15:02:04 -0700
Message-Id: <20220429220204.353225-9-mathew.j.martineau@linux.intel.com>
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

This patch verifies the 'first' struct member of struct mptcp_sock, which
points to the first subflow of msk. Save 'sk' in mptcp_storage, and verify
it with 'first' in verify_msk().

Acked-by: Matthieu Baerts <matthieu.baerts@tessares.net>
Signed-off-by: Geliang Tang <geliang.tang@suse.com>
Signed-off-by: Mat Martineau <mathew.j.martineau@linux.intel.com>
---
 tools/testing/selftests/bpf/bpf_mptcp_helpers.h | 1 +
 tools/testing/selftests/bpf/prog_tests/mptcp.c  | 8 ++++++++
 tools/testing/selftests/bpf/progs/mptcp_sock.c  | 5 +++++
 3 files changed, 14 insertions(+)

diff --git a/tools/testing/selftests/bpf/bpf_mptcp_helpers.h b/tools/testing/selftests/bpf/bpf_mptcp_helpers.h
index 463e4e061c96..b5a43b108982 100644
--- a/tools/testing/selftests/bpf/bpf_mptcp_helpers.h
+++ b/tools/testing/selftests/bpf/bpf_mptcp_helpers.h
@@ -10,6 +10,7 @@ struct mptcp_sock {
 	struct inet_connection_sock	sk;
 
 	__u32		token;
+	struct sock	*first;
 	char		ca_name[TCP_CA_NAME_MAX];
 } __attribute__((preserve_access_index));
 
diff --git a/tools/testing/selftests/bpf/prog_tests/mptcp.c b/tools/testing/selftests/bpf/prog_tests/mptcp.c
index 4518aa6e661e..7e704f5aab05 100644
--- a/tools/testing/selftests/bpf/prog_tests/mptcp.c
+++ b/tools/testing/selftests/bpf/prog_tests/mptcp.c
@@ -12,7 +12,9 @@
 struct mptcp_storage {
 	__u32 invoked;
 	__u32 is_mptcp;
+	struct sock *sk;
 	__u32 token;
+	struct sock *first;
 	char ca_name[TCP_CA_NAME_MAX];
 };
 
@@ -133,6 +135,12 @@ static int verify_msk(int map_fd, int client_fd)
 		err++;
 	}
 
+	if (val.first != val.sk) {
+		log_err("Unexpected mptcp_sock.first %p != %p",
+			val.first, val.sk);
+		err++;
+	}
+
 	if (strncmp(val.ca_name, ca_name, TCP_CA_NAME_MAX)) {
 		log_err("Unexpected mptcp_sock.ca_name %s != %s",
 			val.ca_name, ca_name);
diff --git a/tools/testing/selftests/bpf/progs/mptcp_sock.c b/tools/testing/selftests/bpf/progs/mptcp_sock.c
index 226571673800..b1e7f3b4330a 100644
--- a/tools/testing/selftests/bpf/progs/mptcp_sock.c
+++ b/tools/testing/selftests/bpf/progs/mptcp_sock.c
@@ -13,7 +13,9 @@ extern bool CONFIG_MPTCP __kconfig;
 struct mptcp_storage {
 	__u32 invoked;
 	__u32 is_mptcp;
+	struct sock *sk;
 	__u32 token;
+	struct sock *first;
 	char ca_name[TCP_CA_NAME_MAX];
 };
 
@@ -52,6 +54,7 @@ int _sockops(struct bpf_sock_ops *ctx)
 
 		storage->token = 0;
 		bzero(storage->ca_name, TCP_CA_NAME_MAX);
+		storage->first = NULL;
 	} else {
 		if (!CONFIG_MPTCP)
 			return 1;
@@ -67,9 +70,11 @@ int _sockops(struct bpf_sock_ops *ctx)
 
 		storage->token = msk->token;
 		memcpy(storage->ca_name, msk->ca_name, TCP_CA_NAME_MAX);
+		storage->first = msk->first;
 	}
 	storage->invoked++;
 	storage->is_mptcp = tcp_sk->is_mptcp;
+	storage->sk = (struct sock *)sk;
 
 	return 1;
 }
-- 
2.36.0

