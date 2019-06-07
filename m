Content-Type: multipart/mixed; boundary="===============4803514103240737685=="
MIME-Version: 1.0
From: Matthieu Baerts <matthieu.baerts at tessares.net>
To: mptcp at lists.01.org
Subject: [MPTCP] LPC networking CfP: abstract: draft
Date: Fri, 07 Jun 2019 16:53:52 +0200
Message-ID: <7aff5fc8-b7b1-cca1-190c-cc0af053238f@tessares.net>
X-Status: 
X-Keywords:                  
X-UID: 1314

--===============4803514103240737685==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hello,

Yesterday, we discussed options for a Linux Plumber's Conference
networking track talk.

Here is a first draft of an abstract. Feel free to comment and react:

=3D=3D=3D

Multipath TCP (MPTCP) is more and more popular these days but it is not
in the upstream Linux kernel yet. A fork is still being maintained on
the side and has been since March 2009. But it cannot be upstreamed as
it is because this implementation is designed for MPTCP and the TCP
stack is too heavily impacted in term of maintainability but also a bit
regarding the performances.

In this presentation, we would like to present the challenges we are
facing. Some are introduced by this MPTCP protocol, others by objectives
we defined: limit at the maximum the impact on the existing TCP stack.
We would like to have no performance regression, a maintainable and
configurable solution and an MPTCP implementation that can be used in a
variety of deployments.

The MPTCP upstreaming community is working on a RFC patch set for
net-next. We should be able to send it before the next LPC in September.
In the current situation, a socket can be created with IPPROTO_MPTCP to
initiate and accept an MPTCP connection. This socket remains compatible
with regular TCP and IPPROTO_TCP socket behavior is unchanged. This
implementation makes use of ULP between the userspace-facing MPTCP
socket and the set of in-kernel TCP sockets it controls to limit the
minimum impact on the current TCP stack. ULP has been extended for use
with listening sockets. skb_ext is used to carry MPTCP metadata.

Both the communication and the code are public and opened. You can find
us at mptcp(a)lists.01.org and https://is.gd/mptcp_upstream

=3D=3D=3D

Do not hesitate to improve it, fix typo or restart from scratch if
needed, I don't mind!

Cheers,
Matt
-- =

Matthieu Baerts | R&D Engineer
matthieu.baerts(a)tessares.net
Tessares SA | Hybrid Access Solutions
www.tessares.net
1 Avenue Jean Monnet, 1348 Louvain-la-Neuve, Belgium

--===============4803514103240737685==--
