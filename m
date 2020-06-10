Content-Type: multipart/mixed; boundary="===============5197042112913735627=="
MIME-Version: 1.0
From: Florian Westphal <fw at strlen.de>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: [PATCH mptcp-next 1/2] selftests: mptcp: add option to
 specify size of file to transfer
Date: Wed, 10 Jun 2020 14:48:00 +0200
Message-ID: <20200610124800.GC21317@breakpoint.cc>
In-Reply-To: 74ce44b3-c625-2840-e54d-ed9a3004cbde@tessares.net
X-Status: 
X-Keywords:                  
X-UID: 4639

--===============5197042112913735627==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Matthieu Baerts <matthieu.baerts(a)tessares.net> wrote:
> > @@ -40,9 +42,11 @@ usage() {
> >   	echo -e "\t-e: ethtool features to disable, e.g.: \"-e tso -e gso\" =
(default: randomly disable any of tso/gso/gro)"
> >   	echo -e "\t-4: IPv4 only: disable IPv6 tests (default: test both IPv=
4 and IPv6)"
> >   	echo -e "\t-c: capture packets for each test using tcpdump (default:=
 no capture)"
> > +	echo -e "\t-s: size of file to transfer in bytes (default random)"
> =

> Small detail: it should be "-f" instead of "-s". I can fix this when
> applying the patch in mptcp-next.

Thanks, please do that.
--===============5197042112913735627==--
