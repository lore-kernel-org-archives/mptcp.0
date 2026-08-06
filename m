Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A26F9302146
	for <mptcp@lists.linux.dev>; Thu,  6 Aug 2026 16:41:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786034514; cv=none; b=Z34rsaEbbbsET8WigaqjOyQMutn3zETyi6IohlwjqOcRUv8SNhSotZBrqQ0Wxb9aEvChCv2UCTrNyUaKbDjR0vU/JddwVBHAxpa3OUKkvRgWPeruYA/BI/r2TeCFM6udVQy4K35H9VkCKXPRN8xKcB1kcTZ8VpApJ3boOSRxaMo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786034514; c=relaxed/simple;
	bh=Hu7Z1Djomapl/2a764LMJSY2lD/erphh+5xXfXaVKcA=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:References:
	 In-Reply-To:Content-Type; b=I6mMIyMjPFM8A20BD7xFTHiiqUy6hoqrCIqOSOZdq1x96TBs2l7DB8Ot2gGccIN3x/JqHNPVnjqHOO1JbYjSqTFShKUPtB3sO1dRzDyUpKz+0u00xmPX7FTEi+4G1qX+xSKaVkb5GGX2BrGjFJZjByokmnBYzp+eKfluExrG02k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=R83ISTjL; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="R83ISTjL"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1786034511;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=mMn9sWAdyD4gLSwmqHDd/tMXaPlJA3rWEt4Q403S078=;
	b=R83ISTjLVFWy/nTTg8sShNLGmEQEA6URX8+eqWUe3hljsuKuzBzAnCjYZBTJVbxVG1ayFd
	69JFLSvRASMT+85TJ3kBDJZyQW1BgZXmFwn3woMBI7KAxEOC6TwvXxJ5lfh+UaTLgqYzfO
	WqK5VSL4L14RfqT30usc5d0H9w8rvZI=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-659-CxvUkpmRM9SxQ2j9mZcyyw-1; Thu, 06 Aug 2026 12:41:50 -0400
X-MC-Unique: CxvUkpmRM9SxQ2j9mZcyyw-1
X-Mimecast-MFC-AGG-ID: CxvUkpmRM9SxQ2j9mZcyyw_1786034509
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-496bbcf7d1eso15023735e9.0
        for <mptcp@lists.linux.dev>; Thu, 06 Aug 2026 09:41:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786034509; x=1786639309;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :references:to:from:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=mMn9sWAdyD4gLSwmqHDd/tMXaPlJA3rWEt4Q403S078=;
        b=UVsTygyd+cwlTu2QAFsjDnjtwhI7X54BneirMNPxLL8azrTonsPQSc+Ocgi/l8Qkbg
         ouHSxdahs/3FF7qD55k7NPGl6oSvbHZjiaFaUZVXtUVidodFeyG2h7He484ANjei7x7j
         Vp1B+/2c/OUtqNVxyXlayGOSQY5WnOG9R60/4mY4MUiLoDKDwR3NcnhDfGv4rmKrOQZ3
         k9Spb7m/m/P1GBzDdgLuI4t3uWD0uJfOfRVF4bb1qSI/KXqU38eeiH+NIscFa7+iSzA4
         mWVZ4rgbVgbicEL16TyyI/ozHNQN0IDyxCi0XVxzt/TIAUA3/TEr0sdviXREgBS/7759
         4zQQ==
X-Gm-Message-State: AOJu0Ywj+Zdi15n6CmXIMjJzAN1K/KLTNSUIDjfXSIzfSBEscs3hOs28
	jYh6vO541cmF/B9prC7usKutB7Bp+2QHNSZD5Z+WmJNATJvqesxrbheaeNuxW4ZMhkeHV6/GLde
	bnEIe8r61KuikHk1EdFSyzmyOvaUUyOkNPBF1fNEB1/NptRCLJnDeRvYeTh+nKq5XePw8j4Eauk
	KtizFGOYOBRNoKJHPMBOaoIsPZ3U4SKxGI2RZmLw==
