Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com [209.85.208.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 065912C80
	for <mptcp@lists.linux.dev>; Thu, 21 Oct 2021 10:09:54 +0000 (UTC)
Received: by mail-ed1-f51.google.com with SMTP id ec8so201516edb.6
        for <mptcp@lists.linux.dev>; Thu, 21 Oct 2021 03:09:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares-net.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :references:from:in-reply-to:content-transfer-encoding;
        bh=Ytel+IDGnDrCTzgvqSH4OKUGaaRZoJYl0wfLprtEpmg=;
        b=zJx4BYruk62e2yAEudv22npK54R+GnSwbxWmDdVOSphg3zV/VnbwNlH+s8ilV4U7fV
         OOnOenXRRnnTYcJd28Ofxyi3JFHUO0poTjQlJ7UUInsIWjCux4h0/0Po94ZkzUMpjMt0
         1ODJf/G70IfwDYg01KBYF/sGQsqX0pTN9omCCtkW5diXLu8hybA0u4AhHrCVTZJKwqj8
         48M8VkhUnWUwvYNswShHDzhAd7gd1ovO+8vorSXTnbBUAJrT9rvhrlhTR8UP5sPhral9
         YLWluBgdU55yC7bucU0XTCK8MUMc33tFHnYJBBDbKL2NQe77Qorhr2UKnnFSI5v4pWyJ
         F/6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:references:from:in-reply-to
         :content-transfer-encoding;
        bh=Ytel+IDGnDrCTzgvqSH4OKUGaaRZoJYl0wfLprtEpmg=;
        b=kLcF1IeJ+g6Gb859suhocMdWLnoOJzlsSf9ZJst2XzNefoBULN10MPmlBCMBY6ns6I
         0VO9gYc9BTUP9GDaMdMUu0JV1IM2PMMpFbLuU0IDNNHOhMpmRDGzkMxeC37lRGvffyee
         tTGitsTw51O1Q76/lY7waLfmu1Xv5yyWpjPTnV+4JTh5oUKvVfrH64wWmiHeM5yp2UIg
         WJ+M5N6rqJ2kNIzLaIjwkoUs/3+/CY4VzPNV0OJlnwaxecYg4B2PaSaiZClalfFVAXxS
         ugm4hfVlKeHg8oiCg1GoM19dDovYuRKBIZ+DymvnwRha4OOGmJr2xNOo7KNNb96KdetI
         0ZuQ==
X-Gm-Message-State: AOAM530sXwudj4mkp+sTtvQUC4aBrAzaLZUELbX14JAGM7+Ut/W+t0XY
	2wfJUB7Oigcb8LmpXbqZqLUghQn+xzFSwORrzTw=
X-Google-Smtp-Source: ABdhPJyY8LcV6B+h+c0JCoQ29Kc3RBgRMq5AtyDCqVibvfsztSCYLi8Lxq18rlDm7/OQjX57AY7p+g==
X-Received: by 2002:a17:907:7f24:: with SMTP id qf36mr6362591ejc.491.1634810993202;
        Thu, 21 Oct 2021 03:09:53 -0700 (PDT)
Received: from [10.44.1.26] ([81.246.10.41])
        by smtp.gmail.com with ESMTPSA id m3sm2925844edc.11.2021.10.21.03.09.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 21 Oct 2021 03:09:52 -0700 (PDT)
Message-ID: <37b6a602-6308-443d-de65-d7d27c2c70dd@tessares.net>
Date: Thu, 21 Oct 2021 12:09:52 +0200
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.1.2
Subject: Re: [PATCH mptcp-next] selftests: mptcp: fix proto type in
 link_failure tests
Content-Language: en-GB
To: Geliang Tang <geliang.tang@suse.com>, mptcp@lists.linux.dev
References: <73206a1932f3f6baab8cfe5bf210fb6fe4cc06cc.1634809754.git.geliang.tang@suse.com>
From: Matthieu Baerts <matthieu.baerts@tessares.net>
In-Reply-To: <73206a1932f3f6baab8cfe5bf210fb6fe4cc06cc.1634809754.git.geliang.tang@suse.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Geliang,

On 21/10/2021 11:51, Geliang Tang wrote:
> In listener_ns, we should pass srv_proto argument to mptcp_connect command,
> not cl_proto.
> 
> Fixes: 7d1e6f1639044 ("selftests: mptcp: add testcase for active-back")
> Signed-off-by: Geliang Tang <geliang.tang@suse.com>

Good catch!

Now in our tree (fix for -net) with my RvB tag:

- 17e467e6b4e3: selftests: mptcp: fix proto type in link_failure tests
- Results: 27b3739429a3..258d7013ee60

Builds and tests are now in progress:

https://cirrus-ci.com/github/multipath-tcp/mptcp_net-next/export/20211021T100936
https://github.com/multipath-tcp/mptcp_net-next/actions/workflows/build-validation.yml?query=branch:export/20211021T100936

Cheers,
Matt
-- 
Tessares | Belgium | Hybrid Access Solutions
www.tessares.net
