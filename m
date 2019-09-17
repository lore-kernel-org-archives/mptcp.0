Content-Type: multipart/mixed; boundary="===============5315819986761775156=="
MIME-Version: 1.0
From: Florian Westphal <fw at strlen.de>
To: mptcp at lists.01.org
Subject: Re: [MPTCP] [PATCH RFC 6/6] mptcp: use __tcp_poll instead of tcp_poll
Date: Tue, 17 Sep 2019 18:42:24 +0200
Message-ID: <20190917164224.GG6961@breakpoint.cc>
In-Reply-To: 23f0c3793e3aa80f090b0660c9fd8c8bef9b01b7.camel@redhat.com
X-Status: 
X-Keywords:                  
X-UID: 1864

--===============5315819986761775156==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Paolo Abeni <pabeni(a)redhat.com> wrote:
> >  		tcp_sock =3D mptcp_subflow_tcp_socket(subflow);
> > -		ret |=3D tcp_poll(file, tcp_sock, wait);
> > +		ret |=3D __tcp_poll(tcp_sock->sk);
> >  	}
> >  	release_sock(sk);
> =

> This allows mptcp_poll working even without a 'struct socket'. we still
> relies on such struct presence for:

Thats what I though as well, but tcp_poll assumes sk->sk_socket points
to the userspace-facing socket structure.

> kernel_accept
> kernel_sock_shutdown
> kernel_setsockopt
> kernel_getsockopt
> kernel_bind
> kernel_connect
> =

> I'm wondering if we should try to get rid completely of any depenency
> on 'struct socket'? That will fix the current issue with MP_JOIN, will
> reduce the memory usage and likely will improve accept time.

It will require careful audit of the stack, afaics Tcp assumes that for
anythig incoming tcp sk might have been detached from usersapce already
(i.e., application called close()).  But for anything coming from
syscalls that doesn't seem to be the case.

I started to hack up an MP_JOIN patch that uses a per-sk workqueue
to defer incoming joins so that a socket can be allocated for it.

I don't like it, but it seems easier to go with that route.


--===============5315819986761775156==--
