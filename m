Content-Type: multipart/mixed; boundary="===============6548673994800947596=="
MIME-Version: 1.0
From: Nicolas Rybowski <nicolas.rybowski at tessares.net>
To: mptcp at lists.01.org
Subject: [MPTCP] [PATCH mptcp-next v2 3/3] bpf: add 'bpf_mptcp_sock' structure
 and helper
Date: Tue, 11 Aug 2020 11:35:31 +0200
Message-ID: <20200811093531.27768-4-nicolas.rybowski@tessares.net>
In-Reply-To: 20200811093531.27768-1-nicolas.rybowski@tessares.net
X-Status: 
X-Keywords:                  
X-UID: 5536

--===============6548673994800947596==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

In order to precisely identify the parent MPTCP connection of a subflow,
it is required to access the mptcp_sock's token which uniquely identify a
MPTCP connection.

This patch adds a new structure 'bpf_mptcp_sock' exposing the 'token' field
of the 'mptcp_sock' extracted from a subflow's 'tcp_sock'. It also adds the
declaration of a new BPF helper of the same name to expose the newly
defined structure in the userspace BPF API.

This is the foundation to expose more MPTCP-specific fields through BPF.

Currently, it is limited to the field 'token' of the msk but it is
easily extensible.

Acked-by: Matthieu Baerts <matthieu.baerts(a)tessares.net>
Signed-off-by: Nicolas Rybowski <nicolas.rybowski(a)tessares.net>
---

Notes:
    v1 -> v2:
    - move new BPF helper implementation in net/mptcp/bpf.c
    - add bpf.c in Makefile of net/mptcp
    - minor cosmetic changes: alignment of function's arguments on open
    	parenthesis

 include/linux/bpf.h            | 33 ++++++++++++++++
 include/uapi/linux/bpf.h       | 13 ++++++
 kernel/bpf/verifier.c          | 30 ++++++++++++++
 net/core/filter.c              |  4 ++
 net/mptcp/Makefile             |  2 +
 net/mptcp/bpf.c                | 72 ++++++++++++++++++++++++++++++++++
 scripts/bpf_helpers_doc.py     |  2 +
 tools/include/uapi/linux/bpf.h | 13 ++++++
 8 files changed, 169 insertions(+)
 create mode 100644 net/mptcp/bpf.c

diff --git a/include/linux/bpf.h b/include/linux/bpf.h
index cef4ef0d2b4e..6eed7d870a52 100644
--- a/include/linux/bpf.h
+++ b/include/linux/bpf.h
@@ -281,6 +281,7 @@ enum bpf_return_type {
 	RET_PTR_TO_SOCK_COMMON_OR_NULL,	/* returns a pointer to a sock_common or =
NULL */
 	RET_PTR_TO_ALLOC_MEM_OR_NULL,	/* returns a pointer to dynamically allocat=
ed memory or NULL */
 	RET_PTR_TO_BTF_ID_OR_NULL,	/* returns a pointer to a btf_id or NULL */
+	RET_PTR_TO_MPTCP_SOCK_OR_NULL,	/* returns a pointer to mptcp_sock or NULL=
 */
 };
 =

 /* eBPF function prototype used by verifier to allow BPF_CALLs from eBPF p=
rograms
@@ -360,6 +361,8 @@ enum bpf_reg_type {
 	PTR_TO_RDONLY_BUF_OR_NULL, /* reg points to a readonly buffer or NULL */
 	PTR_TO_RDWR_BUF,	 /* reg points to a read/write buffer */
 	PTR_TO_RDWR_BUF_OR_NULL, /* reg points to a read/write buffer or NULL */
