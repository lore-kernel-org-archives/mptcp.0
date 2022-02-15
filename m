Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C65561376
	for <mptcp@lists.linux.dev>; Tue, 15 Feb 2022 09:54:51 +0000 (UTC)
Received: by mail-ej1-f54.google.com with SMTP id p9so20137953ejd.6
        for <mptcp@lists.linux.dev>; Tue, 15 Feb 2022 01:54:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares-net.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :references:from:in-reply-to:content-transfer-encoding;
        bh=l2BG6HpNgCzcGMYDpEFX50fU14inQtcK9NpRbVxvdh4=;
        b=YieMgZNYtVAazbw63DJmgwFi6+a9f0qQJ84CcZT5L8RtGuQTviSXJlfqU7sZPtT+Ak
         A/IXH2KzjFh2//7C6hgLewPm1cTy0YmA8+kcWU9/dskEPrpi0EaBunYZBNk7kSo/QzW4
         Gvl9vUep7XhXWws0aspMJQiaNsO/28fOd4h/CNzF5zf/uejHCpyYzdIXyKMoQF5qbjmQ
         HBnIdMp64HiLw3mHZ2TGbFurKy/mj1loZ2QnFOaF2mUvgoKVI9rjeR71vnFx+rBJAH2a
         ULfpqOHBZPfN3nYRGTMRsF8ZKjcdR9EJG0eIoZrcK0Er00VDpUl1ZOGbSX6ftvNZf51j
         SU8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:references:from:in-reply-to
         :content-transfer-encoding;
        bh=l2BG6HpNgCzcGMYDpEFX50fU14inQtcK9NpRbVxvdh4=;
        b=DPplLnLrq6XwTUx0X7SJ6c5ITJVgx00Rml0WQ6nZ692px5e9Fzgvau3R4V8TkcowaJ
         1qAiAbnJquUsx72aoKbjt1ldNDE1QHwMGDa4n7YVpnIN1PtPyU/Y7q0s4TkI8jVUbst9
         pfHSmUoJiFNxKl+BHTYXDn5CMM4msb7fYFa9wy5xLHcSJV+IZFRO1dOcX1d0ekh5o60p
         l8EyTJrnQMtKLuhm2Am3djg6E/LnLzRp/l8r17/4wCS2fgRvtdmy/LHd8zc/YjDLwJFc
         ItoID+MDAf9keDigPkbdjtNmIOY9UP/Z3pus7o+NMa82e/EffJc89+jOZVZD+fs9yzm1
         O6BQ==
X-Gm-Message-State: AOAM533153DtyHET/vffeIxeADq8IeeMsPk0OHN/gIhMV0OkChKf1Ja4
	+Y2hKOnw0kWHZIn39Ppc45IKdQ==
X-Google-Smtp-Source: ABdhPJy61xfnpotefzndmwv5vgKuEL1OkO6vIklyRs87IS6xxfjlpuAALCEU71OXpRtxZokN9iUS8w==
X-Received: by 2002:a17:907:7f0c:: with SMTP id qf12mr2292223ejc.233.1644918889859;
        Tue, 15 Feb 2022 01:54:49 -0800 (PST)
Received: from [10.120.18.9] ([84.17.46.7])
        by smtp.gmail.com with ESMTPSA id b15sm5301226edd.60.2022.02.15.01.54.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 15 Feb 2022 01:54:49 -0800 (PST)
Message-ID: <4c67f3b3-aca9-7bc5-41b6-d6e5c9ba8ffc@tessares.net>
Date: Tue, 15 Feb 2022 10:54:49 +0100
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.1
Subject: Re: [PATCH mptcp-next v2] selftests: mptcp: add csum mib check for
 mptcp_connect
Content-Language: en-GB
To: Geliang Tang <geliang.tang@suse.com>, mptcp@lists.linux.dev
References: <068c6ecb38fae8a5c0a67097b6a8c86896a27675.1644763024.git.geliang.tang@suse.com>
From: Matthieu Baerts <matthieu.baerts@tessares.net>
In-Reply-To: <068c6ecb38fae8a5c0a67097b6a8c86896a27675.1644763024.git.geliang.tang@suse.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Geliang, Mat,

On 13/02/2022 15:38, Geliang Tang wrote:
> This patch added the data checksum error mib counters check for the
> script mptcp_connect.sh when the data checksum is enabled.
> 
> In do_transfer(), got the mib counters twice, before and after running
> the mptcp_connect commands. The latter minus the former is the actual
> number of the data checksum mib counter.
> 
> The output looks like this:
> 
> ns1 MPTCP -> ns2 (dead:beef:1::2:10007) MPTCP   (duration    86ms) [ OK ]
> ns1 MPTCP -> ns2 (10.0.2.1:10008      ) MPTCP   (duration    66ms) [ FAIL ]
> server got 1 data checksum error[s]
> 
> Fixes: 94d66ba1d8e48 ("selftests: mptcp: enable checksum in mptcp_connect.sh")
> Signed-off-by: Geliang Tang <geliang.tang@suse.com>
> ---
> v2:
>  - get mib counters twice.
>  - Closes: https://github.com/multipath-tcp/mptcp_net-next/issues/255

I added this tag in the commit message. Please tell me if it was not
fixing this issue.

Thank you for the patch and the review!

Now in our tree -- feat. for net-next but I guess it could be sent to
-net, no? -- with Mat's RvB tag:

- 8cf6b18d75cd: selftests: mptcp: add csum mib check for mptcp_connect
- Results: 7cf2ef8f7b27..49fef9d3e44a

Builds and tests are now in progress:

https://cirrus-ci.com/github/multipath-tcp/mptcp_net-next/export/20220215T095400
https://github.com/multipath-tcp/mptcp_net-next/actions/workflows/build-validation.yml?query=branch:export

Cheers,
Matt
-- 
Tessares | Belgium | Hybrid Access Solutions
www.tessares.net
