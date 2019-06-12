Content-Type: multipart/mixed; boundary="===============3422549981331090649=="
MIME-Version: 1.0
From: Mat Martineau <mathew.j.martineau at linux.intel.com>
To: mptcp at lists.01.org
Subject: Re: [MPTCP] MPTCP-API
Date: Wed, 12 Jun 2019 09:21:20 -0700
Message-ID: <alpine.OSX.2.21.1906120854030.23563@skshiu-mobl1.amr.corp.intel.com>
In-Reply-To: B258872C-CA60-4B5A-AE36-4FBF3E114A60@apple.com
X-Status: 
X-Keywords:                  
X-UID: 1346

--===============3422549981331090649==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable


On Tue, 11 Jun 2019, Christoph Paasch wrote:

> Hello,
>
>> On Jun 11, 2019, at 3:24 PM, Mat Martineau <mathew.j.martineau(a)linux.i=
ntel.com> wrote:
>>
>>
>> Hi Christoph and Leif,
>>
>> On Tue, 11 Jun 2019, Christoph Paasch wrote:
>>
>>> I am bringing up something that we already once discussed quite a while
>>> back. Apache Traffic Server has an option to enable MPTCP (currently,
>>> through the socket-option MPTCP_ENABLED that is exposed on the
>>> multipath-tcp.org kernel). Leif (in CC) is the main contributor & maint=
ainer
>>> of ATS.
>>>
>>> Now, ATS will be doing a 9.0.0-release soon that will be the first rele=
ase
>>> with this MPTCP-option in the ATS-config.
>>>
>>> We want to make sure that it would also work with the upcoming upstream=
 MPTCP
>>> implementation. So, we can easily make this use IPPROTO_MPTCP. However,
>>> there currently isn't a 100% guarantee that the API is stable (as upstr=
eam
>>> might request changes).
>>>
>>> So, we are wondering how we can do binary compatibility without having =
to
>>> wait for MPTCP to land upstream. Could the MPTCP-code expose maybe a sy=
sctl
>>> that indicates the "API-version" ? That way, upon startup ATS can simply
>>> check the API-version and if it doesn't match, just disable MPTCP.
>>>
>>>
>>> What are your thoughts?
>>
>> There are a couple of approaches we could use to help ATS and other proj=
ects as upstream MPTCP evolves.
>>
>> One is that we should pick a likely-to-get-merged value for IPPROTO_MPTC=
P. The current prototype uses 99, but the IANA defines that as "any private=
 encryption scheme). We had earlier prototypes with 262 (IPPROTO_TCP | 0x10=
0) since the socket API uses 'int proto' instead of a single byte. ATS coul=
d consider a runtime-configurable proto value for MPTCP to help with this.
>
> Yes, let's pick a "likely-to-get-merged" value ASAP. Do you think 262 cou=
ld work out?
>

I'll test it out and send the patches, so they're ready to merge if we =

have a consensus.

>> My impression is that the maintainers would not want a "MPTCP API versio=
n" sysctl where you'd read a number from a file and have v0, v1, v2 etc API=
 since it would mainly exist to accomodate non-upstream kernels. The upstre=
am API (once MPTCP is merged) is not supposed to change in ways that break =
userspace, after all.
>>
>> Given that the MPTCP features will get added to the upstream kernel over=
 time, we may have an easier time justifying a MPTCP feature flag sysctl, k=
ind of like the CPU flags in /proc/cpuinfo. That could indicate support for=
 things like TFO, netlink path management, break-before-make, customizable =
schedulers, etc. The combination of features may be enough for userspace pr=
ograms to figure out if they can make use of that MPTCP implementation.
>
> That sounds like a fine approach to me.
>
> In general, I am wondering, how do userspace applications handle runtime =
feature-checking as they may be running on different kernels? Is it always =
a try-and-error approach?

A project I am involved in makes use of recent additions to the keyctl API =

and various crypto algorithms on AF_ALG sockets. The checks are basically =

trial and error, if the feature is not there we expect EOPNOTSUPP from =

keyctl or bind() to fail:

https://git.kernel.org/pub/scm/libs/ell/ell.git/tree/ell/key.c#n788

https://git.kernel.org/pub/scm/libs/ell/ell.git/tree/ell/cipher.c#n621

--
Mat Martineau
Intel

--===============3422549981331090649==--
