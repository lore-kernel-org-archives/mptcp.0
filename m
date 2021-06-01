Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BD8871
	for <mptcp@lists.linux.dev>; Tue,  1 Jun 2021 14:28:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1622557734;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=qAMIUdAYaPM4LJXuHv3YVvYO0YZK5mQjkyBlsnfyhug=;
	b=DF/R9MYaVsOCgQccODa++Gz9G7vGVjLZbOushhInv7uAgT0I7MPLrlnhZCHsV7/X0ZrW2r
	QHNvmpXg8FqX1ZS66S4qYW1M/UZQ1vMmNSA1jqh22Suui819rcksuzsArAuszSptyZPXLI
	LLNIH9KKsNGo9V/jq9GELpEd3m7U0oc=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-286-_gfohX3yOtm_xmZPgIL8eQ-1; Tue, 01 Jun 2021 10:28:52 -0400
X-MC-Unique: _gfohX3yOtm_xmZPgIL8eQ-1
Received: by mail-wm1-f71.google.com with SMTP id z25-20020a1c4c190000b029019f15b0657dso581260wmf.8
        for <mptcp@lists.linux.dev>; Tue, 01 Jun 2021 07:28:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:user-agent:mime-version:content-transfer-encoding;
        bh=qAMIUdAYaPM4LJXuHv3YVvYO0YZK5mQjkyBlsnfyhug=;
        b=VoEA3KGxJ/Ef3Ib4YYN6l6IdWkybIDATZAPzOK6s3xna5pSBZf0TcLrWRw5CLYOgcs
         ci3waftKBaLxxWZTpokCJESlsHSZ13E19u7ErusHQPiwiIuRlSTRxiEDv+lNMGtHFnZA
         c5Vext9IyaxJJXOi9Yw44V2ukhPs0z1s/cYV18Tc30bUUsWGWoOINdZ41ZyMww9GR6C3
         JshnHAJD13tpWAYC6b/3SP1algCLTRjHE3uOKzeVfKnTrmwMCAacQ6N7Oecogi3RHiuB
         BI53BY8D8Qf9yll1qrH/Lv9Kah+a8ruZghmoUSB7WMGOfP4jzubipjDcH2gtX+d0LRVh
         D2UQ==
X-Gm-Message-State: AOAM530i5hq0Ori/muEKvyZNiTtQz6EqCMvOR+yhRmmsWoDj8x1jxfl4
	meAJs1t/vXsACtwS5r8Th8V7X6AUn4cXDe+CKHKknc5CTUicQYEcymySflUNSB7Gskc5eFAfnh6
	KQu0cfHDDrOaDmpD+EL3ZeB9tq5SIdLNuvmpohqPXNsxlGTbR7XQt8Kgj5fK5Fmh3
X-Received: by 2002:a1c:f202:: with SMTP id s2mr26183725wmc.66.1622557731604;
        Tue, 01 Jun 2021 07:28:51 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJydvTlZ1h6zIutrpmFcmd1hcWVkU6aF11TztfVuY0jnEGDCMBz+pXFsRPqXhoZ5PFz0lizWNA==
X-Received: by 2002:a1c:f202:: with SMTP id s2mr26183708wmc.66.1622557731356;
        Tue, 01 Jun 2021 07:28:51 -0700 (PDT)
Received: from gerbillo.redhat.com (146-241-110-123.dyn.eolo.it. [146.241.110.123])
        by smtp.gmail.com with ESMTPSA id f20sm22209614wmh.41.2021.06.01.07.28.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Jun 2021 07:28:51 -0700 (PDT)
Message-ID: <f91ca8f2d0e417ae75e304797072a4c0d3fcee77.camel@redhat.com>
Subject: Re: [PATCH mptcp-net] mptcp: fix soft lookup in
 subflow_error_report().
From: Paolo Abeni <pabeni@redhat.com>
To: mptcp@lists.linux.dev
Cc: max@internet.ru
Date: Tue, 01 Jun 2021 16:28:50 +0200
In-Reply-To: <1ff9487ec87d1ca5cbd32ea40b079099bfeedc06.1622555451.git.pabeni@redhat.com>
References: <1ff9487ec87d1ca5cbd32ea40b079099bfeedc06.1622555451.git.pabeni@redhat.com>
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

On Tue, 2021-06-01 at 15:51 +0200, Paolo Abeni wrote:
> @@ -1603,6 +1604,8 @@ static void subflow_state_change(struct sock *sk)
>  	 */
>  	if (mptcp_subflow_data_available(sk))
>  		mptcp_data_ready(parent, sk);
> +	else if (sk->sk_err)
> +		subflow_error_report(sk);

whoops, I forgot to add an 'unlikely()' annotation above. Will do in
v2.

Thanks,

Paolo

