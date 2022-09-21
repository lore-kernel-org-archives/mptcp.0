Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05DA08440
	for <mptcp@lists.linux.dev>; Wed, 21 Sep 2022 18:02:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1663783332;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=F5Xif7Qt3hEAXgYAx5zeoVTvOQfZkJFDLCimvuJIzDM=;
	b=et4YVTKrtKx6oc5u4OSO2euo3akMwmcSInaRx/i1k/0P3uJYOo0uAKHlT1ZAnJoa3pwXab
	3b2fLNFWgQ2YftJKVAtp+GF2LCzy0CcxWBNZofoHku1uDxrfp3gLUjCWP8vkdqW9dPMR4O
	7eXdXoTOg++a+B9f06nInwtejg61kKo=
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-594-w8ECHbiiMpS5cstgF8jUsw-1; Wed, 21 Sep 2022 14:02:11 -0400
X-MC-Unique: w8ECHbiiMpS5cstgF8jUsw-1
Received: by mail-qv1-f70.google.com with SMTP id ec8-20020ad44e68000000b004aab01f3eaaso4816614qvb.4
        for <mptcp@lists.linux.dev>; Wed, 21 Sep 2022 11:02:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:user-agent:references
         :in-reply-to:date:to:from:subject:message-id:x-gm-message-state:from
         :to:cc:subject:date;
        bh=F5Xif7Qt3hEAXgYAx5zeoVTvOQfZkJFDLCimvuJIzDM=;
        b=ME+88t+U2UceCFb9hNDmsvGhBYS+QD+VJnN85+igOWwJ9kEXlpa/MIquYvwVJ5JxPo
         HTespfPTMPYQ7MDzsbXjxt8yZKW3XRQ2GoWXRDP6l7B4NqywD3ThZS6vb6jK391ccfej
         P06+UZ7cwphcREVlWlCJoIHQygKVXnqpWLx6O/wbcds60vH7ZBuLSsjLTT92IzGXSSZT
         Apkw3kyA1OAEj5H26iGuygK2Hg7nfmyQjYBBS0+2wWwKLPn7dtzD1W3ALEUfi4E8pRG9
         CLE1Db7yJziS2EsOvW0b6wGcsf3Jk/MqJ7N8hp0tAyg+0wRxAPpRUselmKRocUrGII6n
         SraQ==
X-Gm-Message-State: ACrzQf0iBZyLT/ajt8zYHAHjdTnt6c40j2EU4mnBRtMf3O68SRvAGQKR
	WfKtHeJIUDHuLFL1jBBrd9FFPWM8hjgvUty+sGHQmbLSjgG5hFuNSdfikM8ierbiRAOO9hYzTDH
	Nomt7/apYJpRts6k=
X-Received: by 2002:ac8:7e92:0:b0:35c:bee6:bbfe with SMTP id w18-20020ac87e92000000b0035cbee6bbfemr24871318qtj.468.1663783330604;
        Wed, 21 Sep 2022 11:02:10 -0700 (PDT)
X-Google-Smtp-Source: AMsMyM51F9jyev7Mq++SiEj5PVY7St1WYQDJ74KJztUVeLLe374KH/+CHz9AAzZ7Hesy1gj3wltlVA==
X-Received: by 2002:ac8:7e92:0:b0:35c:bee6:bbfe with SMTP id w18-20020ac87e92000000b0035cbee6bbfemr24871250qtj.468.1663783329987;
        Wed, 21 Sep 2022 11:02:09 -0700 (PDT)
Received: from gerbillo.redhat.com (146-241-104-76.dyn.eolo.it. [146.241.104.76])
        by smtp.gmail.com with ESMTPSA id w12-20020a05620a444c00b006af1f0af045sm2297033qkp.107.2022.09.21.11.02.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Sep 2022 11:02:09 -0700 (PDT)
Message-ID: <3f896828c24c388e84c0f7577af3d24b55599e1d.camel@redhat.com>
Subject: Re: [RFC PATCH mptcp-next v9 4/6] mptcp: fix retrans., add mptfo
 vars to msk
From: Paolo Abeni <pabeni@redhat.com>
To: Dmytro Shytyi <dmytro@shytyi.net>, mptcp@lists.linux.dev
Date: Wed, 21 Sep 2022 20:02:07 +0200
In-Reply-To: <20220921125558.19483-5-dmytro@shytyi.net>
References: <20220921125558.19483-1-dmytro@shytyi.net>
	 <20220921125558.19483-5-dmytro@shytyi.net>
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

On Wed, 2022-09-21 at 14:55 +0200, Dmytro Shytyi wrote:
> We use mptcp_gen_msk_ackseq_fasopen()
> when we know this is the first chunk of data after MPTFO.
> Without it I observe infinite retransmissions.

The commit message should probably re-phrase to something more
descriptive. With fastopen in place the first subflow socket is created
before the MPC handshake completes, and we need to properly initialize
the sequence numbers at MPC ACK reception.

Thanks,

Paolo

