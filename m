Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9286033FA
	for <mptcp@lists.linux.dev>; Thu,  6 Oct 2022 16:37:26 +0000 (UTC)
Received: by mail-wm1-f53.google.com with SMTP id iv17so1392090wmb.4
        for <mptcp@lists.linux.dev>; Thu, 06 Oct 2022 09:37:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares.net; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date;
        bh=ti0i+OtNNn39ecyZS8X25QZaV+tL26dTv/A7g2hwDvc=;
        b=bllSi/XAdVaBxvFuMVjYIoNQAEJ41e5vhelNfdk+T/tQUu4n6x4X5iez6dPld1Uqbc
         gQVlfaoNkC4KNXmndFSV2QkyDFtNDuKADH9keLjAUmUEQdbbA7VBjny34slASyO66mFw
         GMsspCc6RnPwQ18rUwzwJmvPPveKZ+KSQwCYEYgEAcp1+B9WcymzxuR5pk341OjzELod
         TR43CgpXtf669loyzgTn5fJDM4BbTD1TtadbdO2GPRHmZX12pj1yPeJV+K964VgCa3Re
         286qT4xxdyB5Y0/o857giZMm/4T3nyyMAi3yKkPQhnkOeioU+Y5bqpHF7Wtraeip6FBk
         RHdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date;
        bh=ti0i+OtNNn39ecyZS8X25QZaV+tL26dTv/A7g2hwDvc=;
        b=8EQWwJ/OJN6PRmgKQqDwpHiwjAjMDau0VJAmt0RbJUwc6ckLGy0sy+6J6c7W+egrS1
         EA6ycaAB/5wthAeIhwxk4fteKfBqifMHD9O8aFhPqf0z+Fegm86Hj77Wrx0k/dZod9kd
         hIv/7dlpPE9ipcQ/yXw349bwQXP+FxeIOmiVYkpszOWKFHU0V4LnIuD11mFqj/wyb8VK
         aCJmMlWTorOEfa494U0tiPIBlW80+98rnwX3D9y96wUaFf2XxtatE/ZZEwpofvRrw2RL
         VoKyNBDKUlqwffkLDE/QnZTJfrR9mAy7hemw87jyk9EwTcUOabme2o520GiFYrsAIePX
         T+8A==
X-Gm-Message-State: ACrzQf06dHw39DYbU1FdRnvuy0fsSneUPWQY4vafwNCE388lPbPMjWe1
	/sJBOH61G4NWQo54hX8omVS0lw==
X-Google-Smtp-Source: AMsMyM4AhkFFg9LtwgzrGYADOCP6EucspnadlZtkk1PPOIVqxQJeuDxBcbCFP7OIjmpWeUAtBKMjMA==
X-Received: by 2002:a05:600c:3c8e:b0:3b4:d224:ae27 with SMTP id bg14-20020a05600c3c8e00b003b4d224ae27mr454820wmb.187.1665074244416;
        Thu, 06 Oct 2022 09:37:24 -0700 (PDT)
Received: from ?IPV6:2a02:578:8593:1200:7236:5581:2686:5041? ([2a02:578:8593:1200:7236:5581:2686:5041])
        by smtp.gmail.com with ESMTPSA id r4-20020a05600c320400b003b4727d199asm5093929wmp.15.2022.10.06.09.37.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 06 Oct 2022 09:37:23 -0700 (PDT)
Message-ID: <7a0988a3-840c-bf9a-33c4-e341961956fc@tessares.net>
Date: Thu, 6 Oct 2022 18:37:22 +0200
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.1
Subject: Re: [PATCH mptcp-next v2] mptcp: factor out mptcp_connect()
Content-Language: en-GB
To: Paolo Abeni <pabeni@redhat.com>, mptcp@lists.linux.dev
Cc: Dmytro Shytyi <dmytro@shytyi.net>
References: <c74935435f59a6120f62c56bd5e1519c30d269bf.1664915909.git.pabeni@redhat.com>
From: Matthieu Baerts <matthieu.baerts@tessares.net>
In-Reply-To: <c74935435f59a6120f62c56bd5e1519c30d269bf.1664915909.git.pabeni@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Paolo, Mat,

On 04/10/2022 22:38, Paolo Abeni wrote:
> The current MPTCP connect implementation duplicates a bit of inet
> code and does not use nor provide a struct proto->connect callback,
> which in turn will not fit the upcoming fastopen implementation.
> 
> Refactor such implementation to use the common helper, moving the
> MPTCP-specific bits into mptcp_connect(). Additionally, avoid an
> indirect call to the subflow connect callback.
> 
> Note that the fastopen call-path invokes mptcp_connect() while already
> holding the subflow socket lock. Explicitly keep track of such path
> via a new MPTCP-level flag and handle the locking accordingly.
> 
> Additionally, track the connect flags in a new msk field to allow
> propagating them to the subflow inet_stream_connect call.

Thank you for the patch and the review!

Now in our tree (feat. for net-next):

New patches for t/upstream:
- 04edaeadb0d1: mptcp: factor out mptcp_connect()
- Results: b9a6e8d36365..996a299c16ae (export)


Tests are now in progress:

https://cirrus-ci.com/github/multipath-tcp/mptcp_net-next/export/20221006T162737

Cheers,
Matt
-- 
Tessares | Belgium | Hybrid Access Solutions
www.tessares.net
