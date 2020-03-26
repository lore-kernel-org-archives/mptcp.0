Content-Type: multipart/mixed; boundary="===============0819481834822394318=="
MIME-Version: 1.0
From: Matthieu Baerts <matthieu.baerts at tessares.net>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: [PATCH net-next v3] Squash-to: "mptcp: add netlink-based
 PM"
Date: Thu, 26 Mar 2020 14:53:16 +0100
Message-ID: <60934ce2-342d-2d4f-ae01-de1917118dbd@tessares.net>
In-Reply-To: b733f047245027ea51dfc99e02d56fe8ff6aa13c.1585223512.git.pabeni@redhat.com
X-Status: 
X-Keywords:                  
X-UID: 4074

--===============0819481834822394318==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Paolo,

On 26/03/2020 12:53, Paolo Abeni wrote:
> Let user space set a single limit at once and drop bogus
> NL extack error message.
> =

> v2 -> v3:
>   - better error message (Mat)
>   - add spinlock
>   - relax admin constraint on 'getters'
> =

> v1 -> v2:
>   - do not include dumb dbg messages

Thank you for the v3, it looks good to  me!

Cheers,
Matt
-- =

Matthieu Baerts | R&D Engineer
matthieu.baerts(a)tessares.net
Tessares SA | Hybrid Access Solutions
www.tessares.net
1 Avenue Jean Monnet, 1348 Louvain-la-Neuve, Belgium
--===============0819481834822394318==--
