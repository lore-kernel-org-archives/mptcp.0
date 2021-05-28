Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [216.205.24.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C3192FB4
	for <mptcp@lists.linux.dev>; Fri, 28 May 2021 15:19:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1622215142;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=/3Qp5vTjTabZI1CA4QEBjlisDDf/OYPDGt+D/TgLt54=;
	b=ENONecfAWT8+N8K+cNmgOsYfYjQfDt6smgZriZpXmBvk8xYz3kaF3p9oW8UGkbowetNNfJ
	Q9KKLYe45KUz39vBVXR8SrIT6Qba8Rk3MeUjJLu3lAbDcZdqFDrImIpcaXU30/WI2mp41M
	nCM9VAqRafLsmExz2seOTnk34VAL1nc=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-13-tPLVnEWTOD6TNupw0EQ_Yw-1; Fri, 28 May 2021 11:18:59 -0400
X-MC-Unique: tPLVnEWTOD6TNupw0EQ_Yw-1
Received: by mail-wm1-f71.google.com with SMTP id h129-20020a1c21870000b02901743c9f70b9so1187237wmh.6
        for <mptcp@lists.linux.dev>; Fri, 28 May 2021 08:18:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:user-agent:mime-version:content-transfer-encoding;
        bh=/3Qp5vTjTabZI1CA4QEBjlisDDf/OYPDGt+D/TgLt54=;
        b=ZzHqddRfWaHW7FTK48pJobie7mhacdryyg4LzDdpyjPkOYLztckVNv62FcdZod4d6x
         U8Bl1vTcj9uUitaU28grOeGXhxwSVn7cczOiEb5dTk4MqLbZ3Jh3+kKn3ZGUNLt4OOXR
         FvzUvago2R1rvY2IKpefItbrec9nvUFWs5V/6Z6vhFTMoAP6VJLnHZ52QIlRp+KLMjl6
         H+wR+CnRa3SBhKO/6xHesV2HmHRSKAWs3LEoUEjOszTKIG9FW2B8R6q7tXlZ4vq1PNL1
         +C8OhZG5Oe03rqvpycYktWcSEn9lencJdD6lRESuPyL7DId78Aktt/0VO9Iy8cpEmbES
         iK8A==
X-Gm-Message-State: AOAM531XwCP0b4K6T+8NoVtKjcTokofrpzv91HJVjhtYSqwvlhDaSUtE
	UulmoVn21KJt/Lgkr8Ui/4vcIVGU0F67btF9pNZSqwfxrieWKs3FVMl4errGe3zx47vIFGPtmqG
	fzV5kGHF7ZFGB6ACN4EOck0BrEqrST/kLzkbDdd+GGLYg4fIn7XjqQzR74lP6lWJY
X-Received: by 2002:adf:ed52:: with SMTP id u18mr9163720wro.379.1622215137889;
        Fri, 28 May 2021 08:18:57 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzzP7O4I9W0b033wsoWTQheuBSL1ALRW7+a4AwsXeEvsIUwAj08zgiye9Ojs0tlVMqUbtmTJA==
X-Received: by 2002:adf:ed52:: with SMTP id u18mr9163696wro.379.1622215137629;
        Fri, 28 May 2021 08:18:57 -0700 (PDT)
Received: from gerbillo.redhat.com (146-241-110-123.dyn.eolo.it. [146.241.110.123])
        by smtp.gmail.com with ESMTPSA id m5sm13393906wmq.6.2021.05.28.08.18.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 May 2021 08:18:57 -0700 (PDT)
Message-ID: <9af85be18465b0f9595459764013568456453ce9.camel@redhat.com>
Subject: Re: [RFC PATCH 0/4] mptcp: just another receive path refactor
From: Paolo Abeni <pabeni@redhat.com>
To: mptcp@lists.linux.dev
Cc: fwestpha@redhat.com
Date: Fri, 28 May 2021 17:18:55 +0200
In-Reply-To: <cover.1621963632.git.pabeni@redhat.com>
References: <cover.1621963632.git.pabeni@redhat.com>
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

On Tue, 2021-05-25 at 19:37 +0200, Paolo Abeni wrote:
> This could have some negative performance effects, as on average more
> locking is required for each packet. I'm doing some perf test and will
> report the results.

There are several different possible scenarios:

1) single subflow, ksoftirq && user-space process run on the same CPU
2) multiple subflows, ksoftirqs && user-space process run on the same
CPU
3) single subflow, ksoftirq && user-space process run on different CPUs
4) multiple subflows ksoftirqs && user-space process run on different
CPUs

With a single subflow, the most common scenario is with ksoftirq &&
user-space process run on the same CPU. With multiple subflows on
resonable server H/W we should likley observe a more mixed situation:
softirqs running on multiple CPUs, one of them also hosting the user-
space process. I don't have data for that yet.

The figures:

scenario	export branch 		RX path refactor	delta
1)		23Mbps			21Mbps			-8%
2)		30Mbps			19Mbps			-37%
3)		17.8Mbps		17.5Mbps		noise range
4)		1-3Mbps			1-3Mbps			???

The last scenario outlined a bug, we likely don't send MPTCP level ACK
frequently enough under some condition. That *could* possibly be
related to:

https://github.com/multipath-tcp/mptcp_net-next/issues/137

but I'm unsure about that.

The delta in scenario 2) is quite significant.

The root cause is that in such scenario the user-space process is the
bottle-neck: it keeps a CPU fully busy, spending most of the available
cycles memcpying the data into the user-space. 

With the current export branch, the skbs movement/enqueuing happens
completely inside the ksoftirqd processes.

On top the RX path refactor, some skbs handling is peformed by the
mptcp_release_cb() inside the scope of the user-space process. That
reduces the number of CPU cycles available for memcpying the data and
thus reduces also the overall tput.

I experimented with a different approach - e.g. keeping the skbs
accounted to the incoming subflows - but that looks not feasible.

Input wanted: WDYT of the above?

Thanks!

Paolo

