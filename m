Received: from mail-qt1-f180.google.com (mail-qt1-f180.google.com [209.85.160.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29EA77C
	for <mptcp@lists.linux.dev>; Fri, 25 Feb 2022 00:28:47 +0000 (UTC)
Received: by mail-qt1-f180.google.com with SMTP id z15so1101273qtx.13
        for <mptcp@lists.linux.dev>; Thu, 24 Feb 2022 16:28:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:reply-to:in-reply-to:references:subject:message-id
         :content-transfer-encoding:date:mime-version;
        bh=oS+MFIk0wusU7AyNxOXnelO+AGBk8JJWNsM4sNGMZQ4=;
        b=ToRf/3Yc8OvHBWTb7hZcKjjxbJinZILGGp2ckN4a2N7JJPzSBf3cJP14jMqDFblD6W
         gWnjiKSuIKWmu/TwQ4bmzQdKkuC9/e18jv/pGUfYv/QQZ4AvfU8hZARyRC/1agghUjBP
         UXVuVqKb2vflWqFCf51jrodbNX88hV6jh8DG3POd6YJnI70vTmdND2C/gZ1H1kF4Inep
         wrHwEv6tjHr0WG36z+yhsgjjrEA3WBqPmTQSgO6/JZH6OSmADhM8TRrNq5v0JiRu6USb
         zFT3NgZoFAbMm2GoI/n8zAQgPpbLx6fnpSCgZWst7XkjvyVhtFBwjucP1S2rcyudlo6l
         IWjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:reply-to:in-reply-to:references
         :subject:message-id:content-transfer-encoding:date:mime-version;
        bh=oS+MFIk0wusU7AyNxOXnelO+AGBk8JJWNsM4sNGMZQ4=;
        b=SFCJf56O2HIsHtCpoVj7z7k8d+WQDsuS3Ye+hqqa24504RKzTvPX4c84I6n0x5TvvE
         +cHu2G+KbRh/JGpW9c+r6C8wtWCnAG0xz9chltKx/hlLZqA1LjfoficauEWT5Q2MEH9P
         Rlqhamlcd74Y3SOeCgJQmQKlWNotM90jfMWLKDz/dYGJ3+JHNEr5gi7N5xtO7+QZS3no
         xsYncbxmFNYf80M7F8rscb3eKwcUfgohhxqepfQSGZ7Ke/tX7LoUUBiT9q5wlKiiELX5
         hRPqj6SrArEsQmFAH1PKhstjzMGUa1XcuG9/WmI2pLjARPeviFuTjME8/a6hhj9KNFXF
         k7bg==
X-Gm-Message-State: AOAM531WlqGp3vuO+Q9aPRfZQtDPVD9xls+2ph/LWEOfB3eiDmiDkLrk
	RX32BmP7LWuimm4heXNG5Q==
X-Google-Smtp-Source: ABdhPJx5mhiob5uHtz7BWSgimIR8kElatPZ5XEtmKl9C/VWrJkWVyGjLqeQghjTv+GiWqgvrc1rS7Q==
X-Received: by 2002:ac8:5994:0:b0:2cd:cc5d:9b6a with SMTP id e20-20020ac85994000000b002cdcc5d9b6amr4818125qte.609.1645748927010;
        Thu, 24 Feb 2022 16:28:47 -0800 (PST)
Received: from [127.0.0.1] ([20.124.10.202])
        by smtp.gmail.com with ESMTPSA id l6-20020ac87246000000b002dcec453e42sm485396qtp.32.2022.02.24.16.28.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Feb 2022 16:28:46 -0800 (PST)
Content-Type: text/plain; charset=utf-8
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Geliang Tang <geliang.tang@suse.com>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To:
 <87d043bc528d81560d964f3536fb549d3ae75a8c.1645744986.git.geliang.tang@suse.com>
References:
 <87d043bc528d81560d964f3536fb549d3ae75a8c.1645744986.git.geliang.tang@suse.com>
Subject: Re: selftests: mptcp: drop msg argument of chk_csum_nr: Tests
 Results
Message-ID: <740488f4-98f1-8a0e-5dac-e8fda96fe4c3@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Fri, 25 Feb 2022 00:28:46 +0000
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0

Hi Geliang,

Thank you for your modifications, that's great!

Our CI did some validations and here is its report:

- KVM Validation: normal:
  - Success! =E2=9C=85:
  - Task: =
https://cirrus-ci.com/task/6662034354864128
  - Summary: https://api.=
cirrus-ci.com/v1/artifact/task/6662034354864128/summary/summary.txt

- KVM Validation: debug:
  - Success! =E2=9C=85:
  - Task: =
https://cirrus-ci.com/task/4621340773711872
  - Summary: https://api.=
cirrus-ci.com/v1/artifact/task/4621340773711872/summary/summary.txt

Initiator: Patchew Applier
Commits: https://github.com/multipath-tcp/mptcp_=
net-next/commits/921ba5ecdf6d

Please note that despite all the efforts =
that have been already done to have a
stable tests suite when executed on a=
 public CI like here, it is possible some
reported issues are not due to =
your modifications. Still, do not hesitate to
help us improve that ;-)

Cheers,
MPTCP GH Action bot
Bot operated by Matthieu Baerts =
(Tessares)
