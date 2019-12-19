Content-Type: multipart/mixed; boundary="===============8380300162942895750=="
MIME-Version: 1.0
From: Florian Westphal <fw at strlen.de>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: [PATCH v1] Squash-to: "tcp: Prevent coalesce/collapse
 when skb has MPTCP extensions"
Date: Thu, 19 Dec 2019 12:43:10 +0100
Message-ID: <20191219114310.GC795@breakpoint.cc>
In-Reply-To: 8d1032ab5f4006cf6554eac229596d6d4d95896f.1576752025.git.pabeni@redhat.com
X-Status: 
X-Keywords:                  
X-UID: 3177

--===============8380300162942895750==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Paolo Abeni <pabeni(a)redhat.com> wrote:
> -static inline bool mptcp_skb_ext_exist(const struct sk_buff *skb)
> +/* move the skb extension owership, with the assumption that 'to' is
> + * newly allocated and 'from' carries only MPTCP ext
> + */
> +static inline void mptcp_skb_ext_move(struct sk_buff *to,
> +				      struct sk_buff *from)
> +{
> +	if (WARN_ON_ONCE(to->active_extensions))
> +		skb_ext_put(to);
> +	WARN_ON_ONCE(from->active_extensions & ~(1 << SKB_EXT_MPTCP));

This warn is triggered for skb that came in via a bridge.
I do not think you need the 2nd WARN.

> +	to->active_extensions =3D from->active_extensions;
> +	to->extensions =3D from->extensions;
> +	from->extensions =3D NULL;

This NULL assignment isn't needed -- if it is, something else is broken.

Rest looks good -- I agree that sk_is_mptcp() check could
be used as you pointed out in your reply to Christoph.

Thanks for working on this.
--===============8380300162942895750==--
