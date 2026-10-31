Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793486697;
	b=Tt6gvBZCphzgSPkXjx5XNCncc7JYeNbwuA1oSGcAbdXlBhcqhcGVDGML4KfZKh1H0vwQ
	 vv0psz5z8AoWnXpO8xzqoEwry4ozJM6ER/QtteocJdIKZPUaScB/6+7aDp/FlRpM45/sV
	 /IoZIZPWp5lMvd/DCGgXwrCh8eMq/TobLLXoHY4GudQvnpqWoFv2nN2fukpxdOcmHoGFo
	 fIW8Y4FyHihK0WBXJiSFrRhBsKjG3zj0SkErMGcL5zQoyVnajKZM3VXvW90AS0FV2E4RR
	 hB6+tIHM7BNPl5kJhq7RPWS/WzfRw6D+vD5tUYLMWaRdfLXksdf8rfpQBhpGOxbOFQg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793486697;
	h=Received:DKIM-Signature:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer:X-Developer-Signature:X-Developer-Key;
	bh=V2WZ/Ki4/Mq0LrUBHHhSD5OcHa9ZckCLSE/1phyhIYk=;
	b=GIOYFS0quWeATE3pg+Zq2cT2DFHqfD7Q9csEve4piLVei5s+KJjdX2iPSwym7lYStHbU
	 n9FvuHnn4+HxUsM3pXRLNb9nnS40p2sN10lXbwGJqiFlmKdwf4KCRYEZw+q6Aorj4EP+A
	 tEJaQMMv3GCDD1BOdlcb0ICU0MF8dQ7F+4LF7jBd6YUMYE+gh2ebHccKxM2vGX3eV0Z5V
	 CzfJlBnnl6j3FxD4PTKKrehn3EWJwTlw95J1B+EjX794Y6lVfTOq625Zey0wQwkkIsnAo
	 bDjT6kKKv4m4nrbRF+YubvKb1yRB6s7cyyGO/D9kwkMTIhsPmZOYG6KMYtZFJDXEtzw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=SE1fbL3s;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63DCF606A31A
	for <mptcp@lists.linux.dev>; Sat, 31 Oct 2026 22:44:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=SE1fbL3s
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A4AA11F00A15;
	Sat, 31 Oct 2026 22:44:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793486697;
	bh=V2WZ/Ki4/Mq0LrUBHHhSD5OcHa9ZckCLSE/1phyhIYk=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=SE1fbL3sm6QZ2ovm8yeK9oJfZ7DNoCy1+26PVwSK4bhqFhVfZqCX+iiu4KnUWDam3
	 /glUGo9Cd4Du/SEFGZnrnu+n9rXK456Roh9KrzA3CL11bFr3i3uDZCBxPYSkhwEt31
	 o8iQu2JOxPx/tRDi485XPgoWsgq9jAzBQUnIokGm3LsVjBAjn5tnHMPBZMWB7j6pO4
	 bApMFue+BaTF98kBJDZFv1BhWPpo+V1+oy8L/lxvDzxAq8ps4taHaPQhaO2OFyVahH
	 6LJN1Fe0vPZDux6FUqMNNg77gmKrYZGoCuBpXN4g1ImZizQfXlDLLaQ0wVaSQoyvdL
	 R+1HoF/P0MCnw==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Sat, 31 Oct 2026 23:44:39 +0100
Subject: [PATCH mptcp-next v2 7/8] selftests: bpf: mptcp: test the send
 limit of a scheduler
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Post: <mailto:mptcp@lists.linux.dev>
List-Help: <mailto:mptcp+help@lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
List-Owner: <mailto:mptcp+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261031-mptcp-sched-opp-retrans-v2-7-e9c4a30f6841@kernel.org>
References: <20261031-mptcp-sched-opp-retrans-v2-0-e9c4a30f6841@kernel.org>
In-Reply-To: <20261031-mptcp-sched-opp-retrans-v2-0-e9c4a30f6841@kernel.org>
To: MPTCP Linux <mptcp@lists.linux.dev>
Cc: Abdul Wasey <w453y.me@gmail.com>, 
 "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=7036; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=K/1YrW4aZ4fWr6dD9zpdbZUEockaVQeD1DXbN6gQVOQ=;
 b=owGbwMvMwCVWo/Th0Gd3rumMp9WSGLKe5Sdcali4i6U7/orxRK62HTwMbe1Vr+y+dUbfODW9K
 7mpoHFGRykLgxgXg6yYIot0W2T+zOdVvCVefhYwc1iZQIYwcHEKwERk+BgZPuyQz5u/V7S1Vnyq
 kqLqgp+Puzcl/U05Old17jXTV6IMqgz/M9n1j2zy2T9JeN2SgPXrGp4ea3IPePw2iXGJ68PvX/0
 u8wMA
