Content-Type: multipart/mixed; boundary="===============4004222023694545573=="
MIME-Version: 1.0
From: Christoph Paasch <cpaasch at apple.com>
To: mptcp at lists.01.org
Subject: Re: [MPTCP] KSelftests warnings: Replaced mapping before it was done
Date: Wed, 05 Jun 2019 10:44:02 -0700
Message-ID: <20190605174402.GS5495@MacBook-Pro-64.local>
In-Reply-To: 94b092e24c7ba034f0388d4300dc35f6d83371d5.camel@redhat.com
X-Status: 
X-Keywords:                  
X-UID: 1292

--===============4004222023694545573==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hello,

On 05/06/19 - 10:13:37, Paolo Abeni wrote:
> On Tue, 2019-06-04 at 21:28 -0700, Christoph Paasch wrote:
> > On 04/06/19 - 18:21:18, Mat Martineau wrote:
> > > On Fri, 31 May 2019, Matthieu Baerts wrote:
> > > =

> > > > Hello,
> > > > =

> > > > As just discussed, I have this warning when launching kselftests:
> > > > =

> > > >    Replaced mapping before it was done
> > > > =

> > > > =

> > > > Here are the logs when KASAN and PROVE_LOCKING are used:
> > > > =

> > > > TAP version 13
> > > > 1..1
> > > > # selftests: mptcp: mptcp_connect.sh
> > > > [   40.042417] IPv6: ADDRCONF(NETDEV_CHANGE): ns1eth2: link becomes=
 ready
> > > > [   40.258626] IPv6: ADDRCONF(NETDEV_CHANGE): ns2eth3: link becomes=
 ready
> > > > [   40.488896] IPv6: ADDRCONF(NETDEV_CHANGE): ns3eth4: link becomes=
 ready
> > > > # Created /tmp/tmp.GJv3xyPEgr (size 5220870) containing data sent b=
y client
> > > > # Created /tmp/tmp.qFsIUFmpRA (size 2720072) containing data sent b=
y server
> > > > # ns1  MPTCP -> ns1  (10.0.1.1:10000) MPTCP	[   40.852761] IPv6:
> > > > ADDRCONF(NETDEV_CHANGE): ns2eth1: link becomes ready
> > > > [ OK ]
> > > > # ns1  MPTCP -> ns1  (10.0.1.1:10001) TCP  	[ OK ]
> > > > # ns1  TCP   -> ns1  (10.0.1.1:10002) MPTCP	[ OK ]
> > > > # ns1  MPTCP -> ns2  (10.0.1.2:10003) MPTCP	[ OK ]
> > > > # ns1  MPTCP -> ns2  (10.0.1.2:10004) TCP  	[ OK ]
> > > > # ns1  TCP   -> ns2  (10.0.1.2:10005) MPTCP	[ OK ]
> > > > # ns1  MPTCP -> ns2  (10.0.2.1:10006) MPTCP	[ OK ]
> > > > # ns1  MPTCP -> ns2  (10.0.2.1:10007) TCP  	[ OK ]
> > > > # ns1  TCP   -> ns2  (10.0.2.1:10008) MPTCP	[ OK ]
> > > > # ns1  MPTCP -> ns3  (10.0.2.2:10009) MPTCP	[ OK ]
> > > > # ns1  MPTCP -> ns3  (10.0.2.2:10010) TCP  	[ OK ]
> > > > # ns1  TCP   -> ns3  (10.0.2.2:10011) MPTCP	[ OK ]
> > > > # ns1  MPTCP -> ns3  (10.0.3.2:10012) MPTCP	[ OK ]
> > > > # ns1  MPTCP -> ns3  (10.0.3.2:10013) TCP  	[ OK ]
> > > > # ns1  TCP   -> ns3  (10.0.3.2:10014) MPTCP	[ OK ]
> > > > # ns1  MPTCP -> ns4  (10.0.3.1:10015) MPTCP	[   62.510172] Replaced
> > > > mapping before it was done
> > > > [   62.510714] Replaced mapping before it was done
> > > > [   62.516202] Replaced mapping before it was done
> > > > [   62.556681] Replaced mapping before it was done
> > > > [   62.561805] Replaced mapping before it was done
> > > > [   62.574194] Replaced mapping before it was done
> > > > [   62.586401] Replaced mapping before it was done
> > > =

> > > ...
> > > =

> > > It looks like this is due to TSO & GSO duplicating the headers for la=
rge
> > > sends, so the same TCP options get sent on all the segments.
> > > =

> > > The RFC seems (?) to allow this.
> > =

> > Yes, it does.
> > =

> > > We're wasting bandwidth by sending
> > > redundant mappings, but it doesn't hurt anything. It could be handled=
 better
> > > by the receiving code, which could confirm that the entire mapping ma=
tches
> > > and only trigger an error when there is a mismatch. Or we could be mo=
re
> > > aggressive about rewriting or truncating the TCP options during
> > > segmentation.
> > =

> > The receiver needs to support such kind of segment splitting as a middl=
ebox
> > might do it on its own. The receiver has to wait until the full mapping=
 has
> > been received on the subflow before pushing it higher up to MPTCP.
> =

> AFAICS, currently such constraint is not enforced: we pass up to the
> MTPCP socket and to user-space any skb as soon as the associated MPTCP
> sequence number is in-order and inside the current mapping. Would that
> break something?

It would break when DSS-checksums are being used, as the full mapping is
needed to verify the checksum of the mapping.

When there is no DSS-checksum, I think it should be fine. On the
multipath-tcp.org implementation we are currently waiting for the full
mapping before pushing up higher.

Is it easier to be implemented by not waiting for the full mapping?


Christoph


--===============4004222023694545573==--
