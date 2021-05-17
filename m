Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com [209.85.208.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 669F12FB6
	for <mptcp@lists.linux.dev>; Mon, 17 May 2021 19:16:02 +0000 (UTC)
Received: by mail-ed1-f46.google.com with SMTP id t15so8193099edr.11
        for <mptcp@lists.linux.dev>; Mon, 17 May 2021 12:16:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares-net.20150623.gappssmtp.com; s=20150623;
        h=subject:to:references:cc:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=P+/Zest2f1CUpBP7uWLgUY0jv05Inq9DCsteNNXm2Ck=;
        b=PRz4gqhZlB4m2op2o7Q43y5ozNzM1YOvjLa8v47abgPWeAbrc2TXHZXU21BLbd6My4
         aZed6BWPLBsMGTS3IKDsLsAUHWK41MYVc34d3UGxKV1pbt1046w1FODAlZSxCMD6CCsB
         uk7yKS1McrZrnFGp5Mmls/6gsgwmQKaHW8ITH1PWzr89DWdidAn9fDqMTnzmojojQ0tW
         xYKH77nMO8cqn0YNkV3GbGboz1C0ipTy7DhHqhMoRYYo0eQ0vitLHfg12c8zhSpkghPz
         ItvuANYBTQUNnUCVKvpeF41Jgx1AA62TsR9Rqf2lIX/FO4t+aKO7/lMHpXPLq8ah5p6u
         T8WA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:cc:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=P+/Zest2f1CUpBP7uWLgUY0jv05Inq9DCsteNNXm2Ck=;
        b=DHf++XVyfDYAvKWv4NzARLvDwmo6QdVsyLjP+Mduhsg258zFlhgTvSV/4JhxxlqaT2
         pJ9BtBSKSB2dXWeoVQynWtDToKaRNviRDTIDWhOAY7M5lTMk0VwyD2GA7UYdlwBYEYh6
         p6Cwz6oaZL66EUr00u1qKpFH8IflkxqzP3vAdKnMmehzQH6AKx++v4OUqMSttiZqAbMl
         /m3XYfPlGNhlEz8DZqzJgwBBJc7qPTPhrh6DdNzqQfuC2gI7eBTcQRrfysTy9M6pBzjv
         Z8jLK5Bp4xre9TfsesRbiIjVY+/P9sLylSKgZgFzLAEGFBINRupJNHbxonqutjxP6y8q
         /iJQ==
X-Gm-Message-State: AOAM532Dc5T2LsFrvYmnkL5PB/+rPDSa88Def4a1i01B0LnRjBlEitEB
	GTiJwgriWy0tUy3Kywn5LOoqQq9F7JT+m97u
X-Google-Smtp-Source: ABdhPJw8QoFOy8nIND7BogPi3dtFJVk8eOslDn8+VxpY0RpM7qr8BmmMANrqAE5v9VDKCt5QT+1Mog==
X-Received: by 2002:a05:6402:3098:: with SMTP id de24mr1840841edb.339.1621278960523;
        Mon, 17 May 2021 12:16:00 -0700 (PDT)
Received: from tsr-lap-08.nix.tessares.net ([2a02:578:85b0:e00:6bb4:e7e7:e1f:1ab9])
        by smtp.gmail.com with ESMTPSA id dk21sm4882151ejb.54.2021.05.17.12.15.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 17 May 2021 12:16:00 -0700 (PDT)
Subject: Re: [PATCH mptcp-net] mptcp: fix sk_forward_memory corruption under
 memory pressure
To: Paolo Abeni <pabeni@redhat.com>,
 Mat Martineau <mathew.j.martineau@linux.intel.com>
References: <b84d11a2f4c33e69637567e64138a453611064dc.1620986525.git.pabeni@redhat.com>
Cc: MPTCP Upstream <mptcp@lists.linux.dev>
From: Matthieu Baerts <matthieu.baerts@tessares.net>
Message-ID: <733cd590-f61e-8102-2f22-5c67a6b044e1@tessares.net>
Date: Mon, 17 May 2021 21:15:59 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <b84d11a2f4c33e69637567e64138a453611064dc.1620986525.git.pabeni@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit

Hi Paolo, Mat,

On 14/05/2021 12:05, Paolo Abeni wrote:
> MPTCP sk_forward_memory handling is a bit special, as such field
> is protected by the msk socket spin_lock, instead of the plain
> socket lock.
> 
> Currently we have a code path updating such field without handling
> the relevant lock:
> 
> __mptcp_retrans() -> __mptcp_clean_una_wakeup() -> __mptcp_update_wmem()
> 
> We can hit the above only under memory pressure. When that happen,
> forward memory accounting could be corrupted, as reported by Mat.
> 
> Address the issue creating a new variant of __mptcp_clean_una_wakeup()
> which handle fwd memory updates with the proper care and invoking
> such new helper in the relevant code path.
> 
> Reported-by: 'Matthieu Baerts <matthieu.baerts@tessares.net>'
> Fixes: 64b9cea7a0af ("mptcp: fix spurious retransmissions")
> Signed-off-by: Paolo Abeni <pabeni@redhat.com>

Thank you for the patch and the review!

Now in our tree with Mat's RvB tag, a small checkpatch fix, my Tested-by
tag, s/Mat/Matt/ and the Closes tag.

- e31f8077084d: mptcp: fix sk_forward_memory corruption under memory
pressure
- Results: 36a7db06660a..6273c44bc200

Builds and tests are now in progress:

https://cirrus-ci.com/github/multipath-tcp/mptcp_net-next/export/20210517T191245
https://github.com/multipath-tcp/mptcp_net-next/actions/workflows/build-validation.yml?query=branch:export/20210517T191245

Cheers,
Matt
-- 
Tessares | Belgium | Hybrid Access Solutions
www.tessares.net
