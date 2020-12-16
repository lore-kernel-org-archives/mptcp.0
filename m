Content-Type: multipart/mixed; boundary="===============6110754942735466597=="
MIME-Version: 1.0
From: Matthieu Baerts <matthieu.baerts at tessares.net>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: [MPTCP][PATCH v3 mptcp-next 0/6] MP_PRIO support
Date: Wed, 16 Dec 2020 23:00:38 +0100
Message-ID: <4a678a3e-8616-c9be-6072-10f5cac5fd53@tessares.net>
In-Reply-To: cover.1607501232.git.geliangtang@gmail.com
X-Status: 
X-Keywords:                  
X-UID: 7197

--===============6110754942735466597==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Geliang, Mat,

On 09/12/2020 09:15, Geliang Tang wrote:
> v3:
>   - drop the MPTCP_PM_ADDR_FLAG_NOBACKUP flag
> =

> v2:
>   - add set_flags command
> =

> v1:
>   - add MP_PRIO PM netlink support

Thank you for the patches and the reviews!

- a56be1da1447: mptcp: add the outgoing MP_PRIO support =

 =

 =


- 661b20bcc670: mptcp: add the incoming MP_PRIO support =

 =

 =


- ef8d4135a450: mptcp: add set_flags command in PM netlink =

 =

 =


- bda492f95f00: selftests: mptcp: add set_flags command in pm_nl_ctl =

 =

 =


- cdd087e12b2f: mptcp: add the mibs for MP_PRIO =

 =

 =


- 6a9e7c4c68db: selftests: mptcp: add the MP_PRIO testcases

- 5b9a80798bf4: "squashed" in "mptcp: add the outgoing MP_PRIO support"

Tests + export have been queued!

> Closes: https://github.com/multipath-tcp/mptcp_net-next/issues/51

Thanks for the link!

Do not forget IPRoute2 patches ;-)
(and ideally packetdrill tests :) )

Cheers,
Matt
-- =

Tessares | Belgium | Hybrid Access Solutions
www.tessares.net
--===============6110754942735466597==--
