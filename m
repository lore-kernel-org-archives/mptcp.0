Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46BA21C8FAF
	for <mptcp@lists.linux.dev>; Fri,  6 Sep 2024 09:45:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725615933; cv=none; b=fQPUVRZ1uAX2w9elXoosvxQpMUJGp/r+reHGD3KaPcRa8GT/0XLmLr+k/G+iPGe385nNw8rVpj7cJDCo6CSsrAOtOyr3OaZY2sXGtXn+JhzP6TPCP1BbcqU+SKfnU3jWrVVlolCNZhSbb4nbDKrrd/3BN1DotFKcbI8olocx4O0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725615933; c=relaxed/simple;
	bh=LernRSShNGa1mGc7qRZaNzj+Q6K/W+vBl6auj/fdMM8=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=eoZwv9DPzmlnfKBKBqtILSk4ABqvYV8LVxJOnpg47dSGZLxiqoH0GOfLiEK2dLA3xrgm2/FNE9bQQXY4a5YW8OLAO/gDnD6xHRfZBa+ydxWhmusMBW7u9a+ElnhwHNx9grhXUiatvLruQHvmTtvAdeA+0GFVcm0MonZ6EZ/DPoQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nJZJsNV7; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nJZJsNV7"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BF4EDC4CEC4;
	Fri,  6 Sep 2024 09:45:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725615932;
	bh=LernRSShNGa1mGc7qRZaNzj+Q6K/W+vBl6auj/fdMM8=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
	b=nJZJsNV7QTdSVinjVvM1g4G5m8Pk3jBcq23jzm1xwmU8gB4ogNYV+wgfk96/f9GXS
	 DMnXqKYHFT6asJFw1GpRc/W/QhQcIGMHK7QPY8RI4od0CowpqOv++A7nL5A2YhPTXx
	 LciT6GKTPYwmacQpeNVlHbQvIRQ+dtLurazXYPuOOaJOKXU5Vuts7Ek7DA0soxtLnC
	 LYleEnplrg8A6KsXMLpbsXn3UVUkYOaeL3BaoIOVLj2XuM8lE5BeBHirKc+PcXCXvy
	 3ASbcv2hB795TT3gzqk7Gb6zG7XC5VuOqUcXrdrKKlW+M01HaIjnxXv0f+BSJurBC0
	 oJcTGvfaWoxbw==
Message-ID: <61dcb4af29b8922b442429607767332640cdf223.camel@kernel.org>
Subject: Re: [PATCH mptcp-next] Squash to "selftests/bpf: Add getsockopt to
 inspect mptcp subflow"
From: Geliang Tang <geliang@kernel.org>
To: Matthieu Baerts <matttbe@kernel.org>, mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Date: Fri, 06 Sep 2024 17:45:27 +0800
In-Reply-To: <e6a444a2-c177-4723-be93-861e2cf7b69a@kernel.org>
References: 
	<11a224e1bade27689271af77cd47c6a49852a2cf.1725543947.git.tanggeliang@kylinos.cn>
	 <e6a444a2-c177-4723-be93-861e2cf7b69a@kernel.org>
Autocrypt: addr=geliang@kernel.org; prefer-encrypt=mutual;
 keydata=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
 Px+2P2cKc7LXXedb/qQ3M
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.52.3-0ubuntu1 
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Matt,

On Thu, 2024-09-05 at 16:03 +0200, Matthieu Baerts wrote:
> Hi Geliang,
> 
> On 05/09/2024 15:46, Geliang Tang wrote:
> > From: Geliang Tang <tanggeliang@kylinos.cn>
> > 
> > Update error messages:
> > 
> >  run_subflow:FAIL:mark unexpected mark: actual 3 != expected 0
> >  run_subflow:FAIL:cc unexpected cc: actual 'reno' != expected
> > 'cubic'
> 
> That's a good idea to improve the error message in case of error, but
> I
> think this technique or changing the optval is dangerous:
> 
> (...)
> 
> > diff --git a/tools/testing/selftests/bpf/progs/mptcp_subflow.c
> > b/tools/testing/selftests/bpf/progs/mptcp_subflow.c
> > index 70302477e326..a5e42bfddbbf 100644
> > --- a/tools/testing/selftests/bpf/progs/mptcp_subflow.c
> > +++ b/tools/testing/selftests/bpf/progs/mptcp_subflow.c
> > @@ -63,6 +63,7 @@ int mptcp_subflow(struct bpf_sock_ops *skops)
> >  static int _check_getsockopt_subflow_mark(struct mptcp_sock *msk,
> > struct bpf_sockopt *ctx)
> >  {
> >  	struct mptcp_subflow_context *subflow;
> > +	int *optval = ctx->optval;
> >  	int i = 0;
> >  
> >  	mptcp_for_each_subflow(msk, subflow) {
> > @@ -72,7 +73,10 @@ static int _check_getsockopt_subflow_mark(struct
> > mptcp_sock *msk, struct bpf_soc
> >  							   struct
> > mptcp_subflow_context));
> >  
> >  		if (ssk->sk_mark != ++i) {
> > -			ctx->retval = -2;
> > +			if (ctx->optval + sizeof(int) <= ctx-
> > >optval_end) {
> > +				*optval = ssk->sk_mark;
> 
> I guess a likely error to have is that the mark (or the cc) has not
> been
> changed on the subflow, and it then has its default value. In this
> case
> here with the mark, you will not change optval: it will be 0 before,
> and
> you will set it to 0. That means your test will not fail here (retval
> =
> 0) or in the verifications done by the userspace (mark = 0).
> 
> I think it is safer not to change 'optval' here in the verification
> step. If you want to pass info to the userspace, can you not write a
> string somewhere? e.g. skel->bss->error_msg, or using a storage map?

Let's drop this patch then.

Please send v5 of "new MPTCP subflow subtest" set to bpf-next for me.

Thanks,
-Geliang

> 
> Cheers,
> Matt

