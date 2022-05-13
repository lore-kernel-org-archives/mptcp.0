Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 263A3258B
	for <mptcp@lists.linux.dev>; Fri, 13 May 2022 22:48:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1652482119; x=1684018119;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=lAAWLgQZcywB+GB+atlb4GlgXzeDxqNyDVPW19oil1c=;
  b=UbMOex+NipZxbS2ZNirxzgP474p2+unQvA5D0SIqpfe+7tKZTCFarW/2
   ne2STVJ/xPsbuVCsAeyfhYRSronaduJOnk2zQschPZav/4bV1Qr6kKv5e
   tn+6UFIyAzgpjJ5w7725CsJFE+vC/bx9BebleBzXenqiLH+ehCqukOGRg
   3+vt5f62Z99xUkV5QN0Sc+7JwTFQEvvge/Qk4l506S1+8BuZTM8eMERDG
   Vz8AJdqaqY+e/3xn8BpZQ/VEGTmK1Yy6He31d5z9qNa+mdsvkt+3Pm1eM
   tWDrNRfKhMvDz5evgteNGAPoIUvl3Ikiop365NZ5LDjk/w18OjldmXOTY
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10346"; a="333462019"
X-IronPort-AV: E=Sophos;i="5.91,223,1647327600"; 
   d="scan'208";a="333462019"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 May 2022 15:48:35 -0700
X-IronPort-AV: E=Sophos;i="5.91,223,1647327600"; 
   d="scan'208";a="815588254"
Received: from clakshma-mobl1.amr.corp.intel.com (HELO mjmartin-desk2.intel.com) ([10.212.160.121])
  by fmsmga006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 May 2022 15:48:34 -0700
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
Subject: [PATCH bpf-next v4 5/7] selftests/bpf: verify token of struct mptcp_sock
Date: Fri, 13 May 2022 15:48:25 -0700
Message-Id: <20220513224827.662254-6-mathew.j.martineau@linux.intel.com>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20220513224827.662254-1-mathew.j.martineau@linux.intel.com>
References: <20220513224827.662254-1-mathew.j.martineau@linux.intel.com>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Geliang Tang <geliang.tang@suse.com>

This patch verifies the struct member token of struct mptcp_sock. Add a
new function get_msk_token() to parse the msk token from the output of
the command 'ip mptcp monitor', and verify it in verify_msk().

v4:
 - use ASSERT_* instead of CHECK_FAIL (Andrii)
 - skip the test if 'ip mptcp monitor' is not supported (Mat)

Acked-by: Matthieu Baerts <matthieu.baerts@tessares.net>
Signed-off-by: Geliang Tang <geliang.tang@suse.com>
Signed-off-by: Mat Martineau <mathew.j.martineau@linux.intel.com>
---
 tools/testing/selftests/bpf/bpf_tcp_helpers.h |  1 +
 .../testing/selftests/bpf/prog_tests/mptcp.c  | 64 +++++++++++++++++++
 .../testing/selftests/bpf/progs/mptcp_sock.c  |  5 ++
 3 files changed, 70 insertions(+)

diff --git a/tools/testing/selftests/bpf/bpf_tcp_helpers.h b/tools/testing/selftests/bpf/bpf_tcp_helpers.h
index 90fecafc493d..422491872619 100644
--- a/tools/testing/selftests/bpf/bpf_tcp_helpers.h
+++ b/tools/testing/selftests/bpf/bpf_tcp_helpers.h
@@ -229,6 +229,7 @@ extern void tcp_cong_avoid_ai(struct tcp_sock *tp, __u32 w, __u32 acked) __ksym;
 struct mptcp_sock {
 	struct inet_connection_sock	sk;
 
+	__u32		token;
 } __attribute__((preserve_access_index));
 
 #endif
diff --git a/tools/testing/selftests/bpf/prog_tests/mptcp.c b/tools/testing/selftests/bpf/prog_tests/mptcp.c
index 02e7fd8918e6..ac98aa314123 100644
--- a/tools/testing/selftests/bpf/prog_tests/mptcp.c
+++ b/tools/testing/selftests/bpf/prog_tests/mptcp.c
@@ -9,8 +9,11 @@
 struct mptcp_storage {
 	__u32 invoked;
 	__u32 is_mptcp;
+	__u32 token;
 };
 
+static char monitor_log_path[64];
+
 static int verify_tsk(int map_fd, int client_fd)
 {
 	char *msg = "plain TCP socket";
@@ -36,11 +39,52 @@ static int verify_tsk(int map_fd, int client_fd)
 	return err;
 }
 
