Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A4A12C11D1
	for <mptcp@lists.linux.dev>; Wed, 20 Aug 2025 07:51:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755676317; cv=none; b=VU2oOJNVBvdCSVYdjQT4AHQkPg3/IsaM2X/9m4J8m97euIr6caP3JJsybbNZGJ1fU/xjkyCPZBVUTxK3PPWcODyyz5yWx71spMP4aDwNBozPt843bjy8aWN7XV6npLyyf6GbA2kYq40kWP2p9kArjq6zQ1Tu56hRxxeeOniZLjc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755676317; c=relaxed/simple;
	bh=FmM297sNkwT4HWmevZz7C2RXW1JeH+wqUA9ICqW7Y2Y=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=jn1WERwSoPKLU1QI8pTJG3ONfQ5eTMHyNOd+DmVj9t49hEcqTX3BVGI/X7Zsc7v0jhtGGPJIHuLzQ4coYiiycNEzKM3TYfPg496/5C7CBRWY+J0O81d9gNyQaBF7C5y9k2Q7GKOm/ML+wRPInN2PMbJzeC6ch/Plh/M98yOKKeQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=T7gPGewZ; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="T7gPGewZ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1755676314;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=lTit/sZH/VU1WKGTWQmqcFk2khrzGLEBclHFmHEP660=;
	b=T7gPGewZK64k61DIHxpN5QTZI5iwGQ1BIfJAyNy/kB2ykDDLsahyMB+q2AR0NjR7kfbfZV
	mTP5dwesto5D1wDPEN2bq22UjYd8jLax/+JSHybnqj5LFov0WYaOUZVLNrTOBTM7GblWqt
	PDuM5t6MsxhwrEbDfB2FQoALI/eqK3M=
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-47-k-C5FMgePyuxv2wElepskw-1; Wed, 20 Aug 2025 03:51:52 -0400
X-MC-Unique: k-C5FMgePyuxv2wElepskw-1
X-Mimecast-MFC-AGG-ID: k-C5FMgePyuxv2wElepskw_1755676311
Received: by mail-qk1-f197.google.com with SMTP id af79cd13be357-7e87031ae4dso678643885a.0
        for <mptcp@lists.linux.dev>; Wed, 20 Aug 2025 00:51:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755676311; x=1756281111;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=lTit/sZH/VU1WKGTWQmqcFk2khrzGLEBclHFmHEP660=;
        b=RqlCqyDUm4kwBLBX+i+gpberGxF6qPSOTIKCmzF1q0/OYgKpSin3oyIzMxIjmqSKtM
         5lOMhsT6W1kglKFm2HqSYAosgKTtTX8P+RO4VEkm8z9BB/4rYKo2tUd8KLO2pO5g2znz
         ZZNnsnE/nDAAaVtjl5YmkzhxiKEU7ICGo96Da8/6cmFMI1ScXQ6zIj2qNLbMvCpp+Dwe
         hQoK5Wldu4fDRQZ0Pt8jKqMfY2dT1/SIld2Sds3qooZ0POluXX6A6J4SVJJDQHF9NUMn
         +ON8qFsj0JcL2N0A89oj+AWsXA8vyQ5ZobBB05oNknbod+hjRA4g/htVUAxA+lbPH304
         AD/Q==
X-Forwarded-Encrypted: i=1; AJvYcCXThLJyZPhJ6Gg0+B2p2dVi/exV0xQrXF4J8fAaf53mMc3pm0uzz4Ibh0gNNmbX2Xwc8hKJyg==@lists.linux.dev
X-Gm-Message-State: AOJu0YzGSb+hfEmN0unZ9ZUtmF7w5El2EGaIvQnwbPHTsQCWsU7obG8m
	PswciX6H/2GrxOmjmeK9RjBeK9/FIPDdGaYrpeq67oNJFSw17DkWXwx7pzgXcvPWBSS9Fstbusk
	F3WHWgEEi9EnB3p3p7w5mMSGY3W/uKoqM9MM1i6HnRmh++UqFJSXPmuUa
