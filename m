Content-Type: multipart/mixed; boundary="===============7921156776227526823=="
MIME-Version: 1.0
From: Nicolas Rybowski <nicolas.rybowski at tessares.net>
To: mptcp at lists.01.org
Subject: [MPTCP] [PATCH mptcp-next v2 4/5] bpf:selftests: add MPTCP test base
Date: Wed, 02 Sep 2020 19:04:42 +0200
Message-ID: <20200902170443.272113-5-nicolas.rybowski@tessares.net>
In-Reply-To: 20200902170443.272113-1-nicolas.rybowski@tessares.net
X-Status: 
X-Keywords:                  
X-UID: 5705

--===============7921156776227526823==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

This patch adds a base for MPTCP specific tests.

It is currently limited to the is_mptcp field in case of plain TCP
connection because there is no easy way to get the subflow sk from a msk
in userspace. This implies that we cannot lookup the sk_storage attached
to the subflow sk in the sockops program.

Acked-by: Matthieu Baerts <matthieu.baerts(a)tessares.net>
Signed-off-by: Nicolas Rybowski <nicolas.rybowski(a)tessares.net>
---

Notes:
    v1 -> v2:
    - new patch: mandatory selftests (Alexei)

 tools/testing/selftests/bpf/config            |   1 +
 tools/testing/selftests/bpf/network_helpers.c |  37 +++++-
 tools/testing/selftests/bpf/network_helpers.h |   3 +
 .../testing/selftests/bpf/prog_tests/mptcp.c  | 119 ++++++++++++++++++
 tools/testing/selftests/bpf/progs/mptcp.c     |  48 +++++++
 5 files changed, 203 insertions(+), 5 deletions(-)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/mptcp.c
 create mode 100644 tools/testing/selftests/bpf/progs/mptcp.c

diff --git a/tools/testing/selftests/bpf/config b/tools/testing/selftests/b=
pf/config
index 2118e23ac07a..8377836ea976 100644
--- a/tools/testing/selftests/bpf/config
+++ b/tools/testing/selftests/bpf/config
@@ -39,3 +39,4 @@ CONFIG_BPF_JIT=3Dy
 CONFIG_BPF_LSM=3Dy
 CONFIG_SECURITY=3Dy
 CONFIG_LIRC=3Dy
+CONFIG_MPTCP=3Dy
diff --git a/tools/testing/selftests/bpf/network_helpers.c b/tools/testing/=
selftests/bpf/network_helpers.c
index 12ee40284da0..9295a5d8e001 100644
--- a/tools/testing/selftests/bpf/network_helpers.c
+++ b/tools/testing/selftests/bpf/network_helpers.c
@@ -14,6 +14,10 @@
 #include "bpf_util.h"
 #include "network_helpers.h"
 =

+#ifndef IPPROTO_MPTCP
+#define IPPROTO_MPTCP 262
+#endif
+
 #define clean_errno() (errno =3D=3D 0 ? "None" : strerror(errno))
 #define log_err(MSG, ...) ({						\
 			int __save =3D errno;				\
@@ -66,8 +70,8 @@ static int settimeo(int fd, int timeout_ms)
 =

 #define save_errno_close(fd) ({ int __save =3D errno; close(fd); errno =3D=
 __save; })
 =

