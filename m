Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 950AD3382F4
	for <mptcp@lists.linux.dev>; Fri, 14 Aug 2026 10:50:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786704620; cv=none; b=HfKbZYHwO1MCmgTK7/zQG6ccydImNBrxRtcL9nwwqlwIxVMVLlkzWVIuTXDnwZw3Ob21biU21eiM0x3rKOb7V/CYL6yUJsxclFGM7pxQLVrio5bWg+fNRkg+2KS38OUeRBAe5c+51o5d++k6qvqwW7KR9wArrzxb7vlJtIeLgjQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786704620; c=relaxed/simple;
	bh=brE5PsMDvz1ds7vdKb915DUqNmKHS2M9356iNLHaBdM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=MPKENPhLs4nA83ADoc+jZWwUt3OeNCNvW3W7lOrE9IUOfFlSt8K8vcd5xJr1ejRb1dsF4zskLruBwMjkGdNjRy+BpVMOcForFk9d9/P+42vNc0T+UAJFCS0SRV1KV2vS8r2ZxD9pxXlL2G4tFgSMldHYVnrA2Qy1eCRs1294jrI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=UMnRJVhs; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="UMnRJVhs"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1786704613;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=0NNoSWPmHYUSj94AY1Jp2arW3HdgturLx9FcbXnpDbw=;
	b=UMnRJVhsPu4L5yniamhktq0I0El7uXepayDZqrzmHb8uJkcIeQQUO0RCxvdeASfisvDJsS
	z+VoOnN/feLMPNkESXxPXXKwP06bnqJWtrRvqs6HHWZoWeUcbev66szF0Iak7v0kG0ccXk
	3BJgsm66LjrHmAWITJ7VQj40NwUOMgU=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-612-zaR0mxq6M2eWSb9alsg7XQ-1; Fri, 14 Aug 2026 06:50:12 -0400
X-MC-Unique: zaR0mxq6M2eWSb9alsg7XQ-1
X-Mimecast-MFC-AGG-ID: zaR0mxq6M2eWSb9alsg7XQ_1786704611
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-47f83450a8eso699453f8f.0
        for <mptcp@lists.linux.dev>; Fri, 14 Aug 2026 03:50:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786704611; x=1787309411;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=0NNoSWPmHYUSj94AY1Jp2arW3HdgturLx9FcbXnpDbw=;
        b=n7gikW/INr+tfo2wEHq2HQjHuCVam7B96UVsQ/wg/AoloT9FTttm57iNhARwukK28M
         HPrIK0qX+CFK44am1DYRV7+94gln8TLFt/CodBHXfevfwmUdhiK7wsX23/Q2b1EcN1XK
         neZqoBRWMqhxzG/nCvncQdo60S0ukqIwXx1JLj6K3uj8Bt7x+bP4jEM6E2wAifwsGOQi
         sT7oBFnuw3VXEk4rSdCUGrf1J6PS3bqi+3ImK49LlNTXUbAs5LLTPpMQAFIISBhE7DIL
         0dIjLVfiZhqpiCz5dIpQ6LF+pxjxPNoAWLTwhBnMpW5Eo3+GDgohnlyfORwWD8Bcz47R
         Mt8w==
X-Forwarded-Encrypted: i=1; AHgh+RoVd/9Wvz9AGnjQTexJEFPBd3gtMLR3D0s/MTUmavwsDVgfnGZ1867vTBY0PGiD69gpLWShyw==@lists.linux.dev
X-Gm-Message-State: AOJu0YzhCHN89oEtL5T6aKRbrRmazeqaaCsXHvkzSUgySaR6TAU6KPtx
	PYTlcm/JdQCwHL3tGVhMGpH/tmgHF1BGO+YGBfhDxdlhVZoPdCOY9QhZ1ZmpzLXMvPTMKk9zNgG
	5BONpv8s07oDbG56Zt1BpOp59/M72cmZSQpazD3Veuooz9c29iCS9my1MmlGKsqdw
