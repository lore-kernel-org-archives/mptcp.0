Content-Type: multipart/mixed; boundary="===============9204652423087602615=="
MIME-Version: 1.0
From: Paolo Abeni <pabeni at redhat.com>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: [MPTCP][PATCH mptcp-next] mptcp: add ADD_ADDR IPv6 support
Date: Fri, 18 Sep 2020 16:54:54 +0200
Message-ID: <dad33eebdb5901a3d738341189c0d0d8e7cc301b.camel@redhat.com>
In-Reply-To: 7d1d38ff0d05925e96ddb0782f8c5e3e1206590f.1600438707.git.geliangtang@gmail.com
X-Status: 
X-Keywords:                  
X-UID: 5934

--===============9204652423087602615==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On Fri, 2020-09-18 at 22:19 +0800, Geliang Tang wrote:
> When ADD_ADDR suboption include an IPv6 address, the size is 28 octets.
> It will not fit when other options are included, e.g. TCP Timestamps. So
> here we send out a mptcp dedicated packet to carry only mptcp options.
> =

> Closes: https://github.com/multipath-tcp/mptcp_net-next/issues/55
> Signed-off-by: Geliang Tang <geliangtang(a)gmail.com>
> ---
>  include/linux/tcp.h                           |  1 +
>  net/ipv4/tcp_output.c                         | 14 ++++++++
>  net/mptcp/options.c                           |  5 +--
>  net/mptcp/pm.c                                | 22 +++++++++++--
>  net/mptcp/protocol.h                          |  3 +-
>  .../testing/selftests/net/mptcp/mptcp_join.sh | 33 ++++++++++++++++++-
>  6 files changed, 72 insertions(+), 6 deletions(-)
> =

> diff --git a/include/linux/tcp.h b/include/linux/tcp.h
> index 2f87377e9af7..847442ac5b26 100644
> --- a/include/linux/tcp.h
> +++ b/include/linux/tcp.h
> @@ -392,6 +392,7 @@ struct tcp_sock {
>  			   */
>  #if IS_ENABLED(CONFIG_MPTCP)
>  	bool	is_mptcp;
> +	bool	mptcp_dedicated;
>  #endif

Uhmm... I would try to avoid adding more fields to tcp_sock, if
possible. Also additional hooking should be avoided, still if possible.

I think we could: =

1) change mptcp_established_options*() functions to accept =

  "struct tcp_out_options*" as the last argument, instead of
  "struct mptcp_out_options*".

2) add an 'skb' argument to mptcp_established_options_addr()

3) in mptcp_established_options_addr(), if the packet is a pure ack and
   the address to be announced is AF_INET6, drop the OPTION_TS bit from
   opts->options

Overall should be quite similar to this patch -
specifically, mptcp_pm_add_addr_signal will still send a pure ack
packet.

Side note, the above would offer the possibility of an interesting
follow-up: we could change the "tcp_out_options" struct "mptcp" field
from:
	struct mptcp_out_options mptcp;

to:
	struct mptcp_out_options *mptcp;

and init the pointer in mptcp_established_options() - the data could be
embedded in the subflow context structure, so no dynamic allocation.

That would remove the last misurable overhead we have on MPTCP enabled
build for plain TCP sockets, as tcp_out_options are zeroed for every
packet and 'struct mptcp_out_options' is quite big. (issue/15)


