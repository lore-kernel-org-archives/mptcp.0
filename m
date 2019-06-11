Content-Type: multipart/mixed; boundary="===============6549098649172508706=="
MIME-Version: 1.0
From: Matthieu Baerts <matthieu.baerts at tessares.net>
To: mptcp at lists.01.org
Subject: Re: [MPTCP] [PATCH] mptcp: selftests: increase timeout and return
 error on ping failure
Date: Tue, 11 Jun 2019 10:32:30 +0200
Message-ID: <465721ff-f803-b900-6b29-5afe890f30af@tessares.net>
In-Reply-To: 20190605093658.623-1-fw@strlen.de
X-Status: 
X-Keywords:                  
X-UID: 1326

--===============6549098649172508706==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Florian, Paolo,

On 05/06/2019 11:36, Florian Westphal wrote:
> Now that we add a qdisc that does random drop, there is a small chance
> for the ping to be dropped, so this triggers:
> ns2 -> 10.0.1.2 connectivity [ FAIL ]
> =

> To fix this, split the ping test part to its own loop and only
> add the qdiscs after the ping tests have completed.
> =

> Also, the script would still exit with 0 status in this case, so update
> run_tests to check the return value of do_transfer() rather than rely on
> that function to set the global exit state in all cases.
> =

> Last, increase the timeout: with qdiscs present, 10 seconds is too low:
> in some rare cases sender or receiver exited too early.

The patch looks good to me!

@Paolo: as a major contributor to this shell script, is this patch also
looks good to you?

Thank you for having also cleaned the mix of spaces and tabs!

Just one question for later: should we print something when we start
adding delays, losses and reordering?

Cheers,
Matt
-- =

Matthieu Baerts | R&D Engineer
matthieu.baerts(a)tessares.net
Tessares SA | Hybrid Access Solutions
www.tessares.net
1 Avenue Jean Monnet, 1348 Louvain-la-Neuve, Belgium

--===============6549098649172508706==--
