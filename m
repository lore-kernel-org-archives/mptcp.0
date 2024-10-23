Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E2EA15E5D4
	for <mptcp@lists.linux.dev>; Wed, 23 Oct 2024 08:32:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729672339; cv=none; b=F+8kGD6i9P40BK/apEZ7AhdSCUEB8ZoN8uHxEVrd/4E7xzBvdv50z4dOqHuUgyUPOhhqYEiRxshFcTL0zclBHndS0zgCBgxAEGKNOYj3GJLejhuiEGvU1lt8fUyluuBZ1zbrxm091yAfEt0nFS09wL3SsXsRgwbsD6FzMunPQlU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729672339; c=relaxed/simple;
	bh=EtXHd5v6/glWwCdZQDUvjFtw913n4uxZfScZUo9DdTg=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=EhucluGq/vLgcp6EotcNoVq2UIPlMqkRjqb2fiUvUo3RaYh9yHRYa83wEfhl6s4b0NtnLLBd5PqXqchRvSMBm5rWGoRWpmdY4s066vg9XQj8D4ab527KLOCsC5NHSRGNgZC9lM+8r9yZ1EjBLRWkyJQ50Nu4x4hYApUO/78bnhc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gqt7jgl4; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gqt7jgl4"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BF318C4CEE7;
	Wed, 23 Oct 2024 08:32:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729672338;
	bh=EtXHd5v6/glWwCdZQDUvjFtw913n4uxZfScZUo9DdTg=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
	b=gqt7jgl4Vnwggi/tWcO6a3WJW7nzfO05Tw/QUebBIbYj3X0bvtGm5XyQuc1/TnaEq
	 7L9uLOaiSS+wXhAKNYPtpQC34zpLCKdCoxq5QmSsC9/F6a2lEPqEcxyb3azwtOqApF
	 JAweKHi6ovOhOtLclWsDfqxgGpsqsCOXGWhc2SFkI6Mkpvoxn6hz5LK/05vOMivwz1
	 yYBqRwZrrLpM2wD6+JWToe6+cjOz8oHHIf+97GX+I8+uq3GfwMLRmpyPFEeDYs95E+
	 17NM2FpDSbPBx6NCjzhrqSQDRhBbZLPQtwlunGugLjeZHNShNZOtH/PJdHq1tuL+rT
	 FDa4s5S+oJTpg==
Message-ID: <a62bb904f005dcfc98662ad23cc92b09005e983c.camel@kernel.org>
Subject: Re: [PATCH mptcp-next v7 2/5] Squash to "selftests/bpf: Add bpf_rr
 scheduler & test"
From: Geliang Tang <geliang@kernel.org>
To: Mat Martineau <martineau@kernel.org>
Cc: mptcp@lists.linux.dev, Geliang Tang <tanggeliang@kylinos.cn>
Date: Wed, 23 Oct 2024 16:32:14 +0800
In-Reply-To: <1dfa37e3-f26d-d55c-2ee1-9cd877e1042b@kernel.org>
References: <cover.1729583414.git.tanggeliang@kylinos.cn>
	 <cc23cd700d88642bf4396739181286262e208d8b.1729583414.git.tanggeliang@kylinos.cn>
	 <1dfa37e3-f26d-d55c-2ee1-9cd877e1042b@kernel.org>
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

Hi Mat,

Thanks for your review.

On Tue, 2024-10-22 at 16:52 -0700, Mat Martineau wrote:
> On Tue, 22 Oct 2024, Geliang Tang wrote:
> 
> > From: Geliang Tang <tanggeliang@kylinos.cn>
> > 
> > Use the newly added bpf_for_each() helper to walk the conn_list.
> > 
> > Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
> > ---
> > .../selftests/bpf/progs/mptcp_bpf_rr.c        | 26 ++++++++--------
> > ---
> > 1 file changed, 11 insertions(+), 15 deletions(-)
> > 
> > diff --git a/tools/testing/selftests/bpf/progs/mptcp_bpf_rr.c
> > b/tools/testing/selftests/bpf/progs/mptcp_bpf_rr.c
> > index 638ea6aa63b7..e02b8cfb262b 100644
> > --- a/tools/testing/selftests/bpf/progs/mptcp_bpf_rr.c
> > +++ b/tools/testing/selftests/bpf/progs/mptcp_bpf_rr.c
> > @@ -34,10 +34,9 @@ SEC("struct_ops")
> > int BPF_PROG(bpf_rr_get_subflow, struct mptcp_sock *msk,
> > 	     struct mptcp_sched_data *data)
> > {
> > -	struct mptcp_subflow_context *subflow;
> > +	struct mptcp_subflow_context *subflow, *next;
> > 	struct mptcp_rr_storage *ptr;
> > 	struct sock *last_snd = NULL;
> > -	int nr = 0;
> > 
> > 	ptr = bpf_sk_storage_get(&mptcp_rr_map, msk, 0,
> > 				 BPF_LOCAL_STORAGE_GET_F_CREATE);
> 
> Hi Geliang -
> 
> Thanks for the series. The bpf_iter code simplifies these scheduler 
> patches significantly!
> 
> > @@ -45,31 +44,28 @@ int BPF_PROG(bpf_rr_get_subflow, struct
> > mptcp_sock *msk,
> > 		return -1;
> > 
> > 	last_snd = ptr->last_snd;
> > +	next = bpf_mptcp_subflow_ctx(msk->first);
> > 
> > -	for (int i = 0; i < data->subflows && i <
> > MPTCP_SUBFLOWS_MAX; i++) {
> > -		subflow = bpf_mptcp_subflow_ctx_by_pos(data, i);
> > -		if (!last_snd || !subflow)
> > +	bpf_for_each(mptcp_subflow, subflow, msk) {
> > +		if (!last_snd)
> 
> last_snd is never changed inside the loop, it's more efficient to
> check it 
> before bpf_for_each().

This is indeed better, updated in v8.

> 
> - Mat
> 
> > 			break;
> > 
> > -		if (mptcp_subflow_tcp_sock(subflow) == last_snd) {
> > -			if (i + 1 == MPTCP_SUBFLOWS_MAX ||
> > -			    !bpf_mptcp_subflow_ctx_by_pos(data, i
> > + 1))
> > +		if (bpf_mptcp_subflow_tcp_sock(subflow) ==
> > last_snd) {
> > +			subflow =
> > bpf_iter_mptcp_subflow_next(&___it);
> > +			if (!subflow)
> > 				break;
> > 
> > -			nr = i + 1;
> > +			next = subflow;
> > 			break;
> > 		}
> > 	}
> > 
> > -	subflow = bpf_mptcp_subflow_ctx_by_pos(data, nr);
> > -	if (!subflow)
> > -		return -1;
> > -	mptcp_subflow_set_scheduled(subflow, true);
> > -	ptr->last_snd = mptcp_subflow_tcp_sock(subflow);
> > +	mptcp_subflow_set_scheduled(next, true);
> > +	ptr->last_snd = bpf_mptcp_subflow_tcp_sock(next);
> > 	return 0;
> > }
> > 
> > -SEC(".struct_ops")
> > +SEC(".struct_ops.link")
> > struct mptcp_sched_ops rr = {
> > 	.init		= (void *)mptcp_sched_rr_init,
> > 	.release	= (void *)mptcp_sched_rr_release,
> > -- 
> > 2.45.2
> > 
> > 
> > 

