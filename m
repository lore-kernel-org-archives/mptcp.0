Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC5322E62A8
	for <mptcp@lists.linux.dev>; Fri, 24 Oct 2025 07:34:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761291275; cv=none; b=GfEg6yedZuF//V/lq/EX7uC7DvBq4BZQGWw86EXLWbvBxET2IbpE8vdLkJJ1oZOcU/1QvwfQ5pfSxqwnDYE/U1MNq8wblcjtt4IBMaYUwVQnBUNKF1cGnl+zMcuNnod/mqc0VPxWI+lFS4gZm8QIKdm/xALRFNJzLVXSlTTdDsk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761291275; c=relaxed/simple;
	bh=tSkZJW4t0m4PTmyQo3igF2s9J1BxLCQFmX1BY8Mot94=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=SRCUevR2F9djMAGttUYIyvxlxJdsMnB0nmgAlDmPIasucB67yMLhTky9L/5SXBQuSbvxZP7veCbYRFDJDNDwyVI2f76Pw52yimVudMHP79S/O2BP9dVCfgNvWK/22e8bnrzF4YOx52Ho1AR7/m4I5n/UYgsTMOnO9sXE61+1jfA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=UUeAc1uF; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="UUeAc1uF"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1761291272;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=oIhoq461VgRX3FL58E5wPrn92uu+R8c9Bl/QijzJKKI=;
	b=UUeAc1uF2AOCsRGghZpvl0+ZtVtN65S+fIi2febIq4ojJTV/wCrBd83/a50Z5IYvf8/1FW
	+a9HU0h/Bk3YUTcmKnClBe/HbvVjhSHCx8X7Rl5OlWpGL2lBi81AktO4AqxVnhcyheIB8B
	gocmymMlOIwSeLZcFPn5w+P47pXBVsw=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-1-843JtyFRML6rTERnpv4Bmg-1; Fri, 24 Oct 2025 03:34:31 -0400
X-MC-Unique: 843JtyFRML6rTERnpv4Bmg-1
X-Mimecast-MFC-AGG-ID: 843JtyFRML6rTERnpv4Bmg_1761291270
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-4284525aecbso1044263f8f.1
        for <mptcp@lists.linux.dev>; Fri, 24 Oct 2025 00:34:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761291270; x=1761896070;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=oIhoq461VgRX3FL58E5wPrn92uu+R8c9Bl/QijzJKKI=;
        b=MAEeWwNPyGbX0JeJM3L149NLzYcJ6J9yFjJ1aqq0p09r/A5MEUtE9Z6B7wqa/ZlxXQ
         1JR8Xn8kXVXJl/W5YsIrs4MXkkTFo8lkGz9ApoMkLC4mm/a6ad07o15y8r238pQeIbCn
         WfDack/aUz4ofh9IqNjH3MELjVFVrxMA8OPilXt8TRhZGLAwnyIpchYwwsBKlwNoqqSr
         7OfHewBBTklkGTXIPjNyp+6FdbbIeZuP8c7Y3bHE6mBeegK8vNtkci8W3qnS8t3j7PH5
         0R6l09/emJGrU8y1JT/aJYOrx13FxSGczEkMRKxnzpG1/DeM5tRzVd2x3Fo8hrLb0lZI
         IeZQ==
X-Gm-Message-State: AOJu0YzibByB/Hke013HFMhLaljiQFe2yY9w3uwwqNZ4kSEvDHXEMiv/
	Cc3lzfHXWbi+04J5Jw62cjq9nu6jS8SxCrK3AKAfnNdY8MJrGVCIoB7vEHFo0Ipu0LQixazWhtK
	E+BRheEpdREF0bvZMjXfhmLm8Q3oo7iAA5AeEVr2gxUqBJGLvVUYwy1DC90ECI+/n
X-Gm-Gg: ASbGncvTC2ODVZiL+nsn+Pj1595g3tm2W4NJmqK0Av5VQTECN0GBarENvcB57d7kBFC
	sOVJi4CTzR90jvybJFrfLRuHr8CutcYL66kIjPqnY66ZbvHEg2pV3qmbENn6y/JKuMRNpBUzMW/
	W6qRCHdBo8KTJUXsgFglsypWmdrKRh8+KDstzmoST98M39E0GlGTVQeEO78pwcUoRp39GsHXH1y
	+h6MkBqPUheaJqvm5v9BMDQohGUw8pvR+waEDI988KesC3lr3OpvZnYMonPCjiI3I+KiKMFHi8i
	Kr3JlfjeoXzpmtfeIU/LU0Cn/TBYCM4k7+eHT0Kjne34CfDdNQeMJXky/da/VAOOpptPqdNbutt
	Evk0QUkFYh8+ZbhIkdhGjsOFfzO+roHzb2D3SmWHsUMpnFHY=
X-Received: by 2002:a5d:5d82:0:b0:428:4004:8226 with SMTP id ffacd0b85a97d-4284004ab91mr12867172f8f.34.1761291270041;
        Fri, 24 Oct 2025 00:34:30 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEv5ljLKK77zt3Tzfi8FkEYJeoyQ+HK+PFGeY8lzvfz+iAsvr7jTkGFmtjfCcRFDGxpAc77ZA==
X-Received: by 2002:a5d:5d82:0:b0:428:4004:8226 with SMTP id ffacd0b85a97d-4284004ab91mr12867139f8f.34.1761291269538;
        Fri, 24 Oct 2025 00:34:29 -0700 (PDT)
Received: from ?IPV6:2a0d:3344:2712:7e10:4d59:d956:544f:d65c? ([2a0d:3344:2712:7e10:4d59:d956:544f:d65c])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-429898ccd88sm9366814f8f.36.2025.10.24.00.34.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 24 Oct 2025 00:34:29 -0700 (PDT)
Message-ID: <f101b253-9116-42bf-98c8-4e7a958bce50@redhat.com>
Date: Fri, 24 Oct 2025 09:34:27 +0200
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 mptcp-next 05/11] mptcp: fix MSG_PEEK stream corruption
To: Mat Martineau <martineau@kernel.org>
Cc: mptcp@lists.linux.dev, Geliang Tang <geliang@kernel.org>
References: <cover.1761142784.git.pabeni@redhat.com>
 <d110f41af91c7b3feb17b6b5942c21cdcec93c13.1761142784.git.pabeni@redhat.com>
 <9a415164-74cb-3650-9299-edc82652b086@kernel.org>
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <9a415164-74cb-3650-9299-edc82652b086@kernel.org>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: swUgfAWnioR6IuKq_npEUMx966kylwDNOuwEFup2KhU_1761291270
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 10/23/25 6:56 PM, Mat Martineau wrote:
> On Wed, 22 Oct 2025, Paolo Abeni wrote:
> 
>> If a MSG_PEEK | MSG_WAITALL read operation consumes all the bytes in the
>> receive queue and recvmsg() need to waits for more data - i.e. it's a
>> blocking one - upon arrival of the next packet the MPTCP protocol will
>> start again copying the oldest data present in the receive queue,
>> corrupting the data stream.
>>
>> Address the issue explicitly tracking the peeked sequence number,
>> restarting from the last peeked byte.
>>
>> Fixes: ca4fb892579f ("mptcp: add MSG_PEEK support")
>> Signed-off-by: Paolo Abeni <pabeni@redhat.com>
>> ---
>> This may sound quite esoteric, but it will soon become very easy to
>> reproduce with mptcp_connect, thanks to the backlog.
> 
> Would it be good to apply this to -net?

FWIW, I'm fine with applying this to -net.

Thanks,

Paolo

