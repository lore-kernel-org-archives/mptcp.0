Content-Type: multipart/mixed; boundary="===============5405834632411306197=="
MIME-Version: 1.0
From: Paul Moore <paul at paul-moore.com>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: [RFC PATCH] selinux: handle MPTCP consistently with TCP
Date: Thu, 03 Dec 2020 21:24:39 -0500
Message-ID: <CAHC9VhT-rj=tJwVycS19TgJDQ766oUH6ng+Uv=wu+WDrgE0AHA@mail.gmail.com>
In-Reply-To: 20201203235415.GD5710@breakpoint.cc
X-Status: 
X-Keywords:                  
X-UID: 7040

--===============5405834632411306197==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On Thu, Dec 3, 2020 at 6:54 PM Florian Westphal <fw(a)strlen.de> wrote:
> Paul Moore <paul(a)paul-moore.com> wrote:
> > I'm not very well versed in MPTCP, but this *seems* okay to me, minus
> > the else-crud chunk.  Just to confirm my understanding, while MPTCP
> > allows one TCP connection/stream to be subdivided and distributed
> > across multiple interfaces, it does not allow multiple TCP streams to
> > be multiplexed on a single connection, yes?
>
> Its the latter.  The application sees a TCP interface (socket), but
> data may be carried over multiple individual tcp streams on the wire.

Hmm, that may complicate things a bit from a SELinux perspective.  Maybe no=
t.

Just to make sure I understand, with MPTCP, a client that
traditionally opened multiple TCP sockets to talk to a server would
now just open a single MPTCP socket and create multiple sub-flows
instead of multiple TCP sockets?

-- =

paul moore
www.paul-moore.com
--===============5405834632411306197==--
