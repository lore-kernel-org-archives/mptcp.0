Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7EE193148B0
	for <mptcp@lists.linux.dev>; Fri, 19 Sep 2025 15:01:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758294096; cv=none; b=nzilrZ52QuJN0jmc7A89KQaA2aLYHWjR/T74mrhZ42ByDt3SxvO3p8g0f+2qsZwrYvBYtYXmk/R6bzl/B47Y/hra6mzdCrT/sHMVYZcq41eQGln0qoK22UvyMQqo+tBZrS0DQtefLKfF098OQLFg4jL/dO9whl+sxZnGD8IqVY8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758294096; c=relaxed/simple;
	bh=WTypobrXWoEjw5qJnULZ5tUxNwM4KEniL32275gHnmw=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=JBVWlyTsfdE6jtdmgfkQ/UuDLTdaQ2f1S+sRzH7OXN7N/iBkGLxqBj0/I7OwQhAD8dphkhN12i/WKxT2f7OoLH6bTWSC+GF25PEGnCjxHTpUDsrn4w0DbTYDR8sgRbUpi49rjJxVKFiWyuOFNsk2RIjs+6Dw7o1+0DPAnKIFC7M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=EAafUo/O; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="EAafUo/O"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1758294091;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=qJoSLXLCe3VbLMQ9Z0BBxIOKblMSgZodgcfE0V3gfj8=;
	b=EAafUo/O8T+RoJKbmDmr5Qi/61BWFl4B9IfxxSmUDflWvg4Fz8Wlq9J9dot4LHa5LrHT8w
	Pr+Qptd8UIeZQ8HH/fjG93LZyN3eCRD/ePjAoTlBJ68X+S7NrmqraaZVNLFtP6dKKBIp5K
	Yfs5inZTRy/5pWwoL8Gu3TcE+430fNA=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-147-lTCdKdlIMO6aerX2-ceiDA-1; Fri, 19 Sep 2025 11:01:18 -0400
X-MC-Unique: lTCdKdlIMO6aerX2-ceiDA-1
X-Mimecast-MFC-AGG-ID: lTCdKdlIMO6aerX2-ceiDA_1758294076
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-45f2b0eba08so14058405e9.3
        for <mptcp@lists.linux.dev>; Fri, 19 Sep 2025 08:01:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758294076; x=1758898876;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=qJoSLXLCe3VbLMQ9Z0BBxIOKblMSgZodgcfE0V3gfj8=;
        b=NVD8tWDeObkEdAic0q4IiJGNlcGiZcneBdEdrdem4qxXwusAo7XrHgIYnvAA9YUCHa
         BaDnHy0+Z1tPS9KO2vLdZirKC9l7yVN/+hjtl5x8ac9dApJFU8mxZm2szhIT4fBn1YUv
         kzJ2fgaxFCmI9lKepiyP/EFNqH/X6WGSyQt57+47AMjzoVCJP438wwzrdWcXgWGG6wez
         yNgs99gj1eamAernHxU+DVE5LjeM2Vkf1JI8vJlxcFfy8QW6BMz/TKCHX/ewJw/YqBA4
         ldhAh+EhcZTJEdKxj8zaOn9ZiLWPFu/sKsXo/t0bvsQaqgfz0wIMb/06TDCMBwOpSN7z
         vB6A==
X-Forwarded-Encrypted: i=1; AJvYcCWKVojOpGQMDkmpKqMSMsRiASq5P8+PxI3Lny3zkRCWxK/F5UK3QQskstEKDOGfXdCfBiawvw==@lists.linux.dev
X-Gm-Message-State: AOJu0YyVp3zWoXHROqkJWkVfm4TnN3JUz4ScSqqh/6+RtOC+YEiiVyeL
	agc0Oxr4/tE8r6CujmwMgSOIGK+ZqIdUppSDgAJXKEZX3UwJ3vCnJwj2DaKTZyv8qz9yihggrot
	3y2jdHQDD8Wfk2hfcRGmmNccHM3bfBimJMIG4kfb04UZjVG01FKYFx0r+
X-Gm-Gg: ASbGncupOhHmS2+O/8G/z60Y+G9+R4Dh28xHdHESAPzYudyByr9U6Ig9v+e7gs3mcdo
	1oGNO3+YT7HJtkDEXwVcCb16L5QKFVOcmL9c/fKuhDUyR4HzhVX5ubOxq6M6v03V65Q58fLvI4J
	v+1N1m5j5cAadIeRTaJR74t1sQ+LRadsQDMchh8NnAXPFQ3+A5B7rXB4xoY+GoKyS3gO99wwr0s
	HHy69sApGOQHEnsDuAd10t1MTSVxMnUqK8dFQJGAgR3eSWu8k6G+XnR1i2BrdVJQ/UyyfbUgfHM
	j4fW+9HoAHaoGC3a8mTLE56uDBFjiQRiuGSSub6YWwpbTlKiJdgO4AsKaA0wh7svCt2jIT1l1jo
	lXB27EVtwozie
X-Received: by 2002:a05:600c:46c6:b0:45b:804a:a65e with SMTP id 5b1f17b1804b1-467ebbbff33mr35339955e9.28.1758294074922;
        Fri, 19 Sep 2025 08:01:14 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE9hJ3r6iSPnahHDaMEDoXyQjW6ApkmP3NfmG6kEx2amKra3PdSO5YBd6yFXZen+XmCIdjjtA==
X-Received: by 2002:a05:600c:46c6:b0:45b:804a:a65e with SMTP id 5b1f17b1804b1-467ebbbff33mr35339465e9.28.1758294074320;
        Fri, 19 Sep 2025 08:01:14 -0700 (PDT)
Received: from ?IPV6:2a0d:3344:2712:7e10:4d59:d956:544f:d65c? ([2a0d:3344:2712:7e10:4d59:d956:544f:d65c])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-46139ba88d0sm127672485e9.10.2025.09.19.08.01.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 19 Sep 2025 08:01:13 -0700 (PDT)
Message-ID: <219c0c7e-9f4c-4f91-951f-8ac99583b8d8@redhat.com>
Date: Fri, 19 Sep 2025 17:01:12 +0200
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH mptcp-next v2 07/12] mptcp: minor move_skbs_to_msk()
 cleanup
To: Matthieu Baerts <matttbe@kernel.org>, mptcp@lists.linux.dev
References: <cover.1758214563.git.pabeni@redhat.com>
 <7874130ef3d034155655104b22712fa3c3c1d028.1758214564.git.pabeni@redhat.com>
 <91594ac4-386b-4fbd-bc65-3bc302bf0e39@kernel.org>
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <91594ac4-386b-4fbd-bc65-3bc302bf0e39@kernel.org>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: 0jtN-cRt5yLoUwB2qmIJy8bASh9I71TNanROvO-zD1o_1758294076
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 9/19/25 2:36 PM, Matthieu Baerts wrote:
> On 18/09/2025 19:14, Paolo Abeni wrote:
>> Such function is called only by __mptcp_data_ready(), which in turn
>> is always invoked when msk is not owned by the user: we can drop the
>> redundant, related check.
>>
>> Additionally mptcp needs to propagate the socket error only for
>> current subflow.
> 
> Ah yes, good point! Should this be considered as a dedicated fix or is
> the impact not important?

I think it is more an optimization/cleanup than a fix.

/P

