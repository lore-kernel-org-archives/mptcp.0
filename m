Content-Type: multipart/mixed; boundary="===============1745292432203842978=="
MIME-Version: 1.0
From: Paolo Abeni <pabeni at redhat.com>
To: mptcp at lists.01.org
Subject: Re: [MPTCP] [PATCH] mptcp: mptcp option len must be skb independent
Date: Wed, 24 Apr 2019 10:35:40 +0200
Message-ID: <38ab22550d1347542bc7d85cbfe1d48230a06af7.camel@redhat.com>
In-Reply-To: alpine.OSX.2.21.1904191423420.55323@mjmartin-mac01.local
X-Status: 
X-Keywords:                  
X-UID: 1085

--===============1745292432203842978==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On Fri, 2019-04-19 at 15:28 -0700, Mat Martineau wrote:
> On Fri, 19 Apr 2019, Paolo Abeni wrote:
> =

> > Otherwise the TCP stack can't compute correctly the mss and
> > that will break segmentation. Note that we can't observe the
> > issue with the self-test until we allow skb collapsing -
> > loopback default MTU is pretty big and we dont build big enogh
> > skb otherwise.
> > =

> > Fix the issue caching the use_map/use_checksum flags also at the
> > substream ctx level, and using them in tcp_established_options().
> > While at it, replace a bunch of magic numbers with the appropriate
> > constants.
> =

> Hi Paolo -
> =

> "use_checksum" isn't going to differ across packets, and is a subflow-wid=
e =

> setting that can be in the subflow context.
> =

> "use_map" is different. The MPTCP DSS option has two parts, with one or =

> both of the MPTCP Data ACK and the MPTCP data sequence mapping. This =

> varies by the packet. After the connection gets started (handshake plus a =

> DSS ACK indicating the DSS options are getting passed through the =

> network), the DSS option is not required on every packet.
> =

> ACK packets have the DSS option with the MPTCP Data ACK but no mapping.
> =

> Not every data packet needs to have DSS mapping information - our MPTCP =

> socket could get a sendmsg with 2800 bytes, and send one skb with the =

> first 1400 data bytes and the DSS mapping for the 2800 byte range, and a =

> second skb with the last 1400 data bytes and no MPTCP option header.
> =

> One option is to have the MPTCP socket only send skbs with DSS mapping =

> information, which might use TCP option bytes in more packets than is =

> strictly necessary. =


I'm unsure I read correctly the above?!? no mptcp ACK?!?

> Another approach would be to assume the larger MPTCP =

> DSS option size (both ack and map) when calculating the mss. =


This is basically what the proposed patch does (as subflow->use_map
can't be changed). AFACS it fixes the issue.

Cheers,

Paolo


--===============1745292432203842978==--
