Content-Type: multipart/mixed; boundary="===============6940342501919774128=="
MIME-Version: 1.0
From: Matthieu Baerts <matthieu.baerts at tessares.net>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: [Weekly meetings] MoM - 3rd of October 2019
Date: Sat, 05 Oct 2019 11:07:22 +0200
Message-ID: <7ebb42f3-b7cc-eca3-ba0f-9469a5ad63e0@tessares.net>
In-Reply-To: 20191004143105.GF13866@breakpoint.cc
X-Status: 
X-Keywords:                  
X-UID: 2025

--===============6940342501919774128==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Florian,

Thank you very much for this answer!

On 04/10/2019 16:31, Florian Westphal wrote:
> Matthieu Baerts <matthieu.baerts(a)tessares.net> wrote:
>> RFCv2 sent to netdev:
>>     - Feedback: Dave M says 40-some patches is way too many, and to
>> repost series with no more than 12-20 patches
>> https://lore.kernel.org/netdev/20191002.171229.1495727500341484392.davem=
(a)davemloft.net/
>>
>>     - We could squash more aggressively to reduce in-series code churn
>> and the patch count
>>
>>     - Or we send less (less at a time)
>>     - Or we do both (squash + send less at a time)
>>     - Maybe easier to send a first subset and then squash other patches
>> later?
>>
>>     - Idea from Florian and Paolo would be to only include:
>>           net: Make sock protocol value checks more specific
>>           sock: Make sk_protocol a 16-bit value
>>           tcp: Define IPPROTO_MPTCP
>>           # new # tcp: Add MPTCP option number
>>           tcp, ulp: Add clone operation to tcp_ulp_ops
>>           # new # mptcp: Add MPTCP to skb extensions
>>           tcp: Prevent coalesce/collapse when skb has MPTCP extensions
>> (requires MPTCP skb extensions)
> =

> Yes, that can be included too.
> =

>>           tcp: Export low-level TCP functions
>>           tcp: Check for filled TCP option space before SACK
>>           tcp: clean ext on tx recycle
>>           tcp: Expose tcp struct and routine for MPTCP
> =

> The idea would be to send that as RFC to see if there are any
> objections on the changes made in the TCP core.

OK, that's clearer.

>>     - and regarding:  "tcp: clean ext on tx recycle" =E2=86=92
>> https://github.com/multipath-tcp/mptcp_net-next/commit/bd623dbb9c27d4399=
6622660e479f2e349d23cb2
>>         - it does have some minimal MPTCP dependencies that can't be
>> removed without making such patch a no-op, so perhaps we should also
>> include some very minimal MPTCP stub definitions:
> =

> I think Paolo was referring to 'tcp: Prevent coalesce/collapse when skb
> has MPTCP extensions' here.

Yes indeed, my bad, sorry.

