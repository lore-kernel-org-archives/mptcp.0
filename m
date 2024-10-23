Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE24C155393
	for <mptcp@lists.linux.dev>; Wed, 23 Oct 2024 08:57:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729673877; cv=none; b=faLSFe7b/EE5UTLQoG6Ws47zQYJ1RlBKxFE10Ai5pbWAvLV2laQYi0WqzSwW93HyUX78bupjyxo8sgO56qqFCf5e4TsskJuH5RJmPMUy7lnrXg7NfjWPhMW7ydE9xIdpU1b17/KpBtxP8utw8tT3QdycGGzleEgqUXuLkeSJ6AE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729673877; c=relaxed/simple;
	bh=OaaElDYLNusfMKY+Oywpaj7QKwJ8Zd8yjROK+jYSvn8=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=GHXumuJdbtpwQxwwJCd5BG+WgB2tolTXPUcgmV1uc1R9kZb7uMN32VHlDN8VJ0Hl6/yhMxeTuKbGA5ah16w8ESRmhkunJWM8OFQFfkNOCsqRT/VD77dzNkbxpAQa+Yialax1sFO3PHIW1bX7Zoq/RoadLBU9BxQ+3tkXnlY1nBI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZHtnhDUL; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZHtnhDUL"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B8C4DC4CEC6;
	Wed, 23 Oct 2024 08:57:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729673877;
	bh=OaaElDYLNusfMKY+Oywpaj7QKwJ8Zd8yjROK+jYSvn8=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
	b=ZHtnhDULQd+RMo5Z1Skc0WNdahBWRaX0YljVGAPloAv5/JQ1RspdvHVQOb2PDCR0E
	 N7yAET0reRaCv6+/6+PWtBoLn1tSa30Jdn6DZxjdBrfE3ByRwcmzgfutd/Gp9+kHjE
	 Rvv8AD2MDOX79O6F4qiwqOew1IHo1Zfk4kIGrsVZYOqRALGBs5/su+IuLnY0PC1/NA
	 RD8IKNdwplp1TiYYq+K9fXwCmsUnRVjErzD1PzRbxkHh9jFt1VCqQns5zDErkuKzbT
	 b0TctIrL6Yx+HCNAm9VPbuDuqg6DD9BsnOIH8gMBs+wVcv35xHsKagh7IXdc0XXkSg
	 Pub/YJA8CFNKQ==
Message-ID: <155fd0bca02ef0619bbd5dd0f1efa4dfdf8a903b.camel@kernel.org>
Subject: Re: [PATCH mptcp-next v7 4/5] Squash to "selftests/bpf: Add
 bpf_burst scheduler & test"
From: Geliang Tang <geliang@kernel.org>
To: Mat Martineau <martineau@kernel.org>
Cc: mptcp@lists.linux.dev, Geliang Tang <tanggeliang@kylinos.cn>
Date: Wed, 23 Oct 2024 16:57:48 +0800
In-Reply-To: <2bc8e804-3fca-086b-5050-b178eda1066a@kernel.org>
References: <cover.1729583414.git.tanggeliang@kylinos.cn>
	 <a9d3b8bc14bd6e93cee030a80db39f3229e1216e.1729583414.git.tanggeliang@kylinos.cn>
	 <2bc8e804-3fca-086b-5050-b178eda1066a@kernel.org>
