Content-Type: multipart/mixed; boundary="===============2849362442411955534=="
MIME-Version: 1.0
From: Paul Moore <paul at paul-moore.com>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: [RFC PATCH] selinux: handle MPTCP consistently with TCP
Date: Fri, 04 Dec 2020 18:22:12 -0500
Message-ID: <CAHC9VhS9xRSbHMCgDkix0fHYeO=aA_=DVyV1Xdu8qFpggws8Kg@mail.gmail.com>
In-Reply-To: 8c844984eaa92413066367af69b56194b111ad8f.camel@redhat.com
X-Status: 
X-Keywords:                  
X-UID: 7057

--===============2849362442411955534==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On Fri, Dec 4, 2020 at 5:04 AM Paolo Abeni <pabeni(a)redhat.com> wrote:
>
> On Thu, 2020-12-03 at 21:24 -0500, Paul Moore wrote:
> > On Thu, Dec 3, 2020 at 6:54 PM Florian Westphal <fw(a)strlen.de> wrote:
> > > Paul Moore <paul(a)paul-moore.com> wrote:
> > > > I'm not very well versed in MPTCP, but this *seems* okay to me, min=
us
> > > > the else-crud chunk.  Just to confirm my understanding, while MPTCP
> > > > allows one TCP connection/stream to be subdivided and distributed
> > > > across multiple interfaces, it does not allow multiple TCP streams =
to
> > > > be multiplexed on a single connection, yes?
> > >
> > > Its the latter.  The application sees a TCP interface (socket), but
> > > data may be carried over multiple individual tcp streams on the wire.
> >
> > Hmm, that may complicate things a bit from a SELinux perspective.  Mayb=
e not.
> >
> > Just to make sure I understand, with MPTCP, a client that
> > traditionally opened multiple TCP sockets to talk to a server would
> > now just open a single MPTCP socket and create multiple sub-flows
> > instead of multiple TCP sockets?
>
> I expect most clients will not be updated specifically for MPTCP,
> except changing the protocol number at socket creation time - and we
> would like to avoid even that.
>
> If a given application creates multiple sockets, it will still do that
> with MPTCP. The kernel, according to the configuration provided by the
> user-space and/or by the peer, may try to create additional subflows
> for each MPTCP sockets, using different local or remote address and/or
> port number. Each subflow is represented inside the kernel as a TCP
> 'struct sock' with specific ULP operations. No related 'struct socket'
> is exposed to user-space.

Hmm, okay, there are probably a few other things we need to worry
about then from a SELinux point of view.  Smack may be okay since it
largely ignores sockets as a security entity, but Casey would be the
one to comment on that.  I'm not certain of the current AppArmor
network controls, or the other LSMs for that matter, but they should
be seeing this conversation on the LSM list so I assume they will
comment as necessary.

For SELinux the issue is that we need to track state in the sock
struct, via sock->sk_security, and that state needs to be initialized
and set properly.  Similarly with TCP request_sock structs, via
request_sock->{secid,peer_secid}.  Is the MPTCP code allocating and/or
otherwise creating socks or request_socks outside of the regular TCP
code?  We would also be concerned about socket structs, but I'm
guessing that code reuses the TCP code based on what you've said.

-- =

paul moore
www.paul-moore.com
--===============2849362442411955534==--
