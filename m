Content-Type: multipart/mixed; boundary="===============0615494013518405155=="
MIME-Version: 1.0
From: Matthieu Baerts <matthieu.baerts at tessares.net>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: [PATCH v5 0/6] mptcp: just another complete datapath
 refactor
Date: Thu, 19 Nov 2020 18:07:46 +0100
Message-ID: <fefef62d-35cf-eae2-24f5-c353edefc6f6@tessares.net>
In-Reply-To: cover.1605789317.git.pabeni@redhat.com
X-Status: 
X-Keywords:                  
X-UID: 6835

--===============0615494013518405155==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Paolo, Florian, Mat,

On 19/11/2020 13:38, Paolo Abeni wrote:
> This iteration introduces some improvement for the wake-up/poll code
> as discussed on the ML.
> =

> The last 2 patches in the previous iterations has been merged in a single
> one, with all the relevant deltas noted there.
> =

> Looking for merge now ;)

Done!

Thank you for your patches and reviews!

I just applied these patches in our tree after having fixed a few =

checkpatch issues (only related to codespell), remove "." at the end of =

the commit title, resolved one conflict with the patch (6/6) due to =

"mptcp: update rtx timeout only if required." patch applied earlier =

today and add Florian's Acked-by.

@Mat: please tell me if you want me to add your Reviewed-by tags on =

these ones ;-)

  - ea8e2035dfab: mptcp: open code mptcp variant for lock_sock
  - 8983b6ddc2a0: mptcp: implement wmem reservation
  - 44bb6c6d4e7f: mptcp: protect the rx path with the msk socket spinlock
  - 3a54a74a3c5b: mptcp: allocate TX skbs in msk context
  - 7ca128e90452: mptcp: avoid a few atomic ops in the rx path
  - 6b142355778a: mptcp: use mptcp release_cb for delayed tasks

  - Results: 55b2596bdf31..11818af71ea2

Tests + export are in progress.

Note that I already updated the export branch manually =

(export/20201119T175232) to let Christoph already starting some tests =

with syzkaller.

Cheers,
Matt
-- =

Tessares | Belgium | Hybrid Access Solutions
www.tessares.net
--===============0615494013518405155==--
