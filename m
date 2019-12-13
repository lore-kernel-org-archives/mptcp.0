Content-Type: multipart/mixed; boundary="===============7495261782529699666=="
MIME-Version: 1.0
From: Paolo Abeni <pabeni at redhat.com>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: [PATCH] squash-to: "mptcp: recvmsg() can drain data from
 multiple subflows"
Date: Fri, 13 Dec 2019 17:09:31 +0100
Message-ID: <d50f8857482214fbc7515e7756e06715931edcc0.camel@redhat.com>
In-Reply-To: 6d836e5d6b44489f59f9dedfe7743c4b2b6f08d5.1576252967.git.dcaratti@redhat.com
X-Status: 
X-Keywords:                  
X-UID: 2954

--===============7495261782529699666==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On Fri, 2019-12-13 at 17:05 +0100, Davide Caratti wrote:
> checkpatch fixes
> =

> Signed-off-by: Davide Caratti <dcaratti(a)redhat.com>
> ---
>  net/mptcp/protocol.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> =

> diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
> index b9eed120913f..fd89075bd1c9 100644
> --- a/net/mptcp/protocol.c
> +++ b/net/mptcp/protocol.c
> @@ -359,7 +359,8 @@ static int mptcp_recvmsg(struct sock *sk, struct msgh=
dr *msg, size_t len,
>  			desc.count =3D min_t(size_t, len - copied, map_remaining);
>  			pr_debug("reading %zu bytes, copied %d", desc.count,
>  				 copied);
> -			bytes_read =3D tcp_read_sock(ssk, &desc, mptcp_read_actor);
> +			bytes_read =3D tcp_read_sock(ssk, &desc,
> +						   mptcp_read_actor);
>  			if (bytes_read < 0) {
>  				if (!copied)
>  					copied =3D bytes_read;

ACK

--===============7495261782529699666==--
