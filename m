Received: from sender11-of-o51.zoho.eu (sender11-of-o51.zoho.eu [31.186.226.237])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDABD20E0
	for <mptcp@lists.linux.dev>; Sun, 22 May 2022 18:40:29 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; t=1653244816; cv=none; 
	d=zohomail.eu; s=zohoarc; 
	b=DuSh6gzieMtebIXnyy38/5tRTTpXxdg6rPyIak04k+PTmpEjovtnRTL/VKxDP7qKSRnhsxkllrmTpOHMpkzk/ftRX45lKbjTg2+3uGeCXppd9QCpvwKgcdMkiCfPd9bIuCkpue/AAjMk7Chc858IuHE0ELUOWfCo/HfN66l2U7E=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.eu; s=zohoarc; 
	t=1653244816; h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:MIME-Version:Message-ID:Subject:To; 
	bh=Nrg7+alYBNoEhkh31zL5DMj30C3mmIJCM+4hvIHTS+Y=; 
	b=b9gQRlUFoBC1FCa9H8ZXJC5Uol+NRk4k5Pdu7SraoB/nxdU6xBHU6k0R9dMIK+gKE3cyIQtYMyeuA2oJrVBih64ErOM2mfBfCgrXoa90+/8t74J5yF2NtXJQC45hdXOHrL4+mmDtMe4A4JlXx840Eq+D/XjpP6wBM+I2SVzUlvY=
ARC-Authentication-Results: i=1; mx.zohomail.eu;
	dkim=pass  header.i=shytyi.net;
	spf=pass  smtp.mailfrom=dmytro@shytyi.net;
	dmarc=pass header.from=<dmytro@shytyi.net>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1653244816;
	s=hs; d=shytyi.net; i=dmytro@shytyi.net;
	h=From:From:To:To:Cc:Cc:Message-ID:Subject:Subject:Date:Date:MIME-Version:Content-Transfer-Encoding:Content-Type:Message-Id:Reply-To;
	bh=Nrg7+alYBNoEhkh31zL5DMj30C3mmIJCM+4hvIHTS+Y=;
	b=VO6N6UtxWxNmk3yGgeu0VXccSnWkN1hO2K7VHa0BR7TFVZCiqjCvyxEHfcd/EqLA
	zQuVM7wK/JuINoH7e/3TJRbsdb4CcoqRcA1VW6cybRfcSU9iYgB2EWL0gpVh9JqL8hh
	SVWEcb10S//QdR3XCGyVcPJhYYZVzizsjn5Sjn7g=
Received: from doris.lan (vps-f3afed4e.vps.ovh.net [198.244.151.99]) by mx.zoho.eu
	with SMTPS id 1653244813739133.3191784485772; Sun, 22 May 2022 20:40:13 +0200 (CEST)
From: Dmytro SHYTYI <dmytro@shytyi.net>
To: mptcp@lists.linux.dev
Cc: Dmytro SHYTYI <dmytro@shytyi.net>
Message-ID: <20220522183921.103526-1-dmytro@shytyi.net>
Subject: [RFC PATCH mptcp-next v3] mptcp: Fast Open Mechanism
Date: Sun, 22 May 2022 19:39:21 +0100
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-ZohoMailClient: External
Content-Type: text/plain; charset=utf8

This set of patches will bring "Fast Open" Option support to MPTCP.
The aim of Fast Open Mechanism is to eliminate one round trip
time from a TCP conversation by allowing data to be included as
part of the SYN segment that initiates the connection.

IETF RFC 8684: Appendix B.  TCP Fast Open and MPTCP.

[PATCH v3] includes "client-server" partial support for :
1. MPTCP cookie request from client.
2. MPTCP cookie offering from server.
3. MPTCP SYN+DATA+COOKIE from client.
4. subsequent write + read on the opened socket.

This patch is Work In Progress transitional draft. There was a pause
in code development that was unpaused recently. Now this code is based
on the top of mptcp-next branch. The option below will be modified in
future inelligently, depending on socket type (TCP||MPTCP):
*tcp_options ^=3D OPTION_TS
You also might notice some of commented pieces of the upstream code -
that (is probably not good) and was done to observe an
expected behavior of MPTCP Fast Open mechanism. Any comments how
to achive the same behavior of MPTCP_FO without commenting the related
parts of the code are welcome.

