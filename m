Content-Type: multipart/mixed; boundary="===============1774001675818348142=="
MIME-Version: 1.0
From: Matthieu Baerts <matthieu.baerts at tessares.net>
To: mptcp at lists.01.org
Subject: Re: [MPTCP] [PATCH] tcp: clean ext on tx recycle
Date: Wed, 15 May 2019 15:45:48 +0200
Message-ID: <2c89a83d-b462-dea8-336e-b35f9fb71503@tessares.net>
In-Reply-To: 9ab88e08-ee11-2bbe-2ada-f48f37ca34a8@tessares.net
X-Status: 
X-Keywords:                  
X-UID: 1181

--===============1774001675818348142==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On 15/05/2019 15:25, Matthieu Baerts wrote:
> On 15/05/2019 15:19, Florian Westphal wrote:
>> Matthieu Baerts <matthieu.baerts(a)tessares.net> wrote:
>>> Hi Florian,
>>>
>>> On 15/05/2019 13:51, Florian Westphal wrote:
>>>> Paolo Abeni <pabeni(a)redhat.com> wrote:
>>>>>
>>>>> Apparently only MPTCP has issues with this kind of stray ext,
>>>>> so an alternative would be add an additional mptcp hook in
>>>>> tso_fragment() or in sk_stream_alloc_skb() to always init
>>>>> the ext.
>>>>
>>>> Yes, MPTCP is the only extension user that can set an extension
>>>> before the skb makes it to tcp tx path.
>>>>
>>>> So we need this fix as part of the MPTCP series, good catch!
>>>
>>> Thank you for the review and confirmation!
>>>
>>> Is the patch OK for you or would you prefer to have one of the
>>> alternatives (dedicated MPTCP hook) mentioned by Paolo?
>>
>> I am fine with this patch.  New hook should be avoided unless
>> we need it for some other reason.
> =

> Agreed, it makes sense!
> =

> I will then add this new patch (without the note about the FIXME) just
> before "mptcp: Add MPTCP to skb extensions" commit if there is no objecti=
on.

Just added before the mentioned commit:
- 8b2e02e94442461c0faae81afc21b08c3e40cafc

https://github.com/multipath-tcp/mptcp_net-next/commits/export

Cheers,
Matt
-- =

Matthieu Baerts | R&D Engineer
matthieu.baerts(a)tessares.net
Tessares SA | Hybrid Access Solutions
www.tessares.net
1 Avenue Jean Monnet, 1348 Louvain-la-Neuve, Belgium

--===============1774001675818348142==--
