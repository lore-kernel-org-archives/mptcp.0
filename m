Content-Type: multipart/mixed; boundary="===============2786206244898108370=="
MIME-Version: 1.0
From: Paolo Abeni <pabeni at redhat.com>
To: mptcp at lists.01.org
Subject: Re: [MPTCP] [PRE-RFC 0/6] mptcp: implement retransmit infrastructure
Date: Mon, 19 Aug 2019 15:02:47 +0200
Message-ID: <848b15465394deaa1ca7d5237dea15ff776e2b80.camel@redhat.com>
In-Reply-To: 20190819110654.GC2588@breakpoint.cc
X-Status: 
X-Keywords:                  
X-UID: 1659

--===============2786206244898108370==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi,

On Mon, 2019-08-19 at 13:06 +0200, Florian Westphal wrote:
> Paolo Abeni <pabeni(a)redhat.com> wrote:
> > As suggested by the subj prefix, this is a very early draft, mainly to
> > discuss design decisions and/or architectural issues. This is only
> > compile-tested so far.
> > =

> > In the current status:
> > - updates the MPTCP unacked sequence number (patches 1-3) on sendmsg()
> >   - also try to cope with 32 bit sequence number
> > - queue data (page frags) in MPTCP retransmission queue (patch 4)
> > - cleanup acked data from retransmission queue and schedule a timeout to
> >    update MPTCP unacked sequence number (patch 5)
> > - do memory accounting for the MPTCP rtx queue (patch 6)
> =

> Can you explain how this rtx queue is expected to be used?
> =

> At this time, we only use one tcp connection for sending data, so
> we can rely on tcp level retransmits.
> =

> Is this for future failover case?

Yes, with a single subflow, we should not use MPTCP-level
retransmission, it should be triggered by scenarios using failover
and/or multiple concurrent substream.

Well, to be 110% honest, I think that with a wrong/less than perfect
MPTCP-level retransmission heuristic we could end-up retransmitting
even with a single flow: since the receiver sends MPTCP-level ack only
after that the user-space read the data, a slow receiver user-space
could trigger the timeout on the sender (and now that I have wrote it
down, it looks a quite bad thing to me :(

[If I'm not completely lost, this is the only question left without an
answer right???]

Cheers,

Paolo


--===============2786206244898108370==--
