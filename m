Content-Type: multipart/mixed; boundary="===============5629270635002597810=="
MIME-Version: 1.0
From: Matthieu Baerts <matthieu.baerts at tessares.net>
To: mptcp at lists.01.org
Subject: Re: [MPTCP] [PATCH] mptcp: Add explicit check for protocol version
Date: Wed, 22 May 2019 18:28:17 +0200
Message-ID: <01a07be7-dfd8-134f-31ee-335459ea088c@tessares.net>
In-Reply-To: alpine.OSX.2.21.1905220750320.28292@cwhilton-mobl1.amr.corp.intel.com
X-Status: 
X-Keywords:                  
X-UID: 1219

--===============5629270635002597810==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Peter, Mat,

On 22/05/2019 16:54, Mat Martineau wrote:
> =

> On Tue, 21 May 2019, Peter Krystad wrote:
> =

>> Currently only MPTCP v0 is supported so ignore v1 MP_CAPABLE option.
>>
>> Also, make sure zeros are shifted to the correct position...
>>
>> Squash to "Handle MPTCP TCP options".
>>
> =

> Thanks Peter, patch looks ready to merge.

Thank you for the fix and the review!

Just squashed as asked.

- squash: 06eaaf5cd641 (with a small conflict)
- update of the commit message: b14c889ea79c (mention which version is
supported)
- conflict: 6ffdacc999da (opposite as before)
- result: 182f21f25f6a..bcf4fe51494f (from TopGit)
- exported commit: 09df85bafe0f

Cheers,
Matt

> =

> =

> Mat
> =

> =

>> Signed-off-by: Peter Krystad <peter.krystad(a)linux.intel.com>
>> ---
>> net/mptcp/options.c | 9 ++++++---
>> 1 file changed, 6 insertions(+), 3 deletions(-)
>>
>> diff --git a/net/mptcp/options.c b/net/mptcp/options.c
>> index c71e40f6f06a..9b9b9c9390c1 100644
>> --- a/net/mptcp/options.c
>> +++ b/net/mptcp/options.c
>> @@ -30,8 +30,11 @@ void mptcp_parse_option(const unsigned char *ptr,
>> int opsize,
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 break;
>>
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 pr_debug("MP_CAPABLE");
>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 opt_rx->mptcp.mp_capable =3D=
 1;
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 opt_rx->mptcp.version =3D *pt=
r++ & MPTCPOPT_VERSION_MASK;
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (opt_rx->mptcp.version !=
=3D 0)
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 brea=
k;
>> +
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 opt_rx->mptcp.mp_capable =3D=
 1;
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 pr_debug("flags=3D%02x", *ptr=
);
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 opt_rx->mptcp.flags =3D *ptr+=
+;
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 opt_rx->mptcp.sndr_key =3D ge=
t_unaligned_be64(ptr);
>> @@ -399,8 +402,8 @@ void mptcp_write_options(__be32 *ptr, struct
>> mptcp_out_options *opts)
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 len =
=3D TCPOLEN_MPTCP_MPC_ACK;
>>
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 *ptr++ =3D htonl((TCPOPT_MPTC=
P << 24) | (len << 16) |
>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 (MPTCPOPT_MP_CAPABLE << 20) |
>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ((MPTCPOPT_VERSION_MASK & 0) << 16)=
 |
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 (MPTCPOPT_MP_CAPABLE << 12) |
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ((MPTCPOPT_VERSION_MASK & 0) << 8) |
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 MPTCP_CAP_HMAC_SHA1);
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 put_unaligned_be64(opts->sndr=
_key, ptr);
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ptr +=3D 2;
>> --=C2=A0
>> 2.17.2
> =

> -- =

> Mat Martineau
> Intel
> _______________________________________________
> mptcp mailing list
> mptcp(a)lists.01.org
> https://lists.01.org/mailman/listinfo/mptcp

-- =

Matthieu Baerts | R&D Engineer
matthieu.baerts(a)tessares.net
Tessares SA | Hybrid Access Solutions
www.tessares.net
1 Avenue Jean Monnet, 1348 Louvain-la-Neuve, Belgium

--===============5629270635002597810==--
