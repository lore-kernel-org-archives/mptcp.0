Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CA3A3FC1
	for <mptcp@lists.linux.dev>; Fri, 20 Aug 2021 07:46:10 +0000 (UTC)
Received: by mail-ed1-f54.google.com with SMTP id bo19so12659328edb.9
        for <mptcp@lists.linux.dev>; Fri, 20 Aug 2021 00:46:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares-net.20150623.gappssmtp.com; s=20150623;
        h=to:references:from:cc:subject:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=byrK0875O5KWEWfhiu7u22mpEfclC2GBvIu5BChmsTU=;
        b=L5/tN6QxDu859KMtqr/65l4aRd0ymAgvEfzPlDQLdc7bDERe4eeuTW/Zpak1LwqoTR
         EKvzIBPK6C/9TeZnjO2g+rHe4FkSEG4U09VXEwBqypd8Q+dqINywTQxneYnIOeVwBlNX
         WnJNnluS5EjQSwzAYZMRr/hfPBUZ/cUtQVJLUe2Qrd2yYTBvU4weg2sK6piOLfD1i6gL
         lIPyPrPFFmiiEKC94pheZc3PXM5wjfE9u5SEf+m9ZRXqlJ1benKf1VryhouvN5/MxKyu
         SZUxqzyes2cAgYcDA6yg1IG8zqwnsG+fnSZ0bIKq7/o+9VZkiVmZrspc1K9O/5HPY5SK
         KwJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:references:from:cc:subject:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=byrK0875O5KWEWfhiu7u22mpEfclC2GBvIu5BChmsTU=;
        b=NFwJnZ3JFDVeMlMQxabIdjVAroVGreULDW5YCG47wF1NtCBJ7xPZfIqOXSwFV4sdjT
         9+/1nWBZqKxnP+4AxVwTsp2Hspkr970riPzoNbOn/m0WEQZn4pk4lRKZhq4HUc9QLl4u
         zl8Gl6fsBu8cC9h/KUj8UJN+Iyri9r/axxzkFqSMnY7Xhlp+giqrdHDJ3bXspR6vpFy2
         mVoVofHsQd4jnN8e/gjsHQOby+ZRAySK6qTrxIOPE7tkFq5zf58dZfp9wxBfY3MFDvJW
         rRKWd5Mt5btvl2vJr08eDWzbOHnfXjnvPmyEHYHNs+9Ww0M7Eznb3nAP+ANK1qOrb6fJ
         vfkg==
X-Gm-Message-State: AOAM532Vy00XyHBAkpuQik1Yh1G2mzfqx1fFgm0IFRLPXL1PM95O3x7q
	L11S9W4xZHgNyPyCYWrzL3Ri2letPOtpbV/t
X-Google-Smtp-Source: ABdhPJz04AedH5W5CU+xgS8QQl+RqB4u0hgQfeDiEdMbhsGm4VgNNji1MtzmLPuPz/u9ch29rSpe5Q==
X-Received: by 2002:a05:6402:1648:: with SMTP id s8mr20409326edx.214.1629445568543;
        Fri, 20 Aug 2021 00:46:08 -0700 (PDT)
Received: from tsr-lap-08.nix.tessares.net ([213.211.142.31])
        by smtp.gmail.com with ESMTPSA id m25sm3076027edv.81.2021.08.20.00.46.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 20 Aug 2021 00:46:08 -0700 (PDT)
To: Florian Westphal <fw@strlen.de>,
 Mat Martineau <mathew.j.martineau@linux.intel.com>
References: <20210819130040.30228-1-fw@strlen.de>
From: Matthieu Baerts <matthieu.baerts@tessares.net>
Cc: mptcp@lists.linux.dev
Subject: Re: [PATCH mptcp] selftest: wait before trasnmitting first data chunk
Message-ID: <0537591c-8b1e-2aeb-5779-c822e58d4670@tessares.net>
Date: Fri, 20 Aug 2021 09:46:07 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <20210819130040.30228-1-fw@strlen.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 8bit

Hi Florian, Mat,

On 19/08/2021 15:00, Florian Westphal wrote:
> Squashto: selftests: mptcp: add mptcp getsockopt test cases

Thank you for the patch and the review!

Just added to our tree:

- d9eb2588bb5f: "squashed" in "selftests: mptcp: add mptcp getsockopt
test cases"
- Results: de6060ba55ea..720da4811476

Builds and tests are now in progress:

https://cirrus-ci.com/github/multipath-tcp/mptcp_net-next/export/20210820T074517
https://github.com/multipath-tcp/mptcp_net-next/actions/workflows/build-validation.yml?query=branch:export/20210820T074517

Cheers,
Matt
-- 
Tessares | Belgium | Hybrid Access Solutions
www.tessares.net
