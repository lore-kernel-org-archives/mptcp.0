Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FE8A468B
	for <mptcp@lists.linux.dev>; Sat, 23 Sep 2023 08:32:12 +0000 (UTC)
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-31c5cac3ae2so3240763f8f.3
        for <mptcp@lists.linux.dev>; Sat, 23 Sep 2023 01:32:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares.net; s=google; t=1695457930; x=1696062730; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=6xC9UkJnP+Y8C4ZK1Ugwvkm6ovdNYCxTPDftJTdSFRA=;
        b=3+BmAb9yaIMZ3XgTTkYELqlCdiPR4RAqN8+QjgtSgobY2VzoI9oXBwV8gFgehgmJNV
         3OUTA3lVBXNqOnV7uvhsDkICIh/DJrSmiNboV8DrwhzNo/z5Bl73FGOb/z0uaxrdTdYM
         A+S8mnSfZI1AWJW4CZAXsC1c7ujHkHVAz1COE7nREpyov+jz9YiNqxSUIXz+gcTeKGOj
         qvx89+AGf4edvlAF+cbANpbbZu4GLrxEwIhVpRTqQjN3xivF80TAQ8Sv17C5Ctp/wDUE
         OKWw01y05HVuEYjva+ego6IGD0O5OPmhsvs5CdCrlKbxU+QWZ4gj2bfZkfGo7eq4CMNe
         a+gA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695457930; x=1696062730;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=6xC9UkJnP+Y8C4ZK1Ugwvkm6ovdNYCxTPDftJTdSFRA=;
        b=OQs3Zg3Hqzrfrkl3dmSHcDfzKu6E7kcJP+VNSjkGrks6dzG7MmAX2r48iDvZQKj3Hn
         frVn9QTRNu/XJq1oXiOFBwPadaaLwvkiqAR8gFBn1uzIg6ZX3rtY5L/c9iKfRRD2cE8v
         vUfNn820rTqVuOfFr+wQ360Nd7iW3MzDQsvgsllbBzlr/KVeIlAobjBD30tM7WfymfDu
         x3ljwrBp7ylWfgk5lt5QcbODaxNrJbSMF/qMtzmFa8IphiXhswvpuS7Jstt7Z6343F4L
         UzhO8Xgv6oAcO0HuTY8jvkrLu6rRKxo8+WglvyNs0ySFr9HFjeMxPTnOwVmPuWtDKLbH
         RL9Q==
X-Gm-Message-State: AOJu0YyAOn4toLyTHrNkPVNFH38e1RHGH6cgLXjxmW3dvevcLHPsw9v7
	awghnnJ0owSttjuxxqfOxXCmed+DjrW8xnAYHKUFNg==
X-Google-Smtp-Source: AGHT+IEjFSQv7P4rd/4K1ut/0tYymBVKyoLk4KqIkM4BKYy8CPoaszaNir4qFJLf94OD44k6XeNsVw==
X-Received: by 2002:a5d:60d2:0:b0:321:5e13:3829 with SMTP id x18-20020a5d60d2000000b003215e133829mr1593139wrt.1.1695457930402;
        Sat, 23 Sep 2023 01:32:10 -0700 (PDT)
Received: from ?IPV6:2a02:578:8593:1200:1c88:7af9:498d:bb0e? ([2a02:578:8593:1200:1c88:7af9:498d:bb0e])
        by smtp.gmail.com with ESMTPSA id e10-20020a5d594a000000b003180fdf5589sm6436956wri.6.2023.09.23.01.32.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 23 Sep 2023 01:32:10 -0700 (PDT)
Message-ID: <c536013e-f066-433b-8b41-a7eb60d4704f@tessares.net>
Date: Sat, 23 Sep 2023 10:32:09 +0200
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 mptcp-next 0/4] mptcp: misc improvement
Content-Language: en-GB, fr-BE
To: Paolo Abeni <pabeni@redhat.com>, mptcp@lists.linux.dev
References: <cover.1695368456.git.pabeni@redhat.com>
From: Matthieu Baerts <matthieu.baerts@tessares.net>
Autocrypt: addr=matthieu.baerts@tessares.net; keydata=
 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
In-Reply-To: <cover.1695368456.git.pabeni@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Paolo, Mat,

On 22/09/2023 09:42, Paolo Abeni wrote:
> This series is a follow-up the discussion ongoing here:
> 
> https://github.com/multipath-tcp/mptcp_net-next/issues/437
> 
> Daire reported several sub-optimal MPTCP behaviour on high-latency
> links.
> 
> At least 3 different items stands off:
> 
> * notsent_lowat setting fooling the scheduler
> * sub-optimal send buffer autotuning
> * delayed acks being de-facto disabled due to subflow rcvlowat
> 
> This series is an attempt to address the first 2 points above.

Thank you for this nice series and the reviews!

Now in our tree: the first patch has been added in "fixes for -net" and
the rest in "feat. for net-next".

Please note that I had a small conflict in patch 3/4, a conflict with
"mptcp: give rcvlowat some love" from your other series I applied first.

New patches for t/upstream-net and t/upstream:
- 24f95a78eca5: mptcp: fix delegated action races
- Results: d92d8f5c2b45..50606b0ed27d (export-net)

New patches for t/upstream:
- b17ad6bb5a17: mptcp: consolidate sockopt synchronization
- f1f975d21614: mptcp: ignore notsent_lowat setting at the subflow level
- 5bc3584d46b5: mptcp: refactor sndbuf auto-tuning
- Results: f2baa63004ad..7221fbbb862a (export)

Tests are now in progress:

https://cirrus-ci.com/github/multipath-tcp/mptcp_net-next/export-net/20230923T082403
https://cirrus-ci.com/github/multipath-tcp/mptcp_net-next/export/20230923T083048

Cheers,
Matt
-- 
Tessares | Belgium | Hybrid Access Solutions
www.tessares.net
