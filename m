Content-Type: multipart/mixed; boundary="===============1716429209959155752=="
MIME-Version: 1.0
From: Matthieu Baerts <matthieu.baerts at tessares.net>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: [PATCH net] selftests: mptcp: fix dependecies
Date: Fri, 07 Aug 2020 12:16:42 +0200
Message-ID: <0892801f-c5d0-4ec3-361c-617208c8e5ec@tessares.net>
In-Reply-To: 781f07aa4d05b123a80bf98f5839e1611a833272.1596791966.git.pabeni@redhat.com
X-Status: 
X-Keywords:                  
X-UID: 5509

--===============1716429209959155752==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Paolo,

On 07/08/2020 11:32, Paolo Abeni wrote:
> Since commit df62f2ec3df6 ("selftests/mptcp: add diag interface tests")
> the MPTCP selftests relies on the MPTCP diag interface which is
> enabled by a specific kconfig knob: be sure to include it.

Good catch! Thank you for the patch!

Reviewed-by: Matthieu Baerts <matthieu.baerts(a)tessares.net>

Cheers,
Matt
-- =

Tessares | Belgium | Hybrid Access Solutions
www.tessares.net
--===============1716429209959155752==--
