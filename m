Content-Type: multipart/mixed; boundary="===============6907476490035117023=="
MIME-Version: 1.0
From: Paolo Abeni <pabeni at redhat.com>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: [MPTCP][PATCH v4 mptcp-next 2/3] mptcp: send out
 dedicated ADD_ADDR packet
Date: Mon, 12 Oct 2020 18:18:27 +0200
Message-ID: <8778b2dddc6bf2f2fa62fb0e641fa8f3bc0f7741.camel@redhat.com>
In-Reply-To: 5df8d67258bfb5c2bce9b108e15b8a558ba318b9.1602323760.git.geliangtang@gmail.com
X-Status: 
X-Keywords:                  
X-UID: 6294

--===============6907476490035117023==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On Sat, 2020-10-10 at 18:07 +0800, Geliang Tang wrote:
> When ADD_ADDR suboption includes an IPv6 address, the size is 28 octets.
> It will not fit when other MPTCP suboptions are included in this packet,
> e.g. DSS. So here we send out an ADD_ADDR dedicated packet to carry only
> ADD_ADDR suboption, no other MPTCP suboptions.
> =

> In mptcp_pm_announce_addr, we check whether this is an IPv6 ADD_ADDR.
> If it is, we set the flag MPTCP_ADD_ADDR_IPV6 to true. Then we call
> mptcp_send_dedicated_add_addr_packet to sent out a new pure ACK packet.
> =

> In mptcp_established_options_add_addr, we check whether this is a pure
> ACK packet for ADD_ADDR. If it is, we drop all other MPTCP suboptions
> in this packet, only put ADD_ADDR suboption in it.
> =

> Suggested-by: Paolo Abeni <pabeni(a)redhat.com>
> Signed-off-by: Geliang Tang <geliangtang(a)gmail.com>
> ---
>  net/mptcp/options.c    | 23 ++++++++++++++++++++---
>  net/mptcp/pm.c         |  9 +++++++--
>  net/mptcp/pm_netlink.c | 37 +++++++++++++++++++++++++++++++++++++
>  net/mptcp/protocol.h   |  3 +++
>  4 files changed, 67 insertions(+), 5 deletions(-)
> =

