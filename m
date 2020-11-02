Content-Type: multipart/mixed; boundary="===============0034974732690745258=="
MIME-Version: 1.0
From: Paolo Abeni <pabeni at redhat.com>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: [PATCH net] mptcp: token: fix unititialized variable
Date: Mon, 02 Nov 2020 11:48:25 +0100
Message-ID: <97343b07772ae794ca2aad683734901c055aa0ab.camel@redhat.com>
In-Reply-To: 49e20da5d467a73414d4294a8bd35e2cb1befd49.1604308087.git.dcaratti@redhat.com
X-Status: 
X-Keywords:                  
X-UID: 6515

--===============0034974732690745258==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On Mon, 2020-11-02 at 10:09 +0100, Davide Caratti wrote:
> gcc complains about use of uninitialized 'num'. Fix it by doing the first
> assignment of 'num' when the variable is declared.
> =

> Fixes: 96d890daad05 ("mptcp: add msk interations helper")
> Signed-off-by: Davide Caratti <dcaratti(a)redhat.com>
> ---
>  net/mptcp/token.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> =

> diff --git a/net/mptcp/token.c b/net/mptcp/token.c
> index 8b47c4bb1c6b..feb4b9ffd462 100644
> --- a/net/mptcp/token.c
> +++ b/net/mptcp/token.c
> @@ -291,7 +291,7 @@ struct mptcp_sock *mptcp_token_iter_next(const struct=
 net *net, long *s_slot,
>  {
>  	struct mptcp_sock *ret =3D NULL;
>  	struct hlist_nulls_node *pos;
> -	int slot, num;
> +	int slot, num =3D 0;
>  =

>  	for (slot =3D *s_slot; slot <=3D token_mask; *s_num =3D 0, slot++) {
>  		struct token_bucket *bucket =3D &token_hash[slot];

LGTM, thanks Davide!

Acked-by: Paolo Abeni <pabeni(a)redhat.com>

--===============0034974732690745258==--
