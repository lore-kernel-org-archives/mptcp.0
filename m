Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1D8063D9
	for <mptcp@lists.linux.dev>; Thu,  4 May 2023 14:57:36 +0000 (UTC)
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-3f193ca059bso4605675e9.3
        for <mptcp@lists.linux.dev>; Thu, 04 May 2023 07:57:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares.net; s=google; t=1683212255; x=1685804255;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=RJDBGiLwEYzogjhdT0Gdg9AdNoO5GRDDx87dHT/2K10=;
        b=KhenM/GnMk4WFRT9jxmJgR/io44W7MznsfbU1odS41mQc+I0e0a6/y2jBL0ourJ/z5
         7jpDMkqrxIFL0Oe0XEeCjBPtpyKSUh5x0oOh7vQexaTj4JR/4tOP1/m1fIZhlvL14n/B
         m9sZTTf5ehfA3vX0WBIki9I6o4ak57xkYgJbry1ehsGBcP8drxsVKmoUl350jDLDlU3e
         x0UH+Ai/h9ILB4fcuoIdrWpwOIrq6QlfINZn4OeIIfVEhDz+83c78sZrQnk2v2VQpr7T
         KKueKyCbgrmLovRmXZ6vv811+N2KrjQJ2SP6Zvi4iToe0x0Lx/0CphfIelUMSGwe2LYl
         gIKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683212255; x=1685804255;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=RJDBGiLwEYzogjhdT0Gdg9AdNoO5GRDDx87dHT/2K10=;
        b=bAmnifU/PmaD5NzlqgQkfqTOYyNVgdP6Hw30DiwTyZd+NBWBCftaNk+XHMM2AFt/77
         VdDn7TZFxA04MwbDbbFAkz/HqHpYlyzPay90pylHDDA0s+3OGFrQBJXBJhYQ+6kF8bHX
         uDfqSFTkJY3tN+9dqRKdTm0oX1m+20Yh6Y7DKjr+4l6wN0ZRQLEKuuxR8jCeJSS5Lbz6
         QJFcQSwFF42M3yU3F3hk+3Z8kW+styhgd/2Rb4j4pbp/xRDB3iWWlmns7u2EJ1auuhTt
         iAXFibtFqmrH/6B+40riR8VAy7TeoyVxPRDNc8+bN7RtnP/LTTRF1q4mEwAOiobzfe6+
         GtNQ==
X-Gm-Message-State: AC+VfDz/F0IK04DwMQjPWKwD8WojmxMEN9HdkIKIU11BlacG6QBeek/v
	znOu8iy8nywOiJ5g7yCFFyuXtc7zl0f+z/qJ0E8=
X-Google-Smtp-Source: ACHHUZ7w5o4XjY+q8XwzP1WzFWSlz7NNNnYmpq2oeCtKn5nOObwc8bKr/TWhPv/vaJ097KKEtc8pbA==
X-Received: by 2002:a1c:4b06:0:b0:3f0:3d47:2cc5 with SMTP id y6-20020a1c4b06000000b003f03d472cc5mr17538469wma.10.1683212254837;
        Thu, 04 May 2023 07:57:34 -0700 (PDT)
Received: from ?IPV6:2a02:578:8593:1200:6b04:8b76:7dd3:7b25? ([2a02:578:8593:1200:6b04:8b76:7dd3:7b25])
        by smtp.gmail.com with ESMTPSA id n6-20020a7bcbc6000000b003f33f8f0a05sm5199566wmi.9.2023.05.04.07.57.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 04 May 2023 07:57:34 -0700 (PDT)
Message-ID: <67ca4d0b-f539-7269-e400-5d89ffabacea@tessares.net>
Date: Thu, 4 May 2023 16:57:33 +0200
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH mptcp-next v11 00/12] update userspace pm mptcp_info
 fields
Content-Language: en-GB
To: Geliang Tang <geliang.tang@suse.com>, mptcp@lists.linux.dev
References: <cover.1683195386.git.geliang.tang@suse.com>
From: Matthieu Baerts <matthieu.baerts@tessares.net>
In-Reply-To: <cover.1683195386.git.geliang.tang@suse.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Geliang,

On 04/05/2023 12:20, Geliang Tang wrote:
> v11:
>  - #1-#5 part 1, address Matt's comments in v10.
>  - #6-#9 part 2, update pm mptcp_info
>  - #10-#12 part 3, some cleanups.

Thank you for the v11!

I just did a review of the 6 first patches that would land in -net. I
just have some last questions regarding the 4th patch (good you did the
squash, it was easier for me to see some issues) and the 6th one.

For the modifications on the selftests side, I didn't look into details
yet but it looks like the CI is complaining about that (maybe with a
debug kconfig, it is way slower, we do need to use 'wait_xxx()'
functions instead of 'sleep'?). I suggest to look at that when the first
6 patches are merged because this second part is for net-next anyway. WDYT?

Just briefly regarding this 2nd part: it is a good idea to get code out
of "do_transfer". It might be good to create helpers to keep stuff clear
when we declare the tests, with brief instructions, e.g.

  set_userspace_pm $ns1
  run_tests (...)
  userspace_pm_send_add_addr (...)
  wait_for_addr (...)
  chk_add_nr (...)
  userspace_pm_send_rm_addr (...)
  wait_rm_addr (...)
  chk_rm_nr (...)
  kill_(...)

If you see the idea.

Also, I really should send all the modifications I have related to my
"selftests: mptcp: skip tests when features are not supported" as my
patches are for -net and they modify quite a bit mptcp_join.sh tests. I
will try to send them tomorrow.

Cheers,
Matt
-- 
Tessares | Belgium | Hybrid Access Solutions
www.tessares.net
