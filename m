Content-Type: multipart/mixed; boundary="===============5615379125255787678=="
MIME-Version: 1.0
From: Jakub Kicinski <kuba at kernel.org>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: [PATCH] mptcp: MPTCP_KUNIT_TESTS should depend on MPTCP
 instead of selecting it
Date: Tue, 20 Oct 2020 16:55:33 -0700
Message-ID: <20201020165533.367acc4a@kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com>
In-Reply-To: 1968b7a6-a553-c882-c386-4b4fde2d7a87@tessares.net
X-Status: 
X-Keywords:                  
X-UID: 6373

--===============5615379125255787678==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On Mon, 19 Oct 2020 17:47:20 +0200 Matthieu Baerts wrote:
> On 19/10/2020 13:32, Geert Uytterhoeven wrote:
> > MPTCP_KUNIT_TESTS selects MPTCP, thus enabling an optional feature the
> > user may not want to enable.  Fix this by making the test depend on
> > MPTCP instead.  =

> =

> Reviewed-by: Matthieu Baerts <matthieu.baerts(a)tessares.net>

Applied, thanks!
--===============5615379125255787678==--
