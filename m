Content-Type: multipart/mixed; boundary="===============6691872843635607499=="
MIME-Version: 1.0
From: Matthieu Baerts <matthieu.baerts at tessares.net>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: [PATCH 05/22] net: remove compat_sock_common_{get,
 set}sockopt
Date: Fri, 17 Jul 2020 11:18:08 +0200
Message-ID: <203f5f41-1de0-575e-864b-53a9412d97f6@tessares.net>
In-Reply-To: 20200717062331.691152-6-hch@lst.de
X-Status: 
X-Keywords:                  
X-UID: 5073

--===============6691872843635607499==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Christoph,

On 17/07/2020 08:23, Christoph Hellwig wrote:
> Add the compat handling to sock_common_{get,set}sockopt instead,
> keyed of in_compat_syscall().  This allow to remove the now unused
> ->compat_{get,set}sockopt methods from struct proto_ops.
> =

> Signed-off-by: Christoph Hellwig <hch(a)lst.de>
> ---
>   include/linux/net.h      |  6 ------
>   include/net/sock.h       |  4 ----
>   net/core/sock.c          | 30 ++++++------------------------
>   net/mptcp/protocol.c     |  6 ------

Thank you for looking at that!

For MPTCP-related code:

Acked-by: Matthieu Baerts <matthieu.baerts(a)tessares.net>

Cheers,
Matt
-- =

Tessares | Belgium | Hybrid Access Solutions
www.tessares.net
--===============6691872843635607499==--
