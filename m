Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B30B032B116
	for <mptcp@lists.linux.dev>; Thu, 30 Jul 2026 15:00:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785423648; cv=none; b=InJ2gXau+4ZCAM/uRTbCHdbiM05GrcHo8EmrS4bWVpbyNSyeYtpThVk/VdgmpYwc9761ez5sc8QXqM8N8Jk+TwOZO4WJ1YyczaX8MldKDm+ZkM56KiI70AZGGEIpsP+qB10t+Pe1mbokruPXn5epuzUkUlPZapmoauUzT8ao45Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785423648; c=relaxed/simple;
	bh=DZhQnbTuywxk8oljcLpjUuoLBIfdn2GNz0Pjfm9GmyA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=NmczpUjsfoUWk0eihh1M3+QvIVhFoJzS3AvSnMZzijYJblQ6CX9ToU0cea6S/DbO4I/QINVvQszZfemGUc4XVNVEh8+ZdcJy2jUfgiHBff+zfKzvdpN8pD7Hqi207azYFbd5umt3vFzihyaeEE2i7gI9TyaWJilg63sM8OSaNig=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=HXqVoh7e; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="HXqVoh7e"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1785423645;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=oCYdsVa0JUPDYN2nOk92Haxj1R2aMBwdLlBa6TmqUcA=;
	b=HXqVoh7e01jMHyrDtbKiQnsnDHJJ/c/bK5eujE6n/cDnaalnNShhDWy3JNKSUC52rY09aF
	0uAjhXSmjcG9tEi0tpHJBw1ESynLrZYdQh1OEDKP26S5W8blmQsLG5r+PzCCVYiGjnOoHG
	7RZstS7fL1Ke0KBYiLeKBHLmmTLqBbU=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-544-gKUa_vyRM4CkGx9NlKtZiA-1; Thu, 30 Jul 2026 11:00:43 -0400
X-MC-Unique: gKUa_vyRM4CkGx9NlKtZiA-1
X-Mimecast-MFC-AGG-ID: gKUa_vyRM4CkGx9NlKtZiA_1785423642
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-4955ecd8a10so16781765e9.3
        for <mptcp@lists.linux.dev>; Thu, 30 Jul 2026 08:00:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785423642; x=1786028442;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=oCYdsVa0JUPDYN2nOk92Haxj1R2aMBwdLlBa6TmqUcA=;
        b=mL8yuLUwsCBM4KdCZlHfK3Zg5W++Tpg9EgVMQu7fPsDvau2iRsp8ZyP3L4vxLXf4UV
         8CkMAzRLsAPVcQGI+EHXbZGNU+GAK128pLnlS7Dq1tUtHR95cjvIc7XUFB+S5PLTFZC2
         C1piyIlCpR1R8wy253xc2cjY20NUW95EFPihEB+9OZtqQMiOGW8Qjools+JqdcY6LMug
         WShegYrazXlZreLcC2f2YzxZKxZMYDsEvA3AW39lfuRsxpX0WboOHJgzZML5ratAfRnj
         9cnwkfgYlpUwGGgPHRD60ixVeyZ7fO9kQFXWIi1TT8l6vSwmi/AGZ2uN0aI+k7lUPJes
         v23w==
X-Forwarded-Encrypted: i=1; AHgh+Rp8f+/obF+PjCYYqggPmgHMQS3K2DT1yznFd2X6ygQyNXdkbg0jrKxyw5HerRhnf1lBRS3zFQ==@lists.linux.dev
X-Gm-Message-State: AOJu0Yy5lM5fCqtCHWGsMiwj4J0fxNsF1EoKUbB6EoAfZABt9ZWcPWTs
	80z5iBtb4nkVEOU+ub7uUJWJOGL3bhB4w7GW4VEkPqd2HLbz5BYJ0C9nF7MLIeFJIUcc5I+lEGX
	oaHUadBmS6inpRaFWJtnngEsWy/fEx5tQtWu/Xw1ZU7cuEvOG5OUfWUz7NxDwMlU4
