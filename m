Content-Type: multipart/mixed; boundary="===============8076815983174493149=="
MIME-Version: 1.0
From: Mat Martineau <mathew.j.martineau at linux.intel.com>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: [PATCH v3 0/7] selftests: mptcp: increase test coverage
Date: Wed, 23 Oct 2019 16:23:17 -0700
Message-ID: <alpine.OSX.2.21.1910231621520.37761@rjszuste-mobl.amr.corp.intel.com>
In-Reply-To: 20191023131325.18895-1-fw@strlen.de
X-Status: 
X-Keywords:                  
X-UID: 2301

--===============8076815983174493149==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable


On Wed, 23 Oct 2019, Florian Westphal wrote:

> This is resend of my selftest changes.  All commits may be sqaushed to
> "mptcp: add basic kselftest for mptcp".
>
> 1. make tc delays random.  This is to make sure mptcp-level retransmits
>   don't trigger more frequent when delay is large.
>   Note that the existing selftests always test low delay in the
>   loopback test case and in the ns1 <-> ns2 case, because there is no
>   artificial delay in both cases.
>
> 2. add accept/getpeername checks to make sure the sockaddr returned
>   from kernel is the expected endpoint.
>
> 3. add ipv6 capability to the test.
>   This was tested by changing the test script to use TCP <-> TCP and
>   setting both capture=3D1 ipv6=3Dtrue in the script.
>   The tcpdump shows ipv6 is used.
>
> 4. use a random combination of tso/gso/gro.  Presence (or lack) of
>   any of them cause slight changes in behaviour, we should make sure
>   include as many combinations as possible.
>   Because test duration is already large (~3m 45s in my vm), don't
>   add more test cases but instead make it use random combination.
>
> 5. allow parallel execution of the test case.  This allows you to
>   run e.g. 10 parallel instances instead of waiting for sequential
>   completion.
>
> 6. Fix a possible deadlock in the test program where both ends
>   block on write(), waiting for other side to drain the receive buffer.
>
> 7. track duration of each test.  This is useful to spot bugs in mptcp:
>   if MPTCP <-> MPTCP test takes 31 seconds but TCP fallback took 3,
>   something is wrong.
>   With current export branch, I saw no absurd divergences, so mptcp seems
>   fine right now.
>
> Average test run time is about 2 minutes after these changes.
>

Other than the extra variables in patch 2 (see the reply to that message), =

I think the series is ok to merge.

--
Mat Martineau
Intel
--===============8076815983174493149==--
