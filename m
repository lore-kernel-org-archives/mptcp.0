Content-Type: multipart/mixed; boundary="===============2783353926986079222=="
MIME-Version: 1.0
From: Geliang Tang <geliangtang at gmail.com>
To: mptcp at lists.01.org
Subject: [MPTCP] [MPTCP][PATCH mptcp-next] Squash to "bpf:selftests: add MPTCP
 test base"
Date: Wed, 17 Mar 2021 20:11:58 +0800
Message-ID: <70cec4a8462feb0ad4771dd1a0d75f3163800059.1615983074.git.geliangtang@gmail.com>
X-Status: 
X-Keywords:                  
X-UID: 8188

--===============2783353926986079222==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

When I ran the bpf mptcp test "./test_progs -n 67", I got a "fallback to
TCP" error in kernel log:

 [   77.939497] MPTCP: msk=3D00000000e58fbe96
 [   77.939534] IPv4: Attempt to release TCP socket in state 8 00000000e58f=
be96
 [   77.939807] MPTCP: subflow_req=3D0000000044a047b7
 [   77.939818] MPTCP: check_fully_established:fallback to TCP (msk=3D00000=
0000719adf6)
 [   77.940238] MPTCP: msk=3D000000004c748421
 [  140.366959] MPTCP: msk=3D000000000719adf6 snd_data_fin_enable=3D1 pendi=
ng=3D0 snd_nxt=3D8514713421947747320 write_seq=3D8514713421947747320
 [  140.366984] MPTCP: msk=3D000000000719adf6

This patch fixed it.

send_byte() is copied from tools/testing/selftests/bpf/prog_tests/tcp_rtt.c.

Signed-off-by: Geliang Tang <geliangtang(a)gmail.com>
---
 tools/testing/selftests/bpf/prog_tests/mptcp.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/tools/testing/selftests/bpf/prog_tests/mptcp.c b/tools/testing=
/selftests/bpf/prog_tests/mptcp.c
index 0e65d64868e9..fc97131ca397 100644
--- a/tools/testing/selftests/bpf/prog_tests/mptcp.c
+++ b/tools/testing/selftests/bpf/prog_tests/mptcp.c
@@ -8,6 +8,14 @@ struct mptcp_storage {
 	__u32 is_mptcp;
 };
 =

+static void send_byte(int fd)
+{
+	char b =3D 0x55;
+
+	if (CHECK_FAIL(write(fd, &b, sizeof(b)) !=3D 1))
+		perror("Failed to send single byte");
+}
+
 static int verify_sk(int map_fd, int client_fd, const char *msg, __u32 is_=
mptcp)
 {
 	int err =3D 0, cfd =3D client_fd;
@@ -76,6 +84,8 @@ static int run_test(int cgroup_fd, int server_fd, bool is=
_mptcp)
 		goto close_client_fd;
 	}
 =

+	send_byte(client_fd);
+
 	err +=3D is_mptcp ? verify_sk(map_fd, client_fd, "MPTCP subflow socket", =
1) :
 			  verify_sk(map_fd, client_fd, "plain TCP socket", 0);
 =

-- =

2.30.2

--===============2783353926986079222==--
