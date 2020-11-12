Content-Type: multipart/mixed; boundary="===============7530517404211025944=="
MIME-Version: 1.0
From: Geliang Tang <geliangtang at gmail.com>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: [MPTCP][PATCH net 1/2] mptcp: fix static checker warnings
 in mptcp_pm_add_timer
Date: Thu, 12 Nov 2020 10:36:23 +0800
Message-ID: <CA+WQbwsAHXoFsO0ow6zasSpW96u8dsLusvJvE1iiAQC3KmQBAQ@mail.gmail.com>
In-Reply-To: 20201109142051.39f1cfaa@kicinski-fedora-PC1C0HJN.hsd1.ca.comcast.net
X-Status: 
X-Keywords:                  
X-UID: 6666

--===============7530517404211025944==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Jakub, Matt,

Jakub Kicinski <kuba(a)kernel.org> =E4=BA=8E2020=E5=B9=B411=E6=9C=8810=E6=
=97=A5=E5=91=A8=E4=BA=8C =E4=B8=8A=E5=8D=886:20=E5=86=99=E9=81=93=EF=BC=9A
>
> On Mon, 9 Nov 2020 21:23:33 +0000 (UTC) Matthieu Baerts wrote:
> > 09 Nov 2020 21:57:05 Jakub Kicinski <kuba(a)kernel.org>:
> > > On Mon, 9 Nov 2020 17:28:54 +0100 Matthieu Baerts wrote:
> > >> A small detail (I think): the Signed-off-by of the sender (Geliang)
> > >> should be the last one in the list if I am not mistaken.
> > >> But I guess this is not blocking.
> > >>
> > >> Reviewed-by: Matthieu Baerts <matthieu.baerts(a)tessares.net>
> > >
> > > I take it you'd like me to apply patch 1 directly to net?
> >
> > Sorry, I didn't know it was OK to apply only one patch of the series.
> > Then yes, if you don't mind, please apply this patch :)
>
> Not really, I was just establishing ownership ;)
>
> Geliang Tang, please rebase on net and repost just the first patch.
> It does not apply to net as is.

v2 of this patch had been sent out.

http://patchwork.ozlabs.org/project/netdev/patch/078a2ef5bdc4e3b2c25ef85246=
1692001f426495.1604976945.git.geliangtang(a)gmail.com/

This patch should be applied to net-next, not -net. Since commit "mptcp:
add a new sysctl add_addr_timeout" is not applied to -net yet.

-Geliang
--===============7530517404211025944==--
