Content-Type: multipart/mixed; boundary="===============5916612041269098499=="
MIME-Version: 1.0
From: Matthieu Baerts <matthieu.baerts at tessares.net>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: [MPTCP][PATCH v3 mptcp-next] mptcp: send ack for every
 add_addr
Date: Fri, 22 Jan 2021 19:08:04 +0100
Message-ID: <2b5cc55c-49f5-c0f6-f275-feda707468e4@tessares.net>
In-Reply-To: 93f8d1cb4ad54d30539c7a3ec1455afc13388844.1611314528.git.geliangtang@gmail.com
X-Status: 
X-Keywords:                  
X-UID: 7472

--===============5916612041269098499==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Geliang, Paolo,

On 22/01/2021 12:25, Geliang Tang wrote:
> This patch changes the sending ACK conditions for the ADD_ADDR, send an A=
CK
> packet for any ADD_ADDR, not just when ipv6 addresses or port numbers
> are included.
> =

> Closes: https://github.com/multipath-tcp/mptcp_net-next/issues/139
> Signed-off-by: Geliang Tang <geliangtang(a)gmail.com>

Thank you for this patch, the Closes tag and the reviews! I added this =

patch in the "mptcp: create subflow for newly added address" series. I =

had a conflict with one patch from Florian I recently applied, should be OK.

- 581ac7207e9c: mptcp: send ack for every add_addr
- 2ee1a4d633eb: conflict in t/mptcp-pm-add-lockdep-assertions
- Results: 1f3c95152e38..61cbfacafedc

Tests + export are in progress!

Cheers,
Matt
-- =

Tessares | Belgium | Hybrid Access Solutions
www.tessares.net
--===============5916612041269098499==--
