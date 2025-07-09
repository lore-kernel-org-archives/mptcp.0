Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0222722338
	for <mptcp@lists.linux.dev>; Wed,  9 Jul 2025 12:33:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752064420; cv=none; b=JpFaAGCB1M+0oltt+XlUqpRpEFBvckFdxZZtj0tIGfA1T9vXatR4R94zxTdyE14ZbiY3DG7QNiGuQVPMQo1ZP/OadaUDfVMW7hLHuhNc7iAeZWfQRZfTB8GbNcvntggVl2ICLai3/5R6JVT4iuRF7pmPweIKPJW9sa/aNb4HPxU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752064420; c=relaxed/simple;
	bh=/q5naKMyxc6eODMLwA+uFRvkdxtzG6f7Jhm9ZvBZku4=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=SJRO/zX17kyKJo3jLm2blQxoDNHTocvRJUgx33YBbq6uzTaRcjN7661unnImvqMYaFK7ThJwvAjDiehgkzl9cZ2dU0OYTb2Pl0cEOmaFa62P/s+lDdBdowwD8hhbX560HDrVTy9GmQwBs1TcQmiGcToqiFxd4C8i6q0qUVG0UB4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=efF9IU2Z; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="efF9IU2Z"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1752064416;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=QVzwe34QpTUBfF0EmyyuPA9/oXkLpmT9iwC5upEMFrE=;
	b=efF9IU2ZTD8pFevBIzzUrN+DTDfef52v8t3u9s+hK3QvqmeGeOZlNbqmXt7/UJVq7QO57t
	7DK3cCxIM0OCyOQKfBi+Iw6kljNI3DQ1F9CiPUEwE/60GZVHV2/oW//RbGRi8GElBgtYac
	vxtHgEqmWBQRYXLhWEQZD9VXkO60rHI=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-479-jqMWKUCFOjam4SvXgVp0GA-1; Wed, 09 Jul 2025 08:33:35 -0400
X-MC-Unique: jqMWKUCFOjam4SvXgVp0GA-1
X-Mimecast-MFC-AGG-ID: jqMWKUCFOjam4SvXgVp0GA_1752064414
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-3a4f3796779so2739887f8f.1
        for <mptcp@lists.linux.dev>; Wed, 09 Jul 2025 05:33:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752064414; x=1752669214;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=QVzwe34QpTUBfF0EmyyuPA9/oXkLpmT9iwC5upEMFrE=;
        b=BCza1rSTGHQ5t3roM4ji9LKOGrU026EcPW4XtITVcgr/UrPfjQ5wxKoFBhPIjJ+EEy
         RJT9OHXAabSie359HGFkMGKFRsc3OuU6USuqyxUEWlRBEEw5uNKRYYPiaN8fxogMv/vk
         Z5ykN8ts+loSPni5ufdQia2WyoWY/66GefgsmQMM962yZJE4ijnJDi3DUKp0CCqWznzh
         975oCN3l8pRAdfFzITAgNI0kaZRXOVGdYlqDr9gYciwi4L20pJIa5z2z/HVdvVk33dl4
         0V9ksr5CUR2gj272bFk/7f0r7CYfyUam+huxrKmihShVPm33CK0oR6bRk/dzE8e09lKh
         FVdQ==
X-Forwarded-Encrypted: i=1; AJvYcCXrqSd2L9B+P6iH4uJm2pj0JrNhYBvhFzoWcehiEN0zSa7LtTlqe8OVuQqgt0KJ/ZbaxECPag==@lists.linux.dev
X-Gm-Message-State: AOJu0YxMBcqCMZTa2OF3LzbuQaPO0x1E6h+wG8Nd42QqDx5f93uCDOKJ
	Ou7UqjD5fjTT22MSyF+uNXRCKu351WZJ335TUsW/8oz80tVk1lg4xnMzvW0BC/O9brxjtCdIzqN
	s4y9OZF5+aVS/NN8KZavl9CxTo9pjurdmmgsjUX3GJoHv2wZTbvgoBuyZ
