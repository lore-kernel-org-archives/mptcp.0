Content-Type: multipart/mixed; boundary="===============2396515036665216743=="
MIME-Version: 1.0
From: Florian Westphal <fw at strlen.de>
To: mptcp at lists.01.org
Subject: Re: [MPTCP] [PATCH] mptcp: remove token_release
Date: Fri, 13 Sep 2019 17:38:32 +0200
Message-ID: <20190913153832.GC10656@breakpoint.cc>
In-Reply-To: f2c9dd39-d305-b5a6-c763-e99e1e88b00d@tessares.net
X-Status: 
X-Keywords:                  
X-UID: 1845

--===============2396515036665216743==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Matthieu Baerts <matthieu.baerts(a)tessares.net> wrote:
> Do you want me to add it at the end of squash in another commit?
> I was going to add it at the end but the commit message seems to show
> that it should be squashed in another commit.
> =

> Paolo proposed cd2d4eeca99b ("mptcp: Add key generation and token tree")
> in his initial commit. Should I do that too?

I would be fine with squashing but I'd wager it adds some extra work due
to the refactoring.

So, handle it as you deem best.

--===============2396515036665216743==--
