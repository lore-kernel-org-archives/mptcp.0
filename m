Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com [209.85.208.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 729956FD0
	for <mptcp@lists.linux.dev>; Thu, 16 Mar 2023 18:28:44 +0000 (UTC)
Received: by mail-ed1-f50.google.com with SMTP id cn21so11460828edb.0
        for <mptcp@lists.linux.dev>; Thu, 16 Mar 2023 11:28:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares.net; s=google; t=1678991322;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=DaY0t/6E9juWeZ9r7PvSQq71c0vnX29Fu+7PPiHV5Rw=;
        b=2xK03R1ZNj76B3hFnggI33YqdkEPrhJuupqSr3/np6T734VtHhgt4W/8uLoikbWE28
         rKG9QG5jJFxBMHr0ZDpkQfzevDPlRDS5m86xN8X+9vujTlte5/F8mOWyuiG+D5TrTdT9
         KdHAchCBmGwbAXvbmCeZmP8msfhyhZ5xDRZR1sniUptcShBe4ilb0Zr3nl8NJeGUNsZX
         +SVkkCo6bdhBImKRkEqwbC27C07b4T4zxWIDhjJmLuDWeRWcJNIKKDboy5+P7DmmQRpc
         MZqzJYnQ51Rmyl+tXgfpfbk+2mEronf0BkV/RS9GCREwz6AZo4NtuoCA1lvmD44kXuU5
         6JOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678991322;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=DaY0t/6E9juWeZ9r7PvSQq71c0vnX29Fu+7PPiHV5Rw=;
        b=DxcJzmElemqqDoBRz/xIqzATonMTnKZahCLPGJe3dCeNEEkm20g2S+jJo2YArHbGiz
         z7BZvzyBQE8BeODSN/CV6DcOO5LNoZ0f24Wcn8Mjwpi4LF3cV8i0KgElzLVhuc0FihEp
         4RXvU+TPg0odTnEChIubNGgyrJmmhhYtQ1wfbLMefcguuHyq/FeDWZJuWXbQQcsA0Drh
         EKCy3bqKTb03zLLZQJA3EcMpzNLAIp9RrSBlOyMEh9D2+2obCt7rikegetmybyQ/fkrZ
         GyVWlOH9jDeOg/78nAhx09+Wr9/6nSGuKL+akUp7VC1wf7yFsZA2VcL/AnBU6FRko2gE
         3Paw==
X-Gm-Message-State: AO0yUKUQ71c/6D7Tix0LlewVenGIwMCG6yA6S0URwsdXf/o7Ymvbk1hS
	g6dNq1DQEbfSZUbgmvBX7yYy6Q==
X-Google-Smtp-Source: AK7set9RhQ8rpCOtnTnw16Fbkz6wsxyGqjDmNSYi+Zm17vCl5OrnzxrqMApfYgFr5GZ4i/jCDEFkDQ==
X-Received: by 2002:a05:6402:b11:b0:4bd:94b9:b8a8 with SMTP id bm17-20020a0564020b1100b004bd94b9b8a8mr462767edb.26.1678991322654;
        Thu, 16 Mar 2023 11:28:42 -0700 (PDT)
Received: from ?IPV6:2a02:578:8593:1200:f605:63cd:a743:20d5? ([2a02:578:8593:1200:f605:63cd:a743:20d5])
        by smtp.gmail.com with ESMTPSA id u3-20020a50d503000000b004fcd78d1215sm102778edi.36.2023.03.16.11.28.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 16 Mar 2023 11:28:42 -0700 (PDT)
Message-ID: <4719462d-02b4-5061-de94-b693c05cd8b6@tessares.net>
Date: Thu, 16 Mar 2023 19:28:41 +0100
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH mptcp-next v5 0/7] mptcp: update userspace pm mptcp_info
 fields
Content-Language: en-GB
To: Geliang Tang <geliang.tang@suse.com>, mptcp@lists.linux.dev
References: <cover.1678778977.git.geliang.tang@suse.com>
From: Matthieu Baerts <matthieu.baerts@tessares.net>
In-Reply-To: <cover.1678778977.git.geliang.tang@suse.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Geliang,

On 14/03/2023 08:31, Geliang Tang wrote:
> v5:
>  - fix a memleak error reported by CI.
>  - add more delay for userspace pm tests.

Thank you for this new version!

I have a couple of questions and comments in the different patches if
you don't mind :)

Cheers,
Matt
-- 
Tessares | Belgium | Hybrid Access Solutions
www.tessares.net
