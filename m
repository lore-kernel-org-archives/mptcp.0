Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B02271
	for <mptcp@lists.linux.dev>; Thu, 17 Jun 2021 13:25:38 +0000 (UTC)
Received: by mail-ej1-f48.google.com with SMTP id l1so9908195ejb.6
        for <mptcp@lists.linux.dev>; Thu, 17 Jun 2021 06:25:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares-net.20150623.gappssmtp.com; s=20150623;
        h=subject:to:references:cc:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=x7WYx7FBo1vvsgS0AS9lyAynhBzNe2QgPtPpeN3KmCY=;
        b=tsreMEMnbcYzcsT+wK0ZhXAr99NUiBX3VOvgXWK8PC0HmR2SNQiKr4fMPL2TKdCLMz
         Iq4f5z0wS15G8tLd7mb9CcXehqKLI70d13DGczSoiAeVTT3+Ye37DxI6V3af8n4knrtJ
         UPFwtefRMo3QEJ9DGgwYLThIEpUD4ysiKEQUoaKrKtO1Z/VQ06so59ZPBHIxLrDy1/H2
         TJcUdWpc3ibQ3mq5xezaFRXXEvqfSgXffuktTBhKid/gDEJyrwaBi4uCYN8fwVQN8z8I
         h6aJ/7fppzOPXRMi0OzZXXpj5EaYWceM+s5oEb54CtVi8G3LL6h/5wNrV2f547YWx8J+
         yfvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:cc:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=x7WYx7FBo1vvsgS0AS9lyAynhBzNe2QgPtPpeN3KmCY=;
        b=NRKM8BuOrRsDu+SZXlQ+MRbW/ZwTEeans0bXOTiuNe12sQQk8UmVAHPkDx5nhAtihE
         WR60S3sX7qQ3ySmg/eShTCEKs/74dm2kcYibnRYw9MRMhWZzCTFFOG+kEhfqCYHSi1kw
         a+/RKWYaUhehs82korI/ArZeGrtM7S6d3MMRk0yVAhVlZ5gE2H7k9BcwLWUuedrTbziq
         JEXdPPpNAgxyiQCcJzzarSiA8DEDcg2NsdEJfUPArvH+alimmeqhxwJ6763VcP3cMStj
         32/OYoda6FiaJkuPLoT0ffp9vfXXfnq18SJQhiDpv+hW3zVCRv5mUBUJLoYIwJOOuH1T
         SQhg==
X-Gm-Message-State: AOAM531fHlhtDidmLQ5M2o3cE7GEQs0ZkSPd/KPwqigPqvH/+8IOp4F5
	UcufKX1Xu+cJF0Rl0RKqJLGn/Hl/8GDqaIuKvMY=
X-Google-Smtp-Source: ABdhPJzK2TOqJXGnvlf0U85QeH7S+p+0BNtJEjU0TtaPD7fBzFdc0ifDud3wrnVACxdB9/0ODhzQFw==
X-Received: by 2002:a17:906:4c8c:: with SMTP id q12mr5308370eju.254.1623936337455;
        Thu, 17 Jun 2021 06:25:37 -0700 (PDT)
Received: from tsr-lap-08.nix.tessares.net ([2a02:578:85b0:e00:7d63:1645:b739:5196])
        by smtp.gmail.com with ESMTPSA id u21sm3623964ejm.89.2021.06.17.06.25.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 17 Jun 2021 06:25:37 -0700 (PDT)
Subject: Re: [PATCH v2 mptcp-net] mptcp: fix 32 bit DSN expansion
To: Paolo Abeni <pabeni@redhat.com>,
 Mat Martineau <mathew.j.martineau@linux.intel.com>
References: <b451ef55b7debb519f42202e75696a79954b32b6.1623831569.git.pabeni@redhat.com>
Cc: mptcp@lists.linux.dev
From: Matthieu Baerts <matthieu.baerts@tessares.net>
Message-ID: <db5de42c-37d4-2d16-c4b2-bc0476773a1a@tessares.net>
Date: Thu, 17 Jun 2021 15:25:36 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <b451ef55b7debb519f42202e75696a79954b32b6.1623831569.git.pabeni@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit

Hi Paolo, Mat,

On 16/06/2021 10:19, Paolo Abeni wrote:
> The current implementation of 32 bit DSN expansion is buggy.
> After the previous patch, we can simply reuse the newly
> introduced helper to do the expansion safely.
> 
> Closes: https://github.com/multipath-tcp/mptcp_net-next/issues/120
> Fixes: 648ef4b88673 ("mptcp: Implement MPTCP receive path")
> Signed-off-by: Paolo Abeni <pabeni@redhat.com>

Thank you for the patch and the review!

Now in our tree (fix for net) with Mat's RvB tag:

- b976d9a38cfc: mptcp: fix 32 bit DSN expansion
- Results: 035a752fa93d..8db480094258

Builds and tests are now in progress:

https://cirrus-ci.com/github/multipath-tcp/mptcp_net-next/export/20210617T132456
https://github.com/multipath-tcp/mptcp_net-next/actions/workflows/build-validation.yml?query=branch:export/20210617T132456

Cheers,
Matt
-- 
Tessares | Belgium | Hybrid Access Solutions
www.tessares.net
