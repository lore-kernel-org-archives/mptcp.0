Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B49106FA1
	for <mptcp@lists.linux.dev>; Wed, 25 Jan 2023 17:47:40 +0000 (UTC)
Received: by mail-wr1-f46.google.com with SMTP id h12so13869844wrv.10
        for <mptcp@lists.linux.dev>; Wed, 25 Jan 2023 09:47:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares.net; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=CVnrDA+GX4AD5Ev/0IDJ8QHD448gFwb+yD0b07Iwi7I=;
        b=ajMVqWYtRRvaG3hxF5HHEnmXon0r1DrjLS6vUCmhlMCNGI6KuT309xneaP3G2hayz8
         Odxo4k8M36vjceeK34xmvZa9mFXXiX0j2BHhT5tBxWOZnHVY0YJwXoadrczPbdnlJsW5
         mdn++LC+KF5WPhsPo7mtE+nGpufO7zGOVdIgesqcETG2zuYoPMxM2UjeKUYeGB8uwg+t
         SOLCAks6WE2HFP9TyfL4MxWiHm/8bpgw16cD3XHCp0SZy94PxehdjCf9KWfY6J1T+sz0
         doKDEC/q0yGA/bVp5NKS9F+hEGFw0dg4rhniz2+8qQGsW2yXKr04qcCpsrh3uiXyguiq
         xMZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=CVnrDA+GX4AD5Ev/0IDJ8QHD448gFwb+yD0b07Iwi7I=;
        b=8PpGdZcY1q2O2xHwDlwredeexqbGAzptkJM5EO/xk75hPxAi7E0yjamHap+ydzekCP
         dAMvqCUD+8IMYSafsf18NUzwQOy/cT3C7QLo5b4TM9bAX2Qn6oLBp1BdI7OrxeQS4DVr
         I0RpvOiDms1/xwWapHaDcHU5OgDM6iN1TMtI2mjNWapL8/u5imFmIaXnTnFx1r3tLdo4
         B4fbJU8nwQMmqSjF7BpSa5vTqxc+vYZ09viTCQNhZJL8jYQLAEy8/Rszok6Jr22v8+SA
         HmHOirSy/bgTzt0a1zvrLtVmQ7oBKeL+3/nLgllFFE7E381F412lleoOUYq8JpyRUexT
         fymQ==
X-Gm-Message-State: AFqh2kqixcC/m5bspt9nQYje77YHB0MospH5FaEvyuxZnzI3OKr8p8Ux
	QUJ1GMIS64RJi23nUzu91A2msQ==
X-Google-Smtp-Source: AMrXdXvYB9wuDrs2//FJDHU7/vILAGgButfUOmfXRnhBFi8jhdhyt1+lfQZ71/i/vFqayWe9PaMz2g==
X-Received: by 2002:adf:df8f:0:b0:2bd:d9a9:b03d with SMTP id z15-20020adfdf8f000000b002bdd9a9b03dmr32242864wrl.58.1674668858793;
        Wed, 25 Jan 2023 09:47:38 -0800 (PST)
Received: from [192.168.3.222] (213.211.137.183.static.edpnet.net. [213.211.137.183])
        by smtp.gmail.com with ESMTPSA id d9-20020adff2c9000000b002be34f87a34sm5250861wrp.1.2023.01.25.09.47.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 25 Jan 2023 09:47:38 -0800 (PST)
Message-ID: <7cdecbb5-f7f4-fb54-1b32-6db24cfa3323@tessares.net>
Date: Wed, 25 Jan 2023 18:47:37 +0100
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
