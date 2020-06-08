Content-Type: multipart/mixed; boundary="===============3771896256214146725=="
MIME-Version: 1.0
From: Paolo Abeni <pabeni at redhat.com>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: [kbuild] [mptcp:export 5/10] net/mptcp/subflow.c:512
 subflow_syn_recv_sock() error: uninitialized symbol 'subflow_req'.
Date: Mon, 08 Jun 2020 15:29:12 +0200
Message-ID: <a77061c3f7ef8ef800e3646b6b2165774594564d.camel@redhat.com>
In-Reply-To: 20200608131535.GO22511@kadam
X-Status: 
X-Keywords:                  
X-UID: 4609

--===============3771896256214146725==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi,

On Mon, 2020-06-08 at 16:15 +0300, Dan Carpenter wrote:
> tree:   https://github.com/multipath-tcp/mptcp_net-next.git export
> head:   e28f6a7575a0006d0d49de297e23dd915c59ba39
> commit: 962c918a1ca2553fac7db45c2a2f9b84fa30a6d9 [5/10] mptcp: refactor t=
oken container.
> config: x86_64-randconfig-m001-20200605 (attached as .config)
> compiler: gcc-9 (Debian 9.3.0-13) 9.3.0
> =

> If you fix the issue, kindly add following tag as appropriate
> Reported-by: kernel test robot <lkp(a)intel.com>
> Reported-by: Dan Carpenter <dan.carpenter(a)oracle.com>
> =

> smatch warnings:
> net/mptcp/subflow.c:512 subflow_syn_recv_sock() error: uninitialized symb=
ol 'subflow_req'.
> =

> # https://github.com/multipath-tcp/mptcp_net-next/commit/962c918a1ca2553f=
ac7db45c2a2f9b84fa30a6d9
> git remote add mptcp https://github.com/multipath-tcp/mptcp_net-next.git
> git remote update mptcp
> git checkout 962c918a1ca2553fac7db45c2a2f9b84fa30a6d9
> vim +/subflow_req +512 net/mptcp/subflow.c
> =

