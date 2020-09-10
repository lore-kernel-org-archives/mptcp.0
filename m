Content-Type: multipart/mixed; boundary="===============4345439433708156546=="
MIME-Version: 1.0
From: Mat Martineau <mathew.j.martineau at linux.intel.com>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: [PATCH net-next 1/2] Squash-to: "mptcp: allow picking
 different xmit subflows"
Date: Wed, 09 Sep 2020 17:40:04 -0700
Message-ID: <alpine.OSX.2.23.453.2009091737010.4909@atenciom-mobl1.amr.corp.intel.com>
In-Reply-To: 49dbfbe2c7bfbdaabe83b34e508d3d5c6905ef80.1599659504.git.pabeni@redhat.com
X-Status: 
X-Keywords:                  
X-UID: 5776

--===============4345439433708156546==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable


On Wed, 9 Sep 2020, Paolo Abeni wrote:

> This improves the current packet scheduler for scenarios
> where the msk sockets is using different links with different
> bandwith limits.
>
> The commit comment should be changed into:
>
> """
> Update the scheduler to less trivial heuristic: cache
> the last used subflow, and try to send on it a reasonably
> long burst of data.
>
> When the burst or the subflow send space is exhausted, pick
> the subflow with the lower ratio between write space and
> send buffer - that is, the subflow with the greater relative
> amount of free space.
> """
>
> Signed-off-by: Paolo Abeni <pabeni(a)redhat.com>
> ---
> v1 -> v2:
> - remove some unneeded magic number
> - fix potential division by 0 - Florian
>
> Note:
> - subflows are now selected when sk_stream_memory_free(ssk),
>  while before we used sk_stream_is_writeable(ssk). The current
>  choice is closer to plain TCP and IMHO more correct, but
>  even the old one should not be buggy.
>  Anyhow I saw reproducible write error (EAGAIN) when using
>  sk_stream_is_writeable() with this strategy, and I was unable
>  to track them down, so possibly there is some other bug there
>  I could not find.
> - simuilt xmit self-tests are still failing, even if we are now
>  closer to success. The failures are now caused by the high delay
>  configured on the virtual link.
>  This problem would be addressed by a larger initial send buffer,
>  but the current xmit path is unable to cope with that correctly:
>  with a larger send buffer it will send pkts outside the MPTCP
>  window.
>  To properly address the above we additionally need something alike
>  "mptcp: keep track of receivers advertised window" from Florian,
>  plus the ability to enqueue data at the MPTCP level and send it
>  when the MPTCP level window is open.

Is this what the tcp_cleanup_rbuf() patch helps with?

I do like this approach better for the default scheduler, but hopefully =

some of our community members who wrote graduate theses on this kind of =

thing can give a more informed opinion at the meeting tomorrow :)


Mat


