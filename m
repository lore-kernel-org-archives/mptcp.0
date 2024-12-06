Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B88D206262
	for <mptcp@lists.linux.dev>; Fri,  6 Dec 2024 16:41:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733503319; cv=none; b=aRcvVxwQsfa6oEjGd2Mow/Ua63v6ezuu4mUVNb5FMeVubc2mlayTBilkp4EBrUYPMs+d5IKWmqurOtRsTLC5UMPXuHAU6xvWZniTnpHE02nfYbzX02viWTTRH0xrZe8WTvhCKESZEdElLD923oGHiPlCr7/63ZaVBER8baJEwOo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733503319; c=relaxed/simple;
	bh=cpyiiIfax4i7KdsymKWuJhkFoJ78p1xocP7/pp0TJHQ=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:References:
	 In-Reply-To:Content-Type; b=HRv2Us5z26hT0FvcGOYaLSRz+P/1G4uh3VIof+32hq64d3mbbzf+hITE2QDcKqOPR2e2oEQrcg0t+k++/yn7GXfYBrI2Ca7m/8/hZBDqGGYahEotsqFww20kslDZLRLQuNjeDDZmtVL7lgL0Qy64RlXcBufaIxnjfALQVcLlZsU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=JqQUtF+i; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="JqQUtF+i"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1733503317;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=cpyiiIfax4i7KdsymKWuJhkFoJ78p1xocP7/pp0TJHQ=;
	b=JqQUtF+iIojJMuHmYceIVBZcPPpPpFjd+6h4iABh01y3zOqPyMXk+sWVLJL3Gu8BjRon4B
	dc7KgiC0Ra2ZF33/Ir/rEPZk8Org11bDAU8PW8h5P3ceJ7tm1ecKdHcZ6resg13MnehGLl
	yYp9d5T/rFnDh7HwUr6gHKvj9RVmtcc=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-115-IrzWWDJsOeGrkQPgl9Otfg-1; Fri, 06 Dec 2024 11:41:56 -0500
X-MC-Unique: IrzWWDJsOeGrkQPgl9Otfg-1
X-Mimecast-MFC-AGG-ID: IrzWWDJsOeGrkQPgl9Otfg
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-434a37a57dfso5554195e9.0
        for <mptcp@lists.linux.dev>; Fri, 06 Dec 2024 08:41:56 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733503315; x=1734108115;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :to:from:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=cpyiiIfax4i7KdsymKWuJhkFoJ78p1xocP7/pp0TJHQ=;
        b=XRcHfvz/qI//zMQf4H0TCX1o/hPdd8Fq531MOJvmvk+P1QVZ9mQMMbu5n6viZ14weR
         Y3iNyGww4ZiNoAwCP9KVl1ZGvdJKUseJLZQxENpGhUTPA/j+uxqZ9O8wbI1nDEIpEMKl
         3dfbDXSp+NoSU8TMPQ5l3+qByDjamgr7RAOItzVotSIux7ekIz09zcDIWg4wQbh/CBN2
         6tHxRxlORQT8CD2BycfYRntXnF4+G4C2mt5q6zli31E1PNwIn9j8Zr77Whg2F9Wv2P+n
         n8e3TbfTsqNwCFAl/mQ8mtv5A5ZjMPFzAUNA8OS7S5rIW/BwWfey0O9H/xrBg4rQ2tgv
         SJqA==
X-Gm-Message-State: AOJu0YyT34KW2oVcHlMnwIs3tCtw6QnCZtXl+1OHASi73sn2Lqbzumqp
	f08qMt8zb8TIMO38jEI0gKSB6lOL+0eWRtEDT3gRsVt3nmX5igUpvaE/NNeX3EslBRVj5YRLqvc
	jrWD9csQB3fyfUmyQpqZ6Qqvp3gYOs6JRCM4YII0LJI6Fw4g9O6H0yhdwemU1NWpM0As7w3yyjg
	zIUy/cwkK2eOeMG68xRuaAq70+SeJ+vU1dzg==
X-Gm-Gg: ASbGncsOdqTU8khKkuzIiD8llgZoG1uVak8pQ5jPcNhS8mKdJZpcFa8eqJvl2Ilcena
	n77LBUQMJ75zB5z9E37UrYcj05haDbvVOEqakchoJPAgN9A9mqm1ck+V+5pmvEAiz3xlmFl5TCQ
	ByQVnj/YBO3IRhWdwQurGwudky2TD1djge/QumXPY0KzAHsFXEKB+R4exIYlRdTOXQ/A+npH+hH
	cS/YYCf4QjAE9+N11I0fkFQWfaXs3scHD2VgR+zEXHFrpRhiHp5CfPmaquOWGo6SbVmOeHhR0Tu
X-Received: by 2002:a05:600c:3ca3:b0:42c:c28c:e477 with SMTP id 5b1f17b1804b1-434ddecb0f7mr30053595e9.23.1733503314860;
        Fri, 06 Dec 2024 08:41:54 -0800 (PST)
X-Google-Smtp-Source: AGHT+IG/Zu0GHNPkQMvKdkHj84Ent91BpUKLoTMsGOvsPLiwucGr/59h2dKZ44cIt/rWPFU54Lrxtw==
X-Received: by 2002:a05:600c:3ca3:b0:42c:c28c:e477 with SMTP id 5b1f17b1804b1-434ddecb0f7mr30053425e9.23.1733503314473;
        Fri, 06 Dec 2024 08:41:54 -0800 (PST)
Received: from [192.168.88.24] (146-241-38-31.dyn.eolo.it. [146.241.38.31])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3861fd46844sm4877833f8f.53.2024.12.06.08.41.53
        for <mptcp@lists.linux.dev>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 06 Dec 2024 08:41:53 -0800 (PST)
Message-ID: <a16d1dbc-5a57-486d-8820-a2a4999c8399@redhat.com>
Date: Fri, 6 Dec 2024 17:41:52 +0100
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH mptcp-next v2 0/7] mptcp: rx path refactor
From: Paolo Abeni <pabeni@redhat.com>
To: mptcp@lists.linux.dev
References: <cover.1733486870.git.pabeni@redhat.com>
In-Reply-To: <cover.1733486870.git.pabeni@redhat.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: UpLW6Pd21bK53jGXiWyEJhl0n2o2envf2PiEoZrREmU_1733503315
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 12/6/24 13:09, Paolo Abeni wrote:
> The present refactor addresses both the above items: most of the
> additional complexity is dropped, and single stream performances
> increase measurably - from 55Gbps to 71Gbps in my loopback test. As a
> reference, plain TCP is around 84Gps on the same host.

I forgot to update this section.

I did some additional test with multiple links, differences vs the
existing codebase is within the noise range.

Disclaimer: tests over multiple veth pairs, with RPS to use multiple
cores for the forwarding. This is a somewhat decent approximation of a
real setup with multiple H/W links but I still have to try the latter.

I think the issue reported by the CI in the previous iteration should be
addressed here - or at least this iteration addresses the closest
problem I was able to reproduce locally.

I'm not aware of any standing issue, but I would bet a few coins this is
not bug-free.

Paolo


