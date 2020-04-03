Content-Type: multipart/mixed; boundary="===============4428787081713249478=="
MIME-Version: 1.0
From: Matthieu Baerts <matthieu.baerts at tessares.net>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: [PATCH] mptcp: move pr_fmt defining to protocol.h
Date: Fri, 03 Apr 2020 12:29:27 +0200
Message-ID: <9674b6ce-3888-557e-8f32-230671363903@tessares.net>
In-Reply-To: 34c83a5fe561739c7b85a3c4959eb44c3155d075.1585899578.git.geliangtang@gmail.com
X-Status: 
X-Keywords:                  
X-UID: 4134

--===============4428787081713249478==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Geliang,

On 03/04/2020 09:57, Geliang Tang wrote:
> Some of the mptcp logs didn't print out the format string "MPTCP":
> =

> [  129.185774] DSS
> [  129.185774] data_fin=3D0 dsn64=3D1 use_map=3D1 ack64=3D1 use_ack=3D1
> [  129.185774] data_ack=3D5481534886531492085
> [  129.185775] data_seq=3D15725204003114694615 subflow_seq=3D1425409 data=
_len=3D5216
> [  129.185776] subflow=3D0000000093526a92 fully established=3D1 seq=3D0:0=
 remaining=3D28
> [  129.185776] MPTCP: msk=3D00000000d5a704a6 ssk=3D00000000b5aabc31 data_=
avail=3D0 skb=3D0000000088f05424
> [  129.185777] MPTCP: seq=3D15725204003114694615 is64=3D1 ssn=3D1425409 d=
ata_len=3D5216 data_fin=3D0
> [  129.185777] MPTCP: msk=3D00000000d5a704a6 ssk=3D00000000b5aabc31 statu=
s=3D0
> [  129.185778] MPTCP: msk ack_seq=3Dda3b25b9a233c2c7 subflow ack_seq=3Dda=
3b25b9a233c2c7
> [  129.185778] MPTCP: msk=3D00000000d5a704a6 ssk=3D00000000b5aabc31 data_=
avail=3D1 skb=3D000000000caed2cc
> [  129.185779] subflow=3D0000000093526a92 fully established=3D1 seq=3D0:0=
 remaining=3D28
> =

> So this patch moves the pr_fmt defining from protocol.c to protocol.h, wh=
ich
> is included by all the C files. Then we can get the same format string
> "MPTCP" in all mptcp logs like this:
> =

> [  141.854787] MPTCP: DSS
> [  141.854788] MPTCP: data_fin=3D0 dsn64=3D1 use_map=3D1 ack64=3D1 use_ac=
k=3D1
> [  141.854788] MPTCP: data_ack=3D18028325517710311871
> [  141.854788] MPTCP: data_seq=3D6163976859259356786 subflow_seq=3D330956=
9 data_len=3D8192
> [  141.854789] MPTCP: msk=3D000000005847a66a ssk=3D0000000022469903 data_=
avail=3D0 skb=3D00000000dd95efc3
> [  141.854789] MPTCP: seq=3D6163976859259356786 is64=3D1 ssn=3D3309569 da=
ta_len=3D8192 data_fin=3D0
> [  141.854790] MPTCP: msk=3D000000005847a66a ssk=3D0000000022469903 statu=
s=3D0
> [  141.854790] MPTCP: msk ack_seq=3D558ad84b9be1d162 subflow ack_seq=3D55=
8ad84b9be1d162
> [  141.854791] MPTCP: msk=3D000000005847a66a ssk=3D0000000022469903 data_=
avail=3D1 skb=3D000000000b8926f6
> [  141.854791] MPTCP: subflow=3D00000000e4e4579c fully established=3D1 se=
q=3D0:0 remaining=3D28
> [  141.854792] MPTCP: subflow=3D00000000e4e4579c fully established=3D1 se=
q=3D0:dcdf2f3b remaining=3D28

Good idea to uniform that.
I think it can be useful for MPTCP devs to add a different prefix in =

each MPTCP .c files but this small improvement can be done later.

LGTM, thanks Geliang!

Reviewed-by: Matthieu Baerts <matthieu.baerts(a)tessares.net>
--===============4428787081713249478==--
