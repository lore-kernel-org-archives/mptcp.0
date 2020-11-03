Content-Type: multipart/mixed; boundary="===============8597837532847781570=="
MIME-Version: 1.0
From: Jakub Kicinski <kuba at kernel.org>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: [PATCH net] mptcp: token: fix unititialized variable
Date: Tue, 03 Nov 2020 13:10:23 -0800
Message-ID: <20201103131023.7deabb3e@kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com>
In-Reply-To: 97343b07772ae794ca2aad683734901c055aa0ab.camel@redhat.com
X-Status: 
X-Keywords:                  
X-UID: 6535

--===============8597837532847781570==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On Mon, 02 Nov 2020 11:48:25 +0100 Paolo Abeni wrote:
> On Mon, 2020-11-02 at 10:09 +0100, Davide Caratti wrote:
> > gcc complains about use of uninitialized 'num'. Fix it by doing the fir=
st
> > assignment of 'num' when the variable is declared.
> > =

> > Fixes: 96d890daad05 ("mptcp: add msk interations helper")
> > Signed-off-by: Davide Caratti <dcaratti(a)redhat.com>
> =

> Acked-by: Paolo Abeni <pabeni(a)redhat.com>

Applied, thanks!
--===============8597837532847781570==--
