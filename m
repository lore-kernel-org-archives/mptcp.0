Content-Type: multipart/mixed; boundary="===============7096989695380323420=="
MIME-Version: 1.0
From: Paolo Abeni <pabeni at redhat.com>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: [RFC PATCH] selinux: handle MPTCP consistently with TCP
Date: Wed, 09 Dec 2020 11:02:23 +0100
Message-ID: <8ceb498f3fd712c4122718cf445f8e3f2a642140.camel@redhat.com>
In-Reply-To: CAHC9VhQmZ_Ra8eY3O-qNo-QN9wLXBFP3VHuHvjY8vWOMSfGafA@mail.gmail.com
X-Status: 
X-Keywords:                  
X-UID: 7094

--===============7096989695380323420==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On Tue, 2020-12-08 at 18:35 -0500, Paul Moore wrote:
> On Tue, Dec 8, 2020 at 10:35 AM Paolo Abeni <pabeni(a)redhat.com> wrote:
> > Hello,
> > =

> > I'm sorry for the latency, I'll have limited internet access till
> > tomorrow.
> > =

> > On Fri, 2020-12-04 at 18:22 -0500, Paul Moore wrote:
> > > For SELinux the issue is that we need to track state in the sock
> > > struct, via sock->sk_security, and that state needs to be initialized
> > > and set properly.
> > =

> > As far as I can see, for regular sockets, sk_security is allocated via:
> > =

> > - sk_prot_alloc() -> security_sk_alloc() for client/listener sockets
> > - sk_clone_lock() -> sock_copy() for server sockets
> > =

> > MPTCP uses the above helpers, sk_security should be initialized
> > properly.
> =

> At least for SELinux, the security_socket_post_create() hook is
> critical too as that is where the SELinux sock/socket state values are
> actually set; see selinux_socket_post_create() for the SELinux hook.

MPTCP sockets are created via the conventional sys_socket() call path
or sk_clone_lock(). MPTCP subflows are created via sock_create_kern()
or csk_af_ops->syn_recv_sock().

Overall the above matches what plain TCP does: client sockets and
listener sockets will hit selinux_socket_post_create(), server sockets
will hit security_sk_clone().

> > >  Similarly with TCP request_sock structs, via
> > > request_sock->{secid,peer_secid}.  Is the MPTCP code allocating and/or
> > > otherwise creating socks or request_socks outside of the regular TCP
> > > code?
> > =

> > Request sockets are easier, I guess/hope: MPTCP handles them very
> > closely to plain TCP.
> =

> Are there a calls to security_inet_conn_request() and
> security_inet_csk_clone() in the MPTCP code path?  As an example look
> at tcp_conn_request() and inet_csk_clone_lock() for IPv4.

MPTCP subflows call both the above, via the relevant TCP call-path.
MPTCP sockets calls security_inet_conn_request() for client sockets on
connect(), but it looks like we currently lack a call
to security_inet_csk_clone() for server MPTCP sockets, as they are
created via direct call to sk_clone_lock().

I think that could be easily handled with an MPTCP patch.

> > > We would also be concerned about socket structs, but I'm
> > > guessing that code reuses the TCP code based on what you've said.
> > =

> > Only the main MPTCP 'struct socket' is exposed to the user space, and
> > that is allocated via the usual __sys_socket() call-chain. I guess that
> > should be fine. If you could provide some more context (what I should
> > look after) I can dig more.
> =

> Hopefully the stuff above should help, if not let me know :)

yes, it helped, thanks!

My understanding is that the MPTCP implementation aligns with this
proposed patch - modulo the required changed mentioned above, which
looks like a MPTCP bug.

Cheers,

Paolo

--===============7096989695380323420==--
