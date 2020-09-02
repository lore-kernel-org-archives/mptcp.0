Content-Type: multipart/mixed; boundary="===============0703823361773098866=="
MIME-Version: 1.0
From: Nicolas Rybowski <nicolas.rybowski at tessares.net>
To: mptcp at lists.01.org
Subject: [MPTCP] [PATCH mptcp-next v2 5/5] bpf:selftests: add bpf_mptcp_sock()
 verifier tests
Date: Wed, 02 Sep 2020 19:04:43 +0200
Message-ID: <20200902170443.272113-6-nicolas.rybowski@tessares.net>
In-Reply-To: 20200902170443.272113-1-nicolas.rybowski@tessares.net
X-Status: 
X-Keywords:                  
X-UID: 5706

--===============0703823361773098866==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

This patch adds verifier side tests for the new bpf_mptcp_sock() helper.

Currently, there is no easy way to test the token field since we cannot
get back the mptcp_sock, this could be a future amelioration.

Acked-by: Matthieu Baerts <matthieu.baerts(a)tessares.net>
Signed-off-by: Nicolas Rybowski <nicolas.rybowski(a)tessares.net>
---

Notes:
    v1 -> v2:
    - new patch: mandatory selftests (Alexei)

 tools/testing/selftests/bpf/verifier/sock.c | 63 +++++++++++++++++++++
 1 file changed, 63 insertions(+)

diff --git a/tools/testing/selftests/bpf/verifier/sock.c b/tools/testing/se=
lftests/bpf/verifier/sock.c
index b1aac2641498..9ce7c7ec3b5e 100644
--- a/tools/testing/selftests/bpf/verifier/sock.c
+++ b/tools/testing/selftests/bpf/verifier/sock.c
@@ -631,3 +631,66 @@
 	.prog_type =3D BPF_PROG_TYPE_SK_REUSEPORT,
 	.result =3D ACCEPT,
 },
+{
+	"bpf_mptcp_sock(skops->sk): no !skops->sk check",
+	.insns =3D {
+	BPF_LDX_MEM(BPF_DW, BPF_REG_1, BPF_REG_1, offsetof(struct bpf_sock_ops, s=
k)),
+	BPF_EMIT_CALL(BPF_FUNC_mptcp_sock),
+	BPF_MOV64_IMM(BPF_REG_0, 0),
+	BPF_EXIT_INSN(),
+	},
+	.prog_type =3D BPF_PROG_TYPE_SOCK_OPS,
+	.result =3D REJECT,
+	.errstr =3D "type=3Dsock_or_null expected=3Dsock_common",
+},
+{
+	"bpf_mptcp_sock(skops->sk): no NULL check on ret",
+	.insns =3D {
+	BPF_LDX_MEM(BPF_DW, BPF_REG_1, BPF_REG_1, offsetof(struct bpf_sock_ops, s=
k)),
+	BPF_JMP_IMM(BPF_JNE, BPF_REG_1, 0, 2),
+	BPF_MOV64_IMM(BPF_REG_0, 0),
+	BPF_EXIT_INSN(),
+	BPF_EMIT_CALL(BPF_FUNC_mptcp_sock),
+	BPF_LDX_MEM(BPF_W, BPF_REG_0, BPF_REG_0, offsetof(struct bpf_mptcp_sock, =
token)),
+	BPF_MOV64_IMM(BPF_REG_0, 0),
+	BPF_EXIT_INSN(),
+	},
+	.prog_type =3D BPF_PROG_TYPE_SOCK_OPS,
+	.result =3D REJECT,
+	.errstr =3D "invalid mem access 'mptcp_sock_or_null'",
+},
+{
+	"bpf_mptcp_sock(skops->sk): msk->token",
+	.insns =3D {
+	BPF_LDX_MEM(BPF_DW, BPF_REG_1, BPF_REG_1, offsetof(struct bpf_sock_ops, s=
k)),
+	BPF_JMP_IMM(BPF_JNE, BPF_REG_1, 0, 2),
+	BPF_MOV64_IMM(BPF_REG_0, 0),
+	BPF_EXIT_INSN(),
+	BPF_EMIT_CALL(BPF_FUNC_mptcp_sock),
+	BPF_JMP_IMM(BPF_JNE, BPF_REG_0, 0, 1),
+	BPF_EXIT_INSN(),
+	BPF_LDX_MEM(BPF_W, BPF_REG_0, BPF_REG_0, offsetof(struct bpf_mptcp_sock, =
token)),
+	BPF_MOV64_IMM(BPF_REG_0, 0),
+	BPF_EXIT_INSN(),
+	},
+	.prog_type =3D BPF_PROG_TYPE_SOCK_OPS,
+	.result =3D ACCEPT,
+},
+{
+	"bpf_mptcp_sock(skops->sk): msk->token cannot be modified",
+	.insns =3D {
+	BPF_LDX_MEM(BPF_DW, BPF_REG_1, BPF_REG_1, offsetof(struct bpf_sock_ops, s=
k)),
+	BPF_JMP_IMM(BPF_JNE, BPF_REG_1, 0, 2),
+	BPF_MOV64_IMM(BPF_REG_0, 0),
+	BPF_EXIT_INSN(),
+	BPF_EMIT_CALL(BPF_FUNC_mptcp_sock),
+	BPF_JMP_IMM(BPF_JNE, BPF_REG_0, 0, 1),
+	BPF_EXIT_INSN(),
+	BPF_ST_MEM(BPF_W, BPF_REG_0, offsetof(struct bpf_mptcp_sock, token), 0x2a=
),
+	BPF_MOV64_IMM(BPF_REG_0, 0),
+	BPF_EXIT_INSN(),
+	},
+	.prog_type =3D BPF_PROG_TYPE_SOCK_OPS,
+	.result =3D REJECT,
+	.errstr =3D "cannot write into mptcp_sock",
+},
-- =

2.28.0

--===============0703823361773098866==--
