Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EA9C30EF69
	for <mptcp@lists.linux.dev>; Thu, 27 Nov 2025 07:36:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764228975; cv=none; b=t/omROuTw3ZHLQKO91NtAvfonLdqeyy7COmjL9Ff9mtgvpppnrTDga0UjTJaB8zF35PoVySpe74MfbteiNa0acdn8qOtmE2KbDSAegoCxBWPdEJbnGD4FTDUuOQJSsRFDc565VGeAXjLdPYWLhYyfRdHrQ8OxcOHrNha2NHzEEo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764228975; c=relaxed/simple;
	bh=fVCqy5Pmj0BNZpT9YfyDml7PSoJuqmSa1IDFpX47jYw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Lr0NhqPwBKNen4MKf0DoOLbGroqFsluCiXp5H+YF9Hn/LzXiR8Alw8AtGdprW4nrcff/GaaGKe1FWRsELBXBd2fqqDr2BilrwrrEMCDDrvKhlGXSSgdDyJZHeN5i83bnCSQAjSuHLc37Spu6rDQI6sG8zdjlg29dg7RYhSEQb6M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=RWFBCN7Y; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="RWFBCN7Y"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1764228972;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=J4ZR8+jcUTzki51KdxGZRcvOxVx8EyzpA4yovsfmvdc=;
	b=RWFBCN7YSRwyXdsaHSAPLVQzmFUrxgeeCUJPbrhmF/3B6FM2u1vEt5ijruOAZJszScNL+t
	oRq0rGZzxQ+DBDNoVViuOVwmIc+uScX7PHKoRKqdChkEdYveamIuAQpjuh7DzgqqcMEqVx
	0u5hlRCoF4PyJOQLhR8HCbY1h6fR0zE=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-138-XShbRzFeM6m_NYVrdQd0cQ-1; Thu, 27 Nov 2025 02:36:10 -0500
X-MC-Unique: XShbRzFeM6m_NYVrdQd0cQ-1
X-Mimecast-MFC-AGG-ID: XShbRzFeM6m_NYVrdQd0cQ_1764228969
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-42b30184be7so408967f8f.2
        for <mptcp@lists.linux.dev>; Wed, 26 Nov 2025 23:36:10 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764228969; x=1764833769;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=J4ZR8+jcUTzki51KdxGZRcvOxVx8EyzpA4yovsfmvdc=;
        b=mMSXdj4qpjz4PVQ9S5i0Gcv3GMmXLRd3lpWV/bTtYWifDdh7/wiMBG9asIE1DWhVEe
         tu+1FtsUHKxnC1ZxX9LOkhuHQMOIfcXAijKrQWu3IWKc60FMilxOxehga7Q3V+oWr5HC
         6x45O8EAwmeB8EE3CtOqZp3zEypjEyrBmWS8LE1GIzpWi0cYNYlVlwHWVRYf9sV45IhU
         1Lb9hH+8avZ6QvU4h6dea/awG5Lkz/l6tjrEyoX/rg+TMETeigiRFcPHfIsGmTtkar8r
         menYCM6K0x04T0Vv4RtQ4aaW61DQb+mkrgpDCN4YOewm75YNV51lyMlfoiXRncI/1/90
         J60A==
X-Gm-Message-State: AOJu0Ywpiq5/wcv+wCOQ1ybi3OYoiyZLe+6H1y58rsCkGsKbv8O+MBG/
	/ZGJQ1FITSwtU+7YmGeMxHkU7kgS2aWV/EX44D0Dtl4eMYTRAdP+XeLanh9Ud96h/Ai7nu4xgWb
	oa2r7NiYfVbUQMacDEIJ1MA5gvMp4MXWmVnup6g8BZR/Jx0CSSQDHMQ2ccu0vpl65
