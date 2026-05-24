Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC47F20010A
	for <mptcp@lists.linux.dev>; Sun, 24 May 2026 08:34:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779611652; cv=none; b=iBne0J84mEvg6ojpgZXG6HOg1admsGqJA7Jh2mIGDrlgGCfJAV2wt3l9dBzB49qncVRY0cknrajHX4b7ccgkt6Qu8yqdeNKeJCnDb+8qnOUiYomUYXLOaH8KOw45bGI64HifgYihfjxJNJ1Hftf+UVDHtRFR5DBg9CY5gnRMl2Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779611652; c=relaxed/simple;
	bh=pS2lQS9h6eXZ1rwNYozsuGpuJuoMQPJz2eEnreYz5Kk=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=tEjWWg6jTQlZsETZv5yY5CeT6zlQfU/P26cwASFKFyypMSB4yVPue6Z13m0//vPgRsz2GEvwxWZms6ecYMyYDW+zYgtPFb3eukJdFRM9ohVrUd45v2IYPg2hlPHM6FWbF7Ctwz7tCgPGZiyW43fmBig8PIhAiAqLITsk3zCqy1s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=UKlwyOPu; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="UKlwyOPu"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1779611649;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ryxdvtuzvnYLlwlc22Zdi//uw+JKqP5f7D6dbpUQqB8=;
	b=UKlwyOPu/AqopVQoUIclZ2t5MTP1X+F+fm/RZF3pylHtibJzSSP7yBsh84FyAvPZo/8FGk
	R0GHczFmWzqcX8gIusXDIzTpbT8RE2hli/by9aqSmJ48oJ4mja5/p1H97SlJnBUVPOEm5T
	DCrkgdYS4YjQ9o0czUNXPLYLCHAzWTg=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-219-nVtISqwDOtqEh_iZTrsc7g-1; Sun, 24 May 2026 04:34:08 -0400
X-MC-Unique: nVtISqwDOtqEh_iZTrsc7g-1
X-Mimecast-MFC-AGG-ID: nVtISqwDOtqEh_iZTrsc7g_1779611647
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-44d83e45febso6374939f8f.0
        for <mptcp@lists.linux.dev>; Sun, 24 May 2026 01:34:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779611647; x=1780216447;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ryxdvtuzvnYLlwlc22Zdi//uw+JKqP5f7D6dbpUQqB8=;
        b=TN3XqqHuGcUm0dBPlmTExN0+JtncwDLKgPlUEdz7m9wq8bMuIwmpXrrcw5L5vG0JXr
         iC4y6ME9d4GojC4Zr7NlVzQegkzHgt2d1m3IJsO6di2/pg9ZZDwXS5wz5l47fZF6+4/g
         7f+/yY5zhq6ds/mUikRA5s5Vsc/ET8K5QKQp+ToR0CxBpOqlwaL6KM8rZABNjt5Murr/
         /4k15u4xP5oIHWCkBDqGn5RbfgNcVgowO4ZowKyK5M4s63fs3wFzLSwL12ON7vSZg9GV
         DjNwYkjQGRLJ5csYx1YfZ8VtMTl/JsHjgT2L6etTgL3brrxf1dvG6Q53WHxQQOpSfhYT
         NY2w==
X-Forwarded-Encrypted: i=1; AFNElJ/IXeoClWGoWVNXjlu+C7HmbXCNWY0Xdc5yjxSTuCOH0kXhoOHVa71HiRHn0u9+QbONsrzGYA==@lists.linux.dev
X-Gm-Message-State: AOJu0YzTpKXGeYaHZSXbH1wHEPyiU7MFWbs+0owqBIew9LIh8JGvXiHq
	ZxPTWgw/rRVazOdLXkQEJ5CMizDIra9QLpoyfmC3c3tJEEwyvMPPOhnKumhiSJxHZZFhOm+fy6r
	R6JQzHS5Q/vNAf+Zg+GfufKPgHid+mpSeZ8ZghixcNZHmssrAnC6v6ONw
