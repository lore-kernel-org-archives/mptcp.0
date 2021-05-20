Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com [209.85.208.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8082170
	for <mptcp@lists.linux.dev>; Thu, 20 May 2021 18:32:22 +0000 (UTC)
Received: by mail-ed1-f43.google.com with SMTP id b17so20576780ede.0
        for <mptcp@lists.linux.dev>; Thu, 20 May 2021 11:32:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares-net.20150623.gappssmtp.com; s=20150623;
        h=subject:to:references:cc:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=7DzbllBMNqedjXJm4so5ZoWJjhW2vbPQhZTRJ7K6mdo=;
        b=kIOIwkz6QMgu7EX64eqQZ13S6WXkbCEHpEFQAPNcEN7Yo+U7NDje2ZB+8Y1hWJSQ5p
         UM68aN7LIbwhvP7KJDKeZuT9KouKPwL8Wl1Pj5avKIhfBeYJTA13wKRpbf7cS2bh3jdB
         bykrOxKZuhfy4bO6fyBBJ8M4TxyRytYuIdB/AU7wlQTNCjulnmuVcJjeX5RAj9wSd/fX
         kcE3BfeL2mDZHa0qKo9Sh5VriXte1T8xRc+acOHJbdNfQbxupXsRfUOFHJQHErchvVzm
         6iaWFTz8Pyx8UAgfmS4FEoxYp7h3Xfslo/r6Uad5yCr8CgfTXsGVsi91/wZMyQyconIX
         US4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:cc:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=7DzbllBMNqedjXJm4so5ZoWJjhW2vbPQhZTRJ7K6mdo=;
        b=A68GiGBb128aH/3yc/j4vspbv+RSW5/O7Imzuw20ZgUDQ5fyZwhmeR/5PA4gp8rClA
         tOTE56DGTUeTIEh3CYnsZ5fYJlR2SuoXIOwpvl7/chElJPGObnt2piYQnzSG2+wPWNju
         nhDW+zZt3GEOS8l5HYxH6YYc4Lb1UoDDBx2Njzpjw+NwgvQA3Xq2XaQFhKWq0xIMU36t
         CZzhl1it7nIjX3y+5TaGHTI8ywdqsiurVds85v+PxRpHebILGPpylvU0S/PtS/Fxq6QQ
         Z+gLJz0yhf/N7JtC7c3kNdkGj8k7vQFEgvA8JR5BZD/CVLmHUrSxzGAjwDPDdM5tdIFk
         iXYQ==
X-Gm-Message-State: AOAM530cNO9kDzfF4Jf3aSrnohzu961/bD0YvVrR+4XPzN24qsXeVrg7
	FhYdIUi1fqWaby4KpyZZ3/gR6jAl5c4rjrKP
X-Google-Smtp-Source: ABdhPJxL3rfBGEeO4k+KJmJip1xA/IFsi3+hWyH77lklJxVMyj9OkKyVJfkdNllBgZAhk+qXVrJf3g==
X-Received: by 2002:a50:bae6:: with SMTP id x93mr6522437ede.48.1621535539941;
        Thu, 20 May 2021 11:32:19 -0700 (PDT)
Received: from tsr-lap-08.nix.tessares.net ([2a02:578:85b0:e00:c9db:d048:1d4c:cd82])
        by smtp.gmail.com with ESMTPSA id jo12sm1891274ejb.22.2021.05.20.11.32.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 20 May 2021 11:32:19 -0700 (PDT)
Subject: Re: [PATCH mptcp-net] mptcp: drop unconditional pr_warn on bad opt
To: Paolo Abeni <pabeni@redhat.com>,
 Mat Martineau <mathew.j.martineau@linux.intel.com>
References: <a4a3c36230b2aeb1315c6234fa39f9ef711be759.1621358150.git.pabeni@redhat.com>
Cc: mptcp@lists.linux.dev
From: Matthieu Baerts <matthieu.baerts@tessares.net>
Message-ID: <a0c68a41-3b2e-c1c2-4587-4ba645429659@tessares.net>
Date: Thu, 20 May 2021 20:32:18 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <a4a3c36230b2aeb1315c6234fa39f9ef711be759.1621358150.git.pabeni@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit

Hi Paolo, Mat,

On 18/05/2021 19:15, Paolo Abeni wrote:
> This is a left-over of early day. A malicious peer can flood
> the kernel logs with useless messages, just drop it.
> 
> Fixes: f296234c98a8 ("mptcp: Add handling of incoming MP_JOIN requests")
> Signed-off-by: Paolo Abeni <pabeni@redhat.com>

Thank you for the patch and the review:

- 1cb1f9c4c940: mptcp: drop unconditional pr_warn on bad opt
- Results: bdf8ab2fa53b..f7c7d5a50852

Builds and tests are now in progress:

https://cirrus-ci.com/github/multipath-tcp/mptcp_net-next/export/20210520T183134
https://github.com/multipath-tcp/mptcp_net-next/actions/workflows/build-validation.yml?query=branch:export/20210520T183134

Cheers,
Matt
-- 
Tessares | Belgium | Hybrid Access Solutions
www.tessares.net