X-Developer-Key: i=matttbe@kernel.org; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

From: Abdul Wasey <w453y.me@gmail.com>

Add bpf_limit, a round robin scheduler that sets send_limit to 4 KB on
the subflow it picks, and a test checking that no subflow gets more than
that between two calls of get_send. The scheduler measures it from the
subflow's write_seq, at each call, for the subflow it picked last time.
An MPTCP-level retransmission is not counted: it does not come from
get_send.

The data is written in 64 KB chunks, so that a dfrag is larger than the
limit. With 1.5 KB writes, as send_recv_data() does, no decision is given
more than 4 KB anyway, and the limit is not tested. Without the limit
applied in __subflow_push_pending(), a subflow got 32728 bytes in one
decision.

Signed-off-by: Abdul Wasey <w453y.me@gmail.com>
---
 tools/testing/selftests/bpf/prog_tests/mptcp.c     | 106 +++++++++++++++++++++
 .../testing/selftests/bpf/progs/mptcp_bpf_limit.c  |  94 ++++++++++++++++++
 2 files changed, 200 insertions(+)

diff --git a/tools/testing/selftests/bpf/prog_tests/mptcp.c b/tools/testing/selftests/bpf/prog_tests/mptcp.c
index d77c9f8c53c7..4302c16cb6bb 100644
--- a/tools/testing/selftests/bpf/prog_tests/mptcp.c
+++ b/tools/testing/selftests/bpf/prog_tests/mptcp.c
@@ -18,6 +18,7 @@
 #include "mptcp_bpf_rr.skel.h"
 #include "mptcp_bpf_red.skel.h"
 #include "mptcp_bpf_burst.skel.h"
+#include "mptcp_bpf_limit.skel.h"
 
 #define NS_TEST "mptcp_ns"
 #define ADDR_1	"10.0.1.1"
@@ -820,6 +821,109 @@ static void test_burst(void)
 	mptcp_bpf_burst__destroy(skel);
 }
 
+struct big_send_arg {
+	int lfd;
+	int err;
+};
+
+/* send total_bytes in 64 KB writes, so that data fragments get larger than
+ * the scheduler's limit
+ */
+static void *big_send(void *data)
+{
+	struct big_send_arg *a = data;
+	static char buf[64 * 1024];
+	unsigned int sent = 0;
+	ssize_t ret;
+	int fd;
+
+	fd = accept(a->lfd, NULL, NULL);
+	if (fd < 0) {
+		a->err = -errno;
+		return NULL;
+	}
+	while (sent < total_bytes) {
+		ret = send(fd, buf, MIN(total_bytes - sent, sizeof(buf)), 0);
+		if (ret < 0 && errno == EINTR)
+			continue;
+		if (ret < 0) {
+			a->err = -errno;
+			break;
+		}
+		sent += ret;
+	}
+	close(fd);
+	return NULL;
+}
+
+/* At most 4 KB per decision, also inside a data fragment: no subflow gets
+ * more than that between two calls of the scheduler.
+ */
+static void test_limit(void)
+{
+	struct big_send_arg arg = {};
+	struct mptcp_bpf_limit *skel;
+	int server_fd = -1, client_fd = -1;
+	struct netns_obj *netns = NULL;
+	unsigned int recvd = 0;
+	struct bpf_link *link;
+	pthread_t thread;
+	char buf[64 * 1024];
+	ssize_t ret;
+
+	skel = mptcp_bpf_limit__open_and_load();
+	if (!ASSERT_OK_PTR(skel, "open_and_load: limit"))
+		return;
+
+	link = bpf_map__attach_struct_ops(skel->maps.limit);
+	if (!ASSERT_OK_PTR(link, "attach_struct_ops"))
+		goto destroy;
+
+	netns = netns_new(NS_TEST, true);
+	if (!ASSERT_OK_PTR(netns, "netns_new"))
+		goto detach;
+	if (!ASSERT_OK(sched_init("subflow", "bpf_limit"), "sched_init"))
+		goto close_netns;
+
+	server_fd = start_mptcp_server(AF_INET, ADDR_1, PORT_1, 0);
+	if (!ASSERT_OK_FD(server_fd, "start_mptcp_server"))
+		goto close_netns;
+	client_fd = connect_to_fd(server_fd, 0);
+	if (!ASSERT_OK_FD(client_fd, "connect_to_fd"))
+		goto close_server;
+
+	arg.lfd = server_fd;
+	if (!ASSERT_OK(pthread_create(&thread, NULL, big_send, &arg),
+		       "pthread_create"))
+		goto close_client;
+	while (recvd < total_bytes) {
+		ret = recv(client_fd, buf, sizeof(buf), 0);
+		if (ret < 0 && errno == EINTR)
+			continue;
+		if (ret <= 0)
+			break;
+		recvd += ret;
+	}
+	pthread_join(thread, NULL);
+
+	ASSERT_OK(arg.err, "send");
+	ASSERT_EQ(recvd, total_bytes, "recv");
+	CHECK(has_bytes_sent(ADDR_2), "limit", "should have bytes_sent on addr2\n");
+	ASSERT_GT(skel->bss->max_given, 0, "bytes given per decision");
+	ASSERT_LE(skel->bss->max_given, 4096, "bytes given per decision");
+
+close_client:
+	close(client_fd);
+close_server:
+	close(server_fd);
+close_netns:
+	netns_free(netns);
+detach:
+	bpf_link__destroy(link);
+destroy:
+	mptcp_bpf_limit__destroy(skel);
+}
+
 void test_mptcp(void)
 {
 	if (test__start_subtest("base"))
@@ -842,4 +946,6 @@ void test_mptcp(void)
 		test_red();
 	if (test__start_subtest("burst"))
 		test_burst();
+	if (test__start_subtest("limit"))
+		test_limit();
 }
