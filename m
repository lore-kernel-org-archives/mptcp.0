Content-Type: multipart/mixed; boundary="===============7735162681688800008=="
MIME-Version: 1.0
From: Mat Martineau <mathew.j.martineau at linux.intel.com>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: [PATCH] Squash-to: "subflow: introduce and use
 mptcp_can_accept_new_subflow()"
Date: Fri, 17 Jul 2020 10:38:22 -0700
Message-ID: <alpine.OSX.2.23.453.2007171037430.39222@kdpetti-mobl.amr.corp.intel.com>
In-Reply-To: 6ec124da60099420355e8d0c0cb9bfeea13e5774.1594999871.git.pabeni@redhat.com
X-Status: 
X-Keywords:                  
X-UID: 5084

--===============7735162681688800008==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable


On Fri, 17 Jul 2020, Paolo Abeni wrote:

> Use the newly introduced helper. No change to the commit message
> required.
>
> Signed-off-by: Paolo Abeni <pabeni(a)redhat.com>
> ---
> net/mptcp/subflow.c | 2 +-
> 1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/net/mptcp/subflow.c b/net/mptcp/subflow.c
> index edc29c2dec73..362637766d74 100644
> --- a/net/mptcp/subflow.c
> +++ b/net/mptcp/subflow.c
> @@ -55,7 +55,7 @@ static void subflow_generate_hmac(u64 key1, u64 key2, u=
32 nonce1, u32 nonce2,
>
> static bool mptcp_can_accept_new_subflow(const struct mptcp_sock *msk)
> {
> -	return inet_sk_state_load((struct sock *)msk) =3D=3D TCP_ESTABLISHED &&
> +	return mptcp_is_fully_established((void *)msk) &&
> 	       READ_ONCE(msk->pm.accept_subflow);
> }
>
> -- =

> 2.26.2

Looks good to squash after the previous patch is ready.

--
Mat Martineau
Intel
--===============7735162681688800008==--
