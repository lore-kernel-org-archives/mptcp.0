Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0BFC1514DC
	for <mptcp@lists.linux.dev>; Thu,  2 Oct 2025 11:21:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759404096; cv=none; b=QWAATcnFl2DTXhIs6ikTL5dCqMkJgJifq8RtyinDkYszrYkOlsJHwEY1EvebxPDOBoOZUydRegK3RxxPOzxUBTNdz5K7Sx+34XjGcBZYevKmnNkql9nlYZ0oWi/Bgkib/BWPJ+4U34upi3UjZlA63ZrPouZdjX2diszo3uATK/g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759404096; c=relaxed/simple;
	bh=3cxRSFnxztdEl/3oe3MZqyfMjZ9kLl6iWNxsJEA9qnw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=W7m3qeFVQOLlhAEJCHFSD9P6IeVGc06EdVo3gwvAzoZZz4H3hzTxxYkyRadfT4UnhW1H7KENnJ8SGj71aDpZJexc6trmILVSFFZl7xbvQedCv5RhAxwd9kWQZ5yhAZ4XjnKv8MHmNSF8UrGtyl9nCl72APKtGA/+k8ao94RmZBk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=openvpn.net; spf=pass smtp.mailfrom=openvpn.com; dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b=Cd9DcAbe; arc=none smtp.client-ip=209.85.221.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=openvpn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=openvpn.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b="Cd9DcAbe"
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-3ee130237a8so634960f8f.0
        for <mptcp@lists.linux.dev>; Thu, 02 Oct 2025 04:21:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=openvpn.net; s=google; t=1759404093; x=1760008893; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=esegZxLK+U9QQi38ZxjBs00HRaUbGD3FZCXde5Cjxmo=;
        b=Cd9DcAbeot+9Z3R1y4paScoteKGUnNUYqdyPguTd4llEUG6qgQ3unrdn++S8pyUfJt
         ACmHPYG4VknEkIYeXmqHbgHgFSdxkRKebZgK6iN4zKcL31XwwwkC9ryLY63GVPmvQtjh
         TRCAUEEWaEVpM4284388I5STOjuQxOEo8xfFr32pIm/y4gj8Yw056wNUeA7u4xPXUWlc
         L4C+PU4VRpgr1s9+rgTA93duXMQC/dbd94eg06W/1L6l2xtxat5IsorlMxv3p+G5TYzt
         eDD9Y/hvlFVUx5RkZvcOAZvi4gYo0DAKPP0a+FvXRYgfLQMEXoRQwdNSdfOOhqKya7Wu
         jdYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759404093; x=1760008893;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=esegZxLK+U9QQi38ZxjBs00HRaUbGD3FZCXde5Cjxmo=;
        b=KllYFMk6pOncdxqu/I66l3u0tUXxU37pZYL3YUHPvjFOweQqL8GOuC4J6MGNulUY96
         v7/kANOhgyZUvwfIsw5VOB64d2OgyfTLJ5qSoiaOa5YZSPXVzt9FhgenIO/U/FOfYb2v
         mYn4nyj8+hVaoPaWe0SH40gC5PEsuewpVdkUs/qBQwcjuyc8F3NUNqqLgoP9YrLaJBee
         jnKtr4DFw/EjdL+TWW1nkDj9mBB8VzNpGuAmuP7UgYFEFiz7LfYKLSFOPgzCutUf1kRV
         e6eQuoebD6sB7p/5HAWGVEd7xUTghYPIouauXDmiXhj5O+SuPmmFbTTxeuFZ66VcoF6q
         mBXg==
X-Forwarded-Encrypted: i=1; AJvYcCW3MiCrqBvnRdKbe920xyVTakYazUL+1rC7w4GIN7BqKGrKOhIqM9emFzXUEYF2ALxvjdvpwA==@lists.linux.dev
X-Gm-Message-State: AOJu0YzYtLGvXf2eYMCXry91j0LFS7aLAVo+tDcauXr+yCikXEJZxziy
	K20IXvJ/7tFVNsenlLbQ6ELVGCljx/U1I+2HLceimKJ4KM7cOvdsgI6cgqmXnvec9+EC8Pad6M2
	PF6ECBTYO7m+gR2rrnBb3iWTrcHE6h1pFyC6Tjv1HcXW0BwQqvQ==
