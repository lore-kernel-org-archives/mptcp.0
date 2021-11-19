Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com [209.85.208.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E06F62C82
	for <mptcp@lists.linux.dev>; Fri, 19 Nov 2021 17:16:11 +0000 (UTC)
Received: by mail-ed1-f46.google.com with SMTP id w1so45503842edc.6
        for <mptcp@lists.linux.dev>; Fri, 19 Nov 2021 09:16:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares-net.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :references:from:in-reply-to:content-transfer-encoding;
        bh=ivPxeAuf3MnMd/50FGI/jhiQsthLEl45vbwAY1RMFoI=;
        b=VO0Xwid9gZ7GwIy5KlDDXdknWIkUllcmL7P9jbDfwKlrMPjwzZg/mjkcGPZfmQYoij
         iKL8MIF3pEe3XTcUPEhwQR2MgYfRu/xCEg51/QKjXCdiuLs6r2R4WQIvdm+NxmTWQeGD
         knZJSDQnKzS3WL0aeOADwBFohhIhKY3yAAPyqm81/Iv5N6/pNS4KDJiFC1TbSKAgYrVa
         LKOw/qD5vc8CU4AWvxhY31yVwYQ1/2BZQainLvzrISWj8PwDp4g/wI/vBvxBfjRGI4qz
         AOkF69OTVk9U1+wMKGBJNTh+RoCtaKdzwy5eJGa+0D/CKPEv5AWP/0E8ohRvmOtd5C6t
         U4NA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:references:from:in-reply-to
         :content-transfer-encoding;
        bh=ivPxeAuf3MnMd/50FGI/jhiQsthLEl45vbwAY1RMFoI=;
        b=r1kJEvcNnqeCwQiz+hU54cocQdwkZRjuJ6ftdbG8E49cX68sZ+a15iAlAjBL1yIsln
         LlIBmf914jHPMg+gHaX0O7SSgjIHvXdzPLVb9NouzXq2k5c3J6T+CPsXho5G6EpNg6za
         K/oy7ff+nzWBz7Q2m0BhuGQBR13RPZmJPWNaC+ZlViTTI3WHRG+LNwhyq4+0/ww+VDkX
         MApxC6csxe7CViaGLppv0IQiW4/7uD0OOjZIaH+bIrC6lToBkSwWTr3bIhqz4VLH4ft9
         LA89b6iKNeQzJ+GsVLjJpkNqR2LuwT9/L3tyQ3cBvg/Hde+c75mp5QjbaC9qUarBnISv
         DyWQ==
X-Gm-Message-State: AOAM531dG89g4FINQHwNZTzjBTdFzT7+DX1NjW15A9MT4vk6wahcr8vV
	HR0ww3NwYtiMF3o/PlMTSseLS/AR/Hj8eLsM
X-Google-Smtp-Source: ABdhPJxjrAhmkQcmm71Rgdt889Was9hGEDkavKkeZUEWHFUrA9gv4S8mF7v8Hh7hXHF5Q79/XU1BMw==
X-Received: by 2002:a17:907:3f8a:: with SMTP id hr10mr9595276ejc.527.1637342170032;
        Fri, 19 Nov 2021 09:16:10 -0800 (PST)
Received: from [192.168.178.33] ([213.211.139.36])
        by smtp.gmail.com with ESMTPSA id kx3sm175604ejc.112.2021.11.19.09.16.09
        for <mptcp@lists.linux.dev>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 19 Nov 2021 09:16:09 -0800 (PST)
Message-ID: <b5bfef35-8883-c1c0-c167-2240763fb59f@tessares.net>
Date: Fri, 19 Nov 2021 18:16:09 +0100
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.1
Subject: Re: [PATCH mptcp-next] Squash to "mptcp: add TCP_INQ cmsg support"
Content-Language: en-GB
To: MPTCP Upstream <mptcp@lists.linux.dev>
References: <20211119171304.4028221-1-matthieu.baerts@tessares.net>
From: Matthieu Baerts <matthieu.baerts@tessares.net>
In-Reply-To: <20211119171304.4028221-1-matthieu.baerts@tessares.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hello

On 19/11/2021 18:13, Matthieu Baerts wrote:
> We can remove this old comment now that its support has been added.

I guess there was no objection for this very simple patch. Now in our tree:

- 72eed6226983: "squashed" in "mptcp: add TCP_INQ cmsg support"
- No Co-Dev tag added for that of course

Cheers,
Matt
-- 
Tessares | Belgium | Hybrid Access Solutions
www.tessares.net
