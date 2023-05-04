Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B19D57E
	for <mptcp@lists.linux.dev>; Thu,  4 May 2023 12:46:41 +0000 (UTC)
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-2f95231618aso284333f8f.1
        for <mptcp@lists.linux.dev>; Thu, 04 May 2023 05:46:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares.net; s=google; t=1683204399; x=1685796399;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=+KVKxJ5xgl7Y9MfGCbIndCqndoFrr5aKZFzl6cPM6fQ=;
        b=hfbd8Zr7JE6n0GGsgEC2qUcrZbxWH8n7xQS1RaDBj0+psrWz5+6sokBI0dPruLtzBR
         X+zO7r/Ji2aMteAzCT4m3nCi1Z92tE4c+pZAwWBwKmHlTN0CqLn1xlnOTAmrZcCxEEVE
         eJFpKxD5Pp3Cz4Za0mqwsktlOPiTRe5tDl+i4FcRVMWUEG51ktb41tSs2AOF+DoHOA/j
         O8P3EF78xZ+Fu+D6y+5ePUQW0wQYPX5U4ZNyMH9s8cMbrPvJI/2MV43XSatxxGINeuTN
         XVrMzdQAqZqK6ieOEp3YuH2wr9ZK7B8VJVOBUK5xW50q23CK1ZEn/WDBnYnXZMXN18zv
         eHwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683204399; x=1685796399;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=+KVKxJ5xgl7Y9MfGCbIndCqndoFrr5aKZFzl6cPM6fQ=;
        b=MBx5mA6NeaXQQPJsXD3bwzjKv+TlHX6J61zzZ3lzZ+GUQTUXjdQC+OT5yASlB7bDyk
         4fN99vrENqsBkZx13udV/709X7iYyiOr4PJP5zCXXctcQ56ED5SoHEnuzRMuIJgS04tF
         dyr4DZ9UO5TR4EYeQ5KPCLXvX6zA7nq8y1sb2RhksoxXsCoFy9iuhYsZPUkXfwWxJWEC
         qBn8ky82QcW7QSEfMnqYYCErhKKCxYegEndKcdSbScNT8M/PcXXKzH/J26wySA8caB0m
         UKehP4ungC8gkane+sMCaz8nxJ4Hs9ISGrp6ziuKrtZQyZ8CFnZAAgOom/92z0OZtlOG
         1olw==
X-Gm-Message-State: AC+VfDxumvYPK/yqy8KozriDRKaTvl9EeoLehAnGDGOChxAHpSOzTswz
	LBuGKz88SR3i5Ncbt+UHhAS6qEWiRV76EmR4r+I=
X-Google-Smtp-Source: ACHHUZ4FGIfU0tysoSXex6esBda4Q7deQryxfMMzbJNfG4ys77W+mCJBLzGE/xtKg6/XbBf/ciVjAA==
X-Received: by 2002:adf:e78e:0:b0:306:4544:ca3e with SMTP id n14-20020adfe78e000000b003064544ca3emr2584838wrm.19.1683204399599;
        Thu, 04 May 2023 05:46:39 -0700 (PDT)
Received: from ?IPV6:2a02:578:8593:1200:6b04:8b76:7dd3:7b25? ([2a02:578:8593:1200:6b04:8b76:7dd3:7b25])
        by smtp.gmail.com with ESMTPSA id z2-20020a5d4c82000000b003021288a56dsm35926187wrs.115.2023.05.04.05.46.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 04 May 2023 05:46:39 -0700 (PDT)
Message-ID: <dc9d2d8b-abd3-f276-ac0e-2e8e13241382@tessares.net>
Date: Thu, 4 May 2023 14:46:38 +0200
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH mptcp-next v11 06/12] mptcp: update userspace pm infos
Content-Language: en-GB
To: Geliang Tang <geliang.tang@suse.com>, mptcp@lists.linux.dev
References: <cover.1683195386.git.geliang.tang@suse.com>
 <0356f03ca8d7e6655914e26502308414d27d3ae5.1683195386.git.geliang.tang@suse.com>
 <20230504105924.GB17540@bogon>
From: Matthieu Baerts <matthieu.baerts@tessares.net>
In-Reply-To: <20230504105924.GB17540@bogon>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Geliang,

On 04/05/2023 12:59, Geliang Tang wrote:
> On Thu, May 04, 2023 at 06:20:11PM +0800, Geliang Tang wrote:
>> Increase pm subflows counter on both server side and client side when
>> userspace pm creates a new subflow, and decrease the counter when it
>> closes a subflow.
>>
>> Increase add_addr_signaled counter in mptcp_nl_cmd_announce() when the
>> address is announced by userspace PM.
>>
>> This modification is similar to how the in-kernel PM is updating the
>> counter: when additional subflows are created/removed.
>>
>> Fixes: 9ab4807c84a4 ("mptcp: netlink: Add MPTCP_PM_CMD_ANNOUNCE")
>> Fixes: 702c2f646d42 ("mptcp: netlink: allow userspace-driven subflow establishment")
>> Closes: https://github.com/multipath-tcp/mptcp_net-next/issues/329
> 
> And CI reported a warning here, should use 'Link:' instead of 'Closes'.

You can ignore this warning, there is a "fix" for that that recently
landed in Linus tree, we just need to wait for the net tree to sync with
it to get it ;-)

Cheers,
Matt
-- 
Tessares | Belgium | Hybrid Access Solutions
www.tessares.net
