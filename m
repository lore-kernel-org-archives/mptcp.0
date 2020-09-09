Content-Type: multipart/mixed; boundary="===============8969398942519726918=="
MIME-Version: 1.0
From: Matthieu Baerts <matthieu.baerts at tessares.net>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: [MPTCP][PATCH v2 net 1/2] mptcp: fix subflow's local_id
 issues
Date: Wed, 09 Sep 2020 16:39:51 +0200
Message-ID: <c1537a78-c2b6-383b-f2fb-817c35bbfdaa@tessares.net>
In-Reply-To: 110eaa273bf313fb1a2a668a446956d27aba05a8.1599532593.git.geliangtang@gmail.com
X-Status: 
X-Keywords:                  
X-UID: 5771

--===============8969398942519726918==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Geliang,

On 08/09/2020 04:49, Geliang Tang wrote:
> In mptcp_pm_nl_get_local_id, skc_local is the same as msk_local, so it
> always return 0. Thus every subflow's local_id is 0. It's incorrect.
> =

> This patch fixed this issue.
> =

> Also, we need to ignore the zero address here, like 0.0.0.0 in IPv4. When
> we use the zero address as a local address, it means that we can use any
> one of the local addresses. The zero address is not a new address, we don=
't
> need to add it to PM, so this patch added a new function address_zero to
> check whether an address is the zero address, if it is, we ignore this
> address.
> =

> Fixes: 01cacb00b35cb ("mptcp: add netlink-based PM")
> Signed-off-by: Geliang Tang <geliangtang(a)gmail.com>

Thank you for the v2!

Reviewed-by: Matthieu Baerts <matthieu.baerts(a)tessares.net>

Cheers,
Matt
-- =

Tessares | Belgium | Hybrid Access Solutions
www.tessares.net
--===============8969398942519726918==--
