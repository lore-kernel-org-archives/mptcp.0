Content-Type: multipart/mixed; boundary="===============5474317990963903560=="
MIME-Version: 1.0
From: Matthieu Baerts <matthieu.baerts at tessares.net>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: [PATCH 25/26] net: pass a sockptr_t into ->setsockopt
Date: Thu, 23 Jul 2020 10:39:57 +0200
Message-ID: <1056b902-fd25-1c13-758d-cd4341dd403b@tessares.net>
In-Reply-To: 20200723060908.50081-26-hch@lst.de
X-Status: 
X-Keywords:                  
X-UID: 5229

--===============5474317990963903560==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Christoph,

On 23/07/2020 08:09, Christoph Hellwig wrote:
> Rework the remaining setsockopt code to pass a sockptr_t instead of a
> plain user pointer.  This removes the last remaining set_fs(KERNEL_DS)
> outside of architecture specific code.
> =

> Signed-off-by: Christoph Hellwig <hch(a)lst.de>
> Acked-by: Stefan Schmidt <stefan(a)datenfreihafen.org> [ieee802154]
> ---
>   net/mptcp/protocol.c                      | 12 +++----

Thank you for the v2!

For MPTCP-related code:

Acked-by: Matthieu Baerts <matthieu.baerts(a)tessares.net>

Cheers,
Matt
-- =

Tessares | Belgium | Hybrid Access Solutions
www.tessares.net
--===============5474317990963903560==--
