Content-Type: multipart/mixed; boundary="===============6995669624461033907=="
MIME-Version: 1.0
From: Paolo Abeni <pabeni at redhat.com>
To: mptcp at lists.01.org
Subject: Re: [MPTCP] [RFC] mptcp: Implement interim path manager
Date: Mon, 26 Aug 2019 17:20:28 +0200
Message-ID: <73e8a5be4a72c404d0d2b956c361f0743594face.camel@redhat.com>
In-Reply-To: 20190807225443.3051-1-peter.krystad@linux.intel.com
X-Status: 
X-Keywords:                  
X-UID: 1709

--===============6995669624461033907==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On Wed, 2019-08-07 at 15:54 -0700, Peter Krystad wrote:
> @@ -91,16 +95,32 @@ int pm_remove_subflow(u32 token, u8 remote_id)
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
> +		INIT_WORK(&pm->addr_work, announce_addr_worker);
> +		queue_work(mptcp_wq, &pm->addr_work);

I think that here we need to acquire a reference to the related msk
socket, or we can get use-after-free depending on socket shutdown and
workqueue scheduling.

Such reference should be releases by the worker itself.

Other workqueue usage below should need a similar change.

Cheers,

Paolo


--===============6995669624461033907==--
