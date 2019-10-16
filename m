Content-Type: multipart/mixed; boundary="===============4048919690598337215=="
MIME-Version: 1.0
From: Paolo Abeni <pabeni at redhat.com>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: [PATCH 4/5] mptcp: Update path manager interface commands
 for IPv6
Date: Wed, 16 Oct 2019 13:00:02 +0200
Message-ID: <d3b22d9c8150a03a4b29d13e47d3b353cc1ddc41.camel@redhat.com>
In-Reply-To: 20191015230613.16981-5-peter.krystad@linux.intel.com
X-Status: 
X-Keywords:                  
X-UID: 2170

--===============4048919690598337215==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi,

On Tue, 2019-10-15 at 16:06 -0700, Peter Krystad wrote:
> squashto: Implement path manager interface commands
> =

> Signed-off-by: Peter Krystad <peter.krystad(a)linux.intel.com>
> ---
>  net/mptcp/pm.c | 75 ++++++++++++++++++++++++++++++++++++++++++--------
>  1 file changed, 64 insertions(+), 11 deletions(-)
> =

> diff --git a/net/mptcp/pm.c b/net/mptcp/pm.c
> index bc46a0ddd396..b14308ad11a3 100644
> --- a/net/mptcp/pm.c
> +++ b/net/mptcp/pm.c
> @@ -23,11 +23,11 @@ int mptcp_pm_announce_addr(u32 token, u8 local_id, st=
ruct in_addr *addr)
>  		goto announce_put;
>  	}
>  =

> -	pr_debug("msk=3D%p, local_id=3D%d, addr=3D%x", msk, local_id, addr->s_a=
ddr);
> +	pr_debug("msk=3D%p, local_id=3D%d", msk, local_id);
>  	msk->pm.local_valid =3D 1;
>  	msk->pm.local_id =3D local_id;
> -	msk->pm.local_family =3D family;
> -	msk->pm.local_addr.s_addr =3D addr->s_addr;
> +	msk->pm.local_family =3D AF_INET;
> +	msk->pm.local_addr =3D *addr;
>  	msk->addr_signal =3D 1;

I think a part of the above chunk belong to patch 1/5. Specifically:
 =

-	msk->pm.local_family =3D family;
+	msk->pm.local_family =3D AF_INET;

I think it should be squashed into "mptcp: Add path manager interface",
otherwise the build will break, as mptcp_pm_announce_addr() lacks the
'family' argument after applying 1/5

Otherwise looks good to me, thanks!

Paolo

--===============4048919690598337215==--
