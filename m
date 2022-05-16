Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C38EE1361
	for <mptcp@lists.linux.dev>; Mon, 16 May 2022 16:25:16 +0000 (UTC)
Received: by mail-wr1-f49.google.com with SMTP id j25so20244727wrc.9
        for <mptcp@lists.linux.dev>; Mon, 16 May 2022 09:25:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares-net.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :references:from:in-reply-to:content-transfer-encoding;
        bh=H5Zyk6uWVKwjk9rjd3feZl5Fyk54B2MNDF5z0DVnhHA=;
        b=iQn8qhpBKbOZaO8J4eTC/eWyYc8txqtK+J+NvaQuXC0/vf3dDTsbfpVg0DTD8ZpNJ5
         jFOeJoyoaBowXWHMCqzBdZXULNkChA90jobRZwynVt5HE0s63JRzJBuwsS7j1+66ngnD
         iHePgrtifN4Yhw8qo+643hHVqPwbPrszkC0z0MtrgOlch26RJfKPPapAcUfx2KhJmp2I
         H/C9VB6y82NLBryhI8hY1pU2nEfFNk2IwT8QzO0EEHJ88lOYenW9TI5gFCB44nWzp9SQ
         wpCNbq8pRfZ6uNTSsu5rRwPeCnWhoCGCygq2Zx7KRkbke13SrY3sMazYLFLMwDrsCL9C
         wHhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:references:from:in-reply-to
         :content-transfer-encoding;
        bh=H5Zyk6uWVKwjk9rjd3feZl5Fyk54B2MNDF5z0DVnhHA=;
        b=3h2ulV5GxXPXirWb1bmx4baWfege6Cn2WDOvJhIMz4gYPwfg6coFhR7NTwUqXt9/Y0
         dtnGRl67nX4NltM6Ru9tXBln0Q/zk8dEUijQi35pYYmZ2BlnjYmzBvpsGY2ddUl5e1ve
         MfjQfSyAe9+xTt9LwHaH4PO5OTo0w8VGNeKCN5F9e+btkFT+b2/BekuNqn9TzeQLPOtz
         rsLwO5DNSFtdK5czZUnLomZNJbCs8haDIAfWFdddgC5vLpQAodgwqq4d82RqGhmWEwNe
         xkejURgBrTasrNrMhs3z3SjPPSVX0cK2xbZzG+1XdW3s/8Tsov3oh45T2c+bY5dhdADH
         lc/Q==
X-Gm-Message-State: AOAM5322gIubfHe8sJJapZDTQ0Cyai3I7xPmHMMNjN2Hb+PHYVLZhl66
	tR5QAN9+ABQTQPlZrd87KYME0w==
X-Google-Smtp-Source: ABdhPJyH68ahuy5IaENokExJdmcj8/TVE6m9WQyR0c+Iei7S+8DVfefKUa8dxAer1yIuBU/CHbjwQg==
X-Received: by 2002:a5d:6daa:0:b0:20c:6476:db2d with SMTP id u10-20020a5d6daa000000b0020c6476db2dmr14770809wrs.266.1652718315017;
        Mon, 16 May 2022 09:25:15 -0700 (PDT)
Received: from [10.44.2.26] ([81.246.10.41])
        by smtp.gmail.com with ESMTPSA id az31-20020a05600c601f00b003944821105esm10587551wmb.2.2022.05.16.09.25.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 16 May 2022 09:25:14 -0700 (PDT)
Message-ID: <3260999d-ef0e-e08d-6f79-dd0f6a5c4c9b@tessares.net>
Date: Mon, 16 May 2022 18:25:14 +0200
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.0
Subject: Re: [PATCH mptcp-next] Squash to "selftests/bpf: test
 bpf_skc_to_mptcp_sock"
Content-Language: en-GB
To: Geliang Tang <geliang.tang@suse.com>, mptcp@lists.linux.dev
References: <f625826dad272f44039bf6f8e35fe18196d5ee08.1652680232.git.geliang.tang@suse.com>
From: Matthieu Baerts <matthieu.baerts@tessares.net>
In-Reply-To: <f625826dad272f44039bf6f8e35fe18196d5ee08.1652680232.git.geliang.tang@suse.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Geliang,

On 16/05/2022 07:50, Geliang Tang wrote:
> Fix mptcp bpf tests failures on export/20220514T172044.

Oops, good catch!

Now in our tree!

- 6aaf2c9e55dd: "squashed" in "selftests/bpf: test bpf_skc_to_mptcp_sock"
- Results: cd3c57373965..c53189ad917e (export)

Builds and tests are now in progress:



https://cirrus-ci.com/github/multipath-tcp/mptcp_net-next/export/20220516T162419

https://github.com/multipath-tcp/mptcp_net-next/actions/workflows/build-validation.yml?query=branch:export

Cheers,
Matt
-- 
Tessares | Belgium | Hybrid Access Solutions
www.tessares.net
