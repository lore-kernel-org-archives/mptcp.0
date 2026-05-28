Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC0101A683F
	for <mptcp@lists.linux.dev>; Thu, 28 May 2026 07:46:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779954366; cv=none; b=Fe93RjwHICuHXTckRiyIZy2zWU2m4zg2aiAAn2rd5gDb7da59lYLHCEuI7pehrS18D9H6gce990kqFDLGuXQAaPLv/QQkNm3+hKV7+RNMCMZIzJXQOYiFvY6VGu/vBvObtOLEQSt1Ew4IcewPUXki6kgfwWmEsLfB+RGR5qDq1E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779954366; c=relaxed/simple;
	bh=42MvBaXQRlYZ7PEu9sET1gFxuwwcQWT+nPpJwzfZkAY=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:References:
	 In-Reply-To:Content-Type; b=EYrmyXQUKH1bF5sAaBQx1XkeGVU6zS4tAvKLF1tWwsEaOV6dCsFOwbsJcKIurxgMWDoF06wHFp1jd3dbcvoTk94PecXqp0fY34uhcCECqWSdxLx9g8OpRXPJ4RtR9puYx5J9j67bD59uY2Aqm7y9OrmACXp0MgAc5tjoEqKib7o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=JB9P1abG; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="JB9P1abG"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1779954363;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=m1+nanBGUjkzFxxqT4n1xz1WFtT6uBHMYXSCpwbI8YI=;
	b=JB9P1abGSzVMGqrRoGIHgK7FURDgz0iTH26g6Cjnriah3UKuEa15tWdY/XrcZkOere+84T
	BF/OUxCFO4Wuotv+6G/sv0l48jj16j9j/VkebUTNMoFUjrHwzJCE/K43sr2an3Kb0kIdq2
	0hurqzMic5ys66kSr8mJlp4zB3ea3v0=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-122-5FlRXRg2NtqS8QXyLleexg-1; Thu, 28 May 2026 03:46:02 -0400
X-MC-Unique: 5FlRXRg2NtqS8QXyLleexg-1
X-Mimecast-MFC-AGG-ID: 5FlRXRg2NtqS8QXyLleexg_1779954361
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-44d79da8cf7so9251704f8f.2
        for <mptcp@lists.linux.dev>; Thu, 28 May 2026 00:46:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779954361; x=1780559161;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :to:from:subject:user-agent:mime-version:date:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=m1+nanBGUjkzFxxqT4n1xz1WFtT6uBHMYXSCpwbI8YI=;
        b=WnWjNcJdrHAVoaBiucSXDSrU+EYoJFemIGPbBASgj4R7JxnDitdybl5AZq9komXZ7m
         LlzLPOheRyYY+eHBXmbU0An4k32845HKiy4a7puv1Z6/x7zG4/3uagnRjpx36Pd0NYw/
         jiAJITkIFPo1LuT4iMaB74YF35jtxX2niwqeuPSIo8JPh1JDwPf+MFNPB2gfIetQq3Cn
         YhrT9RzO5LNtkC2qgGuBKM84YGlBKIkaTa+pvkeVoY62HpbiCwcJXZKkd11ekE6KTDG9
         4FQTmHQnyMhMFhIXNqMVCJ7nZSH8eSd5iMxleC5gQraEePWazPvUUBPPpsPqyKTpxiXC
         RMAw==
X-Gm-Message-State: AOJu0YxkcBiFn8eCshKYrZuTIiCBn9N8SC5Neha4I6fGjZZixGxbTSkI
	oL6J0GEWySokog65cnF5EuaFfTbLHNTFv1ZeUW1hXaoza3ilYq68MYqHbkI6UEmiJsNgExk4sic
	t3fbCSuwePXbm/V/wkjo3Pm8euT/qn89AaZqPprL08wUm6NVPNYzYKjluTSHABlofdSSQjxBGcH
	/skGS4S9wx8T0kQslNkVA6Q1/r6ir7vIUBZPCzHA==
X-Gm-Gg: Acq92OE7tiIoGsuMPwn1NBWm6heW3plYeu8CwP7ngsWtFXidazTiwKyeHMl/kX5Uv7G
	huHsQ8ZenFMSEvlyvYqywh9ZYFMyG6KYfPagmXdyCrDpCE6F3ViZPyhFQ/v9sFmmfnz0xhOSC0m
	CtcfIs8CJRoHezWFlTmBWK6ZT6AYIgqLNzQjIXSH0dlhtmf4Gqr+/c+gMwOERKDj02Yct6iScpo
	bbyBDA1mBLWgNqLaoNIeQh13c6kaBn5pVGaGQ9iawu4AE/yjDAICDVYezI+FJsTuvmA1ibJryB8
	pGe0J7PVkJA6AJ8aWHvilVoJK9eMC/CAY2/GvlLDUbdzC9UbmVBfBe+PvN2qKH1IV1KE/u+jRAz
	cQmUDZ2HLp6zfIAZqkK0nBsfqjxfjTrBudsVSjJiLSinqdwg31oC7EjcX9iyI47/ovw==
X-Received: by 2002:a05:600c:1992:b0:48a:9428:5522 with SMTP id 5b1f17b1804b1-490426bc7dcmr423695125e9.16.1779954360982;
        Thu, 28 May 2026 00:46:00 -0700 (PDT)
X-Received: by 2002:a05:600c:1992:b0:48a:9428:5522 with SMTP id 5b1f17b1804b1-490426bc7dcmr423694605e9.16.1779954360457;
        Thu, 28 May 2026 00:46:00 -0700 (PDT)
Received: from [192.168.88.32] ([216.128.11.12])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-45edb549e79sm12635253f8f.7.2026.05.28.00.45.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 28 May 2026 00:46:00 -0700 (PDT)
Message-ID: <afc2b2d5-7093-409f-b037-b6afbc16863f@redhat.com>
Date: Thu, 28 May 2026 09:45:59 +0200
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v9 mptcp-next 6/6] mptcp: let the retrans scheduler do its
 job.
From: Paolo Abeni <pabeni@redhat.com>
To: mptcp@lists.linux.dev, "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
References: <cover.1779876523.git.pabeni@redhat.com>
 <f16e4cf87d041b650be81e6e0f072c3abfeeb29b.1779876523.git.pabeni@redhat.com>
In-Reply-To: <f16e4cf87d041b650be81e6e0f072c3abfeeb29b.1779876523.git.pabeni@redhat.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: zW833HrJXZ4qzZhHK7WLt3CnqpNqNbbkg-VnjiuR13Y_1779954361
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

 5/27/26 12:45 PM, Paolo Abeni wrote:
> Currently the MPTCP core enforces that when MPTCP-level retrans timer
> fires, at most a single dfrag is retransmitted. If some corner-cases it
> may be necessary retransmit multiple dfrags, and the MPTCP socket will
> need to wait multiple retrans timeout to accomplish that.
> 
> Remove the mentioned constraint, allowing to transmit multiple dfrags per
> retrans period, as long as the scheduler keeps selecting subflows for
> retransmissions and pending data is available in the rtx queue.
> The default scheduler will transmit a dfrag per available subflow.
> 
> Signed-off-by: Paolo Abeni <pabeni@redhat.com>

Sashiko concerns on this patch is real, and a new revision is needed.
@Matttbe: could you please apply patches 1-4, as they makes sense as a
whole? I'll resubmit a new version for the last 2. Patch 5 is correct,
but makes no sense without this one.

/P

