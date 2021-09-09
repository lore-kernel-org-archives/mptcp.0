Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE3803FE9
	for <mptcp@lists.linux.dev>; Thu,  9 Sep 2021 14:23:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1631197389;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=rT5gnKCoLzHrALZA8CNA3DJEkpQyDOYloGIgALucYC8=;
	b=WeeArWr+vzPo201JgdsLkKG5RfewvS51UABWL3+CBr5yrFGoy4NQkNv7e7DaW8f8RCFo/I
	GW6KV9a+tSC6vOaF5uZHVVxiSvOEBOdgWsdAB+zaWqP2+ZkjcR07uzWNuq5VWU9LuRxNDN
	UbteWxOOh1PrGxwvOqhXhJY8+KUZbZM=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-15-_ZqkvwXtOq28P3P12ZUpCQ-1; Thu, 09 Sep 2021 10:23:08 -0400
X-MC-Unique: _ZqkvwXtOq28P3P12ZUpCQ-1
Received: by mail-wm1-f70.google.com with SMTP id v2-20020a7bcb420000b02902e6b108fcf1so930643wmj.8
        for <mptcp@lists.linux.dev>; Thu, 09 Sep 2021 07:23:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:user-agent:mime-version:content-transfer-encoding;
        bh=rT5gnKCoLzHrALZA8CNA3DJEkpQyDOYloGIgALucYC8=;
        b=KAMzyipIMjGjNfVYUV47uEc/mCLX2LWXtl3D3s/nKQUbTNEMv8IGLQs6c+yK1CV2Ix
         ANTlF75mzOX20Uu4LWguMHrTUgcnmiIU0MHUt2/oHHJnL4N1AzrXjV+mQrE94OCSSGAR
         9dCP4yffVkhpb3JWGXv5bEUpcd9cmMtnCj7LRFxPbCv5/jIA50IOSG1vX/2dwcQnfDWy
         UGwwon3pnNCt2QzYXDF9NssfHawy3JFsk2B59K2zVPK/JFTC9SC0tPXfr3QkG8iXdlY9
         HxsaCGJkIMGjtMmTJQhX1DqcJYa7a3TPiLQRX4lB1io00eLhPY7fnSjCgeLlXuAF3bkB
         RrOQ==
X-Gm-Message-State: AOAM532q1/E9w8M/uY0MSzcvEOfH7hZsokqmNLeeclLLbBThdSPAPEjA
	7Kzc7BLkkU3NMMJkFlZ9Z2kcqzpoewbGPiQzQaNagCOWjtIE1DQP3Z2kXz+2mHeSnTUyMaUFkvY
	Qn6nWCaWmjA7Us+A=
X-Received: by 2002:a1c:ed10:: with SMTP id l16mr3287939wmh.8.1631197387324;
        Thu, 09 Sep 2021 07:23:07 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJz4G8qOzOrqjADoQTOnFB8hmBlkTt0M8ul+sUavnnfba0xz2raGhl9gpgQBCRcDm3Bk8AS3BA==
X-Received: by 2002:a1c:ed10:: with SMTP id l16mr3287924wmh.8.1631197387128;
        Thu, 09 Sep 2021 07:23:07 -0700 (PDT)
Received: from gerbillo.redhat.com (146-241-241-2.dyn.eolo.it. [146.241.241.2])
        by smtp.gmail.com with ESMTPSA id g5sm1904854wrq.80.2021.09.09.07.23.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Sep 2021 07:23:06 -0700 (PDT)
Message-ID: <3a1f4fdab51c7b451fe05a76f181853237774500.camel@redhat.com>
Subject: Re: [PATCH mptcp-next v2 9/9] DO-NOT-MERGE: mptcp: mp_fail test
From: Paolo Abeni <pabeni@redhat.com>
To: Geliang Tang <geliangtang@gmail.com>, mptcp@lists.linux.dev
Cc: Geliang Tang <geliangtang@xiaomi.com>
Date: Thu, 09 Sep 2021 16:23:05 +0200
In-Reply-To: <5afb788b507a63f31f390c512fb5eedb464dd01e.1631188109.git.geliangtang@xiaomi.com>
References: <cover.1631188109.git.geliangtang@xiaomi.com>
	 <5afb788b507a63f31f390c512fb5eedb464dd01e.1631188109.git.geliangtang@xiaomi.com>
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

On Thu, 2021-09-09 at 19:51 +0800, Geliang Tang wrote:
> From: Geliang Tang <geliangtang@xiaomi.com>
> 
> ./mptcp_join.sh -Cf
> 
> Signed-off-by: Geliang Tang <geliangtang@xiaomi.com>

I'm wondering if we could use the u32 target to replace all the TCP
options with u32 if find a DSS (tcp header len == 38, IIRC) and the DSS
len is not zero (checking 2 bytes at a fixed offset).

That will corrupt che tcp csum, but IIRC the csum is not really checked
over veth with default nic config.

/P

