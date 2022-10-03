Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3913F192
	for <mptcp@lists.linux.dev>; Mon,  3 Oct 2022 08:31:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1664785866;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=IbUBE3sJXWYNCUZ7P8VjffRgsrVTrsthXI8lgHUA46M=;
	b=X9j0hq2jNaWEu3P4d+JTyDu4mn9c7AcAz94jgM2iwhVm1xmeB8qrsJYLqriPPiLoFwmFsi
	FeHK3VmmEpurMvYW1T499ZayEwSH+gdcFQ6WKeQQerjs+taJO5ONcN4d5HrE4UdVcmBdlJ
	22VN2933iZbgMMlx1xtj5rUnX9d2SgE=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-48-3-mRR7fGNya8sOCfQjByEw-1; Mon, 03 Oct 2022 04:31:05 -0400
X-MC-Unique: 3-mRR7fGNya8sOCfQjByEw-1
Received: by mail-wm1-f71.google.com with SMTP id e3-20020a05600c218300b003b4e4582006so2679847wme.6
        for <mptcp@lists.linux.dev>; Mon, 03 Oct 2022 01:31:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:user-agent:references
         :in-reply-to:date:to:from:subject:message-id:x-gm-message-state:from
         :to:cc:subject:date;
        bh=IbUBE3sJXWYNCUZ7P8VjffRgsrVTrsthXI8lgHUA46M=;
        b=fEfT8YHP3PClw2Q45BwueitLS5sa//JiIBjNAt03p4VUNc8k7tfL1eMtuA7zJ4xSwd
         sX29LJkPO8yyTiUHco6blW7tmTRbFWKv8JbrE8wcvL3e1/IwiNPQf4guI6EZta19BVyw
         ISk9LybSnI7N0lMEz1ISHcR/tYTG47yuDiVpvamGRM6ot2OWFAg6J52DUh+W+Rdo/thf
         r3IY72tJl2s52S/WWZkbTwSX5YCXvwmUJAGN2AKbtcK6ip7cCpOmV/fmWPn4G3nHLsak
         mRVWTHI0pMnaIcPYIK5id/Avhn2YiOSzIO2vXZEj5FTJX9kocvoBQftOdKhG/PkRRkta
         hqgQ==
X-Gm-Message-State: ACrzQf0l1UxT3cx/S2946iiBx5kY0bHSEK3LR5oGPNYdhLjuZqMeGeIb
	7w/+yCEJ7HHfOYYVN22awFufzv9p4bgmkVjj3j4v3lOdyKI0BSiir2diJK8Z5jWtFJvw+nzQJXt
	CQS1pWjE+MNVxORQ=
X-Received: by 2002:adf:ff8b:0:b0:22e:3608:d9f4 with SMTP id j11-20020adfff8b000000b0022e3608d9f4mr3309031wrr.221.1664785863982;
        Mon, 03 Oct 2022 01:31:03 -0700 (PDT)
X-Google-Smtp-Source: AMsMyM5/DH16MyiAmJxMxu/D7pyNajf97ZqdHVbyz9cJjPrsGyedeqTnpKWAR5PVkxjP7a6+Nm82Mw==
X-Received: by 2002:adf:ff8b:0:b0:22e:3608:d9f4 with SMTP id j11-20020adfff8b000000b0022e3608d9f4mr3309016wrr.221.1664785863738;
        Mon, 03 Oct 2022 01:31:03 -0700 (PDT)
Received: from gerbillo.redhat.com (146-241-97-71.dyn.eolo.it. [146.241.97.71])
        by smtp.gmail.com with ESMTPSA id h40-20020a05600c49a800b003b49ab8ff53sm10558639wmp.8.2022.10.03.01.31.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Oct 2022 01:31:03 -0700 (PDT)
Message-ID: <965056bb46f0d3172d5436889b0849c5795caef6.camel@redhat.com>
Subject: Re: [RFC PATCH mptcp-next v12 7/7] selftests: mptfo
 initiator/listener
From: Paolo Abeni <pabeni@redhat.com>
To: Dmytro Shytyi <dmytro@shytyi.net>, mptcp@lists.linux.dev
Date: Mon, 03 Oct 2022 10:31:02 +0200
In-Reply-To: <04007982-1066-5099-852e-580de8d3cf9c@shytyi.net>
References: <20220927225341.14165-1-dmytro@shytyi.net>
	 <20220927225341.14165-8-dmytro@shytyi.net>
	 <3ee71fb92a93914ab8c6bacc063731a1870d0a6e.camel@redhat.com>
	 <04007982-1066-5099-852e-580de8d3cf9c@shytyi.net>
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

On Sat, 2022-10-01 at 05:03 +0200, Dmytro Shytyi wrote:
> Thank you for this comment. I keep it in my notebook for the moment. I 
> will come back to tests, when I will see the proper result of Initiator 
> and Listener, if you don't mind?

Better self-tests will allow you to more easily validates your patches,
and a complete self-test is required for merging. I suggest to not
postpone this.

Thanks,

Paolo

p.s. to validate this code, thanks to Mat, there are a few packetdrill
available:

https://github.com/multipath-tcp/packetdrill/tree/mptcp-net-next/gtests/net/mptcp/fastopen

you just need to remote the '.TODO' suffix.

