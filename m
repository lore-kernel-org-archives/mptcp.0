Content-Type: multipart/mixed; boundary="===============2976304086185657053=="
MIME-Version: 1.0
From: Matthieu Baerts <matthieu.baerts at tessares.net>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: [MPTCP][PATCH v3 mptcp-next 0/6] MP_PRIO support
Date: Thu, 17 Dec 2020 09:02:44 +0100
Message-ID: <6eec2135-ea61-4ab3-6875-5e6ee405a8c0@tessares.net>
In-Reply-To: 4a678a3e-8616-c9be-6072-10f5cac5fd53@tessares.net
X-Status: 
X-Keywords:                  
X-UID: 7204

--===============2976304086185657053==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Geliang,

On 16/12/2020 23:00, Matthieu Baerts wrote:
> Hi Geliang, Mat,
> =

> On 09/12/2020 09:15, Geliang Tang wrote:
>> v3:
>> =C2=A0 - drop the MPTCP_PM_ADDR_FLAG_NOBACKUP flag
>>
>> v2:
>> =C2=A0 - add set_flags command
>>
>> v1:
>> =C2=A0 - add MP_PRIO PM netlink support
> =

> Thank you for the patches and the reviews!
> =

> - a56be1da1447: mptcp: add the outgoing MP_PRIO support

I had to do a small extra modification:

- 3614352825d7: mptcp: fix compilation warning

> - 661b20bcc670: mptcp: add the incoming MP_PRIO support
> - ef8d4135a450: mptcp: add set_flags command in PM netlink
> - bda492f95f00: selftests: mptcp: add set_flags command in pm_nl_ctl
> - cdd087e12b2f: mptcp: add the mibs for MP_PRIO

- 3f23b36e8d05: Revert "mptcp: fix compilation warning"

Now each topic compiles without warning.

- Results: ce539249b370..60eae9e2e048
(empty, as expected)

Cheers,
Matt
-- =

Tessares | Belgium | Hybrid Access Solutions
www.tessares.net
--===============2976304086185657053==--
