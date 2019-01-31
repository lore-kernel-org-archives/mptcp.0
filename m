Content-Type: multipart/mixed; boundary="===============3789821316760737285=="
MIME-Version: 1.0
From: Florian Westphal <fw at strlen.de>
To: mptcp at lists.01.org
Subject: Re: [MPTCP] Questions/remarks wrt. mptcp layered prototype
Date: Fri, 01 Feb 2019 00:11:39 +0100
Message-ID: <20190131231139.mv7klifjikkl5vmq@breakpoint.cc>
In-Reply-To: alpine.OSX.2.21.1901311022360.38822@mwahl-mobl.amr.corp.intel.com
X-Status: 
X-Keywords:                  
X-UID: 986

--===============3789821316760737285==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Mat Martineau <mathew.j.martineau(a)linux.intel.com> wrote:
> > I had a look at the layered prototype, here are some questions/remarks.
> > 1) mptcp_close():
> > =

> >                hlist_del_rcu(node);
> >                spin_unlock_bh(&msk->conn_list_lock);
> >                synchronize_rcu();
> >                pr_debug("conn_list->subflow=3D%p", subflow);
> >                sock_release(sock_sk(subflow)->sk_socket);
> >        } while (1);
> > =

> > What is this synchronize_rcu() supposed to protect/do?
> > AFAICS it can be removed?
> =

> Readers of conn_list call sock_hold(subflow) while the rcu read lock is
> held, and can do so without any socket locks held. We want to make sure t=
hey
> have adjusted the subflow socket reference count before calling
> sock_release() here, which can free the subflow socket.

I see, thanks for explaining.  This will need a different solution,
 synchronize_rcu() can cause delays in oder of several hundreds of millisec=
onds.

I'll first work on selftest, then look it this one.
It might be as simple as move sock_hold() users to refcount_inc_not_zero().

--===============3789821316760737285==--
