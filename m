Content-Type: multipart/mixed; boundary="===============5175654292039490007=="
MIME-Version: 1.0
From: Matthieu Baerts <matthieu.baerts at tessares.net>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: [PATCH v2] mptcp: add some missing pr_fmt defines
Date: Fri, 03 Apr 2020 13:57:48 +0200
Message-ID: <53e4271f-c881-c52d-c6e1-4930a4f6898a@tessares.net>
In-Reply-To: f66ab0b7dfcc895d901e6e85b30f2a21842d2b2c.1585904950.git.geliangtang@gmail.com
X-Status: 
X-Keywords:                  
X-UID: 4137

--===============5175654292039490007==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Geliang,

On 03/04/2020 11:14, Geliang Tang wrote:
> Some of the mptcp logs didn't print out the format string:
> =

> [  185.651493] DSS
> [  185.651494] data_fin=3D0 dsn64=3D0 use_map=3D0 ack64=3D1 use_ack=3D1
> [  185.651494] data_ack=3D13792750332298763796
> [  185.651495] MPTCP: msk=3D00000000c4b81cfc ssk=3D000000009743af53 data_=
avail=3D0 skb=3D0000000063dc595d
> [  185.651495] MPTCP: msk=3D00000000c4b81cfc ssk=3D000000009743af53 statu=
s=3D0
> [  185.651495] MPTCP: msk ack_seq=3D9bbc894565aa2f9a subflow ack_seq=3D9b=
bc894565aa2f9a
> [  185.651496] MPTCP: msk=3D00000000c4b81cfc ssk=3D000000009743af53 data_=
avail=3D1 skb=3D0000000012e809e1
> =

> So this patch added these missing pr_fmt defines. Then we can get the same
> format string "MPTCP" in all mptcp logs like this:
> =

> [  142.795829] MPTCP: DSS
> [  142.795829] MPTCP: data_fin=3D0 dsn64=3D0 use_map=3D0 ack64=3D1 use_ac=
k=3D1
> [  142.795829] MPTCP: data_ack=3D8089704603109242421
> [  142.795830] MPTCP: msk=3D00000000133a24e0 ssk=3D000000002e508c64 data_=
avail=3D0 skb=3D00000000d5f230df
> [  142.795830] MPTCP: msk=3D00000000133a24e0 ssk=3D000000002e508c64 statu=
s=3D0
> [  142.795831] MPTCP: msk ack_seq=3D66790290f1199d9b subflow ack_seq=3D66=
790290f1199d9b
> [  142.795831] MPTCP: msk=3D00000000133a24e0 ssk=3D000000002e508c64 data_=
avail=3D1 skb=3D00000000de5aca2e
> =

> Signed-off-by: Geliang Tang <geliangtang(a)gmail.com>
> =

> ---
> Changes in v2:
>   - add pr_fmt to C files, not headers.

Thank you for this v2 (sorry, it was in my spam folder).

I thought checkpatch.pl would have forced you to add a new blank line in =

net/mptcp/pm.c after the copyright comment and before the beginning of =

the code but it seems not. And there was no blank line before so I guess =

it's OK like that!

Reviewed-by: Matthieu Baerts <matthieu.baerts(a)tessares.net>
--===============5175654292039490007==--
