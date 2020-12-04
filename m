Content-Type: multipart/mixed; boundary="===============2025270703017108554=="
MIME-Version: 1.0
From: Paolo Abeni <pabeni at redhat.com>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: [RFC PATCH] selinux: handle MPTCP consistently with TCP
Date: Fri, 04 Dec 2020 11:04:36 +0100
Message-ID: <8c844984eaa92413066367af69b56194b111ad8f.camel@redhat.com>
In-Reply-To: CAHC9VhT-rj=tJwVycS19TgJDQ766oUH6ng+Uv=wu+WDrgE0AHA@mail.gmail.com
X-Status: 
X-Keywords:                  
X-UID: 7042

--===============2025270703017108554==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On Thu, 2020-12-03 at 21:24 -0500, Paul Moore wrote:
> On Thu, Dec 3, 2020 at 6:54 PM Florian Westphal <fw(a)strlen.de> wrote:
> > Paul Moore <paul(a)paul-moore.com> wrote:
> > > I'm not very well versed in MPTCP, but this *seems* okay to me, minus
> > > the else-crud chunk.  Just to confirm my understanding, while MPTCP
> > > allows one TCP connection/stream to be subdivided and distributed
> > > across multiple interfaces, it does not allow multiple TCP streams to
> > > be multiplexed on a single connection, yes?
> > =

> > Its the latter.  The application sees a TCP interface (socket), but
> > data may be carried over multiple individual tcp streams on the wire.
> =

> Hmm, that may complicate things a bit from a SELinux perspective.  Maybe =
not.
> =

> Just to make sure I understand, with MPTCP, a client that
> traditionally opened multiple TCP sockets to talk to a server would
> now just open a single MPTCP socket and create multiple sub-flows
> instead of multiple TCP sockets?

I expect most clients will not be updated specifically for MPTCP,
except changing the protocol number at socket creation time - and we
would like to avoid even that.

If a given application creates multiple sockets, it will still do that
with MPTCP. The kernel, according to the configuration provided by the
user-space and/or by the peer, may try to create additional subflows
for each MPTCP sockets, using different local or remote address and/or
port number. Each subflow is represented inside the kernel as a TCP
'struct sock' with specific ULP operations. No related 'struct socket'
is exposed to user-space.

Cheers,

Paolo

--===============2025270703017108554==--
