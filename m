Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 922693672AA
	for <mptcp@lists.linux.dev>; Tue, 30 Jun 2026 09:57:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782813471; cv=none; b=qBZmCq1GZIwLlXZ51GVIKUGEyCq0FpYx5sCe/AqKtxCxtFEzXRflxUgRsMWFbLugXNXe4di6qIRT9OJL7/BffG9nHysvnB5gEC998L9BtMk7AwOw/7IqVnqvadJEjVzHXlKnNhzyuZWG+FzRM2wCUciYL24+5aRTO1Aw2WOC56E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782813471; c=relaxed/simple;
	bh=4hJQrgpMeqRnFVSEa0vN+hj8YtQw8WE/6vL0/gydX+w=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=nTacUPeaTsws+4SNSkh0cBCE8WgflJ7LG7s1kEZdY9dWLc+5bmowW6vixZClR40kVAHM12RWxcXwtyJkkLEw+V0UghU35B2i5ga4Db0CncMbvlSRSU3/VRdfMVQl/jnoqLJ7/TS/2rQwenFpBQgOevo4Q70gv0YF+M2Z/C6hdWc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lgHKmova; arc=none smtp.client-ip=209.85.221.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lgHKmova"
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-463f1165e16so4344504f8f.0
        for <mptcp@lists.linux.dev>; Tue, 30 Jun 2026 02:57:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782813468; x=1783418268; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ddcFhHxm7zIEGmo7ovTKRtISnHGWBs3nbrT2TAxpK5k=;
        b=lgHKmovakMkx3Jvmt9f4ykmMAmCMslrWdH0LM62Bl+5R9pGLiDO2mOAbbJtlc9ArLr
         uZ9r5yTGhJag95zwbps+kVsM/uCz2x9+JOgcNrUcXfI4QG8S1cEWQG03rvVnqlJzq4IK
         BXlIGDVNY315tvfDRZFKctc2nFFySTPTyiU55x9QxW2/+RD22b8GI65bOQwpLkyKTJdy
         R4IVimDpBXi+ZZvZ9bhPn7X1s2c3dkYpSKqrmBKhIoe7zcdb/W4EQQD2L8U0aVPPoD0F
         6ZS9TO1N8YFA5n8ook6xy+rgrCOCNaoA76i9FBsnwa3Bp5KyJCWDybCssTn5oLxak1TJ
         mXpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782813468; x=1783418268;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ddcFhHxm7zIEGmo7ovTKRtISnHGWBs3nbrT2TAxpK5k=;
        b=quVI5c86cBq+wBKypbMT8pm6RV78/9hS3ut+uiYtH6vhenVqfMNLLw3p4EKehohU6E
         nP3b7kpoD1U6EbmQ0zZZRLDN0UdsZh9i0yoIdfRFEPJoxkLaDrdQ8r4TIARAUFoTuuMS
         xGxSK5o50Wyj1TQCa2DR1vjJ7OOJvOtNJBZI3g3biP1ymqs7NdnUNJ9hCsS4/wZKI4Rf
         Uwm3eoweOn/XWvU3I5zjZGooGrOIdJeH2s2z/RUAfZN0Y9Pd3eWcqhAjKeUsYqO2dyA5
         cqTVm8wRW4DNL2GSS5wH/uAaKRrPc/v1nqiFw42s9tdHBmJhO7P/fi2uaJ+HZAwPqoh4
         TIEg==
X-Forwarded-Encrypted: i=1; AHgh+RrX0zbDV/Upl1txNP3ogrzYga/SAQ38ZRmdSxsMT/tUiwKR4IgBX9usXpVsOifCJzYPYQvcNw==@lists.linux.dev
X-Gm-Message-State: AOJu0Yx8ChZ+xXgC/P2oY6zb1CgUglUcyb35D0/8qeZlS7VxzrLGPgCU
	WEBfZ2eoy+CL8MgdR/qVpNmsIVhoItByOlzt4uHUP5WGSXXGGtVmnwSr
X-Gm-Gg: AfdE7cn3wDoHgluBtfOcP0ybujjV6ydGjNXWzhbku5eMyRkYlDiog9DAVBmXYQbabiI
	9RRE+M+STQ4yIjJoNjto+gMQNyVhXsYBU167lNDhAe4tZhA61oUyaMMox0hI1SlWEqgsdBysJbI
	YvbN3P7aQvB4ypTvc3nCXjDE6HFd7chCXD6Idfaj2mi3jw398tpiQTLpJELy0rQl9KU9fvOkPz/
	Xe76ak9PvsrBSY7F+mi1AvIF/cfJJd7+4iENsjlXJOhN42x7ute/1Cm0DjhK4cRpD+PbHhcpSJW
	2VURiH6/yaO3OoJBRBUIRuZhfMLSLbbA3xZ1iBii/oHSzCObe/Ftqk2j+Wjgf05ZOqBvKWpIW4N
	dl/vhRcvB9ngIFZGgzlRFlQj9fNiMQgdi1oT2KF8dpTiJk5fvXTpWsdGnPbmwz2QUFTE5
