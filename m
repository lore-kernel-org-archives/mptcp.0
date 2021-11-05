Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41C9A2C9B
	for <mptcp@lists.linux.dev>; Fri,  5 Nov 2021 10:48:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1636109288;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=340L8HQDOLiEWZewEHZMtS98rNFC72vIB7u3xfhKsSg=;
	b=Qt7SuHh0jECIrNXuVHoArLMkF4BUNVg60n8O1tjZTKPr20Zk2UcAQaxCFlyxzSEMxQG95E
	iu/O6SwGDnBF66RV1oURpAt7ahpuBBQHzfUX1suq7HEmuWOPzLFbGJL5kyBrth6qz2AFs2
	kU8c6Dj2yixWjEAwWp7ajcqpWn/nBfk=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-558-uPgtlFEkNIqLgK6HU7WVTQ-1; Fri, 05 Nov 2021 06:48:05 -0400
X-MC-Unique: uPgtlFEkNIqLgK6HU7WVTQ-1
Received: by mail-wr1-f69.google.com with SMTP id f3-20020a5d50c3000000b00183ce1379feso2181384wrt.5
        for <mptcp@lists.linux.dev>; Fri, 05 Nov 2021 03:48:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:subject:from:to:date:in-reply-to
         :references:user-agent:mime-version:content-transfer-encoding;
        bh=340L8HQDOLiEWZewEHZMtS98rNFC72vIB7u3xfhKsSg=;
        b=mWx96Ds7TVXi78R+UVqfQlYmW3uuCGbhc+XhTbCuJvPmeM9Hj40hxkYNiq1Jkkm37g
         gE//akhctzVLlwJcjZ8mHp4s7qfPIFJsxmwcYlIA5CcFpOyaEciMlzeMTfcOcsry4A3J
         m2Oz/+XKFKov3YOGHrXBWF1YUlz73bSzhUM/njuW6AwhStc4Dj3GyEOzV7goc4vKrhVg
         hEx2PeN8Lhoa7XORrK0nunUyxO7Vd7ZJGZ7zMBYY8xcr/WVGPKqqr/2UbfKFZU0TJ/pI
         VpZ07maAhwEDx5Y0Y0+drOm74v1ZIc/DRa84BXfm5sYEv5lZMEgRX4lILXGKh5e6ygaT
         Lneg==
X-Gm-Message-State: AOAM530Nv8tz/7gXxJY+n5Y2ZtGYg9ZCZMuaEoRFAEEZ+TP9fQlMtu0M
	eXxT0EsYktzbsym/u0C+a5pwdiNoV0cXZeyUl40tPBn6wZ+ydbJTd8lvu4jeGLguOXAkyg/AZb3
	CLB3aJ8Az5PsAOQs=
X-Received: by 2002:a5d:6d0c:: with SMTP id e12mr30279496wrq.94.1636109284184;
        Fri, 05 Nov 2021 03:48:04 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwdVQt9ixW3z4KF/LPlZVxrXpf8QGpoKrhbp2Q+kboSLHzeGNZy+cdpFsorTYo1GkowVJhJiw==
X-Received: by 2002:a5d:6d0c:: with SMTP id e12mr30279463wrq.94.1636109283919;
        Fri, 05 Nov 2021 03:48:03 -0700 (PDT)
Received: from gerbillo.redhat.com (146-241-236-6.dyn.eolo.it. [146.241.236.6])
        by smtp.gmail.com with ESMTPSA id t1sm8351490wre.32.2021.11.05.03.48.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Nov 2021 03:48:03 -0700 (PDT)
Message-ID: <8141891e5388b61b8f07371dcd6e4b253e6213d1.camel@redhat.com>
Subject: Re: Linux 5.15 + v2ray + mptcp
From: Paolo Abeni <pabeni@redhat.com>
To: Mark Burton <mark@helenandmark.org>, mptcp@lists.linux.dev
Date: Fri, 05 Nov 2021 11:48:02 +0100
In-Reply-To: <8DB8DCC4-A85C-4A1A-8A82-5D53F256C09A@helenandmark.org>
References: <8DB8DCC4-A85C-4A1A-8A82-5D53F256C09A@helenandmark.org>
User-Agent: Evolution 3.36.5 (3.36.5-2.fc32)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Authentication-Results: relay.mimecast.com;
	auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=pabeni@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit

Hello,

On Thu, 2021-11-04 at 12:10 +0100, Mark Burton wrote:
> Just a very brief note to say I have this working with good results:
> 
> Kernel 5.15.0-rc6
> 
> V2Ray - I hacked the ‘go’ library as follows:
> diff -s go/src/net/ipsock_posix.go go1.17.1/src/net/ipsock_posix.go
> 138,139d137
> <         family, ipv6only := favoriteAddrFamily(net, laddr, raddr,
> mode)
> < 
> 143,145c141
> < 	if (sotype == syscall.SOCK_STREAM && !laddr.isWildcard()) {
> <             return socket(ctx, net, family, sotype,
> syscall.IPPROTO_TCP+256, false , laddr, raddr, ctrlFn)
> <         }
> ---
> > 	family, ipv6only := favoriteAddrFamily(net, laddr, raddr, mode)
> 
> This is far from a good fix, but for testing purposes it suffices. 

Thanks for sharing your experience. Note that alternatively you can use
the mptcpize command available in the mptcpd project:

https://github.com/intel/mptcpd

for the details, please, see the related man-page.

> NOTE v2ray must listen to the correct endpoint address, not just
> 0.0.0.0 or [::]

I'm unsure I read the above correctly?!? do you mean that while
listening on 0.0.0.0 the v2ray server using mptcp does not accept
incoming subflows and/or does not signal the addresses ?!?

If so, that is quite unexpected...

Cheers,

Paolo

