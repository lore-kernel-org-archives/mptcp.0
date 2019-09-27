Content-Type: multipart/mixed; boundary="===============1052551369843872987=="
MIME-Version: 1.0
From: Matthieu Baerts <matthieu.baerts at tessares.net>
To: mptcp at lists.01.org
Subject: Re: [MPTCP] some squashing needed?
Date: Fri, 27 Sep 2019 17:59:32 +0200
Message-ID: <0290621d-11de-6515-baf9-429ed9582783@tessares.net>
In-Reply-To: 20190927155106.GH9938@breakpoint.cc
X-Status: 
X-Keywords:                  
X-UID: 1940

--===============1052551369843872987==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Florian,

On 27/09/2019 17:51, Florian Westphal wrote:
> Matthieu Baerts <matthieu.baerts(a)tessares.net> wrote:
>> Hi Paolo,
>>
>> On 26/09/2019 19:20, Paolo Abeni wrote:
>>> On Thu, 2019-09-26 at 17:05 +0200, Florian Westphal wrote:
>>
>> [...]
>>
>>>> from Paolo.
>>>>
>>>> But I figured it would make sense to share this now and discuss
>>>> how to proceed from here first.
>>>
>>> The above branch is based on mptcp_net-next export branch hash
>>> a45bdbe6701b
>>
>> Great, still the last one. So everything is in it.
>>
>>> There is a small diff vs such hash, see below. Mostily checkpack fixes,
>>> a trivial functional fix in mptcp_setsockopt(), and a bunch of likely
>>> not interesting debug messages dropped - side note: we may want remove
>>> more of them.
>>
>> I guess that we indeed need to remove most of these pr_debug() at some
>> points. Thank you for having done that!
>> Also great to have looked at checkpatch and making sure each commit can
>> compile :-)
>>
>> For the fix in mptcp_setsockopt(), was it due to a bad "squash"?
> =

> No, that is intentional -- I don't think returning 0 when nothing
> was done is good.
> =

> I can fold Peters mptcp prefix patch for crypto where needed and push a
> v2, let me know.

I just pushed a new tree on mptcp_net-next repo on Github based on your
branch :)

I didn't want to block anybody but I can re-create a new one again later
if needed!

Also I don't mind squashing this patch and also do the same for the
remaining functions (subflow_ ones I guess). I can do that on Monday if
it is OK for you.

Also, before recreating the new tree, I remove all (Git) refs to the
previous ones. If someone uses our repo with Topgit (we never know :) ),
please do the same on your side!

Cheers,
Matt
-- =

Matthieu Baerts | R&D Engineer
matthieu.baerts(a)tessares.net
Tessares SA | Hybrid Access Solutions
www.tessares.net
1 Avenue Jean Monnet, 1348 Louvain-la-Neuve, Belgium

--===============1052551369843872987==--