X-Gm-Gg: ASbGncsnTuGervKLHo9xNURtk06Mw6Ezl6+r7Ef6w27apfmZRLpCGCmloYxtEqWBFRm
	HmmtlN9bMcQWaEgTkKvgkXbPEsdduVLiLHU1STTGLVW27TeMfBSDCTRjxYgI/o3E/7PKnXYdGGJ
	ERMgCclDWmh2UhY0ZKXLf93Thl16z9fe9r9uMrr97H+Ov8dSmCLMIvHpeof9bK60GhsNO3KFIT/
	73ui0MVdOGGU0joflTpgQqWinfqj/rXliQp3ZJ/1gdg6cqMBqvAwZb7ogPTIomIhd3KDZdT9qTc
	yWvtKC+6fJUsr064jDDpmaKIle/Nrp/9PjPapoJM7NTxDSJBbJIe21xCf6XluX0vJcqvqsRgIh0
	1qyI9yEo2C7Hru9BGY/CSrHwEsKgGIS6Cv8rbOLq9h/OuxqRxRQhG+xOCvTZ/R2juKw4hjxNOn8
	zUbawsShJN3A==
X-Google-Smtp-Source: AGHT+IGTNHfoolP7+ES6We+KAQbTbUt0PMziY5xH2uTnyMl7liaQQ0xnKzGrdwuUKABeYW6vjPRNyQ==
X-Received: by 2002:a05:6000:400a:b0:3e5:394d:10bb with SMTP id ffacd0b85a97d-4255780b19cmr4417882f8f.41.1759404093053;
        Thu, 02 Oct 2025 04:21:33 -0700 (PDT)
Received: from ?IPV6:2001:67c:2fbc:1:9bfe:b0f3:b629:60c8? ([2001:67c:2fbc:1:9bfe:b0f3:b629:60c8])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4255d8e970esm3214763f8f.35.2025.10.02.04.21.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 02 Oct 2025 04:21:32 -0700 (PDT)
Message-ID: <8aac2981-4c90-45d3-841a-1447aca3931f@openvpn.net>
Date: Thu, 2 Oct 2025 13:21:31 +0200
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net] selftests: net: unify the Makefile formats
To: Jakub Kicinski <kuba@kernel.org>, davem@davemloft.net
Cc: netdev@vger.kernel.org, edumazet@google.com, pabeni@redhat.com,
 andrew+netdev@lunn.ch, horms@kernel.org, shuah@kernel.org, jv@jvosburgh.net,
 olteanv@gmail.com, jiri@resnulli.us, mst@redhat.com, jasowang@redhat.com,
 xuanzhuo@linux.alibaba.com, eperezma@redhat.com, kuniyu@google.com,
 matttbe@kernel.org, martineau@kernel.org, pablo@netfilter.org,
 kadlec@netfilter.org, fw@strlen.de, allison.henderson@oracle.com,
 petrm@nvidia.com, razor@blackwall.org, idosch@nvidia.com,
 linux-kselftest@vger.kernel.org, mptcp@lists.linux.dev,
 netfilter-devel@vger.kernel.org, coreteam@netfilter.org
References: <20251002013034.3176961-1-kuba@kernel.org>
Content-Language: en-US
From: Antonio Quartulli <antonio@openvpn.net>
Autocrypt: addr=antonio@openvpn.net; keydata=
 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
Organization: OpenVPN Inc.
In-Reply-To: <20251002013034.3176961-1-kuba@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 02/10/2025 03:30, Jakub Kicinski wrote:
> We get a significant number of conflicts between net and net-next
> because of selftests Makefile changes. People tend to append new
> test cases at the end of the Makefile when there's no clear sort
> order. Sort all networking selftests Makefiles, use the following
> format:
> 
>   VAR_NAME := \
> 	 entry1 \
> 	 entry2 \
> 	 entry3 \
>   # end of VAR_NAME
> 
> Some Makefiles are already pretty close to this.
> 
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>

for the ovpn bits:

Acked-by: Antonio Quartulli <antonio@openvpn.net>

-- 
Antonio Quartulli
OpenVPN Inc.

