Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66A693CFF51
	for <mptcp@lists.linux.dev>; Tue, 23 Jun 2026 08:54:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782204879; cv=none; b=D1rLHsphTqgkey75bBXAdYtvnLR0oksnN0veV7YYAMimSJfaZTtaQgTI5y4zaVgxDDcN9Q7fbPmnFNgC7FjYbuA62LqQHnmSvSeWIaACJHF5ta7GTDlCyV62kXMlhDFa/fLbZKRizA+HlPwxzSpI3KS3KLkyFYafs9u5l1h23kw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782204879; c=relaxed/simple;
	bh=ILtrqd4tWrYVcDWmgCyq6sNuk4UwhPQQ21QfixUhlRY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=R8Cj2pMYOrmsSsB7kdE0Tl/RF/Q1QVeE9cGPhw3eYmiu7KMXPnktXI3StJeVA1oVHYqcDDj3e49LeKcLCimm/fEUVchv+KDirbjXrNShw6UE5vbhhCKfFzY55asKN7XnIC3EK4k5+hQ1x65HvHxouQ5ESffGMgnTBOtGTgmUF0I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FBoTQ8WG; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FBoTQ8WG"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2981C1F00A3A;
	Tue, 23 Jun 2026 08:54:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782204878;
	bh=Buqo+9ttYLom23qiNbNROjr9vgk1PB4NYslcdPh+tlY=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=FBoTQ8WG3l/1QBaUxUJY2LCeI/WNiQWKfEUz3HhLnt4TTb59vCR+SBE424bzPvdKW
	 9iuRsrQ6/slJ19QRfCUvgaZr+AE6hWgnVHjnSg3XU7oRIoFBeC9axqU6nIuCTtEZj3
	 OazqGEOoibz+9kHy7h7HSutdQZVTbZDiPHLrkhRL1WQ9AZzPQmwiGdaCV0W8lsRNrF
	 3gcwkGUAtyl7Y0r6gkMFt2RsEsMgH1LnJWbrT+ZrbuRKeXeE2R8rNtUpMMNbtVVKsn
	 2nICdabK2DUyUvxftXY1clyhr4cNUsu9j/JGJ19MJ3qLKn6OS12QZ45SeKAopFd6Ud
	 Td9bXyd9yrWYw==
Message-ID: <05d0dbe6-b2d8-415d-9ded-cb5c4f073812@kernel.org>
Date: Tue, 23 Jun 2026 10:54:31 +0200
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird Beta
Subject: Re: [PATCH mptcp-next] mptcp: fix lockdep splat in
 mptcp_subflow_create_socket
Content-Language: fr
To: Li Xiasong <lixiasong1@huawei.com>,
 Kalpan Jani <kalpan.jani@mpiricsoftware.com>
Cc: martineau@kernel.org, pabeni@redhat.com, shardul.b@mpiricsoftware.com,
 janak@mpiric.us, kalpanjani009@gmail.com, akshit@mpiricsoftware.com,
 syzbot+fb2c3fa2ba28aec94627@syzkaller.appspotmail.com,
 "mptcp@lists.linux.dev" <mptcp@lists.linux.dev>,
 zhangchangzhong <zhangchangzhong@huawei.com>,
 yuehaibing <yuehaibing@huawei.com>, "weiyongjun (A)" <weiyongjun1@huawei.com>
References: <20260617064835.2957303-1-kalpan.jani@mpiricsoftware.com>
 <c45810a3-5a87-4080-a8c4-4846d0fc74ed@huawei.com>
From: Matthieu Baerts <matttbe@kernel.org>
Autocrypt: addr=matttbe@kernel.org; keydata=
 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
 lzVbFe7fduHbABmYz9cefQpO7wDE/Q==
Organization: NGI0 Core
In-Reply-To: <c45810a3-5a87-4080-a8c4-4846d0fc74ed@huawei.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Li, Kalpan,

On 23/06/2026 06:50, Li Xiasong wrote:
> Hi, Kalpan
> 
> On 6/17/2026 2:48 PM, Kalpan Jani wrote:
>> Move sk_net_refcnt_upgrade() outside the socket lock to avoid GFP_KERNEL
>> allocation under lock_sock_nested(), which can trigger page reclaim and
>> create a circular locking dependency detected by lockdep.
>>
> 
> Thanks for the patch.
> 
> I might be missing something, but I wonder if this is still needed after:
> 
>   d532cddb6c60 ("nbd: Reclassify sockets to avoid lockdep circular dependency")
> 
> The reported chain seems to involve NBD sockets sharing the generic TCP lock
> classes, and that patch should address it more directly.

@Li: Thank you for pointing to this commit. Indeed, that seems to be the
required fix for this issue.

@Kalpan: were you able to reproduce the issue pointed out by syzbot? If
yes, can you check if Eric's fix is enough? Or did you try to fix it by
analysing the code?

>> The circular dependency chain detected:
>>   fs_reclaim --> sk_lock-AF_INET --> k-sk_lock-AF_INET/1
>>
>> This operation is safe after lock release since the socket is fully
>> initialized and no other references to it exist yet.
>>
> 
> Even with this change, the locked section still contains GFP_KERNEL
> allocations: tcp_set_ulp() is called under lock_sock_nested(), and the MPTCP
> ULP init path allocates the subflow context with GFP_KERNEL.
> 
> So if the NBD dependency is still present, I am not sure this fixes the
> reported lockdep dependency rather than moving it to another allocation site.

Indeed, the fix might not be enough to fix the issue.

> It might be worth retesting this report with the NBD reclassification patch in
> the tree before changing the MPTCP locking here.
If it is not possible to reproduce the bug, I suggest closing the
corresponding bug, and drop this patch. WDYT?

Cheers,
Matt
-- 
Sponsored by the NGI0 Core fund.

