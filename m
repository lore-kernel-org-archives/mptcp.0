Content-Type: multipart/mixed; boundary="===============6744285452891679586=="
MIME-Version: 1.0
From: Jakub Kicinski <kuba at kernel.org>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: [PATCH net] mptcp: provide rmem[0] limit
Date: Mon, 09 Nov 2020 17:36:32 -0800
Message-ID: <20201109173632.21c7045b@kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com>
In-Reply-To: d49c966b-e2fe-e0c9-49ea-a7a2475f45cf@tessares.net
X-Status: 
X-Keywords:                  
X-UID: 6620

--===============6744285452891679586==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On Mon, 9 Nov 2020 18:20:50 +0100 Matthieu Baerts wrote:
> On 08/11/2020 19:49, Paolo Abeni wrote:
> > The mptcp proto struct currently does not provide the
> > required limit for forward memory scheduling. Under
> > pressure sk_rmem_schedule() will unconditionally try
> > to use such field and will oops.
> > =

> > Address the issue inheriting the tcp limit, as we already
> > do for the wmem one.
> > =

> > Fixes: ("mptcp: add missing memory scheduling in the rx path")
> > Signed-off-by: Paolo Abeni <pabeni(a)redhat.com>  =

> =

> Good catch, thank you for this patch!
> =

> Reviewed-by: Matthieu Baerts <matthieu.baerts(a)tessares.net>

Fixed up the tag and applied, thanks!
--===============6744285452891679586==--
