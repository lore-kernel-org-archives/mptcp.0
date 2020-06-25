Content-Type: multipart/mixed; boundary="===============0780749476518279160=="
MIME-Version: 1.0
From: Paolo Abeni <pabeni at redhat.com>
To: mptcp at lists.01.org
Subject: [MPTCP] [PATCH 1/3] inet_diag: support for wider protocol numbers
Date: Thu, 25 Jun 2020 12:22:28 +0200
Message-ID: <27168b417a02dec9b62cf62d2b89ca4c51a54f8e.1593080104.git.pabeni@redhat.com>
In-Reply-To: cover.1593080104.git.pabeni@redhat.com
X-Status: 
X-Keywords:                  
X-UID: 4797

--===============0780749476518279160==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

After commit bf9765145b85 ("sock: Make sk_protocol a 16-bit value")
the current size of 'sdiag_protocol' is not sufficient to represent
the possible protocol values.

This change introduces a new inet diag request attribute to let
user space specify the relevant protocol number using u32 values.

The attribute is parsed by inet diag core on get/dump command
and the extended protocol value, if available, is preferred to
'sdiag_protocol' to lookup the diag handler.

The parse attributed are exposed to all the diag handlers via
the cb->data.

Note that inet_diag_dump_one_icsk() is left unmodified, as it
will not be used by protocol using the extended attribute.

Suggested-by: David S. Miller <davem(a)davemloft.net>
Signed-off-by: Paolo Abeni <pabeni(a)redhat.com>
---
 include/uapi/linux/inet_diag.h |  1 +
 net/core/sock.c                |  1 +
 net/ipv4/inet_diag.c           | 63 +++++++++++++++++++++++++---------
 3 files changed, 48 insertions(+), 17 deletions(-)

diff --git a/include/uapi/linux/inet_diag.h b/include/uapi/linux/inet_diag.h
index e6f183ee8417..5ba122c1949a 100644
--- a/include/uapi/linux/inet_diag.h
+++ b/include/uapi/linux/inet_diag.h
@@ -65,6 +65,7 @@ enum {
 	INET_DIAG_REQ_NONE,
 	INET_DIAG_REQ_BYTECODE,
 	INET_DIAG_REQ_SK_BPF_STORAGES,
+	INET_DIAG_REQ_PROTOCOL,
 	__INET_DIAG_REQ_MAX,
 };
 =

diff --git a/net/core/sock.c b/net/core/sock.c
index 6c4acf1f0220..b359e29bb737 100644
--- a/net/core/sock.c
+++ b/net/core/sock.c
@@ -3573,6 +3573,7 @@ int sock_load_diag_module(int family, int protocol)
 #ifdef CONFIG_INET
 	if (family =3D=3D AF_INET &&
 	    protocol !=3D IPPROTO_RAW &&
+	    protocol < MAX_INET_PROTOS &&
 	    !rcu_access_pointer(inet_protos[protocol]))
 		return -ENOENT;
 #endif
