Content-Type: multipart/mixed; boundary="===============6798135335614565460=="
MIME-Version: 1.0
From: Mat Martineau <mathew.j.martineau at linux.intel.com>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: [PATCH] mptcp: propagate sendbuf setting to subflow on
 fallback
Date: Fri, 13 Mar 2020 15:39:19 -0700
Message-ID: <alpine.OSX.2.22.394.2003131516400.69817@jsingh3-mobl.amr.corp.intel.com>
In-Reply-To: 20200312154408.597-1-fw@strlen.de
X-Status: 
X-Keywords:                  
X-UID: 3942

--===============6798135335614565460==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable


On Thu, 12 Mar 2020, Florian Westphal wrote:

> For normal mptcp subflows we do not need to propagate the sndbuf size
> because all skbs to be transmitted via mptcp get charged to the mptcp
> send buffer, i.e. mptcp sndbuf will limit the amount of data handed to
> the subflow sockets.
>
> However, when we enter fallback mode, the mptcp xmit function is cut
> short and no mptcp-level socket accouting takes place.
> Therefore for the sndbuf limit to have any effect we need to set it
> on the fallback socket.
>
> Signed-off-by: Florian Westphal <fw(a)strlen.de>
> ---
> I'll pass this to netdev@ unless there are objections.
>
> net/mptcp/protocol.c | 16 ++++++++++++++--
> 1 file changed, 14 insertions(+), 2 deletions(-)
>
> diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
> index 8d6ab825bdab..ddfd02ab6e31 100644
> --- a/net/mptcp/protocol.c
> +++ b/net/mptcp/protocol.c
> @@ -57,15 +57,27 @@ static bool __mptcp_needs_tcp_fallback(const struct m=
ptcp_sock *msk)
> 	return msk->first && !sk_is_mptcp(msk->first);
> }
>
> +static void sync_sndbuf(const struct sock *msk, struct sock *ssk)
> +{
> +	if (unlikely((msk->sk_userlocks & SOCK_SNDBUF_LOCK) &&
> +	     ssk->sk_sndbuf !=3D msk->sk_sndbuf)) {
> +		ssk->sk_userlocks |=3D SOCK_SNDBUF_LOCK;
> +		WRITE_ONCE(ssk->sk_sndbuf, msk->sk_sndbuf);
> +	}
> +}
> +
> static struct socket *__mptcp_tcp_fallback(struct mptcp_sock *msk)
> {
> -	sock_owned_by_me((const struct sock *)msk);
> +	struct sock *sk =3D (struct sock *)msk;
> +
> +	sock_owned_by_me(sk);
>
> 	if (likely(!__mptcp_needs_tcp_fallback(msk)))
> 		return NULL;
>
> 	if (msk->subflow) {
> -		release_sock((struct sock *)msk);
> +		sync_sndbuf(sk, msk->subflow->sk);
> +		release_sock(sk);

__mptcp_tcp_fallback() is used on several system calls to determine if a =

fallback subflow is in use, but the commit message implies the sync is to =

happen upon fallback.

This placement of sync_sndbuf() will sync the value in a few cases, =

including when mptcp_sendmsg() is called (which is a good time to sync) =

and mptcp_recvmsg().

It will also sync the value in setsockopt()/getsockopt() - but, =

counterintuitively, not with SOL_SOCKET options like SO_SNDBUF.

Is the intent to sync once at fallback time, or to resync on send/recv & =

sockopt changes? It looks like we set tcp_sk(sk)->is_mptcp =3D 0 in several =

places to implement fallback, so there isn't a dedicated function for =

things to do at fallback time.

When fallback has already happened, does it make sense to pass through =

SO_SNDBUF changes to a fallback subflow (which would unfortunately involve =

net core changes)?

--
Mat Martineau
Intel
--===============6798135335614565460==--
