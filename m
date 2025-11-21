Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3DB31EB19B
	for <mptcp@lists.linux.dev>; Fri, 21 Nov 2025 08:45:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763714733; cv=none; b=aCOrsyh+Xb5pjRzUmC9dM1vgTaDOdwB6gcjDaJiORN4vWQKbM/Xf/0iez3xGTyRfRNVb8z3hvXADStG/VNH5C0Chsv113yoxiYv2QPCUOEJNlTspuIoDTaTBlD8FGC9DkYU+KP7WLfFpox5oB+cBHFxg7fE6YcBaJHwy73qI9cY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763714733; c=relaxed/simple;
	bh=DQbyvtdwyq6NPA+16MTLYVILx4r7IW7gMp7AJE2ubvM=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=kuVZQRPyHCKCdwp4SiAaCQUruwZZRecOesNt7L7pvu52awK9vrAsuhwVMGf5ey3oZnF83njPTSWAos6n8yxcJfOnlC1wBwhGtI5YGt2qzpdXNg5G4hOuI2OPdtqL3aI6A4qXtmiO6BZfmsx3tPsLdxZNoeta9DXrWG07JOLiJ34=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=BDM2FBxM; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="BDM2FBxM"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1763714729;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=VpMuMuX/Fj3w+W9JXG/A/LBtJO9Hqd2CV8Wyyo4xje0=;
	b=BDM2FBxMJ4TrNq3KR/0wiHLgFVueYFhqgMORPkhVfReBBl5rp3Fdze7t2dKOvZC1K78gRC
	okGd6pUu0h9aLRjvFjNoxUxvxp11qMjkbkO9Qa0pyg9z3yCeLpJwzjdaJ9QuXB4hLBBQiZ
	3bPjIMy3iNVpcdlR+F+b58AwihCDDgw=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-673-kpHgofLNNrKCKiUHkNki7g-1; Fri, 21 Nov 2025 03:45:28 -0500
X-MC-Unique: kpHgofLNNrKCKiUHkNki7g-1
X-Mimecast-MFC-AGG-ID: kpHgofLNNrKCKiUHkNki7g_1763714727
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-47106720618so16081375e9.1
        for <mptcp@lists.linux.dev>; Fri, 21 Nov 2025 00:45:27 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763714727; x=1764319527;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=VpMuMuX/Fj3w+W9JXG/A/LBtJO9Hqd2CV8Wyyo4xje0=;
        b=jHO17TR4WaFwm5nVmLMXjD02IebUc9LYTf1Jq5hXixGDJjKEzJDkkL1FRaeKT0SFtP
         FTSPl/YuWS8+swvZShCoZVmxiHIqCy0J0FOJc7hMREw+KBHsD9f+F64vADBgVJd718+2
         AUs94YijhSYSTusE7pWlaZHaDkrd7+DKCFpyHvVF+KUVysv0iphHQxqUd/bBp9AkeXpf
         RrbWlX0TJ4WkVzq1gqJhl+c7aWe2cpe1p/R+HFuL0OUE5DDIaJkv5KjOq7wWwo2xIIKs
         1KcSp1d/3WGy9Odwbk3Du52ERXpFaKDe4+oDtCzcsOQslj7FDb6Zni2dpQ0mkyON9ywt
         70ZQ==
X-Gm-Message-State: AOJu0YzTI3N5Eak6DE55MIyONnb1dZu3Kj7XbIn7hvtrz4zAw0Qe8hrj
	e0t1ev/+BNosHNEkrRg5PaLbDXUrD7Sa3L7wwlCfzpHAKCW0S6tAtP7ZEDzrxbLAJzoOaEtheHG
	odvTc5iKoCPOYEhniS+x6FZJrs8Aav3ht8YYcrV1CdGHvE9fRJWx2Iywi1ULNTpoK5AnJYxUyw0
	wwn2BGmL3DXyjJlL4VnyiceQfux9C9c6sTd3UC0A==
X-Gm-Gg: ASbGncua9jFXHT6bT2IBmLZulLsC1NicLeEXrn8At+Iuj6afjQNzpHvIbPPs3naa3XN
	1S5DdoCs+KHs298E2jiO2osQ/+fEEHCX4dcREshtIEd49ZUE2CpRG1lNtl38tJmOU/e6zl4rBUx
	dMTOQ4kjD6SJMI062UxPBvK7f2zhMg53sGN6SUki/6hr0iStO4Nv2A3QA5/EnqTK04eEiIO/B1A
	4wJXFbU6a/wdzpC/0R/uSMEijTrWHIYY/d+OldaOGyRG26Md12QnUOdRwbdO2pXOYEEGug9z1Y/
	7cCAEa5/guF0eLXH4qxvOsVYULKieR271QBXJHOSCwOKTq2UYGS4BGtYS7KcLtmXnkxuuzMC3Hf
	R4kRFRMWDsEw3BQ==
X-Received: by 2002:a05:600c:1c8a:b0:477:5af7:6fa with SMTP id 5b1f17b1804b1-477c01ff636mr15161325e9.32.1763714726682;
        Fri, 21 Nov 2025 00:45:26 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEPcGX/3U644GGRl3++iuedCCxmRJNyPQGOpjDvxxC0ArGOnKnriM/m9KtgPCIYOsCLfBkBhA==
X-Received: by 2002:a05:600c:1c8a:b0:477:5af7:6fa with SMTP id 5b1f17b1804b1-477c01ff636mr15161055e9.32.1763714726291;
        Fri, 21 Nov 2025 00:45:26 -0800 (PST)
Received: from [192.168.88.32] ([212.105.153.231])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-42cb7f34ffesm10630281f8f.10.2025.11.21.00.45.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 21 Nov 2025 00:45:25 -0800 (PST)
Message-ID: <1788272b-b2f0-4b11-81f2-7d7f057e86cb@redhat.com>
Date: Fri, 21 Nov 2025 09:45:24 +0100
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH mptcp-net] mptcp: clear scheduled subflows on retransmit
From: Paolo Abeni <pabeni@redhat.com>
To: mptcp@lists.linux.dev
Cc: dcaratti@redhat.com
References: <30e5325f37026b870cd0d0765d5d47c8a68fced9.1763676964.git.pabeni@redhat.com>
In-Reply-To: <30e5325f37026b870cd0d0765d5d47c8a68fced9.1763676964.git.pabeni@redhat.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: 1z1O_CT166HeHwtg20gwbyJzPjq9JtRSdW-ZWJ2hvt8_1763714727
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 11/20/25 11:16 PM, Paolo Abeni wrote:
> When __mptcp_retrans() kicks-in, it schedules one or more subflow for
> retransmission, but such subflows could be actually left alone if there
> is no more data to retransmit and/or in case of concurrent fallback.
> 
> Scheduled subflows could be processed much later in time, i.e. when new
> data will be transmitted, leading to bad subflow selection.
> 
> Explicitly clear all scheduled subflows before leaving the retransmission
> function.
> 
> Fixes: ee2708aedad0 ("mptcp: use get_retrans wrapper")
> Signed-off-by: Paolo Abeni <pabeni@redhat.com>

I forgot to add:

Reported-by: Filip Pokryvka <fpokryvk@redhat.com>

/P

