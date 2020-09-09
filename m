Content-Type: multipart/mixed; boundary="===============5695975393209229823=="
MIME-Version: 1.0
From: Paolo Abeni <pabeni at redhat.com>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: [PATCH] mptcp: call tcp_cleanup_rbuf on subflows
Date: Wed, 09 Sep 2020 18:15:50 +0200
Message-ID: <396a39fddc546f5d97cd42c59db565428cdc120a.camel@redhat.com>
In-Reply-To: 3e3bca22480da1920cb48f87d1167a0f22cbd63f.1599659451.git.pabeni@redhat.com
X-Status: 
X-Keywords:                  
X-UID: 5773

--===============5695975393209229823==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On Wed, 2020-09-09 at 15:51 +0200, Paolo Abeni wrote:
> That is needed to let the subflows announce promply when new
> space is available in the receive buffer.
> =

> Signed-off-by: Paolo Abeni <pabeni(a)redhat.com>
> --

Reporting here info shared on the IRC channel.

This is a bit rough, but fixes the simult self-tests (at least the
enabled one) and here apparently also reduces the mptcp_connect.sh
self-tests run time.

Any third-party confirm more than appreciated ;)

/P





--===============5695975393209229823==--
