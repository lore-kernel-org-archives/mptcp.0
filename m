Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com [209.85.208.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F55C2C80
	for <mptcp@lists.linux.dev>; Thu, 21 Oct 2021 10:05:46 +0000 (UTC)
Received: by mail-ed1-f42.google.com with SMTP id t16so1468907eds.9
        for <mptcp@lists.linux.dev>; Thu, 21 Oct 2021 03:05:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares-net.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :references:cc:from:in-reply-to:content-transfer-encoding;
        bh=vnY5KYgGBLKmJrjY2sUjlX5DXBN8MtO0qTpuCtsltxc=;
        b=jGkDNb/6QpSSZ4t6WeIUa6ar5CXJzkiALnelRYb3+dSIBsiznnWk+P6ueFycM23i7M
         +ghQhHN2FdR7Nmv4vX9Mv1lae1OpFwsplkLtUFBpDOR9Smuye5LWkoyGENuKcRZZRXr6
         QGOLNRjFiDn9prJZ3CDINEbbDDKC95FInINc150TZPn6BfUrAfPY89eqF1AyFuYRGtwM
         r4s6HSTZiYrEfyyYUsK0O8MxmQNI8m8NC0qvMgP97CQJYpinCAxBP9mJnYn+sFmTwaCc
         ofQKUUQUj0Xxao/lTEW+t/m9zWyVNd5IAtLjLMMLP2yEIQQZW8Xz41bKOpOgUKadpwfg
         Dqug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:references:cc:from:in-reply-to
         :content-transfer-encoding;
        bh=vnY5KYgGBLKmJrjY2sUjlX5DXBN8MtO0qTpuCtsltxc=;
        b=6+Vdk/CIrEeyVlHjRZWcVHF56cUEwd9HkOSI5888U2YBqKY4LCeHMiStGWKh9/8XLu
         ieBRkZHWKrsMx6jpbyxLMfRLtH5MNCzDqGggg0ybShBMUdL57Cyc6opqSXnzqMSTfkuK
         7agIIyplpk/1o2T27hhXql5BzqejZ27KzWLeqo/IQMuIkdaLkaC6a8J5H/AHXvnvVuzy
         4eAMxEsDo96BpDMjHXqir2XITl3SAUiei4EKHi7Dpjd7ZAlFCQpRbCoZ3wEtfuxHRmJO
         IfvDi5CTD3sPI11Rm4TNqdOccDpNhM+UL1RYED+Va21YnBPpIBA6sDR89YMvLdJbZ6jN
         jBog==
X-Gm-Message-State: AOAM531rt+KXpNSnpd0qoVUi83f8btL0rGEmGVi4DWYSEdkqHlNzs+39
	zDACoabro9GwtpS6kwOaY5dizykujyP7n8Ae4/I=
X-Google-Smtp-Source: ABdhPJy6eGNeoP29UujTAudKJiyasJ3vCgVBSj+nu5bANb85icoe9hCdZNqHs4qY60RmAAg4R5rC3A==
X-Received: by 2002:a17:907:7ba8:: with SMTP id ne40mr5779277ejc.335.1634810744320;
        Thu, 21 Oct 2021 03:05:44 -0700 (PDT)
Received: from [10.44.1.26] ([81.246.10.41])
        by smtp.gmail.com with ESMTPSA id t18sm2755565edd.18.2021.10.21.03.05.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 21 Oct 2021 03:05:43 -0700 (PDT)
Message-ID: <91fbd377-db58-b95f-f086-8874130a1812@tessares.net>
Date: Thu, 21 Oct 2021 12:05:43 +0200
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.1.2
Subject: Re: [RFC PATCH v2] selftests: mptcp: more stable simult_flows tests
Content-Language: en-GB
To: Paolo Abeni <pabeni@redhat.com>
References: <9d66028a72b6807d4dc3397bb70f028cbc78161d.1634310418.git.pabeni@redhat.com>
Cc: mptcp@lists.linux.dev
From: Matthieu Baerts <matthieu.baerts@tessares.net>
In-Reply-To: <9d66028a72b6807d4dc3397bb70f028cbc78161d.1634310418.git.pabeni@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Paolo,

On 15/10/2021 17:09, Paolo Abeni wrote:
> Currently the simult_flows.sh self-tests are not very
> stables, expecially when running on slow VM.
> 
> The tests mesures runtime for transfers on multiple subflows
> and check that the time is nearby the theoretical maximum.
> 
> The current test infra introduces a bit of jitter in test
> runtime, due to multiple explicit delays. Additionally the
> runtime is measured by the shell script wrapper. On slow
> VM, the script overhead is measurable and subject to relevant
> jitter.
> 
> One solution to make the test more stable would be adding more
> slack to the expected time; that could possibly hide reall
> regressions. Instead move the measurement inside the command
> doint the transfer, and drop most unneeded sleep.

Thank you for the patch!

Now in our tree (without some typos detected by codespell) and my RvB tag:

- e0c1e93cee3c: selftests: mptcp: more stable simult_flows tests
- Results: 3b796086040b..27b3739429a3

Builds and tests are now in progress:

https://cirrus-ci.com/github/multipath-tcp/mptcp_net-next/export/20211021T100529
https://github.com/multipath-tcp/mptcp_net-next/actions/workflows/build-validation.yml?query=branch:export/20211021T100529

Cheers,
Matt
-- 
Tessares | Belgium | Hybrid Access Solutions
www.tessares.net
