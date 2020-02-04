Content-Type: multipart/mixed; boundary="===============0799029250418616663=="
MIME-Version: 1.0
From: Matthieu Baerts <matthieu.baerts at tessares.net>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: [syzkaller] KASAN: use-after-free Write in __lock_sock
Date: Tue, 04 Feb 2020 13:34:36 +0100
Message-ID: <154a5d21-47ff-33e8-d599-ca10a24e9714@tessares.net>
In-Reply-To: 5b235b4f2636c7621be6a8526e8b6f5cfb7852de.camel@redhat.com
X-Status: 
X-Keywords:                  
X-UID: 3582

--===============0799029250418616663==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Paolo,

On 04/02/2020 10:12, Paolo Abeni wrote:
> That is unfortunated, I liked the fact that a fallback socket got the
> same performances of a plain TCP socket (could encourage MPTCP adoption
> - not sure that is good thing, anyway ;)

That would be nice but we can also say that this case is supposed to be =

an exception. If you create an "MPTCP socket" on purpose, you hope to =

use MPTCP, certainly because you know the server side supports MPTCP and =

maybe you also know that there is no middleboxes blocking MPTCP on the path.

So maybe as a first step and *if it eases things*, the fallback could =

have extra overheads.

Cheers,
Matt
-- =

Matthieu Baerts | R&D Engineer
matthieu.baerts(a)tessares.net
Tessares SA | Hybrid Access Solutions
www.tessares.net
1 Avenue Jean Monnet, 1348 Louvain-la-Neuve, Belgium
--===============0799029250418616663==--
