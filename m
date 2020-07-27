Content-Type: multipart/mixed; boundary="===============8830898090957308512=="
MIME-Version: 1.0
From: David Miller <davem at davemloft.net>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: [PATCH net] mptcp: fix joined subflows with unblocking sk
Date: Mon, 27 Jul 2020 11:52:18 -0700
Message-ID: <20200727.115218.1191292272155021831.davem@davemloft.net>
In-Reply-To: 20200727102433.3422117-1-matthieu.baerts@tessares.net
X-Status: 
X-Keywords:                  
X-UID: 5329

--===============8830898090957308512==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

From: Matthieu Baerts <matthieu.baerts(a)tessares.net>
Date: Mon, 27 Jul 2020 12:24:33 +0200

> Unblocking sockets used for outgoing connections were not containing
> inet info about the initial connection due to a typo there: the value of
> "err" variable is negative in the kernelspace.
> =

> This fixes the creation of additional subflows where the remote port has
> to be reused if the other host didn't announce another one. This also
> fixes inet_diag showing blank info about MPTCP sockets from unblocking
> sockets doing a connect().
> =

> Fixes: 41be81a8d3d0 ("mptcp: fix unblocking connect()")
> Signed-off-by: Matthieu Baerts <matthieu.baerts(a)tessares.net>

Applied, thanks!
--===============8830898090957308512==--