> diff --git a/net/mptcp/options.c b/net/mptcp/options.c
> index d601dd1ebe5e..7de9b5af72db 100644
> --- a/net/mptcp/options.c
> +++ b/net/mptcp/options.c
> @@ -243,7 +243,9 @@ static void mptcp_parse_option(const struct sk_buff *=
skb,
>  		mp_opt->add_addr =3D 1;
>  		mp_opt->port =3D 0;
>  		mp_opt->addr_id =3D *ptr++;
> -		pr_debug("ADD_ADDR: id=3D%d, echo=3D%d", mp_opt->addr_id, mp_opt->echo=
);
> +		pr_debug("ADD_ADDR%s: id=3D%d, echo=3D%d",
> +			 (mp_opt->family =3D=3D MPTCP_ADDR_IPVERSION_6) ? "6" : "",
> +			 mp_opt->addr_id, mp_opt->echo);
>  		if (mp_opt->family =3D=3D MPTCP_ADDR_IPVERSION_4) {
>  			memcpy((u8 *)&mp_opt->addr.s_addr, (u8 *)ptr, 4);
>  			ptr +=3D 4;
> @@ -572,17 +574,30 @@ static u64 add_addr6_generate_hmac(u64 key1, u64 ke=
y2, u8 addr_id,
>  }
>  #endif
>  =

> -static bool mptcp_established_options_add_addr(struct sock *sk,
> +static bool mptcp_established_options_add_addr(struct sock *sk, struct s=
k_buff *skb,
>  					       unsigned int *size,
>  					       unsigned int remaining,
>  					       struct mptcp_out_options *opts)
>  {
>  	struct mptcp_subflow_context *subflow =3D mptcp_subflow_ctx(sk);
>  	struct mptcp_sock *msk =3D mptcp_sk(subflow->conn);
> +	bool drop_other_suboptions =3D false;
> +	unsigned int opt_size =3D *size;
>  	struct mptcp_addr_info saddr;
>  	bool echo;
>  	int len;
>  =

> +	if (msk->pm.add_addr_signal & BIT(MPTCP_ADD_ADDR_IPV6) &&
> +	    msk->pm.add_addr_signal & BIT(MPTCP_ADD_ADDR_SEND_ACK) &&

Why is the 'MPTCP_ADD_ADDR_SEND_ACK' bit required? can't we simply
check the other conditions ???

> +	    skb && skb_is_tcp_pure_ack(skb)) {
> +		msk->pm.add_addr_signal &=3D ~BIT(MPTCP_ADD_ADDR_IPV6);
> +
> +		pr_debug("drop other suboptions");
> +		opts->suboptions =3D 0;
> +		remaining +=3D opt_size;
> +		drop_other_suboptions =3D true;
> +	}
> +
>  	if (!mptcp_pm_should_add_signal(msk) ||
>  	    !(mptcp_pm_add_addr_signal(msk, remaining, &saddr, &echo)))
>  		return false;
> @@ -592,6 +607,8 @@ static bool mptcp_established_options_add_addr(struct=
 sock *sk,
>  		return false;
>  =

>  	*size =3D len;
> +	if (drop_other_suboptions)
> +		*size -=3D opt_size;
>  	opts->addr_id =3D saddr.id;
>  	if (saddr.family =3D=3D AF_INET) {
>  		opts->suboptions |=3D OPTION_MPTCP_ADD_ADDR;
> @@ -671,7 +688,7 @@ bool mptcp_established_options(struct sock *sk, struc=
t sk_buff *skb,
>  =

>  	*size +=3D opt_size;
>  	remaining -=3D opt_size;
> -	if (mptcp_established_options_add_addr(sk, &opt_size, remaining, opts))=
 {
> +	if (mptcp_established_options_add_addr(sk, skb, &opt_size, remaining, o=
pts)) {
>  		*size +=3D opt_size;
>  		remaining -=3D opt_size;
>  		ret =3D true;
> diff --git a/net/mptcp/pm.c b/net/mptcp/pm.c
> index 5f453db36e54..da99f8e24702 100644
> --- a/net/mptcp/pm.c
> +++ b/net/mptcp/pm.c
> @@ -22,6 +22,8 @@ int mptcp_pm_announce_addr(struct mptcp_sock *msk,
>  	msk->pm.add_addr_signal |=3D BIT(MPTCP_ADD_ADDR_SIGNAL);
>  	if (echo)
>  		msk->pm.add_addr_signal |=3D BIT(MPTCP_ADD_ADDR_ECHO);
> +	if (addr->family =3D=3D AF_INET6)
> +		msk->pm.add_addr_signal |=3D BIT(MPTCP_ADD_ADDR_IPV6);
>  	return 0;
>  }
>  =

> @@ -150,10 +152,13 @@ void mptcp_pm_add_addr_received(struct mptcp_sock *=
msk,
>  =

>  	spin_lock_bh(&pm->lock);
>  =

> -	if (!READ_ONCE(pm->accept_addr))
> +	if (!READ_ONCE(pm->accept_addr)) {
>  		mptcp_pm_announce_addr(msk, addr, true);
> -	else if (mptcp_pm_schedule_work(msk, MPTCP_PM_ADD_ADDR_RECEIVED))
> +		if (msk->pm.add_addr_signal & BIT(MPTCP_ADD_ADDR_IPV6))
> +			mptcp_send_dedicated_add_addr_packet(msk);

I *think* that moving the mptcp_send_dedicated_add_addr_packet() call
outside the pm_lock will simplify the code,
as mptcp_send_dedicated_add_addr_packet() will not need to
release/acquire it again and the move shoud not be problematic in all
call-site.

I would try to set a local bool variable inside under the pm lock scope
when the pure ack is needed and test such variable after releasing the
lock itself.

> @@ -329,6 +356,13 @@ static void mptcp_pm_create_subflow_or_signal_addr(s=
truct mptcp_sock *msk)
>  			if (mptcp_pm_alloc_anno_list(msk, local)) {
>  				msk->pm.add_addr_signaled++;
>  				mptcp_pm_announce_addr(msk, &local->addr, false);
> +
> +				if (msk->pm.add_addr_signal & BIT(MPTCP_ADD_ADDR_IPV6)) {
> +					spin_unlock_bh(&msk->pm.lock);
> +					msleep(500);

??? =

I fear this is not upstream acceptable. Why such delay is needed? =

We need to resolve such need without the delay.

>@@ -399,6 +433,9 @@ void mptcp_pm_nl_add_addr_received(struct mptcp_sock *=
msk)
>  	spin_lock_bh(&msk->pm.lock);
>  =

>  	mptcp_pm_announce_addr(msk, &remote, true);
> +
> +	if (msk->pm.add_addr_signal & BIT(MPTCP_ADD_ADDR_IPV6))
> +		mptcp_send_dedicated_add_addr_packet(msk);

If mptcp_send_dedicated_add_addr_packet() is modified to avoid pm lock
dance, the mptcp_pm_announce_addr() should be moved a bit above:

// -> here
	spin_unlock_bh(&msk->pm.lock);
// and here -> we should call mptcp_send_dedicated_add_addr_packet(msk);

        __mptcp_subflow_connect((struct sock *)msk, &local, &remote);


>  }
>  =

>  void mptcp_pm_nl_rm_addr_received(struct mptcp_sock *msk)

Please reach for me on IRC if the above feedback is confusing!

Cheers,

Paolo

--===============6907476490035117023==--
