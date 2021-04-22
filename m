Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com [209.85.208.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB69E2F9B
	for <mptcp@lists.linux.dev>; Thu, 22 Apr 2021 14:26:52 +0000 (UTC)
Received: by mail-ed1-f49.google.com with SMTP id cq11so10078714edb.0
        for <mptcp@lists.linux.dev>; Thu, 22 Apr 2021 07:26:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares-net.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=prpgsfQtS8Zswrjf7V6ZP/jCnfE5BZdNp7pRiqwY2nM=;
        b=HlbLG7uvwwGSYhhveN9DYrDqJj6bBZIoWW64FzZK+tpoXlq0Ebe+OgmjeXAdeu217Z
         +LBW19MoTZGD60coVaFJPHM4bhpB3RBAQaZy8B3Ae6Z1toKPkEOvhD8MScTd8KXSxU58
         KHvyQFdOqNbKeYfsur+WA98tkFIfSx0Gf2O10sLRLyKNMmmnl2qzwgFl222o1//5RK0r
         c2KQ8twPgdGok+Fz4ladjJKQkLiPdk65bcwj6fMBBWTCdIlQDVzMeTtW+X3g+M4lK7Iv
         vYEsRpSnLiY0wiHFq1DQH7eLHJ6NC1GsY9iNbdVlJtjmBwhXfOtWsWvOsih5Rkde+Eur
         N/Aw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=prpgsfQtS8Zswrjf7V6ZP/jCnfE5BZdNp7pRiqwY2nM=;
        b=cLBWTsRmuXHkT6VnLhZ4aahiaR+tKzEAbzPnY/DZeqDZMLBR9bAuKcAX64L0eCX6UH
         YE6S71ewRBEBLwunkVP80EKeaCvL6wHoFE0rb7gZ4nmW5BQQcj5iR0z52msWSg5BMIe3
         guxEbPxrEGbqmxArPY9+N91Yb2rfdUOf9r+BUxn3oca/DSAzOk5lMsABAmXz+Vsd4+Cw
         ptOhtJ4L3khHauY4wka6DoJNubUl1X1ZSr9Acc+oFvibisPFXRI/ilvKJzpiTwkiqy0/
         EI9Qd1Mj7lw4B1N1Rd4sqTU1rj6gklwUTRoN3+wOrX/obIS8bbGPD+xc1xDS3SS76QwJ
         PrvQ==
X-Gm-Message-State: AOAM533qxmKUjh0qC5l0NjGB30Y33/liVu46cHYwwtzXwxLalhsUW4Ci
	BXRUvhURMSqcPjfM0BBJCSIiDA==
X-Google-Smtp-Source: ABdhPJwIiM9uEVLND19JkvEvF3wug71X0z4pEiZ9OSmbVtmBMVrIMh+FRjWfnYE0as56dnEWiyB7xg==
X-Received: by 2002:a05:6402:27d4:: with SMTP id c20mr4261436ede.271.1619101610941;
        Thu, 22 Apr 2021 07:26:50 -0700 (PDT)
Received: from tsr-lap-08.nix.tessares.net ([2a02:578:85b0:e00:12ce:5892:37b1:5a39])
        by smtp.gmail.com with ESMTPSA id lr27sm1972000ejb.8.2021.04.22.07.26.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 22 Apr 2021 07:26:50 -0700 (PDT)
Subject: Re: [PATCH v2 RESEND] mptcp: remove redundant initialization in
 pm_nl_init_net()
To: Jianguo Wu <wujianguo106@163.com>, mptcp@lists.linux.dev
Cc: Paolo Abeni <pabeni@redhat.com>
References: <2462aa3f-f72b-e31e-7a58-346ddc5ac546@163.com>
From: Matthieu Baerts <matthieu.baerts@tessares.net>
Message-ID: <55a59245-e1be-78c3-a07c-b8bd82db0db3@tessares.net>
Date: Thu, 22 Apr 2021 16:26:49 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <2462aa3f-f72b-e31e-7a58-346ddc5ac546@163.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit

Hi Jianguo,

On 22/04/2021 12:20, Jianguo Wu wrote:
> From: Jianguo Wu <wujianguo@chinatelecom.cn>
> 
> Memory of struct pm_nl_pernet{} is allocated by kzalloc()
> in setup_net()->ops_init(), so it's no need to reset counters
> and zero bitmap in pm_nl_init_net().

Thank you for the new version.

With Paolo, we slightly modified the comment you added to fix one typo
and make it shorter, nothing important.

Just added in the tree with Paolo's ACK:

- 7f8536b0200c: mptcp: remove redundant initialization in pm_nl_init_net()
- Results: b48a833e40ba..bdc5b468c37c

Builds and tests are now in progress:

https://cirrus-ci.com/github/multipath-tcp/mptcp_net-next/export/20210422T142551
https://github.com/multipath-tcp/mptcp_net-next/actions/workflows/build-validation.yml?query=branch:export/20210422T142551

Cheers,
Matt
-- 
Tessares | Belgium | Hybrid Access Solutions
www.tessares.net
