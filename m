Content-Type: multipart/mixed; boundary="===============6139525493551579897=="
MIME-Version: 1.0
From: Mat Martineau <mathew.j.martineau at linux.intel.com>
To: mptcp at lists.01.org
Subject: Re: [MPTCP] MPTCP-API
Date: Thu, 13 Jun 2019 08:02:23 -0700
Message-ID: <alpine.OSX.2.21.1906130752540.36402@skshiu-mobl1.amr.corp.intel.com>
In-Reply-To: e51b8fae-3d8c-0841-3faa-31b495bff96e@tessares.net
X-Status: 
X-Keywords:                  
X-UID: 1360

--===============6139525493551579897==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable


On Thu, 13 Jun 2019, Matthieu Baerts wrote:

> Hi Mat,
>
> On 12/06/2019 18:21, Mat Martineau wrote:
>>
>> On Tue, 11 Jun 2019, Christoph Paasch wrote:
>>
>>> Hello,
>>>
>>>> On Jun 11, 2019, at 3:24 PM, Mat Martineau
>>>> <mathew.j.martineau(a)linux.intel.com> wrote:
>>>>
>>>>
>>>> Hi Christoph and Leif,
>>>>
>>>> On Tue, 11 Jun 2019, Christoph Paasch wrote:
>>>>
>>>>> So, we are wondering how we can do binary compatibility without =

>>>>> having to wait for MPTCP to land upstream. Could the MPTCP-code =

>>>>> expose maybe a sysctl that indicates the "API-version" ? That way, =

>>>>> upon startup ATS can simply check the API-version and if it doesn't =

>>>>> match, just disable MPTCP.
>>>>>
>>>>>
>>>>> What are your thoughts?
>>>>
>>>> There are a couple of approaches we could use to help ATS and other
>>>> projects as upstream MPTCP evolves.
>>>>
>>>> One is that we should pick a likely-to-get-merged value for
>>>> IPPROTO_MPTCP. The current prototype uses 99, but the IANA defines
>>>> that as "any private encryption scheme). We had earlier prototypes
>>>> with 262 (IPPROTO_TCP | 0x100) since the socket API uses 'int proto'
>>>> instead of a single byte. ATS could consider a runtime-configurable
>>>> proto value for MPTCP to help with this.
>>>
>>> Yes, let's pick a "likely-to-get-merged" value ASAP. Do you think 262
>>> could work out?
>>>
>>
>> I'll test it out and send the patches, so they're ready to merge if we
>> have a consensus.
>
> Should we not request an official protocol number from the IANA? It
> seems that all the other ones in the upstream Linux kernel are official.
> Why not having one for MPTCP then. Especially if this will need to be
> added later in the different libC.
>
> I can check what to do and ask around how our TCP option official number
> for MPTCP (30) was requested and assigned.

I think the IANA would expect a new protocol number to be used =

over-the-wire, which would dramatically affect MPTCP's ability to pretend =

to be TCP as far as middleboxes and firewalls are concerned!

The Linux definitions already deviate somewhat from the IANA list (for =

example, IPPROTO_IP), which leads me to believe there is some flexibility =

in future definitions.

--
Mat Martineau
Intel

--===============6139525493551579897==--
