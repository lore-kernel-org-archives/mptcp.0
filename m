Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C48A510E8
	for <mptcp@lists.linux.dev>; Mon, 19 Dec 2022 08:28:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1671438523;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=+5AjBcdEuaady/SaoWtJSxUBiJOwyCY079sUVb52DnI=;
	b=eO83W7vyq/2QLh4TDXyfUfDDByhulxKMXnxGJKz7RATUB+pM0JN53R/tmZXboZhYZs5MC5
	01lRG6m5mOTMA7yhR34rzfS3z+w5xTy3rQF97nqrwG8P2QRTe9UHX3wZurk2lFsfAt4in2
	FEj5O0ILLaG/6Hu30XPMx9viRaSWAHk=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-274-JUSlVL4pN7qpESV_zTc-AQ-1; Mon, 19 Dec 2022 03:28:42 -0500
X-MC-Unique: JUSlVL4pN7qpESV_zTc-AQ-1
Received: by mail-wm1-f71.google.com with SMTP id j2-20020a05600c1c0200b003cf7397fc9bso4870296wms.5
        for <mptcp@lists.linux.dev>; Mon, 19 Dec 2022 00:28:42 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:user-agent:references
         :in-reply-to:date:to:from:subject:message-id:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=+5AjBcdEuaady/SaoWtJSxUBiJOwyCY079sUVb52DnI=;
        b=ZA5YeLM1hSXL0pXzBgpGFhHf32a38K/vU6yeZTZxPYg/j8Ct29oJyBXVMgSLSs/yL3
         vUeBqO3dE1cuJduffehneNCcdAPlQEVMgGWFLvBeo/TgMs+fZkR4X5CohRtX/cnNWj81
         f6rnFFP3C3h4oi7P1qYFUC42CGVsfRoRv6Hh6OHXnb9GgUPW6SNvKI61V4GVQCZk1jeO
         xJQ07GcnoxCEE7y7/Hah0bgA4cFejKdHRFvkQ0HvTMGtKKcMDAvZ+TJ4swfyd5Um04ta
         j54y8iODmVVsYyqRov5PROS1P3OQUnkyC3eKT6sgTfmToQRpr9jMliNN7EMNDY4q97K1
         VV1g==
X-Gm-Message-State: ANoB5pl2e8b8fmTdp1e4Dk0hI9b1Uj8nPPFasJ9j5FKV+JgrpYqGxyOd
	i45exW/Z2mwx1bmrChZgse4m6upSIIcS5+8pGIofTgy8GEsMqbAqKwVycUzuTU5uS5G+5CxyfdX
	IGdXh/YmfHbIECpuyJKo3HmH2FbIGRd8kj4bC0nyOzq3rSuoIz2ONhAeUr4hgIpII
X-Received: by 2002:a5d:4684:0:b0:242:a75:33f6 with SMTP id u4-20020a5d4684000000b002420a7533f6mr26601875wrq.61.1671438520745;
        Mon, 19 Dec 2022 00:28:40 -0800 (PST)
X-Google-Smtp-Source: AA0mqf4mUnMgRFnjaM7n8sa4rAGQqgZtGRn1aLLzijZ/WtTuUUtGhnjEdSa06CKazE30e7CLyGpM1A==
X-Received: by 2002:a5d:4684:0:b0:242:a75:33f6 with SMTP id u4-20020a5d4684000000b002420a7533f6mr26601866wrq.61.1671438520526;
        Mon, 19 Dec 2022 00:28:40 -0800 (PST)
Received: from gerbillo.redhat.com (146-241-101-173.dyn.eolo.it. [146.241.101.173])
        by smtp.gmail.com with ESMTPSA id g15-20020a5d554f000000b00241da0e018dsm9221456wrw.29.2022.12.19.00.28.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Dec 2022 00:28:40 -0800 (PST)
Message-ID: <eca5dbca69c0cdfa913b2428f9ce7dd8e37f39e1.camel@redhat.com>
Subject: Re: selftest: mptcp: add test for mptcp socket in use: Build Failure
From: Paolo Abeni <pabeni@redhat.com>
To: mptcp@lists.linux.dev, Menglong Dong <imagedong@tencent.com>
Date: Mon, 19 Dec 2022 09:28:38 +0100
In-Reply-To: <7c0f2c76-f259-b0d9-5156-2cee298a596b@gmail.com>
References: <20221219075048.255811-7-imagedong@tencent.com>
	 <7c0f2c76-f259-b0d9-5156-2cee298a596b@gmail.com>
User-Agent: Evolution 3.42.4 (3.42.4-2.fc35)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit

On Mon, 2022-12-19 at 08:08 +0000, MPTCP CI wrote:
> Hi Menglong,
> 
> Thank you for your modifications, that's great!
> 
> But sadly, our CI spotted some issues with it when trying to build it.
> 
> You can find more details there:
> 
>   https://patchwork.kernel.org/project/mptcp/patch/20221219075048.255811-7-imagedong@tencent.com/
>   https://github.com/multipath-tcp/mptcp_net-next/actions/runs/3729469771
> 
> Status: failure
> Initiator: MPTCPimporter
> Commits: https://github.com/multipath-tcp/mptcp_net-next/commits/93db6277a7d9
> 
> Feel free to reply to this email if you cannot access logs, if you need
> some support to fix the error, if this doesn't seem to be caused by your
> modifications or if the error is a false positive one.

The reported error is:

CC      net/mptcp/token.o
  net/mptcp/token.c:152: warning: Function parameter or member 'ssk' not described in 'mptcp_token_new_connect'
  net/mptcp/token.c:152: warning: Excess function parameter 'sk' description in 'mptcp_token_new_connect'

basically it means you should additionally update the doctext for
mptcp_token_new_connect(), renaming sk as ssk even there.

Cheers,

Paolo

