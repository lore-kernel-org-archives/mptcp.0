Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5D0E3FC6
	for <mptcp@lists.linux.dev>; Mon, 23 Aug 2021 07:16:57 +0000 (UTC)
Received: by mail-ej1-f46.google.com with SMTP id x11so35018648ejv.0
        for <mptcp@lists.linux.dev>; Mon, 23 Aug 2021 00:16:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares-net.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=X4D5UV+a/csb9kGYkXXBY1D2Zv98LBRTHCzfrPU9/tQ=;
        b=ifJu3bDFWvgmlhqpUAb7+OwosGRe/svgx7+T78KEFGYk6lnVmpuvSJY4NC1XYXFIfY
         w8/RpRsVUZJD25Y5u5EqTxrKJp5EbSnielc+3BehBsWwdxrFSyb1l3hMCtYyfWN3X0KL
         jpGktPRG8V/ihcx/NwLGAczg+h0ts9i4nbLvVNApls8IqqKEdusVqmEU4pkaeOZJUjvX
         ljqKqLPjuzADQIv/sT3yLh7NOmFcoPG8D2h8Ny5PaAL9KxxR4Zkvh0rTTq6kgf+pmkMz
         hxtqnFeioy+Bta8YAXYgocUZKIwZCYXHv9bzkRSVCsErR5TshobO5MHzNvuo/GoQMDu1
         /haA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=X4D5UV+a/csb9kGYkXXBY1D2Zv98LBRTHCzfrPU9/tQ=;
        b=VfyQxuuGNTE/g4Xbii2VLRBD5xo9Kx7GIVmCuTq0k3i3I1PDOPC+PDdiPYmA7KueXx
         p0Ce7QsF1LNhNmlm6csNZiDzrz8Bo+AJru27voxCYKSE7ypQIFdZTnhbYvF8GdsL938a
         jJ7lHfITdFn1PjaMAOVL8Wf/hha2IsZ5VQ04AtR4QwE+LkRPFU/TpVwEz4lnhMwODfns
         Tt1p4l0/Gz8O/w4hoO6pfy/KEHUJahsk3pTGMqAWjDdmbUoaIjNv4fpapcErW0CoMg/y
         xCnZZoQ1mTxkSth07TbXjqC3tyQ4RXLNyNZF74gL3S4SDb9QRRDTNldrgE0oj8aGyRxS
         FQiw==
X-Gm-Message-State: AOAM530tyqglfcD/lk5T3qpq4UuBYMQFiX9y70RJLfGxysJdP3NAjAPn
	UkKXGbEamlPC86guNiYYmtHVQ0wqxl9VoQ==
X-Google-Smtp-Source: ABdhPJydFLsE7xSF1jQj2FzEhR3si4rSuaUICpLfSkJenhCQT1uhggOKAie3STQtuxRhyTD5HqQNQg==
X-Received: by 2002:a17:906:d057:: with SMTP id bo23mr34171253ejb.208.1629703015636;
        Mon, 23 Aug 2021 00:16:55 -0700 (PDT)
Received: from tsr-lap-08.nix.tessares.net (94.105.103.227.dyn.edpnet.net. [94.105.103.227])
        by smtp.gmail.com with ESMTPSA id i6sm6786832ejd.57.2021.08.23.00.16.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 23 Aug 2021 00:16:55 -0700 (PDT)
Subject: Re: [PATCH mptcp 0/2] mptcp: a couple of fix - almost
To: Mat Martineau <mathew.j.martineau@linux.intel.com>,
 Paolo Abeni <pabeni@redhat.com>
Cc: mptcp@lists.linux.dev
References: <cover.1629481305.git.pabeni@redhat.com>
 <dcc47221-50b4-6c46-320-7231ba4a211f@linux.intel.com>
From: Matthieu Baerts <matthieu.baerts@tessares.net>
Message-ID: <671a8ef8-34b9-7269-8cc1-01488e919e07@tessares.net>
Date: Mon, 23 Aug 2021 09:16:54 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <dcc47221-50b4-6c46-320-7231ba4a211f@linux.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit

Hi Paolo, Florian, Mat,

On 21/08/2021 01:02, Mat Martineau wrote:
> On Fri, 20 Aug 2021, Paolo Abeni wrote:
> 
>> This are couple of changes poped-up while investigating
>> issues/219. They does not address the mentioned issue,
>> but the first one should fix an actual bug, the other
>> is more a cleanup, so the target tree is undefined ;)
> 
> So far my syzkaller setup hasn't seen the div-by-0 again, but it was
> typically taking days to show up. I'll leave that running over the weekend.
> 
> Changes look good to me - mptcp_push_release() is now only called from
> places where info->mss_now is non-zero.
> 
> Patch 1 for -net, patch 2 for net-next seems appropriate.

Thank you for the patches, the suggestions and the reviews!

These two patches are now in our tree (net and net-next) with Mat's RvB tag:

- 5d8855f6a71f: mptcp: fix possible divide by zero
- Results: 84fc11b83a29..653135eedf64
- 33708631c1fd: mptcp: make the locking tx schema more readable
- Results: 653135eedf64..ebac4c6745a4

Builds and tests are now in progress:

https://cirrus-ci.com/github/multipath-tcp/mptcp_net-next/export/20210823T071618
https://github.com/multipath-tcp/mptcp_net-next/actions/workflows/build-validation.yml?query=branch:export/20210823T071618

Cheers,
Matt
-- 
Tessares | Belgium | Hybrid Access Solutions
www.tessares.net
