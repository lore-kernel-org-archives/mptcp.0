Content-Type: multipart/mixed; boundary="===============1371258511883965597=="
MIME-Version: 1.0
From: Florian Westphal <fw at strlen.de>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: [RFC 7/7] make accept not allocate kernel socket struct
Date: Mon, 25 Nov 2019 16:31:32 +0100
Message-ID: <20191125153132.GC795@breakpoint.cc>
In-Reply-To: 97ed872fc1646d62788b3246ec01db5ce73aedf8.camel@redhat.com
X-Status: 
X-Keywords:                  
X-UID: 2688

--===============1371258511883965597==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Paolo Abeni <pabeni(a)redhat.com> wrote:
> > No, its also for outgoing connections, we use in kernel sockets for
> > those.
> =

> Uhm...  I see. Everything created via mptcp_subflow_create_socket(),
> right? I though of always using msk's socket also/mainly to reduce the
> memory usage, but server side we should have very few
> mptcp_subflow_create_socket() instances, so I guess it's no necessary
> optimize them.

FWIW it might make sense to not have those in kernel sockets either
in the future, but this might need a bit more changes to how outgoing
connections work in mptcp-next.

I would have a look at it at some later date, I don't think its
a high priority.

> > > > @@ -1443,6 +1470,20 @@ static int mptcp_stream_accept(struct socket=
 *sock, struct socket *newsock,
> > > >  		return -EINVAL;
> > > >  =

> > > >  	err =3D ssock->ops->accept(sock, newsock, flags, kern);
> > > > +	if (err =3D=3D 0 && (newsock->sk->sk_prot =3D=3D &mptcp_prot ||
> > > > +			 is_mptcp_v6(newsock))) {
> > > =

> > > Is not clear to me why/how we can hit the condition '!(newsock->sk-
> > > > sk_prot =3D=3D &mptcp_prot || is_mptcp_v6(newsock))' ... Can you pl=
ease
> > > explain?
> > =

> > We will hit it when we get connection from non-mptcp peer, i.e. the
> > !mp_capable part of mptcp_accept().
> > =

> > In that case sk_prot is &tcp_prot.
> > =

> > It might make sense to change this to
> >     err =3D=3D 0 && newsock->sk->sk_prot !=3D &tcp_prot
> > =

> > perhaps that would clarify this a bit.  WDYT?
> =

> Yep, I like this latter code more!

Ok, I've flagged the patches 'RFC' in patchwork already.
I will make this change and will resubmit that part later.

Thanks,
Florian
--===============1371258511883965597==--
