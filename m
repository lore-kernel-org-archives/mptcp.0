Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com [209.85.208.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0990B2C9C
	for <mptcp@lists.linux.dev>; Fri, 17 Dec 2021 11:40:36 +0000 (UTC)
Received: by mail-ed1-f49.google.com with SMTP id o20so6623452eds.10
        for <mptcp@lists.linux.dev>; Fri, 17 Dec 2021 03:40:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares-net.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :references:cc:from:in-reply-to:content-transfer-encoding;
        bh=I2hHeM+CS4D4F2v5JpMezrFzPZsBcrymhYBtMO2hpn0=;
        b=Wf4cQ3suylfc2PjOx7MppuMiOGTBT+07NUKocJCwM1tTOnuXgTuUS1EHf+Hp0Cszed
         9e08LaNI5EsC4pHLy7PjqQIgCnn8CAWTYYDqkMqOGJCbuV9T5q7ZWF2ouSdlW2O3WyvG
         CzKpuoGPbgqMsC59HWQhMARZN/lDB/h5pNbte6A9gEWnwRo79AWgjmvNKFOYhgp09vKx
         cUXOzTEoZAyH/SQQKxVdFlb6At3kEqIkqwMUSVOajyBYkAieaCIVuEKff7vXYMw+Q2w2
         Y0u9oQVcqSLR6XfLE/NyyyUYznM8AVAEczfSSZv1dvYzX3kE3isJTbxANJ1PbfCiS/uz
         9/zg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:references:cc:from:in-reply-to
         :content-transfer-encoding;
        bh=I2hHeM+CS4D4F2v5JpMezrFzPZsBcrymhYBtMO2hpn0=;
        b=NhS4wRJ0fgJL7D8mNIOvX9FrRbMhkrltfSzBxNq8/4J+lrD47B4NSU/qioJvmSKxxv
         DG6AoKfmsQtArxVksqN/kDDOqw9PvB4XrqcmIh6lhGsxQlIEcdcVaiyR7x1YTOFC3w87
         Kn6eY07St+wHH88YiVpBKTK5ikzn1/acGxiU/zLzJ+krs95prPctE943DN2y12e4oesr
         mWFVJcxLoNTzwVVmK4M877Cnid1d96AhAXY+rObN+lvNmQVhHju+UbZw2urRPo4/yiPh
         VAXvCYNum/aH3aUVFGlsAH+Wb2OGwTVrY7BVNwljWTMcs5IZsBvw1vFKkR3WNnuY0Uxy
         gtGw==
X-Gm-Message-State: AOAM5310sHZL0Q4rLyH19TBR8ei5SKYeF2p0W+UeXtVvm2KZSFEz4mIM
	KHK7ieOjGloCdGvsL6lMM1/BRL1c4yUfvQ==
X-Google-Smtp-Source: ABdhPJzhvO/UqMYEC2RaZJ/omeHmsxFtyttPu4+oYrNkmjZwU9c6g+I9exbqD7qUdiefxZDeITzabA==
X-Received: by 2002:a17:907:86a6:: with SMTP id qa38mr2230736ejc.286.1639741234925;
        Fri, 17 Dec 2021 03:40:34 -0800 (PST)
Received: from [192.168.178.33] (94.105.100.208.dyn.edpnet.net. [94.105.100.208])
        by smtp.gmail.com with ESMTPSA id y17sm3695603edd.31.2021.12.17.03.40.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 17 Dec 2021 03:40:34 -0800 (PST)
Message-ID: <d42754d8-b911-97bb-e755-f70a40f35665@tessares.net>
Date: Fri, 17 Dec 2021 12:40:33 +0100
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.0
Subject: Re: [PATCH mptcp-next] Squash-to: "mptcp: cleanup MPJ subflow list
 handling"
Content-Language: en-GB
To: Paolo Abeni <pabeni@redhat.com>,
 Mat Martineau <mathew.j.martineau@linux.intel.com>
References: <70e15da075bab481ac07ed1ce8c2adc9740403c6.1639665203.git.pabeni@redhat.com>
Cc: mptcp@lists.linux.dev
From: Matthieu Baerts <matthieu.baerts@tessares.net>
In-Reply-To: <70e15da075bab481ac07ed1ce8c2adc9740403c6.1639665203.git.pabeni@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Paolo, Mat,

On 16/12/2021 15:33, Paolo Abeni wrote:
> The self-tests in a loop triggered a UaF similar to:
> 
> https://github.com/multipath-tcp/mptcp_net-next/issues/250
> 
> The critical scenario is actually almost fixed by:
> 
> "mptcp: cleanup MPJ subflow list handling"
> 
> with a notable exception: if an MPJ handshake races with
> mptcp_close(), the subflow enter the join_list and __mptcp_finish_join()
> is processed at the msk socket lock release in mptcp_close(),
> the subflow will preserver a danfling reference to the msk sk_socket.
> 
> Address the issue fragting the subflow only on successful
> __mptcp_finish_join()

Thank you for the patch and the review!

Now in our tree:

- 494ff5ec1dd6: "squashed" in "mptcp: cleanup MPJ subflow list handling"
- Results: cabf1e05f011..82c91858f45c

Builds and tests are now in progress:

https://cirrus-ci.com/github/multipath-tcp/mptcp_net-next/export/20211217T113938
https://github.com/multipath-tcp/mptcp_net-next/actions/workflows/build-validation.yml?query=branch:export

> Note that issues/250 triggers even before
> "mptcp: cleanup MPJ subflow list handling", as before such commit the join
> list was not spliced by mptcp_close(). We could consider a net-only patch to
> address that.
Please note I didn't close issues/250 for this reason.

Cheers,
Matt
-- 
Tessares | Belgium | Hybrid Access Solutions
www.tessares.net
