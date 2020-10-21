Content-Type: multipart/mixed; boundary="===============4910618182655999671=="
MIME-Version: 1.0
From: Jakub Kicinski <kuba at kernel.org>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: [PATCH] mptcp: MPTCP_IPV6 should depend on IPV6 instead
 of selecting it
Date: Tue, 20 Oct 2020 20:56:47 -0700
Message-ID: <20201020205647.20ab7009@kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com>
In-Reply-To: 5dddd3fe-86d7-d07f-dbc9-51b89c7c8173@tessares.net
X-Status: 
X-Keywords:                  
X-UID: 6377

--===============4910618182655999671==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On Tue, 20 Oct 2020 11:26:34 +0200 Matthieu Baerts wrote:
> On 20/10/2020 09:38, Geert Uytterhoeven wrote:
> > MPTCP_IPV6 selects IPV6, thus enabling an optional feature the user may
> > not want to enable.  Fix this by making MPTCP_IPV6 depend on IPV6, like
> > is done for all other IPv6 features.  =

> =

> Here again, the intension was to select IPv6 from MPTCP but I understand =

> the issue: if we enable MPTCP, we will select IPV6 as well by default. =

> Maybe not what we want on some embedded devices with very limited memory =

> where IPV6 is already off. We should instead enable MPTCP_IPV6 only if =

> IPV6=3Dy. LGTM then!
> =

> Reviewed-by: Matthieu Baerts <matthieu.baerts(a)tessares.net>

Applied, thanks!
--===============4910618182655999671==--
