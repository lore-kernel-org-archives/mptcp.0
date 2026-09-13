Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72C9B3BD653
	for <mptcp@lists.linux.dev>; Sun, 13 Sep 2026 10:15:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789294533; cv=none; b=T2K8IswOOge9CtCwj3WqREKHMgucjcHl/NhH48R6p5ivaBm5k9BuDarRvlH4Gb30Bm5hM8NvTKs0yoACYriV107lkuJCNJ4n9EC855xb4guyljqxIW6zIDFuoHa9CcYeUCptiVOJMqFi3rgpdKb4CzKfeZ84lBeqFxjsn9NQGVw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789294533; c=relaxed/simple;
	bh=HVEnPnnpumA9OCH93A5gRXcOnQOVHzetAtq0gickHJA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DWnzlumbOF0iML2c8XSGQL3U3ZgJthaHUTscg0uond0T2n5ZOuVA8R4FLPYUUj66BBckk/+hzMxZgb/hkcIjelertkZwjmoyXBcUagAgiY6jrzSKnz1YbGE9gQpffolM7cQjKpnlEPgsByysHJkNfaBQ6YImdP8YhyHsWwWMbRE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jyk+9kO/; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jyk+9kO/"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 32E201F000FF;
	Sun, 13 Sep 2026 10:15:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789294531;
	bh=UjFuTpymvaVQtQhikpqbeQUg+od0VtOhW5da+fyqNb0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=jyk+9kO/yb++B6D/6HnbECqv7hngh22zB5oBBSL0Jd5ocrC6NaGw+sihdaj3x51fK
	 Ws/uCNNLWGrbqhBWccgs+r5HnKQBhMXFpmj9UjxUOuCs/ZbW++FS6S2pJa+ZdDJulJ
	 tXigsQzRWKlDtVlZ+HMdQ+m5u2FfB6fmIE571kHauAF1z7gxzhOQ+C/KjkU+3aE5wF
	 FF4XxEWCa9xU9G3Ejjs+L2amAJIs24lF/TxyTvVg4n84Z/KCVW8aj+RSzo6hH3UGND
	 KNATgZyeBm7+J9thN2U7KgCZcjX56myXLjd1GP+IjOzn8yupoN7uoNxU9D/UpodZnz
	 Q3eAaHXRytCRw==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next v5 16/16] selftests/bpf: add MPTCP coverage to sockmap_listen
Date: Sun, 13 Sep 2026 18:14:55 +0800
Message-ID: <3857608bd79abf9079a7bebd3d589194bb6433ff.1789294365.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <cover.1789294365.git.tanggeliang@kylinos.cn>
References: <cover.1789294365.git.tanggeliang@kylinos.cn>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Geliang Tang <tanggeliang@kylinos.cn>

Extend sockmap_listen tests to cover MPTCP sockets. Run the full test
suite (ops, redir, reuseport) in both TCP and MPTCP modes, using
IPPROTO_MPTCP for stream sockets when in MPTCP mode. Skip UDP-specific
tests in MPTCP mode. Add a dedicated BPF reuseport program
(prog_reuseport_mptcp) that uses bpf_mptcp_sk_select_reuseport() for
MPTCP-aware reuseport selection. Prefix subtest names with the protocol
(tcp/mptcp) for clarity.

Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
---
 .../selftests/bpf/prog_tests/sockmap_listen.c | 122 +++++++++++-------
 .../selftests/bpf/progs/test_sockmap_listen.c |  25 ++++
 2 files changed, 101 insertions(+), 46 deletions(-)

diff --git a/tools/testing/selftests/bpf/prog_tests/sockmap_listen.c b/tools/testing/selftests/bpf/prog_tests/sockmap_listen.c
index 1c96a3cf4b97..d31f3eb661d6 100644
--- a/tools/testing/selftests/bpf/prog_tests/sockmap_listen.c
+++ b/tools/testing/selftests/bpf/prog_tests/sockmap_listen.c
@@ -31,6 +31,10 @@
 
 #define NO_FLAGS 0
 
