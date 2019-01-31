Content-Type: multipart/mixed; boundary="===============6837121109239788899=="
MIME-Version: 1.0
From: Florian Westphal <fw at strlen.de>
To: mptcp at lists.01.org
Subject: [MPTCP] Questions/remarks wrt. mptcp layered prototype
Date: Thu, 31 Jan 2019 16:02:42 +0100
Message-ID: <20190131150242.e43t66aeklckmvw5@breakpoint.cc>
X-Status: 
X-Keywords:                  
X-UID: 982

--===============6837121109239788899==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi.

I had a look at the layered prototype, here are some questions/remarks.
1) mptcp_close():

                hlist_del_rcu(node);
                spin_unlock_bh(&msk->conn_list_lock);
                synchronize_rcu();
                pr_debug("conn_list->subflow=3D%p", subflow);
                sock_release(sock_sk(subflow)->sk_socket);
        } while (1);

What is this synchronize_rcu() supposed to protect/do?
AFAICS it can be removed?

2) struct tcp_options_received should really have IS_ENABLED(CONFIG_MPTCP)
 wrap for the mptcp struct; unlike smc it increases struct size.
So better appease those that have CONFIG_MPTCP=3Dn.

3) running scripts/checkpatch.pl spews out a gazillion of warnings,
   I would suggest fix those up rather sooner than later.
   Its annoting task for sure, but someone has to do it.

4) the networking maintainer enforces reverse-xmas tree for variable
   declarations, so =


 	if (tcp_rsk(req)->is_mptcp) {
		u64 local_key;
 		u64 remote_key;

   must become
 	if (tcp_rsk(req)->is_mptcp) {
 		u64 remote_key;
		u64 local_key;

   This might seems silly, but thats how things are.

5) The line in skbuff.c adding the mptcp extension should look like this
    [SKB_EXT_MPTCP] =3D SKB_EXT_CHUNKSIZEOF(struct mptcp_skb_cb),
    Also, mptcp_skb_cb still contains obsolete reference count.
    (while at it, probably better to rename struct, mptcp_skb_cb makes
    me think its stored in skb->cb[]).

6) I think it would help to add an mptcp kselftest; I can look at this next.

Thanks,
Florian

--===============6837121109239788899==--
