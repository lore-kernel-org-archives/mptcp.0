Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82A3F33AD9B
	for <mptcp@lists.linux.dev>; Sat, 22 Aug 2026 22:19:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787437184; cv=none; b=GYTS4mdjAs6ixYNFpus76cOX2LgnBtrLrx489rWIJ0cdFFNs+/Gklxf4nAauqfpUnQLibenjOFRfAR1p9ba3FJVtWxw0HlTq8V71nowJn+ayyFdU21tTGxfIZFjC6y3eRQHR12/qYoDDVcIhsaUxUuCYBxfou6IRq5QGsbS8kgU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787437184; c=relaxed/simple;
	bh=2IFIrXXQx/YTLSk7qgjW+/GYCEMiGGrTEdWZJHI1F3M=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=PDf4AazOGK2ZtDcdJhMosvNVj4X8ZfdfT3BgHOCErwI1tcrwxnBj0f5I/Ld1LjYXyoHu+JlMB/CchZAz0YLWThNrC5wCFg2VJIQtal4AedRdIfVKTRvf0mVLWRm9B670+LFR2JxsH2o1XfOEm1euf6fTZ9oDISWXvjVqE1MaHd4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.218.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-c15e2dab83eso425040566b.1
        for <mptcp@lists.linux.dev>; Sat, 22 Aug 2026 15:19:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787437181; x=1788041981;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=HeO8qz7gI/PQdjAfS1WIWNrGC+sH7zaBOZAEPxSZsz0=;
        b=ovrkIxd5UdbsNE4V31eeLYjJio1S1VohwCe+yhx95h0TIAPlTAeqc/gxcdRf8DhgTU
         EGYAXd7ASe6lGjTvz2P8LEcWyFH4SZGCKH3v52yfMj+wf+7Am9oeMrj81TYAnxcZjgeL
         XIqpoFjrNoas7SJ/Sqqbne7L4BroWKG51tioqrdQeHd9Kfthb4o8cDZcuOeSCkJ5CUlP
         KKv3mpumU1iGXgdCzYMIfwqc22Vnoc97JQNqHHuDD8r46u1p3ZoByPfahIvD1lZmxo40
         dZmKDk8iW5m7c7ULLgUSLnTXXT86x0xsL6etIDzvclZoHjPANhU0If7O10n9J8X3LfiM
         mr8A==
X-Forwarded-Encrypted: i=1; AHgh+RogKuN9Zdw3mwnV9I3kxhwF3o0915ibxqqIXqj0FiwDyFcdq1Go2l9ziiuMdf2DO3Ga5YBkEg==@lists.linux.dev
X-Gm-Message-State: AFuF++leJKyQWrXKQj+KOuDi48AA6O84UbstLX9lbAhQriZ/mR1sgfIz
	T1YqBhTnFNIul6T08iTOteTDnhPHpCxwMqibRH9Sutd1YzzF+oIE+ss9
X-Gm-Gg: AR+sD11VOoli5xySy/hQubGAv0e/Jy856gUoAdvuDM1HMVvu/XYdsaCR786bdYcDi4c
	eISZS8alBnULRDlIl7tYZRPoJOXSUXVsft1P8tJ/noAO7rdIZ8zybpGZsac/W8357wHGWguP/6e
	paqP3cko/uoPzeA778miNLDeXiUCj1dHc3unTzLzNCmZT5cvDy4kvnmZcROgs+9MZkP+NZiULf8
	lTEUpFXkJ200Vu24EVQYnWkrMwiuzCcTp6/ZjV3hSUlSF5rviC5bUWChuD8HMnXRl9jX8rA/Orn
	24Ye5x9EtxwfTJEz2OBxjEScqZweFQ1BdBEe01ICSuc9zTgbRYXL8npNsHLm78QiHOiwgRcqHMj
	TDTRfYmUjJnbqxO0chLlKjqVCDKG0nS+0tEhjqaE5e7R/hcTxtIlPRwb4THGgx1oYBv5jlz2IEk
	5ECuxB7Yl/rj0SXa/yRrFSpx2hiM51aeHBPBk+ukZ0DE2Fy5gHAbVuDxZUg336hOgZ5AqV6I7c6
	msst0mJCLs3J+IGoDn4e14=
