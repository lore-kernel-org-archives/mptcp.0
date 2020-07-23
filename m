Content-Type: multipart/mixed; boundary="===============8257315296189523015=="
MIME-Version: 1.0
From: Matthieu Baerts <matthieu.baerts at tessares.net>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: [PATCH 08/26] net: switch sock_set_timeout to sockptr_t
Date: Thu, 23 Jul 2020 10:39:50 +0200
Message-ID: <092368db-122f-60bc-6a32-3cd5c70727da@tessares.net>
In-Reply-To: 20200723060908.50081-9-hch@lst.de
X-Status: 
X-Keywords:                  
X-UID: 5228

--===============8257315296189523015==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Christoph,

On 23/07/2020 08:08, Christoph Hellwig wrote:
> Pass a sockptr_t to prepare for set_fs-less handling of the kernel
> pointer from bpf-cgroup.
> =

> Signed-off-by: Christoph Hellwig <hch(a)lst.de>
> ---
>   net/mptcp/protocol.c |  6 ++++--

Thank you for looking at that!

For MPTCP-related code:

Acked-by: Matthieu Baerts <matthieu.baerts(a)tessares.net>

Cheers,
Matt
-- =

Tessares | Belgium | Hybrid Access Solutions
www.tessares.net
--===============8257315296189523015==--