diff --git a/tools/testing/selftests/bpf/progs/mptcp_bpf_limit.c b/tools/testing/selftests/bpf/progs/mptcp_bpf_limit.c
new file mode 100644
index 000000000000..431f07d6b669
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/mptcp_bpf_limit.c
@@ -0,0 +1,94 @@
+// SPDX-License-Identifier: GPL-2.0
+
+#include "mptcp_bpf.h"
+#include <bpf/bpf_tracing.h>
+
+char _license[] SEC("license") = "GPL";
+
+#define LIMIT	4096
+
+__u64 calls = 0;
+/* the most bytes a subflow was given for one decision */
+__u32 max_given = 0;
+
+/* the subflow picked last time, by position, and its write_seq then */
+int last_pick = -1;
+__u32 last_seq = 0;
+
+SEC("struct_ops")
+void BPF_PROG(mptcp_sched_limit_init, struct mptcp_sock *msk)
+{
+}
+
+SEC("struct_ops")
+void BPF_PROG(mptcp_sched_limit_release, struct mptcp_sock *msk)
+{
+}
+
+/* round robin, at most LIMIT bytes per decision */
+SEC("struct_ops")
+int BPF_PROG(bpf_limit_get_send, struct mptcp_sock *msk)
+{
+	struct mptcp_subflow_context *subflow, *first = NULL, *pick = NULL;
+	const struct tcp_sock *tp;
+	__u64 n = calls++;
+	struct sock *ssk;
+	int i = 0, p = 0;
+
+	bpf_for_each(mptcp_subflow, subflow, (struct sock *)msk) {
+		if (i == last_pick) {
+			ssk = bpf_mptcp_subflow_tcp_sock(subflow);
+			tp = ssk ? bpf_skc_to_tcp_sock(ssk) : NULL;
+			if (tp && tp->write_seq - last_seq > max_given)
+				max_given = tp->write_seq - last_seq;
+		}
+		if (!first)
+			first = subflow;
+		if (!pick && i == (n & 1)) {
+			pick = subflow;
+			p = i;
+		}
+		i++;
+	}
+	/* a single subflow so far */
+	if (!pick) {
+		pick = first;
+		p = 0;
+	}
+	if (!pick)
+		return -1;
+
+	ssk = bpf_mptcp_subflow_tcp_sock(pick);
+	tp = ssk ? bpf_skc_to_tcp_sock(ssk) : NULL;
+	last_pick = tp ? p : -1;
+	last_seq = tp ? tp->write_seq : 0;
+
+	pick->send_limit = LIMIT;
+	mptcp_subflow_set_scheduled(pick, true);
+	return 0;
+}
+
+/* An MPTCP-level retransmission is not one of our decisions: do not count
+ * what it sends.
+ */
+SEC("struct_ops")
+int BPF_PROG(bpf_limit_get_retrans, struct mptcp_sock *msk)
+{
+	struct mptcp_subflow_context *subflow;
+
+	last_pick = -1;
+	bpf_for_each(mptcp_subflow, subflow, (struct sock *)msk) {
+		mptcp_subflow_set_scheduled(subflow, true);
+		return 0;
+	}
+	return -1;
+}
+
+SEC(".struct_ops.link")
+struct mptcp_sched_ops limit = {
+	.init		= (void *)mptcp_sched_limit_init,
+	.release	= (void *)mptcp_sched_limit_release,
+	.get_send	= (void *)bpf_limit_get_send,
+	.get_retrans	= (void *)bpf_limit_get_retrans,
+	.name		= "bpf_limit",
+};

-- 
2.55.0