+static bool mptcp;
+#define SOTYPE_PROTO(st) \
+	(mptcp && ((st) & SOCK_STREAM) ? IPPROTO_MPTCP : 0)
+
 static void test_insert_invalid(struct test_sockmap_listen *skel __always_unused,
 				int family, int sotype, int mapfd)
 {
@@ -56,7 +60,7 @@ static void test_insert_opened(struct test_sockmap_listen *skel __always_unused,
 	int err, s;
 	u64 value;
 
-	s = xsocket(family, sotype, 0);
+	s = xsocket(family, sotype, SOTYPE_PROTO(sotype));
 	if (s == -1)
 		return;
 
@@ -79,7 +83,7 @@ static void test_insert_bound(struct test_sockmap_listen *skel __always_unused,
 
 	init_addr_loopback(family, &addr, &len);
 
-	s = xsocket(family, sotype, 0);
+	s = xsocket(family, sotype, SOTYPE_PROTO(sotype));
 	if (s == -1)
 		return;
 
@@ -107,7 +111,7 @@ static void test_insert(struct test_sockmap_listen *skel __always_unused,
 	u32 key;
 	int s;
 
-	s = socket_loopback(family, sotype);
+	s = socket_loopback_proto(family, sotype, SOTYPE_PROTO(sotype));
 	if (s < 0)
 		return;
 
@@ -124,7 +128,7 @@ static void test_delete_after_insert(struct test_sockmap_listen *skel __always_u
 	u32 key;
 	int s;
 
-	s = socket_loopback(family, sotype);
+	s = socket_loopback_proto(family, sotype, SOTYPE_PROTO(sotype));
 	if (s < 0)
 		return;
 
@@ -142,7 +146,7 @@ static void test_delete_after_close(struct test_sockmap_listen *skel __always_un
 	u64 value;
 	u32 key;
 
-	s = socket_loopback(family, sotype);
+	s = socket_loopback_proto(family, sotype, SOTYPE_PROTO(sotype));
 	if (s < 0)
 		return;
 
@@ -167,7 +171,7 @@ static void test_lookup_after_insert(struct test_sockmap_listen *skel __always_u
 	u32 key;
 	int s;
 
-	s = socket_loopback(family, sotype);
+	s = socket_loopback_proto(family, sotype, SOTYPE_PROTO(sotype));
 	if (s < 0)
 		return;
 
@@ -195,7 +199,7 @@ static void test_lookup_after_delete(struct test_sockmap_listen *skel __always_u
 	u64 value;
 	u32 key;
 
-	s = socket_loopback(family, sotype);
+	s = socket_loopback_proto(family, sotype, SOTYPE_PROTO(sotype));
 	if (s < 0)
 		return;
 
@@ -218,7 +222,7 @@ static void test_lookup_32_bit_value(struct test_sockmap_listen *skel __always_u
 	u32 key, value32;
 	int err, s;
 
-	s = socket_loopback(family, sotype);
+	s = socket_loopback_proto(family, sotype, SOTYPE_PROTO(sotype));
 	if (s < 0)
 		return;
 
@@ -250,11 +254,11 @@ static void test_update_existing(struct test_sockmap_listen *skel __always_unuse
 	u64 value;
 	u32 key;
 
-	s1 = socket_loopback(family, sotype);
+	s1 = socket_loopback_proto(family, sotype, SOTYPE_PROTO(sotype));
 	if (s1 < 0)
 		return;
 
-	s2 = socket_loopback(family, sotype);
+	s2 = socket_loopback_proto(family, sotype, SOTYPE_PROTO(sotype));
 	if (s2 < 0)
 		goto close_s1;
 
@@ -280,7 +284,7 @@ static void do_destroy_orphan_child(int family, int sotype, int mapfd)
 	u64 value;
 	u32 key;
 
-	s = socket_loopback(family, sotype);
+	s = socket_loopback_proto(family, sotype, SOTYPE_PROTO(sotype));
 	if (s < 0)
 		return;
 
@@ -293,7 +297,7 @@ static void do_destroy_orphan_child(int family, int sotype, int mapfd)
 	value = s;
 	xbpf_map_update_elem(mapfd, &key, &value, BPF_NOEXIST);
 
-	c = xsocket(family, sotype, 0);
+	c = xsocket(family, sotype, SOTYPE_PROTO(sotype));
 	if (c == -1)
 		goto close_srv;
 
@@ -342,7 +346,7 @@ static void test_clone_after_delete(struct test_sockmap_listen *skel __always_un
 	u64 value;
 	u32 key;
 
-	s = socket_loopback(family, sotype);
+	s = socket_loopback_proto(family, sotype, SOTYPE_PROTO(sotype));
 	if (s < 0)
 		return;
 
@@ -356,7 +360,7 @@ static void test_clone_after_delete(struct test_sockmap_listen *skel __always_un
 	xbpf_map_update_elem(mapfd, &key, &value, BPF_NOEXIST);
 	xbpf_map_delete_elem(mapfd, &key);
 
-	c = xsocket(family, sotype, 0);
+	c = xsocket(family, sotype, SOTYPE_PROTO(sotype));
 	if (c < 0)
 		goto close_srv;
 
@@ -379,7 +383,8 @@ static void test_accept_after_delete(struct test_sockmap_listen *skel __always_u
 	socklen_t len;
 	u64 value;
 
-	s = socket_loopback(family, sotype | SOCK_NONBLOCK);
+	s = socket_loopback_proto(family, sotype | SOCK_NONBLOCK,
+				  SOTYPE_PROTO(sotype));
 	if (s == -1)
 		return;
 
@@ -393,7 +398,7 @@ static void test_accept_after_delete(struct test_sockmap_listen *skel __always_u
 	if (err)
 		goto close_srv;
 
-	c = xsocket(family, sotype, 0);
+	c = xsocket(family, sotype, SOTYPE_PROTO(sotype));
 	if (c == -1)
 		goto close_srv;
 
@@ -434,7 +439,8 @@ static void test_accept_before_delete(struct test_sockmap_listen *skel __always_
 	socklen_t len;
 	u64 value;
 
-	s = socket_loopback(family, sotype | SOCK_NONBLOCK);
+	s = socket_loopback_proto(family, sotype | SOCK_NONBLOCK,
+				  SOTYPE_PROTO(sotype));
 	if (s == -1)
 		return;
 
@@ -448,7 +454,7 @@ static void test_accept_before_delete(struct test_sockmap_listen *skel __always_
 	if (err)
 		goto close_srv;
 
-	c = xsocket(family, sotype, 0);
+	c = xsocket(family, sotype, SOTYPE_PROTO(sotype));
 	if (c == -1)
 		goto close_srv;
 
@@ -511,7 +517,7 @@ static void *connect_accept_thread(void *arg)
 	for (i = 0; i < ctx->nr_iter; i++) {
 		int c, p;
 
-		c = xsocket(family, socktype, 0);
+		c = xsocket(family, socktype, SOTYPE_PROTO(socktype));
 		if (c < 0)
 			break;
 
@@ -546,7 +552,8 @@ static void test_syn_recv_insert_delete(struct test_sockmap_listen *skel __alway
 	int err, s;
 	u64 value;
 
-	s = socket_loopback(family, sotype | SOCK_NONBLOCK);
+	s = socket_loopback_proto(family, sotype | SOCK_NONBLOCK,
+				  SOTYPE_PROTO(sotype));
 	if (s < 0)
 		return;
 
@@ -609,7 +616,7 @@ static void test_race_insert_listen(struct test_sockmap_listen *skel __always_un
 	int err, s;
 	u64 value;
 
-	s = xsocket(family, socktype, 0);
+	s = xsocket(family, socktype, SOTYPE_PROTO(socktype));
 	if (s < 0)
 		return;
 
@@ -795,7 +802,8 @@ static void redir_to_listening(int family, int sotype, int sock_mapfd,
 
 	zero_verdict_count(verd_mapfd);
 
-	s = socket_loopback(family, sotype | SOCK_NONBLOCK);
+	s = socket_loopback_proto(family, sotype | SOCK_NONBLOCK,
+				  SOTYPE_PROTO(sotype));
 	if (s < 0)
 		return;
 
@@ -804,7 +812,7 @@ static void redir_to_listening(int family, int sotype, int sock_mapfd,
 	if (err)
 		goto close_srv;
 
-	c = xsocket(family, sotype, 0);
+	c = xsocket(family, sotype, SOTYPE_PROTO(sotype));
 	if (c < 0)
 		goto close_srv;
 	err = xconnect(c, sockaddr(&addr), len);
@@ -984,8 +992,9 @@ static void test_reuseport_select_listening(int family, int sotype,
 
 	zero_verdict_count(verd_map);
 
-	s = socket_loopback_reuseport(family, sotype | SOCK_NONBLOCK,
-				      reuseport_prog);
+	s = socket_loopback_reuseport_proto(family, sotype | SOCK_NONBLOCK,
+					    SOTYPE_PROTO(sotype),
+					    reuseport_prog);
 	if (s < 0)
 		return;
 
@@ -1000,7 +1009,7 @@ static void test_reuseport_select_listening(int family, int sotype,
 	if (err)
 		goto close_srv;
 
-	c = xsocket(family, sotype, 0);
+	c = xsocket(family, sotype, SOTYPE_PROTO(sotype));
 	if (c < 0)
 		goto close_srv;
 	err = xconnect(c, sockaddr(&addr), len);
@@ -1053,7 +1062,9 @@ static void test_reuseport_select_connected(int family, int sotype,
 
 	zero_verdict_count(verd_map);
 
-	s = socket_loopback_reuseport(family, sotype, reuseport_prog);
+	s = socket_loopback_reuseport_proto(family, sotype,
+					    SOTYPE_PROTO(sotype),
+					    reuseport_prog);
 	if (s < 0)
 		return;
 
@@ -1069,7 +1080,7 @@ static void test_reuseport_select_connected(int family, int sotype,
 	if (err)
 		goto close_srv;
 
-	c0 = xsocket(family, sotype, 0);
+	c0 = xsocket(family, sotype, SOTYPE_PROTO(sotype));
 	if (c0 < 0)
 		goto close_srv;
 
@@ -1082,7 +1093,7 @@ static void test_reuseport_select_connected(int family, int sotype,
 		if (p0 < 0)
 			goto close_cli0;
 	} else {
-		p0 = xsocket(family, sotype, 0);
+		p0 = xsocket(family, sotype, SOTYPE_PROTO(sotype));
 		if (p0 < 0)
 			goto close_cli0;
 
@@ -1103,7 +1114,7 @@ static void test_reuseport_select_connected(int family, int sotype,
 	if (err)
 		goto close_peer0;
 
-	c1 = xsocket(family, sotype, 0);
+	c1 = xsocket(family, sotype, SOTYPE_PROTO(sotype));
 	if (c1 < 0)
 		goto close_peer0;
 
@@ -1158,11 +1169,15 @@ static void test_reuseport_mixed_groups(int family, int sotype, int sock_map,
 	zero_verdict_count(verd_map);
 
 	/* Create two listeners, each in its own reuseport group */
-	s1 = socket_loopback_reuseport(family, sotype, reuseport_prog);
+	s1 = socket_loopback_reuseport_proto(family, sotype,
+					     SOTYPE_PROTO(sotype),
+					     reuseport_prog);
 	if (s1 < 0)
 		return;
 
-	s2 = socket_loopback_reuseport(family, sotype, reuseport_prog);
+	s2 = socket_loopback_reuseport_proto(family, sotype,
+					     SOTYPE_PROTO(sotype),
+					     reuseport_prog);
 	if (s2 < 0)
 		goto close_srv1;
 
@@ -1176,7 +1191,7 @@ static void test_reuseport_mixed_groups(int family, int sotype, int sock_map,
 	if (err)
 		goto close_srv2;
 
-	c = xsocket(family, sotype, 0);
+	c = xsocket(family, sotype, SOTYPE_PROTO(sotype));
 	if (c < 0)
 		goto close_srv2;
 
@@ -1272,7 +1287,7 @@ static const char *sotype_str(int sotype)
 	case SOCK_DGRAM:
 		return "UDP";
 	case SOCK_STREAM:
-		return "TCP";
+		return mptcp ? "MPTCP" : "TCP";
 	default:
 		return "unknown";
 	}
@@ -1321,7 +1336,8 @@ static void test_ops(struct test_sockmap_listen *skel, struct bpf_map *map,
 	map_fd = bpf_map__fd(map);
 
 	for (t = tests; t < tests + ARRAY_SIZE(tests); t++) {
-		snprintf(s, sizeof(s), "%s %s %s %s", map_name, family_name,
+		snprintf(s, sizeof(s), "%s %s %s %s %s",
+			 mptcp ? "mptcp" : "tcp", map_name, family_name,
 			 sotype_name, t->name);
 
 		if (t->sotype != 0 && t->sotype != sotype)
@@ -1359,7 +1375,8 @@ static void test_redir(struct test_sockmap_listen *skel, struct bpf_map *map,
 	map_name = map_type_str(map);
 
 	for (t = tests; t < tests + ARRAY_SIZE(tests); t++) {
-		snprintf(s, sizeof(s), "%s %s %s", map_name, family_name,
+		snprintf(s, sizeof(s), "%s %s %s %s",
+			 mptcp ? "mptcp" : "tcp", map_name, family_name,
 			 t->name);
 
 		if (!test__start_subtest(s))
@@ -1393,10 +1410,15 @@ static void test_reuseport(struct test_sockmap_listen *skel,
 
 	socket_map = bpf_map__fd(map);
 	verdict_map = bpf_map__fd(skel->maps.verdict_map);
-	reuseport_prog = bpf_program__fd(skel->progs.prog_reuseport);
+	if (mptcp)
+		reuseport_prog =
+			bpf_program__fd(skel->progs.prog_reuseport_mptcp);
+	else
+		reuseport_prog = bpf_program__fd(skel->progs.prog_reuseport);
 
 	for (t = tests; t < tests + ARRAY_SIZE(tests); t++) {
-		snprintf(s, sizeof(s), "%s %s %s %s", map_name, family_name,
+		snprintf(s, sizeof(s), "%s %s %s %s %s",
+			 mptcp ? "mptcp" : "tcp", map_name, family_name,
 			 sotype_name, t->name);
 
 		if (t->sotype != 0 && t->sotype != sotype)
@@ -1413,10 +1435,14 @@ static void run_tests(struct test_sockmap_listen *skel, struct bpf_map *map,
 		      int family)
 {
 	test_ops(skel, map, family, SOCK_STREAM);
-	test_ops(skel, map, family, SOCK_DGRAM);
 	test_redir(skel, map, family, SOCK_STREAM);
 	test_reuseport(skel, map, family, SOCK_STREAM);
-	test_reuseport(skel, map, family, SOCK_DGRAM);
+
+	/* UDP is unaffected by MPTCP, only run it once (in tcp mode) */
+	if (!mptcp) {
+		test_ops(skel, map, family, SOCK_DGRAM);
+		test_reuseport(skel, map, family, SOCK_DGRAM);
+	}
 }
 
 void serial_test_sockmap_listen(void)
@@ -1429,13 +1455,17 @@ void serial_test_sockmap_listen(void)
 		return;
 	}
 
-	skel->bss->test_sockmap = true;
-	run_tests(skel, skel->maps.sock_map, AF_INET);
-	run_tests(skel, skel->maps.sock_map, AF_INET6);
+	for (int i = 0; i < 2; i++) {
+		mptcp = i;
 
-	skel->bss->test_sockmap = false;
-	run_tests(skel, skel->maps.sock_hash, AF_INET);
-	run_tests(skel, skel->maps.sock_hash, AF_INET6);
+		skel->bss->test_sockmap = true;
+		run_tests(skel, skel->maps.sock_map, AF_INET);
+		run_tests(skel, skel->maps.sock_map, AF_INET6);
+
+		skel->bss->test_sockmap = false;
+		run_tests(skel, skel->maps.sock_hash, AF_INET);
+		run_tests(skel, skel->maps.sock_hash, AF_INET6);
+	}
 
 	test_sockmap_listen__destroy(skel);
 }
diff --git a/tools/testing/selftests/bpf/progs/test_sockmap_listen.c b/tools/testing/selftests/bpf/progs/test_sockmap_listen.c
index b7250eb9c30c..46e9929ba7c4 100644
--- a/tools/testing/selftests/bpf/progs/test_sockmap_listen.c
+++ b/tools/testing/selftests/bpf/progs/test_sockmap_listen.c
@@ -7,6 +7,9 @@
 
 #include <bpf/bpf_helpers.h>
 
+static long (*bpf_mptcp_sk_select_reuseport)(struct sk_reuseport_md *, void *,
+					     void *, __u64) = (void *)213;
+
 struct {
 	__uint(type, BPF_MAP_TYPE_SOCKMAP);
 	__uint(max_entries, 2);
@@ -137,4 +140,26 @@ int prog_reuseport(struct sk_reuseport_md *reuse)
 	return verdict;
 }
 
+SEC("sk_reuseport")
+int prog_reuseport_mptcp(struct sk_reuseport_md *reuse)
+{
+	unsigned int *count;
+	int err, verdict;
+	__u32 zero = 0;
+
+	if (test_sockmap)
+		err = bpf_mptcp_sk_select_reuseport(reuse, &sock_map,
+						    &zero, 0);
+	else
+		err = bpf_mptcp_sk_select_reuseport(reuse, &sock_hash,
+						    &zero, 0);
+	verdict = err ? SK_DROP : SK_PASS;
+
+	count = bpf_map_lookup_elem(&verdict_map, &verdict);
+	if (count)
+		(*count)++;
+
+	return verdict;
+}
+
 char _license[] SEC("license") = "GPL";
-- 
2.53.0

