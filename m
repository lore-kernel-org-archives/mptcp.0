Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8755472
	for <mptcp@lists.linux.dev>; Tue, 24 Aug 2021 10:07:03 +0000 (UTC)
Received: by mail-ej1-f42.google.com with SMTP id me10so14810359ejb.11
        for <mptcp@lists.linux.dev>; Tue, 24 Aug 2021 03:07:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares-net.20150623.gappssmtp.com; s=20150623;
        h=to:references:from:subject:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=m4/3uTwsrtpZvDGudsW95u2MN06mTQcTux9FJf4YbQo=;
        b=n/lz3xrkZCT+/Gh/8MB7IVNw6PBEr1Z5NRvVsC1cm4WcgqtOwCXdkbm1Ap9jGOWnQ6
         BpkKINtY9NUtoeeWi8GEZfjG6xMDASVuWGAqS/KRQQGtYK2rjXT5Qs8T/yZhrW5WmIxw
         Y/ukeKsAvcCNJiF0CPt++8ExM+0lsVi+3BltP4ABNNnaQi/dhc1pvxYmWP2EXeXvTjet
         SfQ0tcjxkpQ0ZseN2/9i9HZV+VHVicpoSi+Nx5PqTAqFuZ6xyfBZwYmrE1JfkueGzELd
         EH3sJSGKs4HLssW9B3+nL36K/9GG5XTH5+Rjpe2QpESTqCCdUMaevcrgZt3AfyS2iE/Q
         R3SA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:references:from:subject:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=m4/3uTwsrtpZvDGudsW95u2MN06mTQcTux9FJf4YbQo=;
        b=SC00xIjtudkfn/aUTtlMyrnx0eqE+FII24yhpUS9fq0jFDvP5aOkTuAoMqLdVdKiGM
         a2zbpQTSgQMs2V1LbKyVxCNnXvFWq9d1djXvnCRxcVZ+DbsU02zHuzyJ83gbF8kYNU4D
         KO0IKKSBmSmiLDJmrMg2YU2jKnQCXrzNLIXu5Yirmw5Pb2HXNsYHqFMRkiBRQPAVUtPU
         hMBkCQtfSm7cm95Dvh1hBMSR5qcxItuBSBHR9BdYpkRbskHhb8ye+t38SeSp94IyoRk1
         BVqKUCe0nkSBe04AUO2/skn6KVM2WJEHcS4b67XXp4PVBdE5bbuOMT8Q049Zo2RPMiWs
         PK0w==
X-Gm-Message-State: AOAM532X1TYCatkqW4M+yKxCgxcJecUVHvJmegTKNIv2TeBGuq2mQNk/
	DYsROZssuNRYvpoUB4N+4PjwQpP45qm4CDw+khs=
X-Google-Smtp-Source: ABdhPJwyg5pbtoupJaH01fkFboygOz/F7pS380BnUL8ADtI8PulTdxe/gDoo3lgxZTiliBlkB9C8iw==
X-Received: by 2002:a17:906:43c9:: with SMTP id j9mr39508195ejn.57.1629799621477;
        Tue, 24 Aug 2021 03:07:01 -0700 (PDT)
Received: from tsr-lap-08.nix.tessares.net (94.105.103.227.dyn.edpnet.net. [94.105.103.227])
        by smtp.gmail.com with ESMTPSA id f6sm8541806eja.88.2021.08.24.03.07.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 24 Aug 2021 03:07:01 -0700 (PDT)
To: Paolo Abeni <pabeni@redhat.com>, mptcp@lists.linux.dev
References: <0a5ab819684c76d5947ee91c43a1bbd75f5aa47c.1629796563.git.pabeni@redhat.com>
From: Matthieu Baerts <matthieu.baerts@tessares.net>
Subject: Re: [PATCH mptcp-net] Squash-to: "mptcp: fix possible divide by zero"
Message-ID: <16bc5301-b4cb-2cf2-0bcb-f6dca4b560b1@tessares.net>
Date: Tue, 24 Aug 2021 12:07:00 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <0a5ab819684c76d5947ee91c43a1bbd75f5aa47c.1629796563.git.pabeni@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 8bit

Hi Paolo,

On 24/08/2021 11:16, Paolo Abeni wrote:
> With the current 'can_collapse' definition, skb collapsing/coalescing
> may not happen have if can_collapse is true. Since we fill the
> tx cache only if 'can_collapse' is false, the TCP code can end-up
> allocating an skb without mptcp extension and triggering a later
> WARN
> 
> Fix the issue using a much more restrictive check for collapsing, so
> that if such check is true, collapsing will happen for sure.
> Additionally change the variable name accordingly and remove a now
> erronous WARN_ON - collapsing can happen even if must_collapse is false.
> 
> Note that if by some bug we hit the opposite erroneous condition -
> collapsing did not happen even if must_collapse is true - we will hit
> the existing WARN_ON_ONCE(!mpext) check.

Thank you for the patch!

Now in our tree:

- 56344a303b57: "squashed" in "mptcp: fix possible divide by zero"
- Results: e4be38126ede..d9f4bc9e6463

> The coming message in the squash to commit should be updated replacing:
> 
> """
> This change addresses the issue refactoring the skb allocation
> code so that skb allocation always happens after the call
> to tcp_send_mss() correctly initialize mss_now.
> """
> 
> with:
> """
> This change addresses the issue refactoring the skb allocation
> code checking if skb collapsing will happen for sure and doing
> the skb allocation only after such check. Skb allocation will happens
> only after that the call to tcp_send_mss() correctly initializes mss_now.
> """

Done!

- fa7fdd39cdd2: tg:msg: update commit message after squash-to patch

Builds and tests are now in progress:

https://cirrus-ci.com/github/multipath-tcp/mptcp_net-next/export/20210824T100358
https://github.com/multipath-tcp/mptcp_net-next/actions/workflows/build-validation.yml?query=branch:export/20210824T100358

Cheers,
Matt
-- 
Tessares | Belgium | Hybrid Access Solutions
www.tessares.net
