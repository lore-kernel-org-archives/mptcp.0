Content-Type: multipart/mixed; boundary="===============1240304142869671368=="
MIME-Version: 1.0
From: Florian Westphal <fw at strlen.de>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: [RFC 7/7] make accept not allocate kernel socket struct
Date: Mon, 25 Nov 2019 13:37:58 +0100
Message-ID: <20191125123758.GB795@breakpoint.cc>
In-Reply-To: 8521f5a18bb86408469be4b83e7ae200a8d81e42.camel@redhat.com
X-Status: 
X-Keywords:                  
X-UID: 2684

--===============1240304142869671368==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Paolo Abeni <pabeni(a)redhat.com> wrote:
> On Mon, 2019-11-25 at 03:15 +0100, Florian Westphal wrote:
> > @@ -924,10 +924,17 @@ static void mptcp_close(struct sock *sk, long tim=
eout)
> >  =

> >  	list_for_each_entry_safe(subflow, tmp, &msk->conn_list, node) {
> >  		struct sock *ssk =3D mptcp_subflow_tcp_sock(subflow);
> > +		struct socket *sock =3D READ_ONCE(ssk->sk_socket);
> >  =

> >  		pr_debug("conn_list->subflow=3D%p", subflow);
> >  		list_del(&subflow->node);
> > -		sock_release(ssk->sk_socket);
> > +
> > +		if (sock && sock !=3D sk->sk_socket) {
> > +			sock_release(sock);
> =

> Double checking I read the above correctly: the condition 'sock && sock
> !=3D sk->sk_socket' only for the first subflow of a client socket, right?
> If so, can we use the msk socket even for that one?

No, its also for outgoing connections, we use in kernel sockets for
those.

> > @@ -1443,6 +1470,20 @@ static int mptcp_stream_accept(struct socket *so=
ck, struct socket *newsock,
> >  		return -EINVAL;
> >  =

> >  	err =3D ssock->ops->accept(sock, newsock, flags, kern);
> > +	if (err =3D=3D 0 && (newsock->sk->sk_prot =3D=3D &mptcp_prot ||
> > +			 is_mptcp_v6(newsock))) {
> =

> Is not clear to me why/how we can hit the condition '!(newsock->sk-
> >sk_prot =3D=3D &mptcp_prot || is_mptcp_v6(newsock))' ... Can you please
> explain?

We will hit it when we get connection from non-mptcp peer, i.e. the
!mp_capable part of mptcp_accept().

In that case sk_prot is &tcp_prot.

It might make sense to change this to
    err =3D=3D 0 && newsock->sk->sk_prot !=3D &tcp_prot

perhaps that would clarify this a bit.  WDYT?
--===============1240304142869671368==--
