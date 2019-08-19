Content-Type: multipart/mixed; boundary="===============3831146472990342814=="
MIME-Version: 1.0
From: Florian Westphal <fw at strlen.de>
To: mptcp at lists.01.org
Subject: Re: [MPTCP] [PRE-RFC 4/6] mptcp: queue data for mptcp level
 retransmission
Date: Mon, 19 Aug 2019 13:12:28 +0200
Message-ID: <20190819111228.GE2588@breakpoint.cc>
In-Reply-To: 666fcde927e49fe2e51ebf38e8b6b7d2c3da13d2.1565970525.git.pabeni@redhat.com
X-Status: 
X-Keywords:                  
X-UID: 1654

--===============3831146472990342814==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Paolo Abeni <pabeni(a)redhat.com> wrote:
> keep the send page fragment on an MPTCP level retransmission queue.
> the queue entries are allocated inside the page frag allocator,
> acquiring an additional reference to the page for each list entry.
> =

> Also switch to a custom page frag refill function, to ensure that
> the current page fragment can always host an MPTCP rtx queue entry.
> =

> The MPTCP rtx queue is flushed at socket destroy() time.

> +/* ensure we get enough memory for the frag hdr, beyond some minimal amo=
unt of
> + * data
> + */
> +bool mptcp_page_frag_refill(struct sock *sk, struct page_frag *pfrag)
> +{
> +	if (likely(skb_page_frag_refill(32U + sizeof(struct mptcp_data_frag),
> +					pfrag, sk->sk_allocation)))

Where is that 32U coming from?

> +static inline struct mptcp_data_frag *
> +mptcp_carve_data_frag(const struct mptcp_sock *msk, struct page_frag *pf=
rag,
> +		      int offset)
> +{
> +	struct mptcp_data_frag *dfrag;
> +
> +	offset =3D ALIGN(offset, BITS_PER_LONG / 8);

sizeof(long)?

The concept of keeping page frags for rexmit looks good to me, thanks Paolo
for working on this.

--===============3831146472990342814==--
