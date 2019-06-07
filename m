Content-Type: multipart/mixed; boundary="===============7246345604440242657=="
MIME-Version: 1.0
From: Matthieu Baerts <matthieu.baerts at tessares.net>
To: mptcp at lists.01.org
Subject: Re: [MPTCP] [PATCH 4/7] mptcp: reduce number of pr_debug() calls.
Date: Fri, 07 Jun 2019 13:23:20 +0200
Message-ID: <b121b0f2-48b8-d739-09f3-d85e18bec65c@tessares.net>
In-Reply-To: 20190606003632.2863-5-peter.krystad@linux.intel.com
X-Status: 
X-Keywords:                  
X-UID: 1310

--===============7246345604440242657==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Peter, Paolo,

On 06/06/2019 02:36, Peter Krystad wrote:
> squash to: Implement MPTCP receive path

Thank you for the patch and the review!

- e2fd582aa5c1: "squash" in "mptcp: Implement MPTCP receive path": I
also added a diff from the previous patch (3/7), see below
- c1873d1e4ed6: signed-off
- 5d1039667868: "squash" (part 2) in "mptcp: accept: don't leak mptcp
socket structure"
- c4df6da5e7d3: conflict
- a9c9e1105ce0: conflict
- a053cbcf3dd5: conflict
- eec1d25d9283..612e3f6c26e6: result

> Signed-off-by: Peter Krystad <peter.krystad(a)linux.intel.com>
> ---
>  net/mptcp/protocol.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> =

> diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
> index 78ce42b1617a..11b6855cc9ed 100644
> --- a/net/mptcp/protocol.c
> +++ b/net/mptcp/protocol.c

I also added this block from patch 3/7:

@@ -623,7 +621,6 @@ static struct sock *mptcp_accept(struct sock *sk,
int flags, int *err,
 		msk->remote_key =3D subflow->remote_key;
 		msk->local_key =3D subflow->local_key;
 		msk->token =3D subflow->token;
-		pr_debug("token=3D%u", msk->token);
 		token_update_accept(new_sock->sk, new_mptcp_sock);
 		msk->subflow =3D NULL;

Cheers,
Matt

> @@ -747,7 +747,7 @@ void mptcp_finish_connect(struct sock *sk, int mp_cap=
able)
>  		msk->remote_key =3D subflow->remote_key;
>  		msk->local_key =3D subflow->local_key;
>  		msk->token =3D subflow->token;
> -		pr_debug("token=3D%u", msk->token);
> +		pr_debug("msk=3D%p, token=3D%u", msk, msk->token);
>  =

>  		crypto_key_sha1(msk->remote_key, NULL, &ack_seq);
>  		msk->write_seq =3D subflow->idsn + 1;
> =


-- =

Matthieu Baerts | R&D Engineer
matthieu.baerts(a)tessares.net
Tessares SA | Hybrid Access Solutions
www.tessares.net
1 Avenue Jean Monnet, 1348 Louvain-la-Neuve, Belgium

--===============7246345604440242657==--
