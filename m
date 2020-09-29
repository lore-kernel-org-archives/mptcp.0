Content-Type: multipart/mixed; boundary="===============6691430127427983419=="
MIME-Version: 1.0
From: Paolo Abeni <pabeni at redhat.com>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: [MPTCP][PATCH v3 mptcp-next 1/2] mptcp: add a new sysctl
 add_addr_timeout
Date: Tue, 29 Sep 2020 11:39:10 +0200
Message-ID: <66b7ac9a132b8ac20614ad1a240a0e11bc1c7de8.camel@redhat.com>
In-Reply-To: 7d8ea9c79622a115660b92d7030cdc0fce363fbc.1601275610.git.geliangtang@gmail.com
X-Status: 
X-Keywords:                  
X-UID: 6091

--===============6691430127427983419==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On Mon, 2020-09-28 at 14:51 +0800, Geliang Tang wrote:
> This patch added a new sysctl, named add_addr_timeout, to control the
> timeout value (in seconds) of the ADD_ADDR retransmission.
> =

> Signed-off-by: Geliang Tang <geliangtang(a)gmail.com>
> ---
>  net/mptcp/ctrl.c       | 14 ++++++++++++++
>  net/mptcp/pm_netlink.c |  8 ++++++--
>  net/mptcp/protocol.h   |  1 +
>  3 files changed, 21 insertions(+), 2 deletions(-)
> =

> diff --git a/net/mptcp/ctrl.c b/net/mptcp/ctrl.c
> index 54b888f94009..db185b198b53 100644
> --- a/net/mptcp/ctrl.c
> +++ b/net/mptcp/ctrl.c
> @@ -18,6 +18,7 @@ struct mptcp_pernet {
>  	struct ctl_table_header *ctl_table_hdr;
>  =

>  	int mptcp_enabled;
> +	u32 add_addr_timeout;
>  };
>  =

>  static struct mptcp_pernet *mptcp_get_pernet(struct net *net)
> @@ -30,6 +31,11 @@ int mptcp_is_enabled(struct net *net)
>  	return mptcp_get_pernet(net)->mptcp_enabled;
>  }
>  =

> +unsigned long mptcp_get_add_addr_timeout(struct net *net)
> +{
> +	return jiffies + mptcp_get_pernet(net)->add_addr_timeout * HZ;
> +}
> +
>  static struct ctl_table mptcp_sysctl_table[] =3D {
>  	{
>  		.procname =3D "enabled",
> @@ -40,12 +46,19 @@ static struct ctl_table mptcp_sysctl_table[] =3D {
>  		 */
>  		.proc_handler =3D proc_dointvec,
>  	},
> +	{
> +		.procname =3D "add_addr_timeout",
> +		.maxlen =3D sizeof(u32),
> +		.mode =3D 0644,
> +		.proc_handler =3D proc_douintvec,

If you use proc_dointvec_jiffies() you will not need any additional
conversion (*HZ or /HZ ) in the fast-path.

> +	},
>  	{}
>  };
>  =

>  static void mptcp_pernet_set_defaults(struct mptcp_pernet *pernet)
>  {
>  	pernet->mptcp_enabled =3D 1;
> +	pernet->add_addr_timeout =3D TCP_RTO_MAX / HZ;
>  }
>  =

>  static int mptcp_pernet_new_table(struct net *net, struct
> mptcp_pernet *pernet)
> @@ -61,6 +74,7 @@ static int mptcp_pernet_new_table(struct net *net,
> struct mptcp_pernet *pernet)
>  	}
>  =

>  	table[0].data =3D &pernet->mptcp_enabled;
> +	table[1].data =3D &pernet->add_addr_timeout;
>  =

>  	hdr =3D register_net_sysctl(net, MPTCP_SYSCTL_PATH, table);
>  	if (!hdr)
> diff --git a/net/mptcp/pm_netlink.c b/net/mptcp/pm_netlink.c
> index 5a0e4d11bcc3..d5fef101b67f 100644
> --- a/net/mptcp/pm_netlink.c
> +++ b/net/mptcp/pm_netlink.c
> @@ -206,6 +206,8 @@ static void mptcp_pm_add_timer(struct timer_list
> *timer)
>  	struct mptcp_pm_add_entry *entry =3D from_timer(entry, timer,
> add_timer);
>  	struct mptcp_sock *msk =3D entry->sock;
>  	struct sock *sk =3D (struct sock *)msk;
> +	struct net *net =3D sock_net(sk);
> +	unsigned long timeout =3D mptcp_get_add_addr_timeout(net);

Small nit: this breaks the reverse x-mas tree order, please move the
initialization (or you can simply get rid of the local variable)

There is a similar issue below in mptcp_pm_alloc_anno_list()

/P

--===============6691430127427983419==--
