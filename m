Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C499370
	for <mptcp@lists.linux.dev>; Thu, 22 Apr 2021 08:26:03 +0000 (UTC)
Received: by mail-ej1-f52.google.com with SMTP id mh2so45931663ejb.8
        for <mptcp@lists.linux.dev>; Thu, 22 Apr 2021 01:26:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares-net.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=NuvHaSWiuiCpZ+ZN7gu7sSuwKtOQ/Znxuhg2oJhwmr0=;
        b=tGxLZFQ3Lhyhgs48qcpgb/p9NVcWOzge+bSOqtufwoF2fIKRc8Y0XUDgAK2kAzcydU
         KEu9GZouW2Sd6tA5+MEyyCxVb8GNArdX0BfIFkev2DyHRL9Kw75++b/AH5UT0h8PZROn
         6lD+8xkk4DBl6VuslJYkvzC4XxcaW5MynLFStqd3tqhuFgOjy+ZGdDo2X2KvccOFlwrp
         7RdjxGjfjTvJlRu5xj7eRB7V3ErLAwIs72jAZm2p3HN76VgajxCLJL4X+8Qbj8Z4RVwt
         DlmJRDnw5xXDeK94n9hdd4HPdFf6DzBAQ9BvWcq3B1TGUaXJGdwKdjdyT1cG3F/Zpk2L
         C56g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=NuvHaSWiuiCpZ+ZN7gu7sSuwKtOQ/Znxuhg2oJhwmr0=;
        b=Ju/u7ke8NXrZ34P58ZekiMle3LbaVzx/ILOtvMJtyEqSp9KYHx2OkPWP6dgGFckrYz
         m2DQRp+2nc2qdc8qAgocU3wHi0GvZn+5zkMoOqTsyukwilJfXqRkcbcm2B819Mg+9MVO
         Da4lhtvE0+SeAb05EM9P3JluqPjK/8HsNcwf06UmbXzqZJCl021MtnHoKdnf2wUnFGee
         3jHlDQjVCeY4+lDFBU0kJj3EYgNEaszpaHO8h6FF9iFEmXsThpEPD9vZ6yZcrMb4M6oT
         98z1OhylFJ8KIed8myCHeDk+kGuFCduAU5Emme+U8wVCulhe8zkDSpAV2mVyF2uxkApx
         5eBQ==
X-Gm-Message-State: AOAM533ac5edh1hnASSSPBNCSMcD1SFmhs5yyRHam04fCtMyxWf732En
	PqwzHWV9zcrfd2Qi4AM3KbSvmQ==
X-Google-Smtp-Source: ABdhPJzvAJxztbNgwVDm964jySJ8hg+FzU1kDawkf03BdnQrkyRuiAV/lm1uCLVjpB/XEkbVgx5Qbw==
X-Received: by 2002:a17:906:77c5:: with SMTP id m5mr2012283ejn.201.1619079962063;
        Thu, 22 Apr 2021 01:26:02 -0700 (PDT)
Received: from tsr-lap-08.nix.tessares.net ([2a02:578:85b0:e00:12ce:5892:37b1:5a39])
        by smtp.gmail.com with ESMTPSA id s8sm1421818edj.25.2021.04.22.01.26.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 22 Apr 2021 01:26:01 -0700 (PDT)
Subject: Re: [PATCH mptcp-next] Squash to: mptcp: Retransmit DATA_FIN
To: Mat Martineau <mathew.j.martineau@linux.intel.com>, mptcp@lists.linux.dev
Cc: pabeni@redhat.com
References: <20210422011251.299480-1-mathew.j.martineau@linux.intel.com>
From: Matthieu Baerts <matthieu.baerts@tessares.net>
Message-ID: <103a29fb-1012-f5ef-82f9-d01295d910bc@tessares.net>
Date: Thu, 22 Apr 2021 10:26:01 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <20210422011251.299480-1-mathew.j.martineau@linux.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit

Hi Mat,

On 22/04/2021 03:12, Mat Martineau wrote:
> Fix timer logic in __mptcp_clean_una(). Only look at DATA_FIN enable
> when snd_una and snd_nxt match to avoid bad calls to mptcp_reset_timer().
> 
> Thank you Paolo for adding the WARN_ON() to mptcp_reset_timer()!

Thank you for the squash-to patch!

Now in our tree:

- 6d3e80805071: "squashed" in "mptcp: Retransmit DATA_FIN"
- Results: fb56846176f2..b48a833e40ba

Builds and tests are now in progress:

https://cirrus-ci.com/github/multipath-tcp/mptcp_net-next/export/20210422T082529
https://github.com/multipath-tcp/mptcp_net-next/actions/workflows/build-validation.yml?query=branch:export/20210422T082529

Cheers,
Matt
-- 
Tessares | Belgium | Hybrid Access Solutions
www.tessares.net
