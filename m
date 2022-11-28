Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com [209.85.208.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FEBC8F5D
	for <mptcp@lists.linux.dev>; Mon, 28 Nov 2022 16:18:31 +0000 (UTC)
Received: by mail-ed1-f47.google.com with SMTP id e13so16112062edj.7
        for <mptcp@lists.linux.dev>; Mon, 28 Nov 2022 08:18:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares.net; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=JJ3ZMnoKNCd0cbYjlXl2fx3A3LKS5FB+6yTHwh5eXQI=;
        b=Yp0oMmxRsYbhcOiPcRnZg8kyTySPDJAGwn5pV3Q+onkAjkwEUAWSC2/dzFfnTZ9fvy
         m0Km5+Wy402uGXH4sJMjn8f8lu2Igp3+xYreBOZUL0khMt+iH8WthHzHb3qR+gmoD2L2
         IWsYJTfB4MaFuQwe3MhAo4syMkSIZKVMFRz9UkSk+s+pFuEMKroleI0qGP0c/kcals6y
         VUx46We+lH1/4cL9xO81YTT5UmSeW7537UpqIGZL4JIRUUKYhRJXv4CI5E6fvs6IU1wB
         Asz0RYIB63JMthXJZrBMz/2igcspl50lw1nHGuBwMEIkXZNvq8++CrXmjJnyWpJeb4l8
         Rsnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=JJ3ZMnoKNCd0cbYjlXl2fx3A3LKS5FB+6yTHwh5eXQI=;
        b=LV5w2uCw6hb5wuluYumhnSG2D+MqXi16kOFUEfeBZoqfTBKTKUTHk3e7s3AiGIk3C5
         85v4Q9/nUuRGHczpkwaXLqOJq6TyMHDCwItlx8F/dXXjvzkrpucpGhwdD96wlDiY4I0E
         WR0CxNx3PneC3qei7MvLP15kt4upUs2zAXPssGBzU0uB5qEgmLVxRVWNhXDOVeoAEzc1
         u9/9MqwGS6hNPYUDfE7gC5NiqshCx3+XoP3Fn9dk2xFs4f5vTgEpK3218y4LMWkHqE9C
         hEstZjYWYdjf4nYQydvzk2mqEREGESqIUlRofOF0UBidExaH8cn5JkpQqts3PirB0way
         stmQ==
X-Gm-Message-State: ANoB5plPTNkRMZe/Ot6vcAKWrz/VuzMxrBDMZu00uvVFDcfchiB4ZfFa
	KivWLqRtg+rY5sLUKLU6YggGEA==
X-Google-Smtp-Source: AA0mqf4iqUUKGKnnWc6hdV8msCgfdrqFpFMGEVXtbt1mU4fS9n+8CF6/+9puaA1v8ZVRg7anwoLuhg==
X-Received: by 2002:a05:6402:1156:b0:467:374e:5f9b with SMTP id g22-20020a056402115600b00467374e5f9bmr30960616edw.283.1669652309554;
        Mon, 28 Nov 2022 08:18:29 -0800 (PST)
Received: from [10.44.2.26] ([81.246.10.41])
        by smtp.gmail.com with ESMTPSA id s7-20020a056402164700b0045c47b2a800sm5256876edx.67.2022.11.28.08.18.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 28 Nov 2022 08:18:29 -0800 (PST)
Message-ID: <c0216a19-3598-7284-0b2c-1ac35488e442@tessares.net>
Date: Mon, 28 Nov 2022 17:18:26 +0100
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.3
Subject: Re: [PATCH mptcp-net] mptcp: netlink: fix some error return code
Content-Language: en-GB
To: Wei Yongjun <weiyongjun@huaweicloud.com>,
 Mat Martineau <mathew.j.martineau@linux.intel.com>,
 Paolo Abeni <pabeni@redhat.com>, Kishen Maloor <kishen.maloor@intel.com>,
 Florian Westphal <fw@strlen.de>
Cc: Wei Yongjun <weiyongjun1@huawei.com>, mptcp@lists.linux.dev
References: <20221118083541.123585-1-weiyongjun@huaweicloud.com>
From: Matthieu Baerts <matthieu.baerts@tessares.net>
In-Reply-To: <20221118083541.123585-1-weiyongjun@huaweicloud.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Wei,

On 18/11/2022 09:35, Wei Yongjun wrote:
> From: Wei Yongjun <weiyongjun1@huawei.com>
> 
> Fix to return negative error code -EINVAL from some error handling
> case instead of 0, as done elsewhere in those functions.
> 
> Fixes: 9ab4807c84a4 ("mptcp: netlink: Add MPTCP_PM_CMD_ANNOUNCE")
> Fixes: 702c2f646d42 ("mptcp: netlink: allow userspace-driven subflow establishment")
> Signed-off-by: Wei Yongjun <weiyongjun1@huawei.com>

Thank you for the fix (and sorry for the delay), it looks good to me!

Reviewed-by: Matthieu Baerts <matthieu.baerts@tessares.net>

Cheers,
Matt
-- 
Tessares | Belgium | Hybrid Access Solutions
www.tessares.net
