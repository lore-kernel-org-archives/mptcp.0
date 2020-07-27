Content-Type: multipart/mixed; boundary="===============1488065956731223691=="
MIME-Version: 1.0
From: Stephen Hemminger <stephen at networkplumber.org>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: [PATCH iproute2] mptcp: show all endpoints when no ID is
 specified
Date: Mon, 27 Jul 2020 16:44:04 -0700
Message-ID: <20200727164404.05fc033f@hermes.lan>
In-Reply-To: 20200724121718.2180511-1-matthieu.baerts@tessares.net
X-Status: 
X-Keywords:                  
X-UID: 5334

--===============1488065956731223691==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On Fri, 24 Jul 2020 14:17:18 +0200
Matthieu Baerts <matthieu.baerts(a)tessares.net> wrote:

> According to 'ip mptcp help', 'endpoint show' can accept no argument:
> =

>   ip mptcp endpoint show [ id ID ]
> =

> It makes sense to print all endpoints when no filter is used.
> =

> So here if the following command is used, all endpoints are printed:
> =

>   ip mptcp endpoint show
> =

> Same as:
> =

>   ip mptcp endpoint
> =

> Fixes: 7e0767cd ("add support for mptcp netlink interface")
> Signed-off-by: Matthieu Baerts <matthieu.baerts(a)tessares.net>

Applied thanks
--===============1488065956731223691==--
