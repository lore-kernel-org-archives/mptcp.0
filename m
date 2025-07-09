Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DC3A275867
	for <mptcp@lists.linux.dev>; Wed,  9 Jul 2025 09:14:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752052472; cv=none; b=nvx8cuHYCyQOW0aGAs6j7HnFyEHKJG9ONeMataUm4Vil6/OWrslzFDiWIM4CDw+ubv1yke9OJpZ9XkQFuAwavZSDVjJaEUcZb9Gtq6SgIvfft1FsZzzfOn20NpyeydCQ2FA7/+vksXSa+q/22ZGWD/WfGn2OqLG9ZAduEGlQD9o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752052472; c=relaxed/simple;
	bh=DY3FbzLKkGsjbpGbv7IDdlYAhr4pcePkJ9sxAnqrED8=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=tmdz7VdzrQ/93yGHthSHdMbV8uECH0si0xemc3b/w+99ytIxQJoq+Hu6piYcMIxGhQlL+JMaDo0qoCJf6B2hKPNBlcPBrnrIsc5zARiu3J4PlRQHmUmkTV3SKMBJ+LVcfOfoEMlXBE9YLQmMmM3J7XCEfb8mBB+XH9uuxeFvRcE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=A1uZy7g/; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="A1uZy7g/"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1752052468;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=HIXoc6i2USkDkytkEz1qBfqCb3+TDXCZwWV5SQTG5nA=;
	b=A1uZy7g/anuo8JKaGJ42LTuPASa8aq0C4OrLaqfFpa0Ki73JQCHt4opnpyOWdBqNH9jda8
	6TuMeGN0GPcbkIwp/bf1CAC/T+Z/IyBJHYIL03w17RFu5vn5Fd2PRzMVowZafWrdxRjqNv
	9xgOEENQ5dp9oY1Y10CRn/yGP3ZI0m8=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-681-CKN8F662MBuK9CKri5FVHA-1; Wed, 09 Jul 2025 05:14:27 -0400
X-MC-Unique: CKN8F662MBuK9CKri5FVHA-1
X-Mimecast-MFC-AGG-ID: CKN8F662MBuK9CKri5FVHA_1752052466
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-451d2037f1eso30374975e9.0
        for <mptcp@lists.linux.dev>; Wed, 09 Jul 2025 02:14:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752052466; x=1752657266;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=HIXoc6i2USkDkytkEz1qBfqCb3+TDXCZwWV5SQTG5nA=;
        b=JUmJsP4/6Rw6Anh5wVQmZh7rQOfW+1Egm68vn6+Hz601Lswr1VjCVjaRKyeezo0voH
         g5ufNbLxyJqiRAepJ6OmhdYBnB4FHZUG5i3qeAe3VjHOJCDsl0clmpnI9KX3gCcOvJSN
         CdDvW+/8CMyVG9GxMKvg3gSeCUHvLwwT9dNRgDMV8CAL1RnIhT3qjFEwpfZtV10APEpt
         MXeNE54V5Dlg8t03ysdDbBnPcsFdTByBHVRjQ7juHRnAiT4QooEwfJD3xwaVQIBLymt0
         qJjFw8Lq5PFyMP7vKp6w6OhG/13DOEq/8ulkOr5mc8+W6J7iopvtIxHuw46hkg7moC0+
         NoCA==
X-Forwarded-Encrypted: i=1; AJvYcCXlKLl9QOERGMTyktkgRgu/fBGZXu0N0TiNIUUQYgfKBTVYfEBW59N3gQtok3Iyem4JgkWmNQ==@lists.linux.dev
X-Gm-Message-State: AOJu0YzwOWIuwZKfbpU64wpHIss1YgLpQUHATBZu61siuDL2IqmF+WlS
	+CWBRLkDjYqMkyK6rJGgavAf3m4TQiyWvwrv7ZxSP11CqHkoHJl+piDGZ2osTzjtBdDOu8tm5gu
	ThE+n3QW5KVvrfYZrzN5+668Lw5Zfmz5W5x1vBzG5ev9dRmPbiINv3idm
