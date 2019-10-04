Content-Type: multipart/mixed; boundary="===============7864607914797920518=="
MIME-Version: 1.0
From: Florian Westphal <fw at strlen.de>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: [Weekly meetings] MoM - 3rd of October 2019
Date: Fri, 04 Oct 2019 16:31:05 +0200
Message-ID: <20191004143105.GF13866@breakpoint.cc>
In-Reply-To: c813e222-dff2-76b7-8fe9-ddc85cff0439@tessares.net
X-Status: 
X-Keywords:                  
X-UID: 2016

--===============7864607914797920518==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Matthieu Baerts <matthieu.baerts(a)tessares.net> wrote:
> RFCv2 sent to netdev:
>     - Feedback: Dave M says 40-some patches is way too many, and to
> repost series with no more than 12-20 patches
> https://lore.kernel.org/netdev/20191002.171229.1495727500341484392.davem(=
a)davemloft.net/
>
>     - We could squash more aggressively to reduce in-series code churn
> and the patch count
> =

>     - Or we send less (less at a time)
>     - Or we do both (squash + send less at a time)
>     - Maybe easier to send a first subset and then squash other patches
> later?
> =

>     - Idea from Florian and Paolo would be to only include:
>           net: Make sock protocol value checks more specific
>           sock: Make sk_protocol a 16-bit value
>           tcp: Define IPPROTO_MPTCP
>           # new # tcp: Add MPTCP option number
>           tcp, ulp: Add clone operation to tcp_ulp_ops
>           # new # mptcp: Add MPTCP to skb extensions
>           tcp: Prevent coalesce/collapse when skb has MPTCP extensions
> (requires MPTCP skb extensions)

Yes, that can be included too.

>           tcp: Export low-level TCP functions
>           tcp: Check for filled TCP option space before SACK
>           tcp: clean ext on tx recycle
>           tcp: Expose tcp struct and routine for MPTCP

The idea would be to send that as RFC to see if there are any
objections on the changes made in the TCP core.

>     - and regarding:  "tcp: clean ext on tx recycle" =E2=86=92
> https://github.com/multipath-tcp/mptcp_net-next/commit/bd623dbb9c27d43996=
622660e479f2e349d23cb2
>         - it does have some minimal MPTCP dependencies that can't be
> removed without making such patch a no-op, so perhaps we should also
> include some very minimal MPTCP stub definitions:

I think Paolo was referring to 'tcp: Prevent coalesce/collapse when skb
has MPTCP extensions' here.

>             - mptcp: Add MPTCP to skb extensions
>             - tcp: Add MPTCP option number
> =

>     - Or we rework the patches above not to include them now (first
> patch set). But easier for us if they are there
> =

>     =E2=86=92 decision: we take the list we have above and if there is an=
 issue
> with upstream, we drop and rework patches
> =

>     =E2=86=92 *@Florian*: may you comment this please? (linked to the dis=
cussion
> we had on "RFCv2 for netdev: what's missing?" mail thread.

Are we talking an initial patch set for upstream merging or something
to get erly feedback on?

>     - We can send a first set (=E2=86=91), then up to kselftests (with po=
ssible
> re-ordered/squashed patches like refactoring of recv/sendmsg) as a
> second batch, then other chunks later
>     - It looks like a good idea to send the first set "now" / very soon.
>     - Matth can re-order the commits and check that each commit can be
> =

>     - planning:
>         - Wait for Florian comment about that (there was a new comment
> by Florian linked to that on the ML after the meeting)
>         - Matth does the rebase
>         - We let half to one day for the review
>         - Paolo sends coffee to Mat
>         - Mat sends that to Netdev as a non RFC
>         - (maybe: Mat, may you already send a new draft for the
> cover-letter for this first batch?)

OK, so non RFC.  Makes no sense to me.

AFAIU we need all of the following:
- MPTCPv1 instead of v0
- ipv6 support
- active/backup
- data_fin

Were those "basic required features" revised?

If so, what are we aiming for...?

We can try of course but why should upstream apply any of these
patches above now?

They don't fix any bugs and the added code is only extra baggage with
no gain.

It might make sense to for upstream to apply this, but only if the
next logical patch set would be ready to send right away after first
batch is in.

> Second part of the "initial" submission:
>     - Squash "mptcp: Make MPTCP socket block/wakeup ignore
> sk_receive_queue" earlier in the series? (Question by Mat)

Makes sense to me to squash it.

> https://github.com/multipath-tcp/mptcp_net-next/commit/de814755d1e5f7fe5e=
56c5240fcbe255361d0ad0
>     - We can squash it, maybe in MPTCP receive path.
>     - *@Mat*: To be confirmed by Mat after the meeting
> =

> mptcp_recvmsg():
>     - Paolo is working on another refactoring of mptcp_recvmsg()
>     - Ideally, we should squash it with the previous one
>     - Paolo hopes having something to share next week
> =

> Another idea of squash:
>     - the ones related to sendmsg():
>         - mptcp: use sk_page_frag() in sendmsg
>         - mptcp: sendmsg() do spool all the provided data
>         - mptcp: allow collapsing consecutive sendpages on the same
> substream
> =

>     - they modified incrementally the code made by the previous one
>     - It might be easier for the reviewers to have everything in one
>     - Maybe we can rework them in 1, 2 patches: one introducing helpers
>     - Paolo can look at that (in the near future)

Seems like a good idea as well -- one with helpers, one using them.

> Remaining items for the initial submission:
>     - IPv6 support:
>         - Peter is working on it

One thing that we could try is to have initial submission (if set is too
large) not support ipv6, instead creating and ipv6 mptcp socket just
creates a tcp socket internally.

Userspace doesn't notice because its just the same as if we would
do full mptcp but all peers (initiators and responders) are not mp_capable.

We could then add mp_capable to ipv6 in a followup set.

>     - DATA_FIN:
>         - Florian might be interesting to help on that

Mat, let me know if I can help in any way.

>     - Shared recv window:
>         - Do we need this for the initial submission? Will be needed
> only with multiple concurrent flows

Given we need to keep side low I don't think we need it.

>         - If we accept multiple subflows, the other end might send data
> over multiple flows (concurrently), even if the backup flag is set

We could just discard that data though, as long as the original
non-backup link is up.
--===============7864607914797920518==--
