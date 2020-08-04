Content-Type: multipart/mixed; boundary="===============7666739736069811269=="
MIME-Version: 1.0
From: Nicolas Rybowski <nicolas.rybowski at tessares.net>
To: mptcp at lists.01.org
Subject: [MPTCP] [PATCH mptcp-next 4/4] bpf: adding 'bpf_mptcp_sock' structure
 and helper
Date: Tue, 04 Aug 2020 18:13:31 +0200
Message-ID: <20200804161331.1219161-5-nicolas.rybowski@tessares.net>
In-Reply-To: 20200804161331.1219161-1-nicolas.rybowski@tessares.net
X-Status: 
X-Keywords:                  
X-UID: 5471

--===============7666739736069811269==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

In order to precisely identify the parent MPTCP connection of a subflow,
it is required to access the mptcp_sock's token which uniquely identify a
MPTCP connection.

This patch adds a new structure 'bpf_mptcp_sock' exposing the 'token' field
of the 'mptcp_sock' extracted from a subflow's 'tcp_sock'. It also adds a
new BPF helper of the same name to expose the newly defined structure in
the userspace BPF API.

This is the fundation to expose more MPTCP-specific fields.

Acked-by: Matthieu Baerts <matthieu.baerts(a)tessares.net>
Signed-off-by: Nicolas Rybowski <nicolas.rybowski(a)tessares.net>
---
 include/linux/bpf.h            | 33 +++++++++++++++++
 include/uapi/linux/bpf.h       | 13 +++++++
 kernel/bpf/verifier.c          | 30 +++++++++++++++
 net/core/filter.c              | 67 ++++++++++++++++++++++++++++++++++
 scripts/bpf_helpers_doc.py     |  2 +
 tools/include/uapi/linux/bpf.h | 13 +++++++
 6 files changed, 158 insertions(+)

