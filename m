Content-Type: multipart/mixed; boundary="===============7045332682802114423=="
MIME-Version: 1.0
From: Matthieu Baerts <matthieu.baerts at tessares.net>
To: mptcp at lists.01.org
Subject: [MPTCP] [PATCH mptcp-next] bpf: move bpf_mptcp_sock_ fn out of
 CONFIG_INET
Date: Sat, 14 Nov 2020 09:19:36 +0100
Message-ID: <20201114081936.2617526-1-matthieu.baerts@tessares.net>
X-Status: 
X-Keywords:                  
X-UID: 6728

--===============7045332682802114423==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

If CONFIG_INET is not enabled, our bpf_mptcp_sock_*() functions were not
declared as reported by the 0-day bot.

We can simply move these bpf_mptcp_sock_*() functions out of

  #ifdef CONFIG_INET

Because these functions are surrounded with:

  #ifdef CONFIG_MPTCP

which depends on CONFIG_INET.

Fixes: 0da79c831507 ("bpf: add 'bpf_mptcp_sock' structure and helper")
Reported-by: kernel test robot <lkp(a)intel.com>
Link: https://lists.01.org/hyperkitty/list/mptcp(a)lists.01.org/thread/RT36=
VFHG56TKRUO6EJQOIIUPWDJZELIL/
Signed-off-by: Matthieu Baerts <matthieu.baerts(a)tessares.net>
---

Notes:
    to be squashed in "bpf: add 'bpf_mptcp_sock' structure and helper"

 include/linux/bpf.h | 56 ++++++++++++++++++++++-----------------------
 1 file changed, 28 insertions(+), 28 deletions(-)

diff --git a/include/linux/bpf.h b/include/linux/bpf.h
index 269033924cb7..10f2329ed654 100644
--- a/include/linux/bpf.h
+++ b/include/linux/bpf.h
@@ -1895,34 +1895,6 @@ struct sk_reuseport_kern {
 	bool bind_inany;
 };
 =

-#ifdef CONFIG_MPTCP
-bool bpf_mptcp_sock_is_valid_access(int off, int size,
-				    enum bpf_access_type type,
-				    struct bpf_insn_access_aux *info);
-
-u32 bpf_mptcp_sock_convert_ctx_access(enum bpf_access_type type,
-				      const struct bpf_insn *si,
-				      struct bpf_insn *insn_buf,
-				      struct bpf_prog *prog,
-				      u32 *target_size);
-#else /* CONFIG_MPTCP */
-static inline bool bpf_mptcp_sock_is_valid_access(int off, int size,
-						  enum bpf_access_type type,
-						  struct bpf_insn_access_aux *info)
-{
-	return false;
-}
-
-static inline u32 bpf_mptcp_sock_convert_ctx_access(enum bpf_access_type t=
ype,
-						    const struct bpf_insn *si,
-						    struct bpf_insn *insn_buf,
-						    struct bpf_prog *prog,
-						    u32 *target_size)
-{
-	return 0;
-}
-#endif /* CONFIG_MPTCP */
-
 bool bpf_tcp_sock_is_valid_access(int off, int size, enum bpf_access_type =
type,
 				  struct bpf_insn_access_aux *info);
 =

@@ -1973,6 +1945,34 @@ static inline u32 bpf_xdp_sock_convert_ctx_access(en=
um bpf_access_type type,
 }
 #endif /* CONFIG_INET */
 =

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
 enum bpf_text_poke_type {
 	BPF_MOD_CALL,
 	BPF_MOD_JUMP,
-- =

2.28.0

--===============7045332682802114423==--
