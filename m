Received: from canpmsgout05.his.huawei.com (canpmsgout05.his.huawei.com [113.46.200.220])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF3FE53E0B
	for <mptcp@lists.linux.dev>; Tue, 23 Jun 2026 04:50:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.220
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782190249; cv=none; b=m6aO3HlKXjj62y9JJrFdC/Y1qhOSRuCCkRdLfQ3a2mGnPs1EqSCahVcjvKgzz5q+qed7SxHHEjzT7noDZxmY1dovyPUrBlG2dxdk9f5NBeoiGkZAeZsVwe5VIhgeMhbzzTm8zxuEXczQj1dEYIHcvIfCOhrOaC/EpZINxXLCK/k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782190249; c=relaxed/simple;
	bh=kGTDLo/axkzjgSIPAYCQ7YxS5/fBwrEbUheGNmsdUIE=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=pOFbG+A1JLjv72+0ytoP7hRkcmgvW5ec6glNAsAvgpJ33ilUhECduhVsXCRf7rWDIwpGScv2Or0eD+tPkBg+j5bsaFcnYAnIk6hFNwkRAEUtxJUEi+tGTRL3TmOl8S7Vu7PzpFF77PJxU/hkk0pTMXjykxGhmdTGiEQlhdndqO8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=hSdVpEFn; arc=none smtp.client-ip=113.46.200.220
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="hSdVpEFn"
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=C4PGU+dceZGSPenf9tqxIe0yjh8no97A+ujHT6vZkjM=;
	b=hSdVpEFnk6PiUy8Zd0QC1C9entmPKBdycfQy3xmqx0NdCvSKtD0eN9HPQhguCzeCDieCcTSqa
	CHwljAqoiolOE6F6fG981pTfPmRjNHhMB1JhUcc+tjj2+WHT6ZY0uQLdRrT/Uv4pjfZj8kNPGN0
	YgVIi+gw0s5Wx8K5OOV9sIU=
Received: from mail.maildlp.com (unknown [172.19.162.140])
	by canpmsgout05.his.huawei.com (SkyGuard) with ESMTPS id 4gksq65yrdz12LDQ;
	Tue, 23 Jun 2026 12:41:54 +0800 (CST)
Received: from kwepemj500018.china.huawei.com (unknown [7.202.194.48])
	by mail.maildlp.com (Postfix) with ESMTPS id 960EA20226;
	Tue, 23 Jun 2026 12:50:42 +0800 (CST)
Received: from [10.174.178.79] (10.174.178.79) by
 kwepemj500018.china.huawei.com (7.202.194.48) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Tue, 23 Jun 2026 12:50:41 +0800
Message-ID: <c45810a3-5a87-4080-a8c4-4846d0fc74ed@huawei.com>
Date: Tue, 23 Jun 2026 12:50:40 +0800
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH mptcp-next] mptcp: fix lockdep splat in
 mptcp_subflow_create_socket
To: Kalpan Jani <kalpan.jani@mpiricsoftware.com>
CC: <matttbe@kernel.org>, <martineau@kernel.org>, <pabeni@redhat.com>,
	<shardul.b@mpiricsoftware.com>, <janak@mpiric.us>, <kalpanjani009@gmail.com>,
	<akshit@mpiricsoftware.com>,
	<syzbot+fb2c3fa2ba28aec94627@syzkaller.appspotmail.com>,
	"mptcp@lists.linux.dev" <mptcp@lists.linux.dev>, zhangchangzhong
	<zhangchangzhong@huawei.com>, yuehaibing <yuehaibing@huawei.com>, "weiyongjun
 (A)" <weiyongjun1@huawei.com>
References: <20260617064835.2957303-1-kalpan.jani@mpiricsoftware.com>
From: Li Xiasong <lixiasong1@huawei.com>
In-Reply-To: <20260617064835.2957303-1-kalpan.jani@mpiricsoftware.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: kwepems500001.china.huawei.com (7.221.188.70) To
 kwepemj500018.china.huawei.com (7.202.194.48)

Hi, Kalpan

On 6/17/2026 2:48 PM, Kalpan Jani wrote:
> Move sk_net_refcnt_upgrade() outside the socket lock to avoid GFP_KERNEL
> allocation under lock_sock_nested(), which can trigger page reclaim and
> create a circular locking dependency detected by lockdep.
> 

Thanks for the patch.

I might be missing something, but I wonder if this is still needed after:

  d532cddb6c60 ("nbd: Reclassify sockets to avoid lockdep circular dependency")

The reported chain seems to involve NBD sockets sharing the generic TCP lock
classes, and that patch should address it more directly.

> The circular dependency chain detected:
>   fs_reclaim --> sk_lock-AF_INET --> k-sk_lock-AF_INET/1
> 
> This operation is safe after lock release since the socket is fully
> initialized and no other references to it exist yet.
> 

Even with this change, the locked section still contains GFP_KERNEL
allocations: tcp_set_ulp() is called under lock_sock_nested(), and the MPTCP
ULP init path allocates the subflow context with GFP_KERNEL.

So if the NBD dependency is still present, I am not sure this fixes the
reported lockdep dependency rather than moving it to another allocation site.

It might be worth retesting this report with the NBD reclassification patch in
the tree before changing the MPTCP locking here.

Thanks,
Li Xiasong
