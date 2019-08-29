Content-Type: multipart/mixed; boundary="===============5486289013519975616=="
MIME-Version: 1.0
From: Matthieu Baerts <matthieu.baerts at tessares.net>
To: mptcp at lists.01.org
Subject: Re: [MPTCP] [PATCH 2/2] mptcp: Modify pm_create_subflow to use
 in_addr in network byte order
Date: Thu, 29 Aug 2019 15:39:28 +0200
Message-ID: <9cafd0cb-4878-9466-7cd2-2d96005ae6b8@tessares.net>
In-Reply-To: alpine.OSX.2.21.1908271137300.10328@aaggar2-mobl.amr.corp.intel.com
X-Status: 
X-Keywords:                  
X-UID: 1760

--===============5486289013519975616==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Peter, Mat,

On 27/08/2019 20:37, Mat Martineau wrote:
> =

> On Fri, 23 Aug 2019, Peter Krystad wrote:
> =

>> squashto: Implement path manager interface commands
>>
>> Signed-off-by: Peter Krystad <peter.krystad(a)linux.intel.com>
>> ---
>> net/mptcp/pm.c | 2 +-
>> 1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/net/mptcp/pm.c b/net/mptcp/pm.c
>> index c98b92512adf..bc07376a823b 100644
>> --- a/net/mptcp/pm.c
>> +++ b/net/mptcp/pm.c
>> @@ -73,7 +73,7 @@ int pm_create_subflow(u32 token, u8 remote_id)
>>
>> =C2=A0=C2=A0=C2=A0=C2=A0remote.sin_family =3D msk->pm.remote_family;
>> =C2=A0=C2=A0=C2=A0=C2=A0remote.sin_port =3D htons(msk->dport);
>> -=C2=A0=C2=A0=C2=A0 remote.sin_addr.s_addr =3D htonl(msk->pm.remote_addr=
.s_addr);
>> +=C2=A0=C2=A0=C2=A0 remote.sin_addr.s_addr =3D msk->pm.remote_addr.s_add=
r;
>>
>> =C2=A0=C2=A0=C2=A0=C2=A0err =3D subflow_connect((struct sock *)msk, &loc=
al, &remote,
>> remote_id);
>>
>> --=C2=A0
>> 2.17.2
> =

> Both patches look good. Thanks.

Thank you for the patches and the reviews!

- 773d308c2033: "squashed" the first patch in "mptcp: Add ADD_ADDR handling"
- 722d13a45004: "squashed" the second one in "mptcp: Implement path
manager interface commands"
- "signed-off" were already there.
- b94f6125bd9a..695f625aa913: result

Tests are still OK!

Cheers,
Matt

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

--===============5486289013519975616==--