X-Gm-Gg: ASbGnctaWPJttS0WTOPTqQWEyoDzOzJab/alLXHdVqgFlAI8boLi3M09Ar2+Bfr2Qjb
	aR+Bz0XmkRr5gs/K+2szy+Aahq3ANjr0t17h3MPUej4C5dyQ3iVilMHKQeSnkJg48/BLHdzvs6j
	rFVLkmPDm+mHHocUyfcvQ3nqfm8b69EJqk0CUIvdAji7coAbiL1Rs5ddTngFhsdm2fyYjBm594r
	N6RU9/Zvo9s9yqpe0lx3Gj+bBnZkxY3Z1ZSoqDPJ0k+5x9xOqQy9zt5k4bC//1rWwimPE9PJQnt
	4H3IFWokyZupgoJz20abiskAMDKmwa7DAiD4N/uiEdQUw+TLV6tpWrKj7PfC6dqEIFuKnA==
X-Received: by 2002:a05:600c:4e41:b0:445:1984:247d with SMTP id 5b1f17b1804b1-454d532eecfmr13796605e9.7.1752052465862;
        Wed, 09 Jul 2025 02:14:25 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGhcLerjAVWlUpSqyRE+AKzRMcGD4iqjfxu0qKFzn7Vu33J5UTZTeuDo9cYNjGUbPxFT0/NNg==
X-Received: by 2002:a05:600c:4e41:b0:445:1984:247d with SMTP id 5b1f17b1804b1-454d532eecfmr13796185e9.7.1752052465277;
        Wed, 09 Jul 2025 02:14:25 -0700 (PDT)
Received: from ?IPV6:2a0d:3344:271f:bc10:144e:d87a:be22:d005? ([2a0d:3344:271f:bc10:144e:d87a:be22:d005])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-454d5071baesm16403725e9.32.2025.07.09.02.14.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 09 Jul 2025 02:14:24 -0700 (PDT)
Message-ID: <0a59dfb9-7bb5-46cb-ae97-b98eba820848@redhat.com>
Date: Wed, 9 Jul 2025 11:14:24 +0200
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH mptcp-net v2 2/5] mptcp: plug races between subflow fail
 and subflow creation
To: Matthieu Baerts <matttbe@kernel.org>, mptcp@lists.linux.dev
References: <cover.1751699999.git.pabeni@redhat.com>
 <ef3a8b7c681bcd78846f047509928bfffff96057.1751700000.git.pabeni@redhat.com>
 <766cdd27-eb1d-493c-ba47-bb8c8467fbe8@kernel.org>
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <766cdd27-eb1d-493c-ba47-bb8c8467fbe8@kernel.org>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: w0TdPst2eanwfgjCIkNOSR3TPkhuuBzBISk07z6rEzk_1752052466
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 7/8/25 5:42 PM, Matthieu Baerts wrote:
> On 05/07/2025 09:24, Paolo Abeni wrote:
>> We have races similar to the one addressed by the previous patch
>> between subflow failing and additional subflow creation. They are
>> just harder to trigger.
>>
>> The solution is similar. Use a separate flag to track the condition
>> 'socket state prevent any additional subflow creation' protected by
>> the fallback lock.
>>
>> The socket fallback makes such flag true, and also receiving or sending
>> a MPTCP fail option.
> 
> Just to be sure, can we not rely on the MPTCP_FALLBACK_DONE flag for the
> two cases?
> 
> In other words, do we not already have something set when
> sending/receiving an MP_FAIL instead of adding a new field? It feels
> like we already store this info, no?

mp fail is not an alias for the new field, as the latter will be true if
e.g mp fail has been received or has been sent or sent or in case of
fallback.

We could check all the above conditions in an helper, but I found
simpler adding a new field

> Can we not continue to use __mptcp_check_fallback(msk) and
> mptcp_check_infinite_map()?

Yes and no ;)

Meaning such checks outside the fallback lock are racy, so they are
possibly useful in the fastpath/datapath, but for fallback related
decision we need to acquire the lock first.

/P

