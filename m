Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [216.205.24.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 994A670
	for <mptcp@lists.linux.dev>; Wed,  9 Jun 2021 14:24:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1623248641;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=d2TV2ziNRW6dJg4SEyAeXc5GthPBrVaopoR8TjCTuX0=;
	b=fy9QTu8hiTU248LI0S09G1NeQmbSsEYzPapl+M/g63opdnj9qsOwEEHIkQ4te+MbDnkCQe
	/EzinNcVmZegTu43IUA4f3q8gzOgWkNQaH9/YkUgz64aAQJPD9kfnWcXwWpuKYtFE8b3B/
	O9uqlr3dihYU/3ZWoiayMtJhQnlSaXY=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-11-2UJuODFyMuqvjsQkAIEg-Q-1; Wed, 09 Jun 2021 10:23:59 -0400
X-MC-Unique: 2UJuODFyMuqvjsQkAIEg-Q-1
Received: by mail-wm1-f71.google.com with SMTP id k8-20020a05600c1c88b02901b7134fb829so477095wms.5
        for <mptcp@lists.linux.dev>; Wed, 09 Jun 2021 07:23:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:user-agent:mime-version:content-transfer-encoding;
        bh=d2TV2ziNRW6dJg4SEyAeXc5GthPBrVaopoR8TjCTuX0=;
        b=tTbHBgexA6rLWxymeHcMNJGxBYerXiaRG41uYw19+GbpnYL2fvyq7fAHgSrxIKDXU5
         BLD7kPa8KV9qwNRV+n0VwCT0SouPfwcP2hjwYSzgjpQ+6kuRYdhr6r8QNnB8t8+Rxs+n
         vT8wMv7+cgaWAjeh3438EMR8FEfhoWQW33iySLaeIfcv7RcJqOXRvJshGn1CTngIkoNC
         kmZTmj5oP3+0ULk2Wu23wZ0A2v4Ri4rQUg4F6DYG29Q3OgWK0dDKvd7brcUV3nDWzOL+
         NWnqMHcEWY9Q+WYDisp+1ZHFIGQDqqqLibYjeizK/alpQBQStQZ8wFx1/tGAciUUl9OL
         5YSA==
X-Gm-Message-State: AOAM530abMz4JJdb8DqOQB8FCbOT5/D3BkKu7m9udiOJXRymuAfjtLwv
	uMZC2ScGen5DGbOU1RtAu3NrP9TSzTG0sw7FZyjD/mg5IjQ3D0ilv2NPOkJJsN+lLidJyNCuP7L
	UdIwSBiqMVKa7Kxc=
X-Received: by 2002:a1c:808c:: with SMTP id b134mr10263620wmd.187.1623248637782;
        Wed, 09 Jun 2021 07:23:57 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJx5BKPYWzsdayGV4lOsRyQgKff3CisB3GHkHOJVYTGh7RYGS5yrN5OIgy0oCcI8qEHRLqAqOg==
X-Received: by 2002:a1c:808c:: with SMTP id b134mr10263519wmd.187.1623248636550;
        Wed, 09 Jun 2021 07:23:56 -0700 (PDT)
Received: from gerbillo.redhat.com (146-241-109-224.dyn.eolo.it. [146.241.109.224])
        by smtp.gmail.com with ESMTPSA id 89sm110562wrq.14.2021.06.09.07.23.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Jun 2021 07:23:56 -0700 (PDT)
Message-ID: <c23b378662b4036a1c3fca3ac994970fd503875f.camel@redhat.com>
Subject: Re: [PATCH 2/3] mptcp: remove redundant req destruct in
 subflow_check_req()
From: Paolo Abeni <pabeni@redhat.com>
To: Jianguo Wu <wujianguo106@163.com>, mptcp@lists.linux.dev
Cc: Geliang Tang <geliangtang@gmail.com>
Date: Wed, 09 Jun 2021 16:23:55 +0200
In-Reply-To: <6747dc58-0dbf-b4d3-e084-85816ad5caec@163.com>
References: <6747dc58-0dbf-b4d3-e084-85816ad5caec@163.com>
User-Agent: Evolution 3.36.5 (3.36.5-2.fc32)
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

On Wed, 2021-06-09 at 18:39 +0800, Jianguo Wu wrote:
> From: Jianguo Wu <wujianguo@chinatelecom.cn>
> 
> In subflow_check_req(), if subflow sport is mismatch, will put msk,
> destroy token, and destruct req, then return -EPERM, which can be
> done by subflow_req_destructor() via:
>   tcp_conn_request()
>     |--__reqsk_free()
>       |--subflow_req_destructor()
> So we should remove these redundant code, otherwise will call tcp_v4_reqsk_destructor()
> twice, and may double free inet_rsk(req)->ireq_opt.

_if_ I read the above correctly, there is no duplicated test, we should
just drop the destructor invocation otherwise we could not enforce the
sport check?!? am I missing something?!?

> Fixes: 5bc56388c74f ("mptcp: add port number check for MP_JOIN")
> Signed-off-by: Jianguo Wu <wujianguo@chinatelecom.cn>
> ---
>  net/mptcp/subflow.c | 5 -----
>  1 file changed, 5 deletions(-)
> 
> diff --git a/net/mptcp/subflow.c b/net/mptcp/subflow.c
> index 6b1cd42..75ed530 100644
> --- a/net/mptcp/subflow.c
> +++ b/net/mptcp/subflow.c
> @@ -213,11 +213,6 @@ static int subflow_check_req(struct request_sock *req,
>  				 ntohs(inet_sk(sk_listener)->inet_sport),
>  				 ntohs(inet_sk((struct sock *)subflow_req->msk)->inet_sport));
>  			if (!mptcp_pm_sport_in_anno_list(subflow_req->msk, sk_listener)) {


> -				sock_put((struct sock *)subflow_req->msk);
> -				mptcp_token_destroy_request(req);
> -				tcp_request_sock_ops.destructor(req);

I mean: we just need to drop the above line.

> -				subflow_req->msk = NULL;
> -				subflow_req->mp_join = 0;
>  				SUBFLOW_REQ_INC_STATS(req, MPTCP_MIB_MISMATCHPORTSYNRX);
>  				return -EPERM;
>  			}

