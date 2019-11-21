Content-Type: multipart/mixed; boundary="===============6266371143287087802=="
MIME-Version: 1.0
From: Matthieu Baerts <matthieu.baerts at tessares.net>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: [PATCH v3 3/4] mptcp: warn once if exceeding tcp opt
 space for dss/mp_capable
Date: Thu, 21 Nov 2019 13:35:22 +0100
Message-ID: <340c5026-1f12-e1d8-62aa-f5b4e69b4e16@tessares.net>
In-Reply-To: 213bb7e7df0bcf3691eb8848a268a862a0af2ca4.camel@redhat.com
X-Status: 
X-Keywords:                  
X-UID: 2644

--===============6266371143287087802==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Paolo,

On 20/11/2019 21:30, Paolo Abeni wrote:
> On Wed, 2019-11-20 at 20:13 +0100, Matthieu Baerts wrote:
>>> diff --git a/net/mptcp/options.c b/net/mptcp/options.c
>>> index 38c0cbd4c77b..bf43d61f792b 100644
>>> --- a/net/mptcp/options.c
>>> +++ b/net/mptcp/options.c
>>> @@ -499,16 +499,10 @@ bool mptcp_established_options(struct sock *sk, s=
truct sk_buff *skb,
>>>
>>>           *size +=3D opt_size;
>>>           remaining -=3D opt_size;
>>> -
>>
>> I had to manually apply the patch and I see I didn't remove this line.
>> Do you want me to remove it?
> =

> whoops... yes, it would be better, thanks1
> =


I just removed this line:

- 1c9961c4aa88: line removed
- 32fda6a17c47..c35e69234be2: result

Cheers,
Matt
-- =

Matthieu Baerts | R&D Engineer
matthieu.baerts(a)tessares.net
Tessares SA | Hybrid Access Solutions
www.tessares.net
1 Avenue Jean Monnet, 1348 Louvain-la-Neuve, Belgium
--===============6266371143287087802==--
