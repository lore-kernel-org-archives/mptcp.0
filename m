Content-Type: multipart/mixed; boundary="===============0689282801313481600=="
MIME-Version: 1.0
From: Matthieu Baerts <matthieu.baerts at tessares.net>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: [PATCH mptcp-next 0/2] mptcp: receive buffer auto-tuning
Date: Wed, 10 Jun 2020 16:08:39 +0200
Message-ID: <c6bec1fa-19e8-c1ba-87a7-3fe9e8dcbebf@tessares.net>
In-Reply-To: 20200610115534.17417-1-fw@strlen.de
X-Status: 
X-Keywords:                  
X-UID: 4640

--===============0689282801313481600==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Florian, Christoph,

On 10/06/2020 13:55, Florian Westphal wrote:
> First patch adds switch to test script so it can be run with a fixed
> file size rather than a random one.
> =

> Second patch adds receive buffer autotuning.  I rebased this on top
> of mptcp-next as per Christophs patch suggestion to make sure the
> initialisation function has been run for the fallback case too.
> =

> I suggest to apply this to mptcp-next so this can be pushed to net-next
> once that opens up again.

Thank you for the patches and the reviews (of the previous version)!

I just added the two patches at the end of the "export" branch (before =

the two DO-NOT-MERGE commits).

- 5fb9128339d6..4f2bd7bdf714: result

As discussed in patch 1/2, I also added a tiny fix:

- ab8953b09d86: selftests: mptcp: fix typo in usage
- (of course, no new signed-off-by tags were added)
- 4f2bd7bdf714..76c6304b26cb: result

Just to be sure (and not to ask to work on this, it's not urgent): I =

guess these modifications don't improve the situation for:

     https://github.com/multipath-tcp/mptcp_net-next/issues/6

The "export" branch has already been updated and tests are still OK.

Cheers,
Matt
-- =

Tessares | Belgium | Hybrid Access Solutions
www.tessares.net
--===============0689282801313481600==--
