Content-Type: multipart/mixed; boundary="===============8109220914240404252=="
MIME-Version: 1.0
From: Matthieu Baerts <matthieu.baerts at tessares.net>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: request for a pcap with version 1
Date: Mon, 20 Jan 2020 22:59:35 +0100
Message-ID: <df103c9f-983d-6896-e46c-cdb8e5e6c94c@tessares.net>
In-Reply-To: CADHp1NybvoUJEWO9DOuY60-SepUu+q_pfXzSa+=J8u5uS+fA5w@mail.gmail.com
X-Status: 
X-Keywords:                  
X-UID: 3437

--===============8109220914240404252==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Matt,

(too many Matt here too now :-=C3=BE )

On 20/01/2020 18:14, Matt wrote:
> Hi,
> =

> First of all congrats on all the work done and the first patchset being m=
erged.
> =

> I am the author of a small mptcp analyzer (displays
> throughput/goodput/one way delays if you capture both at
> client/server):
> https://github.com/teto/mptcpanalyzer
> =

> I would like to add support for mptcp v1 but I would need a pcap to
> check it works correctly (without having me compile the kernel).
> I wonder if it would be possible to share such a pcap (from a
> selftest, or mininet test) with the community, at
> https://wiki.wireshark.org/SampleCaptures#MPTCP for instance ?

That's a good idea to add support for MPTCP v1!

Davide (in cc) recently created a pull request to add MPTCP v1 support =

in TCPDump. There is one .pcap in the linked commit:

- https://github.com/the-tcpdump-group/tcpdump/pull/817
- =

https://github.com/the-tcpdump-group/tcpdump/blob/0a7bfdb0d33265734bf9c059e=
e27ec6f04402145/tests/mptcp-v1.pcap?raw=3Dtrue

Would it help you supporting MPTCP v1?

Cheers,
Matt
-- =

Matthieu Baerts | R&D Engineer
matthieu.baerts(a)tessares.net
Tessares SA | Hybrid Access Solutions
www.tessares.net
1 Avenue Jean Monnet, 1348 Louvain-la-Neuve, Belgium
--===============8109220914240404252==--
