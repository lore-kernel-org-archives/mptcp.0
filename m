Content-Type: multipart/mixed; boundary="===============4113049002771899873=="
MIME-Version: 1.0
From: Paolo Abeni <pabeni at redhat.com>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: [mptcp-next] mptcp: track window announced to peer
Date: Thu, 15 Oct 2020 15:46:04 +0200
Message-ID: <bd6b44154a14fe74b67cd17c7f2fec6c464f0d2c.camel@redhat.com>
In-Reply-To: 20201015124528.28088-1-fw@strlen.de
X-Status: 
X-Keywords:                  
X-UID: 6315

--===============4113049002771899873==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On Thu, 2020-10-15 at 14:45 +0200, Florian Westphal wrote:
> OoO handling attemtps to detect when packet is out-of-window by testing
> current ack sequence and remaining space vs. sequence number.
> =

> This doesn't work reliably.  This stores the highest allowed sequence
> number that we've sent and uses it to detect oow packets.
> =

> Do this during mptcp option writing, this handles ACKs sent on
> behalf of tcp_cleanup_rbuf().  We also need to update when a new
> window is chosen, because option writing occurs earlier than this:
> =

> 1. mptcp_established_options_dss advances ack_seq
> 2. ack_seq + win is stored
> 3. __tcp_transmit_skb calls tcp_select_window
> =

> This would lead to detection of oow packets as saved value was based on
> outdated tp->rcv_wnd.
> =

> Signed-off-by: Florian Westphal <fw(a)strlen.de>
> ---
>  include/net/mptcp.h   |  3 +++
>  net/ipv4/tcp_output.c |  2 ++
>  net/mptcp/options.c   | 13 +++++++++++--
>  net/mptcp/protocol.c  | 10 +++++-----
>  net/mptcp/protocol.h  |  1 +
>  net/mptcp/subflow.c   | 10 ++++++++++
>  6 files changed, 32 insertions(+), 7 deletions(-)
> =

> diff --git a/include/net/mptcp.h b/include/net/mptcp.h
> index 6e706d838e4e..177735615ef6 100644
> --- a/include/net/mptcp.h
> +++ b/include/net/mptcp.h
> @@ -63,6 +63,8 @@ extern struct request_sock_ops mptcp_subflow_request_so=
ck_ops;
>  =

>  void mptcp_init(void);
>  =