X-Gm-Gg: AR+sD11wjl/ptk0tixJJlbH1P0WBf6LDqX1CfYVkFhSoOnE+ATPtpKpw+UI4jeYNvpW
	KtepDZKV3AY9Neio5B9UAVrA7oKDV7I5/ImrABsXVO4mWLECZ7vDu7vbZjJf3sqm2a7egxV41vG
	QS57tNYzYyGYEYFaGMJ3ZW0q9S1nkoItVqauQt57EQSX77JGQHjlfNSCVtZJ1Hlp13pW+QQ8/AL
	fp3XuhWj8bVC0pV02Q8B2Svq8XahQw+ZBoViyb/NzXPzhxLjG/DYu4M2YtWTz8mrB4I0d31sgve
	7EQ8K9hgEo19PMWoWug2hdQ3xcDHH31Jd2eTrBi+C3etkJeQO/wNJXHCSpCRZTeY5Efnc0Y6cKg
	NNclm3gc/EnJPA3GZ9mx6TEs/0srXCMhiZk9n1B/rzVQxptsW8BK1ZdbqTNc4QBYxQlMuDJfqOf
	+A4Q==
X-Received: by 2002:a05:600c:8707:b0:493:c182:6b08 with SMTP id 5b1f17b1804b1-49800ed12f2mr42219845e9.36.1785423642024;
        Thu, 30 Jul 2026 08:00:42 -0700 (PDT)
X-Received: by 2002:a05:600c:8707:b0:493:c182:6b08 with SMTP id 5b1f17b1804b1-49800ed12f2mr42219015e9.36.1785423641505;
        Thu, 30 Jul 2026 08:00:41 -0700 (PDT)
Received: from ?IPV6:2a0d:3344:5521:6b10:58fd:68f:7756:389d? ([2a0d:3344:5521:6b10:58fd:68f:7756:389d])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-496fa4605c5sm143613505e9.1.2026.07.30.08.00.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 30 Jul 2026 08:00:40 -0700 (PDT)
Message-ID: <0ac1a2d7-1426-4218-968b-deeea450a48c@redhat.com>
Date: Thu, 30 Jul 2026 17:00:39 +0200
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
 <15adac30-7d7f-4637-91b7-3310f64cdb13@redhat.com>
 <4651fc61637f8be39654decec137010ffcd81991.camel@kernel.org>
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <4651fc61637f8be39654decec137010ffcd81991.camel@kernel.org>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: VrwxUN3r7GcJf3TF40XmOihrJte4aEvqepCgZu8xxaE_1785423642
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 7/30/26 3:15 AM, Geliang Tang wrote:
> On Wed, 2026-07-29 at 10:08 +0200, Paolo Abeni wrote:
>> On 7/27/26 1:29 PM, Geliang Tang wrote:
>>> The linear readers (recvmsg, read_sock, read_done) cope with that
>>> by
>>> computing a per-skb offset = copied_seq - map_seq and skipping it.
>>> But
>>> consumers that treat the receive queue as a single contiguous byte
>>> stream cannot: the TLS strparser builds an anchor whose frag_list
>>> is
>>> the receive-queue skbs and reads it with a plain skb_copy_bits(),
>>> which
>>> has no per-skb offset knowledge. A record spanning such an skb
>>> boundary
>>> then reads the duplicated prefix and gets corrupted.
>>
>> The above raises a question.
>>
>> AFAICS, the critical skb layout is also possible with plain TCP -
>> possibly is just less likely. How does TLS deal with that? I read the
>> above as the TLS stream get corrupted, which sounds suspiciously too
>> fragile to me?!? Or did I miss something?
> 
> My description was inaccurate. This only occurs in the MPTCP out-of-
> order scenario. It does not happen with TCP.

I mean: even for plain TCP skbs can sits in the receive queue with some
heading bytes overlapping with already received ones, and skipped at
read time due to `copied_seq`, how comes that TLS has no problem is such
a case?

/P

