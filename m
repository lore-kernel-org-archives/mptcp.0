Content-Type: multipart/mixed; boundary="===============6200921298955317235=="
MIME-Version: 1.0
From: Paolo Abeni <pabeni at redhat.com>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: [MPTCP][PATCH v2 mptcp-next 3/4] mptcp: add the RM_ADDR
 option parsing
Date: Wed, 22 Jul 2020 12:41:47 +0200
Message-ID: <cff743760f2c425253dc53e2e6299139a2e5c5ac.camel@redhat.com>
In-Reply-To: 5236563860251c88b7f7b723f1515ef9b13d56b4.1595407078.git.geliangtang@gmail.com
X-Status: 
X-Keywords:                  
X-UID: 5175

--===============6200921298955317235==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On Wed, 2020-07-22 at 16:42 +0800, Geliang Tang wrote:
> This patch added the RM_ADDR option parsing logic.

It would be nice if you could elaborate a bit the commit message,
briefly describing how the RM_ADDR options are now handled (e.g.
subflows matching the addr id are closed, and pm counter updated).

> Suggested-by: Matthieu Baerts <matthieu.baerts(a)tessares.net>
> Suggested-by: Paolo Abeni <pabeni(a)redhat.com>
> Signed-off-by: Geliang Tang <geliangtang(a)gmail.com>
> ---
>  net/mptcp/options.c    |  5 +++++
>  net/mptcp/pm.c         | 12 ++++++++++++
>  net/mptcp/pm_netlink.c | 20 ++++++++++++++++++++
>  net/mptcp/protocol.c   |  8 ++++++--
>  net/mptcp/protocol.h   |  5 +++++
>  net/mptcp/subflow.c    |  1 +
>  6 files changed, 49 insertions(+), 2 deletions(-)
> =

> diff --git a/net/mptcp/options.c b/net/mptcp/options.c
> index 38685e0e06db..b9e6e67ed195 100644
> --- a/net/mptcp/options.c
> +++ b/net/mptcp/options.c
> @@ -875,6 +875,11 @@ void mptcp_incoming_options(struct sock *sk, struct =
sk_buff *skb,
>  		mp_opt.add_addr =3D 0;
>  	}
>  =

> +	if (mp_opt.rm_addr) {
> +		mptcp_pm_rm_addr_received(msk, mp_opt.rm_id);
> +		mp_opt.rm_addr =3D 0;
> +	}
> +
>  	if (!mp_opt.dss)
>  		return;
>  =

> diff --git a/net/mptcp/pm.c b/net/mptcp/pm.c
> index 91b74ca47fa1..84fad1fec28b 100644
> --- a/net/mptcp/pm.c
> +++ b/net/mptcp/pm.c
> @@ -149,6 +149,18 @@ void mptcp_pm_add_addr_received(struct mptcp_sock *m=
sk,
>  	spin_unlock_bh(&pm->lock);
>  }
>  =

> +void mptcp_pm_rm_addr_received(struct mptcp_sock *msk, u8 rm_id)
> +{
> +	struct mptcp_pm_data *pm =3D &msk->pm;
> +
> +	pr_debug("msk=3D%p remote_id=3D%d", msk, rm_id);
> +
> +	spin_lock_bh(&pm->lock);
> +	mptcp_pm_schedule_work(msk, MPTCP_PM_RM_ADDR_RECEIVED);
> +	pm->rm_id =3D rm_id;
> +	spin_unlock_bh(&pm->lock);
> +}
> +
>  /* path manager helpers */
>  =

>  bool mptcp_pm_add_addr_signal(struct mptcp_sock *msk, unsigned int remai=
ning,
> diff --git a/net/mptcp/pm_netlink.c b/net/mptcp/pm_netlink.c
> index c8820c4156e6..2ee7227f5f2b 100644
> --- a/net/mptcp/pm_netlink.c
> +++ b/net/mptcp/pm_netlink.c
> @@ -261,6 +261,26 @@ void mptcp_pm_nl_add_addr_received(struct mptcp_sock=
 *msk)
>  	spin_lock_bh(&msk->pm.lock);
>  }
>  =

> +void mptcp_pm_nl_rm_addr_received(struct mptcp_sock *msk)
> +{
> +	struct mptcp_subflow_context *subflow, *tmp;
> +
> +	pr_debug("remote_id %d", msk->pm.rm_id);
> +
> +	msk->pm.add_addr_accepted--;
> +	msk->pm.subflows--;
> +	WRITE_ONCE(msk->pm.accept_addr, true);
> +
> +	list_for_each_entry_safe(subflow, tmp, &msk->conn_list, node) {
> +		struct sock *tcp_sk =3D mptcp_subflow_tcp_sock(subflow);
> +
> +		if (msk->pm.rm_id =3D=3D subflow->remote_id) {
> +			mptcp_subflow_shutdown(tcp_sk, 1, 1, msk->write_seq);

the 2nd argument for mptcp_subflow_shutdown() should be something alike
'RCV_SHUTDOWN|SEND_SHUTDOWN' - we are closing the subflow in both
direction - and the third argument '0' - the msk will remain
open/established.

I think here the subflow socket will be leaked. Can you please double
check that with a CONFIG_DEBUG_KMEMLEAK enabled build?

Likely something alike what __mptcp_close_ssk() is currently doing
should be added here, but that will not fit nicely with a proper
shutdown, so I'm unsure how to address this correctly.

> +			list_del(&subflow->node);
> +		}
> +	}
> +}

[...]

> diff --git a/net/mptcp/subflow.c b/net/mptcp/subflow.c
> index 519122e66f17..2864b8d20dbd 100644
> --- a/net/mptcp/subflow.c
> +++ b/net/mptcp/subflow.c
> @@ -990,6 +990,7 @@ int __mptcp_subflow_connect(struct sock *sk, int ifin=
dex,
>  	subflow->remote_key =3D msk->remote_key;
>  	subflow->local_key =3D msk->local_key;
>  	subflow->token =3D msk->token;
> +	subflow->remote_id =3D remote->id;
>  	mptcp_info2sockaddr(loc, &addr);

Whoops... this chunk looks like fixing a long standing bug, thanks!
 =

>  	addrlen =3D sizeof(struct sockaddr_in);

/P

--===============6200921298955317235==--
