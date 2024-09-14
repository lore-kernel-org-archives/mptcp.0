Received: from out-177.mta1.migadu.com (out-177.mta1.migadu.com [95.215.58.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08A60440C
	for <mptcp@lists.linux.dev>; Sat, 14 Sep 2024 00:41:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726274504; cv=none; b=UXvlJDR6K7azbijTit/vGxlG172lAEF33cWpTHsU5qOkuHXmDhDMdoGIelU7hHtq9x9FlB6NRK3mdIts6KAzUEr7XkdhJmRxN5yfRElv+gDYbtZydD8C/WfYrX0RxW5H9AE01fcdnpK4IXtbu8X+J6/6DZS7e+jIYwcCN5mjTpg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726274504; c=relaxed/simple;
	bh=Vu82Ph2sIXj20bterymiQTcZHkCHQpXcKnBniB79saE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=cS4o/vxo6rW1Ln81qn/09Rgaiz55XXUsZTq8gpf8/5WUD7bFFo5Ml3JZORDR7DHwvFWf8yGeeIlyM6rET3ODicDz9uBxd/kxqa4ILnlkakLOBFGFxQP+QtOsQQt7Dwp6scrvGDhQpOmMbUIlKgr2fdaKLfizEcNDw8GfO42hnYE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=UHpu96fv; arc=none smtp.client-ip=95.215.58.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="UHpu96fv"
Message-ID: <849457c0-5a34-4d5d-9c4f-ba004809269b@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1726274499;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=njze7aemUanrhZMt51vAeuzqXry4lCEDqyyBFJtyc5M=;
	b=UHpu96fvLwm7krDPJxrZOvWqh+QNULQJgDdaqes+FbGU5LkT1F2Gk30fL0oLH6ptT15TcS
	YXGFCTUCu3d7gw8Z4YKH5HMxAHhMM3E0N6e1Ls38vFX1rmLuZsvX5Rtdr1JaF02CQ90X68
	DetOE69NF1J75BEkikML+2MjWA9Ippk=
Date: Fri, 13 Sep 2024 17:41:32 -0700
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Subject: Re: [PATCH mptcp-next v5 1/5] bpf: Add mptcp_subflow bpf_iter
To: Geliang Tang <geliang@kernel.org>
Cc: Andrii Nakryiko <andrii.nakryiko@gmail.com>, mptcp@lists.linux.dev,
 Geliang Tang <tanggeliang@kylinos.cn>, bpf@vger.kernel.org,
 Martin KaFai Lau <martin.lau@kernel.org>
References: <cover.1726132802.git.tanggeliang@kylinos.cn>
 <5e5b91efc6e06a90fb4d2440ddcbe9b55ee464be.1726132802.git.tanggeliang@kylinos.cn>
 <CAEf4BzaVzVhoqhzpq-FD5GGJT1wW5=LbZ4ADs2+NdLO5rcJMMw@mail.gmail.com>
 <a9bd9aa00c702f98d86f5d7acd305cc477a4c91b.camel@kernel.org>
 <CAEf4Bza4qtP5EVOk08XmGOjWgy1-671gciK5j5vg5Lr=5ggm0Q@mail.gmail.com>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Martin KaFai Lau <martin.lau@linux.dev>
In-Reply-To: <CAEf4Bza4qtP5EVOk08XmGOjWgy1-671gciK5j5vg5Lr=5ggm0Q@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 9/13/24 1:57 PM, Andrii Nakryiko wrote:
>>>> +__bpf_kfunc int bpf_iter_mptcp_subflow_new(struct
>>>> bpf_iter_mptcp_subflow *it,
>>>> +                                          struct mptcp_sock *msk)
>>>> +{
>>>> +       struct bpf_iter_mptcp_subflow_kern *kit = (void *)it;
>>>> +
>>>> +       kit->msk = msk;
>>>> +       if (!msk)
>>>> +               return -EINVAL;
>>>> +
>>>> +       kit->pos = &msk->conn_list;
>>>> +       return 0;
>>>> +}

[ ... ]

>>>>   BTF_KFUNCS_START(bpf_mptcp_sched_kfunc_ids)
>>>> +BTF_ID_FLAGS(func, bpf_iter_mptcp_subflow_new)
>>>
>>> I'm not 100% sure, but I suspect you might need to specify
>>> KF_TRUSTED_ARGS here to ensure that `struct mptcp_sock *msk` is a

+1

>>>> @@ -241,6 +286,8 @@ static int __init bpf_mptcp_kfunc_init(void)
>>>>          int ret;
>>>>
>>>>          ret = register_btf_fmodret_id_set(&bpf_mptcp_fmodret_set);
>>>> +       ret = ret ?:
>>>> register_btf_kfunc_id_set(BPF_PROG_TYPE_TRACING,
>>>> +
>>>> &bpf_mptcp_sched_kfunc_set);

This cannot be used in tracing.

Going back to my earlier question in v1. How is the msk->conn_list protected?


