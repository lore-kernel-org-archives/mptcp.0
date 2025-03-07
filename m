Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A594619E971
	for <mptcp@lists.linux.dev>; Fri,  7 Mar 2025 08:48:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741337337; cv=none; b=pImV++Lm6FNeuMvdc0ZVLBtpGz3jAq74c6P6yMm1LRnbZFdvXHZt0m0nuGDLUleVCpvq1pL8kx58P4pow0CBTmYddCpPesfG5h/21VkVR0FpbpNjja0SNBqRSapx84MdxQyX+6sQThAUCWzifaW9TmIV2WYDgZO1tTcTPA51XW4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741337337; c=relaxed/simple;
	bh=zbU0w1lhJdWLXGbAsxtlkbWqktRVTiCfxmCsMaWTdiQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=iKEOpd7ntnmfakNmiRAHwucEnnJu14g1hWx2ke4uT16rzMLUMSzQSECOkcafJnmYh3v3lgRwPMO3j5MR/qtpI0mI/74V0AUcs4nnaz3Re5/yUKonIhdHCAizLkD+v2K/+V2ZVsy9YnCpYutiVXw73EADJ0MgdfBW76GzD2wG56M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VkiH7pFK; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VkiH7pFK"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 350CDC4CED1;
	Fri,  7 Mar 2025 08:48:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741337337;
	bh=zbU0w1lhJdWLXGbAsxtlkbWqktRVTiCfxmCsMaWTdiQ=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=VkiH7pFK/dFe1lakz13S9wqN6St46ADW35V6ctC4an/uHFJMhfD33IJEeeaFpMh5b
	 5XPspmfocr+o558jqCOwl2kVRJAC57TGOMI6/G8y+qxRrT2IYwCwugIb54xYCkzs7V
	 nWcLCIpMBd2gUZ54tjFnv7oMv5nMhM5eh0aifhBe0a272CmZOhDy5iI0b+ZjAKnh7E
	 Sse7c+7wa20J3EArTcsSHv6PoPsCp7TIG0LpTE3sfFTPPszHzsLPDTUZwc022gUDTq
	 K2x2zHGDGtYu+EM5I0rwC7WABltJTNT64nNP+gze1Hd7VJ3bwZLXu7/KDfFAvcVl2J
	 HhyLiGfdCqm6g==
Message-ID: <706a3051-8328-4321-8eea-71d4120ea996@kernel.org>
Date: Fri, 7 Mar 2025 09:48:53 +0100
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird Beta
Subject: Re: [PATCH mptcp-next v15 0/8] use bpf_iter in bpf schedulers
Content-Language: en-GB
To: Geliang Tang <geliang@kernel.org>, mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
References: <cover.1739788598.git.tanggeliang@kylinos.cn>
 <ba7822fb-a0cb-4636-89fc-ad1355e4c234@kernel.org>
 <02622736c58386a5d074b5a64af5d76b7f35248d.camel@kernel.org>
From: Matthieu Baerts <matttbe@kernel.org>
Autocrypt: addr=matttbe@kernel.org; keydata=
 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
 lzVbFe7fduHbABmYz9cefQpO7wDE/Q==
Organization: NGI0 Core
In-Reply-To: <02622736c58386a5d074b5a64af5d76b7f35248d.camel@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Geliang,

On 07/03/2025 04:08, Geliang Tang wrote:
> On Wed, 2025-03-05 at 17:14 +0100, Matthieu Baerts wrote:

(...)

>> While at it, I added two patches, as a follow-up of b68b106b0f15
>> ("mptcp: sched: reduce size for unused data") instead of patch 8/8:
>> - e74f811b4626: Revert: "mptcp: add sched_data helpers"
>> - Results: a37b7ba9c462..a44778c76bc6 (export)
>>
>> - fe2716bcac00: mptcp: sched: remove mptcp_sched_data
>> - Results: a44778c76bc6..516dcfe47eed (export)
> 
> I think we need to keep mptcp scheduler API unchanged. We can keep
> struct mptcp_sched_data and mptcp_sched_data_set_contexts helper for
> future use, as I said in patch 8.

While this code has not been upstreamed, I think it is important to
clean what is not being used. If we need to add an extra parameter, we
will still be able to do so.

> The bpf_iter_task [1] that I am adding recently can actually use them.
> 
> I've been thinking about this recently. It's not a good idea to add
> bpf_iter_task to struct mptcp_sock. It's better to add it to struct
> mptcp_sched_data instead since it's more related to mptcp scheduler.

Why is it not a good idea to add it to the msk? Will you not check it
from bpf_iter kfunc where you have access to the msk, but not the data?
Also, will you not need such check also for the BPF PM, so it will not
be only dedicated to the scheduler?

> 
> 1. Add bpf_iter_task in mptcp_sched_data.
> 
> struct mptcp_sched_data {
>         struct task_struct *bpf_iter_task;
> };
> 
> 2. Set bpf_iter_task as "current" in mptcp_sched_data_set_contexts:
> 
> void mptcp_sched_data_set_contexts(const struct mptcp_sock *msk,
>                                    struct mptcp_sched_data *data)
> {
>         WRITE_ONCE(data->bpf_iter_task, current);
> }
> 
> 3. Add a struct mptcp_sched_data parameter for
> bpf_iter_mptcp_subflow_new:
> 
> __bpf_kfunc static int
> bpf_iter_mptcp_subflow_new(struct bpf_iter_mptcp_subflow1 *it,
>                            struct sock *sk,
>                            struct mptcp_sched_data *data)

That means that this kfunc will only be used for the scheduler API, then
no longer for the [gs]etsockopt and BPF PM, no?

> 4. Check data->bpf_iter_task in bpf_iter_mptcp_subflow_new:
> 
>         msk = mptcp_sk(sk);
>         task = READ_ONCE(data->bpf_iter_task);
>         if (!task || task != current)
>                 return -EINVAL;
> 
>         WRITE_ONCE(data->bpf_iter_task, NULL);

I think it would make more sense to do that from sched.c, similar to a lock.

  WRITE_ONCE(data->bpf_iter_task, current);
  ret = msk->sched->get_send(msk, data);
  WRITE_ONCE(data->bpf_iter_task, NULL);

  return ret;

> 
>         msk_owned_by_me(msk);
> 
>         kit->msk = msk;
>         kit->pos = &msk->conn_list;
> 
> 5. Use bpf_for_each() with "data" parameter in bpf:
> 
> SEC("struct_ops")
> int BPF_PROG(bpf_red_get_send, struct mptcp_sock *msk,
>              struct mptcp_sched_data *data)
> {
>         struct mptcp_subflow_context *subflow;
> 
>         bpf_for_each(mptcp_subflow, subflow, (struct sock *)msk, data)
>                 mptcp_subflow_set_scheduled(subflow, true);
> 
>         return 0;
> }
> 
> WDYT?
> 
> Anyway, we can put the patch "mptcp: sched: remove mptcp_sched_data" on
> the export branch and wait for a while, don't send it upstream
> recently, and wait for me to send some squash-to patches to modify
> them.

Sure. There are some other patches to send first anyway.

Cheers,
Matt
-- 
Sponsored by the NGI0 Core fund.

