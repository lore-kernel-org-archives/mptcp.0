Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com [209.85.208.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E203B2C9D
	for <mptcp@lists.linux.dev>; Thu,  2 Dec 2021 17:50:38 +0000 (UTC)
Received: by mail-ed1-f49.google.com with SMTP id w1so1226177edc.6
        for <mptcp@lists.linux.dev>; Thu, 02 Dec 2021 09:50:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares-net.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=FeZA6KXPPLMLAhwsXdrVAfsphPk3QwlUovbLy9uHkeU=;
        b=Kuyjw5zRpUXcHbqVFsZk2y3jQ+UKdkt3bxKZiDwiwQM7h/k89aOvUcknOFxQ7CWidu
         21RiR4UPJubsgEvo9/VKcoGXMyweHIfra8CcwsycAYTmT1L5hSWJi6yRYvOxrsBz0zzJ
         iORmzMq1RQAH9yI4OlBbZqqb3Sc1yo0Fjkt3dWov+Nn1WBL+GY14drX/0gqZiANkeXH/
         MYA1Wb7k+sXkEDLCdE7I5e0qOdJDJEosSYwRCeovR3BZYsbm1oWgrd0vm5fR+NEi/B5M
         dSlumegK39cS/Gaow3zT/MYaXdBCx+c+nbGJEfnkYKgHEALAtD2BYt1In5RZ19QGXDF7
         JrGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=FeZA6KXPPLMLAhwsXdrVAfsphPk3QwlUovbLy9uHkeU=;
        b=n7PiBG8ts5bDY25UrlHMHn11KKzm1r5B5enOfkJt/AlC1hUbWBCRBRtfzdLNfnKHnP
         six//ZYuEg3lrD6y+Lvz2AI+FHmesMHmwrEt5Tr94B7qI0TDZ5GSLVGutVjApVEU92RG
         o+1/Z2k+59TKpS7gq1PB2L4ddsfwYt/oZNHDPjx1BYEIgLJSEl1m1vgXAV7YYHUvOwG8
         2pDOE6wRrupf5INhEB7VuHAU1YkOPk3IN4SFS0Knmq6cAKXdGeWqww78Ct1Dta7XYDT7
         ntSex2LEZvxpiuBW4h2ZsQHoF1PrF6zgL9u0ZA37mARBoEp7YyIsGfSq5tmbP5YjERKN
         Xsbw==
X-Gm-Message-State: AOAM530YPhAzdYBWI/HJwueY8ZRd5EiZLoffG1JyF/AXWlkKChgmtBfl
	F4FeQAkcyyNXbF2/NFYXL1G40SAsIDt2E7XTCI0=
X-Google-Smtp-Source: ABdhPJzrKPP6M+iTXXud5LQCwC5YBwZaGTKP5NYeRZG0jHxL2D1nHTWC4nZ2ntyD5k54fMCeZGahlg==
X-Received: by 2002:a17:907:7f9e:: with SMTP id qk30mr17105977ejc.313.1638467437192;
        Thu, 02 Dec 2021 09:50:37 -0800 (PST)
Received: from [192.168.178.33] ([213.211.142.51])
        by smtp.gmail.com with ESMTPSA id dy4sm251719edb.92.2021.12.02.09.50.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 02 Dec 2021 09:50:36 -0800 (PST)
Message-ID: <7a5ebdb0-8dbc-71fc-c215-c9465ce4f39c@tessares.net>
Date: Thu, 2 Dec 2021 18:50:36 +0100
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.2
Subject: Re: [PATCH mptcp-net] mptcp: fix deadlock in __mptcp_push_pending()
Content-Language: en-GB
To: Maxim Galaganov <max@internet.ru>, Florian Westphal <fw@strlen.de>,
 Mat Martineau <mathew.j.martineau@linux.intel.com>
Cc: Paolo Abeni <pabeni@redhat.com>, mptcp@lists.linux.dev
References: <20211201211523.7155-1-max@internet.ru>
From: Matthieu Baerts <matthieu.baerts@tessares.net>
In-Reply-To: <20211201211523.7155-1-max@internet.ru>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Maxim, Florian, Mat,

On 01/12/2021 22:15, Maxim Galaganov wrote:
> __mptcp_push_pending() may call mptcp_flush_join_list() with subflow
> socket lock held. If such call hits mptcp_sockopt_sync_all() then
> subsequently __mptcp_sockopt_sync() could try to lock the subflow
> socket for itself, causing a deadlock.

Thank you for the patch and the review!

Now in our tree (fix for -net) with Florian and Mat's RvB tags:

- 4607ae5cd560: mptcp: fix deadlock in __mptcp_push_pending()

- Results: afbf49f90abe..3fca3bddffca

(Thanks for the Closes tag :) )

Builds and tests are now in progress:



https://cirrus-ci.com/github/multipath-tcp/mptcp_net-next/export/20211202T175024

https://github.com/multipath-tcp/mptcp_net-next/actions/workflows/build-validation.yml?query=branch:export

Cheers,
Matt
-- 
Tessares | Belgium | Hybrid Access Solutions
www.tessares.net
