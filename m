Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38DDA566A
	for <mptcp@lists.linux.dev>; Mon, 21 Jul 2025 16:47:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753116459; cv=none; b=bLA4ImJUwEQR3TU2DYOQd5/NDsSr8B8rDX4wdXlzGQJn+dxOiD7/Pqv60MG5tOTzH3/82IRJN/TrX0Tle4ZLUR1SMnn0k6ON+btDEsL65hPbC1hAsDxF0jsLDCGXY4Lqf+2lbkIu9ioKPp3hHR6QHp0R/HsIzOMKD4MJsA/A83I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753116459; c=relaxed/simple;
	bh=Ty11GvBH4XlIevzdf7aSi95WYoAeVxKze2gG7mCMxyc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=TyH7BP7ckyfN53mnOvKShqyXkW/um0ZJuI1BVpY8zlSmUALvscgZ/nEm/ihpDiyewdqM860kjG7nviMIMInqGbl/fLcKiRH4emNIsitr7ElFrxCXy8SvR2Y8XLBo38Uq4qpg6xQe23XCcaNFVfOkcFYhcNRaiHQ7a/KtZQbjBo8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=QjYb1p7W; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="QjYb1p7W"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1753116456;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=aKkrfW2uoGi3k7+7eI93C5upLmnlLrJcQs/pY2nnC8E=;
	b=QjYb1p7W3NH1ShtnyM9l2mUbzAfd5r82WgFmQUKWnyV7eXYTKa/6wnh0Q1S8v/KzBmAjPw
	7j1yiqFd+Hmr7GRz+TaMobCNovXtX+th7dLtera4AO1uw/WH4lIjn7XYIvpYebvvL5TR/K
	7udvSt+fAj/LUHpAEtA38MmPTWL4ho4=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-115-wcrev-fINIm9G6vpU7Ha7Q-1; Mon, 21 Jul 2025 12:47:34 -0400
X-MC-Unique: wcrev-fINIm9G6vpU7Ha7Q-1
X-Mimecast-MFC-AGG-ID: wcrev-fINIm9G6vpU7Ha7Q_1753116452
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-3a50049f8eeso2568023f8f.3
        for <mptcp@lists.linux.dev>; Mon, 21 Jul 2025 09:47:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753116452; x=1753721252;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=aKkrfW2uoGi3k7+7eI93C5upLmnlLrJcQs/pY2nnC8E=;
        b=ZwlFpCrwL9/lZ0UfnAb69XWzMYCINFGB+itJaQXAJcFLP1QECQ6ge/pY2UgDu9f2s7
         bOV4OszCFPPCTgR1FZfsprtEmb7Eeo3q8y+wt5ZaUfDR/apyeEtEbxUBV/jFg7ivB/vb
         8Qp0hBqC+CSiv4SVmQBUAhLB0sSaUDupaVxwqCfrX0c0E8KWDQDeb61ptMsYDvtsmr1W
         WdD/iIVSgc6cWmxHkwIh4txDeQajekmJzukiiYuF8D8g+KGVuA+AVHZHGEKeul3zjoi1
         QXwwuySy04AXB3wE26siZyLpR3Qht1tj2p7W5qsMp/8LBVJ7UaiI1HkvlIXu4acpOQnL
         tzpw==
X-Gm-Message-State: AOJu0YxaPVtlQ1wKZasc3MMXu4wQ/8I2hbznojFZEgSZsf+ijQeL8ssr
	RGM9+hWPbcFoH1JbWtch1I48ZFciydQZn+/8OD5BaeWTYAomQMXZMNTuvuZEzkcyj1q9TQdl14a
	lgwakTYBJV9PK+EfROsXkVaUWUIZDTyi8FUaTv/al70wybnNbE+LCSHI7
X-Gm-Gg: ASbGncsxkBzFcoZWhKKIgNuEe6fm8K1w9zqxYSB2DdQWffmSjoRh/e+uJp8nczpYRZA
	P+SuF1tgH36HPrxdKgkIGMxsl9nT3SBDbmy8DtLkVHphVvKh8HJmJQv3W6RzgNoUEU0UGTs43tG
	to+EL0pDmMBK5vCiU8wAKUtRA1HaTrsQ24EWF2vnOaaAkWCR4ST47Y+dAnILTFbHe/EyP04nrzl
	uRrdCA7GpM3gRDf298RDwwq58nXCJmcNQfTGyl6HqVMHrKjC9VFwguRnjTkZBDbLv0IzBAC68Hl
	2wSh6XpqA/ORdbr0tnKF23kjii8hCjZ17eCpGzjR9MRK6AaZhcDpROllPkxjpATfqqi0+ZGo/3W
	wx96bMUzIf9s=
X-Received: by 2002:a05:6000:652:b0:3b5:dc07:50a4 with SMTP id ffacd0b85a97d-3b61b0ec0f1mr9676705f8f.2.1753116452067;
        Mon, 21 Jul 2025 09:47:32 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEISsAmcx+WEvkDxqODs8uy+4s85cx/o3O1WhThOa6ThD1PabKaRm5JHDv8Znb3z7Dm1XlnjQ==
