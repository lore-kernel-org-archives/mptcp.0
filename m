Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7202272
	for <mptcp@lists.linux.dev>; Mon, 26 Jul 2021 09:21:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1627291301;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=vnuCcsDkh4y3q4nFxpWndWK4F4NCkZeybVPY0tXOQp8=;
	b=gQU8d65HMQc97p4GF+iK6sCki4f9G/O70mwx8Ip5WIRDk8e7ccMdGfj7aErGTu4iiytf1t
	hWn1CoSEO9NrfYdt4NSAKQXkPCmV3Em4e3Z5uD08E8Q+Wn4InPLR0927e1kBtTf49FFxgo
	xb/SRIvpKIlmagxTWvPKzA0O19HvgKM=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-412-9YnQxIdiMVGZynpWZyXbIA-1; Mon, 26 Jul 2021 05:21:39 -0400
X-MC-Unique: 9YnQxIdiMVGZynpWZyXbIA-1
Received: by mail-wm1-f69.google.com with SMTP id a1-20020a7bc1c10000b0290225338d8f53so2919159wmj.8
        for <mptcp@lists.linux.dev>; Mon, 26 Jul 2021 02:21:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:user-agent:mime-version:content-transfer-encoding;
        bh=vnuCcsDkh4y3q4nFxpWndWK4F4NCkZeybVPY0tXOQp8=;
        b=MxTuwXFLxNkoswgex1Rx/L75iiKjh7/cR7lrKZO1yeZs80jMSJuTlUjSSdBrwinYlp
         oU4pONrtkp5SeqP79swh9QRWNk/YrUEK2RTIFhDFtF9NW5Xo1lYNZ1BwJuqIw9QcCU/H
         D5cLm/dJ/Q0gaTSSYgZIzjeGyc8Bn8C50HC7GbPdE7q0qwai5/UWbt8UNMZSJsEUZSL4
         AD77Qc5KC/NuWDs5MqD2HsV63eae4rcE8a52kgq5Uo8172UZpBWaXcR5nE6CBlSVyFXC
         6zVPMGyYAh50MaeLsRLv/NNBsqELmsnyAj/HJcIpJmN3YGCcE9EUeShRBU711k3H7ulB
         5I+w==
X-Gm-Message-State: AOAM530ACzQeUm+MZ2AO/us1INsTSoSt85pMV+HPuy48HKVa3UEBQJWK
	V8cIdZV3AZ+ZTqrXO7wtDa7QM64aLJMzW6htlypIaOr5U+/F4awf3BYpcMVfPi9HedCfFXIzBeB
	zf1R00w5nFJDIrck=
X-Received: by 2002:a05:6000:18c8:: with SMTP id w8mr18120926wrq.90.1627291298389;
        Mon, 26 Jul 2021 02:21:38 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwdwUXWP2ZHyd922nHNtT/HVIXeI76k9Hm2ijAQi70vnGCIVqSxtZNjSzTB/N0THl0nhVApKQ==
X-Received: by 2002:a05:6000:18c8:: with SMTP id w8mr18120909wrq.90.1627291298231;
        Mon, 26 Jul 2021 02:21:38 -0700 (PDT)
Received: from gerbillo.redhat.com (146-241-97-57.dyn.eolo.it. [146.241.97.57])
        by smtp.gmail.com with ESMTPSA id j2sm6446647wrd.14.2021.07.26.02.21.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Jul 2021 02:21:37 -0700 (PDT)
Message-ID: <78ad0030f1a8f18b083904c3357d44eb9b6f772b.camel@redhat.com>
Subject: Re: [MPTCP][PATCH v3 mptcp-next 3/5] selftests: mptcp: set and
 print the fullmesh flag
From: Paolo Abeni <pabeni@redhat.com>
To: Geliang Tang <geliangtang@gmail.com>, mptcp@lists.linux.dev
Cc: Geliang Tang <geliangtang@xiaomi.com>
Date: Mon, 26 Jul 2021 11:21:37 +0200
In-Reply-To: <64d4079290cfb03d6a5c4ffb44478a770854b228.camel@redhat.com>
References: <cover.1627272435.git.geliangtang@xiaomi.com>
	 <6f7aa2fec63dcaa337c7b78184a73a90d58b580f.1627272435.git.geliangtang@xiaomi.com>
	 <043ce3b46a70bd59ae7aaa53ed1afdf44b7f3ad2.1627272435.git.geliangtang@xiaomi.com>
	 <3e4690d0d33f8285465e54870410266e22208acc.1627272435.git.geliangtang@xiaomi.com>
	 <64d4079290cfb03d6a5c4ffb44478a770854b228.camel@redhat.com>
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

On Mon, 2021-07-26 at 10:25 +0200, Paolo Abeni wrote:
> On Mon, 2021-07-26 at 12:12 +0800, Geliang Tang wrote:
> > From: Geliang Tang <geliangtang@xiaomi.com>
> > 
> > This patch dealt with the MPTCP_PM_ADDR_FLAG_FULLMESH flag in add_addr()
> > and print_addr(), to set and print out the fullmesh flag.
> 
> I'm unsure we should enforce no 'SIGNAL' flag is set on the relevant
> endpoint. Likely not required...

Whoops this comment really matters for patch 1/5, sorry for the
confusion!

/P

