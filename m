Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B8673D74
	for <mptcp@lists.linux.dev>; Mon, 19 Sep 2022 10:46:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1663584375;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ax0XCHBoTxPcV1wk/8RPerKIwg3a9ML0E1zvz2EE3ts=;
	b=KP7JwmXWngEvvMz/wAm6WS9JWXHQmK+ieYotzWmR0LyeBrVRNPiHDdilDKJKZEhwhX2zQx
	99SyP1o1NETJrxC/ugBmrv0o3w7M2mlBor6lYUCrQFLXz9LxQ83MDbqazU4gOV5B6gNqCy
	L+e+aoZZlGeNUVw51nH+psJEqP2suBg=
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-62-wr6qGJxoN1KN4slyKLfF9Q-1; Mon, 19 Sep 2022 06:46:14 -0400
X-MC-Unique: wr6qGJxoN1KN4slyKLfF9Q-1
Received: by mail-qk1-f200.google.com with SMTP id bs33-20020a05620a472100b006cef8cfabe2so3056727qkb.12
        for <mptcp@lists.linux.dev>; Mon, 19 Sep 2022 03:46:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:user-agent:references
         :in-reply-to:date:to:from:subject:message-id:x-gm-message-state:from
         :to:cc:subject:date;
        bh=ax0XCHBoTxPcV1wk/8RPerKIwg3a9ML0E1zvz2EE3ts=;
        b=LZhNRNQa9yHCEa/aqGVAtyA91EYKJPpFIMsIQClz/PYgBo4ruhesmgclGIbE27I8wO
         BNV8olXgSji5D5HbYe9AoB/rwvpeNuB6Qqmnd9Rksxycr7CcKEFzwPM5YAbYrjGIaefT
         Ha25DJaJM1OHkYZxDqPlxTSqZvSGvI5SYRPacua1mygkEMRDdHj6qqS8T5tC9ihJhwEM
         tdyZfLIZ69tQ4c0hifPyY8/EvFNzjkXYph6ij7+AHphBgCWpjuh/+yZJuj0EyhH0xGOA
         O2+s1k4ep5qASKP/x7wlrLV41JJDnlcmcJo4/ZQRvgpoV8RWQneXaKPsk00CMj/bqopf
         vWOQ==
X-Gm-Message-State: ACrzQf1Ziwne6KmR6V1xdeZaol7+ggeK9B8lw//qzyCXq3Wsj54isM6L
	MsilIP3SOLrFdrseSmAUlNa9e4lFJ5hmXGko+RmE1LBXs4NwPpueBrI/mrLdNmkBuOotBCD18Dy
	vM6vgKnefjgPVqVw=
X-Received: by 2002:a37:c409:0:b0:6ce:173b:6b37 with SMTP id d9-20020a37c409000000b006ce173b6b37mr12407922qki.75.1663584373456;
        Mon, 19 Sep 2022 03:46:13 -0700 (PDT)
X-Google-Smtp-Source: AMsMyM5kP8gHZLeCeLLTuye+OkHmVZtGt/uy5t0zNrAoSWIcIQ1V5vJ6LdDcU306pk0QlStjh3uetw==
X-Received: by 2002:a37:c409:0:b0:6ce:173b:6b37 with SMTP id d9-20020a37c409000000b006ce173b6b37mr12407907qki.75.1663584373173;
        Mon, 19 Sep 2022 03:46:13 -0700 (PDT)
Received: from gerbillo.redhat.com (146-241-114-90.dyn.eolo.it. [146.241.114.90])
        by smtp.gmail.com with ESMTPSA id a12-20020a05620a16cc00b006a5d2eb58b2sm11508037qkn.33.2022.09.19.03.46.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Sep 2022 03:46:12 -0700 (PDT)
Message-ID: <71bf3761af14f71496b297cc31c0cdab047e1aa1.camel@redhat.com>
Subject: Re: [RFC PATCH mptcp-next v7 05/11] Initiator: add locks() to
 mptcp_sendmsg_fastopen.
From: Paolo Abeni <pabeni@redhat.com>
To: Dmytro Shytyi <dmytro@shytyi.net>, mptcp@lists.linux.dev
Date: Mon, 19 Sep 2022 12:46:10 +0200
In-Reply-To: <20220917222853.2406-6-dmytro@shytyi.net>
References: <20220917222853.2406-1-dmytro@shytyi.net>
	 <20220917222853.2406-6-dmytro@shytyi.net>
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
> Suggestion of @mmartineau : 'add locks' is implemented in this patch
> 
> Signed-off-by: Dmytro Shytyi <dmytro@shytyi.net>

This should be likely squashed into patch 3/11. It's better to avoid
leaving broken code in the middle of the series. Incomplete
functionalitly would be ok for a mid-series patch, but not corrupting
the internal sock state.

Cheers,

Paolo

