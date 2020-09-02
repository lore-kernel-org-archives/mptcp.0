Content-Type: multipart/mixed; boundary="===============4750395581412481763=="
MIME-Version: 1.0
From: Paolo Abeni <pabeni at redhat.com>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: [PATCH mptcp-next] mptcp: use _fast lock version in
 __mptcp_move_skbs
Date: Wed, 02 Sep 2020 18:16:36 +0200
Message-ID: <cf777c2c14a091eca844228a44b31367a74e030f.camel@redhat.com>
In-Reply-To: 20200902143750.28478-1-fw@strlen.de
X-Status: 
X-Keywords:                  
X-UID: 5699

--===============4750395581412481763==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On Wed, 2020-09-02 at 16:37 +0200, Florian Westphal wrote:
> The function is short and won't sleep, so this can use the _fast version.
> =

> Signed-off-by: Florian Westphal <fw(a)strlen.de>
> ---
>  net/mptcp/protocol.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
> =

> diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
> index 3b621a99c8c5..0c2b506d17de 100644
> --- a/net/mptcp/protocol.c
> +++ b/net/mptcp/protocol.c
> @@ -1472,13 +1472,14 @@ static bool __mptcp_move_skbs(struct mptcp_sock *=
msk)
>  	__mptcp_flush_join_list(msk);
>  	do {
>  		struct sock *ssk =3D mptcp_subflow_recv_lookup(msk);
> +		bool slowpath;
>  =

>  		if (!ssk)
>  			break;
>  =

> -		lock_sock(ssk);
> +		slowpath =3D lock_sock_fast(ssk);
>  		done =3D __mptcp_move_skbs_from_subflow(msk, ssk, &moved);
> -		release_sock(ssk);
> +		unlock_sock_fast(ssk, slowpath);
>  	} while (!done);
>  =

>  	if (mptcp_ofo_queue(msk) || moved > 0) {

Good catch! the patch LGTM, thanks!

Do you think it could useful do the same also in mptcp_sendmsg()
and mptcp_worker()? (since mptcp_sendmsg_frag() does not sleep, should
be possible...)

Cheers,

Paolo

--===============4750395581412481763==--
