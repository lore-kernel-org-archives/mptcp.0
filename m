Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 614A7192D6C
	for <mptcp@lists.linux.dev>; Mon, 23 Dec 2024 09:49:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734947353; cv=none; b=fmY41GjGDDGd8KMb2ZJH+9ZTvMK5jjrmudzgV2SugPsAH/XdGRdQTDxIsssHr2uhrsTin1F9nfp9nDR8WJxEHIpaMmitX51OhD7dI8r0+IkYC3EqQSO6pCPk5/5bqi5BtZefVEqqct1jXmgSMkiM4ZMukeLnwxuTl3M9BiFaCOM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734947353; c=relaxed/simple;
	bh=ILoBGbWdjkiAvwVl8EVvqaF2c+2IjBCsIzeUWpLnPJo=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=k2ncK/qMK1ZufszyWJPzvd2Ko2s1tW/9wlyJV7XwGRSOkSWZBUA+oQ7VITBx07exfVfb30QYyfsqxT1Xlv5Q7EaRJB+Gi9Q40otUQlb95OmRnIOCqvhiO9YMhXgbIZwH3tJYXkgO+puiH7ZSBWPUpodceNyiEZwtr6oWLGXiUZU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eG2tuZkS; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eG2tuZkS"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8CECCC4CED3;
	Mon, 23 Dec 2024 09:49:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734947352;
	bh=ILoBGbWdjkiAvwVl8EVvqaF2c+2IjBCsIzeUWpLnPJo=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
	b=eG2tuZkS8AA2YSlTthIoIL7mNpd0kzTpbsFD6LOHzUSbUl6J/3+yJ7pz/ZYMB/1Eo
	 R+AIMjTfkEfCVM6LUocjG79W8u+ec60kzsAI99eBKrWGf6q3IvL7o6XvvvFV9xqlMw
	 wTUMmOvHaxF4nGUoOtubWMCVtt7aB0eE/IF799T7mfpkZ10LrSWtH1ecMrV7+tFtiK
	 Bl4nHvADY9KQdi+T6hfjKJO5xBbrUuB0hYdDtQIF2nj/1jJduOZtC1OucjcZFpQj42
	 opjq8tmmrG8i5I66wjTITY9szsFPJ2T5OfwlmblCer1pHpCI0sPrwDp/nSyNB/rupG
	 rAz1qEaILueRA==
Message-ID: <2e5968e1c5b213b633c1c844269d1c55c2a43ffb.camel@kernel.org>
Subject: Re: [PATCH mptcp-next 2/8] Squash to "selftests/bpf: Add bpf_first
 scheduler & test"
From: Geliang Tang <geliang@kernel.org>
To: Mat Martineau <martineau@kernel.org>
Cc: mptcp@lists.linux.dev, baohua@kernel.org, Geliang Tang
	 <tanggeliang@kylinos.cn>
Date: Mon, 23 Dec 2024 17:49:09 +0800
In-Reply-To: <b5ca9ddf-77a9-dd73-e485-71ec6f354054@kernel.org>
References: <cover.1732153672.git.tanggeliang@kylinos.cn>
	 <e57ac76105430bab4bbc5ac4f62c77e883dd7f29.1732153672.git.tanggeliang@kylinos.cn>
	 <b5ca9ddf-77a9-dd73-e485-71ec6f354054@kernel.org>
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

On Fri, 2024-12-20 at 17:28 -0800, Mat Martineau wrote:
> On Thu, 21 Nov 2024, Geliang Tang wrote:
> 
> > From: Geliang Tang <tanggeliang@kylinos.cn>
> > 
> > Split get_subflow() interface into two: get_send() and
> > get_retrans().
> > 
> > Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
> > ---
> > .../selftests/bpf/progs/mptcp_bpf_first.c     | 24 +++++++++++++++-
> > ---
> > 1 file changed, 19 insertions(+), 5 deletions(-)
> > 
> > diff --git a/tools/testing/selftests/bpf/progs/mptcp_bpf_first.c
> > b/tools/testing/selftests/bpf/progs/mptcp_bpf_first.c
> > index d57399b407a7..36bf9adffb2c 100644
> > --- a/tools/testing/selftests/bpf/progs/mptcp_bpf_first.c
> > +++ b/tools/testing/selftests/bpf/progs/mptcp_bpf_first.c
> > @@ -16,18 +16,32 @@ void BPF_PROG(mptcp_sched_first_release, struct
> > mptcp_sock *msk)
> > {
> > }
> > 
> > -SEC("struct_ops")
> > -int BPF_PROG(bpf_first_get_subflow, struct mptcp_sock *msk,
> > -	     struct mptcp_sched_data *data)
> > +static int bpf_first_get_subflow(struct mptcp_sock *msk,
> > +				 struct mptcp_sched_data *data)
> > {
> > 	mptcp_subflow_set_scheduled(bpf_mptcp_subflow_ctx_by_pos(d
> > ata, 0), true);
> > 	return 0;
> > }
> > 
> > -SEC(".struct_ops")
> > +SEC("struct_ops")
> > +int BPF_PROG(bpf_first_get_send, struct mptcp_sock *msk,
> > +	     struct mptcp_sched_data *data)
> > +{
> > +	return bpf_first_get_subflow(msk, data);
> > +}
> > +
> > +SEC("struct_ops")
> > +int BPF_PROG(bpf_first_get_retrans, struct mptcp_sock *msk,
> > +	     struct mptcp_sched_data *data)
> > +{
> > +	return bpf_first_get_subflow(msk, data);
> > +}
> 
> Hi Geliang -
> 
> If my suggestion in patch 1 (use get_send for retransmit scheduling
> if 
> get_retrans is NULL) doesn't seem like clear enough behavior for BPF

The suggestion in patch 1 works well, I updated it in v2.

>  
> scheduler authors, this code and the following patches could be
> simplified 
> by removing the duplicate _retrans function above...
> 
> > +
> > +SEC(".struct_ops.link")
> > struct mptcp_sched_ops first = {
> > 	.init		= (void *)mptcp_sched_first_init,
> > 	.release	= (void *)mptcp_sched_first_release,
> > -	.get_subflow	= (void *)bpf_first_get_subflow,
> > +	.get_send	= (void *)bpf_first_get_send,
> > +	.get_retrans	= (void *)bpf_first_get_retrans,
> 
> ... and setting get_retrans like this:
>  	.get_retrans	= (void *)bpf_first_get_send,

If we do this, libbpf will report the following error:

# libbpf: struct_ops init_kern first func ptr get_retrans: invalid
reuse of prog bpf_first_get_send in sec struct_ops with type 27:
expected_attach_type 0 != kern_member_idx 1
# libbpf: failed to load object 'mptcp_bpf_first'
# libbpf: failed to load BPF skeleton 'mptcp_bpf_first': -EINVAL
# test_first:FAIL:open_and_load: first unexpected error: -22

So in v2, I didn't set this get_retrans ptr, but let it be NULL.

Thanks,
-Geliang

> 
> Then there would be example code for BPF scheduler programmers to see
> that 
> it's ok to use the same function pointer in both fields.
> 
> - Mat
> 
> > 	.name		= "bpf_first",
> > };
> > -- 
> > 2.43.0
> > 
> > 
> > 

