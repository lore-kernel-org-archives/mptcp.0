Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 311E568
	for <mptcp@lists.linux.dev>; Mon,  6 Dec 2021 17:48:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1638812918;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=xMgsnOEbJA2+rNt1142w0sxiwtr7pPb7pqdDQdfyVGk=;
	b=PeXeNHg8MtB75ymdIp/6+9NcI3DWwxAJcj4HhCtUPDJCEYg99dIqa5t7H9W7PWhWsRcl8/
	K7IDQlkYOPI8bQZcu/8L7i7/q7JPZQW6y+2U4udMHyTHLDQCLK4hx0o5uVhUiEy3w8Xv+y
	2m9kobOTM380oaZ25a09RmAgW6USb3s=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-549-FL9fgvXCNkyLQRSO9VCZoA-1; Mon, 06 Dec 2021 12:48:35 -0500
X-MC-Unique: FL9fgvXCNkyLQRSO9VCZoA-1
Received: by mail-wm1-f72.google.com with SMTP id ay34-20020a05600c1e2200b00337fd217772so213056wmb.4
        for <mptcp@lists.linux.dev>; Mon, 06 Dec 2021 09:48:35 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:subject:from:to:date:in-reply-to
         :references:user-agent:mime-version:content-transfer-encoding;
        bh=xMgsnOEbJA2+rNt1142w0sxiwtr7pPb7pqdDQdfyVGk=;
        b=zZZUCgl0YdzapXizV6/gdhYwPeJjC6bmoG62lMuHWY+ZrqABAKH/JqGOrLrlHA7ppW
         5aTGOwe/KP281gHTw65EUbBN/9263y0SrjJRcLodofFOnx+eruvvIOno4HVQsLwDwkXG
         5cv84OtFgSFFfMTOv9NDOr9IyuGUFgE9nfLPsURgk+glbgzfYJb4A2O6YAUA74q1AVe0
         2OnImUjFkFfbXLVeHIzbJz1euN6xRkuKaXVSPISnNy2tOUw4LShynBmst5QeuF2mdAoB
         CSW++MtnhZbIEUMbcV28RYAfYb6JHQU5PNlf9dRELJ4PENQFLuVYSocXRDGnBqudonIg
         y+AA==
X-Gm-Message-State: AOAM5307jwPXhrbCB0s1c+tEoRjUri0uMntjTuUFvvx+1+Oz0Lf93s0Y
	FnaHCMDLDLGjlCqD2rWPIkeStXQMrcsAfbnULK27vDyeuqUL8Ci7IRR0Sv3GWQ0hnYwIjxfEipj
	BxhyeKNdB+Au9624=
X-Received: by 2002:a7b:c153:: with SMTP id z19mr40610556wmi.171.1638812913886;
        Mon, 06 Dec 2021 09:48:33 -0800 (PST)
X-Google-Smtp-Source: ABdhPJxR4D99qgy8t2wsDRUjYkvNAsH/R+V8dQpilSAuJ2EHaFURE/RiMps0xbNjOOpZ9mz9HGFbbQ==
X-Received: by 2002:a7b:c153:: with SMTP id z19mr40610534wmi.171.1638812913727;
        Mon, 06 Dec 2021 09:48:33 -0800 (PST)
Received: from gerbillo.redhat.com (146-241-252-1.dyn.eolo.it. [146.241.252.1])
        by smtp.gmail.com with ESMTPSA id j8sm11624824wrh.16.2021.12.06.09.48.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Dec 2021 09:48:33 -0800 (PST)
Message-ID: <7d2c19aa4a4753fa1c7d88db9a89527aead958d5.camel@redhat.com>
Subject: Re: [PATCH mptcp-next v2 3/6] mptcp: Bypass kernel PM when
 userspace PM is enabled
From: Paolo Abeni <pabeni@redhat.com>
To: Mat Martineau <mathew.j.martineau@linux.intel.com>, mptcp@lists.linux.dev
Date: Mon, 06 Dec 2021 18:48:32 +0100
In-Reply-To: <20211202005216.154787-4-mathew.j.martineau@linux.intel.com>
References: <20211202005216.154787-1-mathew.j.martineau@linux.intel.com>
	 <20211202005216.154787-4-mathew.j.martineau@linux.intel.com>
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

On Wed, 2021-12-01 at 16:52 -0800, Mat Martineau wrote:
> When a MPTCP connection is managed by a userspace PM, bypass the kernel
> PM for incoming advertisements and subflow events. Netlink events are
> still sent to userspace.
> 
> v2: Remove unneeded check in mptcp_pm_add_addr_received() (Kishen Maloor)

I guess the above should be 'mptcp_pm_rm_addr_received'.

Cheers,

Paolo

