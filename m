Content-Type: multipart/mixed; boundary="===============6311176643121617911=="
MIME-Version: 1.0
From: Matthieu Baerts <matthieu.baerts at tessares.net>
To: mptcp at lists.01.org
Subject: Re: [MPTCP] [PATCH v2] mptcp: sockopt: pass whitelisted setsockopt to
 subflows
Date: Fri, 30 Aug 2019 14:59:12 +0200
Message-ID: <a65452c1-9abd-ae33-0f40-6ea0024aace6@tessares.net>
In-Reply-To: 20190829224451.GN20113@breakpoint.cc
X-Status: 
X-Keywords:                  
X-UID: 1769

--===============6311176643121617911==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Florian, Mat,

On 30/08/2019 00:44, Florian Westphal wrote:
> Mat Martineau <mathew.j.martineau(a)linux.intel.com> wrote:
>> On Fri, 16 Aug 2019, Florian Westphal wrote:
>>
>>> This allows to set tcp congestion control algorithm on all subflows.
>>>
>>> In the future we could keep a record of sockopts so we can "replay"
>>> them when another subflow is added at a later point in time.
>>>
>>> Only TCP_CONGESTION is allowed at the moment, as some available
>>> TCP knobs either have undesireable behaviour or should be later
>>> implemented at the mptcp level rather than passing them through to
>>> the subflows (TCP_CORK for example).
>>>
>>> getsockopt is disabled for the time being to not expose a particular
>>> behaviour ("first subflow on list") at this time.
>>>
>>> v2: disable getsockopt, restrict setsockopt via whitelist.
>>
>> As Florian mentioned on the call today, we definitely want to merge the
>> getsockopt fix.

Thank you for the patch and the review!

>> As for the setsockopt part, if TCP_CONGESTION is sufficiently useful to
>> enough users, we could consider merging it. My slight hesitation is that=
 the
>> potential "replay" behavior change in the future could come as a surpris=
e,
>> and if we start out with this ability to set options on all subflows the=
n we
>> have to be careful and consistent about how it interacts with per-subflow
>> options later. Anyone know if TCP_CONGESTION is a priority?
> =

> Its not.
> =

> Lets drop this, I will respin with the getsockopt fix only.
> =

> Alternatively, Matthieu -- if you can just apply the getsockopt part
> of this patch that works for me too.

Sure, just did:
- 8d057956303c: "squashed" in "mptcp: Make connection_list a real list
of subflows"
- 6090eb26ae22: signed-off
- 72da334cdf7c..732bbb964f61: result

Just exported, tests in progress.

Cheers,
Matt
-- =

Matthieu Baerts | R&D Engineer
matthieu.baerts(a)tessares.net
Tessares SA | Hybrid Access Solutions
www.tessares.net
1 Avenue Jean Monnet, 1348 Louvain-la-Neuve, Belgium

--===============6311176643121617911==--
