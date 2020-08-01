Content-Type: multipart/mixed; boundary="===============8556699898947696035=="
MIME-Version: 1.0
From: Florian Westphal <fw at strlen.de>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: [RFC PATCH 07/12] mptcp: cleanup
 mptcp_subflow_discard_data()
Date: Sun, 02 Aug 2020 01:18:46 +0200
Message-ID: <20200801231846.GF29169@breakpoint.cc>
In-Reply-To: 915cf19849b12e6bd8deabbb406be51eff92c764.1596216310.git.pabeni@redhat.com
X-Status: 
X-Keywords:                  
X-UID: 5425

--===============8556699898947696035==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Paolo Abeni <pabeni(a)redhat.com> wrote:

Hmmm, a changelog would have been nice 8-)

> -	/* discard mapped data */
> -	pr_debug("discarding %zu bytes, current map len=3D%d", delta,
> -		 map_remaining);
> -	if (delta) {
> -		read_descriptor_t desc =3D {
> -			.count =3D delta,
> -		};
> -		int ret;
> -
> -		ret =3D tcp_read_sock(ssk, &desc, subflow_read_actor);

tcp_read_sock tosses 'delta' bytes, and may zap multiple skbs, but after
this change only at most one skb gets tossed.

>  	return 0;
>  }

Nit: After this change, mptcp_subflow_discard_data() always returns 0.

> @@ -853,7 +824,7 @@ static bool subflow_check_data_avail(struct sock *ssk)
>  		/* only accept in-sequence mapping. Old values are spurious
>  		 * retransmission
>  		 */
> -		if (mptcp_subflow_discard_data(ssk, old_ack - ack_seq))
> +		if (mptcp_subflow_discard_data(ssk, skb, old_ack - ack_seq))
>  			goto fatal;

... so this conditional can be removed.

>  		return false;

Wouldn't it make sense to get rid of the return false too so that this
checks if there is another skb to process?  This would also obsolete my
'may zap multiple skbs' comment above since the caller would invoke the
discard helper again if next skb is also outdated.
--===============8556699898947696035==--
