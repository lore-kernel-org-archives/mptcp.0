Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5CFA33FC
	for <mptcp@lists.linux.dev>; Thu, 19 May 2022 23:30:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1653003044; x=1684539044;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=yL57FAH7UrgJbVY5BNbdOK3sEJquq2+jOQ3e/t7En0s=;
  b=b32SF0OsrcnelaI5nlUocMY02AZP3c5uBWhPN394zvGDIoIqeg/dcZ/D
   pPlwkMQJUlFQ0JZ1yA5GAX0yBeyikkLmGJFKVPYcEg+X4Xa2Wy4KBlVa9
   JeUdccEy7Lmvn82yC5TEntCGszqUN5xglz8mVECpJWVcVUhfopZjti1Nw
   79VOgrs8gMPNQOrDsXjgiEqFqm0uJPtdPqe6z4RMp+kTHptOYHSP+GUCa
   IAnMKCsFiOh7A4q0ouEPruXZ9OJS/jNP+r8gCaygGhURWomx33R42esRv
   2kFKndI5kkKlCdN14Ei+yZdxdY+MooPs22FVO3r4EBT2KO5wKXE3wnug+
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10352"; a="272381765"
X-IronPort-AV: E=Sophos;i="5.91,238,1647327600"; 
   d="scan'208";a="272381765"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 May 2022 16:30:22 -0700
X-IronPort-AV: E=Sophos;i="5.91,238,1647327600"; 
   d="scan'208";a="570491197"
Received: from mjmartin-desk2.amr.corp.intel.com (HELO mjmartin-desk2.intel.com) ([10.252.132.179])
  by orsmga007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 May 2022 16:30:21 -0700
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
Subject: [PATCH bpf-next v5 4/7] selftests/bpf: test bpf_skc_to_mptcp_sock
Date: Thu, 19 May 2022 16:30:13 -0700
Message-Id: <20220519233016.105670-5-mathew.j.martineau@linux.intel.com>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20220519233016.105670-1-mathew.j.martineau@linux.intel.com>
References: <20220519233016.105670-1-mathew.j.martineau@linux.intel.com>
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

v4:
 - use ASSERT_* instead of CHECK_FAIL (Andrii)
 - drop bpf_mptcp_helpers.h (Andrii)

v5:
 - some 'ASSERT_*' were replaced in the next commit by mistake.
 - Drop CONFIG_MPTCP (Martin)
 - Use ASSERT_EQ (Andrii)

Acked-by: Matthieu Baerts <matthieu.baerts@tessares.net>
Signed-off-by: Geliang Tang <geliang.tang@suse.com>
Signed-off-by: Mat Martineau <mathew.j.martineau@linux.intel.com>
---
 tools/testing/selftests/bpf/bpf_tcp_helpers.h |  5 ++++
 .../testing/selftests/bpf/prog_tests/mptcp.c  | 27 ++++++++++++++-----
 .../testing/selftests/bpf/progs/mptcp_sock.c  | 19 ++++++++++---
 3 files changed, 41 insertions(+), 10 deletions(-)

diff --git a/tools/testing/selftests/bpf/bpf_tcp_helpers.h b/tools/testing/selftests/bpf/bpf_tcp_helpers.h
index 22e0c8849a17..90fecafc493d 100644
--- a/tools/testing/selftests/bpf/bpf_tcp_helpers.h
+++ b/tools/testing/selftests/bpf/bpf_tcp_helpers.h
@@ -226,4 +226,9 @@ static __always_inline bool tcp_cc_eq(const char *a, const char *b)
 extern __u32 tcp_slow_start(struct tcp_sock *tp, __u32 acked) __ksym;
 extern void tcp_cong_avoid_ai(struct tcp_sock *tp, __u32 w, __u32 acked) __ksym;
 
+struct mptcp_sock {
+	struct inet_connection_sock	sk;
+
+} __attribute__((preserve_access_index));
+
 #endif
