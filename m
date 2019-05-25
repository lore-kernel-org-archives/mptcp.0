Content-Type: multipart/mixed; boundary="===============4075992511896010541=="
MIME-Version: 1.0
From: Mat Martineau <mathew.j.martineau at linux.intel.com>
To: mptcp at lists.01.org
Subject: Re: [MPTCP] [PATCH mptcp v3] mptcp: switch sublist to mptcp socket
 lock protection
Date: Fri, 24 May 2019 17:11:34 -0700
Message-ID: <alpine.OSX.2.21.1905241617460.51733@sabrinas-mobl.amr.corp.intel.com>
In-Reply-To: 20190524145753.20219-1-fw@strlen.de
X-Status: 
X-Keywords:                  
X-UID: 1242

--===============4075992511896010541==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable


On Fri, 24 May 2019, Florian Westphal wrote:

> The mptcp sublist is currently guarded by rcu, but this comes with
> several artifacts that make little sense.
>
> 1. There is a synchronize_rcu after stealing the subflow list on
>   each mptcp socket close.
>
>   synchronize_rcu() is a very expensive call, and should not be
>   needed.
>
> 2. There is a extra spinlock to guard the list, ey we can't use
>   the lock in some cases because we need to call functions that
>   might sleep.
>
> 3. There is a 'mptcp_subflow_hold()' function that uses
>   an 'atomic_inc_not_zero' call.  This wasn't needed even with
>   current code:  The owning mptcp socket holds references on its
>   subflows, so a subflow socket that is still found on the list
>   will always have a nonzero reference count.
>
> This changes the subflow list to always be guarded by the owning
> mptcp socket lock.  This is safe as long as no code path that holds
> a mptcp subflow tcp socket lock will try to lock the owning mptcp
> sockets lock.
>
> The inverse -- locking the tcp subflow lock while holding the
> mptcp lock -- is fine.
>
> mptcp_subflow_get_ref() will have to be altered later when we
> support multiple subflows so it will pick a 'preferred' subflow
> rather than the first one in the list.
>
> This also adds checks on the mptcp socket state to cope with
> following scenario:
>
> mptcp_close()
>   reap sublist
> ...
> mptcp_finish_connect
>   add to sublist
>
> As the mptcp socket has already been closed, the tcp_sock
> reference would be lost.
>
> From the callback check that the MPTCP socket is not closed.
> In order to allow to differentiate between a closed socket
> (mptcp_close was called) and a new socket, update the mptcp
> sockets state to SYN_SENT right before we start to create the
> outgoing connection.
>
> For the reverse case, update it in mptcp_listen so mptcp_accept
> can do the same/similar check: do not accept a new subflow if
> the mptcp socket has already been closed.
>

Thanks for the patch Florian. At an earlier point we thought there would =

be a need to read the list without holding a lock, but I don't remember =

what that case was and looking at the current code the socket lock works =

well.

I do have a question about the MPTCP sock state transition below.


> Signed-off-by: Florian Westphal <fw(a)strlen.de>
> ---
> v3: changed locking to bh_lock_sock to handle non-backlog case.
>
> I did NOT change mptcp_finish_connect yet, I suspect we will need to
> rewrite/rethink this once we support multiple *active* subflows.
>
> AFAIU, when userspace has called close() just when internal machinery
> would complete the tcp connection, then we have to make sure that the
> tcp socket is closed too.  Doing this from the current place isn't
> possible as the tcp sockets lock is held.
>
> There are alternatives of course, but this patch is already rather
> large and this problem isn't related to spinlock/rcu vs. socket lock.
>
> net/mptcp/protocol.c | 181 ++++++++++++++++++++++---------------------
> net/mptcp/protocol.h |   3 +-
> 2 files changed, 93 insertions(+), 91 deletions(-)
>
> diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
> index 9a98c8e0c996..f6375d18dc57 100644
> --- a/net/mptcp/protocol.c
> +++ b/net/mptcp/protocol.c

...

> @@ -866,6 +881,8 @@ static int mptcp_stream_connect(struct socket *sock, =
struct sockaddr *uaddr,
> 			return err;
> 	}
>
> +	if (sock->sk->sk_state =3D=3D TCP_CLOSE)
> +		sock->sk->sk_state =3D TCP_SYN_SENT;

Should this use inet_sk_state_store()?

> 	return inet_stream_connect(msk->subflow, uaddr, addr_len, flags);

Since this could return an error, the MPTCP socket state could be set to =

TCP_SYN_SENT if the subflow connect call succeeded and ended up in the =

right state.

> }
>

...

> @@ -994,24 +1001,20 @@ static int mptcp_shutdown(struct socket *sock, int=
 how)
> 	}
>
> 	/* protect against concurrent mptcp_close(), so that nobody can
> -	 * remove entries from the conn list and walking the list breaking
> -	 * the RCU critical section is still safe. We need to release the
> -	 * RCU lock to call the blocking kernel_sock_shutdown() primitive
> -	 * Note: we can't use MPTCP socket lock to protect conn_list changes,
> +	 * remove entries from the conn list and walking the list
> +	 * is still safe.
> +	 *
> +	 * We can't use MPTCP socket lock to protect conn_list changes,
> 	 * as we need to update it from the BH via the mptcp_finish_connect()
> 	 */
> 	lock_sock(sock->sk);
> -	rcu_read_lock();
> -	list_for_each_entry_rcu(subflow, &msk->conn_list, node) {
> +	list_for_each_entry(subflow, &msk->conn_list, node) {

Minor: this could use mptcp_for_each_subflow()

> 		struct socket *tcp_socket;
>
> 		tcp_socket =3D mptcp_subflow_tcp_socket(subflow);
> -		rcu_read_unlock();
> 		pr_debug("conn_list->subflow=3D%p", subflow);
> 		ret =3D kernel_sock_shutdown(tcp_socket, how);
> -		rcu_read_lock();
> 	}
> -	rcu_read_unlock();
> 	release_sock(sock->sk);
>
> 	return ret;

--
Mat Martineau
Intel

--===============4075992511896010541==--
