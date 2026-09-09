Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F3E657982A
	for <mptcp@lists.linux.dev>; Wed,  9 Sep 2026 15:54:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788969291; cv=none; b=OrVRQfjS65gQoDAKQVBMBAJgr3pY28tLdO/zHxWI6YOQNmMr/ebSXuGiRVb+Xx3JDun3haLs6D8xIA3CCybp6f1rNkoQEi9YJ+YmdJuJZB/N6gtDfr/MWuu+7pvKtjb3+W21t5iZZdHU7Lh6egPL8NJuTHpvRltLTpwkMMmy6mA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788969291; c=relaxed/simple;
	bh=ZS57qCJaJZzvLtWT5rb+UsgkBAE6cq2kv5Ow6zPtdvU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=RbAF12X7SMzKhKNUpfOxS5WWAiJVoX0TJAaAGhFD2XvRY+ug5Hcntcw1IShm/QSviFbjaYw0H3hYQSeJ1Sfe+UW712L6VgX6hKY+j6OfIY0eMH9id3hUcV8ESsU/RpWcDxkdNcViQexL+WB07f2V1HA888biF6yKQE6pKlDBTZA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=L4UAeOFQ; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="L4UAeOFQ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1788969287;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=QhAkYk+BLfXoLVmp1k/Z3VniIpgJgKO5MbxyHejQ6HY=;
	b=L4UAeOFQGyq68TxaHe7SBsuVD3GQiFvWZfFHGWsTpKhzwa0v+jkdfAXdQufpYsEiwr43KT
	2w3K1wJargQ91Q+sJTATnCKBw6sIeFHDNT2uNi7IMZzEI4pFYJv7eId49WBN1aMlRJd1Lf
	JMK/R47FZw1NkXwkSaR31NC9SXLHODg=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-647-HuvVs-ptMouX_KfjWYy8aw-1; Wed, 09 Sep 2026 11:54:46 -0400
X-MC-Unique: HuvVs-ptMouX_KfjWYy8aw-1
X-Mimecast-MFC-AGG-ID: HuvVs-ptMouX_KfjWYy8aw_1788969286
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-485afdd5079so731833f8f.1
        for <mptcp@lists.linux.dev>; Wed, 09 Sep 2026 08:54:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788969285; x=1789574085;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=QhAkYk+BLfXoLVmp1k/Z3VniIpgJgKO5MbxyHejQ6HY=;
        b=Uo40TLXuUPvUtuMSunYq9LqdKipLFG9hvt9tufJHCyGpQUpC+J7LPtApX8+yIKMPP6
         3Ofoc6G4pvJHwkc3qMBG+t/BEnMvqyBe+RFkocpYoiWSKEhnM+p84i2fw6YqRZHyzaps
         KqT27QRiW6GkzNRq78YQVO1v/QKQC6hjXI+mFbdsEdl+vzWuTpiWwDL3+NWGZ96uOa0J
         bZ+F7LMJFLgiio5H2878zS7VYS/1mzODVHSkixQTWcoz+Gg+CIUzNsCMaXQls6y6cU1S
         BS4PILqf799eIkJVD8BEUo0K1gViMI6+MiW1UNkjhAZy/gSfHWKTiD129TBibz5sDngL
         hbQg==
X-Forwarded-Encrypted: i=1; AKwUvBxAdpOKG6SBNJGFb4iDLGaHCoQV2rhOdxq4Kyf9h54VA+wfgURyoOxtPNpc2GBVIerdlqdDrQ==@lists.linux.dev
X-Gm-Message-State: AFuF++lEU7VRX7MgDeTw6sRHnYUt7USPTuY+vDbByS2KoIZTPnC5vI/2
	uzo9iqFTrjpEJ8Is1Sdb6WJqN7F8KL1U5tkJtxOfZxJ996WdXPyBZod8gI/znoyACIfrv32wJUE
	HfpEcqu/+nBBDgj6c8GnqjR/FcqczpZU83YsvqcCKv9/G3nuJz3h1Qhiw
X-Gm-Gg: AYBFou2RbDl2gff/E6qAaippsq5JnYBxoKw4WpbayOhs0GsEU37EJiYPy54UktKRWmd
	pICEaEtYLnskfMWbRqTetkvaaEzeTLYPevQsg44o7tXGSob/iGaZDY7rrDW6nSIzqFNkCUXnBXd
	VTd3v9W4/jlzqijTQnUqGVEoBkNI0J1gpd+qmwBFN+/yy2peAMJZAa7ESDGolhPznzHGdOhXpG9
	JwwXIHSIg4fKbMTN5ih02s/o4BT+rY9bJgVJsUQMB3qJYR/tJlNzzI5ve9ATUBRp5kwvS/yqwFm
	V8h1VQYtPOtKogsxh9MTdrKc/oilE7b7+3P9Tb/Qr9HzjT7SJt4UVzU5E+xlWTO5NQgKmjeYm+z
	VnSc+rUXBXZuJkE5ecgOA/GTwzERewIANq6D+TIK//PtT/EJpqMgddwb42jOxDnwv2GAQF331PA
	==
X-Received: by 2002:a05:6000:288e:b0:485:8c16:a33f with SMTP id ffacd0b85a97d-4858c16a5d0mr33596603f8f.52.1788969285542;
        Wed, 09 Sep 2026 08:54:45 -0700 (PDT)
X-Received: by 2002:a05:6000:288e:b0:485:8c16:a33f with SMTP id ffacd0b85a97d-4858c16a5d0mr33596570f8f.52.1788969285051;
        Wed, 09 Sep 2026 08:54:45 -0700 (PDT)
Received: from [192.168.188.218] (ip232-47-231-195.pool-bba.aruba.it. [195.231.47.232])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-485883be709sm44531453f8f.21.2026.09.09.08.54.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 09 Sep 2026 08:54:43 -0700 (PDT)
Message-ID: <03f37b1f-a115-4c63-bdb1-7467ae8b165d@redhat.com>
Date: Wed, 9 Sep 2026 17:54:41 +0200
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net v2 06/15] mptcp: prevent race between disconnect() and
 rtx
To: netdev-bot+sashiko@kernel.org, matttbe@kernel.org
Cc: martineau@kernel.org, geliang@kernel.org, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, horms@kernel.org,
 netdev@vger.kernel.org, mptcp@lists.linux.dev, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org
References: <20260908-net-mptcp-misc-fixes-7-3-rc1-v2-6-df1de70348b6@kernel.org>
 <178896537655.219967.3201901026877077910@kernel.org>
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <178896537655.219967.3201901026877077910@kernel.org>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: gHfOy4myhjfYG6yGhZXgnhCakWtPoavZD46dmRNbT80_1788969286
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 9/9/26 4:49 PM, netdev-bot+sashiko@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 2 potential
> issue(s) to consider:
> 
> Critical: 0 · High: 0 · Medium: 0 · Low: 2
> 
> - [Low] The commit message of "mptcp: prevent race between disconnect()
>   and rtx" describes the change as only "Prevent the race using the…
> - [Low] The commit carries "Fixes: b29fcfb54cd7 (\"mptcp: full disconnect
>   implementation\")" (v5.18) for a real race that can leave a reused msk…

Here the code is actually just fine and sashiko don't like much my prose.

/P

