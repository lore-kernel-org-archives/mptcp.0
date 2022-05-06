Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com [209.85.208.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AA302F22
	for <mptcp@lists.linux.dev>; Fri,  6 May 2022 19:11:01 +0000 (UTC)
Received: by mail-ed1-f48.google.com with SMTP id g20so9742667edw.6
        for <mptcp@lists.linux.dev>; Fri, 06 May 2022 12:11:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares-net.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=o4I6eMXY/AVbsJRPb6Pzf2wX3pVS3M6rjx6/V21dTZE=;
        b=IN+RzOwgO+uV/XogK5Z5O0KgZWmaf3ss6/uJof+rret1/UEKXdrxATHIgcj4UT8sOA
         HFEV1ec5Sxbn8CBZtu123Z3X/0aiUqDYScOocu5xFhbsNoU2UAzx6FbXJIP8LWTMJ4P1
         kH3cCehtzx4fBOxURvO/+AMvWGpvShH9fw91EMFfWMZVW+F33eZhXd6fS8dy+1+QeynP
         S+L/8umC8FtKS+GI0GYaid09fBxZByCfZtP0z1TpmhJLo3iR0M+etp89CVnp53pGnb22
         vAPG6j6Ux+jkLX4KTXBgi5lUxXXiBn0XwvZ6Rkmk/TZ51IA4hXgOehcns6aW2NVEhHb8
         O73g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=o4I6eMXY/AVbsJRPb6Pzf2wX3pVS3M6rjx6/V21dTZE=;
        b=sEXj7hVsMO4lS1a9FdrJFuoIj306eamEO0YjqohaBtRHAvPkJQR7VFNUhA5n+AkI2j
         18XuGAM+lMFLIirkF22cw1DHhvcK8ory+3vXTOteRBhcM/sfpeswOuab9/V1rUSUxz2o
         56ThDUo57g5HseT970eKW7OBEkIpta87KaL4uPmv4Jqswlx3dVkNcWECIzN+vplVVKVa
         F3CDiDkU5fHiv2RB3/RViruh9bw4RPXOzH3pal587zEFRR+CwQjek11Q2zUjnkmKwdgl
         Abiq8482JiFoWTSYbyKeUmBeYN2D2F1+U4cUG6OWJfskQXbGPOvvJE+pRdsvWiufD34u
         Nyyw==
X-Gm-Message-State: AOAM531gZvOexD3khGePVNxRL+Yi5Jp/Ea0T39IzqW3S++6+QLlw8owv
	qtx5qu7v7Mw/M1vMCwapQw1LZzLOpZkeSNTt
X-Google-Smtp-Source: ABdhPJxS3ELG9esVK/x/2hDYztRB4+/3QZTx5z7kZWvwDywIb2vKew0+jn5iGpwpiU3+WIth7RPdZg==
X-Received: by 2002:a05:6402:5113:b0:427:f443:f63e with SMTP id m19-20020a056402511300b00427f443f63emr5109806edd.317.1651864259153;
        Fri, 06 May 2022 12:10:59 -0700 (PDT)
Received: from ?IPV6:2a02:578:8593:1200:b63e:f9ca:c9c4:cf8a? ([2a02:578:8593:1200:b63e:f9ca:c9c4:cf8a])
        by smtp.gmail.com with ESMTPSA id m17-20020a509991000000b0042617ba63b9sm2534394edb.67.2022.05.06.12.10.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 06 May 2022 12:10:58 -0700 (PDT)
Message-ID: <2ff24f02-800b-d980-9019-74f214e53c56@tessares.net>
Date: Fri, 6 May 2022 21:10:57 +0200
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.0
Subject: Re: [PATCH mptcp-next] Revert "mptcp: add data lock for sk timers"
Content-Language: en-GB
To: Paolo Abeni <pabeni@redhat.com>, Geliang Tang <geliang.tang@suse.com>
Cc: mptcp@lists.linux.dev
References: <0343ae0f3f81535f20d387147ce6b8e4158cc1fc.1651770128.git.pabeni@redhat.com>
From: Matthieu Baerts <matthieu.baerts@tessares.net>
In-Reply-To: <0343ae0f3f81535f20d387147ce6b8e4158cc1fc.1651770128.git.pabeni@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Paolo, Mat,

On 05/05/2022 19:12, Paolo Abeni wrote:
> This reverts commit 4293248c6704b854bf816aa1967e433402bee11c.
> 
> Additional locks are not needed, all the touched sections
> are already under mptcp socket lock protection.

Thank you for the patch and the review!

Now in our tree (fixes for net-next) with Mat's RvB and a Fixes tag.

New patches for t/upstream:
- 2ff5e4eba944: Revert "mptcp: add data lock for sk timers"
- Results: bc6528b2b1d7..22856348dac5 (export)


Builds and tests are now in progress:

https://cirrus-ci.com/github/multipath-tcp/mptcp_net-next/export/20220506T190735
https://github.com/multipath-tcp/mptcp_net-next/actions/workflows/build-validation.yml?query=branch:export


Cheers,
Matt
-- 
Tessares | Belgium | Hybrid Access Solutions
www.tessares.net
