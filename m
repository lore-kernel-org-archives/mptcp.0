Content-Type: multipart/mixed; boundary="===============7950390169156926520=="
MIME-Version: 1.0
From: Matthieu Baerts <matthieu.baerts at tessares.net>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: Cover letters for part1/part2 netdev patchsets
Date: Fri, 13 Dec 2019 22:08:25 +0100
Message-ID: <09582f0a-446e-9201-bf0c-687c2ccdd343@tessares.net>
In-Reply-To: alpine.OSX.2.21.1912131239570.33632@amhui-mobl1.amr.corp.intel.com
X-Status: 
X-Keywords:                  
X-UID: 3015

--===============7950390169156926520==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On 13/12/2019 21:41, Mat Martineau wrote:
> On Fri, 13 Dec 2019, Matthieu Baerts wrote:
> =

>> Hi Mat,
>>
>> On 13/12/2019 20:19, Mat Martineau wrote:
>>>
>>> On Fri, 13 Dec 2019, Matthieu Baerts wrote:
>>>
>>>> Hi Mat,
>>>>
>>>> On 06/12/2019 01:41, Mat Martineau wrote:
>>>>>
>>>>> Hello everyone -
>>>>>
>>>>> As we discussed earlier today, here are draft cover letters for =

>>>>> patch set parts 1 & 2. Feedback appreciated!
>>>>>
>>>>>
>>>>> ------
>>>>> Part 1
>>>>>
>>>>> Subject: [PATCH net-next 0/0] Multipath TCP part 1: Prerequisites
>>>>>
>>>>> The MPTCP upstreaming community has been collaborating on an
>>>>> upstreamable MPTCP implementation. David requested that we split this
>>>>> work in to multiple, smaller patch sets to build up MPTCP
>>>>> infrastructure. The scope of this first patch set is limited to
>>>>> prerequisite TCP core changes so we can get focused feedback in these
>>>>> areas.
>>>>
>>>> Related to why I proposed on "Checklist before sending to netdev" =

>>>> ML, should we already introduce here the fact that we are going to =

>>>> send 3 different patch sets and why we cannot send all in one or =

>>>> less patches?
>>>>
>>>> Something like:
>>>>
>>>> =C2=A0=C2=A0 - The protocol is what it is and having a minimal set of =
features =

>>>> already signifies a lot of code.
>>>> =C2=A0=C2=A0 - This minimal set of features includes: the possibility =
for the =

>>>> userspace to establish and properly terminate MPTCP connections but =

>>>> limited to one subflow while still being able to transfer data in =

>>>> both directions
>>>> =C2=A0=C2=A0 - We decided to split everything in 3 parts to ease the r=
eviews:
>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 - Part 1: Prerequisite TCP core c=
hanges
>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 - Part 2: MPTCP minimal set of fe=
atures including selftests
>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 - Part 3: a switch from MPTCPv0 (=
RFC 6824) to MPTCPv1 (new =

>>>> RFC 8684 going to obsolete the previous one in the coming days)
>>>> =C2=A0=C2=A0 - The idea would be to apply everything in the same "merg=
e window".
>>>>
>>>> Feel free to improve this of course :)
>>>
>>> Thanks Matthieu, good suggestion. Am I correct in thinking the plan =

>>> is to have part 4 in this window as well, just in January sometime?
>>>
>>> Updated draft:
>>>
>>> ----
>>> Subject: [PATCH net-next 0/0] Multipath TCP part 1: Prerequisites
>>>
>>> The MPTCP upstreaming community has been collaborating on an =

>>> upstreamable MPTCP implementation that complies with RFC 8684. A =

>>> minimal set of features to comply with the specification involves a =

>>> sizeable set of code changes, so David requested that we split this =

>>> work in to multiple, smaller patch sets to build up MPTCP =

>>> infrastructure.
>>>
>>> The minimal MPTCP feature set we are proposing for the v5.6 timeframe =

>>> is split in to these parts for review:
>>>
>>> Part 1 (this patch set): MPTCP prerequisites. Introduce some MPTCP =

>>> definitions, additional ULP and skb extension features, TCP option =

>>> space checking, and a few exported symbols.
>>>
>>> Part 2: Single subflow implementation and self tests.
>>>
>>> Part 3: Switch from MPTCP v0 (RFC 6824) to MPTCP v1 (new RFC 8684, =

>>> publication expected in the next few days).
>>>
>>> Part 4: Multiple subflow support.
>>
>> I would not mention Part 4 for the moment. Maybe better to wait and =

>> see how the other patches will be welcomed, no?
> =

> How about
> =

> """
> The minimal MPTCP feature set we are proposing for review in the v5.6 =

> timeframe begins with these parts:
> """
> =

> and drop part 4?

Yes, sounds good but what about keeping this sentence and add this at =

the end instead of part 3:

   More commits are in preparation to add multiple subflow support, path =

management, active backup support and more but this will come later when =

these 3 previous parts are reviewed and applied.

I hope it is clear that we don't have to wait for any part 4 :)

And also:

   The part 2 is coming later today and part 3 over the next week.

Cheers,
Matt
-- =

Matthieu Baerts | R&D Engineer
matthieu.baerts(a)tessares.net
Tessares SA | Hybrid Access Solutions
www.tessares.net
1 Avenue Jean Monnet, 1348 Louvain-la-Neuve, Belgium
--===============7950390169156926520==--
