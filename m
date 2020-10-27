Content-Type: multipart/mixed; boundary="===============1708179772401940533=="
MIME-Version: 1.0
From: Matthieu Baerts <matthieu.baerts at tessares.net>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: [MPTCP][PATCH mptcp-next] Squash to "selftests: mptcp:
 add link failure test case"
Date: Tue, 27 Oct 2020 18:04:17 +0100
Message-ID: <a9325e25-1491-3642-1587-dde871fa9896@tessares.net>
In-Reply-To: CA+WQbwu-xkUtyay4sxxs7rFY22BYdqHLXtFeO323zywW+NVhJA@mail.gmail.com
X-Status: 
X-Keywords:                  
X-UID: 6448

--===============1708179772401940533==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Geliang

On 27/10/2020 08:23, Geliang Tang wrote:

(...)
> It changed run_tests 22 times with test_linkfail=3D0,
> and only added one run_tests with test_linkfail=3D1.
> =

> If we change test_linkfail as an optional argument,
> and set it's default value to 0. We don't need to change
> all 22 run_tests, we just need to change the 6 run_tests
> with the "slow" flag. It can save some code.

Thank you for the explanation, that's clearer!

Yes, it makes sense to reduce the patch like you did:

- 50d7ca136895: "squashed" in "selftests: mptcp: add link failure test case"
- 1011fdb1bfb8: "Signed-off-by" + "Co-developed-by"
- Results: 53c49928dfa2..9bceebfe0a58

Tests + export are in progress!

Cheers,
Matt
-- =

Tessares | Belgium | Hybrid Access Solutions
www.tessares.net
--===============1708179772401940533==--
