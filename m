Content-Type: multipart/mixed; boundary="===============3652669699466496791=="
MIME-Version: 1.0
From: Paolo Abeni <pabeni at redhat.com>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: [PATCH mptcp] subflow: place outgoing connections on the
 join list
Date: Thu, 20 Feb 2020 17:00:18 +0100
Message-ID: <72608929bc3b314de71a87502e091acff140953c.camel@redhat.com>
In-Reply-To: 20200204153534.23813-1-fw@strlen.de
X-Status: 
X-Keywords:                  
X-UID: 3713

--===============3652669699466496791==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On Tue, 2020-02-04 at 16:35 +0100, Florian Westphal wrote:
> squashto: subflow: place further subflows on new 'join_list'
> =

> in case the subflow can't be established (timeout, reset) the subflow
> socket is leaked.
> =

> Add it to the join list for now.  This isn't nice because the socket
> will be added while its known to not be established, and its not removed
> at any time even if its not useable.
> =

> The list_del_init() call can be removed because the subflow context
> ->node is still unused / not on a list in all cases.
> =

> On a different note:
> =

> I think it makes sense to remove the 'splice join to conn list' approach
> and instead have the worker check the join and conn lists:
> =

> 1. subflows are added from join to conn list once they are established.
> 2. subflows on join list that are still in SYN_SENT are ignored
> 3. subflows on join and/or conn list that are closed already are removed
> and free'd.
> =

> Alternatively, we could probably extend the sk_state_change callback
> to do this and keep checking outside of send/receive code paths.
> =

> Signed-off-by: Florian Westphal <fw(a)strlen.de>
> ---
>  net/mptcp/subflow.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
> =

> diff --git a/net/mptcp/subflow.c b/net/mptcp/subflow.c
> index 547d5ffef070..154fb2b42243 100644
> --- a/net/mptcp/subflow.c
> +++ b/net/mptcp/subflow.c
> @@ -821,11 +821,14 @@ int mptcp_subflow_connect(struct sock *sk, struct s=
ockaddr *local,
>  	if (err && err !=3D -EINPROGRESS)
>  		goto failed;
>  =

> +	spin_lock_bh(&msk->join_list_lock);
> +	list_add_tail(&subflow->node, &msk->join_list);
> +	spin_unlock_bh(&msk->join_list_lock);
> +
>  	release_sock(sk);
>  	return err;
>  =

>  failed:
> -	list_del_init(&subflow->node);
>  	release_sock(sk);
>  	sock_release(sf);
>  	return err;

whooops ... this one fell outside my radar for a long time.

mp_join self-tests (WIP) demonstrated the need for this one!

LGTM, thanks Florian!

/P

--===============3652669699466496791==--
