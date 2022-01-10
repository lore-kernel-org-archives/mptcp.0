Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com [209.85.208.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57F4E168
	for <mptcp@lists.linux.dev>; Mon, 10 Jan 2022 19:39:17 +0000 (UTC)
Received: by mail-ed1-f42.google.com with SMTP id u25so57982135edf.1
        for <mptcp@lists.linux.dev>; Mon, 10 Jan 2022 11:39:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares-net.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=di3d3ljeB+QrovZYuUJhz2v3ZWFs4Fc+b7Xpay6Vwhg=;
        b=l9UVdIoOEo1RKWaqfo80kXoioCxXIuEFoBdLL1tvcC9oV9VF8sx6fB1LFWrDAkHOJY
         5PKfHUIcgmVq/Et/kYbm+IiigByAKHc4wVoG1tJQfZPX8oyIFQ7JewkY8w45nXbkZwNC
         KJ8FiJsngj5c7m6B5swrVto9xaYFeacDtLX6Lv2m4hlbKJTND8pmQpKpaRKYHl3oYbgi
         h63bBjizsNkVXkkVmrJehGiB00KtD7SBQUr5QoAyaLKf0UoDr0Cyl7LxeIh3Lh5cGshN
         qBMYeEZ2ZfQQrnD9hpbZSfQ5uiA3j7oBr8PlLMyOzKIznugxM0JPw3M8hwoHmSAMqRBp
         RvsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=di3d3ljeB+QrovZYuUJhz2v3ZWFs4Fc+b7Xpay6Vwhg=;
        b=St/MAyHPlzW4iHBClUZ/K3bDSDBZuAKcx+JQ44IhrM7NCsA8zGNQbEV3+VLFE43qd5
         2Hya8pQ8gHoKpAQLfebz8FOD1pAgcQtfA5/AolmgjSrbpl2kMha8GsTtuOJ6UJG1jmcC
         Pnqyg7cnP9sAa99Lw4fHATsvL1qY6+IoZG3lvajtMY2T1HieRD74baaLIuGgDecTX2yR
         UAUG8Stds9J9gXBN92qBy+YFIIAmfi9ABk+ialCzexidttlW2IbPt3Q3/akENjsRjOWb
         hlHyUOgHGiuoUCU8GC7t2gCdmEm2iP60H/dX6OLnNgIF9ZaDFIpu0sR4F8fqMo7NbDhe
         bfYQ==
X-Gm-Message-State: AOAM532/JqtPVM7kIhNXOrlu61SDE5Z0bAMlmvgic3yJpMSa4lTP0/Vx
	zIljSvh3cnWq/uq8a5VbBp7UNQ==
X-Google-Smtp-Source: ABdhPJz4kZkNLkKhc9JI9e5t12SScAKZ2DgxhHQVtmPqEsu04mASyiEGAYGZSWRGySSYFfhVSxQgZg==
X-Received: by 2002:a17:907:3e0b:: with SMTP id hp11mr942389ejc.584.1641843556354;
        Mon, 10 Jan 2022 11:39:16 -0800 (PST)
Received: from ?IPV6:2a02:578:8593:1200:e398:f37c:e11f:a1a0? ([2a02:578:8593:1200:e398:f37c:e11f:a1a0])
        by smtp.gmail.com with ESMTPSA id t10sm4026108edt.83.2022.01.10.11.39.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 10 Jan 2022 11:39:15 -0800 (PST)
Message-ID: <b8d1d1cb-063d-c933-9529-33aaebd38068@tessares.net>
Date: Mon, 10 Jan 2022 20:39:15 +0100
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.0
Subject: Re: Export branch squash
Content-Language: en-GB
To: Mat Martineau <mathew.j.martineau@linux.intel.com>
Cc: Geliang Tang <geliang.tang@suse.com>, mptcp@lists.linux.dev
References: <af3c2f86-51cd-f0b7-66f3-19c9238ec188@linux.intel.com>
From: Matthieu Baerts <matthieu.baerts@tessares.net>
In-Reply-To: <af3c2f86-51cd-f0b7-66f3-19c9238ec188@linux.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Mat,

On 10/01/2022 19:26, Mat Martineau wrote:
> 
> Hi Matthieu -
> 
> With the latest export branch rebase (export/20220110T054834), there are
> two "selftests: mptcp: more stable join tests-cases" commits: one is the
> version merged to net-next, the other is a leftover bit only in the
> export branch due to patch reordering.
> 
> The one that isn't in net-next (74397e5f40b3) can be squashed with
> "selftests: mptcp: add infinite map mibs check" (cb7e9100a8b8)

Good catch, thank you for your message!

I just squashed the left-over in the right commit:

- 616d316f6807: selftests: mptcp: more stable join tests-cases
- t/selftests-mptcp-more-stable-join-tests-cases is now empty
- Results: 0b8548cb13d2..7af80875c0af

Builds and tests are now in progress:

https://cirrus-ci.com/github/multipath-tcp/mptcp_net-next/export/20220110T193856
https://github.com/multipath-tcp/mptcp_net-next/actions/workflows/build-validation.yml?query=branch:export

Cheers,
Matt
-- 
Tessares | Belgium | Hybrid Access Solutions
www.tessares.net
