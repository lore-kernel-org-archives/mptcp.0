Content-Type: multipart/mixed; boundary="===============7554421342859002596=="
MIME-Version: 1.0
From: Matthieu Baerts <matthieu.baerts at tessares.net>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: [PATCH]
 Squash-to-mptcp-Create-SUBFLOW-socket-for-incoming-connections
Date: Fri, 13 Dec 2019 01:25:34 +0100
Message-ID: <884b514f-2728-0d9d-9d50-409203e7e17c@tessares.net>
In-Reply-To: 500c372287d2af8bbbe0dc811e5566b07ce2160e.1576196206.git.pabeni@redhat.com
X-Status: 
X-Keywords:                  
X-UID: 2911

--===============7554421342859002596==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Paolo,

On 13/12/2019 01:18, Paolo Abeni wrote:
> Need to explicitly clear msk->subflow on passive connection, or
> it will inherit the listener msk value, which is uncorrect
> =

> This fixes hang-up pre-v1 patches.
> =

> Still investigating why the v1 code did non hang without this.

Thank you for the patch, that was quick!

I already applied it to let the CI running during the night. If needed, =

we can still easily revert/improve it later.

- 9029651dddd7: "squashed" in "mptcp: Create SUBFLOW socket for incoming =

connections"
- d71e217c05ae: conflict in t/mptcp-Add-key-generation-and-token-tree
- 45cba5f6b369..3b3ffeb26480: result

Tests + export in progress.

Cheers,
Matt
-- =

Matthieu Baerts | R&D Engineer
matthieu.baerts(a)tessares.net
Tessares SA | Hybrid Access Solutions
www.tessares.net
1 Avenue Jean Monnet, 1348 Louvain-la-Neuve, Belgium
--===============7554421342859002596==--
