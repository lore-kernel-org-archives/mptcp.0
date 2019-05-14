Content-Type: multipart/mixed; boundary="===============7248409065013512252=="
MIME-Version: 1.0
From: Davide Caratti <dcaratti at redhat.com>
To: mptcp at lists.01.org
Subject: [MPTCP] [PATCH RFC mptcp 1/2] tcp: ulp: add functions to dump
 ulp-specific information
Date: Tue, 14 May 2019 11:14:08 +0200
Message-ID: <33f3fdfea7cef53c18e163feeb06168d2d6d11a2.1557824658.git.dcaratti@redhat.com>
In-Reply-To: cover.1557824658.git.dcaratti@redhat.com
X-Status: 
X-Keywords:                  
X-UID: 1160

--===============7248409065013512252==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

currently, only getsockopt() can be invoked to know if a ULP is on top of
a TCP socket. idiag_get_aux() and idiag_get_aux_size() are currently used
only by TCP MD5 extension: extend them to dump ULP-related information to
userspace tools like 'ss' when they query the kernel with INET_DIAG_INFO.

Signed-off-by: Davide Caratti <dcaratti(a)redhat.com>
---
 include/net/tcp.h              |  3 +++
 include/uapi/linux/inet_diag.h |  2 ++
 net/ipv4/tcp_diag.c            | 33 +++++++++++++++++++++++++++++++--
 3 files changed, 36 insertions(+), 2 deletions(-)

diff --git a/include/net/tcp.h b/include/net/tcp.h
index 02df4f946c06..16161dbbdea0 100644
--- a/include/net/tcp.h
+++ b/include/net/tcp.h
@@ -2100,6 +2100,9 @@ struct tcp_ulp_ops {
 	/* clone ulp */
 	void (*clone)(const struct request_sock *req, struct sock *newsk,
 		      const gfp_t priority);
+	/* diagnostic */
+	int (*get_info)(struct sock *sk, struct sk_buff *skb);
+	size_t (*get_info_size)(struct sock *sk);
 =

 	char		name[TCP_ULP_NAME_MAX];
 	struct module	*owner;
diff --git a/include/uapi/linux/inet_diag.h b/include/uapi/linux/inet_diag.h
index e8baca85bac6..195e10550dc8 100644
--- a/include/uapi/linux/inet_diag.h
+++ b/include/uapi/linux/inet_diag.h
@@ -153,6 +153,8 @@ enum {
 	INET_DIAG_BBRINFO,	/* request as INET_DIAG_VEGASINFO */
 	INET_DIAG_CLASS_ID,	/* request as INET_DIAG_TCLASS */
 	INET_DIAG_MD5SIG,
+	INET_DIAG_ULPNAME,
+	INET_DIAG_ULPINFO,
 	__INET_DIAG_MAX,
 };
 =

diff --git a/net/ipv4/tcp_diag.c b/net/ipv4/tcp_diag.c
index 81148f7a2323..c37a0eb7a9b8 100644
--- a/net/ipv4/tcp_diag.c
+++ b/net/ipv4/tcp_diag.c
@@ -88,10 +88,12 @@ static int tcp_diag_put_md5sig(struct sk_buff *skb,
 static int tcp_diag_get_aux(struct sock *sk, bool net_admin,
 			    struct sk_buff *skb)
 {
+	struct inet_connection_sock *icsk =3D inet_csk(sk);
+	int err =3D 0;
+
 #ifdef CONFIG_TCP_MD5SIG
 	if (net_admin) {
 		struct tcp_md5sig_info *md5sig;
-		int err =3D 0;
 =

 		rcu_read_lock();
 		md5sig =3D rcu_dereference(tcp_sk(sk)->md5sig_info);
@@ -102,12 +104,33 @@ static int tcp_diag_get_aux(struct sock *sk, bool net=
_admin,
 			return err;
 	}
 #endif
+	if (net_admin && icsk->icsk_ulp_ops) {
+		struct nlattr *nest;
 =

-	return 0;
+		err =3D nla_put_string(skb, INET_DIAG_ULPNAME,
+				     icsk->icsk_ulp_ops->name);
+		if (err < 0 || !icsk->icsk_ulp_ops->get_info)
+			return err;
+
+		nest =3D nla_nest_start_noflag(skb, INET_DIAG_ULPINFO);
+		if (!nest) {
+			err =3D -EMSGSIZE;
+			goto nla_failure;
+		}
+		err =3D icsk->icsk_ulp_ops->get_info(sk, skb);
+		if (err < 0) {
+nla_failure:
+			nla_nest_cancel(skb, nest);
+			return err;
+		}
+		nla_nest_end(skb, nest);
+	}
+	return err;
 }
 =

 static size_t tcp_diag_get_aux_size(struct sock *sk, bool net_admin)
 {
+	struct inet_connection_sock *icsk =3D inet_csk(sk);
 	size_t size =3D 0;
 =

 #ifdef CONFIG_TCP_MD5SIG
@@ -127,6 +150,12 @@ static size_t tcp_diag_get_aux_size(struct sock *sk, b=
ool net_admin)
 				       sizeof(struct tcp_diag_md5sig));
 	}
 #endif
+	if (net_admin && icsk->icsk_ulp_ops) {
+		size +=3D nla_total_size(TCP_ULP_NAME_MAX);
+		if (icsk->icsk_ulp_ops->get_info_size)
+			size +=3D nla_total_size(0) + /* INET_DIAG_ULPINFO */
+				icsk->icsk_ulp_ops->get_info_size(sk);
+	}
 =

 	return size;
 }
-- =

2.20.1


--===============7248409065013512252==--
