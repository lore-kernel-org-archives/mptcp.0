Content-Type: multipart/mixed; boundary="===============4074640921553127028=="
MIME-Version: 1.0
From: Matthieu Baerts <matthieu.baerts at tessares.net>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: [MPTCP][PATCH v2 mptcp-next 0/2] remove address when
 netlink flush addrs and testcase
Date: Fri, 04 Dec 2020 18:06:00 +0100
Message-ID: <3ae1f16b-7f02-e07b-27cb-e84cfe1133e8@tessares.net>
In-Reply-To: cover.1606719598.git.geliangtang@gmail.com
X-Status: 
X-Keywords:                  
X-UID: 7053

--===============4074640921553127028==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Geliang, Paolo, Mat,

On 30/11/2020 08:11, Geliang Tang wrote:
> v2:
>   - update the testcase.
> =

> This patchset removes address when netlink do flush addrs command, and
> adds the testcase for flush addrs command.
> =

> Geliang Tang (2):
>    mptcp: remove address when netlink flush addrs
>    selftests: mptcp: add the flush addrs testcase

Thank you for the patches and the reviews!

For both, I added Paolo's Acked-by and Mat's Reviewed-by tags. I hope I =

properly understood the answers!

These two patches have been applied after other patches from Geliang.

- 104e1f51ec45: mptcp: remove address when netlink flushes addrs
- 56330abd80b3: selftests: mptcp: add the flush addrs testcase
- Results: 8e81e32d0db6..f8649f5ba21e

Tests + export will be started soon!

Cheers,
Matt
-- =

Tessares | Belgium | Hybrid Access Solutions
www.tessares.net
--===============4074640921553127028==--
