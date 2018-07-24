Content-Type: multipart/mixed; boundary="===============6949778071254234954=="
MIME-Version: 1.0
From: Mat Martineau <mathew.j.martineau at linux.intel.com>
To: mptcp at lists.01.org
Subject: Re: [MPTCP] [PATCH] mptcp:fullmesh: fix compilation warning if no IPv6
Date: Tue, 24 Jul 2018 11:37:55 -0700
Message-ID: <alpine.OSX.2.21.1807241137140.14681@asadovni-mobl3.amr.corp.intel.com>
In-Reply-To: 20180718153750.3822-1-cpaasch@apple.com
X-Status: 
X-Keywords:                  
X-UID: 683

--===============6949778071254234954==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable


On Wed, 18 Jul 2018, Christoph Paasch wrote:

> From: Matthieu Baerts <matthieu.baerts(a)tessares.net>
>
> if_idx would be seen as an unitialized variable even if it should never
> happen in case of !CONFIG_IPV6. But let makes the compiler happy!
>
> Fixes: 9e763119cccc6 (mptcp: Check interface index in fullmesh pm)
> Signed-off-by: Matthieu Baerts <matthieu.baerts(a)tessares.net>
> Signed-off-by: Christoph Paasch <cpaasch(a)apple.com>
> (cherry picked from commit e2b2f250f15fe9c4442483c1263af83cf8d8a0d5)
> Signed-off-by: Christoph Paasch <cpaasch(a)apple.com>

Thanks Christoph and Matthieu. Patch applied.

--
Mat Martineau
Intel OTC

--===============6949778071254234954==--
