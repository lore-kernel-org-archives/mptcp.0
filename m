Content-Type: multipart/mixed; boundary="===============1823674222041176011=="
MIME-Version: 1.0
From: Matthieu Baerts <matthieu.baerts at tessares.net>
To: mptcp at lists.01.org
Subject: [MPTCP] [PATCH] mptcp: prefix subflow routines with mptcp_
Date: Mon, 30 Sep 2019 19:23:30 +0200
Message-ID: <5e089910-0490-fda1-6e33-b123e24ece1e@tessares.net>
X-Status: 
X-Keywords:                  
X-UID: 1968

--===============1823674222041176011==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hello,

As planned, I looked at prefixing with mptcp_ all exposed subflow_xxx()
routines (functions and structures).

I did that directly in the TopGit tree. I just need an approval to push
the changes :)
I made sure each exported commit is compiling as before. I also fix an
additional warning:

- 397f992497aa: 1st patch in "mptcp: Associate MPTCP context with TCP
socket"
- 1ebb17ea7b40: conflict in
t/mptcp-Handle-MP_CAPABLE-options-for-outgoing-connections
- ac3944a29ad8: conflict in
t/mptcp-Create-SUBFLOW-socket-for-incoming-connections
- a0f93af7bd70: build-fix, in "mptcp: Associate MPTCP context with TCP
socket"
- 27bbecae8653: conflict in
t/mptcp-Handle-MP_CAPABLE-options-for-outgoing-connections
- 37e987cb2dce: conflict in
t/mptcp-Handle-MP_CAPABLE-options-for-outgoing-connections
- 135935f47ebb: build-fix, in "mptcp: add mptcp_poll"
- f9d12ac4153f: conflict in
t/mptcp-Create-SUBFLOW-socket-for-incoming-connections
- d1f30786e37e: build-fix, in "mptcp: Create SUBFLOW socket for incoming
connections" ## also removed unused vars that were already there before
- 771afd683bce: 2nd patch in "mptcp: Create SUBFLOW socket for incoming
connections"
- 1d1fd83c6490: conflict in t/mptcp-Add-key-generation-and-token-tree
- be827265d4c9: build-fix, in "mptcp: Add key generation and token tree"
- e422bac911a7: build-fix, in "mptcp: Add shutdown() socket operation"
- 29eb0d0b4053: build-fix, in "mptcp: Write MPTCP DSS headers to
outgoing data packets"
- ebebd5f0ddb9: conflict in t/mptcp-Implement-MPTCP-receive-path
- 6f97f6fbcca5: build-fix, in "mptcp: Implement MPTCP receive path"
- e6e99ca52ee9: conflict in t/mptcp-Add-path-manager-interface
- 6e6582b8fbd6: build-fix, in "mptcp: Add path manager interface"
- 780b8d642b52: build-fix, in "mptcp: Add ADD_ADDR handling"
- 7fbade176d28: conflict in
t/mptcp-Add-handling-of-incoming-MP_JOIN-requests
- 450c40831c1a: build-fix, in "mptcp: Add handling of incoming MP_JOIN
requests"
- e2cf185fa8ed: conflict in
t/mptcp-harmonize-locking-on-all-socket-operations
- a22dc45fb884: build-fix, in "mptcp: harmonize locking on all socket
operations."
- 03b30f5ab420: conflict in
t/mptcp-new-sysctl-to-control-the-activation-per-NS
- e456c89f9ee8: conflict in
t/mptcp-Add-handling-of-outgoing-MP_JOIN-requests
- ba1130a4e0ab: build-fix, in "mptcp: Add handling of outgoing MP_JOIN
requests"
- ae4d94be7818: 3rd patch in "mptcp: Add handling of outgoing MP_JOIN
requests"
- d092649e080a: build-fix, in "mptcp: Implement path manager interface
commands"
- 5a29aef0ec5e: conflict in
t/mptcp-Make-MPTCP-socket-block-wakeup-ignore-sk_receive_queue
- b864a19f93a7: conflict in
t/mptcp-queue-data-for-mptcp-level-retransmission
- 6fa2165ba14d: conflict in
t/mptcp-implement-memory-accounting-for-mptcp-rtx-queue
- 37cb660793c0: conflict in
t/mptcp-rework-mptcp_sendmsg_frag-to-accept-optional-dfrag
- 833fd784d834: conflict in
t/mptcp-implement-and-use-MPTCP-level-retransmission



Here is the diff:



