Content-Type: multipart/mixed; boundary="===============7935659953729966475=="
MIME-Version: 1.0
From: David Miller <davem at davemloft.net>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: [PATCH net] selftests: mptcp: fix dependecies
Date: Fri, 07 Aug 2020 17:23:21 -0700
Message-ID: <20200807.172321.1351420945383297003.davem@davemloft.net>
In-Reply-To: 781f07aa4d05b123a80bf98f5839e1611a833272.1596791966.git.pabeni@redhat.com
X-Status: 
X-Keywords:                  
X-UID: 5523

--===============7935659953729966475==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

From: Paolo Abeni <pabeni(a)redhat.com>
Date: Fri,  7 Aug 2020 11:32:04 +0200

> Since commit df62f2ec3df6 ("selftests/mptcp: add diag interface tests")
> the MPTCP selftests relies on the MPTCP diag interface which is
> enabled by a specific kconfig knob: be sure to include it.
> =

> Fixes: df62f2ec3df6 ("selftests/mptcp: add diag interface tests")
> Signed-off-by: Paolo Abeni <pabeni(a)redhat.com>

Applied, thanks!
--===============7935659953729966475==--
