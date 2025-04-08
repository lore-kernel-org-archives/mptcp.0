Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08F1A26A096
	for <mptcp@lists.linux.dev>; Tue,  8 Apr 2025 10:57:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744109834; cv=none; b=FGFcqrlHXp1ThGQAj2TeivDX7+nzjYeVY1ZNvMcoIPY+eos7rmGANw//MO7sKa2DoQrQUGLRonlN2kuE25wATQlxb4BSpjWcm6Fr1T1FWVMhYG/67W703TjrLhX6XmNQfSQ3x1wxvXOO72cO9m+ecBEyNYJruuwJPwtbmMfpKw4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744109834; c=relaxed/simple;
	bh=o93kT3HUr6PSKVXUdV14Bgz9/0yB1U6VVEQHCXqgg2E=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=mxTLo/96hm9x5lrtT92/MqtNo96uNasMT7Q27U0NkqG8sxYNj9oYfN5JQMrLwUfSZo0LE/bzjBDT4LJ91F/wVjE1XMXMDMVkbYOamX+0M14A4j3uc3YmjIPnEHj/567WJ9IXXgwygGu7Ge1utJKhu76Fpo7e7XzmlMEz+gxtx5k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=TJC3bxiD; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="TJC3bxiD"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1744109831;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=WiB8QLkLLCMptXLpQ+Fs8eV4CmtpBvO8mQtuoLcCE5Q=;
	b=TJC3bxiD4i1szKlMsr5BktZwJPY2cXpGA8Q3ubUAzyv/uGDP+QCRsQ6q7fRFhkBVLB4WzC
	qUVNhBMA4XZOFSiR/SIvfbHOcds39RxlDwD0F/n+ZsZIBpCGpp3agpDeiKP4d3JxLVueEC
	l0fno4S9suemCtgHkKlAG5kzLjPZs7o=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-571-h3QaTe3jNy-ZPKjNJxR5oA-1; Tue, 08 Apr 2025 06:57:10 -0400
X-MC-Unique: h3QaTe3jNy-ZPKjNJxR5oA-1
X-Mimecast-MFC-AGG-ID: h3QaTe3jNy-ZPKjNJxR5oA_1744109829
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-43d734da1a3so28268195e9.0
        for <mptcp@lists.linux.dev>; Tue, 08 Apr 2025 03:57:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744109829; x=1744714629;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=WiB8QLkLLCMptXLpQ+Fs8eV4CmtpBvO8mQtuoLcCE5Q=;
        b=eo8i+w1yU9eKlCTeAdfCQ58+8uap3VHzHaoe3w7vMj84dCtNe3OClcNYF9xY2wPX+y
         s7iRWV3wha13tIrVtF1K1EE/jO3Bc9gCVQHv374gSVsNOPkHa/NBmsw+4D8J4rD/dAv/
         mwo0ZoYcUnuvOPtdwESJ48R1ILSll5liQ2TXT3HMi5eOIqoJgkrGr3RQufP4IqeYNQS+
         +61PlVZPEyTmBblGhcgGP6weNs3l/GmPXJjM2NAVvULAEQAKS+w1w+K543EITwSc6RmM
         n7dQYMYLGGJbz5odrS5tDqSHuzG12hb5zwIju5xwwV50THEyn9ST+7gfnZ/JJMgqBEW0
         isnw==
X-Forwarded-Encrypted: i=1; AJvYcCWPLBAw3se7YvEk1I9l1LPDJ73faORzriP7bDUl7zbf5eIOnz0Bjslje3KNHLJAG8rYL8oIoA==@lists.linux.dev
X-Gm-Message-State: AOJu0YyECqTmzYNEBo3ivnGAZnIHzdvSQGcyGswxAqyc9IVDloUBol4P
	DziEHz5Liz4ZjX+4bDmFJS2CKfnMKV0x4tZMRWGqiSbU22+vPNffD/FNWgl8Q3fHbAVLkOXzgE3
	nfKVUhicI9MchFn3UEgTiPCWdvYVEDq0fMDwNc9gyxcSxQJiDbTNU
X-Gm-Gg: ASbGncvLhwE+Gc7I5BZ+Ut4KVkRjKuLmmqZj5GsdULIghyT65MQPxkCCh6NNxcUOcan
	VggKvBpPUORiVezlny2VKbW+mjVS3oXo6Y9tYHeLHQIFidWmwk1YxwFmbyDqxdgD+WvInB2vOS7
	E8Rmd56mD8TNeOCXwEAQr9BKvoyumf3yRbu2RubFp5hi7sjaAEH0XVdUSMk37nK3EhxkV5C0eQN
	5wpYy5Pot4eH+i3j1ttOISRpbSs2dA6JWCIIcVGsP5MNUrKM46cBPnaOhPD0WB5OkA17BWdvItj
	D7LY6vN1kkShJ4Pp8bAlPkhhGTzSz8Tj3YuFt8VBo80=
