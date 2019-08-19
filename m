Content-Type: multipart/mixed; boundary="===============2885915104029408675=="
MIME-Version: 1.0
From: Florian Westphal <fw at strlen.de>
To: mptcp at lists.01.org
Subject: Re: [MPTCP] [PRE-RFC 6/6] mptcp: implement memory accounting for
 mptcp rtx queue
Date: Mon, 19 Aug 2019 16:31:03 +0200
Message-ID: <20190819143103.GI2588@breakpoint.cc>
In-Reply-To: e2829f6caef0e7f6c315c3a96f56e8caaabb45c7.camel@redhat.com
X-Status: 
X-Keywords:                  
X-UID: 1660

--===============2885915104029408675==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Paolo Abeni <pabeni(a)redhat.com> wrote:
> On Mon, 2019-08-19 at 13:47 +0200, Florian Westphal wrote:
> > Paolo Abeni <pabeni(a)redhat.com> wrote:
> > > Charge the data on the rtx queue to the master MPTCP socket, too.
> > > Such memory in uncharged when the data is acked/dequeued.
> > =

> > Could you briefly explain why this is needed?
> > The data is already accounted on the subflows.
> > =

> > Under what circumstances is the data un-charged from a subflow,
> > but still retained on the mptcp retrans list?
> =

> With the proposed patches and the current MPTCP code, that happens
> quite often, even with a single stream and no loss.
> =

> The MPTCP-level acks arrives later than TCP-level ones, as we send
> (MPTCP) ack when the user space really read the data. Most/every
> fragment stays in the MPTCP RTX queue for a while, after that the
> corresponding skb has been removed for the TCP transmission queue.
> =

> Please let me know if the above is somehow human-parsable ;)

Yes, make sense, thanks for explaining.

--===============2885915104029408675==--
