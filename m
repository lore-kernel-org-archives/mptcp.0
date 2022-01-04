Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com [209.85.208.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F98F2C80
	for <mptcp@lists.linux.dev>; Tue,  4 Jan 2022 16:47:38 +0000 (UTC)
Received: by mail-ed1-f51.google.com with SMTP id m21so152013727edc.0
        for <mptcp@lists.linux.dev>; Tue, 04 Jan 2022 08:47:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares-net.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :references:from:in-reply-to:content-transfer-encoding;
        bh=9ymIO1NWiED1L3EhmNBWvXzV3C30YG3vvRPM4Gt6ssQ=;
        b=BIlgVoRsEZFgf7RqQvtt6dzZetN83Og+DkR7/Yh6a0clxD7nMg3KUmV6iki+IyEUbV
         JHPLsujID0CegzrPsW7asCDFWtbjeHD7V3moubwz0Jvhut0Dqel20XXcOC7XP5NVzemJ
         ZvoshjgEkSwKR4Hi/JepaWEXlHiI8jr2j1e56HKpJvVl/bBTE47Ywfqbdc3iI7fkdFY1
         Up7Zz6krZ0O139G4ufRGrBJEKCkr6w6PNnTa/n7LnNYyKSI0IWbwXCDNYBi0Eei156Ec
         RPbq9gRino4IcuV+nH8ntOgbGAp5mmboS5HSMW4LawrAGmI+k3yk97UM766feHxr3gsW
         F50g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:references:from:in-reply-to
         :content-transfer-encoding;
        bh=9ymIO1NWiED1L3EhmNBWvXzV3C30YG3vvRPM4Gt6ssQ=;
        b=m9NIRW2Yp/olKiAtvS35DL2+ETvSp4tNAgikDqsMUdacL0kPQPagB449AcD2FyNuLh
         MtyhKO9+s2WgVvyhWObvjT2oTp3CRjIrmHeGv+D4lmw/42NVe2P/MyrZIQnZenSMja3n
         Xd4URs+I566I1tLa+CE831/bMF3JMv9tJ2HDT1XGia6zDoV/LXfsf70CdKpKr6zDzTaN
         PxxBnNWqQZCAZ/qfvqS4NkXiU2ZCtubUy2WkUwrh7eI+23nA82oX6F/mNcUeDQMaUQBk
         xfBoTbJdnU8DaTELnB4bYR0CpMGpcGyNoao8s2qrRLEgS/cNctX8ZziVPOXWQyfGxcXa
         4RIw==
X-Gm-Message-State: AOAM532oHIgoc6q+W/wgJvXteoxX2ae3W6G1CfHM027RNKj90ewKrwgP
	B37f5HXM55kW4Aw/P9U3AQR7TQ==
X-Google-Smtp-Source: ABdhPJwMm2hO04t5eo8OeeeRbOYSvlRSxI/DNwU2hTUhaYu59GR/yNfzavMzsEg3oP7L4MsxW9w27A==
X-Received: by 2002:aa7:d6d6:: with SMTP id x22mr49776124edr.132.1641314856864;
        Tue, 04 Jan 2022 08:47:36 -0800 (PST)
Received: from ?IPV6:2a02:578:8593:1200:eb62:5355:d611:125? ([2a02:578:8593:1200:eb62:5355:d611:125])
        by smtp.gmail.com with ESMTPSA id sc7sm11640526ejc.87.2022.01.04.08.47.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 04 Jan 2022 08:47:36 -0800 (PST)
Message-ID: <1982663a-58a4-fad0-8f6f-71ad3cd761bb@tessares.net>
Date: Tue, 4 Jan 2022 17:47:35 +0100
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.0
Subject: Re: [PATCH mptcp-next 0/4] use 'ip mptcp' in selftests
Content-Language: en-GB
To: Geliang Tang <geliang.tang@suse.com>, mptcp@lists.linux.dev
References: <cover.1641290905.git.geliang.tang@suse.com>
From: Matthieu Baerts <matthieu.baerts@tessares.net>
In-Reply-To: <cover.1641290905.git.geliang.tang@suse.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Geliang,

On 04/01/2022 11:11, Geliang Tang wrote:
> This patchset replaced all the pm_nl_ctl commands in selftests with the
> 'ip mptcp' commands.

Thank you for looking at that, that's a good idea!

I see that you are using features that are not in iproute2 yet. This
depends on your "more patches from pm_nl_ctl" series, right?

We can easily modify the environment of our CI but not the other ones.
To continue having these other CIs validating MPTCP selftests, I think
we should do two things:

- check IPRoute2 version and skip the tests with a clear message if a
too old version is used. I guess these CI uses at least the last stable
version of IPRoute2.

- wait for patches to be at least in "iproute2-next" before applying
patches in our "export" branch: it means we can already apply the
modifications that doesn't needs your patches for iproute2.

(if it helps, we can also have an mptcp-iproute2-next repo, e.g. if we
see we have too many IPRoute2 patches waiting to be applied upstream)

WDYT?

Cheers,
Matt
-- 
Tessares | Belgium | Hybrid Access Solutions
www.tessares.net
