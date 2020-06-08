Content-Type: multipart/mixed; boundary="===============8371766725740277661=="
MIME-Version: 1.0
From: Matthieu Baerts <matthieu.baerts at tessares.net>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: [PATCH net v2] mptcp: bugfix for RM_ADDR option parsing
Date: Mon, 08 Jun 2020 13:19:02 +0200
Message-ID: <983bab97-ed03-c84b-5bbb-b79b5dc5afb0@tessares.net>
In-Reply-To: 5ec9759a19d4eba5f7f9006354da2cfeb39fa839.1591612830.git.geliangtang@gmail.com
X-Status: 
X-Keywords:                  
X-UID: 4606

--===============8371766725740277661==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Geliang,

On 08/06/2020 12:47, Geliang Tang wrote:
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
> =

> Fixes: 3df523ab582c ("mptcp: Add ADD_ADDR handling")
> Signed-off-by: Geliang Tang <geliangtang(a)gmail.com>
> ---
>   Changes in v2:
>    - Add "-net" subject and "Fixes" tag as Matt suggested.

Thanks for this v2! LGTM!

Reviewed-by: Matthieu Baerts <matthieu.baerts(a)tessares.net>

Cheers,
Matt
-- =

Matthieu Baerts | R&D Engineer
matthieu.baerts(a)tessares.net
Tessares SA | Hybrid Access Solutions
www.tessares.net
1 Avenue Jean Monnet, 1348 Louvain-la-Neuve, Belgium
--===============8371766725740277661==--