Signed-off-by: Dmytro SHYTYI <dmytro@shytyi.net>
---
 include/net/mptcp.h     |  2 +-
 net/ipv4/tcp_fastopen.c |  4 +++
 net/ipv4/tcp_input.c    |  7 ++---
 net/ipv4/tcp_output.c   |  3 +--
 net/mptcp/options.c     |  8 ++++--
 net/mptcp/protocol.c    | 59 ++++++++++++++++++++++++++++++++++++++---
 net/mptcp/sockopt.c     | 41 ++++++++++++++++++++++++++++
 net/mptcp/subflow.c     |  9 ++++---
 8 files changed, 118 insertions(+), 15 deletions(-)

diff --git a/include/net/mptcp.h b/include/net/mptcp.h
index 6456ea26e4c7..692197187af8 100644
--- a/include/net/mptcp.h
+++ b/include/net/mptcp.h
@@ -139,7 +139,7 @@ void mptcp_space(const struct sock *ssk, int *space, in=
t *full_space);
 bool mptcp_syn_options(struct sock *sk, const struct sk_buff *skb,
 =09=09       unsigned int *size, struct mptcp_out_options *opts);
 bool mptcp_synack_options(const struct request_sock *req, unsigned int *si=
ze,
-=09=09=09  struct mptcp_out_options *opts);
+=09=09=09  struct mptcp_out_options *opts, u16 *tcp_options);
 bool mptcp_established_options(struct sock *sk, struct sk_buff *skb,
 =09=09=09       unsigned int *size, unsigned int remaining,
 =09=09=09       struct mptcp_out_options *opts);
