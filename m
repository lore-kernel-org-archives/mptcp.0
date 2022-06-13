Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com [209.85.208.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED213110D
	for <mptcp@lists.linux.dev>; Mon, 13 Jun 2022 07:25:20 +0000 (UTC)
Received: by mail-ed1-f47.google.com with SMTP id d14so5844608eda.12
        for <mptcp@lists.linux.dev>; Mon, 13 Jun 2022 00:25:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares-net.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :references:from:in-reply-to:content-transfer-encoding;
        bh=f5kgwxwk0vlPzppeqMgyCSkHm7niwOJN6+LgoAGuu6I=;
        b=u/9fwg9kRSO+3xW2CQwrCvK6KpjXESOASa1XYKRR0qm2E99a9go7xmyUKQdfAAu9nz
         9/ugbUO2QzuvCgS3V2seHsNuqzkNJnHtsvjxxecYGC2ULJpHZbCx7AawQGZFLDmt2RtR
         iPKWI1lBJu3+UzS8X5e4Go4LEiAXtbvPKID/WM8xu11MuCAqFDgYsjW7Jw2/S7IMwDqk
         MLEVfsxbjJRZ27Pib5B8AfQxaj0SA6nEflCcUtUP5Zn2VY4icUjAFrl11eN9CY6WcrV+
         NySPOghhBMuWRcOuOdQI3x0PyYgMCHxlelMLFbXaKBGc4tO3bIXz8l0fnqypyYQRUpT1
         V2zQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:references:from:in-reply-to
         :content-transfer-encoding;
        bh=f5kgwxwk0vlPzppeqMgyCSkHm7niwOJN6+LgoAGuu6I=;
        b=Lk3oxbNH6PjcxJimYe9FoKchKKD+6S12CAeeqKTvOx7Qzn1dHPnr9CBcx7u5qi2/ek
         U3ue46lNR22NbbRi+ojXaOn5toErbFa44Qp6e42XSZzMxA2bJ2H18EYU7DWLD5QzjSYH
         dBcszDAMaq96mypgIA6SA06c2yQNXOweJUz8vbnp+yQC4IZiPV7XilRrSZ6ftKoY1Vw1
         Qf5QsMKu2r0SV4i8ZLVRbeLyHn3uOV4j8XtMfTLwvEYHQ4+mSJL1iUWERGWG7rsa3pSH
         MJuSJ1C/FqmDlFt//wHUzVws5EvH73hivGwS/WImjW+KBlPV0/7PlCMmKesmcqJ0UgWl
         vWvg==
X-Gm-Message-State: AOAM5303Iih96BxGKZdnLk1tfzoW3T3VDFBOePaNg7M3w1j2y1eT42ME
	JbNP3qT+KJ3h1K2gPrtcueF2qg==
X-Google-Smtp-Source: ABdhPJyTT+OdukuQjQCOy7wI3yWweIzo0arw+FfFSTSmfSyZu27jbpyO5I0W6mwvVjYPnPC2Z7vwqg==
X-Received: by 2002:aa7:c0d1:0:b0:42d:ddda:7470 with SMTP id j17-20020aa7c0d1000000b0042dddda7470mr62965279edp.196.1655105118685;
        Mon, 13 Jun 2022 00:25:18 -0700 (PDT)
Received: from ?IPV6:2a02:578:8593:1200:e91:9a45:e2da:8352? ([2a02:578:8593:1200:e91:9a45:e2da:8352])
        by smtp.gmail.com with ESMTPSA id um10-20020a170906cf8a00b006fe8c831632sm3478538ejb.73.2022.06.13.00.25.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 13 Jun 2022 00:25:18 -0700 (PDT)
Message-ID: <982d63cf-8369-5f88-64bd-b59bc8c2f93f@tessares.net>
Date: Mon, 13 Jun 2022 09:25:17 +0200
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH mptcp-next v2 1/5] mptcp: update MIB_RMSUBFLOW in
 cmd_sf_destroy
Content-Language: en-GB
To: Geliang Tang <geliang.tang@suse.com>, mptcp@lists.linux.dev
References: <cover.1654958401.git.geliang.tang@suse.com>
 <4ed5348a34b4de9b482fe192fc271a59ee334e37.1654958401.git.geliang.tang@suse.com>
From: Matthieu Baerts <matthieu.baerts@tessares.net>
In-Reply-To: <4ed5348a34b4de9b482fe192fc271a59ee334e37.1654958401.git.geliang.tang@suse.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi Geliang,

On 11/06/2022 16:54, Geliang Tang wrote:
> This patch increases MPTCP_MIB_RMSUBFLOW mib counter in userspace pm
> destroy subflow function mptcp_nl_cmd_sf_destroy() when removing subflow.
> 
> Signed-off-by: Geliang Tang <geliang.tang@suse.com>
> ---
>  net/mptcp/pm_userspace.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/net/mptcp/pm_userspace.c b/net/mptcp/pm_userspace.c
> index f56378e4f597..ebbab5200290 100644
> --- a/net/mptcp/pm_userspace.c
> +++ b/net/mptcp/pm_userspace.c
> @@ -5,6 +5,7 @@
>   */
>  
>  #include "protocol.h"
> +#include "mib.h"
>  
>  void mptcp_free_local_addr_list(struct mptcp_sock *msk)
>  {
> @@ -418,6 +419,7 @@ int mptcp_nl_cmd_sf_destroy(struct sk_buff *skb, struct genl_info *info)
>  
>  		mptcp_subflow_shutdown(sk, ssk, RCV_SHUTDOWN | SEND_SHUTDOWN);
>  		mptcp_close_ssk(sk, ssk, subflow);
> +		__MPTCP_INC_STATS(sock_net(sk), MPTCP_MIB_RMSUBFLOW);

It looks like this instruction is causing quite a bit of issues
according to the public CI:

- KVM Validation: normal:
  - Critical: 7 Call Trace(s) ❌:
  - Task: https://cirrus-ci.com/task/5443636765655040
  - Summary:
https://api.cirrus-ci.com/v1/artifact/task/5443636765655040/summary/summary.txt


I guess you should use MPTCP_INC_STATS() instead.


Side note: I don't know if it is a good idea to increment MIB counters
from the PM code (any pm*.c files). I think this should only be done
from "core" functions in protocol.c and subflow.c (+ options.c of
course). Or from new helpers declared in protocol.h. WDYT?

Cheers,
Matt
-- 
Tessares | Belgium | Hybrid Access Solutions
www.tessares.net