X-Gm-Gg: AR+sD10cRBtU7BFSQtHMyR765ZzsDnEEn5g6rhAUHdYFMA/etd4It8KKOI8pL1g8/XE
	Rm5SjvgxPG5NQEbn762+JhSH9eSkCutO8WPu/nu7WHIYrGNvNeF4Q6HAwLJASN5qws+MLZjHUb4
	S7JXbPJD3JLLptJhaVRNMWv7hlNmM4lgXAWKz0EbyL+KC1QIB4392VThbHbCTu+ywQNP6t7YsUc
	YcGlnYuRyuKVqFqiHC8wLNUmif8/kc3PbgmqVwl/9T7ERcP7NaGEZ5YFJv3jCOawwJ+9/JCqULR
	T2sbhzPS81aEhOHKoYzH0qITHBLuuQB8Ie3oKNKlrQPvAtAdqmgfjTp9DnQF1YaGeGccz0U6ilk
	JWIWYakqD4DsGFzQkaeOfhpS0xgAM81s83wy5Sdf313YKmuyMouBDVvEwcny2hwBHScZRH0qBMs
	c=
X-Received: by 2002:a05:600c:35c4:b0:499:4dca:aa4 with SMTP id 5b1f17b1804b1-4994e70ed73mr220576995e9.4.1786034508910;
        Thu, 06 Aug 2026 09:41:48 -0700 (PDT)
X-Received: by 2002:a05:600c:35c4:b0:499:4dca:aa4 with SMTP id 5b1f17b1804b1-4994e70ed73mr220576125e9.4.1786034508399;
        Thu, 06 Aug 2026 09:41:48 -0700 (PDT)
Received: from [192.168.188.103] (ip239-44-231-195.pool-bba.aruba.it. [195.231.44.239])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-499542853f8sm76305395e9.13.2026.08.06.09.41.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 06 Aug 2026 09:41:47 -0700 (PDT)
Message-ID: <f600ca63-d238-4340-a8f8-f5d2391d1e9d@redhat.com>
Date: Thu, 6 Aug 2026 18:41:47 +0200
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 mptcp-next 2/7] mptcp: move the stale logic out of
 retrans scheduler
From: Paolo Abeni <pabeni@redhat.com>
To: mptcp@lists.linux.dev, "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
References: <cover.1786026372.git.pabeni@redhat.com>
 <0a81a4bf60008faefdd1688012b8fcebc291a4d6.1786026372.git.pabeni@redhat.com>
In-Reply-To: <0a81a4bf60008faefdd1688012b8fcebc291a4d6.1786026372.git.pabeni@redhat.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: 6mil0EOBbSH8mzRzYIqPNry2Ihy7zkJYynW0fbMT82E_1786034509
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 8/6/26 4:45 PM, Paolo Abeni wrote:
> This allow separating the stale logic invocation and the retrans
> scheduler, and will simplify the next patch.
> 
> It's also a cleaner design as the retrans scheduler has currently
> too many side effects. As a possible downside, the retrans work will
> now traverse the subflows list additional times; that does not matter
> much, as this is slowpath.
> 
> While at it, pick more accurate names for the involved helpers and
> explicitly note that the per subflow stale data is under msk socket
> lock protection.
> 
> The scheduler and the stale logic may observe different subflow
> statues, as no subflow lock is acquired. This is intentional and not
> harmful, worst case leading to slower retransmissions.
> 
> Signed-off-by: Paolo Abeni <pabeni@redhat.com>
> ---
> v1 -> v2:
>   - fix stale lockless access
> 
> Note: BPF scheduler should be rebase to use the renamed helper
Additional note: I think the rename is a good thing, because the
function additionally changed the argument list.

@Mat: please LMK if you are ok with squash-to patches for later
self-tests/bpf things to be adjusted.

/P