diff --git a/net/mptcp/options.c b/net/mptcp/options.c
index dd16d2ab8cc7..5e575999e281 100644
--- a/net/mptcp/options.c
+++ b/net/mptcp/options.c
@@ -308,7 +308,7 @@ void mptcp_get_options(const struct sk_buff *skb,
 bool mptcp_syn_options(struct sock *sk, unsigned int *size,
 		       struct mptcp_out_options *opts)
 {
-	struct subflow_context *subflow =3D subflow_ctx(sk);
+	struct mptcp_subflow_context *subflow =3D mptcp_subflow_ctx(sk);

 	if (subflow->request_mptcp) {
 		pr_debug("local_key=3D%llu", subflow->local_key);
@@ -332,8 +332,8 @@ bool mptcp_syn_options(struct sock *sk, unsigned int
*size,

 void mptcp_rcv_synsent(struct sock *sk)
 {
+	struct mptcp_subflow_context *subflow =3D mptcp_subflow_ctx(sk);
 	struct tcp_sock *tp =3D tcp_sk(sk);
-	struct subflow_context *subflow =3D subflow_ctx(sk);

 	if (subflow->request_mptcp && tp->rx_opt.mptcp.mp_capable) {
 		subflow->mp_capable =3D 1;
@@ -353,7 +353,7 @@ static bool mptcp_established_options_mp(struct sock
*sk, unsigned int *size,
 					 unsigned int remaining,
 					 struct mptcp_out_options *opts)
 {
-	struct subflow_context *subflow =3D subflow_ctx(sk);
+	struct mptcp_subflow_context *subflow =3D mptcp_subflow_ctx(sk);

 	if (subflow->mp_capable && !subflow->fourth_ack &&
 	    remaining >=3D TCPOLEN_MPTCP_MPC_ACK) {
@@ -393,7 +393,7 @@ static bool mptcp_established_options_dss(struct
sock *sk, struct sk_buff *skb,
 		bool use_csum;

 		map_size =3D TCPOLEN_MPTCP_DSS_BASE + TCPOLEN_MPTCP_DSS_MAP64;
-		use_csum =3D subflow_ctx(sk)->use_checksum;
+		use_csum =3D mptcp_subflow_ctx(sk)->use_checksum;
 		if (use_csum)
 			map_size +=3D TCPOLEN_MPTCP_DSS_CHECKSUM;

@@ -426,11 +426,11 @@ static bool mptcp_established_options_dss(struct
sock *sk, struct sk_buff *skb,

 		dss_size +=3D ack_size;

-		msk =3D mptcp_sk(subflow_ctx(sk)->conn);
+		msk =3D mptcp_sk(mptcp_subflow_ctx(sk)->conn);
 		if (msk) {
 			opts->ext_copy.data_ack =3D msk->ack_seq;
 		} else {
-			mptcp_crypto_key_sha1(subflow_ctx(sk)->remote_key,
+			mptcp_crypto_key_sha1(mptcp_subflow_ctx(sk)->remote_key,
 					      NULL, &opts->ext_copy.data_ack);
 			opts->ext_copy.data_ack++;
 		}
@@ -454,7 +454,7 @@ static bool mptcp_established_options_addr(struct
sock *sk,
 					   unsigned int remaining,
 					   struct mptcp_out_options *opts)
 {
-	struct subflow_context *subflow =3D subflow_ctx(sk);
+	struct mptcp_subflow_context *subflow =3D mptcp_subflow_ctx(sk);
 	struct mptcp_sock *msk =3D mptcp_sk(subflow->conn);
 	struct sockaddr_storage saddr;
 	u8 id;
@@ -485,7 +485,7 @@ bool mptcp_established_options(struct sock *sk,
struct sk_buff *skb,
 			       unsigned int *size, unsigned int remaining,
 			       struct mptcp_out_options *opts)
 {
-	struct subflow_context *subflow =3D subflow_ctx(sk);
+	struct mptcp_subflow_context *subflow =3D mptcp_subflow_ctx(sk);
 	unsigned int opt_size =3D 0;
 	bool ret =3D false;

@@ -514,7 +514,7 @@ bool mptcp_established_options(struct sock *sk,
struct sk_buff *skb,
 bool mptcp_synack_options(const struct request_sock *req, unsigned int
*size,
 			  struct mptcp_out_options *opts)
 {
-	struct subflow_request_sock *subflow_req =3D subflow_rsk(req);
+	struct mptcp_subflow_request_sock *subflow_req =3D mptcp_subflow_rsk(req);

 	if (subflow_req->mp_capable) {
 		opts->suboptions =3D OPTION_MPTCP_MPC_SYNACK;
@@ -578,7 +578,7 @@ void update_una(struct mptcp_sock *msk, struct
mptcp_options_received *mp_opt)
 void mptcp_incoming_options(struct sock *sk, struct sk_buff *skb,
 			    struct tcp_options_received *opt_rx)
 {
-	struct subflow_context *subflow =3D subflow_ctx(sk);
+	struct mptcp_subflow_context *subflow =3D mptcp_subflow_ctx(sk);
 	struct mptcp_sock *msk =3D mptcp_sk(subflow->conn);
 	struct mptcp_options_received *mp_opt;
 	struct mptcp_ext *mpext;
diff --git a/net/mptcp/pm.c b/net/mptcp/pm.c
index c8d6341c9683..7c7c00f9f7e8 100644
--- a/net/mptcp/pm.c
+++ b/net/mptcp/pm.c
@@ -75,7 +75,8 @@ int pm_create_subflow(u32 token, u8 remote_id)
 	remote.sin_port =3D htons(msk->dport);
 	remote.sin_addr.s_addr =3D msk->pm.remote_addr.s_addr;

-	err =3D subflow_connect((struct sock *)msk, &local, &remote, remote_id);
+	err =3D mptcp_subflow_connect((struct sock *)msk, &local, &remote,
+				    remote_id);

 create_put:
 	sock_put((struct sock *)msk);
@@ -161,7 +162,7 @@ int pm_addr_signal(struct mptcp_sock *msk, u8 *id,
 int pm_get_local_id(struct request_sock *req, struct sock *sk,
 		    const struct sk_buff *skb)
 {
-	struct subflow_request_sock *subflow_req =3D subflow_rsk(req);
+	struct mptcp_subflow_request_sock *subflow_req =3D mptcp_subflow_rsk(req);
 	struct mptcp_sock *msk =3D mptcp_sk(sk);

 	if (!msk->pm.local_valid)
diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index 01bc35fe9374..b54fecf528b9 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -80,7 +80,7 @@ static struct socket *mptcp_fallback_get_ref(const
struct mptcp_sock *msk)

 static struct sock *mptcp_subflow_get_ref(const struct mptcp_sock *msk)
 {
-	struct subflow_context *subflow;
+	struct mptcp_subflow_context *subflow;

 	sock_owned_by_me((const struct sock *)msk);

@@ -305,7 +305,7 @@ static int mptcp_sendmsg_frag(struct sock *sk,
struct sock *ssk,
 	if (mpext) {
 		memset(mpext, 0, sizeof(*mpext));
 		mpext->data_seq =3D *write_seq;
-		mpext->subflow_seq =3D subflow_ctx(ssk)->rel_write_seq;
+		mpext->subflow_seq =3D mptcp_subflow_ctx(ssk)->rel_write_seq;
 		mpext->data_len =3D ret;
 		mpext->checksum =3D 0xbeef;
 		mpext->use_map =3D 1;
@@ -322,7 +322,7 @@ static int mptcp_sendmsg_frag(struct sock *sk,
struct sock *ssk,
 out:
 	*poffset +=3D frag_truesize;
 	*write_seq +=3D ret;
-	subflow_ctx(ssk)->rel_write_seq +=3D ret;
+	mptcp_subflow_ctx(ssk)->rel_write_seq +=3D ret;

 	return ret;
 }
@@ -410,14 +410,14 @@ static u64 expand_seq(u64 old_seq, u16
old_data_len, u64 seq)
 	return seq | ((old_seq + old_data_len + 1) & GENMASK_ULL(63, 32));
 }

-static u64 get_map_offset(struct subflow_context *subflow)
+static u64 get_map_offset(struct mptcp_subflow_context *subflow)
 {
 	return tcp_sk(mptcp_subflow_tcp_socket(subflow)->sk)->copied_seq -
 		      subflow->ssn_offset -
 		      subflow->map_subflow_seq;
 }

-static u64 get_mapped_dsn(struct subflow_context *subflow)
+static u64 get_mapped_dsn(struct mptcp_subflow_context *subflow)
 {
 	return subflow->map_seq + get_map_offset(subflow);
 }
@@ -460,7 +460,7 @@ enum mapping_status {

 static enum mapping_status mptcp_get_mapping(struct sock *ssk)
 {
-	struct subflow_context *subflow =3D subflow_ctx(ssk);
+	struct mptcp_subflow_context *subflow =3D mptcp_subflow_ctx(ssk);
 	struct mptcp_ext *mpext;
 	enum mapping_status ret;
 	struct sk_buff *skb;
@@ -556,7 +556,7 @@ static void mptcp_wait_data(struct sock *sk, long
*timeo)
 	remove_wait_queue(sk_sleep(sk), &wait);
 }

-static void warn_bad_map(struct subflow_context *subflow, u32 ssn)
+static void warn_bad_map(struct mptcp_subflow_context *subflow, u32 ssn)
 {
 	WARN_ONCE(1, "Bad mapping: ssn=3D%d map_seq=3D%d map_data_len=3D%d",
 		  ssn, subflow->map_subflow_seq, subflow->map_data_len);
@@ -566,7 +566,7 @@ static int mptcp_recvmsg(struct sock *sk, struct
msghdr *msg, size_t len,
 			 int nonblock, int flags, int *addr_len)
 {
 	struct mptcp_sock *msk =3D mptcp_sk(sk);
-	struct subflow_context *subflow;
+	struct mptcp_subflow_context *subflow;
 	struct mptcp_read_arg arg;
 	read_descriptor_t desc;
 	struct socket *ssock;
@@ -579,7 +579,8 @@ static int mptcp_recvmsg(struct sock *sk, struct
msghdr *msg, size_t len,
 	ssock =3D __mptcp_fallback_get_ref(msk);
 	if (ssock) {
 		release_sock(sk);
-		pr_debug("fallback-read subflow=3D%p", subflow_ctx(ssock->sk));
+		pr_debug("fallback-read subflow=3D%p",
+			 mptcp_subflow_ctx(ssock->sk));
 		copied =3D sock_recvmsg(ssock, msg, flags);
 		sock_put(ssock->sk);
 		return copied;
@@ -591,7 +592,7 @@ static int mptcp_recvmsg(struct sock *sk, struct
msghdr *msg, size_t len,
 		return -ENOTCONN;
 	}

-	subflow =3D subflow_ctx(ssk);
+	subflow =3D mptcp_subflow_ctx(ssk);
 	tp =3D tcp_sk(ssk);

 	lock_sock(ssk);
@@ -896,8 +897,8 @@ static void mptcp_cancel_rtx_work(struct sock *sk)

 static void mptcp_close(struct sock *sk, long timeout)
 {
+	struct mptcp_subflow_context *subflow, *tmp;
 	struct mptcp_sock *msk =3D mptcp_sk(sk);
-	struct subflow_context *subflow, *tmp;
 	struct socket *ssk =3D NULL;

 	mptcp_token_destroy(msk->token);
@@ -941,17 +942,19 @@ static struct sock *mptcp_accept(struct sock *sk,
int flags, int *err,
 				 bool kern)
 {
 	struct mptcp_sock *msk =3D mptcp_sk(sk);
-	struct socket *listener =3D msk->subflow;
-	struct subflow_context *subflow;
+	struct mptcp_subflow_context *subflow;
 	struct socket *new_sock;
+	struct socket *listener;
 	struct sock *newsk;

-	pr_debug("msk=3D%p, listener=3D%p", msk, subflow_ctx(listener->sk));
+	listener =3D msk->subflow;
+
+	pr_debug("msk=3D%p, listener=3D%p", msk, mptcp_subflow_ctx(listener->sk));
 	*err =3D kernel_accept(listener, &new_sock, flags);
 	if (*err < 0)
 		return NULL;

-	subflow =3D subflow_ctx(new_sock->sk);
+	subflow =3D mptcp_subflow_ctx(new_sock->sk);
 	pr_debug("msk=3D%p, new subflow=3D%p, ", msk, subflow);

 	if (subflow->mp_capable) {
@@ -1096,15 +1099,18 @@ static int mptcp_get_port(struct sock *sk,
unsigned short snum)
 {
 	struct mptcp_sock *msk =3D mptcp_sk(sk);

-	pr_debug("msk=3D%p, subflow=3D%p", msk, subflow_ctx(msk->subflow->sk));
+	pr_debug("msk=3D%p, subflow=3D%p", msk,
+		 mptcp_subflow_ctx(msk->subflow->sk));

 	return inet_csk_get_port(msk->subflow->sk, snum);
 }

 void mptcp_finish_connect(struct sock *sk, int mp_capable)
 {
+	struct mptcp_subflow_context *subflow;
 	struct mptcp_sock *msk =3D mptcp_sk(sk);
-	struct subflow_context *subflow =3D subflow_ctx(msk->subflow->sk);
+
+	subflow =3D mptcp_subflow_ctx(msk->subflow->sk);

 	if (mp_capable) {
 		u64 ack_seq;
@@ -1158,7 +1164,7 @@ void mptcp_finish_connect(struct sock *sk, int
mp_capable)

 void mptcp_finish_join(struct sock *sk)
 {
-	struct subflow_context *subflow =3D subflow_ctx(sk);
+	struct mptcp_subflow_context *subflow =3D mptcp_subflow_ctx(sk);
 	struct mptcp_sock *msk =3D mptcp_sk(subflow->conn);

 	pr_debug("msk=3D%p, subflow=3D%p", msk, subflow);
@@ -1173,7 +1179,7 @@ void mptcp_finish_join(struct sock *sk)

 bool mptcp_sk_is_subflow(const struct sock *sk)
 {
-	struct subflow_context *subflow =3D subflow_ctx(sk);
+	struct mptcp_subflow_context *subflow =3D mptcp_subflow_ctx(sk);

 	return subflow->mp_join =3D=3D 1;
 }
@@ -1206,8 +1212,8 @@ static struct proto mptcp_prot =3D {

 static struct socket *mptcp_socket_create_get(struct mptcp_sock *msk)
 {
+	struct mptcp_subflow_context *subflow;
 	struct sock *sk =3D (struct sock *)msk;
-	struct subflow_context *subflow;
 	struct socket *ssock;
 	int err;

@@ -1216,14 +1222,14 @@ static struct socket
*mptcp_socket_create_get(struct mptcp_sock *msk)
 	if (ssock)
 		goto release;

-	err =3D subflow_create_socket(sk, &ssock);
+	err =3D mptcp_subflow_create_socket(sk, &ssock);
 	if (err) {
 		ssock =3D ERR_PTR(err);
 		goto release;
 	}

 	msk->subflow =3D ssock;
-	subflow =3D subflow_ctx(msk->subflow->sk);
+	subflow =3D mptcp_subflow_ctx(msk->subflow->sk);
 	subflow->request_mptcp =3D 1; /* @@ if MPTCP enabled */
 	subflow->request_cksum =3D 0; /* checksum not supported */
 	subflow->request_version =3D 0; /* only v0 supported */
@@ -1356,7 +1362,7 @@ static int mptcp_stream_accept(struct socket
*sock, struct socket *newsock,
 static __poll_t mptcp_poll(struct file *file, struct socket *sock,
 			   struct poll_table_struct *wait)
 {
-	struct subflow_context *subflow;
+	struct mptcp_subflow_context *subflow;
 	const struct mptcp_sock *msk;
 	struct sock *sk =3D sock->sk;
 	struct socket *ssock;
@@ -1386,7 +1392,7 @@ static __poll_t mptcp_poll(struct file *file,
struct socket *sock,
 static int mptcp_shutdown(struct socket *sock, int how)
 {
 	struct mptcp_sock *msk =3D mptcp_sk(sock->sk);
-	struct subflow_context *subflow;
+	struct mptcp_subflow_context *subflow;
 	struct socket *ssock;
 	int ret =3D 0;

@@ -1439,7 +1445,7 @@ void mptcp_proto_init(void)
 	if (percpu_counter_init(&mptcp_sockets_allocated, 0, GFP_KERNEL))
 		panic("Failed to allocate MPTCP pcpu counter\n");

-	subflow_init();
+	mptcp_subflow_init();
 	pm_init();

 	if (proto_register(&mptcp_prot, 1) !=3D 0)
diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
index dc75401cca0b..0c6bc8617cf4 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -169,7 +169,7 @@ static inline struct mptcp_data_frag
*mptcp_rtx_head(const struct sock *sk)
 	return list_first_entry(&msk->rtx_queue, struct mptcp_data_frag, list);
 }

-struct subflow_request_sock {
+struct mptcp_subflow_request_sock {
 	struct	tcp_request_sock sk;
 	u8	mp_capable : 1,
 		mp_join : 1,
@@ -188,14 +188,14 @@ struct subflow_request_sock {
 	u32	remote_nonce;
 };

-static inline
-struct subflow_request_sock *subflow_rsk(const struct request_sock *rsk)
+static inline struct mptcp_subflow_request_sock *
+mptcp_subflow_rsk(const struct request_sock *rsk)
 {
-	return (struct subflow_request_sock *)rsk;
+	return (struct mptcp_subflow_request_sock *)rsk;
 }

 /* MPTCP subflow context */
-struct subflow_context {
+struct mptcp_subflow_context {
 	struct	list_head node;/* conn_list of subflows */
 	u64	local_key;
 	u64	remote_key;
@@ -233,25 +233,27 @@ struct subflow_context {
 	struct	rcu_head rcu;
 };

-static inline struct subflow_context *subflow_ctx(const struct sock *sk)
+static inline struct mptcp_subflow_context *
+mptcp_subflow_ctx(const struct sock *sk)
 {
 	struct inet_connection_sock *icsk =3D inet_csk(sk);
+
 	/* Use RCU on icsk_ulp_data only for sock diag code */
-	return (__force struct subflow_context *)icsk->icsk_ulp_data;
+	return (__force struct mptcp_subflow_context *)icsk->icsk_ulp_data;
 }

 static inline struct socket *
-mptcp_subflow_tcp_socket(const struct subflow_context *subflow)
+mptcp_subflow_tcp_socket(const struct mptcp_subflow_context *subflow)
 {
 	return subflow->tcp_sock;
 }

 int mptcp_is_enabled(struct net *net);

-void subflow_init(void);
-int subflow_connect(struct sock *sk, struct sockaddr_in *local,
-		    struct sockaddr_in *remote, u8 remote_id);
-int subflow_create_socket(struct sock *sk, struct socket **new_sock);
+void mptcp_subflow_init(void);
+int mptcp_subflow_connect(struct sock *sk, struct sockaddr_in *local,
+			  struct sockaddr_in *remote, u8 remote_id);
+int mptcp_subflow_create_socket(struct sock *sk, struct socket **new_sock);

 extern const struct inet_connection_sock_af_ops ipv4_specific;

diff --git a/net/mptcp/subflow.c b/net/mptcp/subflow.c
index c86ce35580cd..7a94049587cc 100644
--- a/net/mptcp/subflow.c
+++ b/net/mptcp/subflow.c
@@ -20,7 +20,7 @@

 static int subflow_rebuild_header(struct sock *sk)
 {
-	struct subflow_context *subflow =3D subflow_ctx(sk);
+	struct mptcp_subflow_context *subflow =3D mptcp_subflow_ctx(sk);
 	int err =3D 0;

 	if (subflow->request_mptcp && !subflow->token) {
@@ -43,7 +43,7 @@ static int subflow_rebuild_header(struct sock *sk)

 static void subflow_req_destructor(struct request_sock *req)
 {
-	struct subflow_request_sock *subflow_req =3D subflow_rsk(req);
+	struct mptcp_subflow_request_sock *subflow_req =3D mptcp_subflow_rsk(req);

 	pr_debug("subflow_req=3D%p", subflow_req);

@@ -56,7 +56,7 @@ static void subflow_req_destructor(struct request_sock
*req)
 static bool subflow_token_join_request(struct request_sock *req,
 				       const struct sk_buff *skb)
 {
-	struct subflow_request_sock *subflow_req =3D subflow_rsk(req);
+	struct mptcp_subflow_request_sock *subflow_req =3D mptcp_subflow_rsk(req);
 	u8 hmac[MPTCPOPT_HMAC_LEN];
 	struct mptcp_sock *msk;

@@ -88,8 +88,8 @@ static void subflow_v4_init_req(struct request_sock *req,
 				const struct sock *sk_listener,
 				struct sk_buff *skb)
 {
-	struct subflow_request_sock *subflow_req =3D subflow_rsk(req);
-	struct subflow_context *listener =3D subflow_ctx(sk_listener);
+	struct mptcp_subflow_context *listener =3D mptcp_subflow_ctx(sk_listener);
+	struct mptcp_subflow_request_sock *subflow_req =3D mptcp_subflow_rsk(req);
 	struct tcp_options_received rx_opt;

 	tcp_rsk(req)->is_mptcp =3D 1;
@@ -138,7 +138,7 @@ static void subflow_v4_init_req(struct request_sock
*req,
 }

 /* validate received truncated hmac and create hmac for third ACK */
-static bool subflow_thmac_valid(struct subflow_context *subflow)
+static bool subflow_thmac_valid(struct mptcp_subflow_context *subflow)
 {
 	u8 hmac[MPTCPOPT_HMAC_LEN];
 	u64 thmac;
@@ -158,7 +158,7 @@ static bool subflow_thmac_valid(struct
subflow_context *subflow)

 static void subflow_finish_connect(struct sock *sk, const struct
sk_buff *skb)
 {
-	struct subflow_context *subflow =3D subflow_ctx(sk);
+	struct mptcp_subflow_context *subflow =3D mptcp_subflow_ctx(sk);

 	inet_sk_rx_dst_set(sk, skb);

@@ -166,7 +166,7 @@ static void subflow_finish_connect(struct sock *sk,
const struct sk_buff *skb)
 		return;

 	if (subflow->mp_capable && !subflow->conn_finished) {
-		pr_debug("subflow=3D%p, remote_key=3D%llu", subflow_ctx(sk),
+		pr_debug("subflow=3D%p, remote_key=3D%llu", mptcp_subflow_ctx(sk),
 			 subflow->remote_key);
 		mptcp_finish_connect(subflow->conn, subflow->mp_capable);
 		subflow->conn_finished =3D 1;
@@ -177,7 +177,7 @@ static void subflow_finish_connect(struct sock *sk,
const struct sk_buff *skb)
 		}
 	} else if (subflow->mp_join && !subflow->conn_finished) {
 		pr_debug("subflow=3D%p, thmac=3D%llu, remote_nonce=3D%u",
-			 subflow_ctx(sk), subflow->thmac,
+			 subflow, subflow->thmac,
 			 subflow->remote_nonce);
 		if (!subflow_thmac_valid(subflow)) {
 			subflow->mp_join =3D 0;
@@ -200,7 +200,7 @@ static struct tcp_request_sock_ops
subflow_request_sock_ipv4_ops;

 static int subflow_conn_request(struct sock *sk, struct sk_buff *skb)
 {
-	struct subflow_context *subflow =3D subflow_ctx(sk);
+	struct mptcp_subflow_context *subflow =3D mptcp_subflow_ctx(sk);

 	pr_debug("subflow=3D%p", subflow);

@@ -220,11 +220,12 @@ static int subflow_conn_request(struct sock *sk,
struct sk_buff *skb)
 static bool subflow_hmac_valid(const struct request_sock *req,
 			       const struct tcp_options_received *rx_opt)
 {
-	const struct subflow_request_sock *subflow_req =3D subflow_rsk(req);
+	const struct mptcp_subflow_request_sock *subflow_req;
 	u8 hmac[MPTCPOPT_HMAC_LEN];
 	struct mptcp_sock *msk;
 	bool ret;

+	subflow_req =3D mptcp_subflow_rsk(req);
 	msk =3D mptcp_token_get_sock(subflow_req->token);
 	if (!msk)
 		return false;
@@ -248,15 +249,15 @@ static struct sock *subflow_syn_recv_sock(const
struct sock *sk,
 					  struct request_sock *req_unhash,
 					  bool *own_req)
 {
-	struct subflow_context *listener =3D subflow_ctx(sk);
-	struct subflow_request_sock *subflow_req;
+	struct mptcp_subflow_context *listener =3D mptcp_subflow_ctx(sk);
+	struct mptcp_subflow_request_sock *subflow_req;
 	struct tcp_options_received opt_rx;
 	struct sock *child;

 	pr_debug("listener=3D%p, req=3D%p, conn=3D%p", listener, req, listener->c=
onn);

 	/* if the sk is MP_CAPABLE, we already received the client key */
-	subflow_req =3D subflow_rsk(req);
+	subflow_req =3D mptcp_subflow_rsk(req);
 	if (!subflow_req->mp_capable && subflow_req->mp_join) {
 		opt_rx.mptcp.mp_join =3D 0;
 		mptcp_get_options(skb, &opt_rx);
@@ -268,7 +269,7 @@ static struct sock *subflow_syn_recv_sock(const
struct sock *sk,
 	child =3D tcp_v4_syn_recv_sock(sk, skb, req, dst, req_unhash, own_req);

 	if (child && *own_req) {
-		struct subflow_context *ctx =3D subflow_ctx(child);
+		struct mptcp_subflow_context *ctx =3D mptcp_subflow_ctx(child);

 		if (!ctx)
 			goto close_child;
@@ -302,7 +303,7 @@ static struct inet_connection_sock_af_ops
subflow_specific;

 static void subflow_data_ready(struct sock *sk)
 {
-	struct subflow_context *subflow =3D subflow_ctx(sk);
+	struct mptcp_subflow_context *subflow =3D mptcp_subflow_ctx(sk);
 	struct sock *parent =3D subflow->conn;

 	pr_debug("sk=3D%p", sk);
@@ -319,23 +320,23 @@ static void subflow_data_ready(struct sock *sk)
 	}
 }

-int subflow_connect(struct sock *sk, struct sockaddr_in *local,
-		    struct sockaddr_in *remote, u8 remote_id)
+int mptcp_subflow_connect(struct sock *sk, struct sockaddr_in *local,
+			  struct sockaddr_in *remote, u8 remote_id)
 {
 	struct mptcp_sock *msk =3D mptcp_sk(sk);
-	struct subflow_context *subflow;
+	struct mptcp_subflow_context *subflow;
 	struct socket *sf;
 	u32 remote_token;
 	int err;

 	lock_sock(sk);
-	err =3D subflow_create_socket(sk, &sf);
+	err =3D mptcp_subflow_create_socket(sk, &sf);
 	if (err) {
 		release_sock(sk);
 		return err;
 	}

-	subflow =3D subflow_ctx(sf->sk);
+	subflow =3D mptcp_subflow_ctx(sf->sk);
 	subflow->remote_key =3D msk->remote_key;
 	subflow->local_key =3D msk->local_key;
 	subflow->token =3D msk->token;
@@ -369,9 +370,9 @@ int subflow_connect(struct sock *sk, struct
sockaddr_in *local,
 	return err;
 }

-int subflow_create_socket(struct sock *sk, struct socket **new_sock)
+int mptcp_subflow_create_socket(struct sock *sk, struct socket **new_sock)
 {
-	struct subflow_context *subflow;
+	struct mptcp_subflow_context *subflow;
 	struct net *net =3D sock_net(sk);
 	struct socket *sf;
 	int err;
@@ -387,7 +388,7 @@ int subflow_create_socket(struct sock *sk, struct
socket **new_sock)
 	if (err)
 		return err;

-	subflow =3D subflow_ctx(sf->sk);
+	subflow =3D mptcp_subflow_ctx(sf->sk);
 	pr_debug("subflow=3D%p", subflow);

 	*new_sock =3D sf;
@@ -397,12 +398,12 @@ int subflow_create_socket(struct sock *sk, struct
socket **new_sock)
 	return 0;
 }

-static struct subflow_context *subflow_create_ctx(struct sock *sk,
-						  struct socket *sock,
-						  gfp_t priority)
+static struct mptcp_subflow_context *subflow_create_ctx(struct sock *sk,
+							struct socket *sock,
+							gfp_t priority)
 {
 	struct inet_connection_sock *icsk =3D inet_csk(sk);
-	struct subflow_context *ctx;
+	struct mptcp_subflow_context *ctx;

 	ctx =3D kzalloc(sizeof(*ctx), priority);
 	if (!ctx)
@@ -419,9 +420,9 @@ static struct subflow_context
*subflow_create_ctx(struct sock *sk,

 static int subflow_ulp_init(struct sock *sk)
 {
-	struct tcp_sock *tp =3D tcp_sk(sk);
 	struct inet_connection_sock *icsk =3D inet_csk(sk);
-	struct subflow_context *ctx;
+	struct mptcp_subflow_context *ctx;
+	struct tcp_sock *tp =3D tcp_sk(sk);
 	int err =3D 0;

 	ctx =3D subflow_create_ctx(sk, sk->sk_socket, GFP_KERNEL);
@@ -443,7 +444,7 @@ static int subflow_ulp_init(struct sock *sk)

 static void subflow_ulp_release(struct sock *sk)
 {
-	struct subflow_context *ctx =3D subflow_ctx(sk);
+	struct mptcp_subflow_context *ctx =3D mptcp_subflow_ctx(sk);

 	if (!ctx)
 		return;
@@ -458,9 +459,9 @@ static void subflow_ulp_clone(const struct
request_sock *req,
 			      struct sock *newsk,
 			      const gfp_t priority)
 {
-	struct subflow_request_sock *subflow_req =3D subflow_rsk(req);
-	struct subflow_context *old_ctx =3D subflow_ctx(newsk);
-	struct subflow_context *new_ctx;
+	struct mptcp_subflow_request_sock *subflow_req =3D mptcp_subflow_rsk(req);
+	struct mptcp_subflow_context *old_ctx =3D mptcp_subflow_ctx(newsk);
+	struct mptcp_subflow_context *new_ctx;

 	/* newsk->sk_socket is NULL at this point */
 	new_ctx =3D subflow_create_ctx(newsk, NULL, priority);
@@ -500,7 +501,7 @@ static struct tcp_ulp_ops subflow_ulp_ops
__read_mostly =3D {

 static int subflow_ops_init(struct request_sock_ops *subflow_ops)
 {
-	subflow_ops->obj_size =3D sizeof(struct subflow_request_sock);
+	subflow_ops->obj_size =3D sizeof(struct mptcp_subflow_request_sock);
 	subflow_ops->slab_name =3D "request_sock_subflow";

 	subflow_ops->slab =3D kmem_cache_create(subflow_ops->slab_name,
@@ -516,7 +517,7 @@ static int subflow_ops_init(struct request_sock_ops
*subflow_ops)
 	return 0;
 }

-void subflow_init(void)
+void mptcp_subflow_init(void)
 {
 	subflow_request_sock_ops =3D tcp_request_sock_ops;
 	if (subflow_ops_init(&subflow_request_sock_ops) !=3D 0)
diff --git a/net/mptcp/token.c b/net/mptcp/token.c
index b3069ef16555..a0d8f6e323b2 100644
--- a/net/mptcp/token.c
+++ b/net/mptcp/token.c
@@ -51,7 +51,7 @@ static int token_used __read_mostly;
  */
 int mptcp_token_new_request(struct request_sock *req)
 {
-	struct subflow_request_sock *subflow_req =3D subflow_rsk(req);
+	struct mptcp_subflow_request_sock *subflow_req =3D mptcp_subflow_rsk(req);
 	int err;

 	while (1) {
@@ -96,7 +96,7 @@ int mptcp_token_new_request(struct request_sock *req)
  */
 int mptcp_token_new_connect(struct sock *sk)
 {
-	struct subflow_context *subflow =3D subflow_ctx(sk);
+	struct mptcp_subflow_context *subflow =3D mptcp_subflow_ctx(sk);
 	struct sock *mptcp_sock =3D subflow->conn;
 	int err;

@@ -154,7 +154,7 @@ int mptcp_token_new_accept(u32 token)
  */
 void mptcp_token_update_accept(struct sock *sk, struct sock *conn)
 {
-	struct subflow_context *subflow =3D subflow_ctx(sk);
+	struct mptcp_subflow_context *subflow =3D mptcp_subflow_ctx(sk);
 	void __rcu **slot;

 	spin_lock_bh(&token_tree_lock);


It is quite big but I only renamed functions and structures and
sometimes moved functions to keep the reversed Xmas tree.

Ideally, I would like to push this before applying other patches because
it is quite big and the rebase is already made on my side :) (I can
still work with a copy of the tree but would be easier to push this :) )

Cheers,
Matt
-- =

Matthieu Baerts | R&D Engineer
matthieu.baerts(a)tessares.net
Tessares SA | Hybrid Access Solutions
www.tessares.net
1 Avenue Jean Monnet, 1348 Louvain-la-Neuve, Belgium
--===============1823674222041176011==--