X-Gm-Gg: Acq92OHteKzow/viwSl9zMBiPav89AA/DC/U2zttQIt2D1W1fTQ4SLvqHy7uVW3To4v
	/O/POwYh05NKduRJN/5Y+cfamnRDl+y7zGa36M9eoK9ZG4eqjOSVi8Ri+bmgj9h++x2W0JZamu2
	g/r7n3AoDg1tQbY4VesCEsX0x+I3lsreDelD9HMYChuo4euLkdBOReA5vt9ZB7vsOoOAKclptgt
	Hixrk4fF2LaCPTUrqKsQ1xo5gXVs7mszZcGh6LSip/OAVU6F14gReyc9FBki/b+pYHx7lhBiD+1
	3UBgnONKdJe0xAmPhDyDDgg9+a4PmV8kNwwqFFixDh0pi0U3JyU2fhqfr4av9E/UyyE5gzegv0W
	m/wST6SSfzfRUALjv4KUaSP0bh+8elMI4LraDdMPSvwsrNwDLAOGKlK2P5w==
X-Received: by 2002:a05:600c:46cb:b0:48f:e044:927d with SMTP id 5b1f17b1804b1-49042480f2dmr135701845e9.10.1779611646805;
        Sun, 24 May 2026 01:34:06 -0700 (PDT)
X-Received: by 2002:a05:600c:46cb:b0:48f:e044:927d with SMTP id 5b1f17b1804b1-49042480f2dmr135701535e9.10.1779611646340;
        Sun, 24 May 2026 01:34:06 -0700 (PDT)
Received: from [192.168.88.32] ([212.105.155.152])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49049973b71sm42455565e9.29.2026.05.24.01.34.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 24 May 2026 01:34:05 -0700 (PDT)
Message-ID: <a017ffa9-1dbe-4094-ae85-7c17e7b48b0d@redhat.com>
Date: Sun, 24 May 2026 10:34:04 +0200
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 mptcp-next 4/9] mptcp: allow subflow rcv wnd to shrink
From: Paolo Abeni <pabeni@redhat.com>
To: Matthieu Baerts <matttbe@kernel.org>
Cc: Geliang Tang <geliang@kernel.org>, gang.yan@linux.dev,
 mptcp@lists.linux.dev
References: <cover.1779485511.git.pabeni@redhat.com>
 <661603fa10737a624bba854fb2515c7abb129a80.1779485511.git.pabeni@redhat.com>
In-Reply-To: <661603fa10737a624bba854fb2515c7abb129a80.1779485511.git.pabeni@redhat.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: us66IaPyjCdGNYjvtQWXaHQXHZhpZoBrayRpyeTwwqc_1779611647
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 5/22/26 11:43 PM, Paolo Abeni wrote:
> In MPTCP connection, the `window` field in the TCP header refers to the
> MPTCP-level rcv_nxt and it's right edge should not move backward. Such
> constraint is enforced at DSS option generation time.
> 
> At the same time, the TCP stack ensures independently that the TCP-level
> rcv wnd right's edge does not move backward. That in turn causes artificial
> inflating of the MPTCP rcv window when the incoming data is acked at the
> TCP level and is OoO in the MPTCP sequence space (or lands in the backlog).
> 
> As a consequence, the incoming traffic can exceed the receiver rcvbuf size
> even when the sender is not misbehaving.
> 
> Prevent such scenario forcibly allowing the TCP subflow to shrink the
> TCP-level rcv wnd regardless of the current netns setting.
> 
> Fixes: f3589be0c420 ("mptcp: never shrink offered window")
> Signed-off-by: Paolo Abeni <pabeni@redhat.com>

Sashiko failed to review this series from this patch included onward:

https://sashiko.dev/#/patchset/cover.1779485511.git.pabeni%40redhat.com

and it's not clear to me why.

I think patch 1/3 are quite uncontroversial and reasonably even this one.

WRT the stall addressing patches, this iteration survives mptcp_data
testing without timeout tuning, hopefully should be fine for Geliang and
Gang usage.

@Matttbe: please LMK if you prefer a complete repost or if you could
apply patch 1-3 (or more).

Thanks,

Paolo

