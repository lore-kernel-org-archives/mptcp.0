Content-Type: multipart/mixed; boundary="===============2198485017687585817=="
MIME-Version: 1.0
From: Geliang Tang <geliangtang at gmail.com>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: [PATCH] mptcp: move pr_fmt defining to protocol.h
Date: Fri, 03 Apr 2020 19:41:58 +0800
Message-ID: <20200403114157.GA10201@OptiPlex>
In-Reply-To: 9674b6ce-3888-557e-8f32-230671363903@tessares.net
X-Status: 
X-Keywords:                  
X-UID: 4135

--===============2198485017687585817==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On Fri, Apr 03, 2020 at 12:29:27PM +0200, Matthieu Baerts wrote:
> Hi Geliang,
> =

> On 03/04/2020 09:57, Geliang Tang wrote:
> > Some of the mptcp logs didn't print out the format string "MPTCP":
> > =

> > [  129.185774] DSS
> > [  129.185774] data_fin=3D0 dsn64=3D1 use_map=3D1 ack64=3D1 use_ack=3D1
> > [  129.185774] data_ack=3D5481534886531492085
> > [  129.185775] data_seq=3D15725204003114694615 subflow_seq=3D1425409 da=
ta_len=3D5216
> > [  129.185776] subflow=3D0000000093526a92 fully established=3D1 seq=3D0=
:0 remaining=3D28
> > [  129.185776] MPTCP: msk=3D00000000d5a704a6 ssk=3D00000000b5aabc31 dat=
a_avail=3D0 skb=3D0000000088f05424
> > [  129.185777] MPTCP: seq=3D15725204003114694615 is64=3D1 ssn=3D1425409=
 data_len=3D5216 data_fin=3D0
> > [  129.185777] MPTCP: msk=3D00000000d5a704a6 ssk=3D00000000b5aabc31 sta=
tus=3D0
> > [  129.185778] MPTCP: msk ack_seq=3Dda3b25b9a233c2c7 subflow ack_seq=3D=
da3b25b9a233c2c7
> > [  129.185778] MPTCP: msk=3D00000000d5a704a6 ssk=3D00000000b5aabc31 dat=
a_avail=3D1 skb=3D000000000caed2cc
> > [  129.185779] subflow=3D0000000093526a92 fully established=3D1 seq=3D0=
:0 remaining=3D28
> > =

> > So this patch moves the pr_fmt defining from protocol.c to protocol.h, =
which
> > is included by all the C files. Then we can get the same format string
> > "MPTCP" in all mptcp logs like this:
> > =

> > [  141.854787] MPTCP: DSS
> > [  141.854788] MPTCP: data_fin=3D0 dsn64=3D1 use_map=3D1 ack64=3D1 use_=
ack=3D1
> > [  141.854788] MPTCP: data_ack=3D18028325517710311871
> > [  141.854788] MPTCP: data_seq=3D6163976859259356786 subflow_seq=3D3309=
569 data_len=3D8192
> > [  141.854789] MPTCP: msk=3D000000005847a66a ssk=3D0000000022469903 dat=
a_avail=3D0 skb=3D00000000dd95efc3
> > [  141.854789] MPTCP: seq=3D6163976859259356786 is64=3D1 ssn=3D3309569 =
data_len=3D8192 data_fin=3D0
> > [  141.854790] MPTCP: msk=3D000000005847a66a ssk=3D0000000022469903 sta=
tus=3D0
> > [  141.854790] MPTCP: msk ack_seq=3D558ad84b9be1d162 subflow ack_seq=3D=
558ad84b9be1d162
> > [  141.854791] MPTCP: msk=3D000000005847a66a ssk=3D0000000022469903 dat=
a_avail=3D1 skb=3D000000000b8926f6
> > [  141.854791] MPTCP: subflow=3D00000000e4e4579c fully established=3D1 =
seq=3D0:0 remaining=3D28
> > [  141.854792] MPTCP: subflow=3D00000000e4e4579c fully established=3D1 =
seq=3D0:dcdf2f3b remaining=3D28
> =

> Good idea to uniform that.
> I think it can be useful for MPTCP devs to add a different prefix in each
> MPTCP .c files but this small improvement can be done later.
> =

> LGTM, thanks Geliang!
> =

> Reviewed-by: Matthieu Baerts <matthieu.baerts(a)tessares.net>

Hi Matthieu,

Thanks for your reply.

I have already resend this patch to you, a better version, v2, added pr_fmt
in each .c files.

-Geliang
--===============2198485017687585817==--
