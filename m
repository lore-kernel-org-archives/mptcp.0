Content-Type: multipart/mixed; boundary="===============7960495604158128158=="
MIME-Version: 1.0
From: Florian Westphal <fw at strlen.de>
To: mptcp at lists.01.org
Subject: Re: [MPTCP] [PRE-RFC 0/6] mptcp: implement retransmit infrastructure
Date: Mon, 19 Aug 2019 13:06:54 +0200
Message-ID: <20190819110654.GC2588@breakpoint.cc>
In-Reply-To: cover.1565970525.git.pabeni@redhat.com
X-Status: 
X-Keywords:                  
X-UID: 1652

--===============7960495604158128158==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Paolo Abeni <pabeni(a)redhat.com> wrote:
> As suggested by the subj prefix, this is a very early draft, mainly to
> discuss design decisions and/or architectural issues. This is only
> compile-tested so far.
> =

> In the current status:
> - updates the MPTCP unacked sequence number (patches 1-3) on sendmsg()
>   - also try to cope with 32 bit sequence number
> - queue data (page frags) in MPTCP retransmission queue (patch 4)
> - cleanup acked data from retransmission queue and schedule a timeout to
>    update MPTCP unacked sequence number (patch 5)
> - do memory accounting for the MPTCP rtx queue (patch 6)

Can you explain how this rtx queue is expected to be used?

At this time, we only use one tcp connection for sending data, so
we can rely on tcp level retransmits.

Is this for future failover case?

> Open points:
> - what about the current seq_una update schema (patch 2-3)? too much comp=
lex?
>    too much loose? too much generic?
> - is it too early to plug any heuristic inside the code? (as done in patc=
h 3)

As long as they don't expose a particular behaviour i think its fine, it
can be tweaked/refined later.

> - do we really need a timer to update the unacked sequence?
>   - we can avoid it with an additional atomic operation in
>     mptcp_incoming_options() - either using an atomic type for 'snd_una' =
or
>     use an additional spin lock to protect it (and possibly other fields)=
[2]

I think that using a timer is very strange.  I will comment in the patch
itself.

>   - still we will likely need a timer to detect that a subflow has become
>     unusable e.g. due to link down event on the peer side. Should we rely=
 on
>     explicit MPTCP notification only (e.g. DEL_ADDR sub-option)?

Ah, that answers my question above.  I don't think we can rely on
on-wire notifications only.  Client can e.g. move outside of wifi range
for example, so we would only notice that the tcp connection is
"blocked" (e.g. outstanding data with no further acks coming in).

> - retransmission code needs to run in process context, as we will need to
>   acquire msk socket lock and ssh socket lock in order.
>   - As MPTCP-level retransmission should be considerably less frequent th=
an
>     TCP-level retransmission-timeout, we could use/schedule a workqueue f=
or
>     that.

Agree, workqueue seems right for this.

--===============7960495604158128158==--
