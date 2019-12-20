Content-Type: multipart/mixed; boundary="===============1920349091924418910=="
MIME-Version: 1.0
From: Eric Dumazet <eric.dumazet at gmail.com>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: [PATCH net-next v5 10/11] tcp: clean ext on tx recycle
Date: Fri, 20 Dec 2019 07:29:05 -0800
Message-ID: <5b17ec8a-3ee2-7167-8702-4f14a9b6e016@gmail.com>
In-Reply-To: 20191219223434.19722-11-mathew.j.martineau@linux.intel.com
X-Status: 
X-Keywords:                  
X-UID: 3217

--===============1920349091924418910==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable



On 12/19/19 2:34 PM, Mat Martineau wrote:
> From: Paolo Abeni <pabeni(a)redhat.com>
> =

> Otherwise we will find stray/unexpected/old extensions value on next
> iteration.
> =

> On tcp_write_xmit() we can end-up splitting an already queued skb in two
> parts, via tso_fragment(). The newly created skb can be allocated via
> the tx cache and an upper layer will not be aware of it, so that upper
> layer cannot set the ext properly.
> =

> Resetting the ext on recycle ensures that stale data is not propagated
> in to packet headers or elsewhere.
> =

> An alternative would be add an additional hook in tso_fragment() or in
> sk_stream_alloc_skb() to init the ext for upper layers that need it.
> =

> Co-developed-by: Florian Westphal <fw(a)strlen.de>
> Signed-off-by: Florian Westphal <fw(a)strlen.de>
> Signed-off-by: Paolo Abeni <pabeni(a)redhat.com>
> Signed-off-by: Mat Martineau <mathew.j.martineau(a)linux.intel.com>
> ---

Reviewed-by: Eric Dumazet <edumazet(a)google.com>

--===============1920349091924418910==--
