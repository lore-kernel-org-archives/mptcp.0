Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com [209.85.218.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B63771
	for <mptcp@lists.linux.dev>; Fri, 30 Apr 2021 09:35:17 +0000 (UTC)
Received: by mail-ej1-f43.google.com with SMTP id gx5so12188100ejb.11
        for <mptcp@lists.linux.dev>; Fri, 30 Apr 2021 02:35:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares-net.20150623.gappssmtp.com; s=20150623;
        h=to:cc:references:from:subject:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=P6BEhRai7SSWLrS83o44Lj65eNkiwDCTNkPTTW+6p7M=;
        b=Xe2L2Iv4N81KropH4v7XyDJQc3OE0XS3FmyCirluYPrgXxY8ry42TEf5cgenMLBvAa
         hvsB9wO9zYrAtIta030aJng/0lA9v0SYO9JjiLmh3iEe2IGuLiykR0oRAhw55RDH6yXr
         CLXeKx0y7r+ybEpSj+v1cYHDAqpoFQGvployxmw7ONAp82tZbSYscCnOv8x0F87HTCIw
         mIEMuHEI7w9tTPNlPzuqb/qOyoyEW8AAksfXY1Q2Zt7CIGE2wCNK3JEsj/KkOKMHSpK/
         3pUrczvnnKuQ3/76mcek3ZhaUXi0WjF/72/BbTvgE6qIMcZTxOOminvI7zLwv5UivdwJ
         anrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:cc:references:from:subject:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=P6BEhRai7SSWLrS83o44Lj65eNkiwDCTNkPTTW+6p7M=;
        b=eCMKciGLgA7e8bRa5vuSqfNnp0A+QuoC48NE0I40w4r0/f47RgmWaTeRg+ewr9aecx
         6hIPKdyWij1x9tN0A0gS08Ueqbt5GyZVISi2lsiQ/MJXuMV+GWGl0LoafTKu7UPyh9PY
         rIDfjOPk77CLZ5+NCT6m212b3NyXhiVMbXMhmRypalJa4dAGvqUrhdoY5x9XCp3538ok
         kF3R2E+vPCF+n8LOw03goJ2202L5vUYGbJFLkyxtC/Tqpoe+Jxb0PF0882ut05wOfL2V
         CqHxM2FMTnKnNlOoWn9/76riF3PFJ5g2AX8L5JUkRnTMqIHlbGtE1eUWJ2LAG9CBCtt7
         9QPA==
X-Gm-Message-State: AOAM532bcncX6/1HOGYuKThGmzPaILuINSwCdAkJAQQ3zWXoui9Xig5w
	EzPJMYPyB24BfVHMZdCiyRyGXw==
X-Google-Smtp-Source: ABdhPJzy02t7m5KwDTJFk5yRnGLliPOAoWac5wXVKiLl7D6/I3Jm0+UzJhi+952PyLpJ6CDSqI3RQQ==
X-Received: by 2002:a17:907:3f99:: with SMTP id hr25mr9582ejc.231.1619775316344;
        Fri, 30 Apr 2021 02:35:16 -0700 (PDT)
Received: from tsr-lap-08.nix.tessares.net ([2a02:578:85b0:e00:b92a:fcbd:82a0:9dba])
        by smtp.gmail.com with ESMTPSA id s20sm836788edu.93.2021.04.30.02.35.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 30 Apr 2021 02:35:16 -0700 (PDT)
To: David Ahern <dsahern@kernel.org>
Cc: mptcp@lists.linux.dev, Paolo Abeni <pabeni@redhat.com>,
 Jianguo Wu <wujianguo106@163.com>, netdev@vger.kernel.org
References: <ea7d8eb1-5484-09dc-aa53-cf839b93bc73@163.com>
From: Matthieu Baerts <matthieu.baerts@tessares.net>
Subject: Re: [PATCH iproute2] mptcp: make sure flag signal is set when add
 addr with port
Message-ID: <6ec00dc5-de95-566d-f292-d43a3f5cf6cb@tessares.net>
Date: Fri, 30 Apr 2021 11:35:15 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <ea7d8eb1-5484-09dc-aa53-cf839b93bc73@163.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 8bit

Hi David,

Thank you for maintaining iproute2-next!

On 23/04/2021 12:24, Jianguo Wu wrote:
> From: Jianguo Wu <wujianguo@chinatelecom.cn>
> 
> When add address with port, it is mean to send an ADD_ADDR to remote,
> so it must have flag signal set.
> 
> Fixes: 42fbca91cd61 ("mptcp: add support for port based endpoint")
> Signed-off-by: Jianguo Wu <wujianguo@chinatelecom.cn>

I see on patchwork[1] that this patch is marked as "Accepted". But I
cannot find it in 'main' branches from iproute2-next.git and
iproute2.git repos.

Did I miss it somewhere?

If it is not too late, here is a ACK from MPTCP team:

Acked-by: Matthieu Baerts <matthieu.baerts@tessares.net>

Thanks Jianguo for this patch!

Cheers,
Matt

[1]
https://patchwork.kernel.org/project/netdevbpf/patch/ea7d8eb1-5484-09dc-aa53-cf839b93bc73@163.com/
-- 
Tessares | Belgium | Hybrid Access Solutions
www.tessares.net