> cec37a6e41aae7 Peter Krystad    2020-01-21  430  static struct sock *subf=
low_syn_recv_sock(const struct sock *sk,
> cec37a6e41aae7 Peter Krystad    2020-01-21  431  					  struct sk_buff *s=
kb,
> cec37a6e41aae7 Peter Krystad    2020-01-21  432  					  struct request_so=
ck *req,
> cec37a6e41aae7 Peter Krystad    2020-01-21  433  					  struct dst_entry =
*dst,
> cec37a6e41aae7 Peter Krystad    2020-01-21  434  					  struct request_so=
ck *req_unhash,
> cec37a6e41aae7 Peter Krystad    2020-01-21  435  					  bool *own_req)
> cec37a6e41aae7 Peter Krystad    2020-01-21  436  {
> cec37a6e41aae7 Peter Krystad    2020-01-21  437  	struct mptcp_subflow_co=
ntext *listener =3D mptcp_subflow_ctx(sk);
> cc7972ea193233 Christoph Paasch 2020-01-21  438  	struct mptcp_subflow_re=
quest_sock *subflow_req;
>                                                                          =
                  ^^^^^^^^^^^
> =

> cfde141ea3faa3 Paolo Abeni      2020-04-30  439  	struct mptcp_options_re=
ceived mp_opt;
> f296234c98a8fc Peter Krystad    2020-03-27  440  	bool fallback_is_fatal =
=3D false;
> 58b09919626bf9 Paolo Abeni      2020-03-13  441  	struct sock *new_msk =
=3D NULL;
> 4c8941de781cf7 Paolo Abeni      2020-04-20  442  	bool fallback =3D false;
> cec37a6e41aae7 Peter Krystad    2020-01-21  443  	struct sock *child;
> cec37a6e41aae7 Peter Krystad    2020-01-21  444  =

> cec37a6e41aae7 Peter Krystad    2020-01-21  445  	pr_debug("listener=3D%p=
, req=3D%p, conn=3D%p", listener, req, listener->conn);
> cec37a6e41aae7 Peter Krystad    2020-01-21  446  =

> cfde141ea3faa3 Paolo Abeni      2020-04-30  447  	/* we need later a vali=
d 'mp_capable' value even when options are not
> cfde141ea3faa3 Paolo Abeni      2020-04-30  448  	 * parsed
> cfde141ea3faa3 Paolo Abeni      2020-04-30  449  	 */
> cfde141ea3faa3 Paolo Abeni      2020-04-30  450  	mp_opt.mp_capable =3D 0;
> ae2dd7164943e0 Florian Westphal 2020-01-29  451  	if (tcp_rsk(req)->is_mp=
tcp =3D=3D 0)
> ae2dd7164943e0 Florian Westphal 2020-01-29  452  		goto create_child;
>                                                                 ^^^^^^^^^=
^^^^^^^^
> =

> ae2dd7164943e0 Florian Westphal 2020-01-29  453  =

> d22f4988ffecbe Christoph Paasch 2020-01-21  454  	/* if the sk is MP_CAPA=
BLE, we try to fetch the client key */
> cc7972ea193233 Christoph Paasch 2020-01-21  455  	subflow_req =3D mptcp_s=
ubflow_rsk(req);
> cc7972ea193233 Christoph Paasch 2020-01-21  456  	if (subflow_req->mp_cap=
able) {
> d22f4988ffecbe Christoph Paasch 2020-01-21  457  		if (TCP_SKB_CB(skb)->s=
eq !=3D subflow_req->ssn_offset + 1) {
> d22f4988ffecbe Christoph Paasch 2020-01-21  458  			/* here we can receiv=
e and accept an in-window,
> d22f4988ffecbe Christoph Paasch 2020-01-21  459  			 * out-of-order pkt, =
which will not carry the MP_CAPABLE
> d22f4988ffecbe Christoph Paasch 2020-01-21  460  			 * opt even on mptcp =
enabled paths
> d22f4988ffecbe Christoph Paasch 2020-01-21  461  			 */
> 58b09919626bf9 Paolo Abeni      2020-03-13  462  			goto create_msk;
> d22f4988ffecbe Christoph Paasch 2020-01-21  463  		}
> d22f4988ffecbe Christoph Paasch 2020-01-21  464  =

> cfde141ea3faa3 Paolo Abeni      2020-04-30  465  		mptcp_get_options(skb,=
 &mp_opt);
> cfde141ea3faa3 Paolo Abeni      2020-04-30  466  		if (!mp_opt.mp_capable=
) {
> 4c8941de781cf7 Paolo Abeni      2020-04-20  467  			fallback =3D true;
> 58b09919626bf9 Paolo Abeni      2020-03-13  468  			goto create_child;
> d22f4988ffecbe Christoph Paasch 2020-01-21  469  		}
> 58b09919626bf9 Paolo Abeni      2020-03-13  470  =

> 58b09919626bf9 Paolo Abeni      2020-03-13  471  create_msk:
> cfde141ea3faa3 Paolo Abeni      2020-04-30  472  		new_msk =3D mptcp_sk_c=
lone(listener->conn, &mp_opt, req);
> 58b09919626bf9 Paolo Abeni      2020-03-13  473  		if (!new_msk)
> 4c8941de781cf7 Paolo Abeni      2020-04-20  474  			fallback =3D true;
> f296234c98a8fc Peter Krystad    2020-03-27  475  	} else if (subflow_req-=
>mp_join) {
> f296234c98a8fc Peter Krystad    2020-03-27  476  		fallback_is_fatal =3D =
true;
> cfde141ea3faa3 Paolo Abeni      2020-04-30  477  		mptcp_get_options(skb,=
 &mp_opt);
> cfde141ea3faa3 Paolo Abeni      2020-04-30  478  		if (!mp_opt.mp_join ||
> cfde141ea3faa3 Paolo Abeni      2020-04-30  479  		    !subflow_hmac_vali=
d(req, &mp_opt)) {
> fc518953bc9c8d Florian Westphal 2020-03-27  480  			SUBFLOW_REQ_INC_STATS=
(req, MPTCP_MIB_JOINACKMAC);
> f296234c98a8fc Peter Krystad    2020-03-27  481  			return NULL;
> cc7972ea193233 Christoph Paasch 2020-01-21  482  		}
> fc518953bc9c8d Florian Westphal 2020-03-27  483  	}
> cec37a6e41aae7 Peter Krystad    2020-01-21  484  =

> d22f4988ffecbe Christoph Paasch 2020-01-21  485  create_child:
>                                                  ^^^^^^^^^^^^
> =

> cec37a6e41aae7 Peter Krystad    2020-01-21  486  	child =3D listener->ics=
k_af_ops->syn_recv_sock(sk, skb, req, dst,
> cec37a6e41aae7 Peter Krystad    2020-01-21  487  						     req_unhash, o=
wn_req);
> cec37a6e41aae7 Peter Krystad    2020-01-21  488  =

> cec37a6e41aae7 Peter Krystad    2020-01-21  489  	if (child && *own_req) {
> 79c0949e9a09f6 Peter Krystad    2020-01-21  490  		struct mptcp_subflow_c=
ontext *ctx =3D mptcp_subflow_ctx(child);
> 79c0949e9a09f6 Peter Krystad    2020-01-21  491  =

> 90bf45134d55d6 Paolo Abeni      2020-05-15  492  		tcp_rsk(req)->drop_req=
 =3D false;
> 90bf45134d55d6 Paolo Abeni      2020-05-15  493  =

> 4c8941de781cf7 Paolo Abeni      2020-04-20  494  		/* we need to fallback=
 on ctx allocation failure and on pre-reqs
> 4c8941de781cf7 Paolo Abeni      2020-04-20  495  		 * checking above. In =
the latter scenario we additionally need
> 4c8941de781cf7 Paolo Abeni      2020-04-20  496  		 * to reset the contex=
t to non MPTCP status.
> 79c0949e9a09f6 Peter Krystad    2020-01-21  497  		 */
> 4c8941de781cf7 Paolo Abeni      2020-04-20  498  		if (!ctx || fallback) {
> f296234c98a8fc Peter Krystad    2020-03-27  499  			if (fallback_is_fatal)
> 729cd6436f359b Paolo Abeni      2020-05-15  500  				goto dispose_child;
> 4c8941de781cf7 Paolo Abeni      2020-04-20  501  =

> 39884604b11692 Paolo Abeni      2020-05-29  502  			subflow_drop_ctx(chil=
d);
> 58b09919626bf9 Paolo Abeni      2020-03-13  503  			goto out;
> f296234c98a8fc Peter Krystad    2020-03-27  504  		}
> 79c0949e9a09f6 Peter Krystad    2020-01-21  505  =

> 79c0949e9a09f6 Peter Krystad    2020-01-21  506  		if (ctx->mp_capable) {
> 58b09919626bf9 Paolo Abeni      2020-03-13  507  			/* new mpc subflow ta=
kes ownership of the newly
> 58b09919626bf9 Paolo Abeni      2020-03-13  508  			 * created mptcp sock=
et
> 58b09919626bf9 Paolo Abeni      2020-03-13  509  			 */
> df1036da90108b Florian Westphal 2020-04-17  510  			new_msk->sk_destruct =
=3D mptcp_sock_destruct;
> 1b1c7a0ef7f323 Peter Krystad    2020-03-27  511  			mptcp_pm_new_connecti=
on(mptcp_sk(new_msk), 1);
> 962c918a1ca255 Paolo Abeni      2020-06-05 @512  			mptcp_token_accept(su=
bflow_req, mptcp_sk(new_msk));
>                                                                          =
                  ^^^^^^^^^^^
> Potential uninitialized?

Thank you for the report. This looks actually a false positive: we skip
subflow_req initialization only if !is_mptcp. And that implies
!mp_capable, (on both the request socket and the child socket). So
can't reach here.

BTW I'll be curious to learn how this report has been created?!? Are
you using a kbuild bot instance to run smack on mptcp export branch ?!?

Manu thanks!

Paolo

--===============3771896256214146725==--
