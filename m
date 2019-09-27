Content-Type: multipart/mixed; boundary="===============2184011300525702175=="
MIME-Version: 1.0
From: Florian Westphal <fw at strlen.de>
To: mptcp at lists.01.org
Subject: Re: [MPTCP] some squashing needed?
Date: Fri, 27 Sep 2019 23:11:11 +0200
Message-ID: <20190927211111.GI9938@breakpoint.cc>
In-Reply-To: 0290621d-11de-6515-baf9-429ed9582783@tessares.net
X-Status: 
X-Keywords:                  
X-UID: 1942

--===============2184011300525702175==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Matthieu Baerts <matthieu.baerts(a)tessares.net> wrote:
> On 27/09/2019 17:51, Florian Westphal wrote:
> > I can fold Peters mptcp prefix patch for crypto where needed and push a
> > v2, let me know.
> =

> I just pushed a new tree on mptcp_net-next repo on Github based on your
> branch :)

Awesome.

> I didn't want to block anybody but I can re-create a new one again later
> if needed!

Great.

> Also I don't mind squashing this patch and also do the same for the
> remaining functions (subflow_ ones I guess). I can do that on Monday if
> it is OK for you.

Sure.

I squashed Peters patch, you can get a branch with it folded by pulling
git://git.breakpoint.cc/fw/mptcp-next.git export_squash_11

The diff between current export and this branch is Peters patch, nothing
else.

If you could prefix the path management api that would be great (to avoid
confusion with 'power management') subflow would be good too.

> Also, before recreating the new tree, I remove all (Git) refs to the
> previous ones. If someone uses our repo with Topgit (we never know :) ),
> please do the same on your side!

Sorry, not following.  What would you like me to do?

I plan to work on a v2 of the snmp counters on Monday, esp. dropping all
the unused/dubious counters.

If there is anything else please let me know.

I still need to do v2 of the 'poll' patch set, I will do that next after
the snmp counters are done.

Thanks,
Florian

--===============2184011300525702175==--
