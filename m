Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com [209.85.208.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5AF993FD5
	for <mptcp@lists.linux.dev>; Fri,  3 Sep 2021 12:37:02 +0000 (UTC)
Received: by mail-ed1-f42.google.com with SMTP id l6so7785316edb.7
        for <mptcp@lists.linux.dev>; Fri, 03 Sep 2021 05:37:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares-net.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=qwD99SHRYFVcR5wFYVVxRnkZQxv5wrLjqQpQeZFB3Gw=;
        b=w1O5c7tuzzmF0iEaJ/fDS7aPhN4BqnAiU9j7N2pvMe3ahwvPlE2G0PwfxoAW3VpOB1
         NLKT8TcADBgTIS2Uzhe8sCkqaa1pI/vurAX/2xfvXt7mdzMiufHdorq6+7KDO+Ph/oK+
         jxEw0kKiD/sWx9MIbw8GAaH0S083BIbtSBXaYG60XeLwEfG68vbJofz49/VuWCCGZ9b6
         i1GF1pE2oe5ABvoVHdW6o6UQofvJie7yxvmWeYqPhFurAUcT/veWLvIo7T01+oSGMEFp
         HDa5WbGdMcn1Kv6dP02PvAlW+Ew/hymDYsXr4Ygizs4cJCbxRwE6zYo2Ay7FRBBTOmO0
         EMtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=qwD99SHRYFVcR5wFYVVxRnkZQxv5wrLjqQpQeZFB3Gw=;
        b=brDX7x5WFIfsSvB5fMXogXy0MZZRxDGDkJGAdVrXmgYiqg6xMerZFWDF8jcBR5Ij3Q
         Mp4svx+No7eQAYS4ku/PFiQhSoDKf3pGiycy4Yr17dxiHRxC0CbRXtmOf+wZBbByNiBJ
         kFU1lJQto+yco28QKqVSb6P1KlNLXFBC6lwuQTuftnBpoEOWafeYLTMCpGT+yOfZCNkm
         iYWlvoaVzlFyOH1jSlV07hyc9FL0siYLzVSeUaBzgUAQdAlsdwLekOfuncSOvxBcz4sg
         nX+l4SHrFxTsilftIWNrZSzOwtkh2JChU7Z+G5hMDQc7p4aMP2e4jXV3/NgDa/KwU3/e
         YQmg==
X-Gm-Message-State: AOAM531MyQb9gRidd57SOUdKS3UZM+yV+GqvIWGXsQyk0YKOqtPJj5Cd
	PKkBwE3tOmQtB8rKrAeXLtLtw6hyfjQ99w==
X-Google-Smtp-Source: ABdhPJwwu9iIvGTk7vyWv7+a5g1uqMnt91uWddPv/LeopddvGa6sXjvbFs/GGsvjQVT8p1Z6OvvUBQ==
X-Received: by 2002:a05:6402:10cc:: with SMTP id p12mr3790033edu.328.1630672620355;
        Fri, 03 Sep 2021 05:37:00 -0700 (PDT)
Received: from tsr-lap-08.nix.tessares.net (94.105.103.227.dyn.edpnet.net. [94.105.103.227])
        by smtp.gmail.com with ESMTPSA id e22sm3056492edu.35.2021.09.03.05.36.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 03 Sep 2021 05:37:00 -0700 (PDT)
Subject: Re: [MPTCP][PATCH v2 mptcp-next] mptcp: use OPTIONS_MPTCP_MPC
To: Geliang Tang <geliangtang@gmail.com>, Paolo Abeni <pabeni@redhat.com>,
 Mat Martineau <mathew.j.martineau@linux.intel.com>
Cc: Geliang Tang <geliangtang@xiaomi.com>, mptcp@lists.linux.dev
References: <10d25ba91ac41cacf02608b9e9a6e884d1eae996.1630573884.git.geliangtang@xiaomi.com>
From: Matthieu Baerts <matthieu.baerts@tessares.net>
Message-ID: <28674be9-a0ea-b3fa-90e1-e61251708b95@tessares.net>
Date: Fri, 3 Sep 2021 14:36:59 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <10d25ba91ac41cacf02608b9e9a6e884d1eae996.1630573884.git.geliangtang@xiaomi.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit

Hi Geliang, Paolo, Mat,

On 02/09/2021 11:15, Geliang Tang wrote:
> From: Geliang Tang <geliangtang@xiaomi.com>
> 
> Since OPTIONS_MPTCP_MPC has been defined, use it instead of open-coding.

Thank you for this patch and the review!

Now in our tree, feature for net-next:

- ee243e703f11: mptcp: use OPTIONS_MPTCP_MPC
- Results: e1015c28d860..396fa2905e69

Builds and tests are now in progress:

https://cirrus-ci.com/github/multipath-tcp/mptcp_net-next/export/20210903T123558
https://github.com/multipath-tcp/mptcp_net-next/actions/workflows/build-validation.yml?query=branch:export/20210903T123558

Cheers,
Matt
-- 
Tessares | Belgium | Hybrid Access Solutions
www.tessares.net
