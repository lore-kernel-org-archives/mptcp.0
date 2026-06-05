Received: from canpmsgout12.his.huawei.com (canpmsgout12.his.huawei.com [113.46.200.227])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B67983BD25A
	for <mptcp@lists.linux.dev>; Fri,  5 Jun 2026 07:32:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.227
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780644730; cv=none; b=eFXaytQ7yFv1/aBxRYGhqGDqFaYkldFoNCjzqXTIqewKBQWCI/hyTbxSOGA5x1EycFL47RZl8akVYpqqdSg5KmGI3TL/t7cndvDIRDFswJ0SvCh7J8K1PhNFq1ocwseKXXGinEBiyDYNa70ILVpC4lE3accl2yoC5aNJnfFwhNU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780644730; c=relaxed/simple;
	bh=oFiDkIB50evWnIkyh4zM5TGPFRrJRtqb3YL1990OiOU=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=nVsnlLyCKIS/MBaJPauaEiA3sK62EhNeNm4kjtbMmDEQF8Xz66G0XrFjxPFRmSK8v6XQI2OGtSlngiGQ3gbWyoCeoccBcBBkf4YbMNg/06gG3cdcDuEcAk28mrYVOLFKUWAvfRL57CuOdcCcQOn1TWY4om9RyBxMR+oGEG3z42M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=r4A8QZ9q; arc=none smtp.client-ip=113.46.200.227
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="r4A8QZ9q"
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=iZ0AfxDuLRaEVDCppEcdOIE9kJNMXqof9Pt2mKJmrOg=;
	b=r4A8QZ9qsj5CGQT/9kr8qh0vRPO8wYVAUPTK1b+h1VwcyfqIZIUQP1Wl45kJe6eHJnaSSXDYa
	KNaV477M4LvukFya8I7wVgxsPjQtwp7iSyObkzYhGTFpoIt92ykUhQMCn4aZ/T0yAFIeXdfF1dz
	W+VuvVB1OVCJngERGTn048I=
Received: from mail.maildlp.com (unknown [172.19.163.163])
	by canpmsgout12.his.huawei.com (SkyGuard) with ESMTPS id 4gWtGb23p4znTWL;
	Fri,  5 Jun 2026 15:24:07 +0800 (CST)
Received: from kwepemj500018.china.huawei.com (unknown [7.202.194.48])
	by mail.maildlp.com (Postfix) with ESMTPS id 47BD14048B;
	Fri,  5 Jun 2026 15:31:59 +0800 (CST)
Received: from [10.174.178.79] (10.174.178.79) by
 kwepemj500018.china.huawei.com (7.202.194.48) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Fri, 5 Jun 2026 15:31:58 +0800
Message-ID: <c7d0b579-85d5-4a8c-8baf-25843dee1fae@huawei.com>
Date: Fri, 5 Jun 2026 15:31:57 +0800
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH mptcp-net] mptcp: prevent add_addr timer rearm during
 teardown
To: Kalpan Jani <kalpan.jani@mpiricsoftware.com>, "matttbe@kernel.org"
	<matttbe@kernel.org>
CC: "mptcp@lists.linux.dev" <mptcp@lists.linux.dev>, "janak@mpiric.us"
	<janak@mpiric.us>, "shardul.b@mpiricsoftware.com"
	<shardul.b@mpiricsoftware.com>, zhangchangzhong <zhangchangzhong@huawei.com>,
	"weiyongjun (A)" <weiyongjun1@huawei.com>, yuehaibing
	<yuehaibing@huawei.com>, "xiasong.lee@gmail.com" <xiasong.lee@gmail.com>
References: <20260526103647.732350-1-xiasong.lee@gmail.com>
 <20260604071909.3260023-1-kalpan.jani@mpiricsoftware.com>
From: Li Xiasong <lixiasong1@huawei.com>
In-Reply-To: <20260604071909.3260023-1-kalpan.jani@mpiricsoftware.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: kwepems500002.china.huawei.com (7.221.188.17) To
 kwepemj500018.china.huawei.com (7.202.194.48)

Hi Matt, Hi Kalpan,

Thank you for your review and suggestion.

The main reason I have been hesitating to send a v2 is that,
after re-checking the code paths more carefully, I am no longer
sure that the original issue reported by Sashiko can actually
happen in this add_addr timer path.

My current understanding is that both sk_stop_timer_sync() and
sk_shutdown_timer_sync() synchronously stop the timer: if the
callback is running, they wait for it to finish, and if the
callback re-arms the timer before returning, the pending timer
is then deleted before the helper returns.

So for this specific add_addr timer, I do not currently see a
path where teardown completes and a re-armed timer is still
left behind afterward. That is why I have not sent a v2 based
on sk_shutdown_timer_sync() so far.

That said, I think tightening this teardown path could still be
useful for robustness and could help avoid similar issues after
future changes.

On 6/4/2026 3:19 PM, Kalpan Jani wrote:
> Hi Li,
>  
> Great work on this patch series! Your approach of creating sk_shutdown_timer_sync()
> helper is the right pattern.
>  
> I noticed one additional issue: in mptcp_pm_free_anno_list(), the timer_done check
> is unsynchronized:
>  
>     if (!entry->timer_done)  // Data race: no lock protecting this read
>         sk_stop_timer_sync(sk, &entry->add_timer);
>  
> This is a classic data race. Your patch keeps it as-is, but I think we should
> also fix it by removing this check entirely and always calling timer_shutdown_sync().
>  
> Would you be open to adding this improvement to your patch? The benefit:
> - Eliminates the data race
> - Simplifies the code (unconditional shutdown)
> - timer_shutdown_sync() is idempotent anyway
>  

Yes, I think this would be a good direction if timer_done can
be removed safely.

I agree that it would avoid the unsynchronized timer_done check
and simplify the teardown path.

Before removing timer_done, I would like to better understand
the original scenario for which it was introduced.

Matt, if I am understanding it correctly, timer_done was added
to avoid the case where the socket reference held by the timer
becomes the last one, and then sock_put() from the timer
callback triggers socket destruction, which in turn reaches
sk_stop_timer_sync() for the same timer.

If that understanding is correct, my concern is that removing
timer_done without addressing that original case might
re-introduce the self-wait issue during teardown from the timer
callback path.

So overall, I agree with Kalpan's suggestion if timer_done is
indeed no longer needed for that last-reference case. I would
just like to clarify that point first before sending a new
version.

> I'd be happy to:
> 1. Test the updated patch
> 2. Help refine the implementation
> 3. Co-author if you'd like
>  
> What do you think?
>  

Thanks a lot for the offer, I really appreciate it.

Thanks,
Li Xiasong

