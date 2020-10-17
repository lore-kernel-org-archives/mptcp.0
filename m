Content-Type: multipart/mixed; boundary="===============1377373386869118374=="
MIME-Version: 1.0
From: Matthieu Baerts <matthieu.baerts at tessares.net>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: [PATCH net-next 0/2] The current export branch suffers of
 the following issue:
Date: Sat, 17 Oct 2020 10:32:27 +0200
Message-ID: <be0149a7-3f6e-a2e4-2447-678f40f06db5@tessares.net>
In-Reply-To: cover.1602693911.git.pabeni@redhat.com
X-Status: 
X-Keywords:                  
X-UID: 6342

--===============1377373386869118374==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Paolo, Mat,

On 14/10/2020 19:15, Paolo Abeni wrote:
> https://github.com/multipath-tcp/mptcp_net-next/issues/97
> =

> To fix the above, MPTCP needs to be able to cope with memory allocation
> failure in do_tcp_sendpages().
> =

> In this iteration the patches are rebased on top of:
> =

> "bpf:selftests: add bpf_mptcp_sock() verifier tests"
> =

> and should apply without fuzz on net-next.
> =

> patch 1/2 went through some lifting to be hopefully more acceptable
> upstream.
> =

> This will cause a few conflicts in later patch, specifically in
> "mptcp: move page frag allocation in mptcp_sendmsg()". Possibly the
> simpler/better would be squashing 2/2 in there.
> =

> The plan is to send 1/2 and "tcp: factor out __tcp_close() helper"
> as RFC upstream soon/while net-next is closed to try to understand
> if that could be acceptable. The 2 TCP patches alone, without the full
> series to hopefully make the review simpler/less cumbersome.

Thank you for the patches and the reviews!

I just applied these two patches on top of "tcp: factor out =

__tcp_close() helper", just before your sendmsg refactor series:

- 325abb8bd3d0: tcp: factor out tcp_build_frag()
   - Note: I took the version you sent to netdev for this one
- c573a4caa599: mptcp: use tcp_build_frag()
- 7b6333e0b375: conflict in =

t/mptcp-move-page-frag-allocation-in-mptcp_sendmsg
- Results: a26726f4d29b..653eafae048c

May you have a look at resolution of the conflicts I did please?

Tests + export are going in progress!

Cheers,
Matt
-- =

Tessares | Belgium | Hybrid Access Solutions
www.tessares.net
--===============1377373386869118374==--
