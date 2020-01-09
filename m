Content-Type: multipart/mixed; boundary="===============5685048230173025713=="
MIME-Version: 1.0
From: Paolo Abeni <pabeni at redhat.com>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: [PATCH 2/2] protocol: fix list corruption
Date: Thu, 09 Jan 2020 16:30:09 +0100
Message-ID: <4b2fec06c49a5c449e418b3ba59d6dbd1ad76bef.camel@redhat.com>
In-Reply-To: 20200109143114.7716-2-fw@strlen.de
X-Status: 
X-Keywords:                  
X-UID: 3312

--===============5685048230173025713==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On Thu, 2020-01-09 at 15:31 +0100, Florian Westphal wrote:
> squashto: subflow: place further subflows on new 'join_list'
> =

> plugs:
>  inconsistent {SOFTIRQ-ON-W} -> {IN-SOFTIRQ-W} usage.
>  kworker/u8:1/31 [HC0[0]:SC1[1]:HE1:SE0] takes:
>  ffff88810c43d520 (&(&msk->join_list_lock)->rlock){+.?.}, at: mptcp_finis=
h_join+0x30f/0x4d0
> =

> and a list corruption, we need to re-init the join list head, else next
> list_empty() test will splice this a second time, resulting in a
> corrupted conn list.
> =

> Signed-off-by: Florian Westphal <fw(a)strlen.de>
> ---
>  net/mptcp/protocol.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> =

> diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
> index a33c4c58de78..6df4eb20916c 100644
> --- a/net/mptcp/protocol.c
> +++ b/net/mptcp/protocol.c
> @@ -153,7 +153,7 @@ static void __mptcp_flush_join_list(struct mptcp_sock=
 *msk)
>  		return;
>  =

>  	spin_lock_bh(&msk->join_list_lock);
> -	list_splice_tail(&msk->join_list, &msk->conn_list);
> +	list_splice_tail_init(&msk->join_list, &msk->conn_list);
>  	spin_unlock_bh(&msk->join_list_lock);
>  }
>  =

> @@ -1420,9 +1420,9 @@ bool mptcp_finish_join(struct sock *sk)
>  =

>  		/* active connections are already on conn_list */
>  		if (list_empty(&subflow->node)) {
> -			spin_lock(&msk->join_list_lock);
> +			spin_lock_bh(&msk->join_list_lock);
>  			list_add_tail(&subflow->node, &msk->join_list);
> -			spin_unlock(&msk->join_list_lock);
> +			spin_unlock_bh(&msk->join_list_lock);
>  		}
>  	}
>  	return true;

whoops, I thought this would run in BH only - I was wrong!

LGTM!

Paolo=20

--===============5685048230173025713==--