> ---
> net/mptcp/protocol.c | 107 ++++++++++++++++++++-----------------------
> 1 file changed, 49 insertions(+), 58 deletions(-)
>
> diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
> index eb833ecbba9e..7469e89b3d7a 100644
> --- a/net/mptcp/protocol.c
> +++ b/net/mptcp/protocol.c
> @@ -1063,26 +1063,25 @@ static bool mptcp_subflow_active(struct mptcp_sub=
flow_context *subflow)
> 	return ((1 << ssk->sk_state) & (TCPF_ESTABLISHED | TCPF_CLOSE_WAIT));
> }
>
> -#define MPTCP_SEND_BURST_SIZE		(1 << 15)
> +#define MPTCP_SEND_BURST_SIZE		((1 << 16) - \
> +					 sizeof(struct tcphdr) - \
> +					 MAX_TCP_OPTION_SPACE - \
> +					 sizeof(struct ipv6hdr) - \
> +					 sizeof(struct frag_hdr))
>
> -static struct list_head *mptcp_next_subflow(struct mptcp_sock *msk,
> -					    struct list_head *pos,
> -					    bool wrap_around)
> -{
> -	if (list_is_last(pos, &msk->conn_list) && wrap_around)
> -		return msk->conn_list.next;
> -	return pos->next;
> -}
> +struct subflow_send_info {
> +	struct sock *ssk;
> +	uint64_t ratio;
> +};
>
> static struct sock *mptcp_subflow_get_send(struct mptcp_sock *msk,
> 					   u32 *sndbuf)
> {
> +	struct subflow_send_info send_info[2];
> 	struct mptcp_subflow_context *subflow;
> -	struct sock *next_backup =3D NULL;
> -	struct list_head *pos, *start;
> -	struct sock *next_ssk =3D NULL;
> -	bool wrap_around;
> -	bool free;
> +	int i, nr_active =3D 0;
> +	int64_t ratio, pace;
> +	struct sock *ssk;
>
> 	sock_owned_by_me((struct sock *)msk);
>
> @@ -1095,65 +1094,57 @@ static struct sock *mptcp_subflow_get_send(struct=
 mptcp_sock *msk,
> 		return msk->first;
> 	}
>
> -	/* lookup the first writeable subflow and first writable back subflow
> -	 * starting from last used, with wrap-around
> -	 */
> -	if (msk->last_snd) {
> -		start =3D &mptcp_subflow_ctx(msk->last_snd)->node;
> -		wrap_around =3D true;
> -	} else {
> -		start =3D &msk->conn_list;
> -		wrap_around =3D false;
> -	}
> -	pr_debug("msk=3D%p start=3D%p pos=3D%p wrap_around=3D%d last=3D%p", msk=
, start,
> -		 mptcp_next_subflow(msk, start, wrap_around), wrap_around,
> -		 msk->last_snd);
> -	for (pos =3D mptcp_next_subflow(msk, start, wrap_around); pos !=3D star=
t;
> -	     pos =3D mptcp_next_subflow(msk, pos, wrap_around)) {
> -		struct sock *ssk;
> +	/* re-use last subflow, if the burst allow that */
> +	if (msk->last_snd && msk->snd_burst > 0 &&
> +	    sk_stream_memory_free(msk->last_snd) &&
> +	    mptcp_subflow_active(mptcp_subflow_ctx(msk->last_snd))) {
> +		mptcp_for_each_subflow(msk, subflow) {
> +			ssk =3D  mptcp_subflow_tcp_sock(subflow);
> +			*sndbuf =3D max(tcp_sk(ssk)->snd_wnd, *sndbuf);
> +		}
> +		return msk->last_snd;
> +	}
>
> -		subflow =3D list_entry(pos, struct mptcp_subflow_context, node);
> +	/* pick the subflow with the lower wmem/wspace ratio */
> +	for (i =3D 0; i < 2; ++i) {
> +		send_info[i].ssk =3D NULL;
> +		send_info[i].ratio =3D -1;
> +	}
> +	mptcp_for_each_subflow(msk, subflow) {
> 		ssk =3D  mptcp_subflow_tcp_sock(subflow);
> 		if (!mptcp_subflow_active(subflow))
> 			continue;
>
> +		nr_active +=3D !subflow->backup;
> 		*sndbuf =3D max(tcp_sk(ssk)->snd_wnd, *sndbuf);
> -		if (next_backup || next_ssk)
> +		if (!sk_stream_memory_free(subflow->tcp_sock))
> 			continue;
>
> -		free =3D sk_stream_is_writeable(subflow->tcp_sock);
> -		if (!free)
> +		pace =3D READ_ONCE(ssk->sk_pacing_rate);
> +		if (!pace)
> 			continue;
>
> -		if (!subflow->backup && !next_ssk)
> -			next_ssk =3D ssk;
> -
> -		if (subflow->backup && !next_backup)
> -			next_backup =3D ssk;
> +		ratio =3D (int64_t)READ_ONCE(ssk->sk_wmem_queued) << 32 / pace;
> +		if (ratio < send_info[subflow->backup].ratio) {
> +			send_info[subflow->backup].ssk =3D ssk;
> +			send_info[subflow->backup].ratio =3D ratio;
> +		}
> 	}
> -	if (!next_ssk)
> -		next_ssk =3D next_backup;
>
> -	if (msk->last_snd) {
> -		*sndbuf =3D max(tcp_sk(msk->last_snd)->snd_wnd, *sndbuf);
> -		free =3D sk_stream_memory_free(msk->last_snd);
> -	} else {
> -		free =3D false;
> -	}
> -	pr_debug("msk=3D%p ssk=3D%p:%d last=3D%p last free=3D%d burst=3D%d", ms=
k,
> -		 next_ssk, next_ssk ? sk_stream_wspace(next_ssk) : 0,
> -		 msk->last_snd, free, msk->snd_burst);
> +	/* pick the best backup if no other subflow is active */
> +	if (!nr_active)
> +		send_info[0].ssk =3D send_info[1].ssk;
>
> -	/* use the looked-up subflow if the previusly one has exauted the burst
> -	 * or is not writable
> -	 */
> -	if (next_ssk && (!free || msk->snd_burst <=3D 0)) {
> -		msk->last_snd =3D next_ssk;
> +	pr_debug("msk=3D%p nr_active=3D%d ssk=3D%p:%lld backup=3D%p:%lld",
> +		 msk, nr_active, send_info[0].ssk, send_info[0].ratio,
> +		 send_info[1].ssk, send_info[1].ratio);
> +	if (send_info[0].ssk) {
> +		msk->last_snd =3D send_info[0].ssk;
> 		msk->snd_burst =3D min_t(int, MPTCP_SEND_BURST_SIZE,
> -				       sk_stream_wspace(next_ssk));
> -		free =3D true;
> +				       sk_stream_wspace(msk->last_snd));
> +		return msk->last_snd;
> 	}
> -	return free ? msk->last_snd : NULL;
> +	return NULL;
> }
>
> static void ssk_check_wmem(struct mptcp_sock *msk)
> -- =

> 2.26.2

--
Mat Martineau
Intel
--===============4345439433708156546==--
