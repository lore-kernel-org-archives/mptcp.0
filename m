Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53465168
	for <mptcp@lists.linux.dev>; Fri, 14 Jan 2022 15:27:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1642174079;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=JTMIYPYTWkEF7lJZW6nAhHLIkzQnGvaSbUsQx3I441w=;
	b=HR37Vz1eaefCQZ0ljT9osu3dDpg4UUXflSdojrupKDASD2zx01ViJDQzwk3weamJBZ5riZ
	LgQUlI6ROcHTB5fUPpNHYLR90cjq123mwtJGAc4J4s+HcPAadIHMsFZoX1zeM0F3bKNtdP
	1qu5QubHGOFv5ycl0jKXBD1Tb24md8s=
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-186-BRN3_RdwMPCYqX5RujqZvg-1; Fri, 14 Jan 2022 10:27:55 -0500
X-MC-Unique: BRN3_RdwMPCYqX5RujqZvg-1
Received: by mail-qt1-f200.google.com with SMTP id 4-20020ac85744000000b002b2f329efc2so8086184qtx.12
        for <mptcp@lists.linux.dev>; Fri, 14 Jan 2022 07:27:55 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:subject:from:to:date:in-reply-to
         :references:user-agent:mime-version:content-transfer-encoding;
        bh=JTMIYPYTWkEF7lJZW6nAhHLIkzQnGvaSbUsQx3I441w=;
        b=2nSk68N+zVyZpel82uLf7DCuGXsP2XeAuV9NdJ2mCmGIWHVaU2BdKJ4CzVUfyO4890
         LwEGJApdSD6XiG8RVu2HWKnCBizc8qrZ8Av9WHQJQmURk/h5+q2Gkyhcxj06jITdVA8e
         wF1LI9XQw9OrhPzPZfarzgTY4AZyf3LQIyxp7y3yz+K/PCE3qnUGCu7NnJreI1y+V/j2
         tTE3rPdQ9TPZQpL1zrOm9XyZc/jwzEzUYP6x35x+J3PACareF5C39D/4xkBuBpEWIn67
         DxX1WVO3w4Uht9qiuHQFJrpzM/nygQFCEDY+q3MhnitCjS1xYcgla8nDB31e4KoAGjCJ
         yyFA==
X-Gm-Message-State: AOAM532YDl44W2G0lDIKpiVAEYLdbj10dYqxc7GxbSwdt72wiYrdcaQk
	RzoxrWdr3+vjk1cR65QG8s3h7zwJVMMwWueOLTxOOqaAhessGYoCSx5XhBpUNryImv0tcAjB78i
	T7YwSntUyv4dTDD4=
X-Received: by 2002:ad4:5fcf:: with SMTP id jq15mr8249789qvb.0.1642174075109;
        Fri, 14 Jan 2022 07:27:55 -0800 (PST)
X-Google-Smtp-Source: ABdhPJwuHgMtHrNgdK4OQWYed8JFEWHESUMODoVMZVr4FVxz0LzKbDn9aE/EYJhL56HBjJ0ctYtelA==
X-Received: by 2002:ad4:5fcf:: with SMTP id jq15mr8249774qvb.0.1642174074843;
        Fri, 14 Jan 2022 07:27:54 -0800 (PST)
Received: from gerbillo.redhat.com (146-241-96-254.dyn.eolo.it. [146.241.96.254])
        by smtp.gmail.com with ESMTPSA id h13sm3654942qtr.47.2022.01.14.07.27.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Jan 2022 07:27:54 -0800 (PST)
Message-ID: <489b1e836ec09b23cd9318f7fa8a404dec50e72b.camel@redhat.com>
Subject: Re: [PATCH mptcp-next v2 07/21] mptcp: netlink: process IPv6 addrs
 in creating listening sockets
From: Paolo Abeni <pabeni@redhat.com>
To: Kishen Maloor <kishen.maloor@intel.com>, mptcp@lists.linux.dev
Date: Fri, 14 Jan 2022 16:27:51 +0100
In-Reply-To: <20220112221523.1829397-8-kishen.maloor@intel.com>
References: <20220112221523.1829397-1-kishen.maloor@intel.com>
	 <20220112221523.1829397-8-kishen.maloor@intel.com>
User-Agent: Evolution 3.42.2 (3.42.2-1.fc35)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Authentication-Results: relay.mimecast.com;
	auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=pabeni@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit

Hello,

On Wed, 2022-01-12 at 17:15 -0500, Kishen Maloor wrote:
> This change updates mptcp_pm_nl_create_listen_socket() to create
> listening sockets bound to IPv6 addresses (where IPv6 is supported).
> 
> Signed-off-by: Kishen Maloor <kishen.maloor@intel.com>
> ---
>  net/mptcp/pm_netlink.c | 8 ++++++--
>  1 file changed, 6 insertions(+), 2 deletions(-)
> 
> diff --git a/net/mptcp/pm_netlink.c b/net/mptcp/pm_netlink.c
> index 4c1895dbc2a5..779ec9d375f0 100644
> --- a/net/mptcp/pm_netlink.c
> +++ b/net/mptcp/pm_netlink.c
> @@ -986,6 +986,7 @@ static int mptcp_pm_nl_create_listen_socket(struct sock *sk,
>  					    struct mptcp_pm_addr_entry *entry,
>  					    struct socket **lsk)
>  {
> +	int addrlen = sizeof(struct sockaddr_in);
>  	struct sockaddr_storage addr;
>  	struct mptcp_sock *msk;
>  	struct socket *ssock;
> @@ -1010,8 +1011,11 @@ static int mptcp_pm_nl_create_listen_socket(struct sock *sk,
>  	}
>  
>  	mptcp_info2sockaddr(&entry->addr, &addr, entry->addr.family);
> -	err = kernel_bind(ssock, (struct sockaddr *)&addr,
> -			  sizeof(struct sockaddr_in));
> +#if IS_ENABLED(CONFIG_MPTCP_IPV6)
> +	if (entry->addr.family == AF_INET6)
> +		addrlen = sizeof(struct sockaddr_in6);
> +#endif
> +	err = kernel_bind(ssock, (struct sockaddr *)&addr, addrlen);
>  	if (err) {
>  		pr_warn("kernel_bind error, err=%d", err);
>  		goto out;

This looks a bugfix for -net to me?

Possibly worthy additional an additional mp_join self-test for the ipv6
case.

Thanks!

/P

