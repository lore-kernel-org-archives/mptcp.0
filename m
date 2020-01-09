Content-Type: multipart/mixed; boundary="===============5372578605782509712=="
MIME-Version: 1.0
From: Mat Martineau <mathew.j.martineau at linux.intel.com>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: [PATCH v1 4/7] Squash-to: "mptcp: Write MPTCP DSS headers
 to outgoing data packets"
Date: Wed, 08 Jan 2020 16:28:10 -0800
Message-ID: <alpine.OSX.2.21.2001081627070.27921@fepiepan-mobl.amr.corp.intel.com>
In-Reply-To: cd0f7bfec9008860447b9d26c39bd3442b6bfd50.1578487811.git.pabeni@redhat.com
X-Status: 
X-Keywords:                  
X-UID: 3300

--===============5372578605782509712==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On Wed, 8 Jan 2020, Paolo Abeni wrote:

> use 'is_tcp' to check for TCP fallback instead of mp_capable (and later
> mp_join).
>
> Suggested-by: Mat Martineau <mathew.j.martineau(a)linux.intel.com>
> Signed-off-by: Paolo Abeni <pabeni(a)redhat.com>
> ---
> net/mptcp/options.c | 2 +-
> 1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/net/mptcp/options.c b/net/mptcp/options.c
> index c9b5f37db63b..25a46420b06d 100644
> --- a/net/mptcp/options.c
> +++ b/net/mptcp/options.c
> @@ -303,7 +303,7 @@ bool mptcp_established_options(struct sock *sk, struc=
t sk_buff *skb,
> 	unsigned int opt_size =3D 0;
> 	bool ret =3D false;
>
> -	if (!mptcp_subflow_ctx(sk)->mp_capable)
> +	if (!tcp_sk(sk)->is_mptcp)
> 		return false;

is_mptcp is already checked by the caller (tcp_established_options()) - =

maybe better to just delete this check?

>
> 	if (mptcp_established_options_mp(sk, &opt_size, remaining, opts))
> -- =

> 2.21.0

--
Mat Martineau
Intel
--===============5372578605782509712==--
