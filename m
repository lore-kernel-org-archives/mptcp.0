Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com [209.85.208.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75E823481
	for <mptcp@lists.linux.dev>; Wed, 28 Jul 2021 07:07:23 +0000 (UTC)
Received: by mail-ed1-f51.google.com with SMTP id ec13so1292559edb.0
        for <mptcp@lists.linux.dev>; Wed, 28 Jul 2021 00:07:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares-net.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=xCnQT3k3XQCibnSkGf8q5faCbzAX0aeTPXqb/dBfiVw=;
        b=ZwYhdfnvI4/eKPF+7d5etZT6hU6zOl48P1KQUcUGRvsriX4tOOtiqVpYPyFiVdsYty
         3nkZUk6TrcKekxwtq/cWWu8PbOMf/0laNLQSRM3hA39+EyFBP/4CVVsYlD+4O2D3Aw+a
         G/NXQvHI/pzVSqQMsQ4rai2ajoSdwfX/mj55rjOkiSSvWQBDCPCjujGr9udOp06e6kFc
         AAqhdTXRvL7mHk7+2dzHqwdReYN6ogAgH08N5bXfG2/SmgNSPjSeMa/9R8igSj7gO+ch
         oaxQi1yeBneDRf2fj3i/I8Z+X4e7/tE3joNGoAel02QuDk8BjzCtelWi3xNn2hsPgLhE
         HodQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=xCnQT3k3XQCibnSkGf8q5faCbzAX0aeTPXqb/dBfiVw=;
        b=NbztQy57x7MNOJAs7oN8t0Z14k4CsTmgyogWFYxcPLextOyKA+h7pJ2sJebgPHISTQ
         4kUwN9wtMypZCwfYBuyzBwD5lmqBBm6H6+zIaHyHNezEPMZiOFtk3FO2+E9McBqLN3VJ
         gDzADpG0UA6D8TaQJCZ+moM4ghchxeWYgKhA5gyu0ZSPUChTgVNoKQvZtVEDqcGPlE3u
         g+JjtMC8CWzZmiQMYH7wdyNZcEBurHN9y9xu4w94SAiO0faakigEYSWVITxcaPOD8qx5
         lOXL6ibs9W1BdAfxoPefNAm93Bjb+kwcfnMAzDoL5/Ozeei4ZaJFcWINGnLyIOV91TQh
         0swQ==
X-Gm-Message-State: AOAM530qnTg5endAFuTgHKe3gCAEN/k0CsiixN8uEasZhLow9bWpphKJ
	UdlM6u9/YjgnZu0Nn3hTJZxgmVib/BqgLA==
X-Google-Smtp-Source: ABdhPJzG0CuoIuBpPdEnEE4jG6Mdcl3Q5L7nseu+A28UkQ9lkGr8uji3mqI1DVN82CU7leDSBuV8Jg==
X-Received: by 2002:a05:6402:1ad9:: with SMTP id ba25mr10075830edb.255.1627456041440;
        Wed, 28 Jul 2021 00:07:21 -0700 (PDT)
Received: from tsr-lap-08.nix.tessares.net ([2a02:578:85b0:e00:c852:afa0:c279:c071])
        by smtp.gmail.com with ESMTPSA id k21sm1667252ejj.55.2021.07.28.00.07.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 28 Jul 2021 00:07:21 -0700 (PDT)
Subject: Re: [PATCH mptcp-next] Squash-to: "mptcp: build
 ADD_ADDR/echo-ADD_ADDR option according pm.add_signal"
To: Paolo Abeni <pabeni@redhat.com>, Geliang Tang <geliangtang@gmail.com>,
 Mat Martineau <mathew.j.martineau@linux.intel.com>
Cc: Yonglong Li <liyonglong@chinatelecom.cn>, mptcp@lists.linux.dev
References: <4206e5473ed255fa08af48a7b5bc0edd00abb99d.1627047074.git.pabeni@redhat.com>
From: Matthieu Baerts <matthieu.baerts@tessares.net>
Message-ID: <a3421f43-1824-4b5a-df91-f753ccfff2e4@tessares.net>
Date: Wed, 28 Jul 2021 09:07:20 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <4206e5473ed255fa08af48a7b5bc0edd00abb99d.1627047074.git.pabeni@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit

Hi Paolo, Geliang, Mat,

On 23/07/2021 15:31, Paolo Abeni wrote:
> We don't need to add a 2nd mptcp_addr_info inside out_options:
> it's quite huge and only one of local or remote is used.
> 
> revert back to a single 'addr' field.

Thank you for the patch, reviews and tests!

Now in our tree:

- 19d088641b4a: "squashed" in "mptcp: build ADD_ADDR/echo-ADD_ADDR
option according pm.add_signal"
- b333d139d5f8: "Signed-off-by" + "Co-developed-by"
- Results: 2fb0dbb4c7c8..fcc436834cac

Builds and tests are now in progress:



https://cirrus-ci.com/github/multipath-tcp/mptcp_net-next/export/20210728T070703

https://github.com/multipath-tcp/mptcp_net-next/actions/workflows/build-validation.yml?query=branch:export/20210728T070703

Cheers,
Matt
-- 
Tessares | Belgium | Hybrid Access Solutions
www.tessares.net
