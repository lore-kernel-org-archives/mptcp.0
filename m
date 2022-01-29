Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com [209.85.208.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 426962C80
	for <mptcp@lists.linux.dev>; Sat, 29 Jan 2022 11:53:23 +0000 (UTC)
Received: by mail-ed1-f46.google.com with SMTP id b13so15905862edn.0
        for <mptcp@lists.linux.dev>; Sat, 29 Jan 2022 03:53:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares-net.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :references:from:in-reply-to:content-transfer-encoding;
        bh=Ji/EfThP+zVCIjXKO0c2DDbfeD6TUexym0AXpowB6F4=;
        b=twoMlnERU1DwattNWOC4yfU330GObjZoW7Oe8HNX5oE6ccY4vOU+gqnGxL71iMyD/9
         xMIctih2EWJ+UMxnE+uLfx2HQvzbQQyvxjH2lRr8bOZF8GOJfmh/aksjsjPVJza/dE7U
         AXr5SJRj8Jbz3L7nc6ktGlGoPTJk6ypbe6WDpTExxHVzaAU2+UrcO0/I2/czFYULhNqe
         Z/dzZXKWTyJmRI69xLS4k2G3wnywYCq+J5QBJv/azjnYOl9tWc914XkHt3oLDqiTJyOW
         qHJPehIJqA3sKErE4lai+0phFe41VcNYO1heE0v3Xn0BrGZ0nwQ3SOUvGzP0tzViu5aK
         7/ug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:references:from:in-reply-to
         :content-transfer-encoding;
        bh=Ji/EfThP+zVCIjXKO0c2DDbfeD6TUexym0AXpowB6F4=;
        b=vh3UA4LYNpKL9U6jITRRAD1u3wmMvdK9O5mvqXSrZDnsqE0uhW3H4TsUTmV23gyy1/
         rYOKvug0t52N0JAkWnFq1jdhM79s4oVe6TtwMwlv8kIF4H4tvWP1xlHgTr1w1Mvoeu5c
         FiYeWuFpd4vfAXLd2cLJ9eFvkOUmE1vQnyEPfEczLjspYADGPzJPuKS2xaiciP+6kOPD
         WedghGnRRGj8VmIcbt19+qzlq3p/nJIDgxKUyqmzVoDzkFelUBg3d5h9ND+JgVjpGaMD
         b+3pDdLUIJi2yh4CmKXMyQhl3I46Nwk+K3+u08Mcv2UnRdRCYAfwrHf4hvPAkMIEeS6i
         7FyQ==
X-Gm-Message-State: AOAM531pMtqv4tQ/NAukiy+4pGK3oQe1MUFVQItfZNRBfGAwJsZyZRmb
	9M+v7+x8Uc8+1bJK+q9xlK1vTx35lKjWvA==
X-Google-Smtp-Source: ABdhPJyD+LGVDywg5F/WQSZeF7ECFwKbfb8A4dP1QWhG/9avsBJLjXun9jgDwKFTSYec6yxN+1BeKw==
X-Received: by 2002:a05:6402:520b:: with SMTP id s11mr12424274edd.365.1643457201525;
        Sat, 29 Jan 2022 03:53:21 -0800 (PST)
Received: from ?IPV6:2a02:578:8593:1200:aba3:53e3:9ad4:e385? ([2a02:578:8593:1200:aba3:53e3:9ad4:e385])
        by smtp.gmail.com with ESMTPSA id ec7sm14477410edb.62.2022.01.29.03.53.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 29 Jan 2022 03:53:21 -0800 (PST)
Message-ID: <25250bc9-015e-df2a-582d-5b5dd3eabdcb@tessares.net>
Date: Sat, 29 Jan 2022 12:53:20 +0100
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.1
Subject: Re: [PATCH mptcp-next] mptcp: use nla_parse_nested
Content-Language: en-GB
To: Geliang Tang <geliang.tang@suse.com>, mptcp@lists.linux.dev
References: <022caed0c9e5964f525336aced8233338c29386f.1643437533.git.geliang.tang@suse.com>
From: Matthieu Baerts <matthieu.baerts@tessares.net>
In-Reply-To: <022caed0c9e5964f525336aced8233338c29386f.1643437533.git.geliang.tang@suse.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Geliang,

On 29/01/2022 07:26, Geliang Tang wrote:
> NLA_F_NESTED has been used in both 'pm_nl_ctl' and 'ip mptcp'.

Was it always the case for 'ip mptcp'? I mean, we cannot break the user API.

And even if it was always the case for 'ip mptcp', there could be other
tools not using NLA_F_NESTED. Maybe we can ignore them in this specific
case but I'm not sure.

Cheers,
Matt

> So we can
> use the strict mode parsing function nla_parse_nested() instead of the
> deprecated one nla_parse_nested_deprecated().

-- 
Tessares | Belgium | Hybrid Access Solutions
www.tessares.net