>  #if IS_ENABLED(CONFIG_SMC)
>  	bool	syn_smc;	/* SYN includes SMC */
> diff --git a/net/ipv4/tcp_output.c b/net/ipv4/tcp_output.c
> index 88f6872751d3..0089ed3969a0 100644
> --- a/net/ipv4/tcp_output.c
> +++ b/net/ipv4/tcp_output.c
> @@ -921,6 +921,20 @@ static unsigned int tcp_established_options(struct s=
ock *sk, struct sk_buff *skb
>  	opts->options =3D 0;
>  =

>  	*md5 =3D NULL;
> +
> +	if (sk_is_mptcp(sk) && tp->mptcp_dedicated) {
> +		unsigned int remaining =3D MAX_TCP_OPTION_SPACE - size;
> +		unsigned int opt_size =3D 0;
> +
> +		if (mptcp_established_options(sk, skb, &opt_size, remaining,
> +					      &opts->mptcp)) {
> +			opts->options |=3D OPTION_MPTCP;
> +			size +=3D opt_size;
> +		}
> +
> +		return size;
> +	}
> +
>  #ifdef CONFIG_TCP_MD5SIG
>  	if (static_branch_unlikely(&tcp_md5_needed) &&
>  	    rcu_access_pointer(tp->md5sig_info)) {
> diff --git a/net/mptcp/options.c b/net/mptcp/options.c
> index 171039cbe9c4..f0ca3ed4dba8 100644
> --- a/net/mptcp/options.c
> +++ b/net/mptcp/options.c
> @@ -243,7 +243,8 @@ static void mptcp_parse_option(const struct sk_buff *=
skb,
>  		mp_opt->add_addr =3D 1;
>  		mp_opt->port =3D 0;
>  		mp_opt->addr_id =3D *ptr++;
> -		pr_debug("ADD_ADDR: id=3D%d, echo=3D%d", mp_opt->addr_id, mp_opt->echo=
);
> +		pr_debug("ADD_ADDR%s: id=3D%d, echo=3D%d", (mp_opt->family =3D=3D 6) ?=
 "6" : "",
> +			 mp_opt->addr_id, mp_opt->echo);
>  		if (mp_opt->family =3D=3D MPTCP_ADDR_IPVERSION_4) {
>  			memcpy((u8 *)&mp_opt->addr.s_addr, (u8 *)ptr, 4);
>  			ptr +=3D 4;
> @@ -584,7 +585,7 @@ static bool mptcp_established_options_add_addr(struct=
 sock *sk,
>  	int len;
>  =

>  	if (!mptcp_pm_should_add_signal(msk) ||
> -	    !(mptcp_pm_add_addr_signal(msk, remaining, &saddr, &echo)))
> +	    !(mptcp_pm_add_addr_signal(msk, sk, remaining, &saddr, &echo)))
>  		return false;
>  =

>  	len =3D mptcp_add_addr_len(saddr.family);
> diff --git a/net/mptcp/pm.c b/net/mptcp/pm.c
> index 6ca88422e774..0b015f8bdd34 100644
> --- a/net/mptcp/pm.c
> +++ b/net/mptcp/pm.c
> @@ -170,11 +170,22 @@ void mptcp_pm_rm_addr_received(struct mptcp_sock *m=
sk, u8 rm_id)
>  	spin_unlock_bh(&pm->lock);
>  }
>  =

> +static void mptcp_send_dedicated_ack(struct sock *sk)
> +{
> +	struct tcp_sock *tp =3D tcp_sk(sk);
> +
> +	tp->mptcp_dedicated =3D true;
> +	tcp_send_ack(sk);
> +	tp->mptcp_dedicated =3D false;
> +}
> +
>  /* path manager helpers */
>  =

> -bool mptcp_pm_add_addr_signal(struct mptcp_sock *msk, unsigned int remai=
ning,
> +bool mptcp_pm_add_addr_signal(struct mptcp_sock *msk, struct sock *ssk,
> +			      unsigned int remaining,
>  			      struct mptcp_addr_info *saddr, bool *echo)
>  {
> +	bool add_addr6 =3D false;
>  	int ret =3D false;
>  =

>  	spin_lock_bh(&msk->pm.lock);
> @@ -183,8 +194,11 @@ bool mptcp_pm_add_addr_signal(struct mptcp_sock *msk=
, unsigned int remaining,
>  	if (!mptcp_pm_should_add_signal(msk))
>  		goto out_unlock;
>  =

> -	if (remaining < mptcp_add_addr_len(msk->pm.local.family))
> +	if (remaining < mptcp_add_addr_len(msk->pm.local.family)) {
> +		if (msk->pm.local.family =3D=3D AF_INET6)
> +			add_addr6 =3D true;
>  		goto out_unlock;
> +	}
>  =

>  	*saddr =3D msk->pm.local;
>  	*echo =3D READ_ONCE(msk->pm.add_addr_echo);
> @@ -193,6 +207,10 @@ bool mptcp_pm_add_addr_signal(struct mptcp_sock *msk=
, unsigned int remaining,
>  =

>  out_unlock:
>  	spin_unlock_bh(&msk->pm.lock);
> +
> +	if (add_addr6)
> +		mptcp_send_dedicated_ack(ssk);
> +
>  	return ret;
>  }
>  =

> diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
> index db1e5de2fee7..da662a436722 100644
> --- a/net/mptcp/protocol.h
> +++ b/net/mptcp/protocol.h
> @@ -468,7 +468,8 @@ static inline unsigned int mptcp_add_addr_len(int fam=
ily)
>  	return TCPOLEN_MPTCP_ADD_ADDR6;
>  }
>  =

> -bool mptcp_pm_add_addr_signal(struct mptcp_sock *msk, unsigned int remai=
ning,
> +bool mptcp_pm_add_addr_signal(struct mptcp_sock *msk, struct sock *sk,
> +			      unsigned int remaining,
>  			      struct mptcp_addr_info *saddr, bool *echo);
>  bool mptcp_pm_rm_addr_signal(struct mptcp_sock *msk, unsigned int remain=
ing,
>  			     u8 *rm_id);
> diff --git a/tools/testing/selftests/net/mptcp/mptcp_join.sh b/tools/test=
ing/selftests/net/mptcp/mptcp_join.sh
> index 08f53d86dedc..b37e63b04772 100755
> --- a/tools/testing/selftests/net/mptcp/mptcp_join.sh
> +++ b/tools/testing/selftests/net/mptcp/mptcp_join.sh
> @@ -126,6 +126,12 @@ do_ping()
>  	fi
>  }
>  =

> +# $1: IP address
> +is_v6()
> +{
> +	[ -z "${1##*:*}" ]
> +}
> +
>  do_transfer()
>  {
>  	listener_ns=3D"$1"
> @@ -165,7 +171,15 @@ do_transfer()
>  		mptcp_connect=3D"./mptcp_connect -r"
>  	fi
>  =

> -	ip netns exec ${listener_ns} $mptcp_connect -t $timeout -l -p $port -s =
${srv_proto} 0.0.0.0 < "$sin" > "$sout" &
> +	local local_addr
> +	if is_v6 "${connect_addr}"; then
> +		local_addr=3D"::"
> +		mptcp_connect=3D"./mptcp_connect -r"
> +	else
> +		local_addr=3D"0.0.0.0"
> +	fi
> +
> +	ip netns exec ${listener_ns} $mptcp_connect -t $timeout -l -p $port -s =
${srv_proto} ${local_addr} < "$sin" > "$sout" &
>  	spid=3D$!
>  =

>  	sleep 1
> @@ -491,6 +505,23 @@ run_tests $ns1 $ns2 10.0.1.1
>  chk_join_nr "multiple subflows and signal" 3 3 3
>  chk_add_nr 1 1
>  =

> +# subflow IPv6
> +reset
> +ip netns exec $ns1 ./pm_nl_ctl limits 0 1
> +ip netns exec $ns2 ./pm_nl_ctl limits 0 1
> +ip netns exec $ns2 ./pm_nl_ctl add dead:beef:3::2 flags subflow
> +run_tests $ns1 $ns2 dead:beef:1::1
> +chk_join_nr "single subflow IPv6" 1 1 1
> +
> +# signal address IPv6
> +reset
> +ip netns exec $ns1 ./pm_nl_ctl limits 0 1
> +ip netns exec $ns1 ./pm_nl_ctl add dead:beef:2::1 flags signal
> +ip netns exec $ns2 ./pm_nl_ctl limits 1 1
> +run_tests $ns1 $ns2 dead:beef:1::1
> +chk_join_nr "single address IPv6" 1 1 1
> +chk_add_nr 1 1

I think it would be nice testing even mixed scenarios: ipv4 msk with
ipv6 subflow[s] and vice versa (not sure if that would work ;)

Cheers,

Paolo

--===============9204652423087602615==--
