Content-Type: multipart/mixed; boundary="===============0857068823678603149=="
MIME-Version: 1.0
From: Matthieu Baerts <matthieu.baerts at tessares.net>
To: mptcp at lists.01.org
Subject: Re: [MPTCP] [PATCH] tcp: clean ext on tx recycle
Date: Wed, 15 May 2019 15:25:10 +0200
Message-ID: <9ab88e08-ee11-2bbe-2ada-f48f37ca34a8@tessares.net>
In-Reply-To: 20190515131925.666wgxrn547csohx@breakpoint.cc
X-Status: 
X-Keywords:                  
X-UID: 1179

--===============0857068823678603149==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On 15/05/2019 15:19, Florian Westphal wrote:
> Matthieu Baerts <matthieu.baerts(a)tessares.net> wrote:
>> Hi Florian,
>>
>> On 15/05/2019 13:51, Florian Westphal wrote:
>>> Paolo Abeni <pabeni(a)redhat.com> wrote:
>>>> Otherwise we will find stray/unexpected/old extensions
>>>> value on next iteration.
>>>>
>>>> On tcp_write_xmit() we can end-up splitting an already queued
>>>> skb in two parts, via tso_fragment(). The newly created skb
>>>> can be allocated via the tx cache and the mptcp stack will not
>>>> be aware of it, so nobody set properly the MPTCP ext.
>>>>
>>>> End result, we transmit the skb using an hold MPTCP DSS map
>>>> and that confuses the rx side/corrupt the stream. It requires
>>>> some concurrent conditions, so it's not deterministic.
>>>>
>>>> Resetting the ext on recycle fixes all the current mptcp self tests
>>>> issues.
>>>>
>>>> Apparently only MPTCP has issues with this kind of stray ext,
>>>> so an alternative would be add an additional mptcp hook in
>>>> tso_fragment() or in sk_stream_alloc_skb() to always init
>>>> the ext.
>>>
>>> Yes, MPTCP is the only extension user that can set an extension
>>> before the skb makes it to tcp tx path.
>>>
>>> So we need this fix as part of the MPTCP series, good catch!
>>
>> Thank you for the review and confirmation!
>>
>> Is the patch OK for you or would you prefer to have one of the
>> alternatives (dedicated MPTCP hook) mentioned by Paolo?
> =

> I am fine with this patch.  New hook should be avoided unless
> we need it for some other reason.

Agreed, it makes sense!

I will then add this new patch (without the note about the FIXME) just
before "mptcp: Add MPTCP to skb extensions" commit if there is no objection.

Cheers,
Matt
-- =

Matthieu Baerts | R&D Engineer
matthieu.baerts(a)tessares.net
Tessares SA | Hybrid Access Solutions
www.tessares.net
1 Avenue Jean Monnet, 1348 Louvain-la-Neuve, Belgium

--===============0857068823678603149==--
