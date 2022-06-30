Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23E197B
	for <mptcp@lists.linux.dev>; Thu, 30 Jun 2022 17:46:49 +0000 (UTC)
Received: by mail-ej1-f53.google.com with SMTP id sb34so40346976ejc.11
        for <mptcp@lists.linux.dev>; Thu, 30 Jun 2022 10:46:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares-net.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :references:from:in-reply-to:content-transfer-encoding;
        bh=PaGhodQvNVxHQ9COLRt2PnNLDfxJ3jOvR0ptzPNMnEA=;
        b=IiEbDgdu5Kl04JIGbs4bknMTsoh48kvfSguzGRlZcr+AIhDUTTcmQEys28rOqxy0HH
         vIfeJsuAO/k2ge3/x19hctbdyentR3DX7oLaT0qnpP3ovzIXAnrA5GwvsfaGu/+bRnj9
         fu01Edr4CC5qz91EFYRpOjR+cnGpnkIUb0kJw2sl+WlLaez3fjmtxx1THHwERLChgBpN
         UGk1b6WPwY6z5cwikSX25qcsJwEZzHACuzlmXqDJW64mtiqcfWAaP/E+sg6Iof37UHqo
         B8yfwm9+X4xKWp1FhrFEo4tahjyS8fxwsNxleZWC6u73VVWWq0QYuaCn6uItKIcfAA29
         LFhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:references:from:in-reply-to
         :content-transfer-encoding;
        bh=PaGhodQvNVxHQ9COLRt2PnNLDfxJ3jOvR0ptzPNMnEA=;
        b=c1j4l/w61abiwbOx5F/eE0oFic9L3LJEULD3NkxZb94dgflpFQiMKQ5jwcIRtTGZNe
         CAxIiS0rAKOrqWq4fcT1bNqzXu8sGZacFgbZFkfPiYNRFaFZ350Q0dWPSeV6LxEwu76z
         E/P9aR9QkUlNA5lb6SS3sLnxWiWVGKAa+nsb2lHigbboU96oeRRVE4FDkq52bOsnyDZL
         M8vbJ/33nzoAaXTq8PzIf6e2e/dJOs/t91xpXchRty5u85JdsEjI8r40UsMfUn5y1n87
         h7U5MoJw5RJZXEoQfx4V8VMF4A4uzA9Xh60t7xE8yZxUqK6zggaNWLjFm+lGEuaupSqs
         jpkw==
X-Gm-Message-State: AJIora8yQoVfbXgs1bgjVOPkQxYUWiFzdXlUrRlWUx2THYlWU/UGimbO
	fUHs7LF2SIYDom5Noy0b+wAR3g==
X-Google-Smtp-Source: AGRyM1se/5qOYMOS2Ei4hJRcDLY84wznvyK1I+w5mzIeoEt708KpexhgcxKyk+xgwEZlTaoU5tM4fQ==
X-Received: by 2002:a17:907:97d4:b0:722:e550:7490 with SMTP id js20-20020a17090797d400b00722e5507490mr10154513ejc.625.1656611207299;
        Thu, 30 Jun 2022 10:46:47 -0700 (PDT)
Received: from ?IPV6:2a02:578:8593:1200:6947:dee2:2822:3dc2? ([2a02:578:8593:1200:6947:dee2:2822:3dc2])
        by smtp.gmail.com with ESMTPSA id bh25-20020a170906a0d900b00722e1635531sm9368372ejb.193.2022.06.30.10.46.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 30 Jun 2022 10:46:46 -0700 (PDT)
Message-ID: <1387e912-02f3-3f62-9eba-555e711ec503@tessares.net>
Date: Thu, 30 Jun 2022 19:46:46 +0200
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH mptcp-net v4 0/2] mptcp: support MP_PRIO signals with
 userspace PMs
Content-Language: en-GB
To: Kishen Maloor <kishen.maloor@intel.com>, mptcp@lists.linux.dev
References: <20220629012702.425574-1-kishen.maloor@intel.com>
From: Matthieu Baerts <matthieu.baerts@tessares.net>
In-Reply-To: <20220629012702.425574-1-kishen.maloor@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Kishen, Mat, Paolo,

On 29/06/2022 03:27, Kishen Maloor wrote:
> This patch series updates MPTCP_PM_CMD_SET_FLAGS to allow userspace PMs
> to issue MP_PRIO signals over a selected (by local and remote address+port)
> subflow in a MPTCP connection. It also adds self tests for this
> change.
> 
> This patch series has been rebased to the series (in review) titled
> "Locking fixes for subflow flag changes".
> 
> v2:
> -userspace_pm.sh: added a sleep after issuing the MP_PRIO signal.
> 
> v3:
> -use local and remote address+port (instead of address ID) alongwith the
> connection token to select a subflow.
> 
> v4:
> -fixed bug during rebase in v3.
> 
> Kishen Maloor (2):
>   mptcp: netlink: issue MP_PRIO signals from userspace PMs
>   selftests: mptcp: userspace PM support for MP_PRIO signals

Thank you for the patches and the reviews!

Now in our tree (fixes for -net) with Mat's RvB tags and Paolo's ACK.

New patches for t/upstream-net:
- 98405967fe79: mptcp: netlink: issue MP_PRIO signals from userspace PMs
- 2ddc9af505ee: selftests: mptcp: userspace PM support for MP_PRIO signals
- Results: 3c88708b1aca..bf5586d50d31 (export-net)

New patches for t/upstream:
- 98405967fe79: mptcp: netlink: issue MP_PRIO signals from userspace PMs
- 2ddc9af505ee: selftests: mptcp: userspace PM support for MP_PRIO signals
- Results: ce6114ac321d..f970a45a66c3 (export)


Builds and tests are now in progress:

https://cirrus-ci.com/github/multipath-tcp/mptcp_net-next/export-net/20220630T174520
https://github.com/multipath-tcp/mptcp_net-next/actions/workflows/build-validation.yml?query=branch:export-net
https://cirrus-ci.com/github/multipath-tcp/mptcp_net-next/export/20220630T174520
https://github.com/multipath-tcp/mptcp_net-next/actions/workflows/build-validation.yml?query=branch:export

Cheers,
Matt
-- 
Tessares | Belgium | Hybrid Access Solutions
www.tessares.net