-int start_server(int family, int type, const char *addr_str, __u16 port,
-		 int timeout_ms)
+static int start_server_proto(int family, int type, int protocol,
+			       const char *addr_str, __u16 port, int timeout_ms)
 {
 	struct sockaddr_storage addr =3D {};
 	socklen_t len;
@@ -76,7 +80,7 @@ int start_server(int family, int type, const char *addr_s=
tr, __u16 port,
 	if (make_sockaddr(family, addr_str, port, &addr, &len))
 		return -1;
 =

-	fd =3D socket(family, type, 0);
+	fd =3D socket(family, type, protocol);
 	if (fd < 0) {
 		log_err("Failed to create server socket");
 		return -1;
@@ -104,6 +108,19 @@ int start_server(int family, int type, const char *add=
r_str, __u16 port,
 	return -1;
 }
 =

+int start_server(int family, int type, const char *addr_str, __u16 port,
+		 int timeout_ms)
+{
+	return start_server_proto(family, type, 0, addr_str, port, timeout_ms);
+}
+
+int start_mptcp_server(int family, const char *addr_str, __u16 port,
+		       int timeout_ms)
+{
+	return start_server_proto(family, SOCK_STREAM, IPPROTO_MPTCP, addr_str,
+				   port, timeout_ms);
+}
+
 int fastopen_connect(int server_fd, const char *data, unsigned int data_le=
n,
 		     int timeout_ms)
 {
@@ -153,7 +170,7 @@ static int connect_fd_to_addr(int fd,
 	return 0;
 }
 =

-int connect_to_fd(int server_fd, int timeout_ms)
+static int connect_to_fd_proto(int server_fd, int protocol, int timeout_ms)
 {
 	struct sockaddr_storage addr;
 	struct sockaddr_in *addr_in;
@@ -173,7 +190,7 @@ int connect_to_fd(int server_fd, int timeout_ms)
 	}
 =

 	addr_in =3D (struct sockaddr_in *)&addr;
-	fd =3D socket(addr_in->sin_family, type, 0);
+	fd =3D socket(addr_in->sin_family, type, protocol);
 	if (fd < 0) {
 		log_err("Failed to create client socket");
 		return -1;
@@ -192,6 +209,16 @@ int connect_to_fd(int server_fd, int timeout_ms)
 	return -1;
 }
 =

+int connect_to_fd(int server_fd, int timeout_ms)
+{
+	return connect_to_fd_proto(server_fd, 0, timeout_ms);
+}
+
+int connect_to_mptcp_fd(int server_fd, int timeout_ms)
+{
+	return connect_to_fd_proto(server_fd, IPPROTO_MPTCP, timeout_ms);
+}
+
 int connect_fd_to_fd(int client_fd, int server_fd, int timeout_ms)
 {
 	struct sockaddr_storage addr;
diff --git a/tools/testing/selftests/bpf/network_helpers.h b/tools/testing/=
selftests/bpf/network_helpers.h
index 7205f8afdba1..336423a789e9 100644
--- a/tools/testing/selftests/bpf/network_helpers.h
+++ b/tools/testing/selftests/bpf/network_helpers.h
@@ -35,7 +35,10 @@ extern struct ipv6_packet pkt_v6;
 =

 int start_server(int family, int type, const char *addr, __u16 port,
 		 int timeout_ms);
+int start_mptcp_server(int family, const char *addr, __u16 port,
+		       int timeout_ms);
 int connect_to_fd(int server_fd, int timeout_ms);
+int connect_to_mptcp_fd(int server_fd, int timeout_ms);
 int connect_fd_to_fd(int client_fd, int server_fd, int timeout_ms);
 int fastopen_connect(int server_fd, const char *data, unsigned int data_le=
n,
 		     int timeout_ms);
diff --git a/tools/testing/selftests/bpf/prog_tests/mptcp.c b/tools/testing=
/selftests/bpf/prog_tests/mptcp.c
new file mode 100644
index 000000000000..0e65d64868e9
--- /dev/null
+++ b/tools/testing/selftests/bpf/prog_tests/mptcp.c
@@ -0,0 +1,119 @@
+// SPDX-License-Identifier: GPL-2.0
+#include <test_progs.h>
+#include "cgroup_helpers.h"
+#include "network_helpers.h"
+
+struct mptcp_storage {
+	__u32 invoked;
+	__u32 is_mptcp;
+};
+
+static int verify_sk(int map_fd, int client_fd, const char *msg, __u32 is_=
mptcp)
+{
+	int err =3D 0, cfd =3D client_fd;
+	struct mptcp_storage val;
+
+	/* Currently there is no easy way to get back the subflow sk from the MPT=
CP
+	 * sk, thus we cannot access here the sk_storage associated to the subflow
+	 * sk. Also, there is no sk_storage associated with the MPTCP sk since it
+	 * does not trigger sockops events.
+	 * We silently pass this situation at the moment.
+	 */
+	if (is_mptcp =3D=3D 1)
+		return 0;
+
+	if (CHECK_FAIL(bpf_map_lookup_elem(map_fd, &cfd, &val) < 0)) {
+		perror("Failed to read socket storage");
+		return -1;
+	}
+
+	if (val.invoked !=3D 1) {
+		log_err("%s: unexpected invoked count %d !=3D %d",
+			msg, val.invoked, 1);
+		err++;
+	}
+
+	if (val.is_mptcp !=3D is_mptcp) {
+		log_err("%s: unexpected bpf_tcp_sock.is_mptcp %d !=3D %d",
+			msg, val.is_mptcp, is_mptcp);
+		err++;
+	}
+
+	return err;
+}
+
+static int run_test(int cgroup_fd, int server_fd, bool is_mptcp)
+{
+	int client_fd, prog_fd, map_fd, err;
+	struct bpf_object *obj;
+	struct bpf_map *map;
+
+	struct bpf_prog_load_attr attr =3D {
+		.prog_type =3D BPF_PROG_TYPE_SOCK_OPS,
+		.file =3D "./mptcp.o",
+		.expected_attach_type =3D BPF_CGROUP_SOCK_OPS,
+	};
+
+	err =3D bpf_prog_load_xattr(&attr, &obj, &prog_fd);
+	if (err) {
+		log_err("Failed to load BPF object");
+		return -1;
+	}
+
+	map =3D bpf_map__next(NULL, obj);
+	map_fd =3D bpf_map__fd(map);
+
+	err =3D bpf_prog_attach(prog_fd, cgroup_fd, BPF_CGROUP_SOCK_OPS, 0);
+	if (err) {
+		log_err("Failed to attach BPF program");
+		goto close_bpf_object;
+	}
+
+	client_fd =3D is_mptcp ? connect_to_mptcp_fd(server_fd, 0) :
+			       connect_to_fd(server_fd, 0);
+	if (client_fd < 0) {
+		err =3D -1;
+		goto close_client_fd;
+	}
+
+	err +=3D is_mptcp ? verify_sk(map_fd, client_fd, "MPTCP subflow socket", =
1) :
+			  verify_sk(map_fd, client_fd, "plain TCP socket", 0);
+
+close_client_fd:
+	close(client_fd);
+
+close_bpf_object:
+	bpf_object__close(obj);
+	return err;
+}
+
+void test_mptcp(void)
+{
+	int server_fd, cgroup_fd;
+
+	cgroup_fd =3D test__join_cgroup("/mptcp");
+	if (CHECK_FAIL(cgroup_fd < 0))
+		return;
+
+	/* without MPTCP */
+	server_fd =3D start_server(AF_INET, SOCK_STREAM, NULL, 0, 0);
+	if (CHECK_FAIL(server_fd < 0))
+		goto with_mptcp;
+
+	CHECK_FAIL(run_test(cgroup_fd, server_fd, false));
+
+	close(server_fd);
+
+with_mptcp:
+	/* with MPTCP */
+	server_fd =3D start_mptcp_server(AF_INET, NULL, 0, 0);
+	if (CHECK_FAIL(server_fd < 0))
+		goto close_cgroup_fd;
+
+	CHECK_FAIL(run_test(cgroup_fd, server_fd, true));
+
+	close(server_fd);
+
+close_cgroup_fd:
+	close(cgroup_fd);
+}
diff --git a/tools/testing/selftests/bpf/progs/mptcp.c b/tools/testing/self=
tests/bpf/progs/mptcp.c
new file mode 100644
index 000000000000..936edc8517df
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/mptcp.c
@@ -0,0 +1,48 @@
+// SPDX-License-Identifier: GPL-2.0
+#include <linux/bpf.h>
+#include <bpf/bpf_helpers.h>
+
+char _license[] SEC("license") =3D "GPL";
+__u32 _version SEC("version") =3D 1;
+
+struct mptcp_storage {
+	__u32 invoked;
+	__u32 is_mptcp;
+};
+
+struct {
+	__uint(type, BPF_MAP_TYPE_SK_STORAGE);
+	__uint(map_flags, BPF_F_NO_PREALLOC);
+	__type(key, int);
+	__type(value, struct mptcp_storage);
+} socket_storage_map SEC(".maps");
+
+SEC("sockops")
+int _sockops(struct bpf_sock_ops *ctx)
+{
+	struct mptcp_storage *storage;
+	struct bpf_tcp_sock *tcp_sk;
+	int op =3D (int) ctx->op;
+	struct bpf_sock *sk;
+
+	sk =3D ctx->sk;
+	if (!sk)
+		return 1;
+
+	storage =3D bpf_sk_storage_get(&socket_storage_map, sk, 0,
+				     BPF_SK_STORAGE_GET_F_CREATE);
+	if (!storage)
+		return 1;
+
+	if (op !=3D BPF_SOCK_OPS_TCP_CONNECT_CB)
+		return 1;
+
+	tcp_sk =3D bpf_tcp_sock(sk);
+	if (!tcp_sk)
+		return 1;
+
+	storage->invoked++;
+	storage->is_mptcp =3D tcp_sk->is_mptcp;
+
+	return 1;
+}
-- =

2.28.0

--===============7921156776227526823==--
