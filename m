Content-Type: multipart/mixed; boundary="===============0434101413121180271=="
MIME-Version: 1.0
From: Matthieu Baerts <matthieu.baerts at tessares.net>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: [MPTCP][PATCH v2 net 2/2] mptcp: fix subflow's remote_id
 issues
Date: Wed, 09 Sep 2020 16:39:54 +0200
Message-ID: <4c6c23fc-f493-ce9e-953f-679109de5fc8@tessares.net>
In-Reply-To: 0127c08400bdf65c03438b0b6e90e4ab72ea1576.1599532593.git.geliangtang@gmail.com
X-Status: 
X-Keywords:                  
X-UID: 5772

--===============0434101413121180271==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Geliang,

On 08/09/2020 04:49, Geliang Tang wrote:
> This patch set the init remote_id to zero, otherwise it will be a random
> number.
> =

> Then it added the missing subflow's remote_id setting code both in
> __mptcp_subflow_connect and in subflow_ulp_clone.
> =

> Fixes: 01cacb00b35cb ("mptcp: add netlink-based PM")
> Fixes: ec3edaa7ca6ce ("mptcp: Add handling of outgoing MP_JOIN requests")
> Fixes: f296234c98a8f ("mptcp: Add handling of incoming MP_JOIN requests")
> Signed-off-by: Geliang Tang <geliangtang(a)gmail.com>

Thank you for the v2!

Reviewed-by: Matthieu Baerts <matthieu.baerts(a)tessares.net>

Cheers,
Matt
-- =

Tessares | Belgium | Hybrid Access Solutions
www.tessares.net
--===============0434101413121180271==--
