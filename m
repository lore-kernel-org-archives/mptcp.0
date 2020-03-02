Content-Type: multipart/mixed; boundary="===============7312468372164035695=="
MIME-Version: 1.0
From: Paolo Abeni <pabeni at redhat.com>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: [PATCH] mptcp: fix wrong merge resolution
Date: Mon, 02 Mar 2020 14:43:37 +0100
Message-ID: <4cf244b31673213a3cc2428fd9079c77a77d9b77.camel@redhat.com>
In-Reply-To: 20200302093442.1481757-1-matthieu.baerts@tessares.net
X-Status: 
X-Keywords:                  
X-UID: 3838

--===============7312468372164035695==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On Mon, 2020-03-02 at 10:34 +0100, Matthieu Baerts wrote:
> Otherwise the data are never init and we get warnings in workqueue code.
> =

> I really don't know how I made this mistake :-/
> =

> Fixes: ce2d7fb36478 (tgupdate: merge t/mptcp-introduce-MPTCP-retransmissi=
on-timer base into t/mptcp-introduce-MPTCP-retransmission-timer)
> Signed-off-by: Matthieu Baerts <matthieu.baerts(a)tessares.net>

LGTM, Thanks!

/P

--===============7312468372164035695==--
