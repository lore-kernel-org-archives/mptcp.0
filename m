Content-Type: multipart/mixed; boundary="===============1349048347970133112=="
MIME-Version: 1.0
From: Matthieu Baerts <matthieu.baerts at tessares.net>
To: mptcp at lists.01.org
Subject: Re: [MPTCP] MPTCP-API
Date: Thu, 13 Jun 2019 10:36:24 +0200
Message-ID: <e51b8fae-3d8c-0841-3faa-31b495bff96e@tessares.net>
In-Reply-To: alpine.OSX.2.21.1906120854030.23563@skshiu-mobl1.amr.corp.intel.com
X-Status: 
X-Keywords:                  
X-UID: 1355

--===============1349048347970133112==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Mat,

On 12/06/2019 18:21, Mat Martineau wrote:
> =

> On Tue, 11 Jun 2019, Christoph Paasch wrote:
> =

>> Hello,
>>
>>> On Jun 11, 2019, at 3:24 PM, Mat Martineau
>>> <mathew.j.martineau(a)linux.intel.com> wrote:
>>>
>>>
>>> Hi Christoph and Leif,
>>>
>>> On Tue, 11 Jun 2019, Christoph Paasch wrote:
>>>
>>>> I am bringing up something that we already once discussed quite a while
>>>> back. Apache Traffic Server has an option to enable MPTCP (currently,
>>>> through the socket-option MPTCP_ENABLED that is exposed on the
>>>> multipath-tcp.org kernel). Leif (in CC) is the main contributor &
>>>> maintainer
>>>> of ATS.
>>>>
>>>> Now, ATS will be doing a 9.0.0-release soon that will be the first
>>>> release
>>>> with this MPTCP-option in the ATS-config.
>>>>
>>>> We want to make sure that it would also work with the upcoming
>>>> upstream MPTCP
>>>> implementation. So, we can easily make this use IPPROTO_MPTCP. However,
>>>> there currently isn't a 100% guarantee that the API is stable (as
>>>> upstream
>>>> might request changes).
>>>>
>>>> So, we are wondering how we can do binary compatibility without
>>>> having to
>>>> wait for MPTCP to land upstream. Could the MPTCP-code expose maybe a
>>>> sysctl
>>>> that indicates the "API-version" ? That way, upon startup ATS can
>>>> simply
>>>> check the API-version and if it doesn't match, just disable MPTCP.
>>>>
>>>>
>>>> What are your thoughts?
>>>
>>> There are a couple of approaches we could use to help ATS and other
>>> projects as upstream MPTCP evolves.
>>>
>>> One is that we should pick a likely-to-get-merged value for
>>> IPPROTO_MPTCP. The current prototype uses 99, but the IANA defines
>>> that as "any private encryption scheme). We had earlier prototypes
>>> with 262 (IPPROTO_TCP | 0x100) since the socket API uses 'int proto'
>>> instead of a single byte. ATS could consider a runtime-configurable
>>> proto value for MPTCP to help with this.
>>
>> Yes, let's pick a "likely-to-get-merged" value ASAP. Do you think 262
>> could work out?
>>
> =

> I'll test it out and send the patches, so they're ready to merge if we
> have a consensus.

Should we not request an official protocol number from the IANA? It
seems that all the other ones in the upstream Linux kernel are official.
Why not having one for MPTCP then. Especially if this will need to be
added later in the different libC.

I can check what to do and ask around how our TCP option official number
for MPTCP (30) was requested and assigned.

Best regards,
Matt
-- =

Matthieu Baerts | R&D Engineer
matthieu.baerts(a)tessares.net
Tessares SA | Hybrid Access Solutions
www.tessares.net
1 Avenue Jean Monnet, 1348 Louvain-la-Neuve, Belgium

--===============1349048347970133112==--
