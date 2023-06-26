Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39F052F34
	for <mptcp@lists.linux.dev>; Mon, 26 Jun 2023 11:28:38 +0000 (UTC)
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-313f2a24cb6so816201f8f.0
        for <mptcp@lists.linux.dev>; Mon, 26 Jun 2023 04:28:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares.net; s=google; t=1687778917; x=1690370917;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=66DQudTDaLd48Ab5sKUZXI/QQPzf9/AzZ0AIKt2FDK0=;
        b=F/4L21JNNj9vpTxOkg7xDQbJvlVPhHz/9rMFB0/wIn5EOCOkaBy0hhQkh2TThLpFfM
         FiGPOcEJ934in0NGtLRQxyHr+4Z1OGkqgSBKF0aC3NLxvFFahKD63w5y+Wm+oRPKTl0F
         okZD5WmnxZD67N7PfGBUknPW9jnU/533MsBGsuEtXOgWT90tahgJj1tagzHd8ER7uU3I
         u5MaVzODjMGYlm3XHhk15j9WZuiJI1ru4/seDc+qj+1wDXTHWwwTLRKhSJTAD40Sn6QP
         Fg6yxTVVvozoETtLNGXbcDuyu1zulkyjq0DlbtU8xdjGPwUH8SjeNj8ZNBGNx0o5RuQj
         PqDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687778917; x=1690370917;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=66DQudTDaLd48Ab5sKUZXI/QQPzf9/AzZ0AIKt2FDK0=;
        b=ZVMrk0AluNH31SUB4uINI7VpoHLCguf4cgIPea1eJjuVTRJXqQAGPu61v2k25zxYzS
         pW3DBh+TCYRNDszmWS/ibi1n04GVGaNpz7/YnQwfzuFn/pJHsQqAO4qby8QXNJ6YDECB
         utgr5ucx+JLK1Zb+hI8IxQ6Oa3ebWXqXl7jpp3ZKrDW/yJnecFyW/12OhphtZcZzyMKH
         wS629cDEFCjuxEsiTQpuPEB7MCF0eUfP0AYt6x4Azh3tVTxiYa3AnU5nHnlDzj5oxXJC
         kTRrZUZ9CiapZWNX/YU4WKHfYAuwf1gp1eDGfJFeuWMmdLxVwZsupuRcy61LB/XNj4lW
         Xizg==
X-Gm-Message-State: AC+VfDwibDgI0sQOff05sTltJDMmLlY7g67YVi3TCO2oJs6PzY5BGn4e
	MhC/Z0dRrgOlCtRwMKsIlNJixQ==
X-Google-Smtp-Source: ACHHUZ44E2+XxsEZxoZOrLRdy1D3wwt9sMgDyswEetYO/LI4BMnjb87/selq4tLK6PGKHZ6qlJlWOg==
X-Received: by 2002:adf:df0f:0:b0:313:e424:906e with SMTP id y15-20020adfdf0f000000b00313e424906emr5263022wrl.38.1687778916779;
        Mon, 26 Jun 2023 04:28:36 -0700 (PDT)
Received: from [10.44.2.5] ([81.246.10.41])
        by smtp.gmail.com with ESMTPSA id n2-20020a5d67c2000000b003127741d7desm7030413wrw.58.2023.06.26.04.28.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 26 Jun 2023 04:28:36 -0700 (PDT)
Message-ID: <5cfcf26c-739b-8787-3264-b41ff5cbed52@tessares.net>
Date: Mon, 26 Jun 2023 13:28:35 +0200
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH net 0/2] selftests: fix mptcp_join test
Content-Language: en-GB
To: Andrea Claudi <aclaudi@redhat.com>, netdev@vger.kernel.org,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com
Cc: mptcp@lists.linux.dev, martineau@kernel.org, geliang.tang@suse.com
References: <cover.1687522138.git.aclaudi@redhat.com>
From: Matthieu Baerts <matthieu.baerts@tessares.net>
In-Reply-To: <cover.1687522138.git.aclaudi@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Andrea,

On 23/06/2023 14:19, Andrea Claudi wrote:
> This series fixes two mptcp_join testcases.
> - '001 implicit EP' fails because of:
>   - missing iproute support for mptcp 'implicit' flag, fixed with
>     iproute2-next commit 3a2535a41854 ("mptcp: add support for implicit
>     flag")
>   - pm_nl_check_endpoint expecting two ip addresses, while only one is
>     present in the iproute output;
> - '002 delete and re-add' fails because the endpoint delete command
>   provide both id and ip address, while address should be provided only
>   if id is 0.
> 
> Andrea Claudi (2):
>   selftests: mptcp: join: fix 'delete and re-add' test
>   selftests: mptcp: join: fix 'implicit EP' test

Thank you for these patches!

I have some comments, please see my replies on the individual patches.

Do you mind sending a v2 only to MPTCP ML -- not to Netdev and its
maintainers -- if you don't mind? When these patches will be ready, we
will apply them in MPTCP tree and send them later to netdev.

(Maybe we should modify the MAINTAINERS file to exclude Netdev
maintainers and list when someone sends a patch.)

Cheers,
Matt
-- 
Tessares | Belgium | Hybrid Access Solutions
www.tessares.net
