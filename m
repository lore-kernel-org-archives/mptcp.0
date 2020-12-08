Content-Type: multipart/mixed; boundary="===============8078271338376153058=="
MIME-Version: 1.0
From: Paul Moore <paul at paul-moore.com>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: [RFC PATCH] selinux: handle MPTCP consistently with TCP
Date: Tue, 08 Dec 2020 18:35:03 -0500
Message-ID: <CAHC9VhQmZ_Ra8eY3O-qNo-QN9wLXBFP3VHuHvjY8vWOMSfGafA@mail.gmail.com>
In-Reply-To: 08b7534580e1bdb134ba0c2816977836cd446c5d.camel@redhat.com
X-Status: 
X-Keywords:                  
X-UID: 7080

--===============8078271338376153058==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On Tue, Dec 8, 2020 at 10:35 AM Paolo Abeni <pabeni(a)redhat.com> wrote:
>
> Hello,
>
> I'm sorry for the latency, I'll have limited internet access till
> tomorrow.
>
> On Fri, 2020-12-04 at 18:22 -0500, Paul Moore wrote:
> > For SELinux the issue is that we need to track state in the sock
> > struct, via sock->sk_security, and that state needs to be initialized
> > and set properly.
>
> As far as I can see, for regular sockets, sk_security is allocated via:
>
> - sk_prot_alloc() -> security_sk_alloc() for client/listener sockets
> - sk_clone_lock() -> sock_copy() for server sockets
>
> MPTCP uses the above helpers, sk_security should be initialized
> properly.

At least for SELinux, the security_socket_post_create() hook is
critical too as that is where the SELinux sock/socket state values are
actually set; see selinux_socket_post_create() for the SELinux hook.

> MPTCP goes through an additional sk_prot_alloc() for each subflow, so
> each of them will get it's own independent context. The subflows are
> not exposed to any syscall (accept()/recvmsg()/sendmsg()/poll()/...),
> so I guess selinux will mostly ignored them right?

SELinux cares quite a bit about the sock structs, they are an
important part of the per-packet access controls as well as a few
other things, so we need to make sure the SELinux state is managed
properly.

From what you have said so far, it is starting to sound like labeling
the subflows with the same label as the parent socket is a reasonable
solution.  In that case, it seems like doing a security_sk_clone()
between the main socket/sock and the new subflow sock should work.

> >  Similarly with TCP request_sock structs, via
> > request_sock->{secid,peer_secid}.  Is the MPTCP code allocating and/or
> > otherwise creating socks or request_socks outside of the regular TCP
> > code?
>
> Request sockets are easier, I guess/hope: MPTCP handles them very
> closely to plain TCP.

Are there a calls to security_inet_conn_request() and
security_inet_csk_clone() in the MPTCP code path?  As an example look
at tcp_conn_request() and inet_csk_clone_lock() for IPv4.

> > We would also be concerned about socket structs, but I'm
> > guessing that code reuses the TCP code based on what you've said.
>
> Only the main MPTCP 'struct socket' is exposed to the user space, and
> that is allocated via the usual __sys_socket() call-chain. I guess that
> should be fine. If you could provide some more context (what I should
> look after) I can dig more.

Hopefully the stuff above should help, if not let me know :)

-- =

paul moore
www.paul-moore.com
--===============8078271338376153058==--