X-Gm-Gg: AR+sD13TMbcJSkZTtVIEj3dIOzti+MZllbnMz5IGoy14uWp9LQlLh9knd4KCwzDdwwJ
	Y0P/Z915egyqaxF/bTF+t3KP98qirIyHpiKx/i00/5ILngDDUzMQReaBei0gTC8/j0S0wX+LJH8
	4QrNFGidWqkujC2ClF/eP31GoUzF/hFR27v+0RUulCu8tqYzTjOyJYQgois+Ul/RVunOGFI74m+
	niNlg8rpaca+aTOjUIPl6++5E24LftCR/fFN9Ke4XVvAR37oWjnrIVY4nSPo0tlFKrLuug6JZXb
	7rJuGgpduanqc0SN7UleIrP1w1SMWSl7cn0rZavN/pJL6SvV6533sBkf6qGt8XXdKQjUQXgEfvS
	mNOO5R11CinFWSpPnb3DoRO0p+6AP2r7J7lF6F5h67vnas49w+PoW2x2zRybYym8n1BrEDyrTo2
	Q=
X-Received: by 2002:a05:6000:41ef:b0:47f:9283:1fbe with SMTP id ffacd0b85a97d-4816069d0ccmr7428334f8f.0.1786704611258;
        Fri, 14 Aug 2026 03:50:11 -0700 (PDT)
X-Received: by 2002:a05:6000:41ef:b0:47f:9283:1fbe with SMTP id ffacd0b85a97d-4816069d0ccmr7428271f8f.0.1786704610821;
        Fri, 14 Aug 2026 03:50:10 -0700 (PDT)
Received: from [192.168.188.103] (ip239-44-231-195.pool-bba.aruba.it. [195.231.44.239])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4815f2b1a91sm6808993f8f.21.2026.08.14.03.50.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 14 Aug 2026 03:50:10 -0700 (PDT)
Message-ID: <a4d66633-1340-4a56-9dd2-18cdeff7629e@redhat.com>
Date: Fri, 14 Aug 2026 12:50:09 +0200
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH mptcp-net] selftests: mptcp: fix an UAF in mptcp_connect.c
To: gang.yan@linux.dev, mptcp@lists.linux.dev
Cc: Gang Yan <yangang@kylinos.cn>
References: <20260814050625.80231-1-gang.yan@linux.dev>
 <0ce89b909d078e40f8f560255ad44ae8e2cfff00@linux.dev>
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <0ce89b909d078e40f8f560255ad44ae8e2cfff00@linux.dev>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: ujywAig3dEGg-TFSzuTfWxNUfeEEMFnmqLybZcRza_w_1786704611
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi,

On 8/14/26 8:42 AM, gang.yan@linux.dev wrote:
> Sorry for this, after reviewing sashiko's comment, I think this modification
> below should be better:
> 
> diff --git a/tools/testing/selftests/net/mptcp/mptcp_connect.c b/tools/testing/selftests/net/mptcp/mptcp_connect.c
> index ea4cb6c1bd5e..c81ec4400bef 100644
> --- a/tools/testing/selftests/net/mptcp/mptcp_connect.c
> +++ b/tools/testing/selftests/net/mptcp/mptcp_connect.c
> @@ -421,7 +421,8 @@ static int sock_connect_mptcp(const char * const remoteaddr,
>                 sock = -1;
>         }
>  
> -       freeaddrinfo(addr);
> +       if (sock == -1)
> +               freeaddrinfo(addr);
>         if (sock != -1)
>                 SOCK_TEST_TCPULP(sock, proto);
>         return sock;
> @@ -1424,6 +1425,7 @@ int main_loop(void)
>         }
>  
>  out:
> +       freeaddrinfo(peer);
>         if (cfg_input)
>                 close(fd_in);
> 
> If you think it's OK, I can send v2 immediately.
I'm sorry for being in late.

This is in a better direction but still will be not fully correct:
freeaddrinfo() must be called on the argument returned by getaddrinfo()
- in this case: `addr`.

Otherwise some addresses will not be freed.

Since sock_connect_mptcp() is invoked only once per program execution,
and not-freed memory will _not_ be leaked at process exit time, I think
the easier solution is to remove the:

	freeaddrinfo(addr);

statement, adding a comment alike:

	/* All the allocated memory is released at exit() time, this
	 * is executed only once and ownership of a single address has
	 * to be transferred to the caller. Keep it simple and avoid
	 * later freeaddrinfo() entirely.
	 */
	xgetaddrinfo(listenaddr, port, &hints, &addr);

/P