X-Received: by 2002:a05:6000:24c7:b0:462:7add:607 with SMTP id ffacd0b85a97d-475523b35afmr4107813f8f.25.1782813467863;
        Tue, 30 Jun 2026 02:57:47 -0700 (PDT)
Received: from uberwald ([5.149.140.238])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-475641e4618sm6111708f8f.9.2026.06.30.02.57.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Jun 2026 02:57:46 -0700 (PDT)
From: Guillaume Maudoux <layus.on@gmail.com>
To: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Martin KaFai Lau <martin.lau@linux.dev>
Cc: Eduard Zingerman <eddyz87@gmail.com>,
	Matthieu Baerts <matttbe@kernel.org>,
	Mat Martineau <martineau@kernel.org>,
	Geliang Tang <geliang@kernel.org>,
	Shuah Khan <shuah@kernel.org>,
	bpf@vger.kernel.org,
	mptcp@lists.linux.dev,
	netdev@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Guillaume Maudoux <layus.on@gmail.com>
Subject: [PATCH bpf-next v2] selftests/bpf: Mask socket type flags in mptcpify prog
Date: Tue, 30 Jun 2026 11:57:23 +0200
Message-ID: <20260630095723.564392-1-layus.on@gmail.com>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The mptcpify BPF prog upgrades eligible TCP sockets to MPTCP, but only
when the socket type is exactly SOCK_STREAM. Its update_socket_protocol()
hook runs on the raw type from userspace, before the socket core masks
it with SOCK_TYPE_MASK, so the type may still carry SOCK_CLOEXEC or
SOCK_NONBLOCK in its upper bits and the equality check fails.

As a result, a socket(AF_INET, SOCK_STREAM | SOCK_CLOEXEC, 0) -- what
common libraries do by default -- is silently left as plain TCP. This
was hit in practice with curl. Since mptcpify.c is referenced as example
code for enabling MPTCP transparently, the same mistake is likely to be
copied into real deployments where it fails the same way and is hard to
diagnose.

Mask the type before comparing, mirroring the socket core. Extend the
test to also create the server with SOCK_CLOEXEC set; the same masking
is applied to start_server_addr() so a flagged type still listens.

Fixes: ddba122428a7 ("selftests/bpf: Add mptcpify test")
Signed-off-by: Guillaume Maudoux <layus.on@gmail.com>
---
Changes in v2:
- Use my real name in the Signed-off-by (the "@" broke git am).
- Add "bpf-next" to the subject prefix so the CI tests it.
- Simplify the test: drop the type[] array and loop, keep two
  explicit run_mptcpify() calls (plain and SOCK_CLOEXEC).
- Tighten the commit message.

 tools/testing/selftests/bpf/network_helpers.c       |  4 ++--
 tools/testing/selftests/bpf/network_helpers.h       |  5 +++++
 tools/testing/selftests/bpf/prog_tests/mptcp.c      | 13 ++++++++++---
 tools/testing/selftests/bpf/progs/bpf_tracing_net.h |  3 +++
 tools/testing/selftests/bpf/progs/mptcpify.c        |  2 +-
 5 files changed, 21 insertions(+), 6 deletions(-)

