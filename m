Content-Type: multipart/mixed; boundary="===============3698871136618271374=="
MIME-Version: 1.0
From: Matthieu Baerts <matthieu.baerts at tessares.net>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: [PATCH mptcp-next v2] [DO-NOT-MERGE] mptcp: use kmalloc
 on kasan build
Date: Fri, 05 Jun 2020 20:02:20 +0200
Message-ID: <a92b901b-6f7d-22f1-0177-444e7c1712a3@tessares.net>
In-Reply-To: 20200605173242.2644099-1-dcaratti@redhat.com
X-Status: 
X-Keywords:                  
X-UID: 4599

--===============3698871136618271374==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Paolo, Davide,

On 05/06/2020 19:32, Davide Caratti wrote:
> From: Paolo Abeni <pabeni(a)redhat.com>
> =

> Helps detection UaF, which apparently kasan misses
> with kmem_cache allocator.
> =

> We also need to always set the SOCK_RCU_FREE flag, to
> preserved the current code leveraging SLAB_TYPESAFE_BY_RCU.
> This latter change will make unreachable some existing
> errors path, but I don't see other options.

Thank you for this new version.

I just added this patch I squashed in "[DO-NOT-MERGE] mptcp: use kmalloc =

on kasan build" commit:

- f83f82c06635: mptcp: support IPv6 with kmalloc

The "export" branch is going to be updated soon.

Cheers,
Matt
-- =

Matthieu Baerts | R&D Engineer
matthieu.baerts(a)tessares.net
Tessares SA | Hybrid Access Solutions
www.tessares.net
1 Avenue Jean Monnet, 1348 Louvain-la-Neuve, Belgium
--===============3698871136618271374==--
