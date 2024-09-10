Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BD9E18595E
	for <mptcp@lists.linux.dev>; Tue, 10 Sep 2024 09:33:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725960795; cv=none; b=JKO9j7Q2VWbXoEJ7h0NlySqcDGyocKb1nFZppGLZ8MW9/n4ACy6P/yqyRXx76Tuzx7P81nxb+v1JtkM4noNEGek3h7LqCdauVeOPnW/raUxoMC+SJg5OJQANHuMI66o/S4vZZ+2VyAuMuKea/tXRfjnLWkxB5wF8Kt7+7SjX7qY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725960795; c=relaxed/simple;
	bh=RrPGYVBX9SOaLbHygcV2SI5JiAl1RMWaoydtqhTvrYI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=XaVVuVnJGUS/UfWgvFDDjFJ8iWWcIn9Q3h5Gi6GVKLTDEJ48CNXZS8zRA3E1O+GTBIg+v5t4vVIV6AOTXNzs61nSCsTcJrDn1V6gcWjEEnpE6bnRsdjq1cu5r+lA0w6PdT00PbkLKrb4tHRvL1QCV89b5vuJqoknUV7pQyd101k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bzloNQgY; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bzloNQgY"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3F6A2C4CEC3;
	Tue, 10 Sep 2024 09:33:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725960795;
	bh=RrPGYVBX9SOaLbHygcV2SI5JiAl1RMWaoydtqhTvrYI=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=bzloNQgY/odLsY13NpfiQ68yDfuUfjUE5trAxuObxs0Cq3Sg4/XfHMsnYp4xpKrcc
	 1wtV1T02gF8GG6LUcJRmC3MAIEpVRMl2wL4yOvIeFpx5SfcugVjCNXBTaCptCion88
	 jjFoyyB+TDecOCIapwUwlj9NNSYJBuv4UM4hMOeshvs6I1TVHLTOFoy/0depeCR1DW
	 3yYnKlL/AStoU/fYWvkOzK2LN4us6Q/pztwG9Y5Evep9ubuLSozwcCyqX35/mU90mH
	 bJKnhXRJa8d4aebqta5VvRGeca5pF6667Lh1DQagQVa7oInHOQztD88+y8UmLOiJpx
	 x5WxwwLsGb67Q==
Message-ID: <7040e6bd-2257-48dc-99a1-3dacbdb1993f@kernel.org>
Date: Tue, 10 Sep 2024 11:33:12 +0200
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird Beta
Subject: Re: [PATCH mptcp-next 1/2] Squash to "bpf: Add mptcp_subflow
 bpf_iter"
Content-Language: en-GB
To: Geliang Tang <geliang@kernel.org>, mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
References: <cover.1725958296.git.tanggeliang@kylinos.cn>
 <cb7ca604cdc487d1f9a2f03a3a14904b003227fd.1725958296.git.tanggeliang@kylinos.cn>
 <a1822c37-3c2d-4865-848c-e6d92fa439aa@kernel.org>
 <72458d8097fa7ee4f8b783c51ec70376fc1234e2.camel@kernel.org>
From: Matthieu Baerts <matttbe@kernel.org>
Autocrypt: addr=matttbe@kernel.org; keydata=
 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
 lzVbFe7fduHbABmYz9cefQpO7wDE/Q==
Organization: NGI0 Core
In-Reply-To: <72458d8097fa7ee4f8b783c51ec70376fc1234e2.camel@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Geliang,

On 10/09/2024 11:27, Geliang Tang wrote:
> Hi Matt,
> 
> On Tue, 2024-09-10 at 11:12 +0200, Matthieu Baerts wrote:
>> Hi Geliang,
>>
>> On 10/09/2024 10:53, Geliang Tang wrote:
>>> From: Geliang Tang <tanggeliang@kylinos.cn>
>>>
>>> Register mptcp_subflow bpf_iter helpers in common_btf_ids in
>>> kernel/bpf/helpers.c, then they can be used on a larger scale,
>>> not only in types BPF_PROG_TYPE_TRACING and
>>> BPF_PROG_TYPE_STRUCT_OPS.
>>
>> Why could they not be used in these types? I find it good to have
>> them
>> defined in net/mptcp, from a maintenance point of view.
>>
>> Also, the different bpf_iter_xxx helpers defined there look generic.
>> While here, it is specific to MPTCP, I'm not even sure that would be
>> OK
>> to add them there. Is it not OK to define them only in
>> net/mptcp/bpf.c?
> 
> Yes, a new test for #484 (BPF: setsockopt on an MPTCP socket: check
> support) will use these helpers in "cgroup/setsockopt", that is the
> BPF_PROG_TYPE_CGROUP_SOCKOPT type.
> 
> register_btf_kfunc_id_set(BPF_PROG_TYPE_CGROUP_SOCKOPT,
> 		&bpf_mptcp_sched_kfunc_set);
> 
> will fail, since BPF_PROG_TYPE_CGROUP_SOCKOPT is not allow to register
> more kfuncs (see bpf_prog_type_to_kfunc_hook() in kernel/bpf/btf.c).
> 
> So I have to move them into common_btf_ids in kernel/bpf/helpers.c to
> allow them can be used in almost every BPF program type.

OK, but then I guess these helpers can be upstreamed before the packet
schedulers, right?

Cheers,
Matt
-- 
Sponsored by the NGI0 Core fund.

