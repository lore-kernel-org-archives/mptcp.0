Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com [209.85.208.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9088A29D6
	for <mptcp@lists.linux.dev>; Thu, 22 Jul 2021 13:33:43 +0000 (UTC)
Received: by mail-ed1-f46.google.com with SMTP id h2so6838966edt.3
        for <mptcp@lists.linux.dev>; Thu, 22 Jul 2021 06:33:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares-net.20150623.gappssmtp.com; s=20150623;
        h=to:references:cc:from:subject:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=JT8yTgEs8v/Zy9cw3/izyU3XGmU0jXdDEY6mCGucd90=;
        b=ideCAsCQWR/qnfWpQ/jzLmTFFHIt3wZVgzTFDw26P6+gAFSU3K7Zwykv35YFvetm4z
         ON9z/bXCPg4cTXmxEJbEvUAhxaaXpGkVD8+Yd5mqrdN+PMXqR82jADTnLzgEF78CSYgg
         ZByM6MO/KByk6ipqqEO7oLjGCk7TRM20Xv2t0YNhL2yV2YZiIi5atdi/y9jDyfOrkjOF
         ZDsM1FTp7UX6KAhMHUkYhLPmP8Ggh9D6XhgRBGhQNYofWaoKwKTYWRFY/XBgR/W8LI33
         jSe/n2oDnzEexpJIdtkpdxaDiVRLKIb6Rcc4iZudyuDRzSVsK/GZ/ur1MSFyVdcBBgeI
         8SZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:references:cc:from:subject:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=JT8yTgEs8v/Zy9cw3/izyU3XGmU0jXdDEY6mCGucd90=;
        b=RJbviLeFndj+Y253DX71x7Vlh0AhBtdkYUtvJ1dKYEo5oO9mOhfwQL5uvxFDoyjewO
         uzJjRuV9qDLdGWtJNcBtilL3DJFk1ppXlvW0DlEV4CF2lBOjtJtLO5Hz7ANkx6htro0A
         DU0KNTGxIrxhQHWpsRfnE7/VfGapqeisqfn9n7mTi8GqfzPPiDAy4BpibLKNwyrP1V7Y
         l5OCny7wydF7RWspzwfyr/UJ4F6yZTz/DlIHJZY3RsKUpzUCItyeiMoBTMmyqF/VCCAJ
         ZwKlS2JHWYio0v+MkOXWzkD+3YduKdtuDp9hXxJJhQh/x+CgTQ84Mw0aBxIz28TvvN/u
         gaPQ==
X-Gm-Message-State: AOAM530tqGUWbcwIJ3xcsToYBsELuxKqy9VWkV0KjZEv63lmg7v4IyoK
	ybVri94J58d2sRinvs/jceCJIRDs307ZRcfQIa4=
X-Google-Smtp-Source: ABdhPJyj6WkL8EtxnuLkgN0AbhkGH9Gwo3fYHpWKzbhYQ2EEmpJNxAYyTQc6VgKBMVOKwsP9ZZFlZA==
X-Received: by 2002:aa7:d4c2:: with SMTP id t2mr45440508edr.241.1626960821906;
        Thu, 22 Jul 2021 06:33:41 -0700 (PDT)
Received: from tsr-lap-08.nix.tessares.net ([2a02:578:85b0:e00:8391:ca7f:9c1b:4236])
        by smtp.gmail.com with ESMTPSA id ch27sm12615652edb.57.2021.07.22.06.33.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 22 Jul 2021 06:33:41 -0700 (PDT)
To: Paolo Abeni <pabeni@redhat.com>, Geliang Tang <geliangtang@gmail.com>
References: <cover.1626877655.git.geliangtang@gmail.com>
 <b5f63eb4ad680a99fc806d2406968a6a5f272f01.1626877655.git.geliangtang@gmail.com>
 <0000f0168f0d8d1cd34bbe5463aed721225446e2.1626877655.git.geliangtang@gmail.com>
 <9e1a6fe0df035c74c7f9169a89a3e4de0954f040.camel@redhat.com>
Cc: mptcp@lists.linux.dev
From: Matthieu Baerts <matthieu.baerts@tessares.net>
Subject: Re: [MPTCP][PATCH v2 mptcp-next 02/10] mptcp: register ipv4 addr
 notifier
Message-ID: <e8591d78-2c73-239d-0ffe-16e028abc12c@tessares.net>
Date: Thu, 22 Jul 2021 15:33:41 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <9e1a6fe0df035c74c7f9169a89a3e4de0954f040.camel@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 8bit

Hi Geliang, Paolo,

On 21/07/2021 19:08, Paolo Abeni wrote:
> On Wed, 2021-07-21 at 22:31 +0800, Geliang Tang wrote:
>> This patch added a new file pm_fullmesh.c, and modify Makefile and
>> Kconfig to support it.
>>
>> Implemented a new function mptcp_pm_fm_init(). In it registered a ipv4
>> addr notifier, named mptcp_pm_addr4_notifier, to deal with the events
>> of net device UP, DOWN and CHANGE, and skip the loopback device.
> 
> Do we absolutely need these notifiers? can we use instead e.g.
> NetworkManager scrips to create/delete endpoints as needed ?!?

I understand it is convenient to have this code in the kernel but I
don't think it will be easy to manage all different cases: ignoring some
interfaces, specific IPs, all v6 or v4, sometimes loopback/link-local
are interesting to use, etc.

It looks like an easy job for a userspace daemon managing the
connections, no?
Is it not possible to have external hooks (shell scripts? an app with
extra rights?) with the daemon managing connections on Android?

Cheers,
Matt
-- 
Tessares | Belgium | Hybrid Access Solutions
www.tessares.net
