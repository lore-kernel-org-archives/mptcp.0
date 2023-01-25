Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E0996FA1
	for <mptcp@lists.linux.dev>; Wed, 25 Jan 2023 17:47:35 +0000 (UTC)
Received: by mail-wr1-f47.google.com with SMTP id bk16so17850784wrb.11
        for <mptcp@lists.linux.dev>; Wed, 25 Jan 2023 09:47:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares.net; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=CVnrDA+GX4AD5Ev/0IDJ8QHD448gFwb+yD0b07Iwi7I=;
        b=6XfSNlooP4+/yGFIiR/0R9hAYli+sL1Wwg0l8yJIVM5nymWfFDwgTC+rKVMKJglaxy
         apL4gp1s4iYAXew/YUDtToWM+W3ZgZZrSpG8wGs90Mqdl1cVNVE6GrprpclKSYgNgrN+
         b1JvjTAWjw8wIj0c8a7VtgTXtqlLibaAJMjZC7RdCkoTlYv1ZYJY4q+LtHJFJ5Dpd7yG
         qP8kh48dqEIaoXHcM/v8/h0uNSH72+5c6LqLHPNL5RX426qO/a3RiJuaIUe6oQO7Tlbw
         nf91E2ObwxcV70TXr3I2sBJBKD1q6kv/e7SVlNCDSVV7JrwO8bRCABS2zW5ZiKT/4i30
         44kA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=CVnrDA+GX4AD5Ev/0IDJ8QHD448gFwb+yD0b07Iwi7I=;
        b=aJ/CKoOVrlew92N5r6aKS31e7KzEzpawXyFm4KrwusDSrDi7G3zM2lj2rMgsPNuHLt
         OVeu/mg7o71CCMND4ny8Noi5aV8abLoae+Hkdyhdjke+RWIKnOpK1jEp+yXTXOzAcz36
         tjCc48iHv7vpzv00Eudcxy9oufksQRKsJ1/swelCZTU7+8GYps/NS/m2ANvBdQzOm0jc
         +kxsxKCp+JibPJuYNLrdz3jZ0stpqcv+4gUMhZUOschvK1LfydweNJSIcqLMRs50NwgW
         mCY3wfFXWtdIvHF48oTkAU2nz1NPZYboe+ApdmDiWngdlvB2HuoRMrIS5jQMdsKgaN+D
         U7jw==
X-Gm-Message-State: AO0yUKUp/mPp8NG3oWeq14D6HDzdVfCElirYxLww6tXAwwVDkgVJDmdC
	z6OqdcvtAkYkJoDMHm5ZLi/GiYzfyGbC3aU5qxI=
X-Google-Smtp-Source: AK7set9f4taZfFIsT/9gpppxyBVQtcGuVhJ8fFpTJ3jK3yBJ/GOY/ac61JhBDVhMo6wHJJnXiHMjiA==
X-Received: by 2002:a05:6000:1281:b0:2bf:ae19:d8e4 with SMTP id f1-20020a056000128100b002bfae19d8e4mr6651098wrx.16.1674668853336;
        Wed, 25 Jan 2023 09:47:33 -0800 (PST)
Received: from [192.168.3.222] (213.211.137.183.static.edpnet.net. [213.211.137.183])
        by smtp.gmail.com with ESMTPSA id a2-20020a056000100200b002be50604c81sm4989546wrx.47.2023.01.25.09.47.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 25 Jan 2023 09:47:31 -0800 (PST)
Message-ID: <7abea9a1-9f31-7a52-41df-c6199671c4ec@tessares.net>
Date: Wed, 25 Jan 2023 18:47:30 +0100
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.0
Subject: Re: [PATCH mptcp-next v2 11/13] mptcp: refactor mptcp_stream_accept()
Content-Language: en-GB
To: Paolo Abeni <pabeni@redhat.com>, mptcp@lists.linux.dev
References: <cover.1673940640.git.pabeni@redhat.com>
 <afe5ec8c5d1e4b7c72839c9ed9c153c18ff97935.1673940640.git.pabeni@redhat.com>
From: Matthieu Baerts <matthieu.baerts@tessares.net>
In-Reply-To: <afe5ec8c5d1e4b7c72839c9ed9c153c18ff97935.1673940640.git.pabeni@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Paolo,

On 17/01/2023 08:36, Paolo Abeni wrote:
> Rewrite the mptcp socket accept op, partially open-codying
> inet_accept(), instead of indirectly calling it.
>
> This way we can avoid acquiring the new socket lock twice
> and we can avoid a couple of indirect calls.

Maybe a stupid idea but could we eventually split inet_accept() to have
a __inet_accept() version with what has to be done while holding the
lock and reusable in MPTCP?

From MPTCP, we would not need to duplicate the code but call
__inet_accept() (no more indirection) and be ready for Zero Copy stuff
or other modifications of __inet_accept() later if needed.

Cheers,
Matt
-- 
Tessares | Belgium | Hybrid Access Solutions
www.tessares.net
