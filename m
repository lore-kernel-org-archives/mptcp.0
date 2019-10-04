Content-Type: multipart/mixed; boundary="===============3514781417713824984=="
MIME-Version: 1.0
From: Mat Martineau <mathew.j.martineau at linux.intel.com>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: [PATCH mptcp] options: copy entire extension area to
 option struct
Date: Fri, 04 Oct 2019 15:46:36 -0700
Message-ID: <alpine.OSX.2.21.1910041545330.58686@syitbare-mobl.amr.corp.intel.com>
In-Reply-To: 20191004112124.20726-1-fw@strlen.de
X-Status: 
X-Keywords:                  
X-UID: 2019

--===============3514781417713824984==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable


On Fri, 4 Oct 2019, Florian Westphal wrote:

> No reason to copy each member individually, just copy everything.
> This means we will also copy ext->data_fin which was not done before.

Looks good to me. I think the missing data_fin copy was a bug.

Mat


>
> squashto: "mptcp: Write MPTCP DSS headers to outgoing data packets"
>
> Signed-off-by: Florian Westphal <fw(a)strlen.de>
> ---
> net/mptcp/options.c | 9 ++-------
> 1 file changed, 2 insertions(+), 7 deletions(-)
>
> diff --git a/net/mptcp/options.c b/net/mptcp/options.c
> index a33c202db009..d00e86550d8b 100644
> --- a/net/mptcp/options.c
> +++ b/net/mptcp/options.c
> @@ -402,13 +402,8 @@ static bool mptcp_established_options_dss(struct soc=
k *sk, struct sk_buff *skb,
> 		if (map_size <=3D remaining) {
> 			remaining -=3D map_size;
> 			dss_size =3D map_size;
> -			if (mpext) {
> -				opts->ext_copy.data_seq =3D mpext->data_seq;
> -				opts->ext_copy.subflow_seq =3D mpext->subflow_seq;
> -				opts->ext_copy.data_len =3D mpext->data_len;
> -				opts->ext_copy.use_map =3D 1;
> -				opts->ext_copy.dsn64 =3D mpext->dsn64;
> -			}
> +			if (mpext)
> +				opts->ext_copy =3D *mpext;
> 		} else {
> 			opts->ext_copy.use_map =3D 0;
> 			WARN_ONCE(1, "MPTCP: Map dropped");
> -- =

> 2.21.0
> _______________________________________________
> mptcp mailing list -- mptcp(a)lists.01.org
> To unsubscribe send an email to mptcp-leave(a)lists.01.org
>

--
Mat Martineau
Intel
--===============3514781417713824984==--