diff --git a/net/ipv4/inet_diag.c b/net/ipv4/inet_diag.c
index 125f4f8a36b4..a3a7ef3fada6 100644
--- a/net/ipv4/inet_diag.c
+++ b/net/ipv4/inet_diag.c
@@ -52,6 +52,9 @@ static DEFINE_MUTEX(inet_diag_table_mutex);
 =

 static const struct inet_diag_handler *inet_diag_lock_handler(int proto)
 {
+	if (proto >=3D IPPROTO_MAX)
+		return ERR_PTR(-ENOENT);
+
 	if (!inet_diag_table[proto])
 		sock_load_diag_module(AF_INET, proto);
 =

@@ -181,6 +184,28 @@ int inet_diag_msg_attrs_fill(struct sock *sk, struct s=
k_buff *skb,
 }
 EXPORT_SYMBOL_GPL(inet_diag_msg_attrs_fill);
 =

+static void inet_diag_parse_attrs(const struct nlmsghdr *nlh, int hdrlen,
+				  struct nlattr **req_nlas)
+{
+	struct nlattr *nla;
+	int remaining;
+
+	nlmsg_for_each_attr(nla, nlh, hdrlen, remaining) {
+		int type =3D nla_type(nla);
+
+		if (type < __INET_DIAG_REQ_MAX)
+			req_nlas[type] =3D nla;
+	}
+}
+
+static int inet_diag_get_protocol(const struct inet_diag_req_v2 *req,
+				  const struct inet_diag_dump_data *data)
+{
+	if (data->req_nlas[INET_DIAG_REQ_PROTOCOL])
+		return nla_get_u32(data->req_nlas[INET_DIAG_REQ_PROTOCOL]);
+	return req->sdiag_protocol;
+}
+
 #define MAX_DUMP_ALLOC_SIZE (KMALLOC_MAX_SIZE - SKB_DATA_ALIGN(sizeof(stru=
ct skb_shared_info)))
 =

 int inet_sk_diag_fill(struct sock *sk, struct inet_connection_sock *icsk,
@@ -198,7 +223,7 @@ int inet_sk_diag_fill(struct sock *sk, struct inet_conn=
ection_sock *icsk,
 	void *info =3D NULL;
 =

 	cb_data =3D cb->data;
-	handler =3D inet_diag_table[req->sdiag_protocol];
+	handler =3D inet_diag_table[inet_diag_get_protocol(req, cb_data)];
 	BUG_ON(!handler);
 =

 	nlh =3D nlmsg_put(skb, NETLINK_CB(cb->skb).portid, cb->nlh->nlmsg_seq,
@@ -539,20 +564,25 @@ EXPORT_SYMBOL_GPL(inet_diag_dump_one_icsk);
 =

 static int inet_diag_cmd_exact(int cmd, struct sk_buff *in_skb,
 			       const struct nlmsghdr *nlh,
+			       int hdrlen,
 			       const struct inet_diag_req_v2 *req)
 {
 	const struct inet_diag_handler *handler;
-	int err;
+	struct inet_diag_dump_data dump_data;
+	int err, protocol;
 =

-	handler =3D inet_diag_lock_handler(req->sdiag_protocol);
+	memset(&dump_data, 0, sizeof(dump_data));
+	inet_diag_parse_attrs(nlh, hdrlen, dump_data.req_nlas);
+	protocol =3D inet_diag_get_protocol(req, &dump_data);
+
+	handler =3D inet_diag_lock_handler(protocol);
 	if (IS_ERR(handler)) {
 		err =3D PTR_ERR(handler);
 	} else if (cmd =3D=3D SOCK_DIAG_BY_FAMILY) {
-		struct inet_diag_dump_data empty_dump_data =3D {};
 		struct netlink_callback cb =3D {
 			.nlh =3D nlh,
 			.skb =3D in_skb,
-			.data =3D &empty_dump_data,
+			.data =3D &dump_data,
 		};
 		err =3D handler->dump_one(&cb, req);
 	} else if (cmd =3D=3D SOCK_DESTROY && handler->destroy) {
@@ -1103,13 +1133,16 @@ EXPORT_SYMBOL_GPL(inet_diag_dump_icsk);
 static int __inet_diag_dump(struct sk_buff *skb, struct netlink_callback *=
cb,
 			    const struct inet_diag_req_v2 *r)
 {
+	struct inet_diag_dump_data *cb_data =3D cb->data;
 	const struct inet_diag_handler *handler;
 	u32 prev_min_dump_alloc;
-	int err =3D 0;
+	int protocol, err =3D 0;
+
+	protocol =3D inet_diag_get_protocol(r, cb_data);
 =

 again:
 	prev_min_dump_alloc =3D cb->min_dump_alloc;
-	handler =3D inet_diag_lock_handler(r->sdiag_protocol);
+	handler =3D inet_diag_lock_handler(protocol);
 	if (!IS_ERR(handler))
 		handler->dump(skb, cb, r);
 	else
@@ -1139,19 +1172,13 @@ static int __inet_diag_dump_start(struct netlink_ca=
llback *cb, int hdrlen)
 	struct inet_diag_dump_data *cb_data;
 	struct sk_buff *skb =3D cb->skb;
 	struct nlattr *nla;
-	int rem, err;
+	int err;
 =

 	cb_data =3D kzalloc(sizeof(*cb_data), GFP_KERNEL);
 	if (!cb_data)
 		return -ENOMEM;
 =

-	nla_for_each_attr(nla, nlmsg_attrdata(nlh, hdrlen),
-			  nlmsg_attrlen(nlh, hdrlen), rem) {
-		int type =3D nla_type(nla);
-
-		if (type < __INET_DIAG_REQ_MAX)
-			cb_data->req_nlas[type] =3D nla;
-	}
+	inet_diag_parse_attrs(nlh, hdrlen, cb_data->req_nlas);
 =

 	nla =3D cb_data->inet_diag_nla_bc;
 	if (nla) {
@@ -1237,7 +1264,8 @@ static int inet_diag_get_exact_compat(struct sk_buff =
*in_skb,
 	req.idiag_states =3D rc->idiag_states;
 	req.id =3D rc->id;
 =

-	return inet_diag_cmd_exact(SOCK_DIAG_BY_FAMILY, in_skb, nlh, &req);
+	return inet_diag_cmd_exact(SOCK_DIAG_BY_FAMILY, in_skb, nlh,
+				   sizeof(struct inet_diag_req), &req);
 }
 =

 static int inet_diag_rcv_msg_compat(struct sk_buff *skb, struct nlmsghdr *=
nlh)
@@ -1279,7 +1307,8 @@ static int inet_diag_handler_cmd(struct sk_buff *skb,=
 struct nlmsghdr *h)
 		return netlink_dump_start(net->diag_nlsk, skb, h, &c);
 	}
 =

-	return inet_diag_cmd_exact(h->nlmsg_type, skb, h, nlmsg_data(h));
+	return inet_diag_cmd_exact(h->nlmsg_type, skb, h, hdrlen,
+				   nlmsg_data(h));
 }
 =

 static
-- =

2.26.2

--===============0780749476518279160==--
