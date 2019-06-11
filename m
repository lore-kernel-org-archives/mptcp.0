Content-Type: multipart/mixed; boundary="===============5623818913832483703=="
MIME-Version: 1.0
From: Matthieu Baerts <matthieu.baerts at tessares.net>
To: mptcp at lists.01.org
Subject: Re: [MPTCP] [PATCH] mptcp: selftests: increase timeout and return
 error on ping failure
Date: Tue, 11 Jun 2019 12:22:23 +0200
Message-ID: <4715aec3-dfc0-c47a-f52b-51a4cdbe3ded@tessares.net>
In-Reply-To: dcaf9fda-9321-8940-120d-a28b19644154@tessares.net
X-Status: 
X-Keywords:                  
X-UID: 1329

--===============5623818913832483703==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Florian, Paolo,

On 11/06/2019 10:49, Matthieu Baerts wrote:
> Hi Paolo,
> =

> On 11/06/2019 10:43, Paolo Abeni wrote:
>> Hi,
>>
>> Sorry for lagging behind ...
>> On Tue, 2019-06-11 at 10:32 +0200, Matthieu Baerts wrote:
>>> Hi Florian, Paolo,
>>>
>>> On 05/06/2019 11:36, Florian Westphal wrote:
>>>> Now that we add a qdisc that does random drop, there is a small chance
>>>> for the ping to be dropped, so this triggers:
>>>> ns2 -> 10.0.1.2 connectivity [ FAIL ]
>>>>
>>>> To fix this, split the ping test part to its own loop and only
>>>> add the qdiscs after the ping tests have completed.
>>>>
>>>> Also, the script would still exit with 0 status in this case, so update
>>>> run_tests to check the return value of do_transfer() rather than rely =
on
>>>> that function to set the global exit state in all cases.
>>>>
>>>> Last, increase the timeout: with qdiscs present, 10 seconds is too low:
>>>> in some rare cases sender or receiver exited too early.
>>>
>>> The patch looks good to me!
>>>
>>> @Paolo: as a major contributor to this shell script, is this patch also
>>> looks good to you?
>>
>> Just reviewed. Yes, the patch LGTM, too.
> =

> Thank you for the quick reply!

Thank you for the patch and the review!

- e9d3a8a4a460: "squashed" in "mptcp: selftests: switch to netns+veth
based tests"
- 9d00b70dbd94: conflict
- c088591c7178..7311dd424a7e: result

Cheers,
Matt
-- =

Matthieu Baerts | R&D Engineer
matthieu.baerts(a)tessares.net
Tessares SA | Hybrid Access Solutions
www.tessares.net
1 Avenue Jean Monnet, 1348 Louvain-la-Neuve, Belgium

--===============5623818913832483703==--