+	PTR_TO_MPTCP_SOCK,	 /* reg points to struct mptcp_sock */
+	PTR_TO_MPTCP_SOCK_OR_NULL, /* reg points to struct mptcp_sock or NULL */
 };
 =

 /* The information passed from prog-specific *_is_valid_access
@@ -1734,6 +1737,7 @@ extern const struct bpf_func_proto bpf_skc_to_tcp_soc=
k_proto;
 extern const struct bpf_func_proto bpf_skc_to_tcp_timewait_sock_proto;
 extern const struct bpf_func_proto bpf_skc_to_tcp_request_sock_proto;
 extern const struct bpf_func_proto bpf_skc_to_udp6_sock_proto;
+extern const struct bpf_func_proto bpf_mptcp_sock_proto;
 =

 const struct bpf_func_proto *bpf_tracing_func_proto(
 	enum bpf_func_id func_id, const struct bpf_prog *prog);
@@ -1790,6 +1794,35 @@ struct sk_reuseport_kern {
 	u32 reuseport_id;
 	bool bind_inany;
 };
+
+#ifdef CONFIG_MPTCP
+bool bpf_mptcp_sock_is_valid_access(int off, int size,
+				    enum bpf_access_type type,
+				    struct bpf_insn_access_aux *info);
+
+u32 bpf_mptcp_sock_convert_ctx_access(enum bpf_access_type type,
+				      const struct bpf_insn *si,
+				      struct bpf_insn *insn_buf,
+				      struct bpf_prog *prog,
+				      u32 *target_size);
+#else /* CONFIG_MPTCP */
+static inline bool bpf_mptcp_sock_is_valid_access(int off, int size,
+						  enum bpf_access_type type,
+						  struct bpf_insn_access_aux *info)
+{
+	return false;
+}
+
+static inline u32 bpf_mptcp_sock_convert_ctx_access(enum bpf_access_type t=
ype,
+						    const struct bpf_insn *si,
+						    struct bpf_insn *insn_buf,
+						    struct bpf_prog *prog,
+						    u32 *target_size)
+{
+	return 0;
+}
+#endif /* CONFIG_MPTCP */
+
 bool bpf_tcp_sock_is_valid_access(int off, int size, enum bpf_access_type =
type,
 				  struct bpf_insn_access_aux *info);
 =

diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.h
index 1a0caa4abc2d..8d51973cbf6f 100644
--- a/include/uapi/linux/bpf.h
+++ b/include/uapi/linux/bpf.h
@@ -3394,6 +3394,14 @@ union bpf_attr {
  *		A non-negative value equal to or less than *size* on success,
  *		or a negative error in case of failure.
  *
+ * struct bpf_mptcp_sock *bpf_mptcp_sock(struct bpf_sock *sk)
+ *	Description
+ *		This helper gets a **struct bpf_mptcp_sock** pointer from a
+ *		**struct bpf_sock** pointer.
+ *	Return
+ *		A **struct bpf_mptcp_sock** pointer on success, or **NULL** in
+ *		case of failure.
+ *
  */
 #define __BPF_FUNC_MAPPER(FN)		\
 	FN(unspec),			\
@@ -3538,6 +3546,7 @@ union bpf_attr {
 	FN(skc_to_tcp_request_sock),	\
 	FN(skc_to_udp6_sock),		\
 	FN(get_task_stack),		\
+	FN(mptcp_sock),			\
 	/* */
 =

 /* integer value in 'imm' field of BPF_CALL instruction selects which help=
er
@@ -3867,6 +3876,10 @@ struct bpf_tcp_sock {
 	__u32 is_mptcp;		/* Is MPTCP subflow? */
 };
 =

+struct bpf_mptcp_sock {
+	__u32 token;		/* msk token */
+};
+
 struct bpf_sock_tuple {
 	union {
 		struct {
diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index b6ccfce3bf4c..fae0afa84800 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -391,6 +391,7 @@ static bool type_is_sk_pointer(enum bpf_reg_type type)
 	return type =3D=3D PTR_TO_SOCKET ||
 		type =3D=3D PTR_TO_SOCK_COMMON ||
 		type =3D=3D PTR_TO_TCP_SOCK ||
+		type =3D=3D PTR_TO_MPTCP_SOCK ||
 		type =3D=3D PTR_TO_XDP_SOCK;
 }
 =

@@ -398,6 +399,7 @@ static bool reg_type_not_null(enum bpf_reg_type type)
 {
 	return type =3D=3D PTR_TO_SOCKET ||
 		type =3D=3D PTR_TO_TCP_SOCK ||
+		type =3D=3D PTR_TO_MPTCP_SOCK ||
 		type =3D=3D PTR_TO_MAP_VALUE ||
 		type =3D=3D PTR_TO_SOCK_COMMON;
 }
@@ -408,6 +410,7 @@ static bool reg_type_may_be_null(enum bpf_reg_type type)
 	       type =3D=3D PTR_TO_SOCKET_OR_NULL ||
 	       type =3D=3D PTR_TO_SOCK_COMMON_OR_NULL ||
 	       type =3D=3D PTR_TO_TCP_SOCK_OR_NULL ||
+	       type =3D=3D PTR_TO_MPTCP_SOCK_OR_NULL ||
 	       type =3D=3D PTR_TO_BTF_ID_OR_NULL ||
 	       type =3D=3D PTR_TO_MEM_OR_NULL ||
 	       type =3D=3D PTR_TO_RDONLY_BUF_OR_NULL ||
@@ -426,6 +429,8 @@ static bool reg_type_may_be_refcounted_or_null(enum bpf=
_reg_type type)
 		type =3D=3D PTR_TO_SOCKET_OR_NULL ||
 		type =3D=3D PTR_TO_TCP_SOCK ||
 		type =3D=3D PTR_TO_TCP_SOCK_OR_NULL ||
+		type =3D=3D PTR_TO_MPTCP_SOCK ||
+		type =3D=3D PTR_TO_MPTCP_SOCK_OR_NULL ||
 		type =3D=3D PTR_TO_MEM ||
 		type =3D=3D PTR_TO_MEM_OR_NULL;
 }
@@ -499,6 +504,8 @@ static const char * const reg_type_str[] =3D {
 	[PTR_TO_SOCK_COMMON_OR_NULL] =3D "sock_common_or_null",
 	[PTR_TO_TCP_SOCK]	=3D "tcp_sock",
 	[PTR_TO_TCP_SOCK_OR_NULL] =3D "tcp_sock_or_null",
+	[PTR_TO_MPTCP_SOCK]	=3D "mptcp_sock",
+	[PTR_TO_MPTCP_SOCK_OR_NULL] =3D "mptcp_sock_or_null",
 	[PTR_TO_TP_BUFFER]	=3D "tp_buffer",
 	[PTR_TO_XDP_SOCK]	=3D "xdp_sock",
 	[PTR_TO_BTF_ID]		=3D "ptr_",
@@ -2176,6 +2183,8 @@ static bool is_spillable_regtype(enum bpf_reg_type ty=
pe)
 	case PTR_TO_SOCK_COMMON_OR_NULL:
 	case PTR_TO_TCP_SOCK:
 	case PTR_TO_TCP_SOCK_OR_NULL:
+	case PTR_TO_MPTCP_SOCK:
+	case PTR_TO_MPTCP_SOCK_OR_NULL:
 	case PTR_TO_XDP_SOCK:
 	case PTR_TO_BTF_ID:
 	case PTR_TO_BTF_ID_OR_NULL:
@@ -2777,6 +2786,9 @@ static int check_sock_access(struct bpf_verifier_env =
*env, int insn_idx,
 	case PTR_TO_TCP_SOCK:
 		valid =3D bpf_tcp_sock_is_valid_access(off, size, t, &info);
 		break;
+	case PTR_TO_MPTCP_SOCK:
+		valid =3D bpf_mptcp_sock_is_valid_access(off, size, t, &info);
+		break;
 	case PTR_TO_XDP_SOCK:
 		valid =3D bpf_xdp_sock_is_valid_access(off, size, t, &info);
 		break;
@@ -2935,6 +2947,9 @@ static int check_ptr_alignment(struct bpf_verifier_en=
v *env,
 	case PTR_TO_TCP_SOCK:
 		pointer_desc =3D "tcp_sock ";
 		break;
+	case PTR_TO_MPTCP_SOCK:
+		pointer_desc =3D "mptcp_sock ";
+		break;
 	case PTR_TO_XDP_SOCK:
 		pointer_desc =3D "xdp_sock ";
 		break;
@@ -4899,6 +4914,10 @@ static int check_helper_call(struct bpf_verifier_env=
 *env, int func_id, int insn
 		mark_reg_known_zero(env, regs, BPF_REG_0);
 		regs[BPF_REG_0].type =3D PTR_TO_TCP_SOCK_OR_NULL;
 		regs[BPF_REG_0].id =3D ++env->id_gen;
+	} else if (fn->ret_type =3D=3D RET_PTR_TO_MPTCP_SOCK_OR_NULL) {
+		mark_reg_known_zero(env, regs, BPF_REG_0);
+		regs[BPF_REG_0].type =3D PTR_TO_MPTCP_SOCK_OR_NULL;
+		regs[BPF_REG_0].id =3D ++env->id_gen;
 	} else if (fn->ret_type =3D=3D RET_PTR_TO_ALLOC_MEM_OR_NULL) {
 		mark_reg_known_zero(env, regs, BPF_REG_0);
 		regs[BPF_REG_0].type =3D PTR_TO_MEM_OR_NULL;
@@ -5226,6 +5245,8 @@ static int adjust_ptr_min_max_vals(struct bpf_verifie=
r_env *env,
 	case PTR_TO_SOCK_COMMON_OR_NULL:
 	case PTR_TO_TCP_SOCK:
 	case PTR_TO_TCP_SOCK_OR_NULL:
+	case PTR_TO_MPTCP_SOCK:
+	case PTR_TO_MPTCP_SOCK_OR_NULL:
 	case PTR_TO_XDP_SOCK:
 		verbose(env, "R%d pointer arithmetic on %s prohibited\n",
 			dst, reg_type_str[ptr_reg->type]);
@@ -6880,6 +6901,8 @@ static void mark_ptr_or_null_reg(struct bpf_func_stat=
e *state,
 			reg->type =3D PTR_TO_SOCK_COMMON;
 		} else if (reg->type =3D=3D PTR_TO_TCP_SOCK_OR_NULL) {
 			reg->type =3D PTR_TO_TCP_SOCK;
+		} else if (reg->type =3D=3D PTR_TO_MPTCP_SOCK_OR_NULL) {
+			reg->type =3D PTR_TO_MPTCP_SOCK;
 		} else if (reg->type =3D=3D PTR_TO_BTF_ID_OR_NULL) {
 			reg->type =3D PTR_TO_BTF_ID;
 		} else if (reg->type =3D=3D PTR_TO_MEM_OR_NULL) {
@@ -8242,6 +8265,8 @@ static bool regsafe(struct bpf_reg_state *rold, struc=
t bpf_reg_state *rcur,
 	case PTR_TO_SOCK_COMMON_OR_NULL:
 	case PTR_TO_TCP_SOCK:
 	case PTR_TO_TCP_SOCK_OR_NULL:
+	case PTR_TO_MPTCP_SOCK:
+	case PTR_TO_MPTCP_SOCK_OR_NULL:
 	case PTR_TO_XDP_SOCK:
 		/* Only valid matches are exact, which memcmp() above
 		 * would have accepted
@@ -8769,6 +8794,8 @@ static bool reg_type_mismatch_ok(enum bpf_reg_type ty=
pe)
 	case PTR_TO_SOCK_COMMON_OR_NULL:
 	case PTR_TO_TCP_SOCK:
 	case PTR_TO_TCP_SOCK_OR_NULL:
+	case PTR_TO_MPTCP_SOCK:
+	case PTR_TO_MPTCP_SOCK_OR_NULL:
 	case PTR_TO_XDP_SOCK:
 	case PTR_TO_BTF_ID:
 	case PTR_TO_BTF_ID_OR_NULL:
@@ -9889,6 +9916,9 @@ static int convert_ctx_accesses(struct bpf_verifier_e=
nv *env)
 		case PTR_TO_TCP_SOCK:
 			convert_ctx_access =3D bpf_tcp_sock_convert_ctx_access;
 			break;
+		case PTR_TO_MPTCP_SOCK:
+			convert_ctx_access =3D bpf_mptcp_sock_convert_ctx_access;
+			break;
 		case PTR_TO_XDP_SOCK:
 			convert_ctx_access =3D bpf_xdp_sock_convert_ctx_access;
 			break;
diff --git a/net/core/filter.c b/net/core/filter.c
index ce83e1ec5259..59411822df1a 100644
--- a/net/core/filter.c
+++ b/net/core/filter.c
@@ -6560,6 +6560,10 @@ sock_ops_func_proto(enum bpf_func_id func_id, const =
struct bpf_prog *prog)
 	case BPF_FUNC_tcp_sock:
 		return &bpf_tcp_sock_proto;
 #endif /* CONFIG_INET */
+#ifdef CONFIG_MPTCP
+	case BPF_FUNC_mptcp_sock:
+		return &bpf_mptcp_sock_proto;
+#endif /* CONFIG_MPTCP */
 	default:
 		return bpf_base_func_proto(func_id);
 	}
diff --git a/net/mptcp/Makefile b/net/mptcp/Makefile
index a611968be4d7..aae2ede220ed 100644
--- a/net/mptcp/Makefile
+++ b/net/mptcp/Makefile
@@ -10,3 +10,5 @@ obj-$(CONFIG_INET_MPTCP_DIAG) +=3D mptcp_diag.o
 mptcp_crypto_test-objs :=3D crypto_test.o
 mptcp_token_test-objs :=3D token_test.o
 obj-$(CONFIG_MPTCP_KUNIT_TESTS) +=3D mptcp_crypto_test.o mptcp_token_test.o
+
+obj-$(CONFIG_BPF) +=3D bpf.o
diff --git a/net/mptcp/bpf.c b/net/mptcp/bpf.c
new file mode 100644
index 000000000000..5332469fbb28
--- /dev/null
+++ b/net/mptcp/bpf.c
@@ -0,0 +1,72 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Multipath TCP
+ *
+ * Copyright (c) 2020, Tessares SA.
+ *
+ * Author: Nicolas Rybowski <nicolas.rybowski(a)tessares.net>
+ *
+ */
+
+#include <linux/bpf.h>
+
+#include "protocol.h"
+
+bool bpf_mptcp_sock_is_valid_access(int off, int size, enum bpf_access_typ=
e type,
+				    struct bpf_insn_access_aux *info)
+{
+	if (off < 0 || off >=3D offsetofend(struct bpf_mptcp_sock, token))
+		return false;
+
+	if (off % size !=3D 0)
+		return false;
+
+	switch (off) {
+	default:
+		return size =3D=3D sizeof(__u32);
+	}
+}
+
+u32 bpf_mptcp_sock_convert_ctx_access(enum bpf_access_type type,
+				      const struct bpf_insn *si,
+				      struct bpf_insn *insn_buf,
+				      struct bpf_prog *prog, u32 *target_size)
+{
+	struct bpf_insn *insn =3D insn_buf;
+
+#define BPF_MPTCP_SOCK_GET_COMMON(FIELD)							\
+	do {											\
+		BUILD_BUG_ON(sizeof_field(struct mptcp_sock, FIELD) >				\
+				sizeof_field(struct bpf_mptcp_sock, FIELD));			\
+		*insn++ =3D BPF_LDX_MEM(BPF_FIELD_SIZEOF(struct mptcp_sock, FIELD),		\
+							si->dst_reg, si->src_reg,		\
+							offsetof(struct mptcp_sock, FIELD));	\
+	} while (0)
+
+	if (insn > insn_buf)
+		return insn - insn_buf;
+
+	switch (si->off) {
+	case offsetof(struct bpf_mptcp_sock, token):
+		BPF_MPTCP_SOCK_GET_COMMON(token);
+		break;
+	}
+
+	return insn - insn_buf;
+}
+
+BPF_CALL_1(bpf_mptcp_sock, struct sock *, sk)
+{
+	if (sk_fullsock(sk) && sk->sk_protocol =3D=3D IPPROTO_TCP && sk_is_mptcp(=
sk)) {
+		struct mptcp_subflow_context *mptcp_sfc =3D mptcp_subflow_ctx(sk);
+
+		return (unsigned long)mptcp_sfc->conn;
+	}
+	return (unsigned long)NULL;
+}
+
+const struct bpf_func_proto bpf_mptcp_sock_proto =3D {
+	.func           =3D bpf_mptcp_sock,
+	.gpl_only       =3D false,
+	.ret_type       =3D RET_PTR_TO_MPTCP_SOCK_OR_NULL,
+	.arg1_type      =3D ARG_PTR_TO_SOCK_COMMON,
+};
diff --git a/scripts/bpf_helpers_doc.py b/scripts/bpf_helpers_doc.py
index 5bfa448b4704..4db41a1c344a 100755
--- a/scripts/bpf_helpers_doc.py
+++ b/scripts/bpf_helpers_doc.py
@@ -428,6 +428,7 @@ class PrinterHelpers(Printer):
             'struct tcp_request_sock',
             'struct udp6_sock',
             'struct task_struct',
+            'struct bpf_mptcp_sock',
 =

             'struct __sk_buff',
             'struct sk_msg_md',
@@ -472,6 +473,7 @@ class PrinterHelpers(Printer):
             'struct tcp_request_sock',
             'struct udp6_sock',
             'struct task_struct',
+            'struct bpf_mptcp_sock',
     }
     mapped_types =3D {
             'u8': '__u8',
diff --git a/tools/include/uapi/linux/bpf.h b/tools/include/uapi/linux/bpf.h
index 1a0caa4abc2d..8d51973cbf6f 100644
--- a/tools/include/uapi/linux/bpf.h
+++ b/tools/include/uapi/linux/bpf.h
@@ -3394,6 +3394,14 @@ union bpf_attr {
  *		A non-negative value equal to or less than *size* on success,
  *		or a negative error in case of failure.
  *
+ * struct bpf_mptcp_sock *bpf_mptcp_sock(struct bpf_sock *sk)
+ *	Description
+ *		This helper gets a **struct bpf_mptcp_sock** pointer from a
+ *		**struct bpf_sock** pointer.
+ *	Return
+ *		A **struct bpf_mptcp_sock** pointer on success, or **NULL** in
+ *		case of failure.
+ *
  */
 #define __BPF_FUNC_MAPPER(FN)		\
 	FN(unspec),			\
@@ -3538,6 +3546,7 @@ union bpf_attr {
 	FN(skc_to_tcp_request_sock),	\
 	FN(skc_to_udp6_sock),		\
 	FN(get_task_stack),		\
+	FN(mptcp_sock),			\
 	/* */
 =

 /* integer value in 'imm' field of BPF_CALL instruction selects which help=
er
@@ -3867,6 +3876,10 @@ struct bpf_tcp_sock {
 	__u32 is_mptcp;		/* Is MPTCP subflow? */
 };
 =

+struct bpf_mptcp_sock {
+	__u32 token;		/* msk token */
+};
+
 struct bpf_sock_tuple {
 	union {
 		struct {
-- =

2.28.0

--===============6548673994800947596==--