diff --git a/tools/testing/selftests/bpf/network_helpers.c b/tools/testing/selftests/bpf/network_helpers.c
index b82f572641b7..db935a9d9fc1 100644
--- a/tools/testing/selftests/bpf/network_helpers.c
+++ b/tools/testing/selftests/bpf/network_helpers.c
@@ -111,7 +111,7 @@ int start_server_addr(int type, const struct sockaddr_storage *addr, socklen_t a
 	if (settimeo(fd, opts->timeout_ms))
 		goto error_close;
 
-	if (type == SOCK_STREAM &&
+	if ((type & SOCK_TYPE_MASK) == SOCK_STREAM &&
 	    setsockopt(fd, SOL_SOCKET, SO_REUSEADDR, &on, sizeof(on))) {
 		log_err("Failed to enable SO_REUSEADDR");
 		goto error_close;
@@ -128,7 +128,7 @@ int start_server_addr(int type, const struct sockaddr_storage *addr, socklen_t a
 		goto error_close;
 	}
 
-	if (type == SOCK_STREAM) {
+	if ((type & SOCK_TYPE_MASK) == SOCK_STREAM) {
 		if (listen(fd, opts->backlog ? MAX(opts->backlog, 0) : 1) < 0) {
 			log_err("Failed to listed on socket");
 			goto error_close;
diff --git a/tools/testing/selftests/bpf/network_helpers.h b/tools/testing/selftests/bpf/network_helpers.h
index 79a010c88e11..75133119c04a 100644
--- a/tools/testing/selftests/bpf/network_helpers.h
+++ b/tools/testing/selftests/bpf/network_helpers.h
@@ -25,6 +25,11 @@ typedef __u16 __sum16;
 #define VIP_NUM 5
 #define MAGIC_BYTES 123
 
+/* include/linux/net.h */
+#ifndef SOCK_TYPE_MASK
+#define SOCK_TYPE_MASK 0xf
+#endif
+
 struct network_helper_opts {
 	int timeout_ms;
 	int proto;
diff --git a/tools/testing/selftests/bpf/prog_tests/mptcp.c b/tools/testing/selftests/bpf/prog_tests/mptcp.c
index 8fade8bdc451..32dfc1c511af 100644
--- a/tools/testing/selftests/bpf/prog_tests/mptcp.c
+++ b/tools/testing/selftests/bpf/prog_tests/mptcp.c
@@ -264,7 +264,7 @@ static int verify_mptcpify(int server_fd, int client_fd)
 	return err;
 }
 
-static int run_mptcpify(int cgroup_fd)
+static int run_mptcpify(int cgroup_fd, int type)
 {
 	int server_fd, client_fd, err = 0;
 	struct mptcpify *mptcpify_skel;
@@ -280,7 +280,7 @@ static int run_mptcpify(int cgroup_fd)
 		goto out;
 
 	/* without MPTCP */
-	server_fd = start_server(AF_INET, SOCK_STREAM, NULL, 0, 0);
+	server_fd = start_server(AF_INET, type, NULL, 0, 0);
 	if (!ASSERT_GE(server_fd, 0, "start_server")) {
 		err = -EIO;
 		goto out;
@@ -317,7 +317,14 @@ static void test_mptcpify(void)
 	if (!ASSERT_OK_PTR(netns, "netns_new"))
 		goto fail;
 
-	ASSERT_OK(run_mptcpify(cgroup_fd), "run_mptcpify");
+	ASSERT_OK(run_mptcpify(cgroup_fd, SOCK_STREAM), "run_mptcpify");
+	/* userspace sets flags such as SOCK_CLOEXEC together with the type;
+	 * the BPF prog must still upgrade the socket to MPTCP. See
+	 * update_socket_protocol() in net/socket.c, which runs before the
+	 * type is masked with SOCK_TYPE_MASK.
+	 */
+	ASSERT_OK(run_mptcpify(cgroup_fd, SOCK_STREAM | SOCK_CLOEXEC),
+		  "run_mptcpify_cloexec");
 
 fail:
 	netns_free(netns);
diff --git a/tools/testing/selftests/bpf/progs/bpf_tracing_net.h b/tools/testing/selftests/bpf/progs/bpf_tracing_net.h
index d8dacef37c16..c4b438854565 100644
--- a/tools/testing/selftests/bpf/progs/bpf_tracing_net.h
+++ b/tools/testing/selftests/bpf/progs/bpf_tracing_net.h
@@ -8,6 +8,9 @@
 #define AF_INET			2
 #define AF_INET6		10
 
+/* include/linux/net.h */
+#define SOCK_TYPE_MASK		0xf
+
 #define SOL_SOCKET		1
 #define SO_REUSEADDR		2
 #define SO_SNDBUF		7
diff --git a/tools/testing/selftests/bpf/progs/mptcpify.c b/tools/testing/selftests/bpf/progs/mptcpify.c
index cbdc730c3a47..e3f8cb54dbe9 100644
--- a/tools/testing/selftests/bpf/progs/mptcpify.c
+++ b/tools/testing/selftests/bpf/progs/mptcpify.c
@@ -15,7 +15,7 @@ int BPF_PROG(mptcpify, int family, int type, int protocol)
 		return protocol;
 
 	if ((family == AF_INET || family == AF_INET6) &&
-	    type == SOCK_STREAM &&
+	    (type & SOCK_TYPE_MASK) == SOCK_STREAM &&
 	    (!protocol || protocol == IPPROTO_TCP)) {
 		return IPPROTO_MPTCP;
 	}
-- 
2.54.0

