Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26DCB3E1234
	for <mptcp@lists.linux.dev>; Wed, 29 Jul 2026 08:08:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785312490; cv=none; b=oL/nhF37mh7XVWphaocV0uMACOpkGBzIudYwuoyAwBVZ5jSxBvm0U2dDS+sJuZXO40eS0i0FnebKCv93CDwivH9QzFAGjMZJMXQ2q/7pLqxhXHNgHN42xM5u9lM3+uPoZW9smQ5x9cyYmGQxtKJ/VEnh8hPCrsKbwShTIqJXcEw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785312490; c=relaxed/simple;
	bh=8lmW40tX/HOH/Ja4mLxJ3uWql+WHHywSvMJtgha45y0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Pye4KOwjAVgzzIJy9a5Xaeeu6ResNmnKuADvGsYohehClA9xbAKjbOoDYFn0Jg45Z9gwzbXPLwMc4tGbYIRgQb1PQ8OeNxovgVqupPjtlq/P+fLCEX8gL4RYWUFlfpELUeIhPU+90sI1fu1fKQezC/bYdfd9gfb/QNgKmFkzTmU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=BRuKaSbC; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="BRuKaSbC"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1785312488;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=8lmW40tX/HOH/Ja4mLxJ3uWql+WHHywSvMJtgha45y0=;
	b=BRuKaSbCr8lThvHex2okzpBRIPHcmOT7M19rWX974Pcw27Vou9pqEJ7VNi/Bc6Go4aIrks
	/gaz7Fu2b1ydwIxAlytrrVDbEE1/gnzNTR69qx4l49oS6/rmPVwGxLo3l20OD9O8Xzzb0U
	kxrrzHbQf/Q/mCx+gshf0b9FRfIVBLw=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-680-0O0k8iiJMWyWKt8bw4ZFNg-1; Wed, 29 Jul 2026 04:08:06 -0400
X-MC-Unique: 0O0k8iiJMWyWKt8bw4ZFNg-1
X-Mimecast-MFC-AGG-ID: 0O0k8iiJMWyWKt8bw4ZFNg_1785312485
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-495474a5fbcso6345975e9.1
        for <mptcp@lists.linux.dev>; Wed, 29 Jul 2026 01:08:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785312485; x=1785917285;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=8lmW40tX/HOH/Ja4mLxJ3uWql+WHHywSvMJtgha45y0=;
        b=e+MNbjKpXz9bb1aqy9WFePj56Z66twL+X1qw1n8F8bS+ugMmE/rRsv5urBXz0D4Tfe
         jxmOlFHdlhLStfhOeik8jgMk4/fgs9c/sd70/Z0EqvRShnfNEQ94xzTKFOYr4CLsvN77
         WAb/ObFjDroO/4XagcyyLgobSx+tNDNMPjEw+1PaN7dZpNNynLvm9TN7xSJKF7lVb7Dq
         d87FZl0SpS2PxcXzSlD/6rosLiCdrwsNKdUaG+vZH/ClSnLzwZl4t1W92vj+K8I8fdna
         vNqUqgKXICEHW/B4Malgj5OnNYclXZlSUeXrpq27Rf9q+wPyfUFQPoAtjULXdRpYNFTP
         3Haw==
X-Forwarded-Encrypted: i=1; AHgh+Rr6Mk+mHdYHdqYTq8oUPrnUn9y0iePJvAqiny4Hw0HDm3C+jTxjvl9RSrwI/e+g1aax8+Hezg==@lists.linux.dev
X-Gm-Message-State: AOJu0Yw/5ip6OEL+7C3Yk6SI82pjGjRxpjBKryt9ULi9i+lwGA6U4u4J
	5tHYJcwgNv3tZ8wcw9Tk/RARzvt+u1XAKAGnvHOQ7CZoOIn1KQ9Ilwd/40pfTGEhDeTZ60xHys7
	w1xrrWJxkeAFldvkcEngEdrpqJ25GdKFX+/G1qHdph79tgBhsxmxL3ELOzplJLRcp
X-Gm-Gg: AR+sD11SDyWTarkWaQ8hbApOwjt8+HCAtAE2OogR7OU+XNEkR41Q3Cmu7qCZyqxmmj+
	N+MSwSAn/hWyww2DuuHlzJgBrWzz8cZSDy293DJXQ3xprED/1P+TgFbMHZZ2pm/6O7wN3jJQTw1
	t3vlzegD7d7wI1KCqE67hBh79/QocemC4kVF1GAEB39hndtW7mc2P+cs9esOaVYhSlstCf4h0/J
	6VZPXZOZM4Zr+IQcpYbCyaW0TU5gS5Liu99iRXJmQrqz54BQKXuEuHL7bAFkOl4/fSKcu3ZV53D
	JltDPZJ0hAaktfYVUw/VL6znGBCVbYm+OtaysWcCTa0svio6AAMdnCpjQCuIMt+9Et3BQAXHR3I
	MQScfCkdW+DdHWInXBsUjgWNzw8/JW4JQxKS3qUwNLOvwRAF4J8QBrNf8O+IibQ6iFggD2mtZMl
	5oXg==
X-Received: by 2002:a05:600c:8485:b0:493:f822:ac5e with SMTP id 5b1f17b1804b1-496c6590688mr62043025e9.23.1785312485074;
        Wed, 29 Jul 2026 01:08:05 -0700 (PDT)
X-Received: by 2002:a05:600c:8485:b0:493:f822:ac5e with SMTP id 5b1f17b1804b1-496c6590688mr62042645e9.23.1785312484598;
        Wed, 29 Jul 2026 01:08:04 -0700 (PDT)
Received: from ?IPV6:2a0d:3344:5521:6b10:58fd:68f:7756:389d? ([2a0d:3344:5521:6b10:58fd:68f:7756:389d])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4976bd6e179sm43043705e9.9.2026.07.29.01.08.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 29 Jul 2026 01:08:04 -0700 (PDT)
Message-ID: <15adac30-7d7f-4637-91b7-3310f64cdb13@redhat.com>
Date: Wed, 29 Jul 2026 10:08:02 +0200
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH mptcp-next 5/6] mptcp: trim the duplicated skb head at
 receive enqueue
To: Geliang Tang <geliang@kernel.org>, mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
References: <cover.1785150300.git.tanggeliang@kylinos.cn>
 <81bd1e2fa9c959927bf0d1cae718a9da72164b5b.1785150300.git.tanggeliang@kylinos.cn>
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <81bd1e2fa9c959927bf0d1cae718a9da72164b5b.1785150300.git.tanggeliang@kylinos.cn>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: hEHs5qU_TmAIOp4bZzblr-Mtxy2ikVMVq8LoBQw4J9o_1785312485
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 7/27/26 1:29 PM, Geliang Tang wrote:
> The linear readers (recvmsg, read_sock, read_done) cope with that by
> computing a per-skb offset = copied_seq - map_seq and skipping it. But
> consumers that treat the receive queue as a single contiguous byte
> stream cannot: the TLS strparser builds an anchor whose frag_list is
> the receive-queue skbs and reads it with a plain skb_copy_bits(), which
> has no per-skb offset knowledge. A record spanning such an skb boundary
> then reads the duplicated prefix and gets corrupted.

The above raises a question.

AFAICS, the critical skb layout is also possible with plain TCP -
possibly is just less likely. How does TLS deal with that? I read the
above as the TLS stream get corrupted, which sounds suspiciously too
fragile to me?!? Or did I miss something?

This change adds a lot of complexity to the rx path, we want to avoid it.

/P

