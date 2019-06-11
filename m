Content-Type: multipart/mixed; boundary="===============0227840169884920077=="
MIME-Version: 1.0
From: Christoph Paasch <cpaasch at apple.com>
To: mptcp at lists.01.org
Subject: [MPTCP] MPTCP-API
Date: Tue, 11 Jun 2019 14:13:40 -0700
Message-ID: <20190611211340.GS5495@MacBook-Pro-64.local>
X-Status: 
X-Keywords:                  
X-UID: 1340

--===============0227840169884920077==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hello everyone,


I am bringing up something that we already once discussed quite a while
back. Apache Traffic Server has an option to enable MPTCP (currently,
through the socket-option MPTCP_ENABLED that is exposed on the
multipath-tcp.org kernel). Leif (in CC) is the main contributor & maintainer
of ATS.

Now, ATS will be doing a 9.0.0-release soon that will be the first release
with this MPTCP-option in the ATS-config.

We want to make sure that it would also work with the upcoming upstream MPT=
CP
implementation. So, we can easily make this use IPPROTO_MPTCP. However,
there currently isn't a 100% guarantee that the API is stable (as upstream
might request changes).

So, we are wondering how we can do binary compatibility without having to
wait for MPTCP to land upstream. Could the MPTCP-code expose maybe a sysctl
that indicates the "API-version" ? That way, upon startup ATS can simply
check the API-version and if it doesn't match, just disable MPTCP.


What are your thoughts?


Thanks,
Christoph


--===============0227840169884920077==--
