Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com [209.85.208.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDCC81376
	for <mptcp@lists.linux.dev>; Tue, 15 Feb 2022 10:00:24 +0000 (UTC)
Received: by mail-ed1-f52.google.com with SMTP id z13so12893197edc.12
        for <mptcp@lists.linux.dev>; Tue, 15 Feb 2022 02:00:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares-net.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :references:from:in-reply-to:content-transfer-encoding;
        bh=2KPRYl5aXXw/Z34/22u0SxGR/AbVL3OFX1v9v33OZng=;
        b=yHxfdiehlg7BU3/VXE1glxi5nIgx9qGUrT5jiotZYmD55g83GP7OcJFkfMTXyuvyCV
         6qHtwmGHrG/rneflFfuTvh9hv7PcGnDtkWsS1RAWll77aeVaK7zBuNDV5nAzuL/txQlo
         mUyCznGhz0lOakIbJEV/6qwyCDFzrbQfZNQemeZTcgEOQXAy50SUZ5A9CFBzXQEqRuC2
         U+6ZwFZH0qoItezok/YR+WvRoXu1HQuj3/DTEevl8yM7aXP2vSg2MZJXR4kW/+p5bTAZ
         KyuLgwPjbkFosiRz3yDLkEyvZN7re5oGcOiE2ZOtOohMKveHARds79dKQmP5kOx0a5xF
         9qPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:references:from:in-reply-to
         :content-transfer-encoding;
        bh=2KPRYl5aXXw/Z34/22u0SxGR/AbVL3OFX1v9v33OZng=;
        b=L4s5fclWxXcF8efL5sLnE0SQAWUEg9gRIAo4IrTy0x2LtKCGpxqm3w1Sqkp7KqcBBp
         9Nm7gSLEqnXp5Sz09j2BqERtWOJXeSq9BtkN50i59UDbtU2WkjMUow7hi8iZ26kYKrih
         2TdpnNsxPTyMbGmG/gixEGME3u7aDLJ4B8rrvHv3x38zAEEEKueRAcbFKyoNgr3pHS7X
         m3fA4dGRQB+1qfPn/gcQjKzdwV37Ru+2QqgbI46+NKCmVHe6TkIROE1DimUX+/sI859u
         BT7XT0AB9AOTJmVA1FTqnw/0qEeLjnmR2SddPIjYaebM9eplG+booju9Mb36wsr65sno
         tefg==
X-Gm-Message-State: AOAM532Kd5MjLqKTiXOKSmmwi3+XjQm/R7sgSyHzrSktLn5Qpxo0nvTD
	Lu1Wl3uKknr7wMV8r9gy6yBoPI7xkELCVUAW
X-Google-Smtp-Source: ABdhPJyeki41TEowjArZO+0Vc+BbRe6k7A90uGo1Gg81NpvvLhwUEg9b9EruGNYrrYQHTtn1vtZAUA==
X-Received: by 2002:a05:6402:697:: with SMTP id f23mr3180745edy.222.1644919223146;
        Tue, 15 Feb 2022 02:00:23 -0800 (PST)
Received: from [10.120.18.9] ([84.17.46.7])
        by smtp.gmail.com with ESMTPSA id 26sm2705374eja.183.2022.02.15.02.00.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 15 Feb 2022 02:00:22 -0800 (PST)
Message-ID: <952696b0-ce52-94bf-5ae4-a02f2562a4e6@tessares.net>
Date: Tue, 15 Feb 2022 11:00:22 +0100
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.1
Subject: Re: [PATCH mptcp-next 0/2] dump infinite_map in trace event
Content-Language: en-GB
To: Geliang Tang <geliang.tang@suse.com>, mptcp@lists.linux.dev
References: <cover.1644819421.git.geliang.tang@suse.com>
From: Matthieu Baerts <matthieu.baerts@tessares.net>
In-Reply-To: <cover.1644819421.git.geliang.tang@suse.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Geliang, Mat,

On 14/02/2022 07:23, Geliang Tang wrote:
> Small patches for dumping newly added infinite_map in trace event.
> 
> Geliang Tang (2):
>   mptcp: dump infinite_map field in mptcp_dump_mpext
>   mptcp: add tracepoint in mptcp_sendmsg_frag

Thank you for the patches and the reviews!

Just applied in our tree -- feat. for net-next, just after your infinite
mapping series as the first patch is linked to that -- with Mat's RvB tag:

- c1def824105b: mptcp: dump infinite_map field in mptcp_dump_mpext
- d40888c52c52: mptcp: add tracepoint in mptcp_sendmsg_frag
- Results: 49fef9d3e44a..19d141cf146b

Builds and tests are now in progress:

https://cirrus-ci.com/github/multipath-tcp/mptcp_net-next/export/20220215T100005
https://github.com/multipath-tcp/mptcp_net-next/actions/workflows/build-validation.yml?query=branch:export

Cheers,
Matt
-- 
Tessares | Belgium | Hybrid Access Solutions
www.tessares.net
