Content-Type: multipart/mixed; boundary="===============2092615056402008681=="
MIME-Version: 1.0
From: cpaasch at apple.com
To: mptcp at lists.01.org
Subject: Re: [MPTCP] [RFC PATCH v4 08/17] mptcp: Create SUBFLOW socket for
 incoming connections
Date: Wed, 12 Dec 2018 13:59:22 -0800
Message-ID: <20181212215922.GW41383@MacBook-Pro-19.local>
In-Reply-To: 1544651156.12006.5.camel@intel.com
X-Status: 
X-Keywords:                  
X-UID: 898

--===============2092615056402008681==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On 12/12/18 - 21:45:58, Krystad, Peter wrote:
> On Wed, 2018-12-12 at 13:07 -0800, cpaasch(a)apple.com wrote:
> > On 12/12/18 - 19:25:09, Krystad, Peter wrote:
> > > On Tue, 2018-12-11 at 22:08 -0800, Christoph Paasch wrote:
> > > > Hello,
> > > > =

> > > > On 30/11/18 - 12:11:03, Mat Martineau wrote:
> > > > > From: Peter Krystad <peter.krystad(a)intel.com>
> > > > > =

> > > > > Add subflow_request_sock type that extends tcp_request_sock
> > > > > and add an is_mptcp flag to tcp_request_sock distinguish them.
> > > > > =

> > > > > Override the listen() and accept() methods of the MPTCP
> > > > > socket proto_ops so they may act on the subflow socket.
> > > > > =

> > > > > Override the conn_request() and syn_recv_sock() handlers
> > > > > in the inet_connection_sock to handle incoming MPTCP
> > > > > SYNs and the ACK to the response SYN.
> > > > =

> > > > I'm having quite a hard time to understand how it works. Can you gi=
ve some
> > > > more details?
> > > > =

> > > > Because, the difficult part about MPTCP is that incoming subflows a=
re no
> > > > more matching on a listener but rather on a "established" MPTCP-soc=
ket based
> > > > on the token that is present in the TCP-options.
> > > > And, I don't see how this is being taken care of here.
> > > > =

> > > > Is the expectation that the app will call "listen()" and "accept()"=
 on the
> > > > MPTCP-socket ?
> > > =

> > > Yes, the application will call listen() and accept() with the socket =
it
> > > got when it called socket(..., IPPROTO_MPTCP), the normal call sequen=
ce
> > > for a server application is preserved. In the kernel this socket is
> > > represented by struct mptcp_sock.
> > > =

> > > Key generation and token-tracking data structure is added in the next
> > > patch, #9.
> > > =

> > > How this works is that underneath the MPTCP socket is a subflow socket
> > > that is a struct subflow_sock. This is an extended tcp_sock structure
> > > with subflow-specific fields. mptcp_stream_listen() and
> > > mptcp_stream_accept() routines in this patch call inet_listen() and
> > > inet_accept() on the subflow socket just like it were a listening TCP
> > > socket.
> > > =

> > > When an initial MPTCP connection completes on the subflow_socket
> > > mptcp_accept() creates a new mptcp_sock, attaches the child tcp_sock
> > > (returned by kernel_accept()) to it and this new MPTCP socket is
> > > returned to the application. In patch #9 you can see the token and new
> > > mptcp_sock are stored in the token tree, so we can find it when
> > > additional subflows are created.
> > =

> > When these additional subflows are coming in, normally these SYNs are
> > matching on the default listener. But, they should be matching on the
> > mptcp-socket that belongs to the token inside the mp_join.
> > =

> > Otherwise said, my question is: where is rx_opt.mp_join set to 1 ? I ca=
n't
> > seem to find it.
> > =

> Join is not supported in this patchset, see 0/0 patch message. But you
> are right additional SYNs will match on the listener subflow socket and
> the MPTCP socket will be located by token-tree lookup.
> =

> I have some in-progress commits that implement this but it's not
> completely working yet.

Ok, that's what I was looking for. What's your plan on how to do that?
Because, it probably involves some changes in tcp_v4_rcv's fast-path.


Christoph

> =

