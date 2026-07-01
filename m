Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B60EE3B0AE7
	for <mptcp@lists.linux.dev>; Wed,  1 Jul 2026 06:32:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782887576; cv=none; b=Yv3oj8uoqe75VQUhftPhK1sMwhx2cLJY0hVMottjMf+ht5c2SzilVrNTERP5wvuUQazjvjlCf/6q629/qCpN7Q14yj1Dpraiq5jMtc3q7y9y+7WYpG1YuYMa4xEcryCq++ZgzhdvtVYtqHLA8rY44PSWjueA80RKjn5nqN7d9K4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782887576; c=relaxed/simple;
	bh=oaW2F3N9adDVym8OesiiqT9rv1+rQNga2S7AfeeyHGE=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=tLAMStqlIajUEyHLfyscQoBtbJPYpdCJAhorzBhyC+eX9FE05cuQU+D/g1g4t2VCC+RATTa6opyeKBAaJypG0xpSJX50TG1dZ5KBfRhDhoMNb+PCA/rgXC4wYV+mZxeuSsLWUY8psbsAMDVxxFTwim9dwgBHORGYYPabhNvVAuk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AtS87FOO; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AtS87FOO"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 112C81F000E9;
	Wed,  1 Jul 2026 06:32:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782887574;
	bh=vctk6OkMOJu6GIE7B5FvSbITfRioJ1woFvVUIKt8heU=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=AtS87FOO7lWwHWFInaIsKXpYz7Aomvef1rtK01iBtAGKNdFnZ4minjWQ3rLOImzUG
	 dEdkzXsLVTkXLT6shsUuaQalMC2behpi6TgalrOMKapJCfoaRMzJY07z9T7NCBHk9W
	 t3JtE9AG/VJrB9hfmexUI73QCs92bQxA160ecVzVU2SnEQKwXmKo43JaxL88OXTxs0
	 huSSP5RvFRPQmKjfNo80NKNDheTiBOJgxa786DrHIyUJfiqzVAk199L09HFvf3TMil
	 GjUTLHB/Y9PmDFhFDUo7zvSY1x0UCqgi5LZSiz734CIN3gao7kLTMQ0FGk5Bp9B4Me
	 hBtNqh+yw7ifg==
Message-ID: <86e9b7f9ac5d630a0bb7b127652544176921a491.camel@kernel.org>
Subject: Re: [PATCH mptcp-net v2] mptcp: fix extra_subflows leak on failed
 passive join
From: Geliang Tang <geliang@kernel.org>
To: Chenguang Zhao <chenguang.zhao@linux.dev>, mptcp@lists.linux.dev
Cc: Chenguang Zhao <zhaochenguang@kylinos.cn>, Matthieu Baerts
	 <matttbe@kernel.org>
Date: Wed, 01 Jul 2026 14:32:43 +0800
In-Reply-To: <20260701032011.358940-1-chenguang.zhao@linux.dev>
References: <20260630095432.1340629-1-chenguang.zhao@linux.dev>
	 <20260701032011.358940-1-chenguang.zhao@linux.dev>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.56.2-9 
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Chenguang,

Thanks for this v2. However, if there are no code changes, there is no
need to send a v2; we can just reply to the email thread on v1 to
discuss it. 

On Wed, 2026-07-01 at 11:20 +0800, Chenguang Zhao wrote:
> From: Chenguang Zhao <zhaochenguang@kylinos.cn>
> 
> mptcp_pm_allow_new_subflow() increments extra_subflows
> before __mptcp_finish_join() on the passive MP_JOIN path.
> On synchronous join failure the subflow is dropped without
> calling mptcp_close_ssk(), so the counter is not rolled back.
> 
> Call mptcp_pm_close_subflow() when the join completion fails.
> 
> Fixes: 3e5014909b56 ("mptcp: cleanup MPJ subflow list handling")
> Signed-off-by: Chenguang Zhao <zhaochenguang@kylinos.cn>
> Reviewed-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
> ---
> v2:
>  Hi Matthieu,
>  Thanks for the review.
>  - I spotted this by reading the code. I don't have a reproducer
>    yet. I also see we already have a Packetdrill test for
>    synchronous connect failure (simult_connect.pkt), but not for
>    synchronous join failure. I'll add a similar Packetdrill test
>    for that case and send it in a follow-up patch.
>  - Add Fixes and Reviewd-by tag.
>  - I looked again at the history, and I think the Fixes tag
>    should point to 3e5014909b56 ("mptcp: cleanup MPJ subflow list
>    handling"), not 10f6d46c943d ("mptcp: fix race between MP_JOIN and
> close"). 

The Fixes tag is incorrect and should be 10f6d46c943d ("mptcp: fix race
between MP_JOIN and close"), because that commit introduced the call to
mptcp_pm_allow_new_subflow. There is no need to send a v3, as this can
be updated when applying.

I have changed the status of v2 to "Queued" and v1 to "Superseded".

Thanks,
-Geliang

> v1:
>  -
> https://lore.kernel.org/all/20260630095432.1340629-1-chenguang.zhao@linux.dev/
> 
>  net/mptcp/protocol.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
> index cb9515f505aa..b32f0cd262a7 100644
> --- a/net/mptcp/protocol.c
> +++ b/net/mptcp/protocol.c
> @@ -3907,6 +3907,7 @@ bool mptcp_finish_join(struct sock *ssk)
>  	mptcp_data_unlock(parent);
>  
>  	if (!ret) {
> +		mptcp_pm_close_subflow(msk);
>  err_prohibited:
>  		subflow->reset_reason = MPTCP_RST_EPROHIBIT;
>  		return false;
