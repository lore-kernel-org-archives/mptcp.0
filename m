Content-Type: multipart/mixed; boundary="===============8362607857745840421=="
MIME-Version: 1.0
From: Mat Martineau <mathew.j.martineau at linux.intel.com>
To: mptcp at lists.01.org
Subject: Re: [MPTCP] KSelftests warnings: Replaced mapping before it was done
Date: Tue, 04 Jun 2019 18:21:18 -0700
Message-ID: <alpine.OSX.2.21.1906041803530.13961@slseaman-mobl1.amr.corp.intel.com>
In-Reply-To: c174bdf2-0418-5b1c-781c-22493290d6d7@tessares.net
X-Status: 
X-Keywords:                  
X-UID: 1283

--===============8362607857745840421==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable


On Fri, 31 May 2019, Matthieu Baerts wrote:

> Hello,
>
> As just discussed, I have this warning when launching kselftests:
>
>    Replaced mapping before it was done
>
>
> Here are the logs when KASAN and PROVE_LOCKING are used:
>
> TAP version 13
> 1..1
> # selftests: mptcp: mptcp_connect.sh
> [   40.042417] IPv6: ADDRCONF(NETDEV_CHANGE): ns1eth2: link becomes ready
> [   40.258626] IPv6: ADDRCONF(NETDEV_CHANGE): ns2eth3: link becomes ready
> [   40.488896] IPv6: ADDRCONF(NETDEV_CHANGE): ns3eth4: link becomes ready
> # Created /tmp/tmp.GJv3xyPEgr (size 5220870) containing data sent by clie=
nt
> # Created /tmp/tmp.qFsIUFmpRA (size 2720072) containing data sent by serv=
er
> # ns1  MPTCP -> ns1  (10.0.1.1:10000) MPTCP	[   40.852761] IPv6:
> ADDRCONF(NETDEV_CHANGE): ns2eth1: link becomes ready
> [ OK ]
> # ns1  MPTCP -> ns1  (10.0.1.1:10001) TCP  	[ OK ]
> # ns1  TCP   -> ns1  (10.0.1.1:10002) MPTCP	[ OK ]
> # ns1  MPTCP -> ns2  (10.0.1.2:10003) MPTCP	[ OK ]
> # ns1  MPTCP -> ns2  (10.0.1.2:10004) TCP  	[ OK ]
> # ns1  TCP   -> ns2  (10.0.1.2:10005) MPTCP	[ OK ]
> # ns1  MPTCP -> ns2  (10.0.2.1:10006) MPTCP	[ OK ]
> # ns1  MPTCP -> ns2  (10.0.2.1:10007) TCP  	[ OK ]
> # ns1  TCP   -> ns2  (10.0.2.1:10008) MPTCP	[ OK ]
> # ns1  MPTCP -> ns3  (10.0.2.2:10009) MPTCP	[ OK ]
> # ns1  MPTCP -> ns3  (10.0.2.2:10010) TCP  	[ OK ]
> # ns1  TCP   -> ns3  (10.0.2.2:10011) MPTCP	[ OK ]
> # ns1  MPTCP -> ns3  (10.0.3.2:10012) MPTCP	[ OK ]
> # ns1  MPTCP -> ns3  (10.0.3.2:10013) TCP  	[ OK ]
> # ns1  TCP   -> ns3  (10.0.3.2:10014) MPTCP	[ OK ]
> # ns1  MPTCP -> ns4  (10.0.3.1:10015) MPTCP	[   62.510172] Replaced
> mapping before it was done
> [   62.510714] Replaced mapping before it was done
> [   62.516202] Replaced mapping before it was done
> [   62.556681] Replaced mapping before it was done
> [   62.561805] Replaced mapping before it was done
> [   62.574194] Replaced mapping before it was done
> [   62.586401] Replaced mapping before it was done

...

It looks like this is due to TSO & GSO duplicating the headers for large =

sends, so the same TCP options get sent on all the segments.

The RFC seems (?) to allow this. We're wasting bandwidth by sending =

redundant mappings, but it doesn't hurt anything. It could be handled =

better by the receiving code, which could confirm that the entire mapping =

matches and only trigger an error when there is a mismatch. Or we could be =

more aggressive about rewriting or truncating the TCP options during =

segmentation.

--
Mat Martineau
Intel

--===============8362607857745840421==--