X-Gm-Gg: ASbGnctyB6HqyjnN8bAqagT9te+BJPxb5WcoWpNAS3b09WNUVcFZMrcyJnA3v3jRCj8
	sSAcqM0cBNUVXEK5w5RA2QnsCkuByoDumgevHzvjeBq/s1X0oxggSExu/2828jbADaXkKJi1MTK
	keaQJgiugMe3FnOWhW2GOTB6h3qjCProWGSLSaKNSt1no3vWujcONZK2nea8xaPQvIdFvH71Gfk
	mYSaYfgVtdWoADl70q/bL5Wh3c8YCc250ltIvenPMWlL6FxOw34gu4tTXI+f13Sat20j4md68vZ
	MallIijmhDUM8RP20ktfKt626Vf5dXYtlNhsEhqC+oZFyptJeJC1nsWmGT8idhmt8JZuuG/5wwE
	iWuMti8M8i6QtSw==
X-Received: by 2002:a5d:64e6:0:b0:42b:36f4:cd20 with SMTP id ffacd0b85a97d-42cc1d2e292mr24952290f8f.27.1764228968577;
        Wed, 26 Nov 2025 23:36:08 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFEdCIuzJIYAMbQy6Hm9GlhNQXAeVi1YVkkwUKGmIwPT5kvBO2BDwdQLX/QcYz+/lScsEy96A==
X-Received: by 2002:a5d:64e6:0:b0:42b:36f4:cd20 with SMTP id ffacd0b85a97d-42cc1d2e292mr24952263f8f.27.1764228968172;
        Wed, 26 Nov 2025 23:36:08 -0800 (PST)
Received: from [192.168.88.32] ([212.105.155.212])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-42e1caa86d0sm1726672f8f.39.2025.11.26.23.36.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 26 Nov 2025 23:36:07 -0800 (PST)
Message-ID: <eeed4a7c-0a8a-4c0a-8785-e0bbb23b33c4@redhat.com>
Date: Thu, 27 Nov 2025 08:36:06 +0100
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 mptcp-next 5/6] mptcp: better mptcp-level RTT estimator
To: Mat Martineau <martineau@kernel.org>, Matthieu Baerts <matttbe@kernel.org>
Cc: mptcp@lists.linux.dev
References: <cover.1763625391.git.pabeni@redhat.com>
 <6ffc28b03d35f1b5698ff9ed6b22bd3e82fc81be.1763625391.git.pabeni@redhat.com>
 <1d606ce4-8921-56c0-c78a-b05c8ebef798@kernel.org>
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <1d606ce4-8921-56c0-c78a-b05c8ebef798@kernel.org>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: DQMNlwAbWPpbrZpXuEPCwGxj3Cvxu6DVoAGjVcquDS4_1764228969
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 11/27/25 3:19 AM, Mat Martineau wrote:
> On Thu, 20 Nov 2025, Paolo Abeni wrote:
> 
>> The current MPTCP-level RTT estimator has several issues. On high speed
>> links, the MPTCP-level receive buffer auto-tuning happens with a frequency
>> well above the TCP-level's one. That in turn can cause excessive/unneeded
>> receive buffer increase.
>>
> 
> Thanks for the revisions Paolo, this definitely addresses my concerns 
> about rtt values getting "stuck".
> 
> Am I understanding correctly: the msk-level rtt estimate doesn't have 
> a direct effect on the size of the autotuned receive buffer, it just 
> changes how often it's updated?

The ties between rtt estimate and receive buffer auto-tuning are very
strict: DRS account for the amount of data received in an estimated RTT,
and computes/derives the rcvbuf size from such value.

If the RTT estimate is i.e. larger than the actual RTT, the accounted
data could be also significantly greater than <real amount of data the
connection is pushing in a RTT>, and the rcvbuf estimate will be
unnecessarily big/large.

I guess it could be called an indirect effect, but a very
impacting/deterministic one.

> It seems like this new algorithm will do a good job of protecting against 
> high-rtt outliers and effects from inactive subflows. It might have 
> low-rtt outliers, 

Can it? How? AFAICS subflow-level RTT estimate can't be lower than the
current wire RTT. It can be a bit slow - due to the sliding window - to
adapt to RTT increases.

> is that a problem at all? Or is the occasional early 
> update ok?

A lower than reality RTT estimate could prevent rcvbuf from growing and
slow down the transfer as rcvbuf limited. I guess there are scenarios
were hitting such condition could be possible, but:

- should be quite hard to see in practice and FWIW I never observed it here.
- the situation is transient; with time the RTT estimate should always
converge to the correct value.
- I think it's fairly better than the opposite, especially on the server
side.
/P

