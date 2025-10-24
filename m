Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D09C28D8DA
	for <mptcp@lists.linux.dev>; Fri, 24 Oct 2025 07:30:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761291054; cv=none; b=ZhEHayEms8RsCTU5kxOhKfMYVSu/0pqDb00qVNXHshmO4P9vhtlQ7++XnZmjVRzxurFSOvPGvkfScRdiWyTH/L2XtQQXuHLLgW28q6Ez25VrR+7dDFEKro8vY3Cty/TX4fEKwUuvoCxLlSo2BAy7EmTDK8hZW5z1TyFcgiZEqfg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761291054; c=relaxed/simple;
	bh=1MWYub82zN/s4EF46pBtD+QQRvPpION1GfJqrBW9gdM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=jbBbsxcCTPCcyVFnH+IqpMkDvKQrkyT+x2T9GNuzp5CCInNbY4VKRRFhO5EGDIf4JEKKjQCWBOrAG3IjYs8as9PjXP2aKwLze3F1/f5/2UMzerQGZkHKC63rE7i4Tf/YCOACBq7G1WuaGB2H2Jh965g6snZwLt4/5700W3rlztU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=iEymg83O; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="iEymg83O"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1761291051;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=X0Xq9lZfi9/TpzCXbi0GiAv7NkLY9wzGxPwirL4pyts=;
	b=iEymg83OcGZtRbryrdJxs5ksT/n7ttQv0Ls7nkclOyYyTU+aPPtWGW1LWXpZ7+Xq36C0CC
	QMt/Yns3ckG0/S5pEdJQpZLNjaWoDEI4p53iEjFufxBNMknyDBgRT7Wpclhnflm5xfkyP+
	66Onnu/vOKhQQdZ7MckFI4Vw4qa/kWE=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-26-CnfW0Z1lMHaf_1RqqG5Xrw-1; Fri, 24 Oct 2025 03:30:49 -0400
X-MC-Unique: CnfW0Z1lMHaf_1RqqG5Xrw-1
X-Mimecast-MFC-AGG-ID: CnfW0Z1lMHaf_1RqqG5Xrw_1761291048
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-4270a273b6eso1057328f8f.0
        for <mptcp@lists.linux.dev>; Fri, 24 Oct 2025 00:30:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761291048; x=1761895848;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=X0Xq9lZfi9/TpzCXbi0GiAv7NkLY9wzGxPwirL4pyts=;
        b=eMuURLKH+K/TfBlI69+UZIBDMyQQ7fEYHgDZ0GVSMv/oYy9j76oP46HkHJLa0E3LYs
         wUz2JFNUiDmavpp2zThbE2r6Tol5uevilNO1ousQnAU6rEQ9Gk7M0sFnuEQKN8N0r3go
         KtzMMaOuzL80ISVmyNsreFBXMMmPfRv9N6WHo2IPnhmr2Rs/ZfG82GIOBrLNz+eYbN9E
         LdGr+aNJn8WOufuVIGx7E8n2iicUpGeE8vZKlGNsA5+wQUFb34ixUm+TVRMi5mVZznAC
         zx7PBeIW7ixCf3aNeGTUogJpU8SX0sHgQN+h1Ut6s4uv47IQQlWZlfdaa1/HqgQc6xlL
         bAgA==
X-Forwarded-Encrypted: i=1; AJvYcCUrEhNc195SYMROoemfOL7l7StEO+Xss1Fmm9Sn7R/VkeN+qIZmt5lmU92A0xsZXAJ0lQuOBQ==@lists.linux.dev
X-Gm-Message-State: AOJu0Yz5B7uCdUPZ2OQdBgqBmoe1wgDH69Rn2wEOU1lSdcJpWpdO5MV9
	G/nvYY8aBrAwXQWU3Gyll+FN4QUnuZqbAZA6/BWn1juDqYwEHPe/STKZ1IthUD/hxARuskZ1DuS
	oXD71+v4Iq1dJqK8Vg1evHK6WtfiBc9qHdL4NLV3UboXNP3FpglDR7uPm
