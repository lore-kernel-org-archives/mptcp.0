Content-Type: multipart/mixed; boundary="===============5691271273505176955=="
MIME-Version: 1.0
From: Matthieu Baerts <matthieu.baerts at tessares.net>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: [PATCH 2/3] mptcp: fix compilation error without IPV6
Date: Thu, 17 Oct 2019 16:22:21 +0200
Message-ID: <6d7cce99-6352-261c-f26b-c1bf21058a7b@tessares.net>
In-Reply-To: 58ec006aee870b478003a6c331fbcf561070dd70.camel@redhat.com
X-Status: 
X-Keywords:                  
X-UID: 2226

--===============5691271273505176955==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Paolo,

Thank you for the review!

On 17/10/2019 16:18, Paolo Abeni wrote:
> On Wed, 2019-10-16 at 18:15 +0200, Matthieu Baerts wrote:
>>    net/mptcp/options.c: In function =E2=80=98mptcp_established_options_a=
ddr=E2=80=99:
>>    net/mptcp/options.c:478:9: error: =E2=80=98struct mptcp_out_options=
=E2=80=99 has no member named =E2=80=98addr6=E2=80=99; did you mean =E2=80=
=98addr=E2=80=99?
>>      478 |   opts->addr6 =3D ((struct sockaddr_in6 *)&saddr)->sin6_addr;
>>          |         ^~~~~
>>          |         addr
>>
>> Signed-off-by: Matthieu Baerts <matthieu.baerts(a)tessares.net>
>> ---
>>
>> Notes:
>>      To squash in "mptcp: Add ADD_ADDR handling"
>>
>>   net/mptcp/options.c | 2 ++
>>   1 file changed, 2 insertions(+)
>>
>> diff --git a/net/mptcp/options.c b/net/mptcp/options.c
>> index c948951509e1..6cfcf2ce44fe 100644
>> --- a/net/mptcp/options.c
>> +++ b/net/mptcp/options.c
>> @@ -470,6 +470,7 @@ static bool mptcp_established_options_addr(struct so=
ck *sk,
>>   		opts->addr_id =3D id;
>>   		opts->addr =3D ((struct sockaddr_in *)&saddr)->sin_addr;
>>   		*size =3D TCPOLEN_MPTCP_ADD_ADDR;
>> +#if IS_ENABLED(CONFIG_IPV6)
>>   	} else if (saddr.ss_family =3D=3D AF_INET6) {
>>   		if (remaining < TCPOLEN_MPTCP_ADD_ADDR6)
>>   			return false;
>> @@ -477,6 +478,7 @@ static bool mptcp_established_options_addr(struct so=
ck *sk,
>>   		opts->addr_id =3D id;
>>   		opts->addr6 =3D ((struct sockaddr_in6 *)&saddr)->sin6_addr;
>>   		*size =3D TCPOLEN_MPTCP_ADD_ADDR6;
>> +#endif
> =

> I think that the preferred codying style here is something alike:
> =

> 		// ipv4 branch
> 	}
> #if IS_ENABLED(CONFIG_IPV6)
> 	else if (/* ... */) {
> 		// ...
> 	}
> #endif
> =

> yep, without the preprocess conditional that would be against the
> codying rules, but looks like checkpatch would be happy here.
> =

> The rationale is that is more clear in both the patch and the resulting
> code what is protected by the conditional.

Fine for me! I copied what was done in net/mptcp/basic.c:75
Do you want me to apply the same change there as well?

Cheers,
Matt
-- =

Matthieu Baerts | R&D Engineer
matthieu.baerts(a)tessares.net
Tessares SA | Hybrid Access Solutions
www.tessares.net
1 Avenue Jean Monnet, 1348 Louvain-la-Neuve, Belgium
--===============5691271273505176955==--
