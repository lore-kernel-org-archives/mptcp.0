Content-Type: multipart/mixed; boundary="===============5242806728414534457=="
MIME-Version: 1.0
From: David Miller <davem at davemloft.net>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: [PATCH net v2] mptcp: drop MPTCP_PM_MAX_ADDR
Date: Mon, 15 Jun 2020 13:01:38 -0700
Message-ID: <20200615.130138.1884447953526283666.davem@davemloft.net>
In-Reply-To: 8d8984e8f73e37c87e69459fdef12fe9bab80949.1592209282.git.geliangtang@gmail.com
X-Status: 
X-Keywords:                  
X-UID: 4682

--===============5242806728414534457==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

From: Geliang Tang <geliangtang(a)gmail.com>
Date: Mon, 15 Jun 2020 16:28:03 +0800

> We have defined MPTCP_PM_ADDR_MAX in pm_netlink.c, so drop this duplicate=
 macro.
> =

> Fixes: 1b1c7a0ef7f3 ("mptcp: Add path manager interface")
> Signed-off-by: Geliang Tang <geliangtang(a)gmail.com>
> ---
>  Changes in v2:
>   - change Subject from "mptcp: unify MPTCP_PM_MAX_ADDR and MPTCP_PM_ADDR=
_MAX"

Applied, thank you.
--===============5242806728414534457==--
