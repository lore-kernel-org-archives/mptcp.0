Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com [209.85.208.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFF452C81
	for <mptcp@lists.linux.dev>; Mon, 18 Oct 2021 08:35:52 +0000 (UTC)
Received: by mail-ed1-f45.google.com with SMTP id d9so67602195edh.5
        for <mptcp@lists.linux.dev>; Mon, 18 Oct 2021 01:35:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares-net.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :references:cc:from:in-reply-to:content-transfer-encoding;
        bh=SA9IKzV62gXxdfcBQhopWg/G1A1EipQGafyhRizufUM=;
        b=J04cNb7+mWVKrhcrlnfJ7NezIIkSW3nDxpQJkOMygiwxk9a1tT4IgUckjltozV/uaD
         njE9OxNmzNnW65N6YtECAXjhYJ4mg+8Bzusx9sSDd1/Ft/qH3JcXv5Y6Vx2EB33xaM7h
         P2zKl69t/Xs9AucBoTwoenDPAHAEypCb3WbrBmBRd7oYwFADWKxQ2/xDHgBuhWE1Nrh+
         zhA1JxS9/vMnCuMiJtU77IELzmUgg7W2RGXcZ0DAPKHE1bjHEh5kOeg5bt4fcWrQE2GP
         lJny/ehw/8M0T9Lcq2yiKPafsW0E51NSyciyCoUp4hSBIJj/b+HNZgKg6qkr1+QLfXdT
         DD5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:references:cc:from:in-reply-to
         :content-transfer-encoding;
        bh=SA9IKzV62gXxdfcBQhopWg/G1A1EipQGafyhRizufUM=;
        b=J+CFG9tqmRHEWiOwtsLTh4trlwlaLoBqejcDZVLmVydjtvm6H4uwH1X9fLU02KBbIO
         H2yx/a3dsMYdBEGdlsasEpayoFL1G8WPkHhh1dKjdWwo92Q7+H7xG1UMCGY51HZI5/J8
         auX4DMbsCulcibWYhhBzp8e6UQEjAzLB7MtUL8hRuFzsA9kG8R80HegHuhjam52QTBP2
         6dRBGa1xdPFDRnJL654pH2qjNK8YiVWt697d0V1HeY+eIg8vMinsGnE/AIf+1LUpvT78
         rOOPIs+sPa5XYqO2H30n4X/9GmxVq5P0OCtT2aUw4/BE/6W9Cs1ST2j0GvGAWC2asySh
         3jjg==
X-Gm-Message-State: AOAM530eC6SEIKkolfGFHp1zokNZ83PkO29+iqlmR6Xz76QUY43EQHwb
	WPlLsTpPUoZB/AHd4VVYX5oN3Q==
X-Google-Smtp-Source: ABdhPJwfG4vHEpRY5hsHQ8pp+VWU35/XDM73IKagB5NqVc5UrIT514ZozhyZ+zx1rLQZAoq4mFZVYg==
X-Received: by 2002:a17:906:254b:: with SMTP id j11mr27839016ejb.513.1634546150739;
        Mon, 18 Oct 2021 01:35:50 -0700 (PDT)
Received: from [192.168.178.46] ([213.211.156.121])
        by smtp.gmail.com with ESMTPSA id f19sm9400121edj.77.2021.10.18.01.35.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 18 Oct 2021 01:35:50 -0700 (PDT)
Message-ID: <a04f6e98-dc2c-ac2d-5243-3237f53e4cf2@tessares.net>
Date: Mon, 18 Oct 2021 10:35:49 +0200
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.1.2
Subject: Re: [PATCH mptcp-next v2 0/3] mptcp: refactor memory accounting
Content-Language: en-GB
To: Paolo Abeni <pabeni@redhat.com>,
 Mat Martineau <mathew.j.martineau@linux.intel.com>
References: <cover.1634312286.git.pabeni@redhat.com>
Cc: mptcp@lists.linux.dev
From: Matthieu Baerts <matthieu.baerts@tessares.net>
In-Reply-To: <cover.1634312286.git.pabeni@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Paolo, Mat,

On 15/10/2021 17:39, Paolo Abeni wrote:
> This iteration address a fwd alloc memory leak.
> Please see the patch 3/3 changelog for the details.

Thank you for looking at that!

Now in our tree with Mat's ACK/RvB tags and without a few checkpatch's
warnings (double 'control' word and ';', a few other typos, misspelled
words found by codespell and one trailing whitespace, nothing important :) )

- 58ab0f09bdde: tcp: define macros for a couple reclaim thresholds

- e3da5eca5edd: net: introduce sk_forward_alloc_get()

- 670b93a99932: mptcp: allocate fwd memory separately on the rx and tx path

- Results: b200d07c9568..88103c16472d

Builds and tests are now in progress:









https://cirrus-ci.com/github/multipath-tcp/mptcp_net-next/export/20211018T083523




https://github.com/multipath-tcp/mptcp_net-next/actions/workflows/build-validation.yml?query=branch:export/20211018T083523

Cheers,
Matt
-- 
Tessares | Belgium | Hybrid Access Solutions
www.tessares.net