diff --git a/tools/testing/selftests/bpf/prog_tests/mptcp.c b/tools/testing/selftests/bpf/prog_tests/mptcp.c
index 7874d8264836..6f333e3aba9c 100644
--- a/tools/testing/selftests/bpf/prog_tests/mptcp.c
+++ b/tools/testing/selftests/bpf/prog_tests/mptcp.c
@@ -12,14 +12,11 @@ struct mptcp_storage {
 	__u32 is_mptcp;
 };
 
-static int verify_sk(int map_fd, int client_fd, __u32 is_mptcp)
+static int verify_tsk(int map_fd, int client_fd)
 {
 	int err, cfd = client_fd;
 	struct mptcp_storage val;
 
-	if (is_mptcp == 1)
-		return 0;
-
 	err = bpf_map_lookup_elem(map_fd, &cfd, &val);
 	if (!ASSERT_OK(err, "bpf_map_lookup_elem"))
 		return err;
@@ -33,6 +30,24 @@ static int verify_sk(int map_fd, int client_fd, __u32 is_mptcp)
 	return err;
 }
 
+static int verify_msk(int map_fd, int client_fd)
+{
+	int err, cfd = client_fd;
+	struct mptcp_storage val;
+
+	err = bpf_map_lookup_elem(map_fd, &cfd, &val);
+	if (!ASSERT_OK(err, "bpf_map_lookup_elem"))
+		return err;
+
+	if (!ASSERT_EQ(val.invoked, 1, "unexpected invoked count"))
+		err++;
+
+	if (!ASSERT_EQ(val.is_mptcp, 1, "unexpected is_mptcp"))
+		err++;
+
+	return err;
+}
+
 static int run_test(int cgroup_fd, int server_fd, bool is_mptcp)
 {
 	int client_fd, prog_fd, map_fd, err;
@@ -64,8 +79,8 @@ static int run_test(int cgroup_fd, int server_fd, bool is_mptcp)
 		goto out;
 	}
 
-	err += is_mptcp ? verify_sk(map_fd, client_fd, 1) :
-			  verify_sk(map_fd, client_fd, 0);
+	err += is_mptcp ? verify_msk(map_fd, client_fd) :
+			  verify_tsk(map_fd, client_fd);
 
 	close(client_fd);
 
diff --git a/tools/testing/selftests/bpf/progs/mptcp_sock.c b/tools/testing/selftests/bpf/progs/mptcp_sock.c
index bc09dba0b078..dc73b3fbb50b 100644
--- a/tools/testing/selftests/bpf/progs/mptcp_sock.c
+++ b/tools/testing/selftests/bpf/progs/mptcp_sock.c
@@ -24,6 +24,7 @@ SEC("sockops")
 int _sockops(struct bpf_sock_ops *ctx)
 {
 	struct mptcp_storage *storage;
+	struct mptcp_sock *msk;
 	int op = (int)ctx->op;
 	struct tcp_sock *tsk;
 	struct bpf_sock *sk;
@@ -41,11 +42,21 @@ int _sockops(struct bpf_sock_ops *ctx)
 		return 1;
 
 	is_mptcp = bpf_core_field_exists(tsk->is_mptcp) ? tsk->is_mptcp : 0;
-	storage = bpf_sk_storage_get(&socket_storage_map, sk, 0,
-				     BPF_SK_STORAGE_GET_F_CREATE);
-	if (!storage)
-		return 1;
+	if (!is_mptcp) {
+		storage = bpf_sk_storage_get(&socket_storage_map, sk, 0,
+					     BPF_SK_STORAGE_GET_F_CREATE);
+		if (!storage)
+			return 1;
+	} else {
+		msk = bpf_skc_to_mptcp_sock(sk);
+		if (!msk)
+			return 1;
 
+		storage = bpf_sk_storage_get(&socket_storage_map, msk, 0,
+					     BPF_SK_STORAGE_GET_F_CREATE);
+		if (!storage)
+			return 1;
+	}
 	storage->invoked++;
 	storage->is_mptcp = is_mptcp;
 
-- 
2.36.1