Autocrypt: addr=geliang@kernel.org; prefer-encrypt=mutual;
 keydata=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
 Px+2P2cKc7LXXedb/qQ3M
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.54.0-1 
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Tue, 2024-10-22 at 17:03 -0700, Mat Martineau wrote:
> On Tue, 22 Oct 2024, Geliang Tang wrote:
> 
> > From: Geliang Tang <tanggeliang@kylinos.cn>
> > 
> > Use the newly added bpf_for_each() helper to walk the conn_list.
> > 
> > Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
> > ---
> > .../selftests/bpf/progs/mptcp_bpf_burst.c     | 79 ++++++++++------
> > ---
> > 1 file changed, 40 insertions(+), 39 deletions(-)
> > 
> > diff --git a/tools/testing/selftests/bpf/progs/mptcp_bpf_burst.c
> > b/tools/testing/selftests/bpf/progs/mptcp_bpf_burst.c
> > index eb21119aa8f7..e7df5f048aa4 100644
> > --- a/tools/testing/selftests/bpf/progs/mptcp_bpf_burst.c
> > +++ b/tools/testing/selftests/bpf/progs/mptcp_bpf_burst.c
> > @@ -11,6 +11,10 @@ char _license[] SEC("license") = "GPL";
> > 
> > #define min(a, b) ((a) < (b) ? (a) : (b))
> > 
> > +#define SSK_MODE_ACTIVE	0
> > +#define SSK_MODE_BACKUP	1
> > +#define SSK_MODE_MAX	2
> > +
> 
> Hi Geliang -
> 
> > struct bpf_subflow_send_info {
> > 	__u8 subflow_id;
> 
> If you store a subflow pointer here instead of an index, there's no
> need 
> to add the mptcp_lookup_subflow_id() helper function, an extra 
> iteration over conn_list is eliminated, and the code is more like 
> mptcp_subflow_get_send().

I thought so too. Two changes were needed to achieve this.

1. Move sk_stream_memory_free check inside bpf_for_each() loop.
2. Implement mptcp_subflow_set_scheduled helper in BPF.

> 
> - Mat
> 
> > 	__u64 linger_time;
> > @@ -23,10 +27,6 @@ extern bool tcp_stream_memory_free(const struct
> > sock *sk, int wake) __ksym;
> > extern bool bpf_mptcp_subflow_queues_empty(struct sock *sk) __ksym;
> > extern void mptcp_pm_subflow_chk_stale(const struct mptcp_sock
> > *msk, struct sock *ssk) __ksym;
> > 
> > -#define SSK_MODE_ACTIVE	0
> > -#define SSK_MODE_BACKUP	1
> > -#define SSK_MODE_MAX	2
> > -
> > static __always_inline __u64 div_u64(__u64 dividend, __u32 divisor)
> > {
> > 	return dividend / divisor;
> > @@ -57,6 +57,19 @@ static __always_inline bool
> > sk_stream_memory_free(const struct sock *sk)
> > 	return __sk_stream_memory_free(sk, 0);
> > }
> > 
> > +static struct mptcp_subflow_context *
> > +mptcp_lookup_subflow_by_id(struct mptcp_sock *msk, unsigned int
> > id)
> > +{
> > +	struct mptcp_subflow_context *subflow;
> > +
> > +	bpf_for_each(mptcp_subflow, subflow, msk) {
> > +		if (subflow->subflow_id == id)
> > +			return subflow;
> > +	}
> > +
> > +	return NULL;
> > +}
> > +
> > SEC("struct_ops")
> > void BPF_PROG(mptcp_sched_burst_init, struct mptcp_sock *msk)
> > {
> > @@ -67,8 +80,7 @@ void BPF_PROG(mptcp_sched_burst_release, struct
> > mptcp_sock *msk)
> > {
> > }
> > 
> > -static int bpf_burst_get_send(struct mptcp_sock *msk,
> > -			      struct mptcp_sched_data *data)
> > +static int bpf_burst_get_send(struct mptcp_sock *msk)
> > {
> > 	struct bpf_subflow_send_info send_info[SSK_MODE_MAX];
> > 	struct mptcp_subflow_context *subflow;
> > @@ -84,16 +96,10 @@ static int bpf_burst_get_send(struct mptcp_sock
> > *msk,
> > 		send_info[i].linger_time = -1;
> > 	}
> > 
> > -	for (i = 0; i < data->subflows && i < MPTCP_SUBFLOWS_MAX;
> > i++) {
> > -		bool backup;
> > +	bpf_for_each(mptcp_subflow, subflow, msk) {
> > +		bool backup = subflow->backup || subflow-
> > >request_bkup;
> > 
> > -		subflow = bpf_mptcp_subflow_ctx_by_pos(data, i);
> > -		if (!subflow)
> > -			break;
> > -
> > -		backup = subflow->backup || subflow->request_bkup;
> > -
> > -		ssk = mptcp_subflow_tcp_sock(subflow);
> > +		ssk = bpf_mptcp_subflow_tcp_sock(subflow);
> > 		if (!mptcp_subflow_active(subflow))
> > 			continue;
> > 
> > @@ -109,7 +115,7 @@ static int bpf_burst_get_send(struct mptcp_sock
> > *msk,
> > 
> > 		linger_time = div_u64((__u64)ssk->sk_wmem_queued
> > << 32, pace);
> > 		if (linger_time < send_info[backup].linger_time) {
> > -			send_info[backup].subflow_id = i;
> > +			send_info[backup].subflow_id = subflow-
> > >subflow_id;
> > 			send_info[backup].linger_time =
> > linger_time;
> > 		}
> > 	}
> > @@ -119,10 +125,10 @@ static int bpf_burst_get_send(struct
> > mptcp_sock *msk,
> > 	if (!nr_active)
> > 		send_info[SSK_MODE_ACTIVE].subflow_id =
> > send_info[SSK_MODE_BACKUP].subflow_id;
> > 
> > -	subflow = bpf_mptcp_subflow_ctx_by_pos(data,
> > send_info[SSK_MODE_ACTIVE].subflow_id);
> > +	subflow = mptcp_lookup_subflow_by_id(msk,
> > send_info[SSK_MODE_ACTIVE].subflow_id);

BPF does not allow access to subflow in this way:

	subflow = send_info[SSK_MODE_ACTIVE].subflow;

So I have to use bpf_core_cast() here as:

	subflow = bpf_core_cast(send_info[SSK_MODE_ACTIVE].subflow,
				struct mptcp_subflow_context);

> > 	if (!subflow)
> > 		return -1;
> > -	ssk = mptcp_subflow_tcp_sock(subflow);
> > +	ssk = bpf_mptcp_subflow_tcp_sock(subflow);

Here BPF doesn't allow passing a cast pointer (subflow) to a kfunc
(bpf_mptcp_subflow_tcp_sock). Fortunately we can use
mptcp_subflow_tcp_sock instead, which is a BPF helper, not a kfunc:

	 ssk = mptcp_subflow_tcp_sock(subflow);

> > 	if (!ssk || !sk_stream_memory_free(ssk))

Again, BPF does not allow passing a cast pointer to a kfunc,
sk_stream_memory_free(ssk) fails.

It's not possible to implement a sk_stream_memory_free function in BPF,
it's too complicated. So the approach I took in v8 was to move this
sk_stream_memory_free check forward to the position of
mptcp_subflow_active in bpf_for_each() loop. I think this doesn't
change the logic of the burst scheduler, but I'd like to hear your
opinion.

After this, mptcp_subflow_set_scheduled(subflow, true) is not allowed
too. So I have to implement a mptcp_subflow_set_scheduled helper in
BPF. It's easy since WRITE_ONCE() is defined in progs/map_kptr.c.

> > 		return -1;
> > 
> > @@ -141,23 +147,18 @@ static int bpf_burst_get_send(struct
> > mptcp_sock *msk,
> > 	return 0;
> > }
> > 
> > -static int bpf_burst_get_retrans(struct mptcp_sock *msk,
> > -				 struct mptcp_sched_data *data)
> > +static int bpf_burst_get_retrans(struct mptcp_sock *msk)
> > {
> > -	int backup = MPTCP_SUBFLOWS_MAX, pick =
> > MPTCP_SUBFLOWS_MAX, subflow_id;
> > +	struct sock *backup = NULL, *pick = NULL;
> > 	struct mptcp_subflow_context *subflow;
> > 	int min_stale_count = INT_MAX;
> > -	struct sock *ssk;
> > 
> > -	for (int i = 0; i < data->subflows && i <
> > MPTCP_SUBFLOWS_MAX; i++) {
> > -		subflow = bpf_mptcp_subflow_ctx_by_pos(data, i);
> > -		if (!subflow)
> > -			break;
> > +	bpf_for_each(mptcp_subflow, subflow, msk) {
> > +		struct sock *ssk =
> > bpf_mptcp_subflow_tcp_sock(subflow);
> > 
> > 		if (!mptcp_subflow_active(subflow))
> > 			continue;
> > 
> > -		ssk = mptcp_subflow_tcp_sock(subflow);
> > 		/* still data outstanding at TCP level? skip this
> > */
> > 		if (!tcp_rtx_and_write_queues_empty(ssk)) {
> > 			mptcp_pm_subflow_chk_stale(msk, ssk);
> > @@ -166,23 +167,23 @@ static int bpf_burst_get_retrans(struct
> > mptcp_sock *msk,
> > 		}
> > 
> > 		if (subflow->backup || subflow->request_bkup) {
> > -			if (backup == MPTCP_SUBFLOWS_MAX)
> > -				backup = i;
> > +			if (!backup)
> > +				backup = ssk;
> > 			continue;
> > 		}
> > 
> > -		if (pick == MPTCP_SUBFLOWS_MAX)
> > -			pick = i;
> > +		if (!pick)
> > +			pick = ssk;
> > 	}
> > 
> > -	if (pick < MPTCP_SUBFLOWS_MAX) {
> > -		subflow_id = pick;
> > +	if (pick)
> > 		goto out;
> > -	}
> > -	subflow_id = min_stale_count > 1 ? backup :
> > MPTCP_SUBFLOWS_MAX;
> > +	pick = min_stale_count > 1 ? backup : NULL;
> > 
> > out:
> > -	subflow = bpf_mptcp_subflow_ctx_by_pos(data, subflow_id);
> > +	if (!pick)
> > +		return -1;
> > +	subflow = bpf_mptcp_subflow_ctx(pick);
> > 	if (!subflow)
> > 		return -1;
> > 	mptcp_subflow_set_scheduled(subflow, true);
> > @@ -194,11 +195,11 @@ int BPF_PROG(bpf_burst_get_subflow, struct
> > mptcp_sock *msk,
> > 	     struct mptcp_sched_data *data)
> > {
> > 	if (data->reinject)
> > -		return bpf_burst_get_retrans(msk, data);
> > -	return bpf_burst_get_send(msk, data);
> > +		return bpf_burst_get_retrans(msk);
> > +	return bpf_burst_get_send(msk);
> > }
> > 
> > -SEC(".struct_ops")
> > +SEC(".struct_ops.link")
> > struct mptcp_sched_ops burst = {
> > 	.init		= (void *)mptcp_sched_burst_init,
> > 	.release	= (void *)mptcp_sched_burst_release,
> > -- 
> > 2.45.2
> > 
> > 
> > 

