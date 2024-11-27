Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D05A1BC3F
	for <mptcp@lists.linux.dev>; Wed, 27 Nov 2024 02:20:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732674024; cv=none; b=dy6/hs/GH59Z21x68gEyUObV/1voWdtiymagQnuqCUI1/ThnSCahuhztdOmSLd2ZNS5aomp1N7SmsGILZprYAIY5ngzpjnPNZpOF2Dy9y28oxDfoO/y1b09VqUIYbxz4bECfhIPL9Dl/IhgE+8X280HyTAPzcFxPbS0aB7wP1UY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732674024; c=relaxed/simple;
	bh=o7EdXpWJ8QEc9luDXoQ3B4Yt2D+3ZzlaxEag8gbvWCo=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=iA3Ouzz6N3JUkaZVN8J7QAiiAMZzv2sbUIuk5FWKf16+KC5bVMAPdsAHoJ07pa7rEj7tyXji/cBwDNjk/WUZt8g0DQl/HllBT7Za9Tu1kR/WgcPB6ZB/FqpTqYCn09OYRWODXqK6YvX45Oc6UPxQpt//gvPeA6L2gK33n7YNZTc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OnuF16kI; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OnuF16kI"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6EB29C4CECF;
	Wed, 27 Nov 2024 02:20:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732674022;
	bh=o7EdXpWJ8QEc9luDXoQ3B4Yt2D+3ZzlaxEag8gbvWCo=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
	b=OnuF16kI1xdk1zUSeofpkq7O0EvYr8/kQ0f8O9ApxX1RwHZ2y1mNhc0KoPJ/oGZk/
	 PxUGsMA6xW7GcJ5yLpb1CJqdXPBzeCsHZ+g+jTdvrs6ocwnGLkXjDxtTJofYKkklC+
	 K69JstBE12BboUWqZorG5XuXq/zdHIo5lVBrW/SavbQwVNqJsnuD3QUHw0MG1C9DQE
	 pZ4QEsqQrfdl+G+cwJhmrvjto92pWhpR/j9WC1BIg/ycdpdIv+6fJL5sEuJ9c4TuJZ
	 dc5CNieB0SmNteYcejUJi2cQZW5mtHiXJO2FJA5vBN0t6ENyxxFde/kapRJfT0Bb3a
	 KO151tiuToyuw==
Message-ID: <a8edc8b7d34db222a39879df4c23adfb532d5279.camel@kernel.org>
Subject: Re: [PATCH mptcp-next v2 2/3] Squash to "bpf: Add mptcp_subflow
 bpf_iter"
From: Geliang Tang <geliang@kernel.org>
To: Matthieu Baerts <matttbe@kernel.org>, mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Date: Wed, 27 Nov 2024 10:20:18 +0800
In-Reply-To: <b149e886-179e-4111-b0bc-0e944b1ed011@kernel.org>
References: <cover.1732181419.git.tanggeliang@kylinos.cn>
	 <c98deccb13e527c3fc120e9f6f6627db3b3cf6ab.1732181419.git.tanggeliang@kylinos.cn>
	 <b149e886-179e-4111-b0bc-0e944b1ed011@kernel.org>
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

Hi Matt,

On Fri, 2024-11-22 at 11:02 +0100, Matthieu Baerts wrote:
> Hi Geliang,
> 
> On 21/11/2024 10:36, Geliang Tang wrote:
> > From: Geliang Tang <tanggeliang@kylinos.cn>
> > 
> > Address Martin's comments in v1:
> > 
> > - bpf_iter_mptcp_subflow_new returns -EINVAL when msk socket lock
> > isn't
> >   held.
> > 
> > Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
> > ---
> >  net/mptcp/bpf.c | 5 ++++-
> >  1 file changed, 4 insertions(+), 1 deletion(-)
> > 
> > diff --git a/net/mptcp/bpf.c b/net/mptcp/bpf.c
> > index 02038db59956..89a7a482368d 100644
> > --- a/net/mptcp/bpf.c
> > +++ b/net/mptcp/bpf.c
> > @@ -252,7 +252,10 @@ bpf_iter_mptcp_subflow_new(struct
> > bpf_iter_mptcp_subflow *it,

Other bpf_iter have added "sizeof" and "alignof" checks, I think
mptcp_subflow bpf_iter also needs to add them too:

      BUILD_BUG_ON(sizeof(struct bpf_iter_mptcp_subflow_kern) !=
                   sizeof(struct bpf_iter_mptcp_subflow));
      BUILD_BUG_ON(__alignof__(struct bpf_iter_mptcp_subflow_kern) !=
                   __alignof__(struct bpf_iter_mptcp_subflow));

> >  	if (!msk)
> >  		return -EINVAL;
> >  
> > -	msk_owned_by_me(msk);
> > +#ifdef CONFIG_LOCKDEP
> > +	if (!lockdep_sock_is_held((const struct sock *)msk))
> > +		return -EINVAL;
> 
> This feels wrong: lockdep is a debugging tool, the goal is usually to
> WARN in case of issue, not to take a different path.
> 
> Maybe you want to use spin_is_locked(), but still, I'm not sure
> whether

spin_is_locked() doesn't work, since this msk socket lock isn't a
spinlock, right?

> that's the direction to take: it means the msk always needs to be
> locked
> when iterating over the different subflow → is it always the case?
> Maybe
> yes if it is used only to modify update it?
> 
> (If not, maybe you just need to check the sk_refcnt as a safety
> measure?
> But that's maybe not enough for all cases.)

I think the answer is no, sometimes locking is not necessary when
iterating over the different subflows. Does this mean we can simply
drop msk_owned_by_me() here?

> 
> Did you check what was being done for the BPF TCP CA? I guess they
> need
> a way to prevent calling some kfunc without the required locks or
> refcount, no?

Not found in BPF TCP CA.

Thanks,
-Geliang

> 
> Cheers,
> Matt

