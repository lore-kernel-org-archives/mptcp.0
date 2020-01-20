Content-Type: multipart/mixed; boundary="===============2074435492044007077=="
MIME-Version: 1.0
From: Matthieu Baerts <matthieu.baerts at tessares.net>
To: mptcp at lists.01.org
Subject: [MPTCP] Part 2 for Netdev: remaining items
Date: Mon, 20 Jan 2020 15:58:11 +0100
Message-ID: <efe45551-0486-5d34-4ad0-49fa8a372490@tessares.net>
X-Status: 
X-Keywords:                  
X-UID: 3426

--===============2074435492044007077==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hello!

On a pad, I listed the different things to do before sending the new =

version to netdev:

  https://annuel2.framapad.org/p/mptcp_upstreaming_20200116_patches_part2


In summary:

- 1223968: mptcp: Store 32 and 64-bit ACKs separately
   =E2=86=92 Needs Review

- 1224646: mptcp: Optimize DSS fields in mptcp_options_received
   =E2=86=92 Changes Requested, or not? (not clear for me)

- a few patches to be applied
   =E2=86=92 I will do that: mainly changing commit messages, comments, etc.

- subflow.c:undefined reference to `__crypto_memneq'
   =E2=86=92 see another email thread from Florian: what do we need to do?


Did I miss something? Feel free to help on the above items ;-)

Cheers,
Matt
-- =

Matthieu Baerts | R&D Engineer
matthieu.baerts(a)tessares.net
Tessares SA | Hybrid Access Solutions
www.tessares.net
1 Avenue Jean Monnet, 1348 Louvain-la-Neuve, Belgium
--===============2074435492044007077==--
