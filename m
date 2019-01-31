Content-Type: multipart/mixed; boundary="===============1757431480232730243=="
MIME-Version: 1.0
From: Mat Martineau <mathew.j.martineau at linux.intel.com>
To: mptcp at lists.01.org
Subject: Re: [MPTCP] Questions/remarks wrt. mptcp layered prototype
Date: Thu, 31 Jan 2019 12:54:07 -0800
Message-ID: <alpine.OSX.2.21.1901311022360.38822@mwahl-mobl.amr.corp.intel.com>
In-Reply-To: 20190131150242.e43t66aeklckmvw5@breakpoint.cc
X-Status: 
X-Keywords:                  
X-UID: 985

--===============1757431480232730243==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable


Hi Florian -

On Thu, 31 Jan 2019, Florian Westphal wrote:

> Hi.
>
> I had a look at the layered prototype, here are some questions/remarks.
> 1) mptcp_close():
>
>                hlist_del_rcu(node);
>                spin_unlock_bh(&msk->conn_list_lock);
>                synchronize_rcu();
>                pr_debug("conn_list->subflow=3D%p", subflow);
>                sock_release(sock_sk(subflow)->sk_socket);
>        } while (1);
>
> What is this synchronize_rcu() supposed to protect/do?
> AFAICS it can be removed?

Readers of conn_list call sock_hold(subflow) while the rcu read lock is =

held, and can do so without any socket locks held. We want to make sure =

they have adjusted the subflow socket reference count before calling =

sock_release() here, which can free the subflow socket.

>
> 2) struct tcp_options_received should really have IS_ENABLED(CONFIG_MPTCP)
> wrap for the mptcp struct; unlike smc it increases struct size.
> So better appease those that have CONFIG_MPTCP=3Dn.
>
> 3) running scripts/checkpatch.pl spews out a gazillion of warnings,
>   I would suggest fix those up rather sooner than later.
>   Its annoting task for sure, but someone has to do it.

Matthieu also noted these in his gerrit review. I've fixed up the =

checkpatch issues this week but haven't pushed those changes yet.

>
> 4) the networking maintainer enforces reverse-xmas tree for variable
>   declarations, so
>
> 	if (tcp_rsk(req)->is_mptcp) {
> 		u64 local_key;
> 		u64 remote_key;
>
>   must become
> 	if (tcp_rsk(req)->is_mptcp) {
> 		u64 remote_key;
> 		u64 local_key;
>
>   This might seems silly, but thats how things are.

Thanks for the reminder, I'm aware of the reverse xmas tree convention but =

we were not rigorous about enforcing it.

>
> 5) The line in skbuff.c adding the mptcp extension should look like this
>    [SKB_EXT_MPTCP] =3D SKB_EXT_CHUNKSIZEOF(struct mptcp_skb_cb),
>    Also, mptcp_skb_cb still contains obsolete reference count.
>    (while at it, probably better to rename struct, mptcp_skb_cb makes
>    me think its stored in skb->cb[]).

Ok, will fix those issues.

>
> 6) I think it would help to add an mptcp kselftest; I can look at this ne=
xt.
>

That will be very helpful, thank you!

--
Mat Martineau
Intel

--===============1757431480232730243==--
