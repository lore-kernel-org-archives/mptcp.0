Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FE8E10979
	for <mptcp@lists.linux.dev>; Tue, 23 Jul 2024 08:10:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721722223; cv=none; b=gWwvQvO1vblxMf2oyFNMgajomqz9aYJZXSyiEAEDYMKQZuRKW+bv7FVDN3Fm5gOyBmtIr/vqQcc2Bk7VB9FXEz8YnnARkO8Lqjvf6N80he2UWG9WFjSbdmu/JnmiGnaRrO5N/h0GcQLvC2iLN4hIKBhMhxeFHw5RGsupvmMOSvM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721722223; c=relaxed/simple;
	bh=fr95nzY+lzdUkWWatT97wPFAB2Gx9SYE2jl+ZxB5dKc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=WrgpIztJYSPC8HBFW1MFBGeYWGq1TS/mkNo/NMdS49oOd98skPyBut41iwdk4Hbrjzdoy5K2UhA9BWtvZVzSMPP77gnEQXkUcuThwGVKjF5l6hJZLsVTbjSFRr08ASduHj6Ep5kdi/PdSWQtBtq88hat0Av8o+Wl8l5Dusy7pj8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=R1ZmJs2Y; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="R1ZmJs2Y"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1721722221;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=wmxfs8F2px2yhrVgIx5UvLCzYzlb0R0xZ5URWUC/7Rg=;
	b=R1ZmJs2Yvck7hnRRxF2KZ1N3nsU8vn23tlwfYF81LSslAa1oijWDpoJVrGyX8ReOCanLLm
	yMoW3Dbu6og4qYy/y+sGAYVGkSo9tsNZAezXFzHxEsbJ2KVZUNnD6WQjDYlcKblnmdA0nA
	dnSZpT9dgdFihcHQpM4D5jLoNn3lZ/I=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-172-EuVyukQZNeW391otVlzwOw-1; Tue, 23 Jul 2024 04:10:19 -0400
X-MC-Unique: EuVyukQZNeW391otVlzwOw-1
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-4265f7f3acdso2175225e9.0
        for <mptcp@lists.linux.dev>; Tue, 23 Jul 2024 01:10:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721722218; x=1722327018;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=wmxfs8F2px2yhrVgIx5UvLCzYzlb0R0xZ5URWUC/7Rg=;
        b=EQCEdA0gV+lGmoMjZN8mbsm1nywMx3WrV4Hllt5qpDI+SZ9E6XM27bgSkac5DgmSyH
         djjgrOSUpbwsARDALH1gUFGokDN+VSmAqw2gHAP0pSs9BhybSHBlAoqqaoi2S7i9/pKp
         AUq2qSXYVt8wUNFmBjn1Ae29NolZxG1YzvGcRevMG1iYLBBtA8K0LyhzAKDw3ETUtbW+
         V1CYP1lKbNNTRMnaaaPSqg9RfpQ5TD+a7ielu0kMqU1xGIwuuIv5AQ1dfie4wAzD4jL6
         zf2tdKm7JUm3o1FNKgOcu2SL/GA44gOIEBcw/DC68mKQzjC+6oJ1cpKV/NUT57DxZKiD
         cHOg==
X-Forwarded-Encrypted: i=1; AJvYcCVthN567n9JTlpDN1JPAMnkAk9MFy19mZQTAQBTXtlazPdAum5RKyzSpFMlNAkabApyZ16+3sNU74WDSBLXAw4E+uQtcCE=
X-Gm-Message-State: AOJu0Ywnpp8tRmEB+vjqlgwu58Q4ACNA+XD1729svVLNIb5DhQnz848T
	UE66hWFOZ81Go7yaPClA8YaNArkcvON0hqOtx9EEjUHtUadBJpllWqZTT3w/mzRgrWlMHxPwPxC
	2Th7K+u6wDeoFBkcC8PPk7zMIMs7hSmmQc9bncu60h7az77Pg4Gyl
X-Received: by 2002:a05:600c:4f4b:b0:427:9f71:16ba with SMTP id 5b1f17b1804b1-427daa927f5mr42550165e9.5.1721722218496;
        Tue, 23 Jul 2024 01:10:18 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFjCo1aNAhjviULscGaL8sACLt8gU7d795r1dvnXHXwpUiu5iTQoVlYIXQzwkKwd8V2YJAIQg==
X-Received: by 2002:a05:600c:4f4b:b0:427:9f71:16ba with SMTP id 5b1f17b1804b1-427daa927f5mr42550025e9.5.1721722218027;
        Tue, 23 Jul 2024 01:10:18 -0700 (PDT)
Received: from ?IPV6:2a0d:3344:173f:4f10::f71? ([2a0d:3344:173f:4f10::f71])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-368787cece3sm10602003f8f.69.2024.07.23.01.10.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 23 Jul 2024 01:10:17 -0700 (PDT)
Message-ID: <a2f181c3-92d7-4874-b402-50a54b6d289c@redhat.com>
Date: Tue, 23 Jul 2024 10:10:15 +0200
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net v2 0/2] tcp: restrict crossed SYN specific actions to
 SYN-ACK
To: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>,
 Neal Cardwell <ncardwell@google.com>
Cc: netdev@vger.kernel.org, mptcp@lists.linux.dev,
 linux-kernel@vger.kernel.org, Jerry Chu <hkchu@google.com>,
 Jakub Kicinski <kuba@kernel.org>, David Ahern <dsahern@kernel.org>,
 Eric Dumazet <edumazet@google.com>, "David S. Miller" <davem@davemloft.net>,
 Kuniyuki Iwashima <kuniyu@amazon.com>
References: <20240718-upstream-net-next-20240716-tcp-3rd-ack-consume-sk_socket-v2-0-d653f85639f6@kernel.org>
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20240718-upstream-net-next-20240716-tcp-3rd-ack-consume-sk_socket-v2-0-d653f85639f6@kernel.org>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 7/18/24 12:33, Matthieu Baerts (NGI0) wrote:
> A recent commit in TCP affects TFO and MPTCP in some cases. The first
> patch fixes that.
> 
> The second one applies the same fix to another crossed SYN specific
> action just before.
> 
> These two fixes simply restrict what should be done only for crossed SYN
> cases to packets with SYN-ACK flags.
> 
> Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
> ---
> Changes in v2:
> - Patch 1/2 has a simpler and generic check (Kuniyuki), and an updated
>    comment.
> - New patch 2/2: a related fix
> - Link to v1: https://lore.kernel.org/r/20240716-upstream-net-next-20240716-tcp-3rd-ack-consume-sk_socket-v1-1-4e61d0b79233@kernel.org

Re-adding Neal for awareness. It would be great if this could go through 
some packetdrill testing,

Thanks!

Paolo

