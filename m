Content-Type: multipart/mixed; boundary="===============7185717557763775541=="
MIME-Version: 1.0
From: Matthieu Baerts <matthieu.baerts at tessares.net>
To: mptcp at lists.01.org
Subject: Re: [MPTCP] [PATCH v2 0/2] mptcp: simplify crypto.c
Date: Wed, 24 Jul 2019 14:53:07 +0200
Message-ID: <b1a8be0c-dc31-23f1-69fa-46e7797783d2@tessares.net>
In-Reply-To: cover.1563903620.git.dcaratti@redhat.com
X-Status: 
X-Keywords:                  
X-UID: 1549

--===============7185717557763775541==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Davide, Mat, Peter, Florian,

On 23/07/2019 19:47, Davide Caratti wrote:
> his series wants to simplify, and hopefully improve, random generation
> of keys and nonces in crypto.c, While at it, I removed some unneeded
> #includes on top of the file. Any feedbacks are welcome!
> =

> Note:
>  in case you think the code is ok, I will propose to squash it into
>  commit a564283a1e38 ("mptcp: Add key generation and token tree")
> =

> Changes since v1:
>  - add a comment that suggests use of hash to improve performance,
>    thanks to Matthieu
>  - remove useless #include <tcp.h>, thanks Mat =

> =

> Changes since RFC:
>  - use get_random_bytes() instead of siphash, thanks to Florian / Mat =

> =

> =

> Davide Caratti (2):
>   net: mptcp: remove useless #includes in crypto.c
>   net: mptcp: randomness improvements for crypto.c

Thank you for the patch, the new version and the reviews!

- 830d99ebce23: first patch squashed in "mptcp: Add key generation and
token tree"
- 1395553e7bbb: signed-off
- 3957d8f5d7dc: second patch partly squashed in "mptcp: Add key
generation and token tree" (with conflicts)
- 1e46a4a65f49: conflict in
t/mptcp-Write-MPTCP-DSS-headers-to-outgoing-data-packets
- 6d9bd00afae6: conflict in
t/mptcp-Make-connection_list-a-real-list-of-subflows
- 14b72baa0fbf: second patch partly squashed in "mptcp: Add handling of
incoming MP_JOIN requests"
- 49e73e4934b4..7b0096b174c5: result

Tests are still OK!

Cheers,
Matt
-- =

Matthieu Baerts | R&D Engineer
matthieu.baerts(a)tessares.net
Tessares SA | Hybrid Access Solutions
www.tessares.net
1 Avenue Jean Monnet, 1348 Louvain-la-Neuve, Belgium

--===============7185717557763775541==--
