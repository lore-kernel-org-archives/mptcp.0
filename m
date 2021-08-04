Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com [209.85.208.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90AFF70
	for <mptcp@lists.linux.dev>; Wed,  4 Aug 2021 13:06:54 +0000 (UTC)
Received: by mail-ed1-f46.google.com with SMTP id y7so3417372eda.5
        for <mptcp@lists.linux.dev>; Wed, 04 Aug 2021 06:06:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares-net.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=u9rSKMclJUJztra+LqLqM0wxhmBRqOtb+nkLxts4INY=;
        b=XvI8FqRNMH1eUQFB0oR0EGXo1A1cUlGrlJg/KOLLlqFYl6gqQFgNJIGveWK9LImCxo
         9wMXMo9qlR2D8JfqF04ZWNPdZMQgl3gHnKSM0HUEyF0GZl1U1me7l1izoxWw1l6uTpTQ
         P5vky4erqstuNRGVxWWLU+2sTY7HS9Ej9w/l9tP8XdHHpec8+Gue67NP8ZrxQMzKUOgj
         Nh1OToPvQNwc4hYb3yMx+xm9wCunr8O2Y3KhTgLC6z4Kbw/pr+4+mParo64HMeAjc+K5
         MXR5K9ajjLB+kB2/76KzgDU1VyFjYcA7qOOVerYuz1s9erTFGE3fZ+C/E46t+0V16dKl
         8nJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=u9rSKMclJUJztra+LqLqM0wxhmBRqOtb+nkLxts4INY=;
        b=J8nKgzCxkSaBvpgrd4IiGhz16A0SH3p1tzWaA4gLUCBIiz1hlatlG4ROFPLe6ku/je
         gnt5RLOy+OiQ7bl4+uPLFGHcVdWuA+VnysFbqIhcKBqMlWdzSZA2RgnfRzng3Iw04b9X
         LxFj6Xvov6yJhvv5aZIVO9338y4eC31E++SgNzOkCF8byY68uhhN2USvf3n6YUZRywJ9
         3JT0jXMKshyfeIcglAb4KHiEJi1ynpM7JSqBFi6Rdecn21LUBnC998XPqjbkPNwZnzp6
         6KUQSYyjuI5MuiTWIf8f4Rh608UAXeM454Hv2DD08mcw8lqj35G+gUgJzEx0QIya+U+P
         YsOw==
X-Gm-Message-State: AOAM530MxvX5mxXU5lgRCmjE4CVMwK+byAHlSFScTGhuBibL4j7O9R3C
	NjzOeoS/tKaN1PiDDKJtd7c0rw==
X-Google-Smtp-Source: ABdhPJwEj2Ng9yPnYXkSjksSQ46ZfWM3IHppS5llx8/l0JVwAlOou0eA9Zv3tkRsnuCRwvbVFYithw==
X-Received: by 2002:a05:6402:440e:: with SMTP id y14mr9290305eda.38.1628082412580;
        Wed, 04 Aug 2021 06:06:52 -0700 (PDT)
Received: from tsr-lap-08.nix.tessares.net (94.105.102.61.dyn.edpnet.net. [94.105.102.61])
        by smtp.gmail.com with ESMTPSA id n13sm665518ejk.97.2021.08.04.06.06.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 04 Aug 2021 06:06:52 -0700 (PDT)
Subject: Re: [PATCH mptcp-next] Squash to "mptcp: remote addresses fullmesh"
To: Geliang Tang <geliangtang@gmail.com>
Cc: mptcp@lists.linux.dev, Jenkins Tessares <kernel-dev@tessares.net>,
 kernel test robot <lkp@intel.com>
References: <20210804073710.681267-1-matthieu.baerts@tessares.net>
 <CA+WQbwvhXX+T+tm2G9Jyi67Pd4sXDfhUn3dgKL_5eQ014tD8gw@mail.gmail.com>
From: Matthieu Baerts <matthieu.baerts@tessares.net>
Message-ID: <efdd733f-e258-d44f-2355-48235f771caa@tessares.net>
Date: Wed, 4 Aug 2021 15:06:50 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <CA+WQbwvhXX+T+tm2G9Jyi67Pd4sXDfhUn3dgKL_5eQ014tD8gw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit

Hi Geliang,

On 04/08/2021 13:31, Geliang Tang wrote:
> Hi Matt,
> 
> Thanks for fixing this.
> 
> Acked-by: Geliang Tang <geliangtang@xiaomi.com>

Thank you for the review!

Now in our tree:

- 40ca9c61f1b1: "squashed" in "mptcp: remote addresses fullmesh"
- (no co-dev for that, it was reported by CIs)
- Results: d2d5ed438884..90dec655986b

Cheers,
Matt
-- 
Tessares | Belgium | Hybrid Access Solutions
www.tessares.net