> Peter.
> =

> > Christoph
> > =

> > > =

> > > Let me know if you have more questions.
> > > =

> > > Peter.
> > > =

> > > =

> > > > Thanks,
> > > > Christoph
> > > > =

> > > > > =

> > > > > Add handling in tcp_output.c to add MP_CAPABLE to an outgoing
> > > > > SYN-ACK response for a subflow_request_sock.
> > > > > =

> > > > > Signed-off-by: Peter Krystad <peter.krystad(a)intel.com>
> > > > > ---
> > > > >  include/linux/tcp.h   |   1 +
> > > > >  include/net/mptcp.h   |  26 ++++++++++
> > > > >  include/net/tcp.h     |   1 +
> > > > >  net/ipv4/tcp_input.c  |   1 +
> > > > >  net/ipv4/tcp_output.c |  21 +++++++-
> > > > >  net/mptcp/options.c   |  15 ++++++
> > > > >  net/mptcp/protocol.c  | 102 ++++++++++++++++++++++++++++++++++---
> > > > >  net/mptcp/subflow.c   | 115 ++++++++++++++++++++++++++++++++++++=
++++--
> > > > >  8 files changed, 271 insertions(+), 11 deletions(-)
> > > > > =

> > > > > diff --git a/include/linux/tcp.h b/include/linux/tcp.h
> > > > > index 2622817ecd6b..b54ab3b5546a 100644
> > > > > --- a/include/linux/tcp.h
> > > > > +++ b/include/linux/tcp.h
> > > > > @@ -148,6 +148,7 @@ struct tcp_request_sock {
> > > > >  						  * FastOpen it's the seq#
> > > > >  						  * after data-in-SYN.
> > > > >  						  */
> > > > > +	bool				is_mptcp;
> > > > >  };
> > > > >  =

> > > > >  static inline struct tcp_request_sock *tcp_rsk(const struct requ=
est_sock *req)
> > > > > diff --git a/include/net/mptcp.h b/include/net/mptcp.h
> > > > > index a5c2baeb688f..ced33f1c529e 100644
> > > > > --- a/include/net/mptcp.h
> > > > > +++ b/include/net/mptcp.h
> > > > > @@ -69,6 +69,23 @@ static inline struct subflow_sock *subflow_sk(=
const struct sock *sk)
> > > > >  	return (struct subflow_sock *)sk;
> > > > >  }
> > > > >  =

> > > > > +struct subflow_request_sock {
> > > > > +	struct	tcp_request_sock sk;
> > > > > +	u8	mp_capable : 1,
> > > > > +		mp_join : 1,
> > > > > +		checksum : 1,
> > > > > +		backup : 1,
> > > > > +		version : 4;
> > > > > +	u64	local_key;
> > > > > +	u64	remote_key;
> > > > > +};
> > > > > +
> > > > > +static inline
> > > > > +struct subflow_request_sock *subflow_rsk(const struct request_so=
ck *rsk)
> > > > > +{
> > > > > +	return (struct subflow_request_sock *)rsk;
> > > > > +}
> > > > > +
> > > > >  #ifdef CONFIG_MPTCP
> > > > >  =

