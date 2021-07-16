Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6032270
	for <mptcp@lists.linux.dev>; Fri, 16 Jul 2021 17:29:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1626456542;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=vAyWTqBH5F4R8EvvVSGFefQV5sgmeYLfEcNhhghsETA=;
	b=L9czV4+aosFVmmvuenQLdMNrGfR/ZYtzWbLsND6+rg4MwB/jTgMZFzGyYEfSadVLvnXIiX
	nT14pBXv0hirjImIXzoCWSG0kZ6hhUAHyLm+C5uaXu8Y1PYjT1yQ4Fkbb7OLnXIOn4JFaC
	fuDcvFmkk+5PFEXy9my4jz5hacPQOQY=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-352-oM0CRSXvNY64gdv0GPiT3w-1; Fri, 16 Jul 2021 13:28:59 -0400
X-MC-Unique: oM0CRSXvNY64gdv0GPiT3w-1
Received: by mail-wr1-f72.google.com with SMTP id m9-20020a0560000089b02901362e1cd6a3so5067014wrx.13
        for <mptcp@lists.linux.dev>; Fri, 16 Jul 2021 10:28:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:date:in-reply-to
         :references:user-agent:mime-version:content-transfer-encoding;
        bh=vAyWTqBH5F4R8EvvVSGFefQV5sgmeYLfEcNhhghsETA=;
        b=ToyF9/2bLp6260uSw3Mvhvia2EZL2MYdMiF6XD9ZUCanyYbLYnvG2OrBES8jN9O0IU
         EFOdXAFbaYghoMsKiTGbicKF3+fKLyakfE6CmpUSNU5Xae+BolRknUhAA4L50rebGLLi
         PrSWj1zjrgLOIA12hjc6Fmf6AV5BVGx68qyzQDhbNW4HmsKaNId2MbdZ6yUQcS3F4Bv0
         sAfbUI1rcMFDLZ9E6EhTPVkdsJB1h70x/lm5nekAyakmKixKQr3Ta7kyalsQjF6d78i9
         lCX70dwI+Y75AvyLsRvcD5vOUPQBoTkEMGzJKiOuDn8uNPtaLDbBdJyaaLL+AMRdKySZ
         z7zg==
X-Gm-Message-State: AOAM531HGfuUUFynZE697SlYm28nbBm/wiCR3GSRT2eQUYIymX2FHc/0
	kEkdsT2jWAA/ovyZlhJbgA66Njp18QVYpakx1WXEJcUMcBzTAlw4H4BfvN9a6wgeVa4zB+K1WlQ
	9/tJ3v/mrsBaFY4k=
X-Received: by 2002:adf:dd92:: with SMTP id x18mr1733715wrl.421.1626456538568;
        Fri, 16 Jul 2021 10:28:58 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxsVOfznrAQ3yg6r0xjR56FugfnHnrxWqcs6CMyf7jbWOPAkEicAuvQEVK9tZib1UkSCQ/TcA==
X-Received: by 2002:adf:dd92:: with SMTP id x18mr1733695wrl.421.1626456538330;
        Fri, 16 Jul 2021 10:28:58 -0700 (PDT)
Received: from gerbillo.redhat.com (146-241-117-63.dyn.eolo.it. [146.241.117.63])
        by smtp.gmail.com with ESMTPSA id d15sm10714305wri.39.2021.07.16.10.28.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Jul 2021 10:28:57 -0700 (PDT)
Message-ID: <afe3a1366f84d584ce092381d02df6204b560d06.camel@redhat.com>
Subject: Re: [MPTCP][PATCH mptcp-next 0/9] fullmesh path manager support
From: Paolo Abeni <pabeni@redhat.com>
To: Geliang Tang <geliangtang@gmail.com>, mptcp@lists.linux.dev
Date: Fri, 16 Jul 2021 19:28:56 +0200
In-Reply-To: <cover.1625825505.git.geliangtang@gmail.com>
References: <cover.1625825505.git.geliangtang@gmail.com>
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

On Fri, 2021-07-09 at 19:04 +0800, Geliang Tang wrote:
> Implement the in-kernel fullmesh path manager like on the mptcp.org
> kernel.
> 
> Closes: https://github.com/multipath-tcp/mptcp_net-next/issues/193

Following-up the yday disucssion in the public mtg, I skimmed over this
series.

I think this approach leads to quite a bit of duplicate code and
avoidable complexity.

I also think we could obtain a full-mash topology with some not to-
complex extension to the current NL PM:

- add and manage a new per endpoint flag, something alike 'fullmesh'
- in mptcp_pm_create_subflow_or_signal_addr(), if such flag is set,
  instead of:

	remote_address((struct sock_common *)sk, &remote);

  fill a temporary allocated array of all known remote address.
  After releaseing the pm lock loop on such array and create a subflow 
  for each remote address from the given local.
  Note that the we could still use an array even for non 'fullmash' 
  endpoint: with a single entry corresponding to the primary MPC
  subflow remote address.
- mptcp_pm_nl_add_addr_received(), fill a temporary allocate array of 
  all local address corresponding to fullmash endpoint. If such array 
  is empty, keep the current behavior.
  Elsewhere loop on such array and create a subflow for each local 
  address towards the given remote address

I hope that overall the above would require a limited amount of
changes. If so, I believe this way to be preferrable:
- 1 in kernel path manager
- a simple one
- a single configuration interface
- should cover the full-mesh use case and possibly more
- the idea is - some far day - use ebpf for more funcy stuff, if
needed.

WDYT?

Thanks!

Paolo

