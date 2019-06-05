Content-Type: multipart/mixed; boundary="===============2939419120155681268=="
MIME-Version: 1.0
From: Paolo Abeni <pabeni at redhat.com>
To: mptcp at lists.01.org
Subject: Re: [MPTCP] KSelftests warnings: Replaced mapping before it was done
Date: Wed, 05 Jun 2019 10:13:37 +0200
Message-ID: <94b092e24c7ba034f0388d4300dc35f6d83371d5.camel@redhat.com>
In-Reply-To: 20190605042800.GQ5495@MacBook-Pro-64.local
X-Status: 
X-Keywords:                  
X-UID: 1286

--===============2939419120155681268==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On Tue, 2019-06-04 at 21:28 -0700, Christoph Paasch wrote:
> On 04/06/19 - 18:21:18, Mat Martineau wrote:
> > On Fri, 31 May 2019, Matthieu Baerts wrote:
> > =

> > > Hello,
> > > =

> > > As just discussed, I have this warning when launching kselftests:
> > > =

> > >    Replaced mapping before it was done
> > > =

> > > =

> > > Here are the logs when KASAN and PROVE_LOCKING are used:
> > > =

> > > TAP version 13
> > > 1..1
> > > # selftests: mptcp: mptcp_connect.sh
> > > [   40.042417] IPv6: ADDRCONF(NETDEV_CHANGE): ns1eth2: link becomes r=
eady
> > > [   40.258626] IPv6: ADDRCONF(NETDEV_CHANGE): ns2eth3: link becomes r=
eady
> > > [   40.488896] IPv6: ADDRCONF(NETDEV_CHANGE): ns3eth4: link becomes r=
eady
> > > # Created /tmp/tmp.GJv3xyPEgr (size 5220870) containing data sent by =
client
> > > # Created /tmp/tmp.qFsIUFmpRA (size 2720072) containing data sent by =
server
> > > # ns1  MPTCP -> ns1  (10.0.1.1:10000) MPTCP	[   40.852761] IPv6:
> > > ADDRCONF(NETDEV_CHANGE): ns2eth1: link becomes ready
> > > [ OK ]
> > > # ns1  MPTCP -> ns1  (10.0.1.1:10001) TCP  	[ OK ]
> > > # ns1  TCP   -> ns1  (10.0.1.1:10002) MPTCP	[ OK ]
> > > # ns1  MPTCP -> ns2  (10.0.1.2:10003) MPTCP	[ OK ]
> > > # ns1  MPTCP -> ns2  (10.0.1.2:10004) TCP  	[ OK ]
> > > # ns1  TCP   -> ns2  (10.0.1.2:10005) MPTCP	[ OK ]
> > > # ns1  MPTCP -> ns2  (10.0.2.1:10006) MPTCP	[ OK ]
> > > # ns1  MPTCP -> ns2  (10.0.2.1:10007) TCP  	[ OK ]
> > > # ns1  TCP   -> ns2  (10.0.2.1:10008) MPTCP	[ OK ]
> > > # ns1  MPTCP -> ns3  (10.0.2.2:10009) MPTCP	[ OK ]
> > > # ns1  MPTCP -> ns3  (10.0.2.2:10010) TCP  	[ OK ]
> > > # ns1  TCP   -> ns3  (10.0.2.2:10011) MPTCP	[ OK ]
> > > # ns1  MPTCP -> ns3  (10.0.3.2:10012) MPTCP	[ OK ]
> > > # ns1  MPTCP -> ns3  (10.0.3.2:10013) TCP  	[ OK ]
> > > # ns1  TCP   -> ns3  (10.0.3.2:10014) MPTCP	[ OK ]
> > > # ns1  MPTCP -> ns4  (10.0.3.1:10015) MPTCP	[   62.510172] Replaced
> > > mapping before it was done
> > > [   62.510714] Replaced mapping before it was done
> > > [   62.516202] Replaced mapping before it was done
> > > [   62.556681] Replaced mapping before it was done
> > > [   62.561805] Replaced mapping before it was done
> > > [   62.574194] Replaced mapping before it was done
> > > [   62.586401] Replaced mapping before it was done
> > =

> > ...
> > =

> > It looks like this is due to TSO & GSO duplicating the headers for large
> > sends, so the same TCP options get sent on all the segments.
> > =

> > The RFC seems (?) to allow this.
> =

> Yes, it does.
> =

> > We're wasting bandwidth by sending
> > redundant mappings, but it doesn't hurt anything. It could be handled b=
etter
> > by the receiving code, which could confirm that the entire mapping matc=
hes
> > and only trigger an error when there is a mismatch. Or we could be more
> > aggressive about rewriting or truncating the TCP options during
> > segmentation.
> =

> The receiver needs to support such kind of segment splitting as a middleb=
ox
> might do it on its own. The receiver has to wait until the full mapping h=
as
> been received on the subflow before pushing it higher up to MPTCP.

AFAICS, currently such constraint is not enforced: we pass up to the
MTPCP socket and to user-space any skb as soon as the associated MPTCP
sequence number is in-order and inside the current mapping. Would that
break something?

Thanks,

Paolo


--===============2939419120155681268==--
