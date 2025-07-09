Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D537D28CF47
	for <mptcp@lists.linux.dev>; Wed,  9 Jul 2025 10:23:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752056600; cv=none; b=QxFsDRA71pXsnly6NCOzdZu6XsDHmNVLNa24MRo7rBHzb2BCFDUpOd3DKpqLPljfy6r9+OTHZp7VwTcM04XuRNY9glYFKNOy7KWCyzVG2wfGYEgW0VVaCfsySisYy38+Kw5oFE7dZ3XV8oV8HxxwP1pmCF8E9vhliz4KLJtHZ+Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752056600; c=relaxed/simple;
	bh=KUoC0IyG8/5c+c0tgPZz0e27BGEBx7LcT1KXerUDlfE=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:References:
	 In-Reply-To:Content-Type; b=tVH5ozNQ9nK/gn98VMdJ4K1rjdygOVJzZqzqC4p8NssPdwRyh8PyMYgT4UXJUe9rzOvioUnF/HfklXSSMF6lZvu/aMvK+OBhA/RyvBgA1XDqBQ2gUD0t32L8Vrpb8ztVpV/bi1tebFguxSl1yfGTiRZKNwetFyTnetttxahq5mw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=UvUyuxSZ; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="UvUyuxSZ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1752056597;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=KUoC0IyG8/5c+c0tgPZz0e27BGEBx7LcT1KXerUDlfE=;
	b=UvUyuxSZgx0aetPmsWFFWTOKaLjnkYjXfUcr299eTtibqv8sVTQW1xxjLJdsLYjWwiw79Y
	aBQTX7f5SPkKMbkC+4jPVFukywHLyYha/ZpMsRh6lzrSPWZeCTlASvo5ipaAV8u+f+w5ox
	cTe25MKB8+xAF0ARd9xxUdNF8e8pOcM=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-150-PbvpP2wwNgqqV0BqH2O0mw-1; Wed, 09 Jul 2025 06:23:16 -0400
X-MC-Unique: PbvpP2wwNgqqV0BqH2O0mw-1
X-Mimecast-MFC-AGG-ID: PbvpP2wwNgqqV0BqH2O0mw_1752056595
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-451d30992bcso39518715e9.2
        for <mptcp@lists.linux.dev>; Wed, 09 Jul 2025 03:23:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752056595; x=1752661395;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :to:from:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=KUoC0IyG8/5c+c0tgPZz0e27BGEBx7LcT1KXerUDlfE=;
        b=AEGcQ1ympCpY1XD1+Hk+Eqh7r19o7+YjfkRrasNV5dYL7mk9xenN7JfLvl05woKJGS
         x9HEwmujzizEloV5caMNamN5O/+smdizF2xN0CNAhg4U5+8sFommJHlWor3O5dtFl19F
         6ECeNgV9+RUJZ1OvrVn9grO1tpPuWJdGwuYHnASw1+sH745QQ6YZq+OB/te2V+nZi1WB
         x/6l7KOx4dj6XakZ9HPkt37zLuvw2fUy+7D5vreIi38vFm+FVzheyK6Cbj3Dz9CtX62q
         TVr2oCrXAfYE/ieSFU9P8eD4echPVJ+T7TB+kZQObRLJCVkLm99AxGM1AxmPT7NF+RIT
         Visw==
X-Forwarded-Encrypted: i=1; AJvYcCVvzgnhgmvrsBzHHJ4Oj7m9/AWu1DD2DFTFh4Jp45kqFG1bjiv+FeiQ2jleS6L7aQLY6InemQ==@lists.linux.dev
X-Gm-Message-State: AOJu0Yye4SL1+tNGgxLZyjeUMh3YOPqQFkR+KIJLCvj138iee/htLL3D
	C1FKI5m2BJk65aVNKWoh4rFp1P6V6YvjicGlenc0lbl7AA1/UKTRHg8aau5KRrAliBs7aLBv+1G
	7LS4UUPNUBR/fBOViIye1l7b4XMkTih4eI8CyxukHIsaPlvWCB7Kt2+n8DEWEp8PO
X-Gm-Gg: ASbGnctkcLFzVMvCj9tvmo0B7F+RlQFk5GTlK9J/PIAKlRsMc3yG0Sf12sazQDeQKDT
	eR89zS4wNAIubDSar7HNpFBZOOqbs+bW6z8IyVXLVqUUUiRWOKhjKFgwksLMrTq3LNMVW4DNMKe
	1/hVkEoRQxpmsBeaf97QzujBukcfPJG2sUHL6rai58gAe69tv8Aeg1ia0wnliDkJ9ng2J5wWbXB
	m2w0SzGz8mIxnyMs2GFHKhYoD1BU/qhDQNhWPjTmHftPztF6vKKqj1Y/oQvN0XlkowOEBD93s79
	DxgPZjBTxWY/iF+ZKVyj6tMxIXZwx7TvUFYzhJzJinqQx+tU5guHlgNvzMsYSEywKi2PKA==
X-Received: by 2002:a05:600c:548d:b0:453:5c30:a1d0 with SMTP id 5b1f17b1804b1-454d53ae0a1mr13384125e9.21.1752056594903;
        Wed, 09 Jul 2025 03:23:14 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHIZC3hrujNSnn3+pgOD5OCMUmRYg4GSn35Zur/lNdbMFqoHDoxIKUjJgMcOmX4TGuv9P7nrg==
X-Received: by 2002:a05:600c:548d:b0:453:5c30:a1d0 with SMTP id 5b1f17b1804b1-454d53ae0a1mr13383885e9.21.1752056594438;
        Wed, 09 Jul 2025 03:23:14 -0700 (PDT)
Received: from ?IPV6:2a0d:3344:271f:bc10:144e:d87a:be22:d005? ([2a0d:3344:271f:bc10:144e:d87a:be22:d005])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-454d5070691sm18640535e9.29.2025.07.09.03.23.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 09 Jul 2025 03:23:14 -0700 (PDT)
Message-ID: <3fbcd96b-5542-45fc-b041-e4dc302f3d2a@redhat.com>
Date: Wed, 9 Jul 2025 12:23:13 +0200
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH mptcp-net v2 4/5] mptcp: track fallbacks accurately via
 mibs
From: Paolo Abeni <pabeni@redhat.com>
To: Matthieu Baerts <matttbe@kernel.org>, mptcp@lists.linux.dev
References: <cover.1751699999.git.pabeni@redhat.com>
 <5a78b3e0fc95d2f6356ff4754ec3bdf1dcf6b2cc.1751700000.git.pabeni@redhat.com>
 <a6b76e9d-b84f-428b-b0bc-bc9d9aa782f7@kernel.org>
 <279b70c8-603a-4fda-af5e-30cf4df7ebed@redhat.com>
In-Reply-To: <279b70c8-603a-4fda-af5e-30cf4df7ebed@redhat.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: dDYKdBNqiIjPdu5tHpDB6FhKPW8-YNtT_kHxlq1hn3k_1752056595
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 7/9/25 11:55 AM, Paolo Abeni wrote:
> I'm ok to rename [__]mptcp_do_fallback() to [__]mptcp_try_fallback(),
> but I would not do that in patch 1, for backport's sake.

Actually patch 1 already touches almost all the the places where
[__]mptcp_do_fallback is used, so it should be fine to do the rename is
such patch.

For consistency with other MIBs I'll additionally trim all the '_' in
the MPTCP-specific part of the newly introduced MIB name i.e.

MPTCP_MIB_FALLBACK_FAILED -> MPTCP_MIB_FALLBACKFAILED

/P

