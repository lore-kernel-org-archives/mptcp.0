Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FA851FB4
	for <mptcp@lists.linux.dev>; Wed, 25 Jan 2023 18:33:43 +0000 (UTC)
Received: by mail-wm1-f46.google.com with SMTP id q10-20020a1cf30a000000b003db0edfdb74so2918766wmq.1
        for <mptcp@lists.linux.dev>; Wed, 25 Jan 2023 10:33:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares.net; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=UZvAQoDF/QLESy+VkP+7yHOHdZZ9XqXm3gnWLr1gky4=;
        b=M8mtEN9BpgP70quViWaan62WXo1zJld0IZwl5S1bcr5gayU4kFbTbWj1sUp1EuUylH
         1/2vUayYtFke7A3N8xyOo2N+UaOnwEFdRVv1tOCWCvxZJjuRFDOXW+kH6HTOiToCoiHB
         fEOOcVJNvILd50Il8usdmbgmQsYup94GCiqeGdF65lZ3EeI09xjFcOW0Yv2yXvwguSmF
         2P6ySuOST0ZGjcTcwx09+P4ywnipix4+wFHqtR33JpMunfE+Vjzc3Z8RrgV5EhxO8F8U
         laEKDCBj9mMzJV5s4+BTWrmr4Me1xv17+hfFkK+V86rwwVWmkayaCzIshng7nslEbDUJ
         2IGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=UZvAQoDF/QLESy+VkP+7yHOHdZZ9XqXm3gnWLr1gky4=;
        b=yzOhL67pTjp1xH6W35fbsFCUsg+YPtbCJJapN2wP0f2NSjU7iLaicARcGA6JVyQNOn
         ekkdgBPDwxtrpAWT93UnjSQN7w/RjvXr6C1rY5QrtRkh1Vzm6bn3GnP1OMGd5XEWWF5W
         EIaTxTbDDCUb3TVJXcJLjDeFEfOjGhLGBv9q4xaAgwz1NbZj0UNZNBf7QsIUU96qyF3z
         2iPygV+MmaZWh971hoTX7zwO6pcBh5yS2TemqMkUJgKqOzHZCrnooaxs9d+yjWn9h4SW
         BFoLaWnJt04WErtEmhTQ10DppSI2V/ZFqpY5FeiTFOGWVzt7wZt61kOsQdUjtGe6kSn7
         u2cg==
X-Gm-Message-State: AFqh2koS82LwYsvy7oDVA4R+qiW6jhwVWr1DZmvocA+q8YOk8ic9B+fx
	E9iKbkbemn5dsy+w2cwjdlfRJPMHZgtAeeuRMZg=
X-Google-Smtp-Source: AMrXdXs/lIJMHwPz20sVN0B8N9ikYcyCLlolOKNL6GtitKshK8GWLOfFXFj0sBrtsVFYQNTyLNeelg==
X-Received: by 2002:a05:600c:434b:b0:3d9:cc40:a8dc with SMTP id r11-20020a05600c434b00b003d9cc40a8dcmr31067779wme.27.1674671621448;
        Wed, 25 Jan 2023 10:33:41 -0800 (PST)
Received: from [192.168.3.222] (213.211.137.183.static.edpnet.net. [213.211.137.183])
        by smtp.gmail.com with ESMTPSA id n24-20020a7bcbd8000000b003daf7721bb3sm2396759wmi.12.2023.01.25.10.33.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 25 Jan 2023 10:33:41 -0800 (PST)
Message-ID: <411cc0b4-af7f-5019-b2ac-a7361f3dcaa9@tessares.net>
Date: Wed, 25 Jan 2023 19:33:40 +0100
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.0
Subject: Re: [PATCH mptcp-net] mptcp: do not propagate fallback subflow status
 on error
Content-Language: en-GB
To: Paolo Abeni <pabeni@redhat.com>, mptcp@lists.linux.dev
References: <97f7deb4132d567132088d43f3e7f5ff0602a45b.1674668294.git.pabeni@redhat.com>
From: Matthieu Baerts <matthieu.baerts@tessares.net>
In-Reply-To: <97f7deb4132d567132088d43f3e7f5ff0602a45b.1674668294.git.pabeni@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Paolo,

On 25/01/2023 18:38, Paolo Abeni wrote:
> Currently the subflow error report callback unconditionally
> propagates the fallback subflow status to the owning msk.
> 
> That is not needed as there is a great deal of infrastructure
> trying to propagate correctly the fallback subflow status to
> the owning mptcp socket, e.g. via mptcp_subflow_eof() and
> subflow_sched_work_if_closed().
> 
> And in some circumstances - specifically if the msk is already
> orphaned - it prevents the code from correctly tracking the msk
> moving to the TCP_CLOSE state and doing the appropriate
> cleanup.
> 
> All the above causes increasing memory usage over time and
> sporadic self-tests failures.
> 
> Address the issue simply removing the unneeded state update.
> 
> Closes: https://github.com/multipath-tcp/mptcp_net-next/issues/339
> Fixes: 15cc10453398 ("mptcp: deliver ssk errors to msk")
> Signed-off-by: Paolo Abeni <pabeni@redhat.com>

Good catch!

Thank you for the quick fix!

It looks good to me and it seems to fix the issue on my side as well
(with a slow VM) :)

Reviewed-by: Matthieu Baerts <matthieu.baerts@tessares.net>

Cheers,
Matt
-- 
Tessares | Belgium | Hybrid Access Solutions
www.tessares.net
