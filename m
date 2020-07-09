Content-Type: multipart/mixed; boundary="===============7795767908070018752=="
MIME-Version: 1.0
From: David Miller <davem at davemloft.net>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: [PATCH net-next 0/4] mptcp: introduce msk diag interface
Date: Thu, 09 Jul 2020 12:38:59 -0700
Message-ID: <20200709.123859.1982048822159692342.davem@davemloft.net>
In-Reply-To: cover.1594292774.git.pabeni@redhat.com
X-Status: 
X-Keywords:                  
X-UID: 4964

--===============7795767908070018752==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

From: Paolo Abeni <pabeni(a)redhat.com>
Date: Thu,  9 Jul 2020 15:12:38 +0200

> This series implements the diag interface for the MPTCP sockets.
> =

> Since the MPTCP protocol value can't be represented with the
> current diag uAPI, the first patch introduces an extended attribute
> allowing user-space to specify lager protocol values.
> =

> The token APIs are then extended to allow traversing the
> whole token container.
> =

> Patch 3 carries the actual diag interface implementation, and =

> later patch bring-in some functional self-tests.

Series applied, thanks.
--===============7795767908070018752==--
