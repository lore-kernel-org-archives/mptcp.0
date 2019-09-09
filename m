Content-Type: multipart/mixed; boundary="===============2110162289968841579=="
MIME-Version: 1.0
From: Florian Westphal <fw at strlen.de>
To: mptcp at lists.01.org
Subject: [MPTCP] [PATCH 0/4] mptcp sparse "fixes"
Date: Tue, 10 Sep 2019 01:17:21 +0200
Message-ID: <20190909231725.4952-1-fw@strlen.de>
X-Status: 
X-Keywords:                  
X-UID: 1807

--===============2110162289968841579==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

NB: these patches don't fix anything because nothing is broken.

The "sparse" checker complains about various constructs, this fixes
some of those.  All of these can be squashed, I've
placed the name of the target commit in the change logs.

There are more sparse warnings in the code base, I am intentionally
skipping those for now as its in code that is still "in flux".

For example the icsk ulp data pointer now has an __rcu annotation upstream
so sparse complains because we don't use rcu_dereference() or similar.

In any case, I think those can be fixed once the code has stabilized more.
I am sending these now because they are in more "mature" areas and it
reduces the delta between my working tree and the "export" branch.

Thanks,
Florian

 crypto.c   |    2 ++
 options.c  |    4 ++--
 pm.c       |    2 +-
 protocol.h |    2 +-
 4 files changed, 6 insertions(+), 4 deletions(-)



--===============2110162289968841579==--
