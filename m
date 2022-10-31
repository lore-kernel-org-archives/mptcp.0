Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 021317E
	for <mptcp@lists.linux.dev>; Mon, 31 Oct 2022 15:07:02 +0000 (UTC)
Received: by mail-wr1-f54.google.com with SMTP id o4so16399502wrq.6
        for <mptcp@lists.linux.dev>; Mon, 31 Oct 2022 08:07:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares.net; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=TsqXcWVNrI5P7JUi6Krs0B/MtFkHdsAvIZheZca4Y9Q=;
        b=rdauestz8FvW409BxyHoDto5fG2ABev9TOInKP/qSaw/req+pe+AiO1390N31lkkj4
         NxN7P0rjyUzFzVRhJ70F+OQ37cMygIMpbR1NvKeU561Dv4zuxvhRTfOTJ0WiqCLBcGAH
         HMExVXDWSFCqVFnr7yF/3k70jA5Ofo3arCY8Qe1fOQIg7ONnC6wPpIx7eBAVQz2A/VXW
         1kQ69zM7xitHCeDuTaED/AoXmVnPHT7mfvM8W6eaqQ5HoXIUJs5sbLdVE5va5QG21xJr
         oD0NvAnnHIcbQ2MuH5FUmviPcHYTegl0p3Ay1JVTGLfa2s+5hOYRK4BOw1wDGHhYWJ74
         FXKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=TsqXcWVNrI5P7JUi6Krs0B/MtFkHdsAvIZheZca4Y9Q=;
        b=2uCz3yhASdkWVMAxM8vyVEBNZAqbLlVMUyZS+TupvjDnxOSl5IGD7QCzqjp8Z99dbC
         TKIMbeFNmmhJ3uvyqcFAnUUtg7XBdT9tKaTIM7+n60r2d/7TVoaSKpnFGlXHdX1QCWDt
         4Pd857IJrbL5kJWLOi/cRS76spHZmSpRw28wIJRN0rBObDpWk8MH9SUH6wG0fv9CKpqD
         VtpndwWmJM5/2sN/ls03FhV/TbZSO2572EG7CZ91sk15m/QldM0DgRyqGyXCQtSm4Jka
         g1DZDQxANK+/JfaDkdfya7amwOYxaB4tUcXwZYe/YUbMwTmY5vH/Mj2RKFkZw6Ey33Eu
         CmRA==
X-Gm-Message-State: ACrzQf1zCQ70r3h66LxHq3pivtvqgRwVcOvX8tOucQGb9s2jluTspZz6
	+H1WUNNJccw0Pjob3UNvLjc7rbLVryTw8w==
X-Google-Smtp-Source: AMsMyM5DmuP/cb7ummw1eYAaaNO3HV2hCXIspvKV3BwqgiuD2lvWeVunVhysa8reBu2r718uki7mPQ==
X-Received: by 2002:a5d:47aa:0:b0:236:79cc:6d5f with SMTP id 10-20020a5d47aa000000b0023679cc6d5fmr8494806wrb.391.1667228821116;
        Mon, 31 Oct 2022 08:07:01 -0700 (PDT)
Received: from [10.44.2.26] ([81.246.10.41])
        by smtp.gmail.com with ESMTPSA id f5-20020a5d64c5000000b0022cd96b3ba6sm9403264wri.90.2022.10.31.08.07.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 31 Oct 2022 08:07:00 -0700 (PDT)
Message-ID: <ace10e70-6b8f-ec9c-f2a9-eb00829a79c7@tessares.net>
Date: Mon, 31 Oct 2022 16:07:00 +0100
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.1
Subject: Re: [PATCH mptcp-next] selftests: mptcp: use max_time instead of time
Content-Language: en-GB
To: Geliang Tang <geliang.tang@suse.com>, mptcp@lists.linux.dev
References: <20221022133528.31996-1-geliang.tang@suse.com>
From: Matthieu Baerts <matthieu.baerts@tessares.net>
In-Reply-To: <20221022133528.31996-1-geliang.tang@suse.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Geliang,

On 22/10/2022 15:35, Geliang Tang wrote:
> 'time' is the local variable of run_test() function, while 'max_time' is
> the local variable of do_transfer() function. So in do_transfer(),
> $max_time should be used, not $time.

Out of curiosity, did you create this patch because you were looking at
issue #310 on GitHub?

https://github.com/multipath-tcp/mptcp_net-next/issues/310

Would it help fixing the issues reported by the different CIs?

Cheers,
Matt
-- 
Tessares | Belgium | Hybrid Access Solutions
www.tessares.net
