Content-Type: multipart/mixed; boundary="===============9133410173611343502=="
MIME-Version: 1.0
From: Paolo Abeni <pabeni at redhat.com>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: [PATCH net] mptcp: fix joined subflows with unblocking sk
Date: Mon, 27 Jul 2020 12:38:55 +0200
Message-ID: <f188e293df1271cb54c1c072aac6dbcfc232a811.camel@redhat.com>
In-Reply-To: 20200727102433.3422117-1-matthieu.baerts@tessares.net
X-Status: 
X-Keywords:                  
X-UID: 5312

--===============9133410173611343502==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On Mon, 2020-07-27 at 12:24 +0200, Matthieu Baerts wrote:
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

Acked-by: Paolo Abeni <pabeni(a)redhat.com>

--===============9133410173611343502==--
