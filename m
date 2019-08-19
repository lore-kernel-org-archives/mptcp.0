Content-Type: multipart/mixed; boundary="===============5720745344674757386=="
MIME-Version: 1.0
From: Paolo Abeni <pabeni at redhat.com>
To: mptcp at lists.01.org
Subject: Re: [MPTCP] [PRE-RFC 6/6] mptcp: implement memory accounting for
 mptcp rtx queue
Date: Mon, 19 Aug 2019 14:53:25 +0200
Message-ID: <e2829f6caef0e7f6c315c3a96f56e8caaabb45c7.camel@redhat.com>
In-Reply-To: 20190819114742.GG2588@breakpoint.cc
X-Status: 
X-Keywords:                  
X-UID: 1658

--===============5720745344674757386==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On Mon, 2019-08-19 at 13:47 +0200, Florian Westphal wrote:
> Paolo Abeni <pabeni(a)redhat.com> wrote:
> > Charge the data on the rtx queue to the master MPTCP socket, too.
> > Such memory in uncharged when the data is acked/dequeued.
> =

> Could you briefly explain why this is needed?
> The data is already accounted on the subflows.
> =

> Under what circumstances is the data un-charged from a subflow,
> but still retained on the mptcp retrans list?

With the proposed patches and the current MPTCP code, that happens
quite often, even with a single stream and no loss.

The MPTCP-level acks arrives later than TCP-level ones, as we send
(MPTCP) ack when the user space really read the data. Most/every
fragment stays in the MPTCP RTX queue for a while, after that the
corresponding skb has been removed for the TCP transmission queue.

Please let me know if the above is somehow human-parsable ;)

Cheers,

Paolo


--===============5720745344674757386==--
