Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D7D22FF65A
	for <mptcp@lists.linux.dev>; Mon, 27 Oct 2025 14:54:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761576858; cv=none; b=iZz47nXQp5+39Qq3CuQp9D2vymCey57cZzZQKYXc2wHj7tR1NHsmJcAWkeh2gLE1zeWYcmMlO11YLNQr3ec3NxOEMtBgaSLIAUoKB/Ir2MaH99lV3xe/MGJR2zjg/ABGIRCLTde1JhV+wvC4y1DBEiegTU9LTDC3JT/TPcM2bgs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761576858; c=relaxed/simple;
	bh=5NdaGBpWUBKpZqjsdIdsEfMTC39gZMJBS2Sr9q1Zims=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=k786n+kLnxj5KPgBWiyNomYA71U+3jfvo34fqtfn8PHF2kD7z8+WYfvIPr+bz6xpDsILfnDcmV+VJPXsSvw5jSgyFdBM5BUd8PpDhzNGfHFT5JfaCziX0aAX+9OmAUW3d4aOaP+AGm5J5tpNUSSwlhhxb1mvo/tqVIMiwkT1ewY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ic0rvDsq; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ic0rvDsq"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1761576854;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=MpJ/zNe/jAHa/3JNJF+gC4AHZtChraCJO1znVRxECBk=;
	b=ic0rvDsqnMtfraevdsPgLn2U+58P9dAReakrgT46Va4p/jC96qXA0TjC/ltPjDNBlDqRO7
	fRMSZojKhyCd/hkw/smyVtdq3EA7mGPyFy0Qv7rfqv1yK3Djbl32bMEI1btnvf/dhqMBGj
	ff+VOUamB4McJhMTnR6yGResCufoZCI=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-373-iM5bPEUvNnyAxceSvqhz0g-1; Mon, 27 Oct 2025 10:54:13 -0400
X-MC-Unique: iM5bPEUvNnyAxceSvqhz0g-1
X-Mimecast-MFC-AGG-ID: iM5bPEUvNnyAxceSvqhz0g_1761576852
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-471168953bdso44907145e9.1
        for <mptcp@lists.linux.dev>; Mon, 27 Oct 2025 07:54:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761576851; x=1762181651;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=MpJ/zNe/jAHa/3JNJF+gC4AHZtChraCJO1znVRxECBk=;
        b=cO6SF1Djife13ky2Vcb2ed5nVMKjO5yKFEoeYm7lOkvHRrEaXuwPGXYY+RLZ1/5PD7
         sp4yMRGuOZC8GwXcyw7RV1/H1X4id7MeMzkhiwTIUTz/OGKa7Sz8mU6t/Jm0eCZQjmgB
         Pg4JQ2CjdMK25h3cJRAUeE2YkzwVsrAwFmrqEartwdA8Jr56LNSzE87N0RJSTsviHpSf
         GKs6bKA1P3RymB2o7R8nlQ6RfPXCOADpfnMPPTmZbjhHCqNDAUWVFxmAZq92kNZy0icC
         ATox+2Ihjkdg/9enF5yK4Z9IwssdRmpvKw9yREbEjHJS5Y7WyPPdsc5dysO7T94DBu5I
         QVow==
X-Gm-Message-State: AOJu0YweQJs1N0LzzuXbwMB/WQPO5+DUQt8J4XcMxXAAG9FzvP1dnb8z
	1R9TdE3grXXyJGOEJVruo6d9nx5BByjnJUbqQP8+M2KsYD99wy8QVBmcTTqKPYZoEYS2QPID8Qm
	KoEljE+F6C5nbM9+FxxiJa/HuIcieQMbdO5Efz15SvCw0PCLK/mTDqFMnA9t/dab1eXQO3KbvVY
	0uqZo/JmyBpBFUeKWrr96mW5TFDjkJQC5QrT5vAw==