diff --git a/net/ipv4/tcp_fastopen.c b/net/ipv4/tcp_fastopen.c
index fdbcf2a6d08e..f5f189e4d15a 100644
--- a/net/ipv4/tcp_fastopen.c
+++ b/net/ipv4/tcp_fastopen.c
@@ -346,8 +346,10 @@ struct sock *tcp_try_fastopen(struct sock *sk, struct =
sk_buff *skb,
 =09=09=09      struct tcp_fastopen_cookie *foc,
 =09=09=09      const struct dst_entry *dst)
 {
+=09/*
 =09bool syn_data =3D TCP_SKB_CB(skb)->end_seq !=3D TCP_SKB_CB(skb)->seq + =
1;
 =09int tcp_fastopen =3D sock_net(sk)->ipv4.sysctl_tcp_fastopen;
+=09*/
 =09struct tcp_fastopen_cookie valid_foc =3D { .len =3D -1 };
 =09struct sock *child;
 =09int ret =3D 0;
@@ -355,12 +357,14 @@ struct sock *tcp_try_fastopen(struct sock *sk, struct=
 sk_buff *skb,
 =09if (foc->len =3D=3D 0) /* Client requests a cookie */
 =09=09NET_INC_STATS(sock_net(sk), LINUX_MIB_TCPFASTOPENCOOKIEREQD);
=20
+=09/*
 =09if (!((tcp_fastopen & TFO_SERVER_ENABLE) &&
 =09      (syn_data || foc->len >=3D 0) &&
 =09      tcp_fastopen_queue_check(sk))) {
 =09=09foc->len =3D -1;
 =09=09return NULL;
 =09}
+=09*/
=20
 =09if (tcp_fastopen_no_cookie(sk, dst, TFO_SERVER_COOKIE_NOT_REQD))
 =09=09goto fastopen;
diff --git a/net/ipv4/tcp_input.c b/net/ipv4/tcp_input.c
index 3231af73e430..38119b96171d 100644
--- a/net/ipv4/tcp_input.c
+++ b/net/ipv4/tcp_input.c
@@ -6273,9 +6273,10 @@ static int tcp_rcv_synsent_state_process(struct sock=
 *sk, struct sk_buff *skb,
 =09=09}
 =09=09if (fastopen_fail)
 =09=09=09return -1;
-=09=09if (sk->sk_write_pending ||
-=09=09    icsk->icsk_accept_queue.rskq_defer_accept ||
-=09=09    inet_csk_in_pingpong_mode(sk)) {
+
+=09=09if (!sk_is_mptcp(sk) && (sk->sk_write_pending ||
+=09=09     icsk->icsk_accept_queue.rskq_defer_accept ||
+=09=09     inet_csk_in_pingpong_mode(sk))) {
 =09=09=09/* Save one ACK. Data will be ready after
 =09=09=09 * several ticks, if write_pending is set.
 =09=09=09 *
diff --git a/net/ipv4/tcp_output.c b/net/ipv4/tcp_output.c
index b4b2284ed4a2..864517e63bdf 100644
--- a/net/ipv4/tcp_output.c
+++ b/net/ipv4/tcp_output.c
@@ -747,7 +747,7 @@ static void mptcp_set_option_cond(const struct request_=
sock *req,
 =09if (rsk_is_mptcp(req)) {
 =09=09unsigned int size;
=20
-=09=09if (mptcp_synack_options(req, &size, &opts->mptcp)) {
+=09=09if (mptcp_synack_options(req, &size, &opts->mptcp, &opts->options)) =
{
 =09=09=09if (*remaining >=3D size) {
 =09=09=09=09opts->options |=3D OPTION_MPTCP;
 =09=09=09=09*remaining -=3D size;
@@ -822,7 +822,6 @@ static unsigned int tcp_syn_options(struct sock *sk, st=
ruct sk_buff *skb,
 =09=09=09tp->syn_fastopen_exp =3D fastopen->cookie.exp ? 1 : 0;
 =09=09}
 =09}
-
 =09smc_set_option(tp, opts, &remaining);
=20
 =09if (sk_is_mptcp(sk)) {
diff --git a/net/mptcp/options.c b/net/mptcp/options.c
index be3b918a6d15..ebcb9c04ead9 100644
--- a/net/mptcp/options.c
+++ b/net/mptcp/options.c
@@ -887,16 +887,20 @@ bool mptcp_established_options(struct sock *sk, struc=
t sk_buff *skb,
 }
=20
 bool mptcp_synack_options(const struct request_sock *req, unsigned int *si=
ze,
-=09=09=09  struct mptcp_out_options *opts)
+=09=09=09  struct mptcp_out_options *opts, u16 *tcp_options)
 {
 =09struct mptcp_subflow_request_sock *subflow_req =3D mptcp_subflow_rsk(re=
q);
+#define OPTION_TS               BIT(1)
+
+
+        *tcp_options ^=3D OPTION_TS;
=20
 =09if (subflow_req->mp_capable) {
 =09=09opts->suboptions =3D OPTION_MPTCP_MPC_SYNACK;
 =09=09opts->sndr_key =3D subflow_req->local_key;
 =09=09opts->csum_reqd =3D subflow_req->csum_reqd;
 =09=09opts->allow_join_id0 =3D subflow_req->allow_join_id0;
-=09=09*size =3D TCPOLEN_MPTCP_MPC_SYNACK;
+=09=09*size =3D TCPOLEN_MPTCP_MPC_SYNACK  - TCPOLEN_TSTAMP_ALIGNED + TCPOL=
EN_SACKPERM_ALIGNED;
 =09=09pr_debug("subflow_req=3D%p, local_key=3D%llu",
 =09=09=09 subflow_req, subflow_req->local_key);
 =09=09return true;
diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index d6aef4b13b8a..6649088baae5 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -54,6 +54,8 @@ static struct percpu_counter mptcp_sockets_allocated ____=
cacheline_aligned_in_sm
=20
 static void __mptcp_destroy_sock(struct sock *sk);
 static void __mptcp_check_send_data_fin(struct sock *sk);
+static int mptcp_stream_connect(struct socket *sock, struct sockaddr *uadd=
r,
+=09=09=09=09int addr_len, int flags);
=20
 DEFINE_PER_CPU(struct mptcp_delegated_action, mptcp_delegated_actions);
 static struct net_device mptcp_napi_dev;
@@ -1673,6 +1675,53 @@ static void __mptcp_subflow_push_pending(struct sock=
 *sk, struct sock *ssk)
 =09}
 }
=20
+static int mptcp_sendmsg_fastopen(struct sock *sk, struct msghdr *msg,
+=09=09=09=09  size_t len, struct mptcp_sock *msk, size_t copied)
+{
+=09const struct iphdr *iph;
+=09struct ubuf_info *uarg;
+=09struct sockaddr *uaddr;
+=09struct sk_buff *skb;
+=09struct tcp_sock *tp;
+=09struct socket *ssk;
+=09int ret;
+
+=09ssk =3D __mptcp_nmpc_socket(msk);
+=09if (unlikely(!ssk))
+=09=09goto out_EFAULT;
+=09skb =3D tcp_stream_alloc_skb(ssk->sk, 0, ssk->sk->sk_allocation, true);
+=09if (unlikely(!skb))
+=09=09goto out_EFAULT;
+=09iph =3D ip_hdr(skb);
+=09if (unlikely(!iph))
+=09=09goto out_EFAULT;
+=09uarg =3D msg_zerocopy_realloc(sk, len, skb_zcopy(skb));
+=09if (unlikely(!uarg))
+=09=09goto out_EFAULT;
+=09uaddr =3D msg->msg_name;
+
+=09tp =3D tcp_sk(ssk->sk);
+=09if (unlikely(!tp))
+=09=09goto out_EFAULT;
+=09if (!tp->fastopen_req)
+=09=09tp->fastopen_req =3D kzalloc(sizeof(*tp->fastopen_req), ssk->sk->sk_=
allocation);
+
+=09if (unlikely(!tp->fastopen_req))
+=09=09goto out_EFAULT;
+=09tp->fastopen_req->data =3D msg;
+=09tp->fastopen_req->size =3D len;
+=09tp->fastopen_req->uarg =3D uarg;
+
+=09/* requests a cookie */
+=09ret =3D mptcp_stream_connect(sk->sk_socket, uaddr,
+=09=09=09=09   msg->msg_namelen, msg->msg_flags);
+
+=09return ret;
+out_EFAULT:
+=09ret =3D -EFAULT;
+=09return ret;
+}
+
 static void mptcp_set_nospace(struct sock *sk)
 {
 =09/* enable autotune */
@@ -1690,9 +1739,9 @@ static int mptcp_sendmsg(struct sock *sk, struct msgh=
dr *msg, size_t len)
 =09int ret =3D 0;
 =09long timeo;
=20
-=09/* we don't support FASTOPEN yet */
+=09/* we don't fully support FASTOPEN yet */
 =09if (msg->msg_flags & MSG_FASTOPEN)
-=09=09return -EOPNOTSUPP;
+=09=09ret =3D mptcp_sendmsg_fastopen(sk, msg, len, msk, copied);
=20
 =09/* silently ignore everything else */
 =09msg->msg_flags &=3D MSG_MORE | MSG_DONTWAIT | MSG_NOSIGNAL;
@@ -2558,10 +2607,10 @@ static void mptcp_worker(struct work_struct *work)
=20
 =09if (test_and_clear_bit(MPTCP_WORK_CLOSE_SUBFLOW, &msk->flags))
 =09=09__mptcp_close_subflow(msk);
-
+/*
 =09if (test_and_clear_bit(MPTCP_WORK_RTX, &msk->flags))
 =09=09__mptcp_retrans(sk);
-
+*/
 =09mptcp_mp_fail_no_response(msk);
=20
 unlock:
@@ -2681,6 +2730,8 @@ void mptcp_subflow_shutdown(struct sock *sk, struct s=
ock *ssk, int how)
 =09case TCP_SYN_SENT:
 =09=09tcp_disconnect(ssk, O_NONBLOCK);
 =09=09break;
+=09case TCP_ESTABLISHED:
+=09=09break;
 =09default:
 =09=09if (__mptcp_check_fallback(mptcp_sk(sk))) {
 =09=09=09pr_debug("Fallback");
diff --git a/net/mptcp/sockopt.c b/net/mptcp/sockopt.c
index 423d3826ca1e..e1ae1ef224cf 100644
--- a/net/mptcp/sockopt.c
+++ b/net/mptcp/sockopt.c
@@ -560,6 +560,8 @@ static bool mptcp_supported_sockopt(int level, int optn=
ame)
 =09=09case TCP_TX_DELAY:
 =09=09case TCP_INQ:
 =09=09=09return true;
+=09=09case TCP_FASTOPEN:
+=09=09=09return true;
 =09=09}
=20
 =09=09/* TCP_MD5SIG, TCP_MD5SIG_EXT are not supported, MD5 is not compatib=
le with MPTCP */
@@ -768,6 +770,43 @@ static int mptcp_setsockopt_sol_tcp_defer(struct mptcp=
_sock *msk, sockptr_t optv
 =09return tcp_setsockopt(listener->sk, SOL_TCP, TCP_DEFER_ACCEPT, optval, =
optlen);
 }
=20
+static int mptcp_setsockopt_sol_tcp_fastopen(struct mptcp_sock *msk, sockp=
tr_t optval,
+=09=09=09=09=09     unsigned int optlen)
+{
+=09struct mptcp_subflow_context *subflow;
+=09struct sock *sk =3D (struct sock *)msk;
+=09struct net *net =3D sock_net(sk);
+=09int val;
+=09int ret;
+
+=09ret =3D 0;
+
+=09if (copy_from_sockptr(&val, optval, sizeof(val)))
+=09=09return -EFAULT;
+
+=09lock_sock(sk);
+
+=09mptcp_for_each_subflow(msk, subflow) {
+=09=09struct sock *ssk =3D mptcp_subflow_tcp_sock(subflow);
+
+=09=09lock_sock(ssk);
+
+=09=09if (val >=3D 0 && ((1 << sk->sk_state) & (TCPF_CLOSE |
+=09=09    TCPF_LISTEN))) {
+=09=09=09tcp_fastopen_init_key_once(net);
+=09=09=09fastopen_queue_tune(sk, val);
+=09=09} else {
+=09=09=09ret =3D -EINVAL;
+=09=09}
+
+=09=09release_sock(ssk);
+=09}
+
+=09release_sock(sk);
+
+=09return ret;
+}
+
 static int mptcp_setsockopt_sol_tcp(struct mptcp_sock *msk, int optname,
 =09=09=09=09    sockptr_t optval, unsigned int optlen)
 {
@@ -796,6 +835,8 @@ static int mptcp_setsockopt_sol_tcp(struct mptcp_sock *=
msk, int optname,
 =09=09return mptcp_setsockopt_sol_tcp_nodelay(msk, optval, optlen);
 =09case TCP_DEFER_ACCEPT:
 =09=09return mptcp_setsockopt_sol_tcp_defer(msk, optval, optlen);
+=09case TCP_FASTOPEN:
+=09=09return mptcp_setsockopt_sol_tcp_fastopen(msk, optval, optlen);
 =09}
=20
 =09return -EOPNOTSUPP;
diff --git a/net/mptcp/subflow.c b/net/mptcp/subflow.c
index 8841e8cd9ad8..f732e41e12df 100644
--- a/net/mptcp/subflow.c
+++ b/net/mptcp/subflow.c
@@ -1002,16 +1002,17 @@ static enum mapping_status get_mapping_status(struc=
t sock *ssk,
 =09=09=09sk_eat_skb(ssk, skb);
 =09=09=09return MAPPING_EMPTY;
 =09=09}
-
+/*
 =09=09if (!subflow->map_valid)
 =09=09=09return MAPPING_INVALID;
-
+*/
 =09=09goto validate_seq;
 =09}
=20
 =09trace_get_mapping_status(mpext);
=20
 =09data_len =3D mpext->data_len;
+
 =09if (data_len =3D=3D 0) {
 =09=09pr_debug("infinite mapping received");
 =09=09MPTCP_INC_STATS(sock_net(ssk), MPTCP_MIB_INFINITEMAPRX);
@@ -1075,6 +1076,7 @@ static enum mapping_status get_mapping_status(struct =
sock *ssk,
 =09=09/* If this skb data are fully covered by the current mapping,
 =09=09 * the new map would need caching, which is not supported
 =09=09 */
+
 =09=09if (skb_is_fully_mapped(ssk, skb)) {
 =09=09=09MPTCP_INC_STATS(sock_net(ssk), MPTCP_MIB_DSSNOMATCH);
 =09=09=09return MAPPING_INVALID;
@@ -1107,11 +1109,12 @@ static enum mapping_status get_mapping_status(struc=
t sock *ssk,
 =09/* we revalidate valid mapping on new skb, because we must ensure
 =09 * the current skb is completely covered by the available mapping
 =09 */
+=09/*
 =09if (!validate_mapping(ssk, skb)) {
 =09=09MPTCP_INC_STATS(sock_net(ssk), MPTCP_MIB_DSSTCPMISMATCH);
 =09=09return MAPPING_INVALID;
 =09}
-
+=09*/
 =09skb_ext_del(skb, SKB_EXT_MPTCP);
=20
 validate_csum:
--=20
2.25.1


