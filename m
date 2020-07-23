Content-Type: multipart/mixed; boundary="===============1787297034416132689=="
MIME-Version: 1.0
From: David Miller <davem at davemloft.net>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: [PATCH net-next 0/8] mptcp: non backup subflows pre-reqs
Date: Thu, 23 Jul 2020 11:47:40 -0700
Message-ID: <20200723.114740.2116654801704929589.davem@davemloft.net>
In-Reply-To: cover.1595431326.git.pabeni@redhat.com
X-Status: 
X-Keywords:                  
X-UID: 5268

--===============1787297034416132689==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

From: Paolo Abeni <pabeni(a)redhat.com>
Date: Thu, 23 Jul 2020 13:02:28 +0200

> This series contains a bunch of MPTCP improvements loosely related to
> concurrent subflows xmit usage, currently under development.
> =

> The first 3 patches are actually bugfixes for issues that will become app=
arent
> as soon as we will enable the above feature.
> =

> The later patches improve the handling of incoming additional subflows,
> improving significantly the performances in stress tests based on a high =
new
> connection rate.

Series applied, thanks!
--===============1787297034416132689==--
