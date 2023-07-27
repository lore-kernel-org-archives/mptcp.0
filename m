Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A16727124
	for <mptcp@lists.linux.dev>; Thu, 27 Jul 2023 16:52:48 +0000 (UTC)
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-3fbab0d0b88so16855155e9.0
        for <mptcp@lists.linux.dev>; Thu, 27 Jul 2023 09:52:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares.net; s=google; t=1690476767; x=1691081567;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=qwhpoqF6uKfTEG6vT7uh8sBiirQNQ3fVgWMLvnyO2Ig=;
        b=b31AXRJ0C0AZPBZHEDb4B5Tbuvzn36HDJkgEVqILKRJyZlihEdT0XG1M4qxbeeAE/J
         tTQxgTq2Or93PffMmvvqlZ5OOCK5rKE01c7Xi6r4JD5U2xeyfVs8dL1BA89VRbSjIQqn
         8l2nHFsDbKxGMzmovblmgQs2UBtImainu+BPLwQL7hgsOW+qTfjPUiCZ3JaYlg5uuUxP
         CViIrZD+pJy4o0rOTb6ugITRYBdG90oHOotjnBNM28XtSWvrZmX+qtvjRMu3SkbGReTC
         bzSi9pweuWWqV6kE/lAjbA71wP4o5Ko3vqoeAo+MgV153SF3XzUi3npx7oI7OltGW40p
         /ySg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690476767; x=1691081567;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=qwhpoqF6uKfTEG6vT7uh8sBiirQNQ3fVgWMLvnyO2Ig=;
        b=cX/dXAD0GWYwjn+jr9HcRHaH4M78Sff0r9qcrd/fngQaJIU2Nkez2NzfM2ppwilhoi
         S/H+1ttZgUjoU6TJhYDSaaIlOB5a1G+XPVdGtxHheBuPYGs621izqmNINlsAotAfNzp4
         BGVT/+BA2KGTJge8E49ayN3wkuhdmcw0TQQndcJrZ8F7uDIJ1dG0F3apD4Ol2X6DyddN
         IzmvxQwx6FQtXEFAmK9/LOa8wDJ/6SJdAT1+21ofS3BkgbavnHw2DHrPJCLjhF4AOTtf
         bSAByBE6kHk7Vmg7C/e3lF9g7Wmt5nLuOyTR0a/sZv0EeKtMqqNHpVYvvtHkS1CkW1mw
         yC7g==
X-Gm-Message-State: ABy/qLb/hTFtW0km4loHYyJTfs+8BnTwU742GTGuTTKzmvKwl1YzqbBI
	4YnQzyl5KbN/KeITtfNvhumrsg==
X-Google-Smtp-Source: APBJJlHtdrpLsdRey4DrMLDu8WtIaC4tTKRmqh3VTFmHqzyeyj3vBdWSdqNYeYXzyIjLrSxNXdgnuA==
X-Received: by 2002:a1c:4b15:0:b0:3fb:c060:9698 with SMTP id y21-20020a1c4b15000000b003fbc0609698mr2579803wma.5.1690476766837;
        Thu, 27 Jul 2023 09:52:46 -0700 (PDT)
Received: from ?IPV6:2a02:578:8593:1200:e411:185b:7f55:ef18? ([2a02:578:8593:1200:e411:185b:7f55:ef18])
        by smtp.gmail.com with ESMTPSA id w3-20020a1cf603000000b003fa973e6612sm5000035wmc.44.2023.07.27.09.52.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 27 Jul 2023 09:52:46 -0700 (PDT)
Message-ID: <b5364451-9cd2-6409-c829-0c34a156e6f7@tessares.net>
Date: Thu, 27 Jul 2023 18:52:45 +0200
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH mptcp-next v2 0/2] selftests: fix mptcp_join test
Content-Language: en-GB
To: Andrea Claudi <aclaudi@redhat.com>, mptcp@lists.linux.dev
Cc: Mat Martineau <martineau@kernel.org>
References: <cover.1690454072.git.aclaudi@redhat.com>
From: Matthieu Baerts <matthieu.baerts@tessares.net>
In-Reply-To: <cover.1690454072.git.aclaudi@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Andrea,

On 27/07/2023 13:08, Andrea Claudi wrote:
> This series fixes two mptcp_join testcases when using ip mptcp:
> - 'implicit EP' fails because of:
>   - missing iproute support for mptcp 'implicit' flag, fixed with
>     iproute2-next commit 3a2535a41854 ("mptcp: add support for implicit
>     flag")
>   - pm_nl_check_endpoint expecting two ip addresses, while only one is
>     present in the iproute output;
> - 'delete and re-add' fails because the endpoint delete command
>   provide both id and ip address, while address should be provided only
>   if id is 0.
> 
> Changelog:
> 
> v1 -> v2
> - Clearly state test fails only when using ip mptcp, i.e.
>   ./mptcp_join.sh -i
> - Remove test numbers from commit messages
> - On endpoint delete, continue to provide $addr when id is 0.

Thank you for the v2, it looks good to me!

Reviewed-by: Matthieu Baerts <matthieu.baerts@tessares.net>

Just one detail for patch 2/2 for the Fixes tag but I can fix that when
applying the patches if needed and if that's OK for you.

These patches can be applied in mptcp-net (export-net branch).

Cheers,
Matt
-- 
Tessares | Belgium | Hybrid Access Solutions
www.tessares.net