>>             - mptcp: Add MPTCP to skb extensions
>>             - tcp: Add MPTCP option number
>>
>>     - Or we rework the patches above not to include them now (first
>> patch set). But easier for us if they are there
>>
>>     =E2=86=92 decision: we take the list we have above and if there is a=
n issue
>> with upstream, we drop and rework patches
>>
>>     =E2=86=92 *@Florian*: may you comment this please? (linked to the di=
scussion
>> we had on "RFCv2 for netdev: what's missing?" mail thread.
> =

> Are we talking an initial patch set for upstream merging or something
> to get erly feedback on?

At the meeting, we were hoping to ask upstream to merge it.

>>     - We can send a first set (=E2=86=91), then up to kselftests (with p=
ossible
>> re-ordered/squashed patches like refactoring of recv/sendmsg) as a
>> second batch, then other chunks later
>>     - It looks like a good idea to send the first set "now" / very soon.
>>     - Matth can re-order the commits and check that each commit can be
>>
>>     - planning:
>>         - Wait for Florian comment about that (there was a new comment
>> by Florian linked to that on the ML after the meeting)
>>         - Matth does the rebase
>>         - We let half to one day for the review
>>         - Paolo sends coffee to Mat
>>         - Mat sends that to Netdev as a non RFC
>>         - (maybe: Mat, may you already send a new draft for the
>> cover-letter for this first batch?)
> =

> OK, so non RFC.  Makes no sense to me.
> =

> AFAIU we need all of the following:
> - MPTCPv1 instead of v0
> - ipv6 support
> - active/backup
> - data_fin
> =

> Were those "basic required features" revised?
> =

> If so, what are we aiming for...?
> =

> We can try of course but why should upstream apply any of these
> patches above now?
> =

> They don't fix any bugs and the added code is only extra baggage with
> no gain.
> =

> It might make sense to for upstream to apply this, but only if the
> next logical patch set would be ready to send right away after first
> batch is in.

That's a very good point, we are still aiming to implement items you
listed. Thank you for sharing this!

So the idea would be still to send the list we wrote above but as an
RFC. In the cover-letter, we would say that we would like to know:
- if there are any objections on the changes made in the TCP core.
- the goal is to send this patch-set as a non RFC one when we are ready
with our initial patch-set that we called "part 2".

Is this correct?

>> Second part of the "initial" submission:
>>     - Squash "mptcp: Make MPTCP socket block/wakeup ignore
>> sk_receive_queue" earlier in the series? (Question by Mat)
> =

> Makes sense to me to squash it.

Great, I can do that when Mat sends the confirmation where I can squash it.

>> https://github.com/multipath-tcp/mptcp_net-next/commit/de814755d1e5f7fe5=
e56c5240fcbe255361d0ad0
>>     - We can squash it, maybe in MPTCP receive path.
>>     - *@Mat*: To be confirmed by Mat after the meeting
>>
>> mptcp_recvmsg():
>>     - Paolo is working on another refactoring of mptcp_recvmsg()
>>     - Ideally, we should squash it with the previous one
>>     - Paolo hopes having something to share next week
>>
>> Another idea of squash:
>>     - the ones related to sendmsg():
>>         - mptcp: use sk_page_frag() in sendmsg
>>         - mptcp: sendmsg() do spool all the provided data
>>         - mptcp: allow collapsing consecutive sendpages on the same
>> substream
>>
>>     - they modified incrementally the code made by the previous one
>>     - It might be easier for the reviewers to have everything in one
>>     - Maybe we can rework them in 1, 2 patches: one introducing helpers
>>     - Paolo can look at that (in the near future)
> =

> Seems like a good idea as well -- one with helpers, one using them.
> =

>> Remaining items for the initial submission:
>>     - IPv6 support:
>>         - Peter is working on it
> =

> One thing that we could try is to have initial submission (if set is too
> large) not support ipv6, instead creating and ipv6 mptcp socket just
> creates a tcp socket internally.
> =

> Userspace doesn't notice because its just the same as if we would
> do full mptcp but all peers (initiators and responders) are not mp_capabl=
e.
> =

> We could then add mp_capable to ipv6 in a followup set.

That's a good alternative. I don't know if upstream would accept that :)
If the follow-up patch-set comes soon after, I guess that's fine. It
depends from who we want to have some feedback from.

>>     - DATA_FIN:
>>         - Florian might be interesting to help on that
> =

> Mat, let me know if I can help in any way.
> =

>>     - Shared recv window:
>>         - Do we need this for the initial submission? Will be needed
>> only with multiple concurrent flows
> =

> Given we need to keep side low I don't think we need it.
> =

>>         - If we accept multiple subflows, the other end might send data
>> over multiple flows (concurrently), even if the backup flag is set
> =

> We could just discard that data though, as long as the original
> non-backup link is up.

Why not indeed. As long as we do something (temporary) for this case :-)

Cheers,
Matt
-- =

Matthieu Baerts | R&D Engineer
matthieu.baerts(a)tessares.net
Tessares SA | Hybrid Access Solutions
www.tessares.net
1 Avenue Jean Monnet, 1348 Louvain-la-Neuve, Belgium
--===============6940342501919774128==--
