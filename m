Content-Type: multipart/mixed; boundary="===============1965671747851136272=="
MIME-Version: 1.0
From: Paolo Abeni <pabeni at redhat.com>
To: mptcp at lists.01.org
Subject: Re: [MPTCP] [PATCH v2] mptcp: Implement interim path manager
Date: Wed, 28 Aug 2019 10:18:54 +0200
Message-ID: <7b26de17efcbb57a0bccb49f8497b1ab61f000ad.camel@redhat.com>
In-Reply-To: 20190827202328.2787-1-peter.krystad@linux.intel.com
X-Status: 
X-Keywords:                  
X-UID: 1733

--===============1965671747851136272==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Peter,

On Tue, 2019-08-27 at 13:23 -0700, Peter Krystad wrote:
> Two features: 1) When an incoming connection is received
> announce a local address and 2) When an outgoing connection
> is fully established and a remote address has been received
> initiate a secondary subflow.
> =

> The second local address must be hard-coded for now.
> =

> v2: take a reference on the mptcp_sock while work is queued.
> =

> Signed-off-by: Peter Krystad <peter.krystad(a)linux.intel.com>
> ---
>  net/mptcp/pm.c | 64 ++++++++++++++++++++++++++++++++++++++++++++++----
>  1 file changed, 60 insertions(+), 4 deletions(-)
> =

> diff --git a/net/mptcp/pm.c b/net/mptcp/pm.c
> index bc07376a823b..449351921c0e 100644
> --- a/net/mptcp/pm.c
> +++ b/net/mptcp/pm.c
> @@ -8,6 +8,10 @@
>  #include <net/mptcp.h>
>  #include "protocol.h"
>  =

> +struct workqueue_struct *mptcp_wq;
> +static void announce_addr_worker(struct work_struct *work);
> +static void create_subflow_worker(struct work_struct *work);
> +
>  /* path manager command handlers */
>  =

>  int pm_announce_addr(u32 token, sa_family_t family, u8 local_id,
> @@ -91,16 +95,34 @@ int pm_remove_subflow(u32 token, u8 remote_id)
>  =

>  void pm_new_connection(struct mptcp_sock *msk, int server_side)
>  {
> -	pr_debug("msk=3D%p", msk);
> +	struct mptcp_pm_data *pm =3D &msk->pm;
> +
> +	pr_debug("msk=3D%p, token=3D%u", msk, msk->token);
>  =

> -	msk->pm.server_side =3D server_side;
> +	pm->server_side =3D server_side;
> +	pm->token =3D msk->token;
> +
> +	/* trigger announce address in interim local path manager */
> +	if (pm->server_side) {
> +		sock_hold((struct sock *)msk);
> +		INIT_WORK(&pm->addr_work, announce_addr_worker);
> +		queue_work(mptcp_wq, &pm->addr_work);

I'm sorry to keep adding things, I missed some details when I did my
previous comment.

It looks like the above code is called with only ssk lock held. =


To be safe in case of multiple subflows, we would need some additional
locking (e.g. a pm-level spinlock) and perhaps something alike:

	if (queue_work(...))
		sock_hold(...)

If there is agreement, I think we can take the patch as is, and then
clean it up with incremental changes - we would touch it anyway to add
the sysctl interface.

Paolo


--===============1965671747851136272==--
