Content-Type: multipart/mixed; boundary="===============3054052118879120286=="
MIME-Version: 1.0
From: Paolo Abeni <pabeni at redhat.com>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: [RFC PATCH] selinux: handle MPTCP consistently with TCP
Date: Tue, 08 Dec 2020 16:35:05 +0100
Message-ID: <08b7534580e1bdb134ba0c2816977836cd446c5d.camel@redhat.com>
In-Reply-To: CAHC9VhS9xRSbHMCgDkix0fHYeO=aA_=DVyV1Xdu8qFpggws8Kg@mail.gmail.com
X-Status: 
X-Keywords:                  
X-UID: 7078

--===============3054052118879120286==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hello,

I'm sorry for the latency, I'll have limited internet access till
tomorrow.

On Fri, 2020-12-04 at 18:22 -0500, Paul Moore wrote:
> For SELinux the issue is that we need to track state in the sock
> struct, via sock->sk_security, and that state needs to be initialized
> and set properly. =


As far as I can see, for regular sockets, sk_security is allocated via:

- sk_prot_alloc() -> security_sk_alloc() for client/listener sockets
- sk_clone_lock() -> sock_copy() for server sockets

MPTCP uses the above helpers, sk_security should be initialized
properly.

MPTCP goes through an additional sk_prot_alloc() for each subflow, so
each of them will get it's own independent context. The subflows are
not exposed to any syscall (accept()/recvmsg()/sendmsg()/poll()/...),
so I guess selinux will mostly ignored them right?

The kernel will pick some of them to actually send the data, and, on
the receive side, will move the data from the subflows into the user-
space visible mptcp socket.

>  Similarly with TCP request_sock structs, via
> request_sock->{secid,peer_secid}.  Is the MPTCP code allocating and/or
> otherwise creating socks or request_socks outside of the regular TCP
> code?  =


Request sockets are easier, I guess/hope: MPTCP handles them very
closely to plain TCP.

> We would also be concerned about socket structs, but I'm
> guessing that code reuses the TCP code based on what you've said.

Only the main MPTCP 'struct socket' is exposed to the user space, and
that is allocated via the usual __sys_socket() call-chain. I guess that
should be fine. If you could provide some more context (what I should
look after) I can dig more.

Thanks!

Paolo

--===============3054052118879120286==--