X-Received: by 2002:a17:906:fe49:b0:c24:b11c:6bf9 with SMTP id a640c23a62f3a-c24b11c6d84mr220160966b.6.1787437180599;
        Sat, 22 Aug 2026 15:19:40 -0700 (PDT)
Received: from [10.100.102.74] (89-138-65-240.bb.netvision.net.il. [89.138.65.240])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c24967383e5sm483628966b.45.2026.08.22.15.19.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 22 Aug 2026 15:19:40 -0700 (PDT)
Message-ID: <904ec61e-17e1-42f6-8215-63a806aeca76@grimberg.me>
Date: Sun, 23 Aug 2026 01:19:38 +0300
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 4/4] nvme-tcp: support IPv6 traffic class
To: Geliang Tang <geliang@kernel.org>, Keith Busch <kbusch@kernel.org>,
 Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>,
 Chaitanya Kulkarni <kch@nvidia.com>, David Ahern <dsahern@kernel.org>,
 Ido Schimmel <idosch@nvidia.com>, "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>,
 Hannes Reinecke <hare@suse.de>, Stanislav Fomichev <sdf@fomichev.me>
Cc: Geliang Tang <tanggeliang@kylinos.cn>, linux-nvme@lists.infradead.org,
 netdev@vger.kernel.org, mptcp@lists.linux.dev
References: <cover.1786947923.git.tanggeliang@kylinos.cn>
 <d6095cd3809af7addc44ed162d70d6327dc237ac.1786947923.git.tanggeliang@kylinos.cn>
Content-Language: en-US
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <d6095cd3809af7addc44ed162d70d6327dc237ac.1786947923.git.tanggeliang@kylinos.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 18/08/2026 9:03, Geliang Tang wrote:
> From: Geliang Tang <tanggeliang@kylinos.cn>
>
> Currently, nvme-tcp host only supports setting the IPv4 TOS value when a
> TOS is specified, but does not handle the IPv6 traffic class.
>
> Extend the queue socket setup to handle AF_INET6 sockets by applying the
> TOS value to both IPv4 and IPv6 sockets. For IPv6, the TOS value is set
> as the IPv6 traffic class via IPV6_TCLASS using do_sock_setsockopt().
>
> Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
> ---
>   drivers/nvme/host/tcp.c | 20 ++++++++++++++++++++
>   1 file changed, 20 insertions(+)
>
> diff --git a/drivers/nvme/host/tcp.c b/drivers/nvme/host/tcp.c
> index 025cade370b2..5f30be04a9dd 100644
> --- a/drivers/nvme/host/tcp.c
> +++ b/drivers/nvme/host/tcp.c
> @@ -1815,6 +1815,17 @@ static int nvme_tcp_sock_set_tos(struct sock *sk, int tos)
>   				  KERNEL_SOCKPTR(&tos), sizeof(tos));
>   }
>   
> +static int nvme_tcp_sock_set_tclass(struct sock *sk, int tclass)
> +{
> +#if IS_ENABLED(CONFIG_IPV6)
> +	if (sk->sk_family == AF_INET6)
> +		return do_sock_setsockopt(sk->sk_socket, false, SOL_IPV6,
> +					  IPV6_TCLASS, KERNEL_SOCKPTR(&tclass),
> +					  sizeof(tclass));
> +#endif
> +	return 0;
> +}
> +
>   static int nvme_tcp_alloc_queue(struct nvme_ctrl *nctrl, int qid,
>   				key_serial_t pskid)
>   {
> @@ -1909,6 +1920,15 @@ static int nvme_tcp_alloc_queue(struct nvme_ctrl *nctrl, int qid,
>   				qid, ret);
>   			goto err_sock;
>   		}
> +
> +		ret = nvme_tcp_sock_set_tclass(queue->sock->sk,
> +					       nctrl->opts->tos);

Won't it just be cleaner to add a generic ip_sock_set_tclass() that 
hides the IS_ENABLED(CONFIG_IPV6) ifdef? Why do we need to wrap all 
these generic helpers?