X-Received: by 2002:a05:6000:652:b0:3b5:dc07:50a4 with SMTP id ffacd0b85a97d-3b61b0ec0f1mr9676689f8f.2.1753116451536;
        Mon, 21 Jul 2025 09:47:31 -0700 (PDT)
Received: from ?IPV6:2a0d:3344:2712:7e10:4d59:d956:544f:d65c? ([2a0d:3344:2712:7e10:4d59:d956:544f:d65c])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4563b73f76esm103602525e9.18.2025.07.21.09.47.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 21 Jul 2025 09:47:31 -0700 (PDT)
Message-ID: <648bb113-f99a-41ed-97f0-f7e447f4f330@redhat.com>
Date: Mon, 21 Jul 2025 18:47:30 +0200
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 0/2] tcp: a couple of fixes
To: Matthieu Baerts <matttbe@kernel.org>
Cc: MPTCP Linux <mptcp@lists.linux.dev>
References: <cover.1752859383.git.pabeni@redhat.com>
 <d11affe4-30d6-4d08-8c56-8ac611e9d74b@kernel.org>
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <d11affe4-30d6-4d08-8c56-8ac611e9d74b@kernel.org>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: xUu_jK7S6TXy6TUbtqOAFT3uDJYFpRo6G6DvECgqJNg_1753116452
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 7/21/25 11:13 AM, Matthieu Baerts wrote:
> CC: -netdev, +mptcp
> 
> On 18/07/2025 19:25, Paolo Abeni wrote:
>> This series includes a couple of follow-up for the recent tcp receiver
>> changes, addressing issues outlined by the nipa CI and the mptcp
>> self-tests.
>>
>> Note that despite the affected self-tests where MPTCP ones, the issues
>> are really in the TCP code, see patch 1 for the details.
> FYI, the two patches have been applied in the MPTCP tree on Friday. (see
> below).
> 
> Today, the CI complained about issues with mptcp_connect.sh, with the
> "disconnect" tests:
> 
> - export:
> 
> https://github.com/multipath-tcp/mptcp_net-next/actions/runs/16409726187
> 
>> # INFO: disconnect
>> # 63 ns1 MPTCP -> ns1 (10.0.1.1:20001      ) MPTCP     (duration  4052ms) [ OK ]
>> # 64 ns1 MPTCP -> ns1 (10.0.1.1:20002      ) TCP       (duration   963ms) [ OK ]
>> # 65 ns1 TCP   -> ns1 (10.0.1.1:20003      ) MPTCP     Unexpected revents: POLLERR/POLLNVAL(19)
>> # (duration  1002ms) [FAIL] file received by server does not match (in, out):
>> # -rw-r--r-- 1 root root 14170836 Jul 21 06:12 /tmp/tmp.RA63zyhMfZ.disconnect
>> # Trailing bytes are: 
>> # �[�����05}�����Oka�<���aH�1-rw------- 1 root root 14029930 Jul 21  2025 /tmp/tmp.BIcGXjzpdJ
>> # Trailing bytes are: 
>> # �[�����05}�����Oka�<���aH�166 ns1 MPTCP -> ns1 (dead:beef:1::1:20004) MPTCP     (duration  1062ms) [ OK ]
>> # 67 ns1 MPTCP -> ns1 (dead:beef:1::1:20005) TCP       (duration  1062ms) [ OK ]
>> # 68 ns1 TCP   -> ns1 (dead:beef:1::1:20006) MPTCP     (duration   998ms) [ OK ]
>> # [FAIL] Tests of the full disconnection have failed
> 
> Do you think this could be related?
> 
> 
> - export-net:
> 
> https://github.com/multipath-tcp/mptcp_net-next/actions/runs/16409727049
> 
>> # INFO: disconnect
>> # 63 ns1 MPTCP -> ns1 (10.0.1.1:20001      ) MPTCP     (duration  3797ms) [ OK ]
>> # 64 ns1 MPTCP -> ns1 (10.0.1.1:20002      ) TCP       (duration  1259ms) [ OK ]
>> # 65 ns1 TCP   -> ns1 (10.0.1.1:20003      ) MPTCP     read: Connection reset by peer
>> # (duration  1317ms) [FAIL] file received by server does not match (in, out):
>> # -rw-r--r-- 1 root root 19806768 Jul 21 06:13 /tmp/tmp.bjbDDrTOHl.disconnect
>> # Trailing bytes are: 
>> # �Z�V;*�49�������#1�0��>3�;-rw------- 1 root root 19591200 Jul 21  2025 /tmp/tmp.lJwoEj0wut
>> # Trailing bytes are: 
>> # �Z�V;*�49�������#1�0��>3�;66 ns1 MPTCP -> ns1 (dead:beef:1::1:20004) MPTCP     (duration  1420ms) [ OK ]
>> # 67 ns1 MPTCP -> ns1 (dead:beef:1::1:20005) TCP       (duration  1440ms) [ OK ]
>> # 68 ns1 TCP   -> ns1 (dead:beef:1::1:20006) MPTCP     (duration  1370ms) [ OK ]
>> # [FAIL] Tests of the full disconnection have failed
> 
> This one is probably unrelated.

Yep, I'm  observing something similar here, too, with a considerably low
frequency that makes investigation hard :/

/P

