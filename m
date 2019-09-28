Content-Type: multipart/mixed; boundary="===============7423527969412259820=="
MIME-Version: 1.0
From: Matthieu Baerts <matthieu.baerts at tessares.net>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: some squashing needed?
Date: Sat, 28 Sep 2019 09:11:32 +0200
Message-ID: <f7ac6426-6b14-db06-4738-9bc1f8d26e3d@tessares.net>
In-Reply-To: 20190927211111.GI9938@breakpoint.cc
X-Status: 
X-Keywords:                  
X-UID: 1948

--===============7423527969412259820==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Florian,

On 27/09/2019 23:11, Florian Westphal wrote:
> Matthieu Baerts <matthieu.baerts(a)tessares.net> wrote:
>> On 27/09/2019 17:51, Florian Westphal wrote:
>>> I can fold Peters mptcp prefix patch for crypto where needed and push a
>>> v2, let me know.
>>
>> I just pushed a new tree on mptcp_net-next repo on Github based on your
>> branch :)
> =

> Awesome.
> =

>> I didn't want to block anybody but I can re-create a new one again later
>> if needed!
> =

> Great.
> =

>> Also I don't mind squashing this patch and also do the same for the
>> remaining functions (subflow_ ones I guess). I can do that on Monday if
>> it is OK for you.
> =

> Sure.
> =

> I squashed Peters patch, you can get a branch with it folded by pulling
> git://git.breakpoint.cc/fw/mptcp-next.git export_squash_11
> =

> The diff between current export and this branch is Peters patch, nothing
> else.

Great, thank you for that!
I just re-created the tree using your branch.

> If you could prefix the path management api that would be great (to avoid
> confusion with 'power management') subflow would be good too.

Sure I will do that on Monday. I will also apply all accepted patches.

I saw that Peter started this refactoring work for the PM but I didn't
see the patches. I will see what I can do on Monday. I don't mind
looking at that not to disturb Peter while he is looking at IPv6 support :)

>> Also, before recreating the new tree, I remove all (Git) refs to the
>> previous ones. If someone uses our repo with Topgit (we never know :) ),
>> please do the same on your side!
> =

> Sorry, not following.  What would you like me to do?

Nothing to do on your side. Only for those who are using TopGit. I guess
only the CI and me.

I removed all these refs from our Github repo:
- refs/heads/t/*
- refs/top-bases/*
- refs/heads/for-review
- (refs/heads/export =E2=86=92 but that's normal)

When recreating the tree, I used the same naming convention. Then most
of these refs have been overridden, the rest is no longer used.

But I guess that's not a problem being the only user of these refs :-)

> I plan to work on a v2 of the snmp counters on Monday, esp. dropping all
> the unused/dubious counters.

Excellent!

> If there is anything else please let me know.

Thank you. I don't think there are anything else needed before sending
the RFCv2 to netdev apart from the cover letter draft.

On my side, I will:
- prefix exposed functions related to subflows
- prefix exposed functions related to PM (or apply Peter's patch)
- apply: "mptcp: fix retransmit timer update"
- apply: "mptcp: add MIB counter infrastructure" (if ready)
- apply: "mptcp: Remove all traces of checksum support" (if OK)
- apply: "mptcp: Implement interim path manager" (if it is OK)

Do you see anything else I can do on my side?

I would like to have a look at supporting MPTCPv1 but I don't want to
slow down any defined plans :)

> I still need to do v2 of the 'poll' patch set, I will do that next after
> the snmp counters are done.

Thank you for that! I guess it is not needed to have it in our RFCv2,
right? Or do you think it would be better there? I also don't know if
the goal is to squash these new commit or add them at the end.

Cheers,
Matt
-- =

Matthieu Baerts | R&D Engineer
matthieu.baerts(a)tessares.net
Tessares SA | Hybrid Access Solutions
www.tessares.net
1 Avenue Jean Monnet, 1348 Louvain-la-Neuve, Belgium
--===============7423527969412259820==--