+/*
+ * Parse the token from the output of 'ip mptcp monitor':
+ *
+ * [       CREATED] token=3ca933d3 remid=0 locid=0 saddr4=127.0.0.1 ...
+ * [       CREATED] token=2ab57040 remid=0 locid=0 saddr4=127.0.0.1 ...
+ */
+static __u32 get_msk_token(void)
+{
+	char *prefix = "[       CREATED] token=";
+	char buf[BUFSIZ] = {};
+	__u32 token = 0;
+	ssize_t len;
+	int fd;
+
+	sync();
+
+	fd = open(monitor_log_path, O_RDONLY);
+	if (!ASSERT_GE(fd, 0, "Failed to open monitor_log_path"))
+		return token;
+
+	len = read(fd, buf, sizeof(buf));
+	if (!ASSERT_GT(len, 0, "Failed to read monitor_log_path"))
+		goto err;
+
+	if (strncmp(buf, prefix, strlen(prefix))) {
+		log_err("Invalid prefix %s", buf);
+		goto err;
+	}
+
+	token = strtol(buf + strlen(prefix), NULL, 16);
+
+err:
+	close(fd);
+	return token;
+}
+
 static int verify_msk(int map_fd, int client_fd)
 {
 	char *msg = "MPTCP subflow socket";
 	int err, cfd = client_fd;
 	struct mptcp_storage val;
+	__u32 token;
+
+	token = get_msk_token();
+	if (!ASSERT_GT(token, 0, "Unexpected token"))
+		return -1;
 
 	err = bpf_map_lookup_elem(map_fd, &cfd, &val);
 	if (!ASSERT_OK(err, "bpf_map_lookup_elem"))
@@ -58,6 +102,12 @@ static int verify_msk(int map_fd, int client_fd)
 		err++;
 	}
 
+	if (val.token != token) {
+		log_err("Unexpected mptcp_sock.token %x != %x",
+			val.token, token);
+		err++;
+	}
+
 	return err;
 }
 
@@ -123,6 +173,7 @@ static int run_test(int cgroup_fd, int server_fd, bool is_mptcp)
 
 void test_base(void)
 {
+	char cmd[256], tmp_dir[] = "/tmp/XXXXXX";
 	int server_fd, cgroup_fd;
 
 	cgroup_fd = test__join_cgroup("/mptcp");
@@ -140,6 +191,17 @@ void test_base(void)
 
 with_mptcp:
 	/* with MPTCP */
+	if (system("ip mptcp help 2>&1 | grep -q monitor")) {
+		test__skip();
+		goto close_cgroup_fd;
+	}
+	if (!ASSERT_OK_PTR(mkdtemp(tmp_dir), "mkdtemp"))
+		goto close_cgroup_fd;
+	snprintf(monitor_log_path, sizeof(monitor_log_path),
+		 "%s/ip_mptcp_monitor", tmp_dir);
+	snprintf(cmd, sizeof(cmd), "ip mptcp monitor > %s &", monitor_log_path);
+	if (!ASSERT_OK(system(cmd), "ip mptcp monitor"))
+		goto close_cgroup_fd;
 	server_fd = start_mptcp_server(AF_INET, NULL, 0, 0);
 	if (!ASSERT_GE(server_fd, 0, "start_mptcp_server"))
 		goto close_cgroup_fd;
@@ -147,6 +209,8 @@ void test_base(void)
 	ASSERT_OK(run_test(cgroup_fd, server_fd, true), "run_test mptcp");
 
 	close(server_fd);
+	snprintf(cmd, sizeof(cmd), "rm -rf %s", tmp_dir);
+	system(cmd);
 
 close_cgroup_fd:
 	close(cgroup_fd);
diff --git a/tools/testing/selftests/bpf/progs/mptcp_sock.c b/tools/testing/selftests/bpf/progs/mptcp_sock.c
index 3feb7ff578e2..4890130826c6 100644
--- a/tools/testing/selftests/bpf/progs/mptcp_sock.c
+++ b/tools/testing/selftests/bpf/progs/mptcp_sock.c
@@ -12,6 +12,7 @@ extern bool CONFIG_MPTCP __kconfig;
 struct mptcp_storage {
 	__u32 invoked;
 	__u32 is_mptcp;
+	__u32 token;
 };
 
 struct {
@@ -48,6 +49,8 @@ int _sockops(struct bpf_sock_ops *ctx)
 					     BPF_SK_STORAGE_GET_F_CREATE);
 		if (!storage)
 			return 1;
+
+		storage->token = 0;
 	} else {
 		if (!CONFIG_MPTCP)
 			return 1;
@@ -60,6 +63,8 @@ int _sockops(struct bpf_sock_ops *ctx)
 					     BPF_SK_STORAGE_GET_F_CREATE);
 		if (!storage)
 			return 1;
+
+		storage->token = msk->token;
 	}
 	storage->invoked++;
 	storage->is_mptcp = is_mptcp;
-- 
2.36.1

