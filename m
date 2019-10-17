Content-Type: multipart/mixed; boundary="===============7645666319707623331=="
MIME-Version: 1.0
From: Matthieu Baerts <matthieu.baerts at tessares.net>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: [PATCH v2 3/4] mptcp:ipv6: fix code style
Date: Thu, 17 Oct 2019 17:15:33 +0200
Message-ID: <d032b976-2cc2-40f0-64be-a0f6e330b5f4@tessares.net>
In-Reply-To: f825b9931d1306dc8db57e2153be6301478e70cf.camel@redhat.com
X-Status: 
X-Keywords:                  
X-UID: 2218

--===============7645666319707623331==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Paolo,

On 17/10/2019 16:58, Paolo Abeni wrote:
> On Thu, 2019-10-17 at 16:50 +0200, Matthieu Baerts wrote:
>> Suggested-by: Paolo Abeni <pabeni(a)redhat.com>
>> Signed-off-by: Matthieu Baerts <matthieu.baerts(a)tessares.net>
>> ---
>>
>> Notes:
>>      To squash in "mptcp: Add ADD_ADDR handling"
>>
>>   net/mptcp/options.c | 5 +++--
>>   1 file changed, 3 insertions(+), 2 deletions(-)
>>
>> diff --git a/net/mptcp/options.c b/net/mptcp/options.c
>> index 0b5fd3985e86..a3bf62a6620a 100644
>> --- a/net/mptcp/options.c
>> +++ b/net/mptcp/options.c
>> @@ -234,13 +234,14 @@ void mptcp_parse_option(const unsigned char *ptr, =
int opsize,
>>   			memcpy((u8 *)&mp_opt->addr.s_addr, (u8 *)ptr, 4);
>>   			pr_debug("ADD_ADDR: addr=3D%x, id=3D%d",
>>   				 mp_opt->addr.s_addr, mp_opt->addr_id);
>> +		}
>>   #if IS_ENABLED(CONFIG_IPV6)
>> -		} else {
>> +		else {
>>   			mp_opt->add_addr =3D 1;
>>   			memcpy(mp_opt->addr6.s6_addr, (u8 *)ptr, 16);
>>   			pr_debug("ADD_ADDR: addr6=3D, id=3D%d", mp_opt->addr_id);
>> -#endif
>>   		}
>> +#endif
>>   		break;
>>   =

>>   	/* MPTCPOPT_RM_ADDR
> =

> I referred to this one, sorry for providing the wrong reference in the
> previous email. LGTM, thanks

Thank you for the review!

- 0dbee5f41001: patch 3/4
- c8c058e39359: patch 4/4
- 54d4db3445c8: fix alignment

Cheers,
Matt
-- =

Matthieu Baerts | R&D Engineer
matthieu.baerts(a)tessares.net
Tessares SA | Hybrid Access Solutions
www.tessares.net
1 Avenue Jean Monnet, 1348 Louvain-la-Neuve, Belgium
--===============7645666319707623331==--