X-Gm-Gg: ASbGncsIE4L62VXrL45f7P8mmWoHYOuVO9bipAyKr66RK/DEI6ipcfsezRfyI9qYyUB
	3ldMkSxhKE3ITqJh/1KcsI6NkoweHr47nlWGGqlQbRHYBoc30+N16VRRVWlSdk3+TTmJR1PLnZY
	shejQ0qUv+M3RodjGtL/ihVnbGcULMz/mOOuovuJ/F5oISSjEkCd4TLWJISLw+2Bq0hmuuPZLwz
	xEvPpcdUzyZtNQaViG8oWUHJX4D5K/H8rJl1H3eF4pzn9Gd3X5PnUhxu3SjOtgXbytoDM0e7ulT
	fcrdYk7XDPdPeHFc5gf3WLkXuu5kW/NaLeokgK8wIq7eD6IvdrRSuJlpghI594BS8Qqt2gp2QbP
	K0cvoSAYD6cjuJOchWmDwLsm+vE4iMG+W4TcXxCxEfWAW+Ic=
X-Received: by 2002:a05:600c:41c3:b0:46f:b42e:e363 with SMTP id 5b1f17b1804b1-475d244d75emr65872765e9.20.1761576851535;
        Mon, 27 Oct 2025 07:54:11 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEui25kgpqHYJ6DP+S/nkw1ImcxPWKLCD/cXDu26m0nGh2YyAnKHuRH3dsmUZ+QpAKEWymZ/g==
X-Received: by 2002:a05:600c:41c3:b0:46f:b42e:e363 with SMTP id 5b1f17b1804b1-475d244d75emr65872595e9.20.1761576851123;
        Mon, 27 Oct 2025 07:54:11 -0700 (PDT)
Received: from ?IPV6:2a0d:3344:2712:7e10:4d59:d956:544f:d65c? ([2a0d:3344:2712:7e10:4d59:d956:544f:d65c])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-475dd4cc596sm144467285e9.15.2025.10.27.07.54.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 27 Oct 2025 07:54:10 -0700 (PDT)
Message-ID: <a46c89f6-8a03-4438-a86a-dbde82232f8e@redhat.com>
Date: Mon, 27 Oct 2025 15:54:09 +0100
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 mptcp-next 0/4] mptcp: introduce backlog processing
From: Paolo Abeni <pabeni@redhat.com>
To: mptcp@lists.linux.dev
Cc: Mat Martineau <martineau@kernel.org>, geliang@kernel.org
References: <cover.1761575881.git.pabeni@redhat.com>
In-Reply-To: <cover.1761575881.git.pabeni@redhat.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: p0lndpeZdCka_bld7lwa1EbXHomOp6k8_KkWg0MEotg_1761576852
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 10/27/25 3:40 PM, Paolo Abeni wrote:
> This series includes RX path improvement built around backlog processing
> 
> The main goals are improving the RX performances _and_ increase the
> long term maintainability.
> 
> Patch 1 and 2 refactor the memory account logic in the RX path, so that
> the msk don't need anymore to do fwd allocation, removing possible drop
> sources.
> 
> Patch 3 and 4 cope with backlog processing. Patch 3 introduces the
> helpers needed to manipulate the msk-level backlog, and the data struct
> itself, without any actual functional change. Patch 4 finally use the
> backlog for RX skb processing. Note that MPTCP can't use the sk_backlog,
> as the mptcp release callback can also release and re-acquire the
> msk-level spinlock and core backlog processing works under the
> assumption that such event is not possible.
> 
> A relevant point is memory accounts for skbs in the backlog.
> 
> It's somewhat "original" due to MPTCP constraints. Such skbs use space
> from the incoming subflow receive buffer, but are fwd memory accounted
> on the msk, using memory borrowed by the subflow.
> 
> Instead the msk borrows memory from the subflow and reserve it for
> the backlog - see patch 3 and 11 for the gory details.

whoops, sorry PEBKAC here. Please ignore. I'll resend shortly hopefully
in a less corrupted form.

/P

