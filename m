Received: from mail-yw1-f179.google.com (mail-yw1-f179.google.com [209.85.128.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F04C7C
	for <mptcp@lists.linux.dev>; Wed, 25 May 2022 11:25:03 +0000 (UTC)
Received: by mail-yw1-f179.google.com with SMTP id 00721157ae682-2ec42eae76bso211015217b3.10
        for <mptcp@lists.linux.dev>; Wed, 25 May 2022 04:25:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=/GXoQHy0PEjhqY2GUpV4MQz6HKWDEx+WL3YMQje/D9o=;
        b=NroNCjhTp4oFT3JJGFwMCAG2iKugB66YWcTwRI+cFOvubJiImHK7GvBYrM3ZOEtLok
         dcUyPjhY4Zqmaz76gj1kpYElAaSNCvH1Z9rtgTxXblFoSiPRjr67Sf0cwLiFvHgxEp5r
         S1ED69ahJXCiS1wCJjE2FeUgakNNohrjSoYKgVgwzLnxeRX/SIeM1iLWN2rog6S62XJd
         bThuoLG6mbAknXnJOQbaLq+dhe4JY/c5qlnKbmRuGNaH3klnhvIq92NmkTPcKtLrs4fS
         kTQim3AoLQ1lFUwYTj9G9QhVy3j00X54Bv//up1f9MQRsNPOybtKZAeRk0SCKdzC4qZN
         tQQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=/GXoQHy0PEjhqY2GUpV4MQz6HKWDEx+WL3YMQje/D9o=;
        b=l/GoZZrUDnwzKrdqkFRHDn0xZT2tTNe2zOZwJ7f1ZrVCYdd6kHoprXUxr34Z8TR9IW
         SEAzVKz/+VRU77RvXq2sqgEmvqIAe1rjfjuKruv8dJCZV4UI9t6gl0Zx+J5c8ml9zhAU
         fD1jUI3IAeVyWCOaSYz7G+xOxDf+8i6ODqN0hj3Pfw/QiLvCXJKuEHPUA/NDCzaQW/hc
         goUAARj4QNwEK/wF+FY6MANSEnXpCXdXcIXi9KicYZUhw8qcJ0umNqC8mpNxphaTvxt2
         aWCZwqWTa9QrcLMG5CrSvAxFaknBgfGFcBbGG54XOn+eXaAN13umDvKa68X/727807iG
         EOiA==
X-Gm-Message-State: AOAM530PolWXbBuj/nBCqkiOY7vYb0VOq5m5ofj30HFJ0g0o7jx7Hr5p
	dOoed6BLuhvOivhrz1MJQMHeMpQ9Vi+PobGMece34g==
X-Google-Smtp-Source: ABdhPJy3B8YBFWbFTvruDuhHSK2AX+kyBtPnKQY9RWjJj2TYRKqmxXqGd2KB6d4c5JAlDAQrH1cPJUkvXiIG4q18LPc=
X-Received: by 2002:a81:2f8c:0:b0:2fe:ed42:21ca with SMTP id
 v134-20020a812f8c000000b002feed4221camr32366972ywv.120.1653477902081; Wed, 25
 May 2022 04:25:02 -0700 (PDT)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <a94be5fe-69b0-b27-5121-fafdd47bc6@linux.intel.com>
In-Reply-To: <a94be5fe-69b0-b27-5121-fafdd47bc6@linux.intel.com>
From: Naresh Kamboju <naresh.kamboju@linaro.org>
Date: Wed, 25 May 2022 16:54:50 +0530
Message-ID: <CA+G9fYuYVyMFs0S7wEEvC4ZxYchEeiooKViL=chS3XuHjiWr2g@mail.gmail.com>
Subject: Re: Adding MPTCP to LKFT tests
To: Mat Martineau <mathew.j.martineau@linux.intel.com>
Cc: lkft@linaro.org, mptcp@lists.linux.dev, 
	Matthieu Baerts <matthieu.baerts@tessares.net>
Content-Type: text/plain; charset="UTF-8"

Hi Mat,

On Tue, 24 May 2022 at 23:57, Mat Martineau
<mathew.j.martineau@linux.intel.com> wrote:
>
>
> Hi Naresh -
>
> I noticed in your response to the 5.17.10-rc1 stable announcment that
> you're running much of the kselftest suite on the stable rc's.
>
> It looks like kselftest-mptcp is not part of the list, so a MPTCP
> kselftest regression was not noted. Is it something you would consider
> adding? Do your tests only run defconfigs for each platform or do you turn
> on other non-default features? MPTCP is not enabled by default.
>
>
> Some considerations:
>
> * MPTCP selftests are in tools/testing/selftests/net/mptcp/
>
> * Kconfig dependencies are documented in
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/tools/testing/selftests/net/mptcp/config
>
> * One test, mptcp_join.sh, takes a long time to run.
>
>
> Thanks for your time!

I will investigate and add MPTCP tests in LKFT test plan.

- Naresh