X-Gm-Gg: ASbGncvdYL2EJcHQXOATOLcE0O6RJUeG1Hjpl71/Vbm4TzHP2Af6+rCyxT4dTNGf2rZ
	pAS4dYbRaUH3W5KDFgBFRbTL2ShL3cTYZCxqk9T4xbbkuWiK5Eg4hCaQbg9PwlxLutrJleBeIb8
	XMBToSLdiyjQ8vGpCqjJ1Lt80Ojxbxjt4zckD/JTG4DTrc7H9tp4xdo2YUT9PwmVZSrBCAsk2qi
	jT7Gh/vVqR1yx0zJysjbS+tsSLIPj1vOtfCboGMPPOCdhvYhWMaeceWkOxIM/+iu3UGD7UvI9qG
	wDI8FN8B6/9pBcSFWP2OFarAZqCuVprKGx67IN1kiAYrIOFZj7k15jQ+lOlL8z12DVQRMKOWEEq
	dofjEFD+bSaE=
X-Received: by 2002:ac8:7f14:0:b0:4b2:8ac4:ef8e with SMTP id d75a77b69052e-4b291c63a04mr23697401cf.73.1755676311477;
        Wed, 20 Aug 2025 00:51:51 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGSsYHhewR0bZJ4BofJwISCIZAUy3vt4+ptjJlY6O/X6Uu/Gv+BgHtp5LAeBDPGxgsaeENEyg==
X-Received: by 2002:ac8:7f14:0:b0:4b2:8ac4:ef8e with SMTP id d75a77b69052e-4b291c63a04mr23697251cf.73.1755676311050;
        Wed, 20 Aug 2025 00:51:51 -0700 (PDT)
Received: from ?IPV6:2a0d:3344:2712:7e10:4d59:d956:544f:d65c? ([2a0d:3344:2712:7e10:4d59:d956:544f:d65c])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4b11de50dd6sm78758481cf.54.2025.08.20.00.51.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 20 Aug 2025 00:51:50 -0700 (PDT)
Message-ID: <b0bdf989-dbb0-4991-aa18-e0ee5039d1d2@redhat.com>
Date: Wed, 20 Aug 2025 09:51:49 +0200
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH mptcp-net 2/3] selftests: mptcp: avoid spurious errors on
 TCP disconnect
To: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>, mptcp@lists.linux.dev
References: <20250819-sft-mptcp-disc-err-v1-0-9d0cf296bc13@kernel.org>
 <20250819-sft-mptcp-disc-err-v1-2-9d0cf296bc13@kernel.org>
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20250819-sft-mptcp-disc-err-v1-2-9d0cf296bc13@kernel.org>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: TiyubN5E0kiyuhVHp4vh0vp7e2V3qiwgZhKvQvfEGQk_1755676311
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 8/19/25 8:05 PM, Matthieu Baerts (NGI0) wrote:

> diff --git a/tools/testing/selftests/net/mptcp/mptcp_connect.c b/tools/testing/selftests/net/mptcp/mptcp_connect.c
> index c1586a7286123a509495ac319fd624b98f0bfd18..00b0307b7da2236fd3ba4ec4b6cec91b6b4b2538 100644
> --- a/tools/testing/selftests/net/mptcp/mptcp_connect.c
> +++ b/tools/testing/selftests/net/mptcp/mptcp_connect.c
> @@ -1251,7 +1251,7 @@ void xdisconnect(int fd)
>  	else
>  		xerror("bad family");
>  
> -	strcpy(cmd, "ss -M | grep -q ");
> +	strcpy(cmd, "ss -Mnt state established state fin-wait-1 state last-ack state closing | grep -q ");

Just to be on the safe side, also add 'close-wait'?

/P

