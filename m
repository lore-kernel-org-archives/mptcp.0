Received: from mail-pj2-f2.google.com (mail-pj2-f2.google.com [74.125.227.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CAEC42236F0
	for <mptcp@lists.linux.dev>; Tue, 11 Aug 2026 00:33:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786408408; cv=none; b=QkUqcOL260DPh2XT4MBD06DnHquARcDEGuujMyYPa3gIgeKKVGV91P+4RUlEPE9XzDJGnJjfnyReEWlY4vVJsx+8bZlSfi1RXHd8ZbQDeHe5QNNMOejjqZA0NIuW4ioGVlKN5+zaIS4xoLYVs+lyLFQxPxBZLVKcmO2Ou47zc8o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786408408; c=relaxed/simple;
	bh=2e5YNDU0jVS7U2IK/Ciy5noStkLUGiTVFAUNSy3HUMk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SXO7FYEPAE3Dn0R1kqQnP8hODcwuidIjtJ+gRBoM12lDmpazjt+EAUmn6jVedo5yPfRXtjCvhyaht/KYm7/Q50gqNLZWnIqFNtN8BZ8SkZt+Uu++rExnVNW6aaeK7x6TaZMqU7iDq7FctRI8L/zJwKsEy/6Vdp8tByXgEGVizx8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mj0cw/jT; arc=none smtp.client-ip=74.125.227.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mj0cw/jT"
Received: by mail-pj2-f2.google.com with SMTP id 98e67ed59e1d1-37fb1883fbfso884611a91.0
        for <mptcp@lists.linux.dev>; Mon, 10 Aug 2026 17:33:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786408406; x=1787013206; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=tyXmp+nyruHB5drxUnjhN/lNDgAHg9Jkey37bDFf6+0=;
        b=mj0cw/jT10fu7GdalPmR8ZHftuZhMHj8Fza/4kgniLBliuRE2b2kRs7bEzuz5dS5rc
         xHh3AqJ6Iee6237HFDsLHEX1TQrgnGvyZwnxU0eCC8pdkcR6n11Vcr/HutFtNA/5e1X9
         k0uW57X5evPZLHTFuSGByJl9uuX+L7N0REyHtpDeP+0RFMEq7FvzMiDcHBlUb2MuQv0h
         0GR4Y8AVErzDDcGGkpKtzAyJttYN0akuhiS/Zby3wJ9kRip3LTPldlh+XzF4V3+DgUVu
         FzQFNIGmwkbzk2bHH4lnNtAF6DD+enP/Q5quloCpQJjN0mgX9+AKk8nIeK8r/Epz/0a7
         6Pfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786408406; x=1787013206;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=tyXmp+nyruHB5drxUnjhN/lNDgAHg9Jkey37bDFf6+0=;
        b=AgVZzhdu1hzdodEXABGi7c9+D/uewAQlp35hdYXdZQj9UCWPW1pVEMY2MNgy/QPJ+v
         iKCoGfjLd4HC/sG1fJnASU53VIjQq+Y6Z/jZsfgAUKxqFUKhPACjlV0Un6yzBU+Q7yvN
         f8GbV12Hu3Ai8xCePT3aXK2VhhNCS/lB2c381O+FqnJj4vfAxjkB3ndj/YRBgTUok9Sm
         /w670pGfq0UO51K4KVlQgPHb89rzF2+aL7fEP/pqVM1qjuB493yXDTBnnJX4BQm8VBbu
         g5iYmsB5DECwxL27slzGzgXq6Az5MNUEVmUP/zTlpVPjPSTYdkmZ1cmAOFP96F6YnhKv
         9LVw==
X-Forwarded-Encrypted: i=1; AHgh+Ro7E2izLzPZZtZ5Nw47AYQ9+32OGk0XfkyzC+8euKCTxETNS4exmN+D689NM1Uk1kvnkt12dQ==@lists.linux.dev
X-Gm-Message-State: AOJu0YwsbRo4vM1dw1GDLYkwTsRDa1+nmimtq2mttUk15so4nznWtTEi
	tkMax5TsHbjyXJBArO4NPXeR8fUS7zkI7ccTGxNUW5/Rbh/McxAzipHq
X-Gm-Gg: AR+sD11cJtGqFVv3VVqVRw71MGP74nwVQSHgABVAzOzaWfzE92FAs3yxGROB/qBSzyP
	d2oMAMQVbyn8XnKpOOmD6wqQXZCqd/95HKRKE2mDtwyT+KWLyGss+uMHBpSmtX/HWB7iLEnRPQs
	ibQvH9ysAGNaLAWRzqfgEBPwZ1pHNVJ/EP3Ll9/mMr9A9UHfjHxqkxoaQjl0ROFJ8cA7Wt8rmMA
	j8lazqdOxaUEt1RysDWHPHDcnJG8kxXVjrLVzcuZVKg7LXAaJoBmjlzsjCF2y7WHLRyaXYdwT7o
	FGGvIMRskMVzw7Vdb618RAqedJ4otMXEjrVVbc2EItMMIq4ZjVXg9yZZHMyJ3HQUj3T2lc0Ycqe
	QR9xrtpejANRy0gAgNkf+J5h126au9QTKww9S5akD9pQ44/jbkWPb+/dM6wNsADFSHUdksEZQj3
	VVnY4xLwZjwJ2f00DMKa23xSlo9jmHG45tK6WqAKE81J6g9Tg4R6G2NTexZJ3h6MvG
X-Received: by 2002:a17:90b:3847:b0:383:f52b:d616 with SMTP id 98e67ed59e1d1-3909d89bd69mr25756524a91.10.1786408406008;
        Mon, 10 Aug 2026 17:33:26 -0700 (PDT)
Received: from localhost ([2a03:2880:2ff:7::])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-392d4050736sm1312465a91.4.2026.08.10.17.33.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Aug 2026 17:33:25 -0700 (PDT)
Date: Mon, 10 Aug 2026 17:32:36 -0700
From: Stanislav Fomichev <sdf.kernel@gmail.com>
To: Geliang Tang <geliang@kernel.org>
Cc: Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@kernel.dk>, 
	Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>, 
	Chaitanya Kulkarni <kch@nvidia.com>, David Ahern <dsahern@kernel.org>, 
	Ido Schimmel <idosch@nvidia.com>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, Hannes Reinecke <hare@suse.de>, 
	Geliang Tang <tanggeliang@kylinos.cn>, linux-nvme@lists.infradead.org, netdev@vger.kernel.org, 
	mptcp@lists.linux.dev
Subject: Re: [PATCH v2 2/3] nvme-tcp: support IPv6 traffic class
Message-ID: <anptYps5IoeGDCnt@devvm7509.cco0.facebook.com>
References: <cover.1786171863.git.tanggeliang@kylinos.cn>
 <3f5e4c84d3fe41601b29468fa4128d4639d56685.1786171863.git.tanggeliang@kylinos.cn>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <3f5e4c84d3fe41601b29468fa4128d4639d56685.1786171863.git.tanggeliang@kylinos.cn>

On 08/08, Geliang Tang wrote:
> From: Geliang Tang <tanggeliang@kylinos.cn>
> 
> The NVMe/TCP transport needs to configure the IPv6 traffic class on its
> queue sockets, but the fabrics option parser currently has no corresponding
> option.
> 
> Add the tclass option to the fabrics parser and store the validated value
> in struct nvmf_ctrl_options. Negative values are rejected, while values
> greater than 255 are clamped to 255, matching the valid range of the IPv6
> traffic class field.
> 
> Keep -1 as the default value to let the transport use its default traffic
> class.
> 
> The fabrics layer now supports parsing the tclass option, but the NVMe/TCP
> transport does not currently advertise or apply it.
> 
> Allow NVMe/TCP to use NVMF_OPT_TCLASS and set IPV6_TCLASS on each queue
> socket via ip6_sock_set_tclass() when a traffic class is specified, keeping
> the existing IPv4 TOS handling unchanged.
> 
> Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
> ---
>  drivers/nvme/host/fabrics.c | 18 ++++++++++++++++++
>  drivers/nvme/host/fabrics.h |  3 +++
>  drivers/nvme/host/tcp.c     |  8 +++++++-
>  3 files changed, 28 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/nvme/host/fabrics.c b/drivers/nvme/host/fabrics.c
> index ac3d4f400601..643c03dc7bcb 100644
> --- a/drivers/nvme/host/fabrics.c
> +++ b/drivers/nvme/host/fabrics.c
> @@ -695,6 +695,7 @@ static const match_table_t opt_tokens = {
>  	{ NVMF_OPT_NR_WRITE_QUEUES,	"nr_write_queues=%d"	},
>  	{ NVMF_OPT_NR_POLL_QUEUES,	"nr_poll_queues=%d"	},
>  	{ NVMF_OPT_TOS,			"tos=%d"		},
> +	{ NVMF_OPT_TCLASS,		"tclass=%d"		},

Do you really need new UAPI for v6? Any reason not to apply existing
NVMF_OPT_TOS to ipv6 sockets?
