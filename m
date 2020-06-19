Content-Type: multipart/mixed; boundary="===============8007402797934927431=="
MIME-Version: 1.0
From: David Miller <davem at davemloft.net>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: [PATCH net 0/2] mptcp: cope with syncookie on MP_JOINs
Date: Thu, 18 Jun 2020 20:26:06 -0700
Message-ID: <20200618.202606.465950193993392898.davem@davemloft.net>
In-Reply-To: cover.1592388398.git.pabeni@redhat.com
X-Status: 
X-Keywords:                  
X-UID: 4740

--===============8007402797934927431==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

From: Paolo Abeni <pabeni(a)redhat.com>
Date: Wed, 17 Jun 2020 12:08:55 +0200

> Currently syncookies on MP_JOIN connections are not handled correctly: the
> connections fallback to TCP and are kept alive instead of resetting them =
at
> fallback time.
> =

> The first patch propagates the required information up to syn_recv_sock t=
ime,
> and the 2nd patch addresses the unifying the error path for all MP_JOIN
> requests.

Series applied, thanks.
--===============8007402797934927431==--
