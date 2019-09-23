Content-Type: multipart/mixed; boundary="===============1905123585310919691=="
MIME-Version: 1.0
From: Matthieu Baerts <matthieu.baerts at tessares.net>
To: mptcp at lists.01.org
Subject: Re: [MPTCP] some squashing needed?
Date: Mon, 23 Sep 2019 14:03:45 +0200
Message-ID: <d6652269-b3bd-4ec6-5a29-06f481b605b2@tessares.net>
In-Reply-To: 532bd9a907852fdf3ef1007e65937c43fc0d7075.camel@redhat.com
X-Status: 
X-Keywords:                  
X-UID: 1906

--===============1905123585310919691==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Paolo,

Thank you for asking these questions!

On 23/09/2019 13:41, Paolo Abeni wrote:
> Hi all,
> =

> the current series is pretty big, and it will likely grow before it
> will be feature complete.
> =

> I think we should look after some squashing, but how do we do that? =

> Just asking good/poor Matt: "please squash chunk 1 of patch X into
> patch Y, <etc...>" ? (Yep Matt, you are authorized to hate me after
> that suggestion!)

That's fine, Belgium was not stopped at the last soccer World Cup
because of Italy, I will not hate you even after having proposed this
suggestion! :-D

I am really fine with this! After each rebase, I can send the diff
(which should be empty).

I can also split files, move and rename functions but maybe better if I
can do that directly in Git without having to first do some changes on
top of the series, drop them and do the job commit by commit. After
these changes directly in Git, I can send the diff for the review.

> Resending the whole squashed series/specific patches for a
> partial/complete replace?

I understand that "because of" Topgit, some people might not want to do
the rebase. But if someone prefers to do the rebase himself, it is
indeed still possible to do that directly with Git using the last
"export" branch.

We can even re-create a new TopGit tree after this rebase if we plan to
continue maintaining it on the side. The idea would be to still be able
to easily see the squash I do + continue to use the script to "rebase"
it on top of net-next.

> Is there any smarter options available? =


Could we maybe already send some patches to already have some stuff
upstream? :-)

Cheers,
Matt
-- =

Matthieu Baerts | R&D Engineer
matthieu.baerts(a)tessares.net
Tessares SA | Hybrid Access Solutions
www.tessares.net
1 Avenue Jean Monnet, 1348 Louvain-la-Neuve, Belgium

--===============1905123585310919691==--