X-Gm-Gg: ASbGncuMLjM4r2U+qc9xKPkoDW7331aX+QGdJpKeMFTPYA+DsZdjWtBzxFqL4FNB0Ud
	KTASi15iBoaVq6hGpobBxgbkn9ZQP286/hK/5VW/qbeyNb7kAnexsKKe+bVMuTPMXMe53czMjwL
	LoW6DjO/pF3C/aeeX9+t3wCUX57Tum1ojnsBRjnXDky5gTgrXa/vu0DP+efJ8XSp4twu+TOw5bv
	ADfTygUK0427r/fvmWG4X58TyMbcceKKz3BawmkCoh4JSlft1TMXrIzvIcqJMHEEa9SttStLfP2
	EpQjqMt8AVWv4Gu8CgTtyTggDZkNSqxcwAfRH1OC05E1pQNFdf01NOhfws+VnOmh0s7EzQxZjmO
	qmF9uEaaySyX4kVSldT3OHkE5NWAwQtQwwO/a2wN7Ops7zfo=
X-Received: by 2002:a05:600c:458b:b0:471:16e5:6d7a with SMTP id 5b1f17b1804b1-475d2e7df18mr8166695e9.13.1761291048242;
        Fri, 24 Oct 2025 00:30:48 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH7co+ObUV+kSc+I3BLZADWpuHwpZjCGkKIgoCaHu3aKnAMnQtQVlF87J4K89gak4j3HUhojQ==
X-Received: by 2002:a05:600c:458b:b0:471:16e5:6d7a with SMTP id 5b1f17b1804b1-475d2e7df18mr8166295e9.13.1761291047718;
        Fri, 24 Oct 2025 00:30:47 -0700 (PDT)
Received: from ?IPV6:2a0d:3344:2712:7e10:4d59:d956:544f:d65c? ([2a0d:3344:2712:7e10:4d59:d956:544f:d65c])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-475c4369b3esm130936625e9.13.2025.10.24.00.30.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 24 Oct 2025 00:30:47 -0700 (PDT)
Message-ID: <14084e3b-2ee1-49bd-b04f-8281d4f9c3be@redhat.com>
Date: Fri, 24 Oct 2025 09:30:46 +0200
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 mptcp-net 2/2] mptcp: zero window probe mib
To: Matthieu Baerts <matttbe@kernel.org>, mptcp@lists.linux.dev
Cc: geliang@kernel.org, Mat Martineau <martineau@kernel.org>
References: <cover.1761118636.git.pabeni@redhat.com>
 <9c935ea98196be13949542dcfe787e5bc799ae23.1761118636.git.pabeni@redhat.com>
 <be149ae2-74f3-4655-a03f-08cda8a15c44@kernel.org>
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <be149ae2-74f3-4655-a03f-08cda8a15c44@kernel.org>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: ASZEKKz3vyyR6a9Wl4F2bPAfYMK5-vMtXfIQyKq6bYI_1761291048
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 10/23/25 6:26 PM, Matthieu Baerts wrote:
> On 22/10/2025 09:39, Paolo Abeni wrote:
>> Explicitly account for MPTCP-level zero windows probe, to catch
>> hopefully earlier issues alike the one addressed by the previous
>> patch.
>>
>> Reviewed-by: Mat Martineau <martineau@kernel.org>
>> Signed-off-by: Paolo Abeni <pabeni@redhat.com>
>> ---
>>  net/mptcp/mib.c      | 1 +
>>  net/mptcp/mib.h      | 1 +
>>  net/mptcp/protocol.c | 1 +
>>  3 files changed, 3 insertions(+)
>>
>> diff --git a/net/mptcp/mib.c b/net/mptcp/mib.c
>> index 6003e47c770a7c..eb4645a9c5ac07 100644
>> --- a/net/mptcp/mib.c
>> +++ b/net/mptcp/mib.c
>> @@ -85,6 +85,7 @@ static const struct snmp_mib mptcp_snmp_list[] = {
>>  	SNMP_MIB_ITEM("DssFallback", MPTCP_MIB_DSSFALLBACK),
>>  	SNMP_MIB_ITEM("SimultConnectFallback", MPTCP_MIB_SIMULTCONNFALLBACK),
>>  	SNMP_MIB_ITEM("FallbackFailed", MPTCP_MIB_FALLBACKFAILED),
>> +	SNMP_MIB_ITEM("MPTcpWinProbe", MPTCP_MIB_MPTCPWINPROBE),
> 
> Detail: I just noticed that after having applied the patch: Do we need
> to double the 'MPTCP' keyword here? The full MIB counter name is:
> 
>   MPTcpExtMPTcpWinProbe
> 
> Maybe just WinProbe is enough? → MPTcpExtWinProbe

I'm sorry for the late reply. Yes WinProbe -> MPTcpExtWinProbe is the
correct/intended name, if you could fix that in the tree would be great,
thanks!

Paolo

