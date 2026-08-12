Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28C5B4248DA
	for <mptcp@lists.linux.dev>; Wed, 12 Aug 2026 10:47:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786531627; cv=none; b=kH74i8EJeUbgriij+ijYC7pzPD9DVIloCOfp9v3BhiF+vOPNwgDlCHez7RJiswgn0nDQpXqRteJy6mkiaiHZ0oWx66CYwjDDmNyX0m8Lmevpk0irRdggJtVy23A9fpimT9lGjvbeC+moczSc7GCmZR68a6fLDrDUygZ3uAWHACw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786531627; c=relaxed/simple;
	bh=2jhqJ8glbZ7bovBRlwMZhYUhyPAuF7oO8r9hLt2YY1k=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=NfIkfToE+k303nvpbamlNJhgnqzCi/Yy/M6IokH/ygvJd3Ii7IjFyZkGMgcRuR5u9FqH28He6ruDqnZp2fxUCIuV8yYxF581UL12tgYFUrJ7R4nGLFXrbNtlirCrnJdwrhO0S4d7KD49qM1b46+xs6Jp3KmKc+mDzqdY/H/zR2Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=bUOJ1KHN; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="bUOJ1KHN"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1786531625;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=BZeW61tjeAF8Qa+S1E/vtRn5ba1qhCQuuLD/DfwN438=;
	b=bUOJ1KHNIE+FwFTJPy3dTV9XegnuvDbGj/LNEZ5ERcQsN7QS9SuWJLjcdm3nWiESi2DRpz
	iS7tGDuQ2Wo82XrsZ5VmWHDxZnuKiuUq5lYUszfpKOJlHV68lHuRnLeL5jAMTCZNx4jfcE
	/RinfqKNqVJiKEDQqwaLG30U/8mgm88=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-387-dqR3_XC5Mn-IqyRSoUto9Q-1; Wed, 12 Aug 2026 06:47:04 -0400
X-MC-Unique: dqR3_XC5Mn-IqyRSoUto9Q-1
X-Mimecast-MFC-AGG-ID: dqR3_XC5Mn-IqyRSoUto9Q_1786531623
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-4954fd771baso10161365e9.0
        for <mptcp@lists.linux.dev>; Wed, 12 Aug 2026 03:47:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786531623; x=1787136423;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=BZeW61tjeAF8Qa+S1E/vtRn5ba1qhCQuuLD/DfwN438=;
        b=law81rjCaweU2kCX2/l7SgXD8tmtdqdZw/vLDcbvUYGBNhmbpsxV6ZBSJ2uUb0QuD0
         k2SNvC6TeEA1qk2+It7a8FA20UqxTpB7w8h550MQeP1OYoouxnLi1hM9qxuJ40VbDldZ
         8VhYDrdGBzyLnoMhdmgYpP6fNDByPpEiL4dOjVxraWxSoDalt+tDOBgKmk0t9H9IyHCv
         ++r4rUuCLsaIBl7jKZEPh5zApbDACm4ayVl4HPlqik0JilF6x91ZNanWqYMpgVDRDatT
         SoNybtCMBFrIgxcTZK7J3q3AUrs34NmEagQvH81oiiJzEqrZYWUOEFF1XXNO1is0/Ziz
         IfZg==
X-Forwarded-Encrypted: i=1; AHgh+RpAeCg9YY2Lxhy+yoa2Q3SulLmUh+4zntKYxz9FCHkoQ3+lfjd8+Z3Cn7OGI3Y/rUJBLM2s2A==@lists.linux.dev
X-Gm-Message-State: AOJu0YypcTYjBWlslWriTwljPgRd+alPkOgb/Ay0TBAwtN87RJ4epLT/
	BrXLOIehLAbn31/3zJJJLvE2kBS7Ib/1m0R7IjlJ5Wru+H+0qzl1iT8GnxBXbkplv6WW63Hp4/M
	QvKKWUWzA0EalBzxdGnRg9SJVL8SjTbAYotJbSo2qDDWEWMqzh8725boL
X-Gm-Gg: AR+sD10rrstKProLVPbPnMLqmZE7Mvm4OZRe4fUCH2fstNBFxtNlPi7Zs3Phrj6Ra1n
	27ZUI8zA+0hfB2xgro0i8u9weMjBUCW49quR/JZ9wKL6h0OQcSFYZo7i1cACq7I6oMRq/IwZRHJ
	wdfbZCdEvcEsgjoYkTSyt0cbrotfCnkBrYohGyKnbJJjGEJMGkLOCeG9sPSPa6Xi6GSLpsZdNpa
	ZsMmOfaNseWaZprivCEOgPuyp96zq4aNsrHZoSO0RBb/BzP1dEOrl3Y9H3as/VlrKdpTQig5VGW
	lT5ahmBtKDv8xYeYoLKEAAuc6YDAegMd/Q7d2fAGk3avCNFR6oYPc5yBKMTlihMvsRHmZnhie5Z
	lIIhawA90SvEv0PbekKv5Vs/fzS6wn+iooFd+HwX7c5XMpCac+rXNKqX6D+jWSvunChzH+9lQwF
	A=
X-Received: by 2002:a05:600c:1d0a:b0:499:59fd:dbfc with SMTP id 5b1f17b1804b1-4997c379313mr41489955e9.1.1786531622824;
        Wed, 12 Aug 2026 03:47:02 -0700 (PDT)
X-Received: by 2002:a05:600c:1d0a:b0:499:59fd:dbfc with SMTP id 5b1f17b1804b1-4997c379313mr41489585e9.1.1786531622416;
        Wed, 12 Aug 2026 03:47:02 -0700 (PDT)
Received: from [192.168.188.103] (ip239-44-231-195.pool-bba.aruba.it. [195.231.44.239])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4997c98d264sm42932945e9.9.2026.08.12.03.47.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 12 Aug 2026 03:47:01 -0700 (PDT)
Message-ID: <e9082cf3-6889-44b6-9e81-c2a2a21e8e9f@redhat.com>
Date: Wed, 12 Aug 2026 12:47:00 +0200
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH export v3 4/4] mptcp: fallback to TCP on MP_FAIL with a
 single subflow
To: Chenguang Zhao <chenguang.zhao@linux.dev>, mptcp@lists.linux.dev
Cc: Chenguang Zhao <zhaochenguang@kylinos.cn>
References: <20260812054653.43799-1-chenguang.zhao@linux.dev>
 <20260812054653.43799-5-chenguang.zhao@linux.dev>
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20260812054653.43799-5-chenguang.zhao@linux.dev>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: ysg0GBPjj55XSDos0tmje4lFWeHpb57ZxoCnTj9hoz8_1786531623
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 8/12/26 7:46 AM, Chenguang Zhao wrote:
> @@ -901,6 +898,12 @@ void mptcp_pm_mp_fail_received(struct sock *sk, u64 fail_seq)
>  		subflow->send_mp_fail = 1;
>  		subflow->send_infinite_map = 1;
>  		tcp_send_ack(sk);

Slightly unrelated... AFAICS the current code sends the mp_fail reply
immediatally, and will send the infinite mapping with the later data
send, if any.

I *think* it will be better to send MP_FAIL and infinite mapping
together. It should remove a little bit of complexity on the xmit path
and will be IMHO closer to the RFC specs.

/P

