Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9EB1E1365
	for <mptcp@lists.linux.dev>; Fri, 29 Apr 2022 10:08:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1651226932;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=btSG8jhwcPPof5JIl34GMZ11EeTqopyAwZraNZ8IyLU=;
	b=bZ5vcoAuOKvq3brG/zv2pAcbDz721oc6E1Nz3AFo3vYUdWxb5MXrspeMxBfRmVkmIQ/L0B
	6eiBazTvcW+D8jEe2pOREe5u8386BG1BZU7HJ5sBNq0fL4VkMB1REhg6PLCh3KYllFa4oy
	ztmXNIzVkRWudxj2BT4w5Bd5pjdIrvk=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-519--ZAJ6-UFOwiDcSJivjN5Mw-1; Fri, 29 Apr 2022 06:08:51 -0400
X-MC-Unique: -ZAJ6-UFOwiDcSJivjN5Mw-1
Received: by mail-wm1-f72.google.com with SMTP id k5-20020a05600c0b4500b003941ca130f9so625023wmr.0
        for <mptcp@lists.linux.dev>; Fri, 29 Apr 2022 03:08:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:user-agent
         :mime-version:content-transfer-encoding;
        bh=btSG8jhwcPPof5JIl34GMZ11EeTqopyAwZraNZ8IyLU=;
        b=Gxw7SnKvDBhfKhWLgW4fJMK/6VhzcsevBaFo6q9ZUgJzJhE9Ka50a3ZUKxk+UweZYR
         3JADxHfoZpx8RvE9MXiN8+K+NhEfvuSKBv44WFLcag/WkpD+m8eE+uXslwKXvb00DQmh
         sxO8DsDsSIzwnum83B2IjPPCsCHZVhqOHcTisyaTq6A/EtMTglE6jCqOvlq3LrEwcnvM
         6rg7xmN51bTzuEIVYhJTCP17m1F9zIzDCR5JgiJh6+m6Z07HC5S/OzrfaDMkOtETo2ex
         Dj3QwuzBh+MyBDGZUY1len6EAP58y3XEel7kVL6tzm6rIaOPH5gtlxoonGpz3UaGeOd1
         SUXg==
X-Gm-Message-State: AOAM531EAV8UTVSyyI0UCKZH9VzOomTrIbwuYXU22rvw4ivWRSFwaNuL
	v4sA2he6uwGQfUyw8f2yN8DIz1BKHPsicqgar45dA8hKYJNXtJNHWzUvnpE7hf6QSq+9oi31LEM
	kyWrBIl8gZWAoEgPeUfguP/fcyRRZs/AbAF9t5qK7PpQmCght+QvKw6WT1cVB3ChE
X-Received: by 2002:a5d:4645:0:b0:20a:db5d:258f with SMTP id j5-20020a5d4645000000b0020adb5d258fmr19290226wrs.135.1651226930086;
        Fri, 29 Apr 2022 03:08:50 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyswfkGAxJ1EmwuLiPHo82Aa59/PSyL15jsaYe8iD55SDj6GPxFEHpKNJQpTA3GlwznTqDumQ==
X-Received: by 2002:a5d:4645:0:b0:20a:db5d:258f with SMTP id j5-20020a5d4645000000b0020adb5d258fmr19290197wrs.135.1651226929730;
        Fri, 29 Apr 2022 03:08:49 -0700 (PDT)
Received: from gerbillo.redhat.com (146-241-96-105.dyn.eolo.it. [146.241.96.105])
        by smtp.gmail.com with ESMTPSA id k23-20020adfb357000000b0020ad7c36332sm2011714wrd.110.2022.04.29.03.08.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 Apr 2022 03:08:49 -0700 (PDT)
Message-ID: <3e23ea866374467e2c9aeec60049716b42d6634e.camel@redhat.com>
Subject: apropos https://github.com/multipath-tcp/mptcp_net-next/issues/265
From: Paolo Abeni <pabeni@redhat.com>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliang.tang@suse.com>, Mat Martineau
	 <mathew.j.martineau@linux.intel.com>
Date: Fri, 29 Apr 2022 12:08:48 +0200
User-Agent: Evolution 3.42.4 (3.42.4-2.fc35)
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

Hello,

I'm investigating the mentioned issue. Not strictily related to the
observed failure, I think/fear we have a very serious problem WRT csum.

Currently, AFAICS, we encode the csum converting the value returned
from csum_fold(csum_partial(csum_unfold)) to be:

https://elixir.bootlin.com/linux/v5.18-rc4/source/net/mptcp/options.c#L1343

while the UDP/TCP csum store directly the result for the same
operation:

https://elixir.bootlin.com/linux/v5.18-rc4/source/net/core/dev.c#L3228

I guess we are doing it wrong but we don't obseve any specific problem
as tests runs on the same arch and we do swap on rx, too. 

I think should see sistematic csum failure when the involved peers have
different endianess (e.g. x86 vs arm). If anyone has easy access to
both systems, could please verify the above?

If the above is true the nasty part is that I don't see how to fix this
without breaking the interop with bugged versions :////

/P

