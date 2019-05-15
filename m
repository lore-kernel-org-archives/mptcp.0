Content-Type: multipart/mixed; boundary="===============4258061685462118760=="
MIME-Version: 1.0
From: Florian Westphal <fw at strlen.de>
To: mptcp at lists.01.org
Subject: Re: [MPTCP] [PATCH] tcp: clean ext on tx recycle
Date: Wed, 15 May 2019 13:51:03 +0200
Message-ID: <20190515115103.xgk25munbmlnfido@breakpoint.cc>
In-Reply-To: 3eba3c63b8dcecb873c7a6b4695a1283c63be164.1557915674.git.pabeni@redhat.com
X-Status: 
X-Keywords:                  
X-UID: 1174

--===============4258061685462118760==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Paolo Abeni <pabeni(a)redhat.com> wrote:
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
>
> Apparently only MPTCP has issues with this kind of stray ext,
> so an alternative would be add an additional mptcp hook in
> tso_fragment() or in sk_stream_alloc_skb() to always init
> the ext.

Yes, MPTCP is the only extension user that can set an extension
before the skb makes it to tcp tx path.

So we need this fix as part of the MPTCP series, good catch!

--===============4258061685462118760==--
