Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 371A76105
	for <mptcp@lists.linux.dev>; Mon, 19 Sep 2022 14:11:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1663596696;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=m+pbJgWeaqDYxJPNCyzOzQ6jJxZNrpBjI70m795d0q4=;
	b=RSqNruVZThR95SCCqJpb7kVigHST3j7epoti2sS5rIcm49ifOJTZgf/6vsHLPkjAY0WSmq
	ri5yGMk3Z+IwYzecOZEBYZGUfM6E6w2oHiP293QP8CToA295xROGr2odM9XR6XRSlKgXPP
	jfrtmxKUww/T5QmTNwaDSYcIAG2g4k0=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-149-5dLyHfIuNBCyK5LTKw3Row-1; Mon, 19 Sep 2022 10:11:35 -0400
X-MC-Unique: 5dLyHfIuNBCyK5LTKw3Row-1
Received: by mail-wm1-f72.google.com with SMTP id i129-20020a1c3b87000000b003b33e6160bdso4706798wma.7
        for <mptcp@lists.linux.dev>; Mon, 19 Sep 2022 07:11:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:user-agent:references
         :in-reply-to:date:to:from:subject:message-id:x-gm-message-state:from
         :to:cc:subject:date;
        bh=m+pbJgWeaqDYxJPNCyzOzQ6jJxZNrpBjI70m795d0q4=;
        b=rsQ5i9+zIY0FIjI5Sy/Foj7woafQNugLsaOcXa4KO74rV/Sn/6+6Rr5BpzMArkMApF
         EJK5HuCCmNkSTNGtGD8QNhw1EcycnOVZJsXUTIsWqcdewK48K+2ytlNHvc1tlsP3uPcR
         l31ocdpzDPICAKLvP/M66qkjjHgVJh/bEA8zkoEzQOS6pZYroOYyyMx3i3QmJZxifGwv
         j1c/AxhV8OCJYuDd/4zLgUAjRlkT1lAIlkz8/orOTKXq9FQHApjrh3HhnyKq9c1OUtha
         H2Dw8C0gNz/FYJSpvBOJcMOJpibEepAZUFHb9EBpsMS5M//cu5S6PSLEgzFH6B0nZv5K
         u9UA==
X-Gm-Message-State: ACrzQf2JySFZk+qLn4s8yR9Yt+MuWT6pfRHu1kkBso1vnMVjCAIZniZh
	vlXh0THdvQPDUgEYaTHNW/lhucgL3Z7pAYAHlAMI67LJrJX8vRTbQc7M2TXirVZJNpWq4mpoG8A
	PxgR4fNW0o5i04FQ=
X-Received: by 2002:adf:fe89:0:b0:228:62f7:3e75 with SMTP id l9-20020adffe89000000b0022862f73e75mr10476624wrr.400.1663596693801;
        Mon, 19 Sep 2022 07:11:33 -0700 (PDT)
X-Google-Smtp-Source: AMsMyM5wUeZC60EkL3hwEZ4b7Zckt2PssuCG0tPlVAJhGyON1HHhvuDsjIcYVFARbYFd31OYbSMj4g==
X-Received: by 2002:adf:fe89:0:b0:228:62f7:3e75 with SMTP id l9-20020adffe89000000b0022862f73e75mr10476613wrr.400.1663596693608;
        Mon, 19 Sep 2022 07:11:33 -0700 (PDT)
Received: from gerbillo.redhat.com (146-241-114-90.dyn.eolo.it. [146.241.114.90])
        by smtp.gmail.com with ESMTPSA id z3-20020adff1c3000000b0022af9555669sm6261215wro.99.2022.09.19.07.11.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Sep 2022 07:11:33 -0700 (PDT)
Message-ID: <6d480f33f953566aeeb7387e1b023c6783e294ce.camel@redhat.com>
Subject: Re: [RFC PATCH mptcp-next v7 11/11] selftests: mptfo
 initiator/listener
From: Paolo Abeni <pabeni@redhat.com>
To: Dmytro Shytyi <dmytro@shytyi.net>, mptcp@lists.linux.dev
Date: Mon, 19 Sep 2022 16:11:32 +0200
In-Reply-To: <20220917222853.2406-12-dmytro@shytyi.net>
References: <20220917222853.2406-1-dmytro@shytyi.net>
	 <20220917222853.2406-12-dmytro@shytyi.net>
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

On Sun, 2022-09-18 at 00:28 +0200, Dmytro Shytyi wrote:
> MPTFO tests: these are examples of initiator (sendto) and listener,
> probably are going to be integrated to the mptcp_connect.* selftests

I know I'm contradiction myself once again, but I think it would be
better adding support for the TCP_FASTOPEN flag in tcp_connect.c

Probably we want to add additional MIBs for the egress and incoming TFO
counters (likely a separate patch) and check them in the relevant test-
case.

Cheers,

Paolo

