Content-Type: multipart/mixed; boundary="===============2679108834129672796=="
MIME-Version: 1.0
From: Paolo Abeni <pabeni at redhat.com>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: [MPTCP][PATCH v6 mptcp-next 5/9] mptcp: add port number
 announced check
Date: Wed, 25 Nov 2020 10:54:02 +0100
Message-ID: <e13e47c7e041e577598101df70bd7e64e789b61e.camel@redhat.com>
In-Reply-To: c61d4b901a34c788dec44b264f2bc669ddb57d2c.1606272852.git.geliangtang@gmail.com
X-Status: 
X-Keywords:                  
X-UID: 6922

--===============2679108834129672796==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On Wed, 2020-11-25 at 11:01 +0800, Geliang Tang wrote:
> When we received the MP_JOIN's SYN/ACK, we do the port number checks. If
> the subflow's source port number is different, we use a new helper
> mptcp_pm_sport_in_anno_list to check whether this port number is announce=
d.
> If it isn't, we need to abort this connection.
> =

> Signed-off-by: Geliang Tang <geliangtang(a)gmail.com>
> ---
>  net/mptcp/pm_netlink.c | 18 ++++++++++++++++++
>  net/mptcp/protocol.h   |  1 +
>  net/mptcp/subflow.c    |  6 ++++++
>  3 files changed, 25 insertions(+)
> =

> diff --git a/net/mptcp/pm_netlink.c b/net/mptcp/pm_netlink.c
> index 2b4e7b077bc9..b0f182053168 100644
> --- a/net/mptcp/pm_netlink.c
> +++ b/net/mptcp/pm_netlink.c
> @@ -202,6 +202,24 @@ lookup_anno_list_by_saddr(struct mptcp_sock *msk,
>  	return NULL;
>  }
>  =

> +bool mptcp_pm_sport_in_anno_list(struct mptcp_sock *msk, const struct so=
ck *sk)
> +{
> +	struct mptcp_pm_add_entry *entry;
> +	bool ret =3D false;
> +
> +	spin_lock_bh(&msk->pm.lock);
> +	list_for_each_entry(entry, &msk->pm.anno_list, list) {
> +		if (entry->addr.port =3D=3D inet_sk(sk)->inet_sport) {
> +			ret =3D true;
> +			goto out;
> +		}
> +	}
> +
> +out:
> +	spin_unlock_bh(&msk->pm.lock);
> +	return ret;
> +}
> +
>  static void mptcp_pm_add_timer(struct timer_list *timer)
>  {
>  	struct mptcp_pm_add_entry *entry =3D from_timer(entry, timer, add_timer=
);
> diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
> index adf5944ec5c4..209cd7690686 100644
> --- a/net/mptcp/protocol.h
> +++ b/net/mptcp/protocol.h
> @@ -551,6 +551,7 @@ void mptcp_pm_add_addr_received(struct mptcp_sock *ms=
k,
>  void mptcp_pm_add_addr_send_ack(struct mptcp_sock *msk);
>  void mptcp_pm_rm_addr_received(struct mptcp_sock *msk, u8 rm_id);
>  void mptcp_pm_free_anno_list(struct mptcp_sock *msk);
> +bool mptcp_pm_sport_in_anno_list(struct mptcp_sock *msk, const struct so=
ck *sk);
>  struct mptcp_pm_add_entry *
>  mptcp_pm_del_add_timer(struct mptcp_sock *msk,
>  		       struct mptcp_addr_info *addr);
> diff --git a/net/mptcp/subflow.c b/net/mptcp/subflow.c
> index 233ec36aa704..cb72327c006a 100644
> --- a/net/mptcp/subflow.c
> +++ b/net/mptcp/subflow.c
> @@ -192,6 +192,10 @@ static void subflow_init_req(struct request_sock *re=
q,
>  			pr_debug("syn inet_sport=3D%d %d",
>  				 ntohs(inet_sk(sk_listener)->inet_sport),
>  				 ntohs(inet_sk((struct sock *)subflow_req->msk)->inet_sport));
> +			if (!mptcp_pm_sport_in_anno_list(subflow_req->msk, sk_listener)) {
> +				subflow_req->mp_join =3D 0;

Is this enough to cause - later - reset for this request socket?

I *think* we should do this test earlier - before the syncookie check,
and ev. clear subflow_req->msk in case of failure -> so that the
syncookie will not be created.

Additionally, in subflow_syn_recv_sock(), after options parsing, we
should check for NULL subflow_req->msk and eventually fallback.
Inverting the order of the existing mptcp_can_accept_new_subflow() and
subflow_hmac_valid() checks should suffice.

Note: I think this later change is actually an independed bug fix, I
fear a peer sending an MP_JOIN with an invalid token will get back an
MPJ_SYNACK, while the subflow_req->msk will be cleared. Later
in subflow_syn_recv_sock(), we will probably get a NULL ptr dereference
in mptcp_can_accept_new_subflow().

@Davide: can we somehow easily check the above with a packet drill?

Thanks!

/P

--===============2679108834129672796==--
