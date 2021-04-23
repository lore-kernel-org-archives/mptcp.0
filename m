Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com [209.85.208.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1480770
	for <mptcp@lists.linux.dev>; Fri, 23 Apr 2021 15:27:50 +0000 (UTC)
Received: by mail-ed1-f42.google.com with SMTP id d21so37797202edv.9
        for <mptcp@lists.linux.dev>; Fri, 23 Apr 2021 08:27:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares-net.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=zn8muqwd1CaEQwNaYuAZH3Bic4ivwlhTO8mNPei/9Gw=;
        b=JgwL3C9KQJuY5s7PZ3tNFKwAo9hMu5YHn7g1OUZQVMWkJ0z7jpPG0nmlVxU0Q+gqct
         DXCRnQRcUBycbZnC2CWgEKQgYEsXeKjUHH9APmfVb941DaqzElw5kBWiTzrRzPCnQlMb
         hamVtGvt0MtfZJUiQKSUbNEq5/G13waKhm3n1J51KWOMIcbbuIk391pDuEnOP13AKOUk
         Xns2fIFbhdBu4YSeaYLcE/FkrSy7Xop5qsvDxHsVbKwy8iU8qdj0ZiyaT78KRu8EOh6M
         oAXzDRI7qFRWJsq2sFf5H2GPH1oKZvJRiSDixz4GOUVpEBd6yWXz1asULd6iU+cbAPgr
         zYPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=zn8muqwd1CaEQwNaYuAZH3Bic4ivwlhTO8mNPei/9Gw=;
        b=sJU3bsUrxTR3n7/h5L4Ke+1M2921pu/2eFvSccBKvutp0EWXOjFaHN09YgOyPvfA2A
         X5fA4QOiFx3Eu9BEajxXSFz2LRtvOVxKUGOC/EZGOhhF4Ih/WFXzNNio10vaJb2+JZfS
         3431/17H4rR7K6UJt8dold0rieNSV4+bQijfb8vVfTstcohpkWuXddPBSE/C3Sduo28z
         t8r0syzxpJedo44APRNytggNSBItKj48Dy+rxdRgQfcHPZaWqsiHe+cqkZftC5BBHYOc
         Cv7j5dWao7n0R5uTtI1waS7L81mf/zrVKEbTcwc0yL/Asd/FlmFiOo/ImtPmoN5Mv9lt
         PJfg==
X-Gm-Message-State: AOAM531xJvwnQt/nYNJud5Nr2V+UuLsdeyH0ebc8EHAyd5Fd8mUucXHG
	V8kx8xRa5P1aWBkdSG7fbxKKkvb+Kwgn0A==
X-Google-Smtp-Source: ABdhPJzU6Mwv5S1uQj0BQgj2VaixgoeAfwVYuK2nipggmWQZ4KPFGrr348ZppLLL++VriIYSEpUGXQ==
X-Received: by 2002:a50:9fa1:: with SMTP id c30mr5275800edf.66.1619191669194;
        Fri, 23 Apr 2021 08:27:49 -0700 (PDT)
Received: from tsr-lap-08.nix.tessares.net ([2a02:578:85b0:e00:d068:c16e:598a:1275])
        by smtp.gmail.com with ESMTPSA id e11sm4107502ejl.115.2021.04.23.08.27.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 23 Apr 2021 08:27:48 -0700 (PDT)
Subject: Re: [PATCH mptcp-next] Squash-to: mptcp: Retransmit DATA_FIN (again)
To: Mat Martineau <mathew.j.martineau@linux.intel.com>, pabeni@redhat.com
Cc: mptcp@lists.linux.dev
References: <20210423011108.179263-1-mathew.j.martineau@linux.intel.com>
From: Matthieu Baerts <matthieu.baerts@tessares.net>
Message-ID: <ef3e2791-6a6d-7858-05ca-321a3da5438e@tessares.net>
Date: Fri, 23 Apr 2021 17:27:48 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <20210423011108.179263-1-mathew.j.martineau@linux.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit

Hi Mat, Paolo,

On 23/04/2021 03:11, Mat Martineau wrote:
> Previous testing happened to involve cases where data had been sent and
> the retrans timer was already running. Packetdrill testing revealed that
> the timer was not being started in cases where no data had been
> transmitted, so __mptcp_retrans() was never called. This change starts
> the timer when the original DATA_FIN is sent, if the timer is not
> already running.
> 
> Packetdrill PR is forthcoming.
> 
> Signed-off-by: Mat Martineau <mathew.j.martineau@linux.intel.com>

Thank you for the patch and the review!

- 820118888287: "squashed" in "mptcp: Retransmit DATA_FIN"
- Results: 9fb030889e08..0f7c6f5b4a89

Builds and tests are now in progress:

https://cirrus-ci.com/github/multipath-tcp/mptcp_net-next/export/20210423T152727
https://github.com/multipath-tcp/mptcp_net-next/actions/workflows/build-validation.yml?query=branch:export/20210423T152727

Cheers,
Matt
-- 
Tessares | Belgium | Hybrid Access Solutions
www.tessares.net
