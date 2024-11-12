Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B8382076D2
	for <mptcp@lists.linux.dev>; Tue, 12 Nov 2024 17:02:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731430949; cv=none; b=Q1Awnb4C9EuYyYbd31oDJsBeZFanQ2735nSpV0DA24NSDBNVerrCpEKI35G0ceNiVuT931tcftwh0MydMcYmzeQ0+8eVoRWmDMDqN40t0C3/RsAo9ieIQgeWV8LEOzZfq0lVZ/d4QAz31c8xLHPsRZnxR6EqLCuKEuGGG2evDYM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731430949; c=relaxed/simple;
	bh=JeXjAZr2wRoz3xTGHRQYQ2MNpYSv4rQ/Nof57ctSuRI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=pMwtl4cEYOanR2reeHE13PC0xw3UieClNUWTTSxoCgFD0VA6DHcRSY8jNI7ot/pPIpytRHoliB8FmWpjoe0eyX86tmN9Lbj9VyGVjqQ4F/slc5bx/EFH0R4h08yld23Z1OMvTbPlupkoIMXUGdUX8/YvD1NRmawP8ENwa1e24k4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=BdH7m6FF; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="BdH7m6FF"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1731430947;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=PbC8eqsqKu6FAXLTd5RD3HsXApcxAbHLjaQXJV6qD40=;
	b=BdH7m6FF+S4QXVQBIUdQiBPduqIacppQT2aBpzeYZdR160yvzBnP24dg6Hf+cFm8uhOgvq
	aUn3xLQR6GLET8DtM9/6j7xFASqDxyHHiq5LTBcAkR0kMOuToey7clmsDdnd0SwR1Qlw91
	eU8xgnOjq7r31AwsUXxKBV2i0CmiB9U=
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-616-H9_8oThZNyW3Pq2waAeeLw-1; Tue, 12 Nov 2024 12:02:25 -0500
X-MC-Unique: H9_8oThZNyW3Pq2waAeeLw-1
X-Mimecast-MFC-AGG-ID: H9_8oThZNyW3Pq2waAeeLw
Received: by mail-qv1-f69.google.com with SMTP id 6a1803df08f44-6cbd12b8b60so132601726d6.0
        for <mptcp@lists.linux.dev>; Tue, 12 Nov 2024 09:02:25 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731430945; x=1732035745;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=PbC8eqsqKu6FAXLTd5RD3HsXApcxAbHLjaQXJV6qD40=;
        b=ZPK+Hj68OR93Xa6RqzWj9kWEW4I67dfiTZpUIg3UXEzk2l1xLQEXlc7ZOYnCPZ5mrG
         wVAxT5vB5v6Z6EsPuJnAFdsmK6B81/tyB56/h7ogpzRr3KLjl5auMQq/YuBFeOpNM9yM
         L0vyzCNs6Y9nqyCB9CHyEthzdl3jEVxMgSno4yy667sR5akBXTOMVUhA48NROVMKBvPK
         sKxKCQUa/qhJbuH71awc1UTXeTOQczZ9qNwkn82tIheoZJh205ast/GpFSQ1cpQrD+bB
         zyNo/KU5pifIW/5B4DBfN5anGrVelF09AOmozWvqd5jEg0hegN2r9YlXCWrN8fS5MNe6
         +RcA==
X-Forwarded-Encrypted: i=1; AJvYcCXa20lulRfxzDHOvW4Z2vKAAPxMOA/XT10AbM2vPsZ32sztI99+fQL27yLZbhmeDZ9L7SwQMg==@lists.linux.dev
X-Gm-Message-State: AOJu0YzI7o4yLBVg8V6ghXArNit2XoeQaVvSa0XVaTnbApUcWsT4TGWx
	A9Z3lghqXE6H9CydBF5ebdCOu0irTykLYcc2WSz4cMEz6keZM7/SRmjxJkFaFhk+HoOb+TnZZA6
	jW2AdqSaaEVNbVeOOVX46EMhBYPxqDgX8ozNBzhwwTiRsEBtH8c7JwOINLC80TkI=
X-Received: by 2002:a05:6214:2f8a:b0:6d3:5bee:33c9 with SMTP id 6a1803df08f44-6d39e564f78mr249237186d6.21.1731430944902;
        Tue, 12 Nov 2024 09:02:24 -0800 (PST)
X-Google-Smtp-Source: AGHT+IH4S9lQaXNJBXj1y7lH464SKIaV4pNIdSkE5cwURjTn3oqYZi+9/V5PfoiZpLahUF3u4tPq/Q==
X-Received: by 2002:a05:6214:2f8a:b0:6d3:5bee:33c9 with SMTP id 6a1803df08f44-6d39e564f78mr249236596d6.21.1731430944413;
        Tue, 12 Nov 2024 09:02:24 -0800 (PST)
Received: from [192.168.88.24] (146-241-44-112.dyn.eolo.it. [146.241.44.112])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6d39643b458sm73222166d6.71.2024.11.12.09.02.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 12 Nov 2024 09:02:23 -0800 (PST)
Message-ID: <24956e31-9a86-4b7b-91b6-b95265aa359b@redhat.com>
Date: Tue, 12 Nov 2024 18:02:22 +0100
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH mptcp-net v3 0/3] mptcp: pm: use _rcu variant under
 rcu_read_lock
To: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>, mptcp@lists.linux.dev
Cc: Geliang Tang <geliang@kernel.org>
References: <20241107-mptcp-pm-lookup_addr_rcu-v3-0-3c458d025de4@kernel.org>
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20241107-mptcp-pm-lookup_addr_rcu-v3-0-3c458d025de4@kernel.org>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: pG97gBM7dAs9_afjqeBjyADm2eo5HJcqcROboBuiCHo_1731430945
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 11/7/24 10:04, Matthieu Baerts (NGI0) wrote:
> When looking at something else, I noticed that the local endpoint
> entries list was iterated under rcu_read_lock, but using
> list_for_each_entry() instead of the _rcu variant. That's what patch 1
> is fixing.
> 
> At the previous meeting, Mat and Christoph mentioned we could use the
> RCU variant elsewhere. That's what is done in patch 2, for -next then.
> 
> Patch 3 is a simple change to remove duplicated code.
> 
> Note: I see that we are using spin_lock_bh(), but the RCU read "locks"
> are always used without the _bh() variant. Is that OK here, or did we
> miss something?
> 
> Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
> ---
> Changes in v3:
> - Use list_for_each_entry_rcu() with a 4th parameter: lockdep_is_held()
> - See individual changelog in the different patches.
> - Link to v2: https://lore.kernel.org/r/20241025-mptcp-pm-lookup_addr_rcu-v2-0-1478f6c4b205@kernel.org
> 
> Changes in v2:
> - Add patch 2 and 3
> - Patch 1: avoid > 80 chars per line in __lookup_addr_rcu() + update
>   commit message.
> - Link to v1: https://lore.kernel.org/r/20241022-mptcp-pm-lookup_addr_rcu-v1-1-19d45f26c872@kernel.org
> 

FWIW, LGTM, too.

I don't add my explicit formal ack just to avoid possibly weird-looking
tag areas after merge on netdev ;)

/P

