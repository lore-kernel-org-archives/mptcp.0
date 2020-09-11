Content-Type: multipart/mixed; boundary="===============3492281409450913975=="
MIME-Version: 1.0
From: Matthieu Baerts <matthieu.baerts at tessares.net>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: [PATCH net-next 1/2] Squash-to: "mptcp: allow picking
 different xmit subflows"
Date: Fri, 11 Sep 2020 12:36:13 +0200
Message-ID: <82a7c126-e2a6-bf73-b50a-261e65fb02cb@tessares.net>
In-Reply-To: 49dbfbe2c7bfbdaabe83b34e508d3d5c6905ef80.1599659504.git.pabeni@redhat.com
X-Status: 
X-Keywords:                  
X-UID: 5797

--===============3492281409450913975==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Paolo,

Thank you for the patch!

On 09/09/2020 15:52, Paolo Abeni wrote:
> This improves the current packet scheduler for scenarios
> where the msk sockets is using different links with different
> bandwith limits.
> =

> The commit comment should be changed into:
> =

> """
> Update the scheduler to less trivial heuristic: cache
> the last used subflow, and try to send on it a reasonably
> long burst of data.
> =

> When the burst or the subflow send space is exhausted, pick
> the subflow with the lower ratio between write space and
> send buffer - that is, the subflow with the greater relative
> amount of free space.
> """
> =

> Signed-off-by: Paolo Abeni <pabeni(a)redhat.com>

(...)

> +	/* pick the best backup if no other subflow is active */
> +	if (!nr_active)
> +		send_info[0].ssk =3D send_info[1].ssk;
>   =

> -	/* use the looked-up subflow if the previusly one has exauted the burst
> -	 * or is not writable
> -	 */
> -	if (next_ssk && (!free || msk->snd_burst <=3D 0)) {
> -		msk->last_snd =3D next_ssk;
> +	pr_debug("msk=3D%p nr_active=3D%d ssk=3D%p:%lld backup=3D%p:%lld",
> +		 msk, nr_active, send_info[0].ssk, send_info[0].ratio,
> +		 send_info[1].ssk, send_info[1].ratio);

We could maybe have this pr_debug before "if (!nr_active)" just above to =

avoid confusions but that's just a debug print. For me we can apply it =

like that. I can also move this pr_debug when applying if you want to.

The rest is (very) good to me!

Cheers,
Matt

> +	if (send_info[0].ssk) {
> +		msk->last_snd =3D send_info[0].ssk;
>   		msk->snd_burst =3D min_t(int, MPTCP_SEND_BURST_SIZE,
> -				       sk_stream_wspace(next_ssk));
> -		free =3D true;
> +				       sk_stream_wspace(msk->last_snd));
> +		return msk->last_snd;
>   	}
> -	return free ? msk->last_snd : NULL;
> +	return NULL;
>   }
>   =

>   static void ssk_check_wmem(struct mptcp_sock *msk)
> =


-- =

Tessares | Belgium | Hybrid Access Solutions
www.tessares.net
--===============3492281409450913975==--
