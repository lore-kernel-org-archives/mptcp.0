Content-Type: multipart/mixed; boundary="===============2788950548475253531=="
MIME-Version: 1.0
From: Jakub Kicinski <kuba at kernel.org>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: [PATCH net] mptcp: depends on IPV6 but not as a module
Date: Wed, 21 Oct 2020 08:08:36 -0700
Message-ID: <20201021080836.5ad77e45@kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com>
In-Reply-To: 20201021105154.628257-1-matthieu.baerts@tessares.net
X-Status: 
X-Keywords:                  
X-UID: 6392

--===============2788950548475253531==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On Wed, 21 Oct 2020 12:51:53 +0200 Matthieu Baerts wrote:
> Like TCP, MPTCP cannot be compiled as a module. Obviously, MPTCP IPv6'
> support also depends on CONFIG_IPV6. But not all functions from IPv6
> code are exported.
> =

> To simplify the code and reduce modifications outside MPTCP, it was
> decided from the beginning to support MPTCP with IPv6 only if
> CONFIG_IPV6 was built inlined. That's also why CONFIG_MPTCP_IPV6 was
> created. More modifications are needed to support CONFIG_IPV6=3Dm.

Applied, thanks!
--===============2788950548475253531==--
