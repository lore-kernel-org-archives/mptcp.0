Content-Type: multipart/mixed; boundary="===============8771692024721491963=="
MIME-Version: 1.0
From: Florian Westphal <fw at strlen.de>
To: mptcp at lists.01.org
Subject: Re: [MPTCP] [PRE-RFC 0/6] mptcp: implement retransmit infrastructure
Date: Mon, 19 Aug 2019 16:35:33 +0200
Message-ID: <20190819143533.GJ2588@breakpoint.cc>
In-Reply-To: 848b15465394deaa1ca7d5237dea15ff776e2b80.camel@redhat.com
X-Status: 
X-Keywords:                  
X-UID: 1661

--===============8771692024721491963==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Paolo Abeni <pabeni(a)redhat.com> wrote:
> On Mon, 2019-08-19 at 13:06 +0200, Florian Westphal wrote:
> > Is this for future failover case?
> =

> Yes, with a single subflow, we should not use MPTCP-level
> retransmission, it should be triggered by scenarios using failover
> and/or multiple concurrent substream.
> =

> Well, to be 110% honest, I think that with a wrong/less than perfect
> MPTCP-level retransmission heuristic we could end-up retransmitting
> even with a single flow: since the receiver sends MPTCP-level ack only
> after that the user-space read the data, a slow receiver user-space
> could trigger the timeout on the sender (and now that I have wrote it
> down, it looks a quite bad thing to me :(

Its not ideal, but I don't think its something that needs
to be addressed *right now*.

> [If I'm not completely lost, this is the only question left without an
> answer right???]

Yes, thanks.

--===============8771692024721491963==--
