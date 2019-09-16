Content-Type: multipart/mixed; boundary="===============6717328386154777075=="
MIME-Version: 1.0
From: Matthieu Baerts <matthieu.baerts at tessares.net>
To: mptcp at lists.01.org
Subject: Re: [MPTCP] [PATCH] mptcp: remove token_release
Date: Mon, 16 Sep 2019 19:55:42 +0200
Message-ID: <a14381f6-8da1-a82c-18a9-6907f51e2cc3@tessares.net>
In-Reply-To: 20190913153832.GC10656@breakpoint.cc
X-Status: 
X-Keywords:                  
X-UID: 1853

--===============6717328386154777075==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Florian,

On 13/09/2019 17:38, Florian Westphal wrote:
> Matthieu Baerts <matthieu.baerts(a)tessares.net> wrote:
>> Do you want me to add it at the end of squash in another commit?
>> I was going to add it at the end but the commit message seems to show
>> that it should be squashed in another commit.
>>
>> Paolo proposed cd2d4eeca99b ("mptcp: Add key generation and token tree")
>> in his initial commit. Should I do that too?
> =

> I would be fine with squashing but I'd wager it adds some extra work due
> to the refactoring.
> =

> So, handle it as you deem best.

Indeed, the refactoring at the end is not helpful if we want to continue
squashing thing. I also saw that the commit introducing the Token API
("mptcp: Add key generation and token tree") is calling functions that
are not available. So I decided to include all changes related to how
the Token API is used in the original commit and the rest in the
refactoring. I hope it is fine like that!

- 5ee88b657e3f: "squashed", part 1 in "mptcp: Add key generation and
token tree"
- 8e2060c69d83: conflict in t/mptcp-token-add-mptcp-prefixes-to-functions
- 41af4de887d8: "squashed", part 2 in "mptcp: Add handling of incoming
MP_JOIN requests"
- 27740d83cacb: "squashed", part 3 in "mptcp: token: add mptcp prefixes
to functions"

Tests are still OK!

Next time I will apply patches quicker! I hope I didn't block you!

Cheers,
Matt
-- =

Matthieu Baerts | R&D Engineer
matthieu.baerts(a)tessares.net
Tessares SA | Hybrid Access Solutions
www.tessares.net
1 Avenue Jean Monnet, 1348 Louvain-la-Neuve, Belgium

--===============6717328386154777075==--
