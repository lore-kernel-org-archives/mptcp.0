Content-Type: multipart/mixed; boundary="===============6568987194153702941=="
MIME-Version: 1.0
From: Matthieu Baerts <matthieu.baerts at tessares.net>
To: mptcp at lists.01.org
Subject: [MPTCP] Preparation of patches for netdev: status
Date: Fri, 06 Dec 2019 22:42:05 +0100
Message-ID: <d1183373-854c-63b5-7d8e-bc8a83ae2307@tessares.net>
X-Status: 
X-Keywords:                  
X-UID: 2836

--===============6568987194153702941==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hello,

It took me more time than expected but I applied all the patches that =

needed to be applied, the list is now empty:

   https://patchwork.ozlabs.org/project/mptcp/list/?state=3D8

There are some new patches that needs review:

   https://patchwork.ozlabs.org/project/mptcp/list/


But in summary, here are the items that still need to be done:

  1) Rebase of Florian's patches added at the end of the series (at =

least the ones impacting code before MPTCPv1 patches)

  2) Remove export of __tcp_poll()

  3) Review fixes related to TCP fallback from Paolo (RFC)

  4) Review the update of the MAINTAINERS file / apply comments (?)

  5) Check if there is no issue with MPTCPv1 patches (+ fixes if needed)

  6) Review Mat's cover letters (part 1 & 2)

  7) New cover letter for part 3

  8) Review all commit messages (part 1, 2, 3)

  9) Add signed-off of the submitters

  10) Tests


*Florian* : is it still OK for you to do the rebase, items 1 & 2? :)
             no urgency because we no longer target Monday but the end =

of the week.


*Christoph* : may you look at the item 7 please? :)


I can do the item 9.

For the rest, they can be done by anybody, sometimes even better if =

there are multiple people.

I hope I listed everything! Please tell me if something is missing or =

not correct!

Cheers,
Matt
-- =

Matthieu Baerts | R&D Engineer
matthieu.baerts(a)tessares.net
Tessares SA | Hybrid Access Solutions
www.tessares.net
1 Avenue Jean Monnet, 1348 Louvain-la-Neuve, Belgium
--===============6568987194153702941==--
