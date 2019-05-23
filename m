Content-Type: multipart/mixed; boundary="===============0930964545812431727=="
MIME-Version: 1.0
From: Paolo Abeni <pabeni at redhat.com>
To: mptcp at lists.01.org
Subject: Re: [MPTCP] [PATCH v2 mptcp] mptcp: switch sublist to mptcp socket
 lock protection
Date: Thu, 23 May 2019 19:20:31 +0200
Message-ID: <77df80d334f48ec7cc44239a6fbbea15cd2b5675.camel@redhat.com>
In-Reply-To: 20190522100424.20249-1-fw@strlen.de
X-Status: 
X-Keywords:                  
X-UID: 1235

--===============0930964545812431727==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On Wed, 2019-05-22 at 12:04 +0200, Florian Westphal wrote:
> diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
> index 9a98c8e0c996..27f09ee9eaf1 100644
> --- a/net/mptcp/protocol.c
> +++ b/net/mptcp/protocol.c

[...]

> @@ -765,14 +751,34 @@ void mptcp_finish_connect(struct sock *sk, int mp_c=
apable)
>  	if (mp_capable) {
>  		u64 ack_seq;
>  =

> +		/* sk (new subflow socket) is already locked, but we need
> +		 * to lock the parent (mptcp) socket now to add the tcp socket
> +		 * to the subflow list.
> +		 *
> +		 * From lockdep point of view, this creates an ABBA type
> +		 * deadlock: Normally (sendmsg, recvmsg, ..), we lock the mptcp
> +		 * socket, then acquire a subflow lock.
> +		 * Here we do the reverse: "subflow lock, then mptcp lock".
> +		 *
> +		 * Its alright to do this here, because this subflow is not yet
> +		 * on the mptcp sockets subflow list.
> +		 *
> +		 * IOW, if another CPU has this mptcp socket locked, it cannot
> +		 * acquire this particular subflow, because subflow->sk isn't
> +		 * on msk->conn_list.
> +		 */
> +		lock_sock_nested(sk, SINGLE_DEPTH_NESTING);

For the record: I had some doubts about the above, as I think this code
should be in BH context and lock_sock_nested() could sleep, but
CONFIG_DEBUG_ATOMIC_SLEEP=3Dy did not complain about the above.

Paolo


--===============0930964545812431727==--
