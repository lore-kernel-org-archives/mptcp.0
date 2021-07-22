Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com [209.85.208.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CA662FB0
	for <mptcp@lists.linux.dev>; Thu, 22 Jul 2021 13:33:55 +0000 (UTC)
Received: by mail-ed1-f44.google.com with SMTP id l1so6797329edr.11
        for <mptcp@lists.linux.dev>; Thu, 22 Jul 2021 06:33:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares-net.20150623.gappssmtp.com; s=20150623;
        h=to:references:from:subject:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=RbfXXFojb63Udd/zAt2s3STD5tgF0PqdZ59A9X8T6lU=;
        b=TCJVSoSY56Y/5K2cBtJQvWEuPz8u4vYNbpFunHHWW+PMVeNPyO6AxKZ7Mj1Zxk6JWh
         bGteyILG/duyA4t7eFxnr5C/gE2QuJEizTWj/hCOX8zm/myQ2iLKRV71KLF2cfZVxXlK
         ktOdp4jbA469izugWyTMP/cyrT+X4iEuAt+87wQU5UPS7CoeyIMzrEWFgQA1b2v08B9Q
         o8ftQpOrxFYN/huOjk6oNjLYVImgXHJ7F3q+loVYEVjbYmPlJsdvIRbhGTMs0AcLYpMv
         PDXPh6uX6kcF1m5koDLe9TKHTJFri0TqeDqnmLY/HP7JY0KplqhmUgeHq8D5+xC/HPTC
         P9UA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:references:from:subject:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=RbfXXFojb63Udd/zAt2s3STD5tgF0PqdZ59A9X8T6lU=;
        b=KDDVTc64cClY+eoFyjy/CcPKgQMXbhGxoe8lgwu2CZQeJSBTECn1M9W1KsZ1xmKas+
         s4j1544/CsG0RkJS6CYumBPjpAuSHjJTv2kKxH/5FmcksZr/ZtYSyR4rk+K7JzsVJfga
         NX+oAuEpEeotPqd5kz0jx+/dm/cFtqikaXmmLwg6AiLuVUJPkmIH3QGg/d4OljJNwPWW
         +O6SHbU6rNia7Fxl65rS4OOeiEksjOwWzRKxxLvRh7v/B8+InfPgCnQeLEg8MhD4Io/x
         ljbtWRM2/JyKdRAzR9/+JRG2CA1q0bd3Vunrx6F4CXmo+JmeLSdaP8si14UT5xymccVb
         odiA==
X-Gm-Message-State: AOAM530yd6IVPqRbjjZX6SMcTLdYPCE7e83U4AHNfJogyiPpHxxMkDMH
	n4yUR/bb0PtQPF80pfcUtqHKNXc6cHk3LB/cxw4=
X-Google-Smtp-Source: ABdhPJy9ZcoDQmqOHLidOm6YNI7fzYIh0vcuYrDQ7HIoez2ZEpZOrhVnXTAg4IfNwYxRyuGVVjQKuQ==
X-Received: by 2002:a05:6402:1c8a:: with SMTP id cy10mr53655218edb.232.1626960833700;
        Thu, 22 Jul 2021 06:33:53 -0700 (PDT)
Received: from tsr-lap-08.nix.tessares.net ([2a02:578:85b0:e00:8391:ca7f:9c1b:4236])
        by smtp.gmail.com with ESMTPSA id d8sm6527915edj.19.2021.07.22.06.33.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 22 Jul 2021 06:33:53 -0700 (PDT)
To: Geliang Tang <geliangtang@gmail.com>, mptcp@lists.linux.dev
References: <cover.1626877655.git.geliangtang@gmail.com>
 <b5f63eb4ad680a99fc806d2406968a6a5f272f01.1626877655.git.geliangtang@gmail.com>
 <0000f0168f0d8d1cd34bbe5463aed721225446e2.1626877655.git.geliangtang@gmail.com>
 <93ffe9fbfda6d2efdbab73373b6efbbce3a36b00.1626877655.git.geliangtang@gmail.com>
 <f1175761821947749ac9724deb3009b9b2747bbd.1626877655.git.geliangtang@gmail.com>
From: Matthieu Baerts <matthieu.baerts@tessares.net>
Subject: Re: [MPTCP][PATCH v2 mptcp-next 04/10] mptcp: add netdev up event
 handler
Message-ID: <6527abdf-adcf-939a-ffa5-6dd0856db428@tessares.net>
Date: Thu, 22 Jul 2021 15:33:52 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <f1175761821947749ac9724deb3009b9b2747bbd.1626877655.git.geliangtang@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 8bit

Hi Geliang,

On 21/07/2021 16:31, Geliang Tang wrote:
> This patch added the net device UP event handler function named
> mptcp_fm_cmd_add_addr. In it, alloc an address entry, populate it, and
> append this entry to the local address list. Then invoke
> mptcp_nl_add_subflow_or_signal_addr to create the new subflows.

(...)

> diff --git a/include/uapi/linux/mptcp.h b/include/uapi/linux/mptcp.h
> index 7b05f7102321..f66038b9551f 100644
> --- a/include/uapi/linux/mptcp.h
> +++ b/include/uapi/linux/mptcp.h
> @@ -73,6 +73,7 @@ enum {
>  #define MPTCP_PM_ADDR_FLAG_SIGNAL			(1 << 0)
>  #define MPTCP_PM_ADDR_FLAG_SUBFLOW			(1 << 1)
>  #define MPTCP_PM_ADDR_FLAG_BACKUP			(1 << 2)
> +#define MPTCP_PM_ADDR_FLAG_FULLMESH			(1 << 3)

Adding a new flag for the Netlink API seems to be the good direction to
take I think. But I think we should only set this flag using Netlink.

> diff --git a/net/mptcp/pm_netlink.c b/net/mptcp/pm_netlink.c
> index ac0aa6faacfa..3437de74f003 100644
> --- a/net/mptcp/pm_netlink.c
> +++ b/net/mptcp/pm_netlink.c

(...)

> @@ -1954,6 +1956,31 @@ static struct genl_family mptcp_genl_family __ro_after_init = {
>  	.n_mcgrps	= ARRAY_SIZE(mptcp_pm_mcgrps),
>  };
>  
> +#if IS_ENABLED(CONFIG_MPTCP_FULLMESH)
> +
> +int mptcp_fm_cmd_add_addr(struct net *net, const struct mptcp_addr_info *addr)

Should it not be declared in fullmesh.c file? It is specific to FM.

Cheers,
Matt
-- 
Tessares | Belgium | Hybrid Access Solutions
www.tessares.net
