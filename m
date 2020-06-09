Content-Type: multipart/mixed; boundary="===============2277208299499322335=="
MIME-Version: 1.0
From: David Miller <davem at davemloft.net>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: [PATCH net v2] mptcp: bugfix for RM_ADDR option parsing
Date: Mon, 08 Jun 2020 19:11:08 -0700
Message-ID: <20200608.191108.1901661787245617914.davem@davemloft.net>
In-Reply-To: 5ec9759a19d4eba5f7f9006354da2cfeb39fa839.1591612830.git.geliangtang@gmail.com
X-Status: 
X-Keywords:                  
X-UID: 4622

--===============2277208299499322335==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

From: Geliang Tang <geliangtang(a)gmail.com>
Date: Mon,  8 Jun 2020 18:47:54 +0800

> In MPTCPOPT_RM_ADDR option parsing, the pointer "ptr" pointed to the
> "Subtype" octet, the pointer "ptr+1" pointed to the "Address ID" octet:
> =

>   +-------+-------+---------------+
>   |Subtype|(resvd)|   Address ID  |
>   +-------+-------+---------------+
>   |               |
>  ptr            ptr+1
> =

> We should set mp_opt->rm_id to the value of "ptr+1", not "ptr". This patch
> will fix this bug.
> =

> Fixes: 3df523ab582c ("mptcp: Add ADD_ADDR handling")
> Signed-off-by: Geliang Tang <geliangtang(a)gmail.com>
> ---
>  Changes in v2:
>   - Add "-net" subject and "Fixes" tag as Matt suggested.

Applied and queued up for v5.7 -stable, thanks!
--===============2277208299499322335==--
