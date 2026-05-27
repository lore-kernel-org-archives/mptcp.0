Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FCE63C1994
	for <mptcp@lists.linux.dev>; Wed, 27 May 2026 09:50:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779875459; cv=none; b=axCixT8dX0axNYvALmmUQYJmZDAr+oGdQ5+bcAuDwVa1xVoYcGAy4ROH8dkMxyadvAn6P4OIWI2CHMfBccrL3gsbQotQyQAnFTnapjM6VzgpTJNM9OJ4NIPLjMl986cIt5ymlmm9jQx+NN5rW3APsz/Pv57re4WhMgN+r7+qW/o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779875459; c=relaxed/simple;
	bh=tis/N0JpXfBqrh1AolOIkL1Ku2DDC5EX9BtY28TKxfk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=AjkRT8TDFr73pwvatajCjFN8dsKatqngcDm7isKvkLfoI7xkfD4agc6++Ie4Xv7zJzPVftMttXJr8+QNBsJcy7eBcdUR7i+K/R55ayTkpho/2lFANvSdlBqiLcghS39D4ITs4ErHiJ2snP0AkGFqH+kOzfZdaDe5KDFp35J/OzI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=VPNM9Ie9; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="VPNM9Ie9"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1779875456;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=XmXW3eTx5EE4T2Et8LHFIC6kUzyQ2UcTYO1xZmYYvyI=;
	b=VPNM9Ie9exf6iVblUttr/3maV5nystRFqLYB6+d8/A5Mdx8+OKhzUvxIhvvBI1YV8g3of3
	L/dfwRlcjNa6Xib61txsfm/QVGzUp8+2plNsDK9AEj7J4SFYy4g8uZVLvULOePRS+sLgXS
	4i2FxDIkGwgmyoRZPqvnxKB06rEoe+4=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-438-QiJ3V_1oPGW5_piQfiqNZw-1; Wed, 27 May 2026 05:50:55 -0400
X-MC-Unique: QiJ3V_1oPGW5_piQfiqNZw-1
X-Mimecast-MFC-AGG-ID: QiJ3V_1oPGW5_piQfiqNZw_1779875454
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-49045243094so72212255e9.2
        for <mptcp@lists.linux.dev>; Wed, 27 May 2026 02:50:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779875454; x=1780480254;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=XmXW3eTx5EE4T2Et8LHFIC6kUzyQ2UcTYO1xZmYYvyI=;
        b=EkMPCEVXYmnqPFEYEBqCKKtfJ+9hSCI9DsVufoKXPlL16TASryHGLx7e/w5D2nLxgP
         VskCDM036fxlSZH3O58UUkGnHYmbbO574UeQJ19IDc7tSuWwJ4YDTai8LXuc2jV9gEGp
         1z3i91HvLnmm8bz8c/+HmpckUXRElmxlhnnugmigy2tbRZ/5767mVb2dX24qV83V82EV
         +g7Tj9j2Ojthyw8vNDtb/V4RaOcuihr5wiQZGpX9mdM6PjFB4QAuzH3yTSvbiPxOYf0C
         wyuvpS+H1pUp98wurXL+1Ffz5u+Znw4zsRXNZMJugDzNKDUrfTcrWrG3uFQEYc+zUXpO
         VFuw==
X-Forwarded-Encrypted: i=1; AFNElJ+b9i0UsvqkXhr+LkdEFe6MvprfAv//A93OnE0BBwShviux5HiVeR5Bl4YePGhjgN1EnOSclg==@lists.linux.dev
X-Gm-Message-State: AOJu0YxkFr+5KI6RZyMV0bpMiTeatFm9uYNpEEWvLBSfM84nOC/IDCOe
	mKjyfhnnOt4pJ+ypVBW7K3zoNgIUtYH8C/6vBK00YHFuAuoG9XczxZViLrjrvusUMekx2cYRVnp
	Bpam/Izx2+TaM8lAnVbAXNm42btO+YuX0CKCj2gMldfvNoh53MujH2DzejcfCaysd
X-Gm-Gg: Acq92OEQfPzWr7BWPIvBeF/DlShytJ7f+XrPYL+r4gystCzaxba5iNXL3By0pqRvLV8
	a6Gy7wSA+IO8Lqg/IiokE9zR5CjZ/JJYBGqtESsTQza1Yt79m7ST2zCHFhP0Ik65+DOfIuLk0Bt
	9RgFfUkPRZ8lZXuW8JBNu58PnSos05quX5g7CbpIHuQDFfvLb9pGijEI7Dk0tm18zZoQ6w03J6x
	qiE4pvPcC73/wjfAVNuPklG3LjjMyDcyptXzQrWqSK0UmYx2of3yqpZ05vg+pil3CzzxJAN+Wa4
	lHKfuw+zNhtnzfCaMsN9BHhPxbi4dZcxGZMuputn/N7csKQBE73jX3YHiQ4rpCjMMy0EKUBT93K
	iJjxsNnUcjYfnkdk7cGChsCGeNlRYvQs+bz17KOrvhipTpBipu+lhmCAmF1HtW5ct5MVm
X-Received: by 2002:a05:600c:3113:b0:490:6237:521b with SMTP id 5b1f17b1804b1-49062375366mr215364755e9.27.1779875453999;
        Wed, 27 May 2026 02:50:53 -0700 (PDT)
X-Received: by 2002:a05:600c:3113:b0:490:6237:521b with SMTP id 5b1f17b1804b1-49062375366mr215364335e9.27.1779875453459;
        Wed, 27 May 2026 02:50:53 -0700 (PDT)
Received: from [192.168.88.32] ([212.105.153.199])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-490454a0b9asm377022015e9.11.2026.05.27.02.50.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 27 May 2026 02:50:52 -0700 (PDT)
Message-ID: <aeb82448-8e0e-4371-b514-a0b24badc666@redhat.com>
Date: Wed, 27 May 2026 11:50:51 +0200
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH mptcp-next v5 1/6] mptcp: replace lock_sock_fast with
 lock_sock in sockopt
To: Gang Yan <gang.yan@linux.dev>, MPTCP Linux <mptcp@lists.linux.dev>
Cc: Gang Yan <yangang@kylinos.cn>
References: <20260522-sockopt_lock-v5-0-108629a46e98@kylinos.cn>
 <20260522-sockopt_lock-v5-1-108629a46e98@kylinos.cn>
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20260522-sockopt_lock-v5-1-108629a46e98@kylinos.cn>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: mnLQdSUuJfHWD7lYnQljZ7SfWdWwMKvh3AxLhe8f1es_1779875454
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 5/22/26 11:12 AM, Gang Yan wrote:
> From: Gang Yan <yangang@kylinos.cn>
> 
> Replace lock_sock_fast()/unlock_sock_fast() with lock_sock()/
> release_sock() in the MPTCP sockopt handlers to avoid accidentally
> introducing sleeping operations inside the lock_sock_fast() critical
> section.
> 
> This is consistent with how other sockopt handlers in the Net code
> already use lock_sock()/release_sock().

Uhm... I went over all the chunks below and AFAICS no context can
actually sleep inside the current lock_sock_fast()/unlock_sock_fast().
The lack of pending KASAN report on that subject is also a good
indication, it should be quite doable for the tool to generate a splat
should the above statement be false.

I suggest dropping this patch.

/P

