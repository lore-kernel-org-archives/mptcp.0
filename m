Content-Type: multipart/mixed; boundary="===============1274059954361476866=="
MIME-Version: 1.0
From: Florian Westphal <fw at strlen.de>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: [Weekly meetings] MoM - 3rd of October 2019
Date: Sat, 05 Oct 2019 11:28:55 +0200
Message-ID: <20191005092855.GJ13866@breakpoint.cc>
In-Reply-To: 7ebb42f3-b7cc-eca3-ba0f-9469a5ad63e0@tessares.net
X-Status: 
X-Keywords:                  
X-UID: 2021

--===============1274059954361476866==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Matthieu Baerts <matthieu.baerts(a)tessares.net> wrote:
> So the idea would be still to send the list we wrote above but as an
> RFC. In the cover-letter, we would say that we would like to know:
> - if there are any objections on the changes made in the TCP core.
> - the goal is to send this patch-set as a non RFC one when we are ready
> with our initial patch-set that we called "part 2".
> =

> Is this correct?

Yes.

> >> Second part of the "initial" submission:
> >>     - Squash "mptcp: Make MPTCP socket block/wakeup ignore
> >> sk_receive_queue" earlier in the series? (Question by Mat)
> > =

> > Makes sense to me to squash it.
> =

> Great, I can do that when Mat sends the confirmation where I can squash i=
t.

Thanks!

> >> Another idea of squash:
> >>     - the ones related to sendmsg():
> >>         - mptcp: use sk_page_frag() in sendmsg
> >>         - mptcp: sendmsg() do spool all the provided data
> >>         - mptcp: allow collapsing consecutive sendpages on the same
> >> substream
> >>
> >>     - they modified incrementally the code made by the previous one
> >>     - It might be easier for the reviewers to have everything in one
> >>     - Maybe we can rework them in 1, 2 patches: one introducing helpers
> >>     - Paolo can look at that (in the near future)
> > =

> > Seems like a good idea as well -- one with helpers, one using them.

I discussed squashing the sendmsg refactor ("spool all the data" and so on)
with Paolo yesterday and will have a stab at this.

No need to stop working on the export branch/freeze things for now.

> >> Remaining items for the initial submission:
> >>     - IPv6 support:
> >>         - Peter is working on it
> > =

> > One thing that we could try is to have initial submission (if set is too
> > large) not support ipv6, instead creating and ipv6 mptcp socket just
> > creates a tcp socket internally.
> > =

> > Userspace doesn't notice because its just the same as if we would
> > do full mptcp but all peers (initiators and responders) are not mp_capa=
ble.
> > =

> > We could then add mp_capable to ipv6 in a followup set.
> =

> That's a good alternative. I don't know if upstream would accept that :)
>
> If the follow-up patch-set comes soon after, I guess that's fine. It
> depends from who we want to have some feedback from.

Well, davem can't have it both ways :-)
And yes, I assumed that ipv6 support would be ready at this time, and
was only omitted to keep size of the batch down.
--===============1274059954361476866==--
