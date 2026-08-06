Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBACE37C91A
	for <mptcp@lists.linux.dev>; Thu,  6 Aug 2026 16:54:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786035284; cv=none; b=INiViadBcvG8FhBWLlcEB9ae5W7CW+f5hjsoM0zwzb7Pu/qIh2g7Zsg80yv/o3bTvNflrPhllkbRBL3wEnLCrAyjVtn8VavyAqIaSFRa/bBKDSgE2cnJsbBcMBb2cOVlCkRRyL7VRhE5joMZpEWuQkPPovl0hxAI+G38FHw01Hc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786035284; c=relaxed/simple;
	bh=ic7uh+aRLDG13y/GDh24irgZyOVruCD0PR2d9lLsVLE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=GiGsvU/hgzW8qcuNEpka75uy6w7z2Ajh827QgxaeGBkz/g83YHaSes8TyR7vqXWxTtWAMfUO9vrm0rwXjt5VQanWVbKL35R1Bxe9YDVEk6LFLSkq5Xph5SX1CbJuoYDihsyCRZ1CkwseBOCou/UxGabUdqZ/hpocwGTC+KzDUkE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=jT2qPijo; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="jT2qPijo"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1786035281;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=61kmOMlZ0SLo6NQSHtnp1AUyEtTSu0NHGuj6AtE3bk4=;
	b=jT2qPijoY20Pq+tUirVkTOTer5ktstzEPT7LiKwoD/TwjGWae9V0gJPRimPk7pzQvg0v8Q
	MOOAW8iwn7WTouXV64jGZJQu/dh4hfeomUXNsGOfibmkHqwh+Sg2wp9OZGEDWsgD2on+ZS
	38EUcWWcySmyaA4EPVo07xzEPmkVzIw=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-371-2gtj-FevP_e16z6eDL-Dyw-1; Thu, 06 Aug 2026 12:54:40 -0400
X-MC-Unique: 2gtj-FevP_e16z6eDL-Dyw-1
X-Mimecast-MFC-AGG-ID: 2gtj-FevP_e16z6eDL-Dyw_1786035279
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-47fe85684b9so2000705f8f.3
        for <mptcp@lists.linux.dev>; Thu, 06 Aug 2026 09:54:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786035279; x=1786640079;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=61kmOMlZ0SLo6NQSHtnp1AUyEtTSu0NHGuj6AtE3bk4=;
        b=UnW36bMcIBkwXpdUX5kSQKzgWh07vK5iMOhQdruZEPXIbeB6B+Jc1q5WkmbHP4ZBJL
         uUKeg/Uq+RvtuZNAUKrM6puQkuIb3SX8VwlHF+Qvnj46AfDuzLVgpQbmblicQHT2I7qb
         49RPjsvnhxAskXkisrUqkXGECQHd2diGcDp3mYuCxUo/oWYUoGdPKYLrhn95WchGY0U+
         2burM4ife5iSHlL3trmskeic171TWbJVsun2YY8bhMM3cWM3rt6x1GgOUUDY4zxFvtcG
         Q1eRWdBNWcGQQj6AwEymH/2OoqMOm9YwU+Lattx12gUCqfzVmqV1hmThM0/9Bw3p9ZMK
         3Bdw==
X-Forwarded-Encrypted: i=1; AHgh+RqBk9U4hYV9vBYSTtczJ81FarYaLNc1cQaw3o6bxmyhAHCt+6DlDFSrJkp/Hox5cTa1diK0rA==@lists.linux.dev
X-Gm-Message-State: AOJu0YwzGlybsQKDxWlQrWYVWLbXcYvjSvYDRcIrbb3u4977xTJ/KYx8
	Cdt8YLcL2zT8wgqDs69VHdy/eDHO8HwC+SLjr8VgxleY561Jvgqr7/bpnIKiVSp3LiWuE6lvyOA
	zoka5wQOU1UCiNEqiq4JKkzTxkwVXbxe1iG0YOiJD/gJIDHWywJmy0/nI
X-Gm-Gg: AR+sD111sI7VpVq1bh5kX6Thrugkqy6tZkOv2x6zC1LnBnI7vikPhGIVOhp9D5NMAuf
	lORWg1vuVk5iihdVVn6GWIX1PwUZePK8P+C1esnaI4SIXmoYJZjgFWOOVtJJZoVX4Ly8vBwZaWv
	YQaq7WxNFoXXQMMbcAPZLwI0qWTYCoQftZFQg//8ZziqIUJ/Cfi0tTzVCagLgVsgt7ikPIETokt
	qcsbvnHL1S8oj/edcrxCUxhHAvjBbRcEV1Jt7MkXHOAxR0PzmGn9wzYA66VuVXi8ZagWIu+8BPv
	qsA4/FIjxfHAxLTlLhf5ABSJaqplreYrRXsqKhZRMZqeeJSJvYoPTLvnzn9asGgl07NNU72b5Ux
	e7xLEr1kE62uiDMYbCnC48OSesTNpIAOIKjpdYNSo9TDHaG5CuF5i/RcojAfZHpKzQLoPdDcVBJ
	0=
X-Received: by 2002:a05:6000:40c9:b0:47f:93b4:2def with SMTP id ffacd0b85a97d-47fec63ebcdmr26222545f8f.28.1786035278978;
        Thu, 06 Aug 2026 09:54:38 -0700 (PDT)
X-Received: by 2002:a05:6000:40c9:b0:47f:93b4:2def with SMTP id ffacd0b85a97d-47fec63ebcdmr26222482f8f.28.1786035278552;
        Thu, 06 Aug 2026 09:54:38 -0700 (PDT)
Received: from [192.168.188.103] (ip239-44-231-195.pool-bba.aruba.it. [195.231.44.239])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-47ff79a7f07sm8076166f8f.8.2026.08.06.09.54.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 06 Aug 2026 09:54:38 -0700 (PDT)
Message-ID: <5f3c924f-6099-4d58-8332-df27e6a6b728@redhat.com>
Date: Thu, 6 Aug 2026 18:54:37 +0200
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH mptcp-next 0/2] Drop mptcp_pm_subflow_chk_stale in bpf
To: Geliang Tang <geliang@kernel.org>, mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
References: <cover.1786007209.git.tanggeliang@kylinos.cn>
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <cover.1786007209.git.tanggeliang@kylinos.cn>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: rgQo2v512dl7pc8XYuY620WVamQ_3nYbLpeKRuDM4BE_1786035279
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 8/6/26 11:10 AM, Geliang Tang wrote:
> From: Geliang Tang <tanggeliang@kylinos.cn>
> 
> Since mptcp_pm_subflow_chk_stale is removed in the "mptcp: address stall
> under memory pressure" series, this patch drops it from BPF to keep the
> BPF tests passing.
> 
> Based-on: <cover.1785943854.git.pabeni@redhat.com>
> 
> Geliang Tang (2):
>   Squash to "bpf: Export mptcp packet scheduler helpers"
>   Squash to "selftests/bpf: Add bpf_burst scheduler & test"
> 
>  net/mptcp/bpf.c                                     | 1 -
>  tools/testing/selftests/bpf/progs/mptcp_bpf_burst.c | 2 --
>  2 files changed, 3 deletions(-)
> 

Thanks Geliang for the quick turn around!

Both patches LGTM!

Side note: I really think it's for the better to keep the stale subflow
logic detection out of the retrans scheduler.

/P

