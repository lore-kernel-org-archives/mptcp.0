Content-Type: multipart/mixed; boundary="===============3817492169517807164=="
MIME-Version: 1.0
From: Paolo Abeni <pabeni at redhat.com>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: [PATCH mptcp-net-next] mptcp: fix pending data accounting
Date: Mon, 14 Dec 2020 12:02:06 +0100
Message-ID: <eb7e5a537bb8e30b73cc8cce52e8bccf6742d020.camel@redhat.com>
In-Reply-To: 108f55ac02616f6ace048488ba4f8456864b7b8c.1607704258.git.pabeni@redhat.com
X-Status: 
X-Keywords:                  
X-UID: 7164

--===============3817492169517807164==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On Fri, 2020-12-11 at 17:32 +0100, Paolo Abeni wrote:
> When sendmsg() needs to wait for memory, the pending data
> is not updated. That causes a drift in forward memory allocation,
> leading to stall and/or warnings at socket close time.
> =

> This change addresses the above issue moving the pending data
> counter update inside the sendmsg() main loop.
> =

> Fixes: 6e628cd3a8f7 ("mptcp: use mptcp release_cb for delayed tasks")
> Signed-off-by: Paolo Abeni <pabeni(a)redhat.com>
> ---
> note:
> - will target -net, should net-next close meanwhile
> - this possibly fixes issues/115
> ---
>  net/mptcp/protocol.c | 5 ++---
>  1 file changed, 2 insertions(+), 3 deletions(-)
> =

> diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
> index 670d49825499..349134622077 100644
> --- a/net/mptcp/protocol.c
> +++ b/net/mptcp/protocol.c
> @@ -1658,6 +1658,7 @@ static int mptcp_sendmsg(struct sock *sk, struct ms=
ghdr *msg, size_t len)
>  		frag_truesize +=3D psize;
>  		pfrag->offset +=3D frag_truesize;
>  		WRITE_ONCE(msk->write_seq, msk->write_seq + psize);
> +		msk->tx_pending_data +=3D copied;

whoops, this is grossly broken :( should be:

	msk->tx_pending_data +=3D psize.

I'll send a v2 soon.

/P

--===============3817492169517807164==--
