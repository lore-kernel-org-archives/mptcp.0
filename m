Content-Type: multipart/mixed; boundary="===============1391584856472567551=="
MIME-Version: 1.0
From: Matthieu Baerts <matthieu.baerts at tessares.net>
To: mptcp at lists.01.org
Subject: Re: [MPTCP] [PATCH] tcp: clean ext on tx recycle
Date: Wed, 15 May 2019 15:14:34 +0200
Message-ID: <96a9b626-ffd4-3afc-214f-bd16fdcc632c@tessares.net>
In-Reply-To: 3eba3c63b8dcecb873c7a6b4695a1283c63be164.1557915674.git.pabeni@redhat.com
X-Status: 
X-Keywords:                  
X-UID: 1177

--===============1391584856472567551==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Paolo,

Thank you for the patch!

On 15/05/2019 12:22, Paolo Abeni wrote:
> Otherwise we will find stray/unexpected/old extensions
> value on next iteration.
> =

> On tcp_write_xmit() we can end-up splitting an already queued
> skb in two parts, via tso_fragment(). The newly created skb
> can be allocated via the tx cache and the mptcp stack will not
> be aware of it, so nobody set properly the MPTCP ext.
> =

> End result, we transmit the skb using an hold MPTCP DSS map
> and that confuses the rx side/corrupt the stream. It requires
> some concurrent conditions, so it's not deterministic.
> =

> Resetting the ext on recycle fixes all the current mptcp self tests
> issues.
> =

> Apparently only MPTCP has issues with this kind of stray ext,
> so an alternative would be add an additional mptcp hook in
> tso_fragment() or in sk_stream_alloc_skb() to always init
> the ext.
> =

> Note that setting/allocating the MPTCP ext in sk_stream_alloc_skb
> for MPTCP socket, we also resolve the fixme in mptcp_sendmsg_frag().

Are you talking about the case where skb_ext_add() returns NULL?

> Signed-off-by: Paolo Abeni <pabeni(a)redhat.com>
> --
> Note: intentionally not adding fixes tags here. Even if small,
> I think it should not be squashed in other commits, other opinion
> welcome!

It makes sense to have it separated, thank you!

Cheers,
Matt
-- =

Matthieu Baerts | R&D Engineer
matthieu.baerts(a)tessares.net
Tessares SA | Hybrid Access Solutions
www.tessares.net
1 Avenue Jean Monnet, 1348 Louvain-la-Neuve, Belgium

--===============1391584856472567551==--
