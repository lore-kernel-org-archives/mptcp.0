Content-Type: multipart/mixed; boundary="===============2284104244224252844=="
MIME-Version: 1.0
From: Mat Martineau <mathew.j.martineau at linux.intel.com>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: RFCv2 for netdev: what's missing?
Date: Tue, 01 Oct 2019 10:21:08 -0700
Message-ID: <alpine.OSX.2.21.1910011019220.22340@syitbare-mobl.amr.corp.intel.com>
In-Reply-To: 0af3b2f0-48cc-ccba-7d50-dd98e2009257@tessares.net
X-Status: 
X-Keywords:                  
X-UID: 1959

--===============2284104244224252844==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable


On Tue, 1 Oct 2019, Matthieu Baerts wrote:

> What do we still need to do?
> - the cover letter: Mat is it still OK to do it on your side?

Here's the cover letter draft:


"""
The MPTCP upstreaming community has prepared a net-next RFCv2 patch set
for review.

Clone/fetch:
https://github.com/multipath-tcp/mptcp_net-next.git (tag: netdev-rfcv2)

Browse:
https://github.com/multipath-tcp/mptcp_net-next/tree/netdev-rfcv2

With CONFIG_MPTCP=3Dy, a socket created with IPPROTO_MPTCP will attempt to
create an MPTCP connection but remains compatible with regular
TCP. IPPROTO_TCP socket behavior is unchanged.

This implementation makes use of ULP between the userspace-facing MPTCP
socket and the set of in-kernel TCP sockets it controls. ULP has been
extended for use with listening sockets. skb_ext is used to carry MPTCP
metadata.

The patch set includes self-tests to exercise MPTCP in various
connection and routing scenarios.

We have more work planned to reach the initial feature set for merging,
notably:

* IPv6

* Comply with MPTCPv1 (RFC6824bis). This patch set supports only
   MPTCPv0 (RFC 6824 / experimental)

* Proper MPTCP-level connection closing with DATA_FIN

* Couple receive windows across sibling subflow TCP sockets as required
   by RFC 6824

* Limit subflow ULP visibility to kernel space

* Simple transmit scheduler that respects subflow 'backup' flags

Thank you for your review. You can find us at mptcp(a)lists.01.org and
https://is.gd/mptcp_upstream

"""


--
Mat Martineau
Intel
--===============2284104244224252844==--
