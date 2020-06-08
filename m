Content-Type: multipart/mixed; boundary="===============6491617705613002493=="
MIME-Version: 1.0
From: Matthieu Baerts <matthieu.baerts at tessares.net>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: [PATCH] mptcp: bugfix for RM_ADDR option parsing
Date: Mon, 08 Jun 2020 12:10:23 +0200
Message-ID: <41246875-febc-e88d-304b-2a6692f590ac@tessares.net>
In-Reply-To: 904e4ae90b94d679d9877d3c48bd277cb9b39f5f.1591601587.git.geliangtang@gmail.com
X-Status: 
X-Keywords:                  
X-UID: 4601

--===============6491617705613002493==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Geliang,

On 08/06/2020 09:48, Geliang Tang wrote:
> In MPTCPOPT_RM_ADDR option parsing, the pointer "ptr" pointed to the
> "Subtype" octet, the pointer "ptr+1" pointed to the "Address ID" octet:
> =

>    +-------+-------+---------------+
>    |Subtype|(resvd)|   Address ID  |
>    +-------+-------+---------------+
>    |               |
>   ptr            ptr+1
> =

> We should set mp_opt->rm_id to the value of "ptr+1", not "ptr". This patch
> will fix this bug.

Thank you for the patch, good catch!
Indeed "ptr" should be incremented.

Because this is a bug-fix for net, may you clearly indicate that in the =

subject to help -net maintainers please? [PATCH net v2]

Also, may you add a "Fixes" tag as well as it is for -net ? I guess it =

should be:

     Fixes: 3df523ab582c ("mptcp: Add ADD_ADDR handling")

The rest is good!

Cheers,
Matt
-- =

Matthieu Baerts | R&D Engineer
matthieu.baerts(a)tessares.net
Tessares SA | Hybrid Access Solutions
www.tessares.net
1 Avenue Jean Monnet, 1348 Louvain-la-Neuve, Belgium
--===============6491617705613002493==--
