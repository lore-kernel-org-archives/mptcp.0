Content-Type: multipart/mixed; boundary="===============7243702250585974359=="
MIME-Version: 1.0
From: Matthieu Baerts <matthieu.baerts at tessares.net>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: [PATCH v2] mptcp: wmem accounting and nonblocking io
 support
Date: Wed, 20 Nov 2019 17:04:35 +0100
Message-ID: <968afc38-bb49-fdb6-e697-e4e00a586684@tessares.net>
In-Reply-To: 8e9cf7581f71e6cb2f6165bec1c5cf0257e8d76e.camel@redhat.com
X-Status: 
X-Keywords:                  
X-UID: 2619

--===============7243702250585974359==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Paolo,

On 20/11/2019 16:49, Paolo Abeni wrote:
> On Wed, 2019-11-20 at 16:36 +0100, Matthieu Baerts wrote:
>> Hi Florian, Paolo,
>>
>> On 20/11/2019 16:25, Paolo Abeni wrote:
>>> On Wed, 2019-11-20 at 16:10 +0100, Florian Westphal wrote:
>>>> Mat Martineau <mathew.j.martineau(a)linux.intel.com> wrote:
>>>>>> There were doubts as to the repeated invocations of mptcp_send_frag()
>>>>>> (RFC patch 13/14, "sendmsg: don't restart mptcp_sendmsg_frag"), I ha=
ve
>>>>>> dropped it from this iteration -- mptcp_sendmsg_frag needs rework wh=
ich
>>>>>> isn't related to this patch series.
>>>>>
>>>>> The series looks good to me, with one minor comment on patch 1.
>>>>
>>>> Thanks, I can fix that up.
>>>>
>>>> How to proceed?  There are several patches in-flight.  I think it might
>>>> make sense to apply this series as-is, with no squashing.
>>>
>>> I'm personally ok with that.
>>>
>>> Can we wait for the series 'Awaiting Upstream' being applied, before
>>> going with this one?
>>
>> I was replying to Florian to say that I was going to do that :)
>> I would like to apply these two series:
>>
>>     https://patchwork.ozlabs.org/project/mptcp/list/?state=3D8&delegate=
=3D100661
>>
>> Ideally, I would also like to move commits after kselftests introduction
>> but this can wait if needed.
> =

> If you could do that, I would appreciate the effort a lot: v1 patches
> rebasing could be started just after that.

Great, I am then going to:

- apply the two series that are waiting to be applied
- then move these 3 commits after "mptcp: add basic kselftest for mptcp":

   mptcp: Add handling of incoming MP_JOIN requests
   mptcp: Add ADD_ADDR handling
   mptcp: Add path manager interface

- then can I add Florian' series at the end?

> Note: will cause some conflict on Makefile, due to pm.c being added
> after ctrl.c

That's nothing :-)
But thank you for the notice!

Cheers,
Matt
-- =

Matthieu Baerts | R&D Engineer
matthieu.baerts(a)tessares.net
Tessares SA | Hybrid Access Solutions
www.tessares.net
1 Avenue Jean Monnet, 1348 Louvain-la-Neuve, Belgium
--===============7243702250585974359==--
