Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 172A318C11
	for <mptcp@lists.linux.dev>; Thu, 25 May 2023 16:02:20 +0000 (UTC)
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-3f6da07ff00so7119165e9.3
        for <mptcp@lists.linux.dev>; Thu, 25 May 2023 09:02:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares.net; s=google; t=1685030539; x=1687622539;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=RsF47cLPgYUo+0et/7iEyT9fQyi0KoDhJCC5Q15WScM=;
        b=20tWWGbulgSbXnXX7sxbzsWYAqCv+Z/Jcy/UJZ1zKkzHQOFrjx6QkduR+l3Ly+jQ0y
         GlKPeLjvtu/Kg8tSl/j1aEdDoUGaf0ggTTvBZpQzaS2on4IMvnkOMZcTDBdl4kewLhOe
         hoJl8FWZVfeJ7ZZfaAJqd6zKerEdxfXf0a0TnKJ9jlUW5ilOAg514IyOjx+s5UyiQE/v
         qCU6ddymWV3k/iT2AlC1WsCa7ixYFxDUjTM49qwYBBkBfB8bSbJgMm7YGvzj+YiD+PVL
         hyP+D3o0isx4QLhjMikldgt08Cn+OWyC9wHCotUqbalNnTaMmt9YH0HQmYp61BaovVzf
         gWcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685030539; x=1687622539;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=RsF47cLPgYUo+0et/7iEyT9fQyi0KoDhJCC5Q15WScM=;
        b=FGoPdPgijqz6qLHJGyuDyzN2LoITQpFx2HOCuY5hZUTgHDMY8l+GbkINYN67REoVQU
         jb1MAnT36++QVFtdnolb6Iu9k7Owr7SdWHVhzOBgIfKAoqcDeSkBoVJUznZEqkQwBAJm
         AgHwnBH7oFMZES7t9mHccZX+WVQ/duSUSbKAgVbYigBEpg6jTvY2VqkBdXZXykY01ecV
         sY+ql33dWFRkh1/n7RQJl/gcIO/5HgSMysDCfGEVj9FDTSPxYPtZj+Vimj8ZrUO3AdFs
         v28rC55fAnRkMfIfIC4Huza2Nq+tfnZF/2zeP6FwMhMJmeg1rBz2iEhlt2VruqSXQA0t
         OIwg==
X-Gm-Message-State: AC+VfDzmDNkBvD2RoXzo/cntkPFntl4Dz8nPKkOnwuKBjaS295IIO/8F
	H0aS6U4gdYuZNfBb+MDhXQumKqRB7aWt0gw3Qro=
X-Google-Smtp-Source: ACHHUZ5qEguhhf4f1ndMrKkv6lPJO2WT754JYtA1wLcOW6gOw4yl+VtqMPY891gn/Ik3PaImDvSzWA==
X-Received: by 2002:a7b:ce95:0:b0:3f1:72e2:5d13 with SMTP id q21-20020a7bce95000000b003f172e25d13mr3002250wmj.16.1685030539038;
        Thu, 25 May 2023 09:02:19 -0700 (PDT)
Received: from ?IPV6:2a02:578:8593:1200:f7f1:b30b:79e4:1a7e? ([2a02:578:8593:1200:f7f1:b30b:79e4:1a7e])
        by smtp.gmail.com with ESMTPSA id e21-20020a05600c219500b003f4fffccd73sm2538898wme.9.2023.05.25.09.02.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 25 May 2023 09:02:18 -0700 (PDT)
Message-ID: <3c425b6b-117a-f613-0071-2a1669920d13@tessares.net>
Date: Thu, 25 May 2023 18:02:18 +0200
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH mptcp-next 3/4] mptcp: unify pm
 get_flags_and_ifindex_by_id
Content-Language: en-GB
To: Geliang Tang <geliang.tang@suse.com>, mptcp@lists.linux.dev
References: <cover.1685001897.git.geliang.tang@suse.com>
 <aebf16ae330cdcf47e05be90b2891f7d9763ce98.1685001897.git.geliang.tang@suse.com>
From: Matthieu Baerts <matthieu.baerts@tessares.net>
In-Reply-To: <aebf16ae330cdcf47e05be90b2891f7d9763ce98.1685001897.git.geliang.tang@suse.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Geliang,

On 25/05/2023 10:07, Geliang Tang wrote:
> This patch unifies the three PM get_flags_and_ifindex_by_id() interfaces:
> 
> mptcp_pm_nl_get_flags_and_ifindex_by_id() in mptcp/pm_netlink.c for the
> in-kernel PM and mptcp_userspace_pm_get_flags_and_ifindex_by_id() in
> mptcp/pm_userspace.c for the userspace PM.
> 
> They'll be switched in the common PM infterface
> mptcp_pm_get_flags_and_ifindex_by_id() in mptcp/pm.c.
> 
> Signed-off-by: Geliang Tang <geliang.tang@suse.com>
> ---
>  net/mptcp/pm.c         |  8 ++++++++
>  net/mptcp/pm_netlink.c | 10 ++--------
>  net/mptcp/protocol.h   |  2 ++
>  3 files changed, 12 insertions(+), 8 deletions(-)
> 
> diff --git a/net/mptcp/pm.c b/net/mptcp/pm.c
> index e37df2f45c70..8499196b8789 100644
> --- a/net/mptcp/pm.c
> +++ b/net/mptcp/pm.c
> @@ -424,6 +424,14 @@ int mptcp_pm_get_local_id(struct mptcp_sock *msk, struct sock_common *skc)
>  	return mptcp_pm_nl_get_local_id(msk, skc);
>  }
>  
> +int mptcp_pm_get_flags_and_ifindex_by_id(struct mptcp_sock *msk, unsigned int id,
> +					 u8 *flags, int *ifindex)
> +{
> +	if (id && mptcp_pm_is_userspace(msk))

It looks strange to call mptcp_pm_nl_() if the userspace PM is used but
id == 0. Maybe add this check in the userspace function?

Or maybe better to do:

  int mptcp_pm_get_flags_and_ifindex_by_id(...)
  {
      *flags = 0;
      *ifindex = 0;

      if (id == 0)
          return 0;

      if (mptcp_pm_is_userspace(msk))
          return mptcp_userspace_pm_(...);
      return return mptcp_pm_nl_(...);
  }

By doing that, you can remove the init of flags and ifindex frmo the two
PMs + the check of 'id' from the Netlink PM. WDYT?

Cheers,
Matt
-- 
Tessares | Belgium | Hybrid Access Solutions
www.tessares.net