X-Received: by 2002:a05:600c:3b94:b0:43d:649:4e50 with SMTP id 5b1f17b1804b1-43f0ab8c6d2mr41519655e9.13.1744109829418;
        Tue, 08 Apr 2025 03:57:09 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHucF/g2LzNPlKjjAwHyVa6MKKp0vRxRscl5LXt0EXHIloC4uTn5GNaY61HCGJgRWXZ/jCvhA==
X-Received: by 2002:a05:600c:3b94:b0:43d:649:4e50 with SMTP id 5b1f17b1804b1-43f0ab8c6d2mr41519505e9.13.1744109829064;
        Tue, 08 Apr 2025 03:57:09 -0700 (PDT)
Received: from [192.168.88.253] (146-241-84-24.dyn.eolo.it. [146.241.84.24])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-39c301b6321sm14290396f8f.44.2025.04.08.03.57.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 08 Apr 2025 03:57:08 -0700 (PDT)
Message-ID: <c4b1219d-a42d-4339-93aa-89987cc6ad2f@redhat.com>
Date: Tue, 8 Apr 2025 12:57:07 +0200
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] selftests: mptcp: add comment for getaddrinfo
To: zhenwei pi <pizhenwei@bytedance.com>, Geliang Tang <geliang@kernel.org>,
 linux-kernel@vger.kernel.org, mptcp@lists.linux.dev,
 linux-kselftest@vger.kernel.org, netdev@vger.kernel.org
Cc: matttbe@kernel.org, martineau@kernel.org, viktor.soderqvist@est.tech,
 zhenwei pi <zhenwei.pi@linux.dev>
References: <20250407085122.1203489-1-pizhenwei@bytedance.com>
 <ae367fb7158e2f1c284a4acaea86f96a7a95b0c4.camel@kernel.org>
 <0de20ab7-9f1c-4a13-a8d2-295f94161c4e@bytedance.com>
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <0de20ab7-9f1c-4a13-a8d2-295f94161c4e@bytedance.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: ut1hxkohmH6c-WXnP_6soozRMIRJhx0IOA_o2X8mSpI_1744109829
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 4/8/25 5:09 AM, zhenwei pi wrote:
> On 4/8/25 09:43, Geliang Tang wrote:
>> On Mon, 2025-04-07 at 16:51 +0800, zhenwei pi wrote:
>>> mptcp_connect.c is a startup tutorial of MPTCP programming, however
>>> there is a lack of ai_protocol(IPPROTO_MPTCP) usage. Add comment for
>>> getaddrinfo MPTCP support.
>>>
>>> Signed-off-by: zhenwei pi <zhenwei.pi@linux.dev>
>>> Signed-off-by: zhenwei pi <pizhenwei@bytedance.com>
>>> ---
>>>   tools/testing/selftests/net/mptcp/mptcp_connect.c | 12 ++++++++++++
>>>   1 file changed, 12 insertions(+)
>>>
>>> diff --git a/tools/testing/selftests/net/mptcp/mptcp_connect.c
>>> b/tools/testing/selftests/net/mptcp/mptcp_connect.c
>>> index c83a8b47bbdf..6b9031273964 100644
>>> --- a/tools/testing/selftests/net/mptcp/mptcp_connect.c
>>> +++ b/tools/testing/selftests/net/mptcp/mptcp_connect.c
>>> @@ -179,6 +179,18 @@ static void xgetnameinfo(const struct sockaddr
>>> *addr, socklen_t addrlen,
>>>   	}
>>>   }
>>>   
>>> +/* There is a lack of MPTCP support from glibc, these code leads
>>> error:
>>> + *	struct addrinfo hints = {
>>> + *		.ai_protocol = IPPROTO_MPTCP,
>>> + *		...
>>> + *	};
>>> + *	err = getaddrinfo(node, service, &hints, res);
>>> + *	...
>>> + * So using IPPROTO_TCP to resolve, and use TCP/MPTCP to create
>>> socket.
>>> + *
>>> + * glibc starts to support MPTCP since v2.42.
>>> + * Link:
>>> https://sourceware.org/git/?p=glibc.git;a=commit;h=a8e9022e0f82
>>
>> Thanks for adding getaddrinfo mptcp support to glibc. I think we should
>> not only add a comment for getaddrinfo mptcp here, but also add an
>> example of using it in mptcp_connect.c. I will work with you to
>> implement this example in v2.

While at that, please also clean-up the tag area: only a single SoB is
required. If you submit using a different mail address WRT the SoB tag,
you should add a 'From: ' header. See
Documentation/process/submitting-patches.rst for the details.

Thanks,

Paolo

