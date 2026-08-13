Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4A44340D90
	for <mptcp@lists.linux.dev>; Thu, 13 Aug 2026 07:57:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786607850; cv=none; b=Jx2cYCxFtX1cD7Hkn7B6sXSZmyAmmrIKa+nEEWLfHtzYJ7SgOysZpvPWryN1VBEjBw8dBm7Uq/fbmkFqRgwFA1RfYo+iyB7IB8Vg2kDLYuwwGjcl4MBt6Za65JZY6wYiZDZ+VCJs4n2o1pZeNzDhSTAjaXOn1WLSz7qiCS4x/WY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786607850; c=relaxed/simple;
	bh=P2DJnPpKroW3/16KWe05s709vplzJYt7drZdbRT9An4=;
	h=Message-ID:Date:MIME-Version:From:To:Cc:Subject:Content-Type; b=sWv2FCKPGdDvT+IKhvANzpJseGiKiQ1mX+uYLSrYpU5d8CwTKJT5eCvsPn/+13i9a0UQUP0cRKp7+nxOBog1EiXBjsknsVncyZLU6BW4KQWHvD33qCMv/CGyIGAyepmo2TrzDy/Dzn5LUxSX6Y4BZHGjvVTTxKFCIV1W0oMBG1g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=fVHJPWOr; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="fVHJPWOr"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1786607847;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=P2DJnPpKroW3/16KWe05s709vplzJYt7drZdbRT9An4=;
	b=fVHJPWOrKZRicC1D9A3eCukiO0FZYeiL4hLEhmG1pQfFvav4Tz2k0IlO/1I3W/8A+PDBZJ
	K3pntkvjBvFq0vG6DdG9d0HIxaRjHg2GK2nLx1IHGznvj+yGBKXDom1ipkswIOrsG/7Fzx
	Z5g0jE0RPMA/cIOIIGUqBsN7zI0cDy8=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-436-I5kE5rSdPqS8l2Ze-gGD7w-1; Thu, 13 Aug 2026 03:57:26 -0400
X-MC-Unique: I5kE5rSdPqS8l2Ze-gGD7w-1
X-Mimecast-MFC-AGG-ID: I5kE5rSdPqS8l2Ze-gGD7w_1786607845
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-496c06ba017so4495335e9.0
        for <mptcp@lists.linux.dev>; Thu, 13 Aug 2026 00:57:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786607845; x=1787212645;
        h=content-transfer-encoding:content-type:subject:cc:to:from
         :content-language:user-agent:mime-version:date:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=P2DJnPpKroW3/16KWe05s709vplzJYt7drZdbRT9An4=;
        b=gsh5+WxQJ2khhpewqKRzXlPJ2trpPSihCEcKnb7+wYjfgx96JSwynXlc/EbH2pYSJR
         asQv1adqaTuItluwdgbt2D7J50YEcM4aNdnTA13pfoZ9S2xCYk79IO1o4lNCaaQo2gvp
         9I483psyLLCEpPnSE4C4DeLBXsljDRZAY7T0UacEQ/ScFWX4vvR5CW29m5Z+mEhp1Gq/
         NPV9w5c9rJBkOeeGmJbmLR2he4U7hscZaC+WFUMWg2ynF9/RShq6yVaKDHVfhS+Ka+6l
         lF/rK4TeTtQvoTtGo79dUUOBZpnI1e9/kIdSOqRVB9G261SvSd+697pQJdUXZbtzMmqq
         mHFQ==
X-Gm-Message-State: AOJu0YyyKrcwG+M2a25Jql32HwcpjTdXg/+5fRZv/UoS0oK08HyHBR1/
	ztz8aF72uQhRxAoCKVLYDVf39SQXhYKWW+uUu5mEdM7mbTAh1AFjmf30iJQ7H7dSRte0xOpcS2E
	U2SLSbKDX4FpcBKYauBpbK4ZNNvJlm/S9s6trkkPPzBGl/xlSGoVxN26KCPj3ZQvg
X-Gm-Gg: AR+sD12/SfCRkfPEjVncCwzfUYO2q+6JEtpEBflHXVwfLd/CV9CP0Huih+Ny8llgY/h
	A/5uccgjvGdNmYS32tKEA+S6LWrtOrDv1lVojZLZSbt4xCP1R3LhG+CazVD91s3fps6q9R36vHq
	q5ktdZ9Eh/mnlw7e3qDN0bQQhQsxUcaXPJTFKrxUJKjXRhrXoQS+pJtpIcwEjM/QxMxnEa1Z9Bi
	hZgmIM9N9U8AcfZu+i3AMu7rJYBVaaOq58CYYrBbQoCErNiDzkMx2qW2RUUELApFj8KgDyu0Dh9
	uvXrlV6k2dAb80DhMXudbjehLVT9sFd6T2taZFzc5Ww3yhEdTeIRchZqyrnDe/jtbu3fBVXe/qN
	Xoyk0OHg36RBEHaiVUaWScXF6iPpFdG7ZYnzfnuSCnTFJxUVeNDds+GqiC8+lE7gualB7K+Umaq
	I=
X-Received: by 2002:a05:600c:138c:b0:493:f783:c46a with SMTP id 5b1f17b1804b1-4998220750bmr35344895e9.6.1786607844802;
        Thu, 13 Aug 2026 00:57:24 -0700 (PDT)
X-Received: by 2002:a05:600c:138c:b0:493:f783:c46a with SMTP id 5b1f17b1804b1-4998220750bmr35344425e9.6.1786607844360;
        Thu, 13 Aug 2026 00:57:24 -0700 (PDT)
Received: from [192.168.188.103] (ip239-44-231-195.pool-bba.aruba.it. [195.231.44.239])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4815a5b6e3asm3919505f8f.28.2026.08.13.00.57.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 13 Aug 2026 00:57:23 -0700 (PDT)
Message-ID: <02830f64-bb5f-41fc-8211-5f7aa36b828e@redhat.com>
Date: Thu, 13 Aug 2026 09:57:23 +0200
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Paolo Abeni <pabeni@redhat.com>
To: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Cc: MPTCP Linux <mptcp@lists.linux.dev>
Subject: CI failures on nipa
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: c_pO947a0UK0_zyUjoc0_IUcPqD16_PgQdDgPX60LsA_1786607845
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi,

I'm looking at this one:

https://netdev-ctrl.bots.linux.dev/logs/vmksft/mptcp/results/776501/6-mptcp-connect-sh/

the output is strange:

https://netdev-ctrl.bots.linux.dev/logview.html?f=/logs/vmksft/mptcp/results/776501/6-mptcp-connect-sh/stdout#L114

the first nstat dump includes apparently the counters from all the
previous runs, which is unexpected: the nstat_init/nstat_get/pr_nstat
dance should allow showing the data from current run only right?

Also I think mptcp_lib_wait_timeout completes too late (after ~60 secs),
when the listener already bailed out due to accept timeout (after ~30
secs), so it does not show any info on the listener side. I fear it may
also race with the actuall `timeout` command completion showing socket
states after the user-space program completion.

Judging on the final status, I *think*/*guess* the (re)connect is
hanged, possibly due to bad remote address?!? It could be useful to
print out on stderr the reconnect destination address.

/P

