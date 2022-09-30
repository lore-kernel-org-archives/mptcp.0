Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4009A7B
	for <mptcp@lists.linux.dev>; Fri, 30 Sep 2022 08:18:57 +0000 (UTC)
Received: by mail-wr1-f43.google.com with SMTP id x15so5164546wrv.1
        for <mptcp@lists.linux.dev>; Fri, 30 Sep 2022 01:18:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares.net; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date;
        bh=EqhBJSBxG/wZSTB8yt4Ov3D/nhvjhTT1IZe9vtGeDKY=;
        b=hqRkWBdam6S2X6GR7TyyvlzCTXjxRe32LVR7xgiHuSGmIE9leLnEqZd5m0mOvz/57/
         Ddvy9Y+aAPAy6CRcoyBBkoWUohYG8VU2vscZoAODohOHHbHeN2lD5srjdXXqQpL3zEDD
         ADkQCzrxrzwHctkBN/RPHLDFoEf/UQ1P1EP/RAqIA5sgwr7wOTffAUuy9XZ6A5XwruY+
         BXWXW90BBt3HVjbPYW54K5GhYNJDqM8d78pR4TlMgWCugXPfRjEUnOVHsRYfdQjEpYER
         6knoim/ClxBaxYztX2a3FWL+LNuNAmTdmtqhLiZN/EOSOSmXZXCVtUdAxQenYanvdFr3
         JvOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date;
        bh=EqhBJSBxG/wZSTB8yt4Ov3D/nhvjhTT1IZe9vtGeDKY=;
        b=bU+SU3B8j6hbRnF5Qiq1mDkTypkjcfleScx1q8QyxTlnkYrHWaU9sSIvmPZGXfdDNK
         qrY8eKbNTEVSuqOqhyEdsPGx5VoJXEifO6VXaVfAxbd1F3s6KzIOOKQ59DqkY+U657Og
         zFR/jDbOP6hlV75GSAqVHRRIsC79qtyoMJ5dOSyJSY61rNwC1Jb/USSyvNZ2XXkvOIC9
         ZacuR0Q7H74o/Ynwl27yjE84dy9yWaElSUrdaVw3oT3Yp4ejbSaDkPcwGcnBCDsxKZcQ
         2fFfCSPao54DHydWjXyI52C73fWEAxAP5DSq1hSkZneR1zr/ZtGEX9qk2R1+c3Iv58ae
         gY2A==
X-Gm-Message-State: ACrzQf3Obn40QegjImMukh1cdrVj3TsYMnZeuD+Us6lRaXCj5kRmVF21
	5eroyxien8JFpD5VuGP8wwWx9gtnBM9paQ==
X-Google-Smtp-Source: AMsMyM6UFINUEYm6UytcAevwHL1gxbOSLMT455eMw2Z5K4sI33UfO567rGaSvuxQkrehUVHsZX9pcQ==
X-Received: by 2002:a5d:5222:0:b0:22c:df1c:92a3 with SMTP id i2-20020a5d5222000000b0022cdf1c92a3mr2322684wra.537.1664525935990;
        Fri, 30 Sep 2022 01:18:55 -0700 (PDT)
Received: from [10.44.2.26] ([81.246.10.41])
        by smtp.gmail.com with ESMTPSA id b5-20020adfe645000000b0022e03fd193csm222009wrn.33.2022.09.30.01.18.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 30 Sep 2022 01:18:55 -0700 (PDT)
Message-ID: <3c9e8479-8352-8e61-6d52-713036c21318@tessares.net>
Date: Fri, 30 Sep 2022 10:18:54 +0200
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.0
Subject: Re: [PATCH mptcp-next] mptcp: sockopt: use new helper for
 TCP_DEFER_ACCEPT
Content-Language: en-GB
To: Paolo Abeni <pabeni@redhat.com>,
 Mat Martineau <mathew.j.martineau@linux.intel.com>
Cc: mptcp@lists.linux.dev
References: <20220928091852.1933333-1-matthieu.baerts@tessares.net>
From: Matthieu Baerts <matthieu.baerts@tessares.net>
In-Reply-To: <20220928091852.1933333-1-matthieu.baerts@tessares.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Paolo, Mat,

On 28/09/2022 11:18, Matthieu Baerts wrote:
> mptcp_setsockopt_sol_tcp_defer() was doing the same thing as
> mptcp_setsockopt_first_sf_only() except for the returned code in case of
> error.
> 
> Ignoring the error is needed to mimic how TCP_DEFER_ACCEPT is handled
> when used with "plain" TCP sockets.
> 
> The specific function for TCP_DEFER_ACCEPT can be replaced by the new
> mptcp_setsockopt_first_sf_only() helper and errors can be ignored to
> stay compatible with TCP. A bit of cleanup.

Thank you both for your review!

I just applied this patch in our tree (feat. for net-next) without
Paolo's Suggested-by tag.

New patches for t/upstream:
- db52578cbc69: mptcp: sockopt: use new helper for TCP_DEFER_ACCEPT
- Results: 6ae98b87e288..a34025ee429c (export)

Tests are now in progress:

https://cirrus-ci.com/github/multipath-tcp/mptcp_net-next/export/20220930T081708

Cheers,
Matt
-- 
Tessares | Belgium | Hybrid Access Solutions
www.tessares.net
