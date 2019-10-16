Content-Type: multipart/mixed; boundary="===============0721484512536191214=="
MIME-Version: 1.0
From: Matthieu Baerts <matthieu.baerts at tessares.net>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: [PATCH 0/3] mptcp: just another recvmsg refactor
Date: Wed, 16 Oct 2019 10:37:13 +0200
Message-ID: <38674e3a-37b1-9b08-b86b-9c8e35c5fd14@tessares.net>
In-Reply-To: 87fd8b8115c48d4b2472bea06df4ccef5830d3de.camel@redhat.com
X-Status: 
X-Keywords:                  
X-UID: 2167

--===============0721484512536191214==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On 16/10/2019 10:22, Paolo Abeni wrote:
> On Wed, 2019-10-16 at 09:39 +0200, Matthieu Baerts wrote:
>> On 15/10/2019 22:39, Paolo Abeni wrote:
>>> On Tue, 2019-10-15 at 17:44 +0200, Paolo Abeni wrote:
>>>> I think this 3 patches should be squashed into
>>>> "mptcp: Implement MPTCP receive path", but the resulting one will be l=
ikely
>>>> too huge; possibly splitting the resulting code in 2 different patches=
 would
>>>> be nicer. Additionally "mptcp: Implement MPTCP receive path" has some =
chunks
>>>> that should be likely moved to some other patches (e.g. ULP RCU fixes).
>>>>
>>>> What if - after the eventuall accept - I publish the resulting code of=
 the
>>>> above squashing somewhere?
>>>
>>> Since I'm an incurable optimist, I went ahead and pushed the rebase
>>> here:
>>
>> Thank you for this work!
>>
>>> https://github.com/pabeni/mptcp/tree/mptcp-proposal-recvmsg_rebase_7
>>>
>>> Squashed:
>>> "mptcp: flush duplicate data at data_ready() time"
>>> and
>>> "mptcp: move some helper into the header file"
>>>     into "mptcp: Implement MPTCP receive path"
>>>       (and rewrote the commit message)
>>>
>>> "mptcp: harmonize locking on all socket operations."
>>>     partially in
>>>       "mptcp: Associate MPTCP context with TCP socket"
>>>     and partially in
>>>       "mptcp: Create SUBFLOW socket for incoming connections"
>>>
>>> Moved the RCU bits from "mptcp: Implement MPTCP receive path"
>>> into:
>>>     "mptcp: Associate MPTCP context with TCP socket"
>>>
>>> Moved the options/ack_seq bits from "mptcp: Implement MPTCP receive
>>> path" into:
>>>     "mptcp: Write MPTCP DSS headers to outgoing data packets"
>>>
>>> Rebased "mptcp: recvmsg() can drain data from multiple subflows" on top
>>> of "mptcp: Implement MPTCP receive path"
>>>
>>> Removed a few intentation issue.
>>>
>>> I checked for build issue only on the modified patches.
>>>
>>> The overall diff from current export branch plus the pending patches is
>>> reported below.
>>
>> Which ref of the "export" branch did you use? This branch has been
>> overridden 3 times yesterday:
>> - around 3.52am: a rebase on latest net-next
>> - around 2.42pm: to include "selftests: allow compilation on older syste=
ms"
>> - around 5.23pm: to include "mptcp:pm: some cleanup"
> =

> It looks I luckly included all the above.

Great!

>> Note that a rebase on latest net-next was done this night by the CI but
>> that's easy to re-do.
> =

> But not this one.

Not a big deal for me!

>> Will you include the change proposed by Mat in a new rebase?
> =

> Yes, I'm cooking patch && rebase right now. I hopefully will send soon
> v2 of the patches with a reference to the rebase branch in the cover
> letter.

If you only adds the line mentioned by Mat, I am fine if you update your =

branch directly, no need to send new patches that we will not use =

directly, a diff is fine :-)

> I'll rebase on top of net-next commit:
> =

> 77ffe33363c0 ("hv_sock: use HV_HYP_PAGE_SIZE for Hyper-V communication")
> =

> to be in sync with the current export branch. Would that help?

It's the same for me. I will re-create the tree based on the net-next =

base you used. As long as it includes all the modifications linked to =

MPTCP and it does :-)

Cheers,
Matt
-- =

Matthieu Baerts | R&D Engineer
matthieu.baerts(a)tessares.net
Tessares SA | Hybrid Access Solutions
www.tessares.net
1 Avenue Jean Monnet, 1348 Louvain-la-Neuve, Belgium
--===============0721484512536191214==--
