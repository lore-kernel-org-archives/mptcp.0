Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EAFC51C02
	for <mptcp@lists.linux.dev>; Tue, 18 Apr 2023 15:33:37 +0000 (UTC)
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-3f169350f05so23973145e9.3
        for <mptcp@lists.linux.dev>; Tue, 18 Apr 2023 08:33:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares.net; s=google; t=1681832016; x=1684424016;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=K0pvwJeaOU+nG/Kx35yQ54L5PWspmjHAJS1FeDYhV4E=;
        b=Xh3cx30dgVvcqAQ2/8zlGzvpHwO374KfeghCnCqDrnff8+mOiU0KGdvWL/h44oslZB
         mpsgA1K1tIxplnewH3OtpE4nUcUWk/hfPEDdJ0K2RQsd9df0YgzqYMzNoaDdkDz7U2Fq
         fpcMlKZzDTrXx0FnIbo2kbleXREZ3sOkogax2Jb2GTP+o6cdEDtjgwlxDT61fcFh50KB
         23Qp1LNrtARFYSTp4+dSuObfaC2FuhLxsICEAuu6L6CNjkw+xlKkKHuaGxE4JV2LFyo8
         cCEc9cCBk3ucyjXSM+ErCv2+jfYA3KdL/c5iqEoaSMPgkolCf1hO/iScOjjmGAVNU7P3
         tt3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681832016; x=1684424016;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=K0pvwJeaOU+nG/Kx35yQ54L5PWspmjHAJS1FeDYhV4E=;
        b=AWbWbMYzsxa/UpUuzue2eaQIIy0wm/MgnRqCA42+E2/5723QWeR0loKBKtMD38SiPV
         lkB75i2024yORf9hJ+ktuTWc7FH939nH7wSLvY5cIr6F3adU1/OQbIxHS45KvqjEKIfR
         H7sD6y5pVa9D0ploTW3+fgwJZ2D27a6sf0GkfCtKbzFPq1K51iOzRTv+jTQHZNtr1Vu4
         OnYJoErUqUwaqRrbukkVkvophKjPnqFuLqhA3m5JHhxy+EahLlrFa/jSeQq5XQs4Uetl
         qkYJ5PWcUmLymuo6/3Z4ZZkAGWBa/fprtROmEZsmjtTUjm5/UqbST7qoa6Hlk1ElkH0b
         LCMg==
X-Gm-Message-State: AAQBX9f/6T0XE4T+kL82sabSyM2F/hKzTohLErHxV3W3d0DQimHuxFSb
	zJlE2NO35E1M8ipts+PeppHe31nd7bbTqvzvW80Ucw==
X-Google-Smtp-Source: AKy350Y4Q0HS7CwKE2ltrjv5zSGtHxpEOwrA7NGrK7HVlxaU5f6+wcXhmqIF+/a/O8Wq+OsjR7+mgg==
X-Received: by 2002:adf:cd0d:0:b0:2ef:bada:2f04 with SMTP id w13-20020adfcd0d000000b002efbada2f04mr1937316wrm.59.1681832016133;
        Tue, 18 Apr 2023 08:33:36 -0700 (PDT)
Received: from ?IPV6:2a02:578:8593:1200:1b76:be36:72bc:27e0? ([2a02:578:8593:1200:1b76:be36:72bc:27e0])
        by smtp.gmail.com with ESMTPSA id g17-20020adff3d1000000b002f777345d21sm10622806wrp.95.2023.04.18.08.33.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 18 Apr 2023 08:33:35 -0700 (PDT)
Message-ID: <15263171-d324-a4be-4d7c-3a73991fae02@tessares.net>
Date: Tue, 18 Apr 2023 17:33:35 +0200
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH mptcp-next v7 5/7] mptcp: increase userspace pm
 add_addr_signaled
Content-Language: en-GB
To: Geliang Tang <geliang.tang@suse.com>, mptcp@lists.linux.dev
References: <cover.1681463340.git.geliang.tang@suse.com>
 <55b8848e621adcf43ef2c4a96d6d600ff44cac6a.1681463340.git.geliang.tang@suse.com>
From: Matthieu Baerts <matthieu.baerts@tessares.net>
In-Reply-To: <55b8848e621adcf43ef2c4a96d6d600ff44cac6a.1681463340.git.geliang.tang@suse.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Geliang,

On 14/04/2023 11:11, Geliang Tang wrote:
> Increase add_addr_signaled counter in mptcp_nl_cmd_announce() when the
> address is announced by userspace PM.

Do you mind adding:

  Fixes: 9ab4807c84a4 ("mptcp: netlink: Add MPTCP_PM_CMD_ANNOUNCE")
  Link: https://github.com/multipath-tcp/mptcp_net-next/issues/329

It looks like a bug: we forgot to update existing counters in this new mode.

Cheers,
Matt
-- 
Tessares | Belgium | Hybrid Access Solutions
www.tessares.net