> +void mptcp_set_rwin(const struct sock *ssk, u32 rw);
> +
>  static inline bool sk_is_mptcp(const struct sock *sk)
>  {
>  	return tcp_sk(sk)->is_mptcp;
> @@ -220,6 +222,7 @@ static inline bool mptcp_skb_can_collapse(const struc=
t sk_buff *to,
>  =

>  static inline void mptcp_space(const struct sock *ssk, int *s, int *fs) =
{ }
>  static inline void mptcp_seq_show(struct seq_file *seq) { }
> +static inline void mptcp_set_rwin(const struct sock *ssk, u32 rw) { }
>  =

>  static inline int mptcp_subflow_init_cookie_req(struct request_sock *req,
>  						const struct sock *sk_listener,
> diff --git a/net/ipv4/tcp_output.c b/net/ipv4/tcp_output.c
> index 9abf5a0358d5..89946e451365 100644
> --- a/net/ipv4/tcp_output.c
> +++ b/net/ipv4/tcp_output.c
> @@ -279,6 +279,8 @@ static u16 tcp_select_window(struct sock *sk)
>  	}
>  	tp->rcv_wnd =3D new_win;
>  	tp->rcv_wup =3D tp->rcv_nxt;
> +	if (sk_is_mptcp(sk))
> +		mptcp_set_rwin(sk, new_win);
>  =

>  	/* Make sure we do not exceed the maximum possible
>  	 * scaled window.

I'm wondering if we could avoid this extra hook moving option writing
after tcp wind selection, passing the tcp_sock to mptcp_write_options
and fetch rcv_wup there.

> diff --git a/net/mptcp/options.c b/net/mptcp/options.c
> index d601dd1ebe5e..0babe13780cc 100644
> --- a/net/mptcp/options.c
> +++ b/net/mptcp/options.c
> @@ -489,6 +489,7 @@ static bool mptcp_established_options_dss(struct sock=
 *sk, struct sk_buff *skb,
>  	struct mptcp_ext *mpext;
>  	unsigned int ack_size;
>  	bool ret =3D false;
> +	u64 ack_seq;
>  =

>  	mpext =3D skb ? mptcp_get_ext(skb) : NULL;
>  	snd_data_fin_enable =3D mptcp_data_fin_enabled(msk);
> @@ -517,15 +518,23 @@ static bool mptcp_established_options_dss(struct so=
ck *sk, struct sk_buff *skb,
>  		return ret;
>  	}
>  =

> +	ack_seq =3D READ_ONCE(msk->ack_seq);
> +
>  	if (READ_ONCE(msk->use_64bit_ack)) {
>  		ack_size =3D TCPOLEN_MPTCP_DSS_ACK64;
> -		opts->ext_copy.data_ack =3D READ_ONCE(msk->ack_seq);
> +		opts->ext_copy.data_ack =3D ack_seq;
>  		opts->ext_copy.ack64 =3D 1;
>  	} else {
>  		ack_size =3D TCPOLEN_MPTCP_DSS_ACK32;
> -		opts->ext_copy.data_ack32 =3D (uint32_t)READ_ONCE(msk->ack_seq);
> +		opts->ext_copy.data_ack32 =3D (uint32_t)ack_seq;
>  		opts->ext_copy.ack64 =3D 0;
>  	}
> +
> +	ack_seq +=3D tcp_sk(sk)->rcv_wnd;
> +
> +	if (after64(ack_seq, msk->rcv_wnd_sent))
> +		WRITE_ONCE(msk->rcv_wnd_sent, ack_seq);
> +

Don't we need to READ_ONCE() the msk wnd ? For TCP-generated acks or
TCP retransmissions, here we could be outside the msk socket lock.

>  	opts->ext_copy.use_ack =3D 1;
>  =

>  	/* Add kind/length/subtype/flag overhead if mapping is not populated */
> diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
> index 95121d9116cb..6917ed13c8d5 100644
> --- a/net/mptcp/protocol.c
> +++ b/net/mptcp/protocol.c
> @@ -168,19 +168,17 @@ static void mptcp_data_queue_ofo(struct mptcp_sock =
*msk, struct sk_buff *skb)
>  	struct rb_node **p, *parent;
>  	u64 seq, end_seq, max_seq;
>  	struct sk_buff *skb1;
> -	int space;
>  =

>  	seq =3D MPTCP_SKB_CB(skb)->map_seq;
>  	end_seq =3D MPTCP_SKB_CB(skb)->end_seq;
> -	space =3D tcp_space(sk);
> -	max_seq =3D space > 0 ? space + msk->ack_seq : msk->ack_seq;
> +	max_seq =3D READ_ONCE(msk->rcv_wnd_sent);
>  =

>  	pr_debug("msk=3D%p seq=3D%llx limit=3D%llx empty=3D%d", msk, seq, max_s=
eq,
>  		 RB_EMPTY_ROOT(&msk->out_of_order_queue));
> -	if (after64(seq, max_seq)) {
> +	if (after64(end_seq, max_seq)) {
>  		/* out of window */
>  		mptcp_drop(sk, skb);
> -		pr_info("oow by %ld\n", (unsigned long)seq - (unsigned long)max_seq);
> +		pr_info("oow by %ld, rcv_wnd_sent %lu\n", (unsigned long)end_seq - (un=
signed long)max_seq, (long)msk->rcv_wnd_sent);
>  		MPTCP_INC_STATS(sock_net(sk), MPTCP_MIB_NODSSWINDOW);
>  		return;
>  	}
> @@ -2273,6 +2271,7 @@ struct sock *mptcp_sk_clone(const struct sock *sk,
>  		mptcp_crypto_key_sha(msk->remote_key, NULL, &ack_seq);
>  		ack_seq++;
>  		WRITE_ONCE(msk->ack_seq, ack_seq);
> +		WRITE_ONCE(msk->rcv_wnd_sent, ack_seq);
>  	}
>  =

>  #if !IS_ENABLED(CONFIG_KASAN)
> @@ -2582,6 +2581,7 @@ void mptcp_finish_connect(struct sock *ssk)
>  	WRITE_ONCE(msk->write_seq, subflow->idsn + 1);
>  	WRITE_ONCE(msk->snd_nxt, msk->write_seq);
>  	WRITE_ONCE(msk->ack_seq, ack_seq);
> +	WRITE_ONCE(msk->rcv_wnd_sent, ack_seq);
>  	WRITE_ONCE(msk->can_ack, 1);
>  	atomic64_set(&msk->snd_una, msk->write_seq);
>  =

> diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
> index 2f2e0b64ec58..ea8d6d9a6224 100644
> --- a/net/mptcp/protocol.h
> +++ b/net/mptcp/protocol.h
> @@ -211,6 +211,7 @@ struct mptcp_sock {
>  	u64		write_seq;
>  	u64		snd_nxt;
>  	u64		ack_seq;
> +	u64		rcv_wnd_sent;
>  	u64		rcv_data_fin_seq;
>  	struct sock	*last_snd;
>  	int		snd_burst;
> diff --git a/net/mptcp/subflow.c b/net/mptcp/subflow.c
> index 00040dee323e..66a1ec338fdc 100644
> --- a/net/mptcp/subflow.c
> +++ b/net/mptcp/subflow.c
> @@ -961,6 +961,16 @@ void mptcp_space(const struct sock *ssk, int *space,=
 int *full_space)
>  	*full_space =3D tcp_full_space(sk);
>  }
>  =

> +void mptcp_set_rwin(const struct sock *ssk, u32 rwin)
> +{
> +	const struct mptcp_subflow_context *subflow =3D mptcp_subflow_ctx(ssk);
> +	struct mptcp_sock *msk =3D mptcp_sk(subflow->conn);
> +	u64 ack_seq =3D READ_ONCE(msk->ack_seq) + rwin;
> +
> +	if (after64(ack_seq, msk->rcv_wnd_sent))
> +		WRITE_ONCE(msk->rcv_wnd_sent, ack_seq);
> +}
> +
>  static void subflow_data_ready(struct sock *sk)
>  {
>  	struct mptcp_subflow_context *subflow =3D mptcp_subflow_ctx(sk);

Looks very good to me. I'm trying a few iteration of simult xmit self
test to see how it goes...

/P

--===============4113049002771899873==--
