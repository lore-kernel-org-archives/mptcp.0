Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [216.205.24.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50F3070
	for <mptcp@lists.linux.dev>; Tue, 27 Jul 2021 09:51:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1627379468;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=unmjP2CFNwUlDFAKlcjUymuLEXT1j9JvHovTOb1pHs0=;
	b=PLQxrNwRDBCSE7KuxBL5pA0gTGsBE98uemh3LxNo2m8IO2/E5S5RuYDazLXbb1gWHj04D5
	mP0RsAPp58m8E3DQx6WzTurLeXoCM1SZkhZa0QkhuenDtpfYfOMV1i9DZBxfhDoIqlmDW0
	uzz7g2FhRuRA8F4WXtS6+GYa0u6t9TM=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-423-3eyMQJc1MKquL642yCOCZg-1; Tue, 27 Jul 2021 05:51:06 -0400
X-MC-Unique: 3eyMQJc1MKquL642yCOCZg-1
Received: by mail-wm1-f70.google.com with SMTP id n17-20020a7bc5d10000b0290228d7e174f1so927944wmk.0
        for <mptcp@lists.linux.dev>; Tue, 27 Jul 2021 02:51:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:user-agent:mime-version:content-transfer-encoding;
        bh=unmjP2CFNwUlDFAKlcjUymuLEXT1j9JvHovTOb1pHs0=;
        b=BouSUGKfTuhr5A1M6uTZal/oEVTW16yWpYPy+qp5nQqGXBbSnq+7t1K1ZsWRveRt+s
         pb3zRQRHjR5QRnet2bJm3XDcvyXA9pnQavgl6o26cil77HJcktEGT3enhCyJgstgKidx
         xeaK7yHOSmJ8ewnVpB1VGUJGlQil/Hojbm1+ZrBB7/roejWp/lFcgGNoItWbNB8eqDj0
         yWSJvRV/MT0vysRGNtSfmBmLQ+HqaRj0VcNHoLYhSVcqnZ53wJuZe8I5N2WFZRtAMOWx
         ar599Q1b2SVI+OHIm3yBB9Nf0wtcTlUOCAftdmUSNs2aLhhlvlFHn2QNcoLvNZ6E4e14
         /ZjA==
X-Gm-Message-State: AOAM532w0ODYvKJ1ZmHsN3x7aR4FomrAsRPDwd8aWEZ/QbRZsHxCvXCR
	NGLp88vFi+u7NW/0ponuqPBgwAln2UOadA5ibIRSxWpBgIhWN+srvrFnsKGq0FzSmPwsPVW4Gqz
	rye24EFfJfM1yYGc=
X-Received: by 2002:a05:600c:21c2:: with SMTP id x2mr13779922wmj.61.1627379465841;
        Tue, 27 Jul 2021 02:51:05 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyZB2fZ5xk++Bx+rG02/+VKs6npR1Q1zIuVIBkoBPICvxFdL/+TCv223FvJ2gIyG1UbS0c+sw==
X-Received: by 2002:a05:600c:21c2:: with SMTP id x2mr13779914wmj.61.1627379465656;
        Tue, 27 Jul 2021 02:51:05 -0700 (PDT)
Received: from gerbillo.redhat.com (146-241-97-57.dyn.eolo.it. [146.241.97.57])
        by smtp.gmail.com with ESMTPSA id l2sm2131635wms.21.2021.07.27.02.51.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Jul 2021 02:51:05 -0700 (PDT)
Message-ID: <9c137e22c92b4756f3e743a7ab7fc0c37bad57f2.camel@redhat.com>
Subject: Re: [MPTCP][PATCH v5 mptcp-next 1/5] mptcp: remote addresses
 fullmesh
From: Paolo Abeni <pabeni@redhat.com>
To: Geliang Tang <geliangtang@gmail.com>, mptcp@lists.linux.dev
Cc: Geliang Tang <geliangtang@xiaomi.com>
Date: Tue, 27 Jul 2021 11:51:04 +0200
In-Reply-To: <b8af3a77da2fcd8e16e8b5d6b63c7c8386abcbac.1627372396.git.geliangtang@xiaomi.com>
References: <cover.1627372396.git.geliangtang@xiaomi.com>
	 <b8af3a77da2fcd8e16e8b5d6b63c7c8386abcbac.1627372396.git.geliangtang@xiaomi.com>
User-Agent: Evolution 3.36.5 (3.36.5-2.fc32)
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


I'm sorry for the partial feedback so far, I noticed more things
looking at the following patches. Again, I'm sorry!

On Tue, 2021-07-27 at 15:58 +0800, Geliang Tang wrote:
> +static bool lookup_subflow_by_addrs(const struct list_head *list,
> +				    struct mptcp_addr_info *saddr,
> +				    struct mptcp_addr_info *daddr)
> +{

both 'saddr' and 'daddr' could be 'const', I think.

> +	struct mptcp_subflow_context *subflow;
> +	struct mptcp_addr_info local, remote;
> +	struct sock_common *skc;
> +
> +	list_for_each_entry(subflow, list, node) {
> +		skc = (struct sock_common *)mptcp_subflow_tcp_sock(subflow);
> +
> +		local_address(skc, &local);
> +		remote_address(skc, &remote);
> +		if (addresses_equal(&local, saddr, saddr->port) &&
> +		    addresses_equal(&remote, daddr, daddr->port))
> +			return true;
> +	}
> +
> +	return false;
> +}
> +
>  static struct mptcp_pm_addr_entry *
>  select_local_address(const struct pm_nl_pernet *pernet,
>  		     struct mptcp_sock *msk)
> @@ -410,6 +431,53 @@ void mptcp_pm_free_anno_list(struct mptcp_sock *msk)
>  	}
>  }
>  
> +static bool lookup_address_in_vec(struct mptcp_addr_info *addrs, unsigned int nr,
> +				  struct mptcp_addr_info *addr)

'addr' could be 'const', I think.

> +{
> +	int i;
> +
> +	for (i = 0; i < nr; i++) {
> +		if (addresses_equal(&addrs[i], addr, addr->port))
> +			return true;
> +	}
> +
> +	return false;
> +}
> +
> +static unsigned int fill_remote_addresses_vec(struct mptcp_sock *msk,
> +					      struct mptcp_pm_addr_entry *local,
> +					      struct mptcp_addr_info *addrs)
> +{

'local' could be 'const', I think.

hopefully no more comments on this patch ;)

Cheers,

Paolo

