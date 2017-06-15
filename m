Content-Type: multipart/mixed; boundary="===============1026399210179632982=="
MIME-Version: 1.0
From: Mat Martineau <mathew.j.martineau at linux.intel.com>
To: mptcp at lists.01.org
Subject: [MPTCP] New Linux TCP feature: generic upper layer protocol
Date: Thu, 15 Jun 2017 16:35:17 -0700
Message-ID: <alpine.OSX.2.21.1706151550060.33450@jrhamric-mobl03.amr.corp.intel.com>
X-Status: 
X-Keywords:                  
X-UID: 43

--===============1026399210179632982==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable


Hello,

A new piece of TCP extension infrastructure was just merged to net-next: =

generic upper layer protocol (ULP) support for TCP.

The relevant commit is =

https://git.kernel.org/pub/scm/linux/kernel/git/davem/net-next.git/commit/?=
id=3D734942cc4ea6478eed125af258da1bdbb4afe578

It was added as part of in-kernel TLS support. The TLS code didn't =

initially have this framework, but Tom Herbert asked them to generalize =

this feature when reviewing an early patch set.

If we use ULP for MPTCP, creating a multipatch socket would look like:

sock =3D socket(AF_INET, SOCK_STREAM, 0);
setsockopt(sock, SOL_TCP, TCP_ULP, "mptcp", sizeof("mptcp"));

instead of:

sock =3D socket(AF_INET, SOCK_STREAM, IPPROTO_MPTCP);


A case can be made for either interface. MPTCP shares an IP protocol =

number with TCP, so IPPROTO_MPTCP is a awkward to define in a way that's =

consistent with other AF_INET{,6} protocols. On the other hand, MPTCP is =

not a layer above TCP like TLS - however, we have the same need to =

override some TCP socket behavior.

In the end, there's not much difference in functionality, but the =

maintainers may favor the ULP approach. Any preferences here on this list?

--
Mat Martineau
Intel OTC

--===============1026399210179632982==--
