Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 722E0221577
	for <mptcp@lists.linux.dev>; Thu, 12 Feb 2026 09:05:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770887111; cv=none; b=pXqj/cQa+vTA1u6RKzabAcOUdcmnF+Hx3EItSIxfU6tqUJHF43O/rh3JmgwOFeFp+6tnhVOhmm+rViLM5I403xVGDIjDaFi0bmJXcVNcXquQ+r01c9JWYHQLDZoY4TN6n3YRqBbY+5UcNM1ywmKYPraFWJEjf/nyyhykH4GKnsg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770887111; c=relaxed/simple;
	bh=PIMwn0lQeD54AlfqVjUisRyo9KcZ3/ioVcYjrUV5cJ4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=KRtjbJO05iViRj6l5NfqRto9gEJ3nA+FRQ1HHgF/bWrVfSE7tguZ7Jrr007XLHeyjVd2rbhXvHeqnmGEH4nuw2dZepfpKFIxDdznm1qBsk/ImlazhM7qXIll+D36HybhKjqjNEccskenuNAdtKda69TgSiRatI+7NoW4FAGgMvE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=bzbdJ4V2; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="bzbdJ4V2"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1770887109;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=oGmCq/0t+1aM1E3Eu35avMSnEJdP78yvMvgNvHe5p6U=;
	b=bzbdJ4V2zsNS2Nz7GsiPspcp5c5WmE7CDWfJDnZuMy38PwzkEVyI3mUQZlO6jfjpr83JlF
	Tx44ixV0PlgVpA7/euSJIvjMEAHd9yDwqXX5/7MWHlZYUyVgpWz9ErEukH/bzpauQUnWIV
	dJvHB6PsqL3SZNnDVXioYqVLIwzGAOQ=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-73-HF3pAp6cPymsiWb5Bq_cLg-1; Thu, 12 Feb 2026 04:05:08 -0500
X-MC-Unique: HF3pAp6cPymsiWb5Bq_cLg-1
X-Mimecast-MFC-AGG-ID: HF3pAp6cPymsiWb5Bq_cLg_1770887107
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-43768240a29so1130124f8f.1
        for <mptcp@lists.linux.dev>; Thu, 12 Feb 2026 01:05:08 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770887107; x=1771491907;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=oGmCq/0t+1aM1E3Eu35avMSnEJdP78yvMvgNvHe5p6U=;
        b=JCR7Obzcal8MVojqrJ2GK8kn10QJ+wiC0UUsGiCEU43R9gfkkdZaK1zJrq40VAp/Yg
         JulSGrMzI6fbJkQYFw08ApHTSSpfVXhL4UdKkES3Mp9O6KNK4zDkGl7tH6KCtrmOuIV0
         ZlPHMKReHHYyjUz4BOFRnjvBPaiZiOpTK3MuUYPiK12nSB5vfjvTgjbz/6WjPjEyFf7y
         dM8kXKCVpu8qkaY6FIJV0NZ8LYuUQibRMNpfNyDVnYHju44Y1thyQSEAkh74jb2pw15F
         NmbEFwK9BEY3JOX7HhIwrwBsrAsGw1JFWkdsVIFWUR0YCD+lvulF+0uXccLl2JsCRBsD
         3stQ==
X-Forwarded-Encrypted: i=1; AJvYcCXEwS5BeJLwslCQnfkdiJs+e93L+/BBguhwhOz7phbx9O+G1cRraoyW4PUT6P3Uol8KHYmC1g==@lists.linux.dev
X-Gm-Message-State: AOJu0Yz72rPFxk9p5Y8IIYxKNXurKaDTz3WzvLAHCSODiM7EVAHo3BQ+
	P+nJiKgC40c2MMnmYNOqgMUFeIHTBNZ5DGhlm0cfc0l4xv5jLLzw28k3DILrRJCwBXdD/1Uc2Jl
	s0aEnZr7RuJmPP2SdPu1tIH9oEnutClY69scV3Rd/qEXd4kX4DtuMxqrC
X-Gm-Gg: AZuq6aIxVCS5VsRpmbWzmVybu7bruuXBP6fJ5t9KNhrDQHne22HTAPzhftaTTyU6+KN
	obEWPDAa7sVxCjZWqwtySoZTLdZdb5kYgcf1fdpvD4bZNeYMoahqjyqPAxul14NhVX0zZk6nKkR
	/ut7pWzx4MoQ62f+dE0nUXfVITFEdx9lmRMVZXgyfYH35t0vEgh1rGi6qCHYcJowFiVQZtGuwBW
	9PRWHLx28tDUDTRP25k8zOLklO4XEXwCp72RivjlS+tBghWT5EHOg1xFTSXAhrCf9OJo4LhUOO3
	mn+H4Dt1rkygTlV7R09e50yVYbaDJHKb9y6VQbCAjR3RBLwlIy0WQW31imoGKJszJ2d74/vu9xW
	YKa1G9GuYSF1euLZ9jW2YQ3XVOQ==
X-Received: by 2002:a05:6000:18a6:b0:435:a135:777d with SMTP id ffacd0b85a97d-4378e6eb419mr2749243f8f.9.1770887106618;
        Thu, 12 Feb 2026 01:05:06 -0800 (PST)
X-Received: by 2002:a05:6000:18a6:b0:435:a135:777d with SMTP id ffacd0b85a97d-4378e6eb419mr2749191f8f.9.1770887106082;
        Thu, 12 Feb 2026 01:05:06 -0800 (PST)
Received: from [192.168.88.32] ([212.105.155.220])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43783d746a3sm10962856f8f.17.2026.02.12.01.05.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 12 Feb 2026 01:05:03 -0800 (PST)
Message-ID: <f3235ddf-9d39-42a7-8e44-a847b7402e39@redhat.com>
Date: Thu, 12 Feb 2026 10:04:56 +0100
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC v2 mptcp-next] mptcp: support MSG_EOR in mptcp_sendmsg
To: Gang Yan <gang.yan@linux.dev>, mptcp@lists.linux.dev
Cc: Gang Yan <yangang@kylinos.cn>
References: <20260203023029.855434-1-gang.yan@linux.dev>
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20260203023029.855434-1-gang.yan@linux.dev>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: YAtbL8Gt2poKu8Cyhu1y3kKhzA3YI4OQtL8HsdC5BpQ_1770887107
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 2/3/26 3:30 AM, Gang Yan wrote:
> diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
> index cd5266099993..8b243062009c 100644
> --- a/net/mptcp/protocol.h
> +++ b/net/mptcp/protocol.h
> @@ -267,6 +267,7 @@ struct mptcp_data_frag {
>  	u16 overhead;
>  	u16 already_sent;
>  	struct page *page;
> +	u8 eor;  /* Is MSG_EOR marked? Prevents coalescing with next frag */

I'm sorry for the late feedback, but the above will waste quite a bit of
memory due to alignment. I think you can change the 'overhead' size to
u8 and place 'eor' after such field.

Such change could be paired with build time check vs 'overhead'
overflow. i.e.

	BUILD_BUG_ON(ALIGN(1, sizeof(long)) + sizeof(struct mptcp_data_frag) >
U8_MAX);

/P

