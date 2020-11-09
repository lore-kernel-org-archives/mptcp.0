Content-Type: multipart/mixed; boundary="===============9076884170073623524=="
MIME-Version: 1.0
From: Jakub Kicinski <kuba at kernel.org>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: [MPTCP][PATCH net 1/2] mptcp: fix static checker warnings
 in mptcp_pm_add_timer
Date: Mon, 09 Nov 2020 14:20:51 -0800
Message-ID: <20201109142051.39f1cfaa@kicinski-fedora-PC1C0HJN.hsd1.ca.comcast.net>
In-Reply-To: 62ab8297-41fc-446b-a09e-0b93118a478c@tessares.net
X-Status: 
X-Keywords:                  
X-UID: 6615

--===============9076884170073623524==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On Mon, 9 Nov 2020 21:23:33 +0000 (UTC) Matthieu Baerts wrote:
> 09 Nov 2020 21:57:05 Jakub Kicinski <kuba(a)kernel.org>:
> > On Mon, 9 Nov 2020 17:28:54 +0100 Matthieu Baerts wrote:  =

> >> A small detail (I think): the Signed-off-by of the sender (Geliang)
> >> should be the last one in the list if I am not mistaken.
> >> But I guess this is not blocking.
> >>
> >> Reviewed-by: Matthieu Baerts <matthieu.baerts(a)tessares.net>  =

> >
> > I take it you'd like me to apply patch 1 directly to net?  =

> =

> Sorry, I didn't know it was OK to apply only one patch of the series.
> Then yes, if you don't mind, please apply this patch :)

Not really, I was just establishing ownership ;)

Geliang Tang, please rebase on net and repost just the first patch.
It does not apply to net as is.
--===============9076884170073623524==--