> > > > >  void mptcp_parse_option(const unsigned char *ptr, int opsize,
> > > > > @@ -77,6 +94,8 @@ unsigned int mptcp_syn_options(struct sock *sk,=
 u64 *local_key);
> > > > >  void mptcp_rcv_synsent(struct sock *sk);
> > > > >  unsigned int mptcp_established_options(struct sock *sk, u64 *loc=
al_key,
> > > > >  				       u64 *remote_key);
> > > > > +unsigned int mptcp_synack_options(struct request_sock *req,
> > > > > +				  u64 *local_key, u64 *remote_key);
> > > > >  =

> > > > >  void mptcp_finish_connect(struct sock *sk, int mp_capable);
> > > > >  =

> > > > > @@ -104,6 +123,13 @@ static inline void mptcp_rcv_synsent(struct =
sock *sk)
> > > > >  {
> > > > >  }
> > > > >  =

> > > > > +static inline unsigned int mptcp_synack_options(struct request_s=
ock *sk,
> > > > > +						u64 *local_key,
> > > > > +						u64 *remote_key)
> > > > > +{
> > > > > +	return 0;
> > > > > +}
> > > > > +
> > > > >  static inline unsigned int mptcp_established_options(struct sock=
 *sk,
> > > > >  						     u64 *local_key,
> > > > >  						     u64 *remote_key)
> > > > > diff --git a/include/net/tcp.h b/include/net/tcp.h
> > > > > index 254cf82e2ec6..1fc6362fa778 100644
> > > > > --- a/include/net/tcp.h
> > > > > +++ b/include/net/tcp.h
> > > > > @@ -216,6 +216,7 @@ void tcp_time_wait(struct sock *sk, int state=
, int timeo);
> > > > >  #define TCPOLEN_MSS_ALIGNED		4
> > > > >  #define TCPOLEN_EXP_SMC_BASE_ALIGNED	8
> > > > >  #define TCPOLEN_MPTCP_MPC_SYN		12
> > > > > +#define TCPOLEN_MPTCP_MPC_SYNACK	20
> > > > >  #define TCPOLEN_MPTCP_MPC_ACK		20
> > > > >  =

> > > > >  /* Flags in tp->nonagle */
> > > > > diff --git a/net/ipv4/tcp_input.c b/net/ipv4/tcp_input.c
> > > > > index eda515b141fb..00f7a3d88d66 100644
> > > > > --- a/net/ipv4/tcp_input.c
> > > > > +++ b/net/ipv4/tcp_input.c
> > > > > @@ -6445,6 +6445,7 @@ int tcp_conn_request(struct request_sock_op=
s *rsk_ops,
> > > > >  =

> > > > >  	tcp_rsk(req)->af_specific =3D af_ops;
> > > > >  	tcp_rsk(req)->ts_off =3D 0;
> > > > > +	tcp_rsk(req)->is_mptcp =3D 0;
> > > > >  =

> > > > >  	tcp_clear_options(&tmp_opt);
> > > > >  	tmp_opt.mss_clamp =3D af_ops->mss_clamp;
> > > > > diff --git a/net/ipv4/tcp_output.c b/net/ipv4/tcp_output.c
> > > > > index 4f284ed879ba..6f723cdb5c8e 100644
> > > > > --- a/net/ipv4/tcp_output.c
> > > > > +++ b/net/ipv4/tcp_output.c
> > > > > @@ -416,6 +416,7 @@ static inline bool tcp_urg_mode(const struct =
tcp_sock *tp)
> > > > >  =

> > > > >  /* MPTCP option subtypes */
> > > > >  #define OPTION_MPTCP_MPC_SYN	(1 << 0)
> > > > > +#define OPTION_MPTCP_MPC_SYNACK	(1 << 1)
> > > > >  #define OPTION_MPTCP_MPC_ACK	(1 << 2)
> > > > >  =

> > > > >  struct tcp_out_options {
> > > > > @@ -439,12 +440,15 @@ static void mptcp_options_write(__be32 *ptr=
, struct tcp_out_options *opts)
> > > > >  		return;
> > > > >  =

> > > > >  	if ((OPTION_MPTCP_MPC_SYN |
> > > > > +	     OPTION_MPTCP_MPC_SYNACK |
> > > > >  	     OPTION_MPTCP_MPC_ACK) & opts->suboptions) {
> > > > >  		u8 len;
> > > > >  		__be64 key;
> > > > >  =

> > > > >  		if (OPTION_MPTCP_MPC_SYN & opts->suboptions)
> > > > >  			len =3D TCPOLEN_MPTCP_MPC_SYN;
> > > > > +		else if (OPTION_MPTCP_MPC_SYNACK & opts->suboptions)
> > > > > +			len =3D TCPOLEN_MPTCP_MPC_SYNACK;
> > > > >  		else
> > > > >  			len =3D TCPOLEN_MPTCP_MPC_ACK;
> > > > >  =

> > > > > @@ -455,7 +459,8 @@ static void mptcp_options_write(__be32 *ptr, =
struct tcp_out_options *opts)
> > > > >  		key =3D cpu_to_be64(opts->sndr_key);
> > > > >  		memcpy((u8 *) ptr, (u8 *) &key, 8);
> > > > >  		ptr +=3D 2;
> > > > > -		if (OPTION_MPTCP_MPC_ACK & opts->suboptions) {
> > > > > +		if ((OPTION_MPTCP_MPC_SYNACK |
> > > > > +		     OPTION_MPTCP_MPC_ACK) & opts->suboptions) {
> > > > >  			key =3D cpu_to_be64(opts->rcvr_key);
> > > > >  			memcpy((u8 *) ptr, (u8 *) &key, 8);
> > > > >  			ptr +=3D 2;
> > > > > @@ -762,6 +767,20 @@ static unsigned int tcp_synack_options(const=
 struct sock *sk,
> > > > >  			remaining -=3D need;
> > > > >  		}
> > > > >  	}
> > > > > +	if (tcp_rsk(req)->is_mptcp) {
> > > > > +		u64 local_key;
> > > > > +		u64 remote_key;
> > > > > +		if (mptcp_synack_options(req, &local_key, &remote_key)) {
> > > > > +			if (remaining >=3D TCPOLEN_MPTCP_MPC_SYNACK) {
> > > > > +				opts->options |=3D OPTION_MPTCP;
> > > > > +				opts->suboptions =3D OPTION_MPTCP_MPC_SYNACK;
> > > > > +				opts->sndr_key =3D local_key;
> > > > > +				opts->rcvr_key =3D remote_key;
> > > > > +				remaining -=3D TCPOLEN_MPTCP_MPC_SYNACK;
> > > > > +			}
> > > > > +		}
> > > > > +	}
> > > > > +
> > > > >  	smc_set_option_cond(tcp_sk(sk), ireq, opts, &remaining);
> > > > >  =

> > > > >  	return MAX_TCP_OPTION_SPACE - remaining;
> > > > > diff --git a/net/mptcp/options.c b/net/mptcp/options.c
> > > > > index b0616f520da0..266a9f7fed0d 100644
> > > > > --- a/net/mptcp/options.c
> > > > > +++ b/net/mptcp/options.c
> > > > > @@ -189,3 +189,18 @@ unsigned int mptcp_established_options(struc=
t sock *sk, u64 *local_key,
> > > > >  	}
> > > > >  	return 0;
> > > > >  }
> > > > > +
> > > > > +unsigned int mptcp_synack_options(struct request_sock *req, u64 =
*local_key,
> > > > > +				  u64 *remote_key)
> > > > > +{
> > > > > +	struct subflow_request_sock *subflow_req =3D subflow_rsk(req);
> > > > > +
> > > > > +	pr_debug("subflow_req=3D%p", subflow_req);
> > > > > +	if (subflow_req->mp_capable) {
> > > > > +		*local_key =3D subflow_req->local_key;
> > > > > +		*remote_key =3D subflow_req->remote_key;
> > > > > +		pr_debug("local_key=3D%llu", *local_key);
> > > > > +		pr_debug("remote_key=3D%llu", *remote_key);
> > > > > +	}
> > > > > +	return subflow_req->mp_capable;
> > > > > +}
> > > > > diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
> > > > > index 1a3412a742ea..9f802f69a528 100644
> > > > > --- a/net/mptcp/protocol.c
> > > > > +++ b/net/mptcp/protocol.c
> > > > > @@ -80,6 +80,45 @@ static void mptcp_close(struct sock *sk, long =
timeout)
> > > > >  	}
> > > > >  }
> > > > >  =

> > > > > +static struct sock *mptcp_accept(struct sock *sk, int flags, int=
 *err,
> > > > > +				 bool kern)
> > > > > +{
> > > > > +	struct mptcp_sock *msk =3D mptcp_sk(sk);
> > > > > +	struct socket *listener =3D msk->subflow;
> > > > > +	struct socket *new_sock;
> > > > > +	struct socket *mp;
> > > > > +	struct subflow_sock *subflow;
> > > > > +
> > > > > +	pr_debug("msk=3D%p, listener=3D%p", msk, listener->sk);
> > > > > +	*err =3D kernel_accept(listener, &new_sock, flags);
> > > > > +	if (*err < 0)
> > > > > +		return NULL;
> > > > > +
> > > > > +	subflow =3D subflow_sk(new_sock->sk);
> > > > > +	pr_debug("new_sock=3D%p", subflow);
> > > > > +
> > > > > +	*err =3D sock_create(PF_INET, SOCK_STREAM, IPPROTO_MPTCP, &mp);
> > > > > +	if (*err < 0) {
> > > > > +		kernel_sock_shutdown(new_sock, SHUT_RDWR);
> > > > > +		sock_release(new_sock);
> > > > > +		return NULL;
> > > > > +	}
> > > > > +
> > > > > +	msk =3D mptcp_sk(mp->sk);
> > > > > +	pr_debug("msk=3D%p", msk);
> > > > > +	subflow->conn =3D mp->sk;
> > > > > +
> > > > > +	if (subflow->mp_capable) {
> > > > > +		msk->remote_key =3D subflow->remote_key;
> > > > > +		msk->local_key =3D subflow->local_key;
> > > > > +		msk->connection_list =3D new_sock;
> > > > > +	} else {
> > > > > +		msk->subflow =3D new_sock;
> > > > > +	}
> > > > > +
> > > > > +	return mp->sk;
> > > > > +}
> > > > > +
> > > > >  static int mptcp_get_port(struct sock *sk, unsigned short snum)
> > > > >  {
> > > > >  	struct mptcp_sock *msk =3D mptcp_sk(sk);
> > > > > @@ -129,11 +168,16 @@ static int subflow_create(struct sock *sock)
> > > > >  int mptcp_stream_bind(struct socket *sock, struct sockaddr *uadd=
r, int addr_len)
> > > > >  {
> > > > >  	struct mptcp_sock *msk =3D mptcp_sk(sock->sk);
> > > > > -	struct socket *subflow =3D msk->subflow;
> > > > > +	int err;
> > > > >  =

> > > > > -	pr_debug("msk=3D%p, subflow=3D%p", msk, subflow->sk);
> > > > > +	pr_debug("msk=3D%p", msk);
> > > > >  =

> > > > > -	return inet_bind(subflow, uaddr, addr_len);
> > > > > +	if (msk->subflow =3D=3D NULL) {
> > > > > +		err =3D subflow_create(sock->sk);
> > > > > +		if (err)
> > > > > +			return err;
> > > > > +	}
> > > > > +	return inet_bind(msk->subflow, uaddr, addr_len);
> > > > >  }
> > > > >  =

> > > > >  int mptcp_stream_connect(struct socket *sock, struct sockaddr *u=
addr,
> > > > > @@ -153,12 +197,56 @@ int mptcp_stream_connect(struct socket *soc=
k, struct sockaddr *uaddr,
> > > > >  	return inet_stream_connect(msk->subflow, uaddr, addr_len, flags=
);
> > > > >  }
> > > > >  =

> > > > > +int mptcp_stream_getname(struct socket *sock, struct sockaddr *u=
addr, int peer)
> > > > > +{
> > > > > +	struct mptcp_sock *msk =3D mptcp_sk(sock->sk);
> > > > > +	struct socket *subflow;
> > > > > +	int err =3D -EPERM;
> > > > > +
> > > > > +	if (msk->connection_list)
> > > > > +		subflow =3D msk->connection_list;
> > > > > +	else
> > > > > +		subflow =3D msk->subflow;
> > > > > +
> > > > > +	err =3D inet_getname(subflow, uaddr, peer);
> > > > > +
> > > > > +	return err;
> > > > > +}
> > > > > +
> > > > > +int mptcp_stream_listen(struct socket *sock, int backlog)
> > > > > +{
> > > > > +	struct mptcp_sock *msk =3D mptcp_sk(sock->sk);
> > > > > +	int err;
> > > > > +
> > > > > +	pr_debug("msk=3D%p", msk);
> > > > > +
> > > > > +	if (msk->subflow =3D=3D NULL) {
> > > > > +		err =3D subflow_create(sock->sk);
> > > > > +		if (err)
> > > > > +			return err;
> > > > > +	}
> > > > > +	return inet_listen(msk->subflow, backlog);
> > > > > +}
> > > > > +
> > > > > +int mptcp_stream_accept(struct socket *sock, struct socket *news=
ock, int flags,
> > > > > +			bool kern)
> > > > > +{
> > > > > +	struct mptcp_sock *msk =3D mptcp_sk(sock->sk);
> > > > > +
> > > > > +	pr_debug("msk=3D%p", msk);
> > > > > +
> > > > > +	if (msk->subflow =3D=3D NULL) {
> > > > > +		return -EINVAL;
> > > > > +	}
> > > > > +	return inet_accept(sock, newsock, flags, kern);
> > > > > +}
> > > > > +
> > > > >  static struct proto mptcp_prot =3D {
> > > > >  	.name		=3D "MPTCP",
> > > > >  	.owner		=3D THIS_MODULE,
> > > > >  	.init		=3D mptcp_init_sock,
> > > > >  	.close		=3D mptcp_close,
> > > > > -	.accept		=3D inet_csk_accept,
> > > > > +	.accept		=3D mptcp_accept,
> > > > >  	.shutdown	=3D tcp_shutdown,
> > > > >  	.sendmsg	=3D mptcp_sendmsg,
> > > > >  	.recvmsg	=3D mptcp_recvmsg,
> > > > > @@ -176,11 +264,11 @@ const struct proto_ops mptcp_stream_ops =3D=
 {
> > > > >  	.bind		   =3D mptcp_stream_bind,
> > > > >  	.connect	   =3D mptcp_stream_connect,
> > > > >  	.socketpair	   =3D sock_no_socketpair,
> > > > > -	.accept		   =3D inet_accept,
> > > > > -	.getname	   =3D inet_getname,
> > > > > +	.accept		   =3D mptcp_stream_accept,
> > > > > +	.getname	   =3D mptcp_stream_getname,
> > > > >  	.poll		   =3D tcp_poll,
> > > > >  	.ioctl		   =3D inet_ioctl,
> > > > > -	.listen		   =3D inet_listen,
> > > > > +	.listen		   =3D mptcp_stream_listen,
> > > > >  	.shutdown	   =3D inet_shutdown,
> > > > >  	.setsockopt	   =3D sock_common_setsockopt,
> > > > >  	.getsockopt	   =3D sock_common_getsockopt,
> > > > > diff --git a/net/mptcp/subflow.c b/net/mptcp/subflow.c
> > > > > index 5e5fdcb3175f..89fcc3b746eb 100644
> > > > > --- a/net/mptcp/subflow.c
> > > > > +++ b/net/mptcp/subflow.c
> > > > > @@ -53,6 +53,40 @@ static int subflow_recvmsg(struct sock *sk, st=
ruct msghdr *msg, size_t len,
> > > > >  	return tcp_recvmsg(sk, msg, len, nonblock, flags, addr_len);
> > > > >  }
> > > > >  =

> > > > > +static void subflow_v4_init_req(struct request_sock *req,
> > > > > +				const struct sock *sk_listener,
> > > > > +				struct sk_buff *skb)
> > > > > +{
> > > > > +	struct subflow_request_sock *subflow_req =3D subflow_rsk(req);
> > > > > +	struct subflow_sock *listener =3D subflow_sk(sk_listener);
> > > > > +	struct tcp_options_received rx_opt;
> > > > > +
> > > > > +	tcp_rsk(req)->is_mptcp =3D 1;
> > > > > +	pr_debug("subflow_req=3D%p, listener=3D%p", subflow_req, listen=
er);
> > > > > +
> > > > > +	tcp_request_sock_ipv4_ops.init_req(req, sk_listener, skb);
> > > > > +
> > > > > +	rx_opt.mptcp.flags =3D 0;
> > > > > +	rx_opt.mptcp.mp_capable =3D 0;
> > > > > +	rx_opt.mptcp.mp_join =3D 0;
> > > > > +	rx_opt.mptcp.dss =3D 0;
> > > > > +	mptcp_get_options(skb, &rx_opt);
> > > > > +
> > > > > +	if (rx_opt.mptcp.mp_capable && listener->request_mptcp) {
> > > > > +		subflow_req->mp_capable =3D 1;
> > > > > +		if (rx_opt.mptcp.version >=3D listener->version)
> > > > > +			subflow_req->version =3D listener->version;
> > > > > +		else
> > > > > +			subflow_req->version =3D rx_opt.mptcp.version;
> > > > > +		if ((rx_opt.mptcp.flags & MPTCP_CAP_CHECKSUM_REQD) ||
> > > > > +		    listener->checksum)
> > > > > +			subflow_req->checksum =3D 1;
> > > > > +		subflow_req->remote_key =3D rx_opt.mptcp.sndr_key;
> > > > > +	} else {
> > > > > +		subflow_req->mp_capable =3D 0;
> > > > > +	}
> > > > > +}
> > > > > +
> > > > >  static void subflow_finish_connect(struct sock *sk, const struct=
 sk_buff *skb)
> > > > >  {
> > > > >  	struct subflow_sock *subflow =3D subflow_sk(sk);
> > > > > @@ -68,13 +102,66 @@ static void subflow_finish_connect(struct so=
ck *sk, const struct sk_buff *skb)
> > > > >  	}
> > > > >  }
> > > > >  =

> > > > > +static struct request_sock_ops subflow_request_sock_ops;
> > > > > +static struct tcp_request_sock_ops subflow_request_sock_ipv4_ops;
> > > > > +
> > > > > +static int subflow_conn_request(struct sock *sk, struct sk_buff =
*skb)
> > > > > +{
> > > > > +	struct subflow_sock *subflow =3D subflow_sk(sk);
> > > > > +
> > > > > +	pr_debug("subflow=3D%p", subflow);
> > > > > +
> > > > > +	/* Never answer to SYNs sent to broadcast or multicast */
> > > > > +	if (skb_rtable(skb)->rt_flags & (RTCF_BROADCAST | RTCF_MULTICAS=
T))
> > > > > +		goto drop;
> > > > > +
> > > > > +	return tcp_conn_request(&subflow_request_sock_ops,
> > > > > +				&subflow_request_sock_ipv4_ops,
> > > > > +				sk, skb);
> > > > > +drop:
> > > > > +	tcp_listendrop(sk);
> > > > > +	return 0;
> > > > > +}
> > > > > +
> > > > > +static struct sock *subflow_syn_recv_sock(const struct sock *sk,
> > > > > +					  struct sk_buff *skb,
> > > > > +					  struct request_sock *req,
> > > > > +					  struct dst_entry *dst,
> > > > > +					  struct request_sock *req_unhash,
> > > > > +					  bool *own_req)
> > > > > +{
> > > > > +	struct subflow_sock *listener =3D subflow_sk(sk);
> > > > > +	struct subflow_request_sock *subflow_req =3D subflow_rsk(req);
> > > > > +	struct sock *child;
> > > > > +
> > > > > +	pr_debug("listener=3D%p, req=3D%p, conn=3D%p", sk, req, listene=
r->conn);
> > > > > +
> > > > > +	child =3D tcp_v4_syn_recv_sock(sk, skb, req, dst, req_unhash, o=
wn_req);
> > > > > +
> > > > > +	if (child) {
> > > > > +		struct subflow_sock *subflow =3D subflow_sk(child);
> > > > > +
> > > > > +		pr_debug("child=3D%p", child);
> > > > > +		if (subflow_req->mp_capable) {
> > > > > +			subflow->mp_capable =3D 1;
> > > > > +			subflow->fourth_ack =3D 1;
> > > > > +			subflow->remote_key =3D subflow_req->remote_key;
> > > > > +			subflow->local_key =3D subflow_req->local_key;
> > > > > +		} else {
> > > > > +			subflow->mp_capable =3D 0;
> > > > > +		}
> > > > > +	}
> > > > > +
> > > > > +	return child;
> > > > > +}
> > > > > +
> > > > >  const struct inet_connection_sock_af_ops subflow_specific =3D {
> > > > >  	.queue_xmit	   =3D ip_queue_xmit,
> > > > >  	.send_check	   =3D tcp_v4_send_check,
> > > > >  	.rebuild_header	   =3D inet_sk_rebuild_header,
> > > > >  	.sk_rx_dst_set	   =3D subflow_finish_connect,
> > > > > -	.conn_request	   =3D tcp_v4_conn_request,
> > > > > -	.syn_recv_sock	   =3D tcp_v4_syn_recv_sock,
> > > > > +	.conn_request	   =3D subflow_conn_request,
> > > > > +	.syn_recv_sock	   =3D subflow_syn_recv_sock,
> > > > >  	.net_header_len	   =3D sizeof(struct iphdr),
> > > > >  	.setsockopt	   =3D ip_setsockopt,
> > > > >  	.getsockopt	   =3D ip_getsockopt,
> > > > > @@ -112,6 +199,21 @@ static void subflow_close(struct sock *sk, l=
ong timeout)
> > > > >  	tcp_close(sk, timeout);
> > > > >  }
> > > > >  =

> > > > > +static struct sock *subflow_accept(struct sock *sk, int flags, i=
nt *err,
> > > > > +				   bool kern)
> > > > > +{
> > > > > +	struct subflow_sock *subflow =3D subflow_sk(sk);
> > > > > +	struct sock *child;
> > > > > +
> > > > > +	pr_debug("subflow=3D%p, conn=3D%p", subflow, subflow->conn);
> > > > > +
> > > > > +	child =3D inet_csk_accept(sk, flags, err, kern);
> > > > > +
> > > > > +	pr_debug("child=3D%p", child);
> > > > > +
> > > > > +	return child;
> > > > > +}
> > > > > +
> > > > >  static void subflow_destroy(struct sock *sk)
> > > > >  {
> > > > >  	pr_debug("subflow=3D%p", sk);
> > > > > @@ -125,7 +227,7 @@ static struct proto subflow_prot =3D {
> > > > >  	.close		=3D subflow_close,
> > > > >  	.connect	=3D subflow_connect,
> > > > >  	.disconnect	=3D tcp_disconnect,
> > > > > -	.accept		=3D inet_csk_accept,
> > > > > +	.accept		=3D subflow_accept,
> > > > >  	.ioctl		=3D tcp_ioctl,
> > > > >  	.init		=3D subflow_init_sock,
> > > > >  	.destroy	=3D subflow_destroy,
> > > > > @@ -169,7 +271,14 @@ int mptcp_subflow_init(void)
> > > > >  =

> > > > >  	/* TODO: Register path manager callbacks. */
> > > > >  =

> > > > > +	subflow_request_sock_ops =3D tcp_request_sock_ops;
> > > > > +	subflow_request_sock_ops.obj_size =3D sizeof(struct subflow_req=
uest_sock),
> > > > > +
> > > > > +	subflow_request_sock_ipv4_ops =3D tcp_request_sock_ipv4_ops;
> > > > > +	subflow_request_sock_ipv4_ops.init_req =3D subflow_v4_init_req;
> > > > > +
> > > > >  	subflow_prot.twsk_prot		=3D tcp_prot.twsk_prot;
> > > > > +	subflow_prot.rsk_prot		=3D &subflow_request_sock_ops;
> > > > >  	subflow_prot.h.hashinfo		=3D tcp_prot.h.hashinfo;
> > > > >  	err =3D proto_register(&subflow_prot, 1);
> > > > >  	if (err)
> > > > > -- =

> > > > > 2.19.1
> > > > > =

> > > > > _______________________________________________
> > > > > mptcp mailing list
> > > > > mptcp(a)lists.01.org
> > > > > https://lists.01.org/mailman/listinfo/mptcp
> > > > =

> > > > _______________________________________________
> > > > mptcp mailing list
> > > > mptcp(a)lists.01.org
> > > > https://lists.01.org/mailman/listinfo/mptcp

--===============2092615056402008681==--
