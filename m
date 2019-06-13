Content-Type: multipart/mixed; boundary="===============4197513366919887324=="
MIME-Version: 1.0
From: Matthieu Baerts <matthieu.baerts at tessares.net>
To: mptcp at lists.01.org
Subject: Re: [MPTCP] MPTCP-API
Date: Thu, 13 Jun 2019 17:11:11 +0200
Message-ID: <2611b5bc-f8a1-7a61-7aca-e376d2228e2a@tessares.net>
In-Reply-To: alpine.OSX.2.21.1906130752540.36402@skshiu-mobl1.amr.corp.intel.com
X-Status: 
X-Keywords:                  
X-UID: 1361

--===============4197513366919887324==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Mat,

On 13/06/2019 17:02, Mat Martineau wrote:
> =

> On Thu, 13 Jun 2019, Matthieu Baerts wrote:
> =

>> Hi Mat,
>>
>> On 12/06/2019 18:21, Mat Martineau wrote:
>>>
>>> On Tue, 11 Jun 2019, Christoph Paasch wrote:
>>>
>>>> Hello,
>>>>
>>>>> On Jun 11, 2019, at 3:24 PM, Mat Martineau
>>>>> <mathew.j.martineau(a)linux.intel.com> wrote:
>>>>>
>>>>>
>>>>> Hi Christoph and Leif,
>>>>>
>>>>> On Tue, 11 Jun 2019, Christoph Paasch wrote:
>>>>>
>>>>>> So, we are wondering how we can do binary compatibility without
>>>>>> having to wait for MPTCP to land upstream. Could the MPTCP-code
>>>>>> expose maybe a sysctl that indicates the "API-version" ? That way,
>>>>>> upon startup ATS can simply check the API-version and if it
>>>>>> doesn't match, just disable MPTCP.
>>>>>>
>>>>>>
>>>>>> What are your thoughts?
>>>>>
>>>>> There are a couple of approaches we could use to help ATS and other
>>>>> projects as upstream MPTCP evolves.
>>>>>
>>>>> One is that we should pick a likely-to-get-merged value for
>>>>> IPPROTO_MPTCP. The current prototype uses 99, but the IANA defines
>>>>> that as "any private encryption scheme). We had earlier prototypes
>>>>> with 262 (IPPROTO_TCP | 0x100) since the socket API uses 'int proto'
>>>>> instead of a single byte. ATS could consider a runtime-configurable
>>>>> proto value for MPTCP to help with this.
>>>>
>>>> Yes, let's pick a "likely-to-get-merged" value ASAP. Do you think 262
>>>> could work out?
>>>>
>>>
>>> I'll test it out and send the patches, so they're ready to merge if we
>>> have a consensus.
>>
>> Should we not request an official protocol number from the IANA? It
>> seems that all the other ones in the upstream Linux kernel are official.
>> Why not having one for MPTCP then. Especially if this will need to be
>> added later in the different libC.
>>
>> I can check what to do and ask around how our TCP option official number
>> for MPTCP (30) was requested and assigned.
> =

> I think the IANA would expect a new protocol number to be used
> over-the-wire, which would dramatically affect MPTCP's ability to
> pretend to be TCP as far as middleboxes and firewalls are concerned!
> =

> The Linux definitions already deviate somewhat from the IANA list (for
> example, IPPROTO_IP), which leads me to believe there is some
> flexibility in future definitions.

I agree with you, I didn't want to set a new protocol number visible on
the wire. I guess we cannot do that regarding the RFC6824 anyway.

My point is more to get an official number for this IPPROTO_MPTCP only
for libc and keep the same between the different OS.
For example, we have IPPROTO_RAW (255) which is marked as "Reserved" by
IANA.

We can discuss about that at our weekly meeting if you want to.

Cheers,
Matt

> -- =

> Mat Martineau
> Intel

-- =

Matthieu Baerts | R&D Engineer
matthieu.baerts(a)tessares.net
Tessares SA | Hybrid Access Solutions
www.tessares.net
1 Avenue Jean Monnet, 1348 Louvain-la-Neuve, Belgium

--===============4197513366919887324==--