X-Gm-Gg: ASbGncu0jfZ7oqXjPyHjfW0oNU60grllJwaESqNUry8qE8z+uIL3ndsGLIjNlB2Gp1l
	AcMTfscPwvzskzWx2PQfqGXcQKHcBg0/DXaS8U6EM19gYXRnuDlDmWpdMLcf2KQuieGlfaTufhG
	PE4oZTKl5BGoKtyOHHVaeFKJsVnCvnTAANh0WqOxlahdXRRz7AhqpYJ3JD7RDLl2R8NKzs5gY0G
	0JpwegmHLgirIcdgiqK3VQSh4ODNKRrYmSoeUt2COn6r5QPEJAlKtCqdcwcJBWNUXH4I3bolxs2
	G9S3ppgOUquBAV1XpjWrIDyVIrjDAR3Sb40/TtTbf+cSKb7PXl95dG5EKwQxrJyzRXEagQ==
X-Received: by 2002:a05:6000:310e:b0:3a4:e56a:48c1 with SMTP id ffacd0b85a97d-3b5e453fa39mr2128354f8f.55.1752064414145;
        Wed, 09 Jul 2025 05:33:34 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG/OiQGZb6dWj8DvGNwwOb2VI7xC8zRom79/jxzKgU+w83x64an+SKvbMvIVP68LGGZf+fPqQ==
X-Received: by 2002:a05:6000:310e:b0:3a4:e56a:48c1 with SMTP id ffacd0b85a97d-3b5e453fa39mr2128322f8f.55.1752064413596;
        Wed, 09 Jul 2025 05:33:33 -0700 (PDT)
Received: from ?IPV6:2a0d:3344:271f:bc10:144e:d87a:be22:d005? ([2a0d:3344:271f:bc10:144e:d87a:be22:d005])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-454d5103c2asm21616915e9.33.2025.07.09.05.33.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 09 Jul 2025 05:33:33 -0700 (PDT)
Message-ID: <ed9cbe19-7ab6-4ff0-b2f8-414b6e5bb55c@redhat.com>
Date: Wed, 9 Jul 2025 14:33:32 +0200
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH mptcp-net v2 3/5] mptcp: fix status reset on disconnect()
To: Matthieu Baerts <matttbe@kernel.org>, mptcp@lists.linux.dev
References: <cover.1751699999.git.pabeni@redhat.com>
 <a5a1798e9f474cf8f8c518ce1b47aebf4b7d5528.1751700000.git.pabeni@redhat.com>
 <a165fd13-3f27-41de-8a51-77ca6838cd72@kernel.org>
 <31fe0442-ab45-438c-abe6-25a9d4f08927@redhat.com>
 <b5ec832f-2fe8-4dec-af09-db0affc3e5a6@kernel.org>
 <9d16ac94-c866-47f8-b34a-1efd45149575@redhat.com>
 <2d493138-fbda-4184-9ece-02a221544f26@kernel.org>
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <2d493138-fbda-4184-9ece-02a221544f26@kernel.org>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: udX_P9nkVYv6JANFPYE7DcjJR2oYyQDJ3mnm-58kTmk_1752064414
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 7/9/25 12:55 PM, Matthieu Baerts wrote:
> On 09/07/2025 12:49, Paolo Abeni wrote:
>> On 7/9/25 12:39 PM, Matthieu Baerts wrote:
>>> On 09/07/2025 11:27, Paolo Abeni wrote:
>>>> The disconnect failure when blocking is not
>>>> possible should really never be a problem from a functional PoV:
>>>> disconnect() can fail per documentation and the application should
>>>> handle that case.
>>>
>>> But it could set "O_NONBLOCK" and do the close later, no? Or is this
>>> correctly handled?
>>
>> Yes and no. Meaning the kernel does not offer any mechanism to complete
>> gracefully a blocking disconnect returning EAGAIN. In such a case the
>> socket will stay in SS_DISCONNECTING (socket) state until close time.
>>
>>>>> In which cases is this MSG_DONTWAIT flag set with disconnect()?
>>>>
>>>> Typo in the patch, should be O_NONBLOCK. The socket layer, the vfs layer
>>>>  and iouring could set that.
>>>
>>> So typically what we do in the packetdrill tests. But maybe we don't
>>> check the returned value?
>>
>> The only relevant pktdrill test I could find is
>> `disconnect_after_accept.pkt` and it checks the return value.
>>
>> Let me check how it will run after the MSG_DONTWAIT -> O_NONBLOCK fix
> 
> Thank you!

The test is passing here. I think that is due to mptcp_disconnect()
invoking mptcp_close_ssk() with the MPTCP_CF_FASTCLOSE flag, which in
turn forces tcp_disconnect() invocation on msk->first, that forciby
closes the first subflow (sk_state == TCP_CLOSE after that).

So we can trim that blocking wait out of patch 3.

/P

