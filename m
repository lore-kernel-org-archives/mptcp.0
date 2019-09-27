Content-Type: multipart/mixed; boundary="===============4066146143658702773=="
MIME-Version: 1.0
From: Peter Krystad <peter.krystad at linux.intel.com>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: some squashing needed?
Date: Fri, 27 Sep 2019 16:34:00 -0700
Message-ID: <711dde7678a8eb50f49210e7e327614bbd50c2d4.camel@linux.intel.com>
In-Reply-To: 20190927211111.GI9938@breakpoint.cc
X-Status: 
X-Keywords:                  
X-UID: 1947

--===============4066146143658702773==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On Fri, 2019-09-27 at 23:11 +0200, Florian Westphal wrote:
> Matthieu Baerts <matthieu.baerts(a)tessares.net> wrote:
> > On 27/09/2019 17:51, Florian Westphal wrote:
> > > I can fold Peters mptcp prefix patch for crypto where needed and push=
 a
> > > v2, let me know.
> > =

> > I just pushed a new tree on mptcp_net-next repo on Github based on your
> > branch :)
> =

> Awesome.
> =

> > I didn't want to block anybody but I can re-create a new one again later
> > if needed!
> =

> Great.
> =

> > Also I don't mind squashing this patch and also do the same for the
> > remaining functions (subflow_ ones I guess). I can do that on Monday if
> > it is OK for you.
> =

> Sure.
> =

> I squashed Peters patch, you can get a branch with it folded by pulling
> git://git.breakpoint.cc/fw/mptcp-next.git export_squash_11
> =

> The diff between current export and this branch is Peters patch, nothing
> else.
> =

> If you could prefix the path management api that would be great (to avoid
> confusion with 'power management') subflow would be good too.

I created this prefix patch for path management api today, will post. I will
include patch 1/2 "Minor changes to path manager interface" from my "Interim
Path Manager" set, since it should also squash nicely into the "Implement p=
ath manager interface commands" commit.

Peter.


> > Also, before recreating the new tree, I remove all (Git) refs to the
> > previous ones. If someone uses our repo with Topgit (we never know :) ),
> > please do the same on your side!
> =

> Sorry, not following.  What would you like me to do?
> =

> I plan to work on a v2 of the snmp counters on Monday, esp. dropping all
> the unused/dubious counters.
> =

> If there is anything else please let me know.
> =

> I still need to do v2 of the 'poll' patch set, I will do that next after
> the snmp counters are done.
> =

> Thanks,
> Florian
> _______________________________________________
> mptcp mailing list
> mptcp(a)lists.01.org
> https://lists.01.org/mailman/listinfo/mptcp

--===============4066146143658702773==--
