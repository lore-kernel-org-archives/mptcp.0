Content-Type: multipart/mixed; boundary="===============5429395014051887996=="
MIME-Version: 1.0
From: Matthieu Baerts <matthieu.baerts at tessares.net>
To: mptcp at lists.01.org
Subject: Re: [MPTCP] [PATCH] tcp: clean ext on tx recycle
Date: Wed, 15 May 2019 15:10:29 +0200
Message-ID: <4d72ef43-97d2-2682-19d4-d5425b2dc84c@tessares.net>
In-Reply-To: 20190515115103.xgk25munbmlnfido@breakpoint.cc
X-Status: 
X-Keywords:                  
X-UID: 1176

--===============5429395014051887996==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Florian,

On 15/05/2019 13:51, Florian Westphal wrote:
> Paolo Abeni <pabeni(a)redhat.com> wrote:
>> Otherwise we will find stray/unexpected/old extensions
>> value on next iteration.
>>
>> On tcp_write_xmit() we can end-up splitting an already queued
>> skb in two parts, via tso_fragment(). The newly created skb
>> can be allocated via the tx cache and the mptcp stack will not
>> be aware of it, so nobody set properly the MPTCP ext.
>>
>> End result, we transmit the skb using an hold MPTCP DSS map
>> and that confuses the rx side/corrupt the stream. It requires
>> some concurrent conditions, so it's not deterministic.
>>
>> Resetting the ext on recycle fixes all the current mptcp self tests
>> issues.
>>
>> Apparently only MPTCP has issues with this kind of stray ext,
>> so an alternative would be add an additional mptcp hook in
>> tso_fragment() or in sk_stream_alloc_skb() to always init
>> the ext.
> =

> Yes, MPTCP is the only extension user that can set an extension
> before the skb makes it to tcp tx path.
> =

> So we need this fix as part of the MPTCP series, good catch!

Thank you for the review and confirmation!

Is the patch OK for you or would you prefer to have one of the
alternatives (dedicated MPTCP hook) mentioned by Paolo?

Cheers,
Matt

> _______________________________________________
> mptcp mailing list
> mptcp(a)lists.01.org
> https://lists.01.org/mailman/listinfo/mptcp
> =


-- =

Matthieu Baerts | R&D Engineer
matthieu.baerts(a)tessares.net
Tessares SA | Hybrid Access Solutions
www.tessares.net
1 Avenue Jean Monnet, 1348 Louvain-la-Neuve, Belgium

--===============5429395014051887996==--