diff --git a/include/linux/bpf.h b/include/linux/bpf.h
index bae557ff2da8..a257220cd107 100644
--- a/include/linux/bpf.h
+++ b/include/linux/bpf.h
@@ -267,6 +267,7 @@ enum bpf_return_type {
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
@@ -342,6 +343,8 @@ enum bpf_reg_type {
 	PTR_TO_BTF_ID_OR_NULL,	 /* reg points to kernel struct or NULL */
 	PTR_TO_MEM,		 /* reg points to valid memory region */
 	PTR_TO_MEM_OR_NULL,	 /* reg points to valid memory region or NULL */
+	PTR_TO_MPTCP_SOCK,	 /* reg points to struct mptcp_sock */
+	PTR_TO_MPTCP_SOCK_OR_NULL, /* reg points to struct mptcp_sock or NULL */
 };
 =

 /* The information passed from prog-specific *_is_valid_access
@@ -1671,6 +1674,7 @@ extern const struct bpf_func_proto bpf_skc_to_tcp_soc=
k_proto;
 extern const struct bpf_func_proto bpf_skc_to_tcp_timewait_sock_proto;
 extern const struct bpf_func_proto bpf_skc_to_tcp_request_sock_proto;
 extern const struct bpf_func_proto bpf_skc_to_udp6_sock_proto;
+extern const struct bpf_func_proto bpf_mptcp_sock_proto;
 =

 const struct bpf_func_proto *bpf_tracing_func_proto(
 	enum bpf_func_id func_id, const struct bpf_prog *prog);
@@ -1727,6 +1731,35 @@ struct sk_reuseport_kern {
 	u32 reuseport_id;
 	bool bind_inany;
 };
+
+#ifdef CONFIG_MPTCP
+bool bpf_mptcp_sock_is_valid_access(int off, int size,
+					enum bpf_access_type type,
+					struct bpf_insn_access_aux *info);
+
+u32 bpf_mptcp_sock_convert_ctx_access(enum bpf_access_type type,
+				    const struct bpf_insn *si,
+				    struct bpf_insn *insn_buf,
+				    struct bpf_prog *prog,
+				    u32 *target_size);
+#else /* CONFIG_MPTCP */
+static inline bool bpf_mptcp_sock_is_valid_access(int off, int size,
+						enum bpf_access_type type,
+						struct bpf_insn_access_aux *info)
+{
+	return false;
+}
+
+static inline u32 bpf_mptcp_sock_convert_ctx_access(enum bpf_access_type t=
ype,
+						  const struct bpf_insn *si,
+						  struct bpf_insn *insn_buf,
+						  struct bpf_prog *prog,
+						  u32 *target_size)
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
index b68aa61ef144..9583c96400cf 100644
--- a/include/uapi/linux/bpf.h
+++ b/include/uapi/linux/bpf.h
@@ -3377,6 +3377,14 @@ union bpf_attr {
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
@@ -3521,6 +3529,7 @@ union bpf_attr {
 	FN(skc_to_tcp_request_sock),	\
 	FN(skc_to_udp6_sock),		\
 	FN(get_task_stack),		\
+	FN(mptcp_sock),			\
 	/* */
 =

 /* integer value in 'imm' field of BPF_CALL instruction selects which help=
er
@@ -3850,6 +3859,10 @@ struct bpf_tcp_sock {
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
index 9a6703bc3f36..b913b1c1a71a 100644
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
 	       type =3D=3D PTR_TO_MEM_OR_NULL;
 }
@@ -424,6 +427,8 @@ static bool reg_type_may_be_refcounted_or_null(enum bpf=
_reg_type type)
 		type =3D=3D PTR_TO_SOCKET_OR_NULL ||
 		type =3D=3D PTR_TO_TCP_SOCK ||
 		type =3D=3D PTR_TO_TCP_SOCK_OR_NULL ||
+		type =3D=3D PTR_TO_MPTCP_SOCK ||
+		type =3D=3D PTR_TO_MPTCP_SOCK_OR_NULL ||
 		type =3D=3D PTR_TO_MEM ||
 		type =3D=3D PTR_TO_MEM_OR_NULL;
 }
@@ -497,6 +502,8 @@ static const char * const reg_type_str[] =3D {
 	[PTR_TO_SOCK_COMMON_OR_NULL] =3D "sock_common_or_null",
 	[PTR_TO_TCP_SOCK]	=3D "tcp_sock",
 	[PTR_TO_TCP_SOCK_OR_NULL] =3D "tcp_sock_or_null",
+	[PTR_TO_MPTCP_SOCK]	=3D "mptcp_sock",
+	[PTR_TO_MPTCP_SOCK_OR_NULL] =3D "mptcp_sock_or_null",
 	[PTR_TO_TP_BUFFER]	=3D "tp_buffer",
 	[PTR_TO_XDP_SOCK]	=3D "xdp_sock",
 	[PTR_TO_BTF_ID]		=3D "ptr_",
@@ -2170,6 +2177,8 @@ static bool is_spillable_regtype(enum bpf_reg_type ty=
pe)
 	case PTR_TO_SOCK_COMMON_OR_NULL:
 	case PTR_TO_TCP_SOCK:
 	case PTR_TO_TCP_SOCK_OR_NULL:
+	case PTR_TO_MPTCP_SOCK:
+	case PTR_TO_MPTCP_SOCK_OR_NULL:
 	case PTR_TO_XDP_SOCK:
 	case PTR_TO_BTF_ID:
 	case PTR_TO_BTF_ID_OR_NULL:
@@ -2767,6 +2776,9 @@ static int check_sock_access(struct bpf_verifier_env =
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
@@ -2925,6 +2937,9 @@ static int check_ptr_alignment(struct bpf_verifier_en=
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
@@ -4824,6 +4839,10 @@ static int check_helper_call(struct bpf_verifier_env=
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
@@ -5148,6 +5167,8 @@ static int adjust_ptr_min_max_vals(struct bpf_verifie=
r_env *env,
 	case PTR_TO_SOCK_COMMON_OR_NULL:
 	case PTR_TO_TCP_SOCK:
 	case PTR_TO_TCP_SOCK_OR_NULL:
+	case PTR_TO_MPTCP_SOCK:
+	case PTR_TO_MPTCP_SOCK_OR_NULL:
 	case PTR_TO_XDP_SOCK:
 		verbose(env, "R%d pointer arithmetic on %s prohibited\n",
 			dst, reg_type_str[ptr_reg->type]);
@@ -6802,6 +6823,8 @@ static void mark_ptr_or_null_reg(struct bpf_func_stat=
e *state,
 			reg->type =3D PTR_TO_SOCK_COMMON;
 		} else if (reg->type =3D=3D PTR_TO_TCP_SOCK_OR_NULL) {
 			reg->type =3D PTR_TO_TCP_SOCK;
+		} else if (reg->type =3D=3D PTR_TO_MPTCP_SOCK_OR_NULL) {
+			reg->type =3D PTR_TO_MPTCP_SOCK;
 		} else if (reg->type =3D=3D PTR_TO_BTF_ID_OR_NULL) {
 			reg->type =3D PTR_TO_BTF_ID;
 		} else if (reg->type =3D=3D PTR_TO_MEM_OR_NULL) {
@@ -8160,6 +8183,8 @@ static bool regsafe(struct bpf_reg_state *rold, struc=
t bpf_reg_state *rcur,
 	case PTR_TO_SOCK_COMMON_OR_NULL:
 	case PTR_TO_TCP_SOCK:
 	case PTR_TO_TCP_SOCK_OR_NULL:
+	case PTR_TO_MPTCP_SOCK:
+	case PTR_TO_MPTCP_SOCK_OR_NULL:
 	case PTR_TO_XDP_SOCK:
 		/* Only valid matches are exact, which memcmp() above
 		 * would have accepted
@@ -8687,6 +8712,8 @@ static bool reg_type_mismatch_ok(enum bpf_reg_type ty=
pe)
 	case PTR_TO_SOCK_COMMON_OR_NULL:
 	case PTR_TO_TCP_SOCK:
 	case PTR_TO_TCP_SOCK_OR_NULL:
+	case PTR_TO_MPTCP_SOCK:
+	case PTR_TO_MPTCP_SOCK_OR_NULL:
 	case PTR_TO_XDP_SOCK:
 	case PTR_TO_BTF_ID:
 	case PTR_TO_BTF_ID_OR_NULL:
@@ -9807,6 +9834,9 @@ static int convert_ctx_accesses(struct bpf_verifier_e=
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
index 048cb0adc75b..026d35a51b11 100644
--- a/net/core/filter.c
+++ b/net/core/filter.c
@@ -5903,6 +5903,69 @@ const struct bpf_func_proto bpf_tcp_sock_proto =3D {
 	.arg1_type	=3D ARG_PTR_TO_SOCK_COMMON,
 };
 =

+#ifdef CONFIG_MPTCP
+bool bpf_mptcp_sock_is_valid_access(int off, int size,
+		enum bpf_access_type type, struct bpf_insn_access_aux *info)
+{
+	if (off < 0 || off >=3D offsetofend(struct bpf_mptcp_sock,
+					  token))
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
+				    const struct bpf_insn *si,
+				    struct bpf_insn *insn_buf,
+				    struct bpf_prog *prog, u32 *target_size)
+{
+	struct bpf_insn *insn =3D insn_buf;
+
+#define BPF_MPTCP_SOCK_GET_COMMON(FIELD)					\
+	do {								\
+		BUILD_BUG_ON(sizeof_field(struct mptcp_sock, FIELD) > \
+			     sizeof_field(struct bpf_mptcp_sock, FIELD)); \
+		*insn++ =3D BPF_LDX_MEM(BPF_FIELD_SIZEOF(struct mptcp_sock, FIELD),\
+				      si->dst_reg, si->src_reg,	\
+				      offsetof(struct mptcp_sock, FIELD)); \
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
+#endif /* CONFIG_MPTCP */
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
+	.func		=3D bpf_mptcp_sock,
+	.gpl_only	=3D false,
+	.ret_type	=3D RET_PTR_TO_MPTCP_SOCK_OR_NULL,
+	.arg1_type	=3D ARG_PTR_TO_SOCK_COMMON,
+};
+
 BPF_CALL_1(bpf_get_listener_sock, struct sock *, sk)
 {
 	sk =3D sk_to_full_sk(sk);
@@ -6557,6 +6620,10 @@ sock_ops_func_proto(enum bpf_func_id func_id, const =
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
index b68aa61ef144..9583c96400cf 100644
--- a/tools/include/uapi/linux/bpf.h
+++ b/tools/include/uapi/linux/bpf.h
@@ -3377,6 +3377,14 @@ union bpf_attr {
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
@@ -3521,6 +3529,7 @@ union bpf_attr {
 	FN(skc_to_tcp_request_sock),	\
 	FN(skc_to_udp6_sock),		\
 	FN(get_task_stack),		\
+	FN(mptcp_sock),			\
 	/* */
 =

 /* integer value in 'imm' field of BPF_CALL instruction selects which help=
er
@@ -3850,6 +3859,10 @@ struct bpf_tcp_sock {
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

--===============7666739736069811269==--
