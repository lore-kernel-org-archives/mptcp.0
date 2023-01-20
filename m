Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17F2820FE
	for <mptcp@lists.linux.dev>; Fri, 20 Jan 2023 12:49:47 +0000 (UTC)
Received: by mail-ej1-f53.google.com with SMTP id mp20so13651070ejc.7
        for <mptcp@lists.linux.dev>; Fri, 20 Jan 2023 04:49:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares.net; s=google;
        h=content-transfer-encoding:in-reply-to:cc:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=04LZnzxx8xsriB2F0+dq3kwmueB79N0U84894k3sPZI=;
        b=FBJNzu1y19DIuNzv6K8XfS0BxThXptpJc66TU0RqWg5SYtdjIvwdTrXf9yyuQVIgMN
         Bjhv8Mh1IpTLH7LWhZZHfuMaI9yg1/cHU5KIlzeVj5+6aVih3ATZZzh2iCSOM5liXcvo
         Dh6QnZ3Ikpy8zJaRf87rGKsuDHlbOnmtwx0BCdU6YE5TKMfgyTSr35Vglp896EsNngsr
         ZJ7Neo3DERUaNmea59IFdZP5x1/4jCpw35zIa3l6x4ovZqK+0iqe9od3s3W0XHcxmphM
         mWyXfRwEfQ/stlWTl7qmKFKDtsvww3XtDTgvAPzkCEfoaqWq1UV8YvJ0CVlf3SOHIIVo
         XD6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:cc:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=04LZnzxx8xsriB2F0+dq3kwmueB79N0U84894k3sPZI=;
        b=b6//H++m2RBsMa3BICgCOz/BZdZQCvIDSahALH0qI0XaLgZFw9a2iqA0ORJNlhBgjn
         X56SuoRJFDNQtmwRo5VzNPV3tT01UT4Oe3EPhTFRNYq45/lyhDusbaa/4CpI+69Bnnhz
         1rh2cKGMjrNCymu/fpSQEjrb+mHZUhoN3c3YAVUCKQ04zDJMteLVgj8y0b7rS7I0loQ8
         PUmmBR5s+ja296L8YSYK5P1PVMWJErzgAkqJy4cSuBWtkTP/NrdqjHGRD267Wdru3ZtQ
         hMkYQS5TwwzJ5Tk9doRuIbgFRcb0JNuelcEC2/MddRiwU1QHZu+vSSCRXNvQFu4ktGxI
         07Tw==
X-Gm-Message-State: AFqh2kqFXTFZj2rsd59kcr2YNWbW1L69eQ8cQgKoPeXk1EKXodoUuyfL
	18HgvUR5qhjuH9tUxNvw/T2t+RkTMFSJdVZKjom/iA==
X-Google-Smtp-Source: AMrXdXtUbrVx/qV8D61DwOO48mQOXuWidD+kMwdJYwi08mrF1FHgQlc4mblCHBWVGQsHEcpKLqigUg==
X-Received: by 2002:a17:906:b081:b0:877:7789:765a with SMTP id x1-20020a170906b08100b008777789765amr6964604ejy.16.1674218985842;
        Fri, 20 Jan 2023 04:49:45 -0800 (PST)
Received: from [10.44.2.5] ([81.246.10.41])
        by smtp.gmail.com with ESMTPSA id j18-20020a17090623f200b007e57d6e3724sm17885432ejg.116.2023.01.20.04.49.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 20 Jan 2023 04:49:45 -0800 (PST)
Message-ID: <11554381-abc6-4d98-2002-847fca2e8adc@tessares.net>
Date: Fri, 20 Jan 2023 13:49:45 +0100
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Subject: Re: mptcpd 0.12 release plans and transition to multipath-tcp/mptcpd
 repository
Content-Language: en-GB
To: "Othman, Ossama" <ossama.othman@intel.com>
References: <DM4PR11MB5247A7BF960343BC079AAB4BF2C59@DM4PR11MB5247.namprd11.prod.outlook.com>
From: Matthieu Baerts <matthieu.baerts@tessares.net>
Cc: "mptcp@lists.linux.dev" <mptcp@lists.linux.dev>
In-Reply-To: <DM4PR11MB5247A7BF960343BC079AAB4BF2C59@DM4PR11MB5247.namprd11.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Ossama,

On 20/01/2023 03:44, Othman, Ossama wrote:
> Our current plan for transitioning the mptcpd repository to
> multipath-tcp/mptcpd includes the following:

Thank you for sharing this plan!

> * Update the owner e-mail in the CODE_OF_CONDUCT.md and SECURITY.md
>   files.
>         - The e-mail was meant to allow for private communication
>           between the mptcpd maintainers and users in the case of CoC
>           or security violations.  Is there a specific e-mail that can
>           be used?  If not, should we point to the kernel MPTCP
>           maintainers, or just drop these files?

I think we can do that for the moment.

I'm sure you did a good job and nobody will contact me for critical
issues ;-)

> * Generate the mptcpd 0.12 release.
>         - In addition to existing changes on the main development
>           branch, references to the old repository URL in the mptcpd
>           source files will be replaced with the new repository URL,
>           https://github.com/multipath-tcp/mptcpd.
>         - The release can be generated quickly, e.g., this week.
> 
> * Create the https://github.com/multipath-tcp/mptcpd repository fork,
>   timed at or soon after mptcpd 0.12 release generation.

If we cannot transfer[1] the repository, we will need to move the
issues, pull requests and wiki, not sure how (manually? close
issues/pr?). Also "watchers", "forks" (and "stars") will not be moved
but that's probably fine.

[1]
https://docs.github.com/en/repositories/creating-and-managing-repositories/transferring-a-repository

> * Update the old repository's GitHub pages
>   (https://intel.github.io/mptcpd) to point to the new repository.

I guess we will need to enable the GitHub pages support manually. But it
should not be difficult. We could eventually use mptcp.dev domain.

I guess the Github Actions will continue to run on the new repo. Maybe
we need to do something for Coveralls.io?

> 
> * Officially announce on the mailing list the mptcpd 0.12 release and
>   mptcpd's new home.
> 
> * The old intel/mptcpd repository will be no longer be used for
>   development and will be archived.

Do you think the Intel repo could have an extra commit to clearly
explain there is a new home?

Maybe:
- Removing all files except the README file where it just say to look
elsewhere?
- Having a new default branch with one commit and just the README file?
- Only replace or update (might not be very visible) the README file?
- ...

Thank you for looking at that!

Cheers,
Matt
-- 
Tessares | Belgium | Hybrid Access Solutions
www.tessares.net
