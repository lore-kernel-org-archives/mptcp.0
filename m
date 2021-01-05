Content-Type: multipart/mixed; boundary="===============1744276051870209546=="
MIME-Version: 1.0
From: Geliang Tang <geliangtang at gmail.com>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: [MPTCP][PATCH v3 mptcp-next 1/4] mptcp: drop *_max fields
 in mptcp_pm_data
Date: Tue, 05 Jan 2021 12:18:25 +0800
Message-ID: <CA+WQbwupiRLxvhL-bogzkB=Vx3vZhejKCqAYVQkbw9E-QjL6-g@mail.gmail.com>
In-Reply-To: 338eef4340087881e1a0e506e69e30872cc6e3fb.1609819265.git.geliangtang@gmail.com
X-Status: 
X-Keywords:                  
X-UID: 7255

--===============1744276051870209546==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Geliang Tang <geliangtang(a)gmail.com> =E4=BA=8E2021=E5=B9=B41=E6=9C=885=E6=
=97=A5=E5=91=A8=E4=BA=8C =E4=B8=8B=E5=8D=8812:05=E5=86=99=E9=81=93=EF=BC=9A
>
> This patch dropped the per-msk values add_addr_signal_max, add_addr_accep=
t_max,
> local_addr_max and subflows_max fields in struct mptcp_pm_data, used the =
pernet
> *_max values instead. And added four new helpers to get the pernet *_max =
values
> separately.
>

Sorry, there's a checkpatch.pl warning here:

WARNING: Possible unwrapped commit description (prefer a maximum 75
chars per line)
#13:
local_addr_max and subflows_max fields in struct mptcp_pm_data, used the pe=
rnet


Please update the commit message:

---
This patch dropped the per-msk values add_addr_signal_max,
add_addr_accept_max, local_addr_max and subflows_max fields in struct
mptcp_pm_data, used the pernet *_max values instead. And added four new
helpers to get the pernet *_max values separately.
---

Thanks.

-Geliang
--===============1744276051870209546==--
