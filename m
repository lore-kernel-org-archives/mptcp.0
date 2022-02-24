Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C71A747A
	for <mptcp@lists.linux.dev>; Thu, 24 Feb 2022 14:16:14 +0000 (UTC)
Received: by mail-ej1-f47.google.com with SMTP id a23so4666362eju.3
        for <mptcp@lists.linux.dev>; Thu, 24 Feb 2022 06:16:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares-net.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :references:from:in-reply-to:content-transfer-encoding;
        bh=fv+aajkonbEUJLnXjxiPxS2SZTeJTijxAMfWSs4ZKQw=;
        b=Vy/gac8eg6Ho9SVGJCIXx8DHVxekzGYMQnfSy3BnGrsRPuDR8FyCzqP0lF+Jy8GudU
         1wAN/WuPPNfaEs5PL61sVXOATnM0ovD9kZ7sszoyi1xvjFpTCogz/va4HjwF3KtEAru8
         bfRcOUyGZnswxPu7Or+vG7Tba5KO1rdMNN6/+PvKYSgKmL4Fj5ZTWuLMNhLJsSgbsAsp
         L4Detkx90xCjGvdtl3SOtnUGV5Rk5Nh3WZLXT6qmP1CaaOYWfmJQkPFXUftUecDKfmoo
         DczrBv27gmhO2MERrhRfBGBnIyLiiVPIXZdGi4Ot7AdGYNRqtl9PgS8PkpBc0GX//6C7
         /+aA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:references:from:in-reply-to
         :content-transfer-encoding;
        bh=fv+aajkonbEUJLnXjxiPxS2SZTeJTijxAMfWSs4ZKQw=;
        b=lHCozXgSAguRTAAALYO1IhHDqZRBZ4hwOVGuo70dl/fRAuiqZTVIwkvJbniv5WHOlb
         Y/sltJh4Qrv5NpgjRv7IjiMu7T4/7C5dVlguusDrvk2M9NNLu99pC0Cr3qgMssvX3fxh
         Sr77ppyKguCEvZOe5txh6P7fKFxhpaLceZyyi5ZzJfZQ0Bul0ZiiB0VLTah0v4XDyXbJ
         g5dp3MkQ/Xxy0fJ9G38bl+SJJZgbwOY3Z1j2usmX5Wh4E1O/NaqMkIuTxQpHYPOMU6lz
         j75gZEvT6Hxup8BXq4qqiDxf0HIUo/DTnt3GutklNdwdDi8haBqvQ7XjYxyM1+UrNRzp
         3NRg==
X-Gm-Message-State: AOAM5317iruvaAjgNh0/pQ3BNhH+fsnUxdnnLp142frE5wzveJzH4Uj3
	r32jcHYz4JLqD4OGd6exu7cfixbJUM+vLh+1aRI=
X-Google-Smtp-Source: ABdhPJxqYsY0ZKMIbAerKGOlx5/R8aQ5D1QvQOII7rgbeqFZ0YC6TEruq7lkSZwcf7i2ZflcryuCnQ==
X-Received: by 2002:a17:906:d205:b0:6d1:4446:d950 with SMTP id w5-20020a170906d20500b006d14446d950mr2332156ejz.702.1645712172419;
        Thu, 24 Feb 2022 06:16:12 -0800 (PST)
Received: from [10.44.2.26] ([81.246.10.41])
        by smtp.gmail.com with ESMTPSA id s12sm1405165ejv.82.2022.02.24.06.16.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 24 Feb 2022 06:16:12 -0800 (PST)
Message-ID: <140a3c63-6b10-e899-196d-d396b5536c21@tessares.net>
Date: Thu, 24 Feb 2022 15:16:11 +0100
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.1
Subject: Re: [PATCH mptcp-next v4] Squash to "bpf: add 'bpf_mptcp_sock'
 structure and helper"
Content-Language: en-GB
To: Geliang Tang <geliang.tang@suse.com>, mptcp@lists.linux.dev
References: <4a1d63bb7976c1d61308a875132107e17272c8f8.1645519631.git.geliang.tang@suse.com>
From: Matthieu Baerts <matthieu.baerts@tessares.net>
In-Reply-To: <4a1d63bb7976c1d61308a875132107e17272c8f8.1645519631.git.geliang.tang@suse.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Geliang,

On 22/02/2022 09:52, Geliang Tang wrote:
> This patch addressed to the comments in [1] from BPF maintainer Alexei:

Thank you for this v4!

Just to be sure it is clear: this patch is marked as "Changes Requested"
on patchwork because it fails to build:

https://github.com/multipath-tcp/mptcp_net-next/runs/5285534493?check_suite_focus=true#step:5:3060

  ld: net/core/filter.o: in function `bpf_mptcp_sock':
  filter.c:(.text+0xca07): undefined reference to `msk_from_subflow'
  make: *** [Makefile:1155: vmlinux] Error 1

Cheers,
Matt
-- 
Tessares | Belgium | Hybrid Access Solutions
www.tessares.net
