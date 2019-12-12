Content-Type: multipart/mixed; boundary="===============1622027394413794325=="
MIME-Version: 1.0
From: Matthieu Baerts <matthieu.baerts at tessares.net>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: [PATCH] mptcp: Remove request_version field from
 subflow_request_sock
Date: Thu, 12 Dec 2019 23:29:02 +0100
Message-ID: <f14304b5-1ab5-c0b6-26f3-6cf4967e98e2@tessares.net>
In-Reply-To: b2c7750964ea43d50bab0abb4442fc44619ed359.camel@linux.intel.com
X-Status: 
X-Keywords:                  
X-UID: 2899

--===============1622027394413794325==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Peter,

On 12/12/2019 23:23, Peter Krystad wrote:
> =

> Hi Matt -
> =

> On Thu, 2019-12-12 at 23:11 +0100, Matthieu Baerts wrote:
>> Hi Peter, Paolo,
>>
>> On 12/12/2019 05:54, Peter Krystad wrote:

[...]

>>
>>> diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
>>> index ddb3a7581d41..93d6c41b76d5 100644
>>> --- a/net/mptcp/protocol.h
>>> +++ b/net/mptcp/protocol.h
>>> @@ -48,8 +48,7 @@ static inline struct mptcp_sock *mptcp_sk(const struc=
t sock *sk)
>>>    =

>>>    /* MPTCP subflow context */
>>>    struct mptcp_subflow_context {
>>> -	u32	request_mptcp : 1,  /* send MP_CAPABLE */
>>> -		request_version : 4;
>>> +	u32	request_mptcp : 1;  /* send MP_CAPABLE */
>>
>> When removing these 4 bits, at the end of the series, we now only use 13
>> bits. Should we switch to u16? I didn't check with pahole if it would
>> really reduce the size of the structure, I don't think so and maybe we
>> don't really need to reduce this bit field but I prefer to ask :)
> =

> We could go back to u16, but then I would want to move it to the end of t=
he
> struct (or just before local_id), but that would create a lot of work
> resolving conflicts as the fields are introduced one by one. Size isn't as
> critical for subflow_context because it doesn't affect every tcp_sock, on=
ly
> MPTCP sockets.

If we think it is important to do that, I can do it, conflicts would be =

easy to resolve :)

But if in any cases, we don't reduce the full size of the structure, no =

reason to change!

Cheers,
Matt
-- =

Matthieu Baerts | R&D Engineer
matthieu.baerts(a)tessares.net
Tessares SA | Hybrid Access Solutions
www.tessares.net
1 Avenue Jean Monnet, 1348 Louvain-la-Neuve, Belgium
--===============1622027394413794325==--
