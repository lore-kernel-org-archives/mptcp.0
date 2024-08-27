Received: from out-173.mta0.migadu.com (out-173.mta0.migadu.com [91.218.175.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E5954414
	for <mptcp@lists.linux.dev>; Tue, 27 Aug 2024 05:22:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724736166; cv=none; b=WEFyaxN8hv9ILQU8TTEv/GROsVvyElZTUl1OZQavHesPp5j75WMmmgeltCiL961hBkiE8/TOGmNA4UXsbZSK2qJcfryErB5V0pZaPQt0oipGMv0UojGbG3/0n6/g8yP2rWwX3c9qEQyfEJUr+fteWl6VXkU3S3uVGp283IjN/Ig=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724736166; c=relaxed/simple;
	bh=865p1tB1kZyRN7bydAmbt8fwb3qP+z0KAosciCpW7EY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=GgzZtM0GVXO5uwAuibRT1OpMSeMERD1mKNLusfj3MvazFCy/0+7CB4vz2MHWIauhUqB9JJq/+DmNKhNfBHwQm11Bbeagx53q+RWVSjFrR2bBGpb7tmdbs+4g6too3Hjt18mGP1GgeItlkiyv2ucgILAeEpK0Dy8wOcsIkdYBceQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=VNTXtM30; arc=none smtp.client-ip=91.218.175.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="VNTXtM30"
Message-ID: <54ce6f90-e86c-4921-b1e0-423fcd655d32@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1724736162;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=quh7O3Lz5jDJSUydWdqAttbbklUHh/h5CagJnR7HKh0=;
	b=VNTXtM30yTbAtX411fM83bPbumH+T0uj887p886clrCgx16kXqokXbs1Am4mCWV2jRyzI0
	7U8Xy+W/77ZEUi2Jv6jCg39oL1pV+IV/Tkor+83bUYvyDFRcmpTaK9lRrEJaroT3Um4EqM
	2cAO82UWXzRht96RpkM70emhkngmTNo=
Date: Mon, 26 Aug 2024 22:22:32 -0700
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Subject: Re: [PATCH mptcp-next 2/2] selftests/bpf: Add getsockopt to inspect
 mptcp subflow
To: Geliang Tang <geliang@kernel.org>, Matthieu Baerts <matttbe@kernel.org>
Cc: Geliang Tang <tanggeliang@kylinos.cn>, mptcp@lists.linux.dev,
 Martin KaFai Lau <martin.lau@kernel.org>
References: <cover.1724142917.git.tanggeliang@kylinos.cn>
 <3788544d841aa372a810f2d3dce905612063e872.1724142917.git.tanggeliang@kylinos.cn>
 <407f6a6a-344e-4f12-9293-e43b9a97f8d4@kernel.org>
 <23cffc2904df37874f35f106975fccc962d6cb8e.camel@kernel.org>
 <689e3694-d8f9-4511-8363-6f83a3bb1a1d@kernel.org>
 <afaa9ac33002da2452d3df014cd61a89fbd4978c.camel@kernel.org>
 <547fdd31-a052-4274-a59e-d7177887dbbe@kernel.org>
 <010b2338434b7df67ac418ad7063543e91c946b9.camel@kernel.org>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Martin KaFai Lau <martin.lau@linux.dev>
Content-Language: en-US
In-Reply-To: <010b2338434b7df67ac418ad7063543e91c946b9.camel@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 8/26/24 2:24 AM, Geliang Tang wrote:
>> I'm not an expert in this, but I guess it means you cannot use
>> 'mptcp_subflow_active()', because it can modify the 'subflow'
>> structure
>> that you got with bpf_core_cast() for a read-only usage.
> 
> A read-only function will get the same error.
> 
> I added a read-only function mptcp_subflow_get_scheduled() for testing:
> 
> bool mptcp_subflow_get_scheduled(struct mptcp_subflow_context *subflow)
> {
>          return subflow->scheduled;
> }
> 
> And invoke it from BPF in mptcp_for_each_subflow() loop:
> 
> int BPF_PROG(bpf_first_get_subflow, struct mptcp_sock *msk,
>               struct mptcp_sched_data *data)
> {
>          struct mptcp_subflow_context *subflow, *tmp;
> 
>          mptcp_for_each_subflow(msk, tmp) {
>                  subflow = bpf_core_cast(tmp, struct
> mptcp_subflow_context);
>                  mptcp_subflow_get_scheduled(subflow);
>          }
>          return 0;
> }
> 
> The same "arg#0 is untrusted_ptr_ expected ptr_ or socket" occurs.
> 
> Hope Martin can give us a solution for this issue.

I don't know the context for this list walking + modify-by-kfunc usage, so the 
following could be a grain of salt.

It seems like fitting the bpf_iter use case. Take a look at some recent bpf_iter 
additions, e.g. bpf_iter_{task,css}_next(). Also the bpf_for_each macro usage in 
selftests. There may be some secondary things that need to consider, e.g. how 
the walked subflow is protected, rcu, refcnt...etc.

