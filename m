Content-Type: multipart/mixed; boundary="===============0992995080936240994=="
MIME-Version: 1.0
From: Matthieu Baerts <matthieu.baerts at tessares.net>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: [PATCH net v2] mptcp: drop MPTCP_PM_MAX_ADDR
Date: Mon, 15 Jun 2020 12:29:06 +0200
Message-ID: <dace6dec-e908-4bf8-f98e-cbec6c2a0f62@tessares.net>
In-Reply-To: 8d8984e8f73e37c87e69459fdef12fe9bab80949.1592209282.git.geliangtang@gmail.com
X-Status: 
X-Keywords:                  
X-UID: 4676

--===============0992995080936240994==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Geliang,

On 15/06/2020 10:28, Geliang Tang wrote:
> We have defined MPTCP_PM_ADDR_MAX in pm_netlink.c, so drop this duplicate=
 macro.
> =

> Fixes: 1b1c7a0ef7f3 ("mptcp: Add path manager interface")
> Signed-off-by: Geliang Tang <geliangtang(a)gmail.com>
> ---
>   Changes in v2:
>    - change Subject from "mptcp: unify MPTCP_PM_MAX_ADDR and MPTCP_PM_ADD=
R_MAX"

Thank you for this v2, it looks good to me!

Reviewed-by: Matthieu Baerts <matthieu.baerts(a)tessares.net>

Cheers,
Matt
-- =

Tessares | Belgium | Hybrid Access Solutions
www.tessares.net
--===============0992995080936240994==--
