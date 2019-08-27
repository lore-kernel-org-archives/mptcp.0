Content-Type: multipart/mixed; boundary="===============6936348274008590710=="
MIME-Version: 1.0
From: Mat Martineau <mathew.j.martineau at linux.intel.com>
To: mptcp at lists.01.org
Subject: Re: [MPTCP] [PATCH] mptcp: remove msk->subflow->sk dereference in
 pr_debug statement
Date: Tue, 27 Aug 2019 11:09:36 -0700
Message-ID: <alpine.OSX.2.21.1908271108420.10328@aaggar2-mobl.amr.corp.intel.com>
In-Reply-To: 20190822184110.2456-1-peter.krystad@linux.intel.com
X-Status: 
X-Keywords:                  
X-UID: 1722

--===============6936348274008590710==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable


On Thu, 22 Aug 2019, Peter Krystad wrote:

> msk->subflow may be NULL when creation of an mptcp_sock fails due
> to the protocol not being enabled.
>
> squashto: Add key generation and token tree
>
> Signed-off-by: Peter Krystad <peter.krystad(a)linux.intel.com>
> ---
> net/mptcp/protocol.c | 2 +-
> 1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
> index aaa71b161c1a..a58211d8568c 100644
> --- a/net/mptcp/protocol.c
> +++ b/net/mptcp/protocol.c
> @@ -702,7 +702,7 @@ static void mptcp_destroy(struct sock *sk)
> {
> 	struct mptcp_sock *msk =3D mptcp_sk(sk);
>
> -	pr_debug("msk=3D%p, subflow=3D%p", sk, msk->subflow->sk);
> +	pr_debug("msk=3D%p", sk);
>
> 	token_destroy(msk->token);
> }
> -- =

> 2.17.2
>

Looks good to merge, thanks for the fix.

--
Mat Martineau
Intel

--===============6936348274008590710==--
