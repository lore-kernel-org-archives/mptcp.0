Content-Type: multipart/mixed; boundary="===============2324593250680375923=="
MIME-Version: 1.0
From: Mat Martineau <mathew.j.martineau at linux.intel.com>
To: mptcp at lists.01.org
Subject: Re: [MPTCP] [PATCH 2/2] mptcp: Modify pm_create_subflow to use
 in_addr in network byte order
Date: Tue, 27 Aug 2019 11:37:51 -0700
Message-ID: <alpine.OSX.2.21.1908271137300.10328@aaggar2-mobl.amr.corp.intel.com>
In-Reply-To: 20190824015633.3070-2-peter.krystad@linux.intel.com
X-Status: 
X-Keywords:                  
X-UID: 1723

--===============2324593250680375923==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable


On Fri, 23 Aug 2019, Peter Krystad wrote:

> squashto: Implement path manager interface commands
>
> Signed-off-by: Peter Krystad <peter.krystad(a)linux.intel.com>
> ---
> net/mptcp/pm.c | 2 +-
> 1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/net/mptcp/pm.c b/net/mptcp/pm.c
> index c98b92512adf..bc07376a823b 100644
> --- a/net/mptcp/pm.c
> +++ b/net/mptcp/pm.c
> @@ -73,7 +73,7 @@ int pm_create_subflow(u32 token, u8 remote_id)
>
> 	remote.sin_family =3D msk->pm.remote_family;
> 	remote.sin_port =3D htons(msk->dport);
> -	remote.sin_addr.s_addr =3D htonl(msk->pm.remote_addr.s_addr);
> +	remote.sin_addr.s_addr =3D msk->pm.remote_addr.s_addr;
>
> 	err =3D subflow_connect((struct sock *)msk, &local, &remote, remote_id);
>
> -- =

> 2.17.2

Both patches look good. Thanks.

--
Mat Martineau
Intel

--===============2324593250680375923==--
