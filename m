Content-Type: multipart/mixed; boundary="===============3143183502687601586=="
MIME-Version: 1.0
From: Matthieu Baerts <matthieu.baerts at tessares.net>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: [PATCH v2 mptcp-next 2/3] mptcp: only admit explicitly
 supported sockopt
Date: Sat, 06 Mar 2021 08:30:13 +0100
Message-ID: <f08b6167-4091-e301-d734-c7128045f317@tessares.net>
In-Reply-To: 97149f97-86c1-6970-8893-bc5e3a81a2ee@linux.intel.com
X-Status: 
X-Keywords:                  
X-UID: 8056

--===============3143183502687601586==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Paolo, Mat,

On 06/03/2021 00:39, Mat Martineau wrote:
> On Fri, 5 Mar 2021, Paolo Abeni wrote:

Thank you for the nice work and the reviews!

(...)

 >> +        /* the following 23 need a better implementation,
 >> +         * but are quite common we want to preserve them
 >> +         */

Maybe we should avoid writing numbers (23) here. It is likely something =

we will forget to update and I don't think they are needed. Same below: =

ten, nine, 14, one, 2, 18.

>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 /* SO_OOBINLINE is not suppo=
rted, let's avoid the related =

>> mess */
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 /* SO_ATTACH_FILTER, SO_ATTA=
CH_BPF, SO_ATTACH_REUSEPORT_CBPF,
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * SO_DETACH_REUSEPORT_=
BPF, SO_DETACH_FILTER, SO_LOCK_FILTER,
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * we must be careful w=
ith subflows
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 */
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 /* SO_ATTACH_REUSEPORT_EBPF =
is not supported, at it checks
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * explicitly the sk_pr=
otocol field
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 */
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 /* SO_PEEK_OFF is unsupporte=
d, as it is for plain TCP */
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 /* SO_MAX_PACING_RATE is uns=
upported, we must be careful with =

>> subflows */
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 /* SO_CNX_ADVICE is currentl=
y unsupported, could possibly be =

>> relevant,
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * but likely needs car=
eful design
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 */
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 /* SO_ZEROCOPY is currently =
unsupported, TODO in sndmsg */
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 /* SO_TXTIME is currently un=
supported */
> =

> The formatting here made the intent less clear - if you move the above =

> block comments were after these lines:
> =

>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 retu=
rn true;
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
> =

> ...it would be a lot more clear that the mentioned options are attached =

> to the "return false;", and the case labels are for the "return true".
> =

> (this applies to the other SOL levels too)

Should we eventually add notes somewhere -- socket.h, in.h, in6.h, tcp.h =

-- to ask other devs to eventually contact us when new sockopt are being =

added?
Not sure it is something common to do but it can be useful for us and =

these devs.

Cheers,
Matt
-- =

Tessares | Belgium | Hybrid Access Solutions
www.tessares.net
--===============3143183502687601586==--
