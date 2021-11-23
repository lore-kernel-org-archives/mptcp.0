Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1C9E2C94
	for <mptcp@lists.linux.dev>; Tue, 23 Nov 2021 12:21:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1637670084;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=SkGfjihagg1pro/zirY0RtasVnrzyeaOBrav6UvyYg0=;
	b=XAAC6A823GjIyT9kh8P07AXfzB+pUpP8S3J0Q4nO6izJLi2HwQCv0SkcDobx+NODgP9AJo
	9JA+uNYRZnSFirZSY84If4vDkMqn4wbtq0bRdu5y7GJoxZm23W/6VODMsPMCazix/yNZll
	PrIeXRQgDa48WPTru93OOaNEulOXzZA=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-444--dbbdkryMQGdTRK9FA-Z6A-1; Tue, 23 Nov 2021 07:21:21 -0500
X-MC-Unique: -dbbdkryMQGdTRK9FA-Z6A-1
Received: by mail-wm1-f70.google.com with SMTP id n16-20020a05600c3b9000b003331973fdbbso1452341wms.0
        for <mptcp@lists.linux.dev>; Tue, 23 Nov 2021 04:21:21 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:subject:from:to:date:in-reply-to
         :references:user-agent:mime-version:content-transfer-encoding;
        bh=SkGfjihagg1pro/zirY0RtasVnrzyeaOBrav6UvyYg0=;
        b=sERQsmveOP4u3FiFFEgKf9LgmAO5RbmKbHCEhAKVWL9d8ys1nORKKa0eKdwZUu1GJN
         Ec1krZc4hk7+Nvbc8kRKtpoAnbh/0v7Www0pirFXSkTFanZQmZvOYO2b51B4SsroVN4T
         pYRxU8tmE1EeHlqp6lb6hdljt3j6abkvdiBhDu2dpn5DtMDSr1dy+HZUIHlDO9/F9Mjl
         2sNdAqFyBHcnT0+mRKl7yow0T6HsVar1MvqWPwOONTnkA5iO9d9gDACDQ86YJQiebRpR
         65qC7erWI8A9ikTFbCFfWYLBDlXlF/9h6N6HAJ3PkYgMvmQ7O4sRq6FlDUPMTps+bDZ2
         Wv6g==
X-Gm-Message-State: AOAM533vJresBdy2lWFohDwduGumrKPv8eRHhKkAWQyUnSX9jhq+EN9u
	sIzI0AUKNm1uX/uZL2M0w/V8Y9JmkO08dWvFUevv88nC1K4T/EXsiypX5LpI5jV0jgGsl+pPCbY
	tm4d02On7AGnjCw8=
X-Received: by 2002:a5d:53cb:: with SMTP id a11mr6595057wrw.357.1637670080458;
        Tue, 23 Nov 2021 04:21:20 -0800 (PST)
X-Google-Smtp-Source: ABdhPJyB/MUs6JOY2QGSzYSasi6Eyph2kCrtpToiCIV9tZuShOUB5dvwzGdDlWMlSJYg+XtAiDgfmg==
X-Received: by 2002:a5d:53cb:: with SMTP id a11mr6595024wrw.357.1637670080170;
        Tue, 23 Nov 2021 04:21:20 -0800 (PST)
Received: from gerbillo.redhat.com (146-241-229-135.dyn.eolo.it. [146.241.229.135])
        by smtp.gmail.com with ESMTPSA id w17sm12075277wrp.79.2021.11.23.04.21.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Nov 2021 04:21:19 -0800 (PST)
Message-ID: <65424687fe3f108285b6b42669d28e61254349f1.camel@redhat.com>
Subject: Re: [PATCH mptcp-next 3/3] mptcp: support TCP_CORK and TCP_NODELAY
From: Paolo Abeni <pabeni@redhat.com>
To: Maxim Galaganov <max@internet.ru>, mptcp@lists.linux.dev
Date: Tue, 23 Nov 2021 13:21:19 +0100
In-Reply-To: <20211123070708.2897469-4-max@internet.ru>
References: <20211123070708.2897469-1-max@internet.ru>
	 <20211123070708.2897469-4-max@internet.ru>
User-Agent: Evolution 3.42.1 (3.42.1-1.fc35)
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

On Tue, 2021-11-23 at 10:07 +0300, Maxim Galaganov wrote:
> First, add cork and nodelay fields to the mptcp_sock structure
> so they can be used in sync_socket_options(), and fill them on setsockopt
> while holding the msk socket lock.
> 
> Then, on setsockopt set proper tcp_sk(ssk)->nonagle values for subflows
> by calling __tcp_sock_set_cork() or __tcp_sock_set_nodelay() on the ssk
> while holding the ssk socket lock.
> 
> tcp_push_pending_frames() will be invoked on the ssk if a cork was cleared
> or nodelay was set. Also set MPTCP_PUSH_PENDING bit by calling
> mptcp_check_and_set_pending(). This will lead to __mptcp_push_pending()
> being called inside mptcp_release_cb() with new tcp_sk(ssk)->nonagle.
> 
> Also add getsockopt support for TCP_CORK and TCP_NODELAY.
> 
> Signed-off-by: Maxim Galaganov <max@internet.ru>
> ---
> I've tested this by doing single-byte writes and looking at the length
> of packets in tcpdump, also this is now running on my tproxy setup.
> Enabling nodelay on a tproxy gave a decrease in latency to first byte
> and lead to improved user experience in web browsing and voip
> applications. Existing selftests run passed on a debug config, I'll add
> coverage for new sockopts once I grasp how to do it.
> 
> Should these bit fields have an explicit zero initializer? I've looked
> at recvmsg_inq and it doesn't seem to have one.

Newly created sockets are zeroed at creation time by sk_alloc(). Cloned
(accepted) sockets inherit the nodelay/cork status from the partent, as
expected.

No need to explicitly clear the fields in [__]mptcp_init_sock().

self-tests should be doable with pktdrill, see:

https://github.com/multipath-tcp/packetdrill/blob/mptcp-net-next/gtests/net/mptcp/sockopts/sockopt_set_ip_tos_valid_v4.pkt

Otherwise you could implement a simple mptcp client setting the cork
flag and doing e.g.
for (;;) { write(MTU/10); sleep (x); }

the peer should do:

	read(..., mtu);
	// mesure elapsed time since previous read
	// delta should be ~ x * 10


yep, is very rough!

As for this series: patches LGTM! many thanks for implementing this!

Acked-by: Paolo Abeni <pabeni@redhat.com>

