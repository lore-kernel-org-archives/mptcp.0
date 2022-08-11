Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 302E320E7
	for <mptcp@lists.linux.dev>; Thu, 11 Aug 2022 10:34:09 +0000 (UTC)
Received: by mail-wm1-f44.google.com with SMTP id ay39-20020a05600c1e2700b003a5503a80cfso2445542wmb.2
        for <mptcp@lists.linux.dev>; Thu, 11 Aug 2022 03:34:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares.net; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc;
        bh=CS9+i7FqXIF79504TrnFWgeO3XrAi2XYrko0upVKoyA=;
        b=zQtFbk4Z7okG5FiYM8Jwq9zyeWwS5aAtgILCgHmY9Gxxsl4V0xUxm7T7K4yY2ml40c
         tNAnhBq8ydPx3BU3c0B4/Az2TL/JBDfULQmfoXN7/hWoZOjHNNRsdfgiOityXOXK6P8S
         fMkFFK0BWRMcK4uT+F8L4uU///hp3qYvFrhUwBKvF50xd19ynO4EyJWWUeXUPOkX/cF5
         YxBmWAgAz5FNDWTb64wfT1cqE833Uunvr9GgCrYfhSnZo1sPxmJ3bUmJt3pItmKi+jAE
         8FV7yntRVC/EdF0i+9OaLBZDN0UUyuUhI9OhaJcz8fcEIBLtfKvxByclMaWO+GvNtuJ0
         c6Xw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc;
        bh=CS9+i7FqXIF79504TrnFWgeO3XrAi2XYrko0upVKoyA=;
        b=P80bhKZ3z/iSoolnPIp5P7OOO4eSgGBy7t6butkS/kmOUFNHWEO2qwH2db+PfINZmW
         YiHd2yVbO7n0qZkT9kemuljzGbew4PhPv3bSQXAUdhtj4peFe2g9Op+YyMBWj30VQzfL
         oQKM+1gD01C8suLcd8LjzoZ5W3r5Pmap4Jtp5qI8aOahqxqwkrN3Oo1lUR6tG2e6fv3W
         W9K2z6VxPaSSD8iRDgBS9Xd2P7Ue5ahg8tnEoucSiPaXQVHTlqNkRA8DvmRmTlIs1rXU
         BA5KXenv44Lv8DYTgcRu5eNh2QtJati1eBsQSNGV24FwrZ7y9rJC9gfpw0FfnYZbFSlK
         RGIw==
X-Gm-Message-State: ACgBeo1rK3cjkCdmTPlszbrCe48OVbqNGyWMI3At+pyX0hJnIwzEtzIU
	RdgQJZamE2cQKcl70Xaqdq2ZaQ==
X-Google-Smtp-Source: AA6agR6C/sq/QYPx08muFJuELrpD9lFmG8QEGrLsuAIOZacI8kFeynsWs0r+ghoHMrVfHJmhfgFT1A==
X-Received: by 2002:a05:600c:3d08:b0:3a5:726:790f with SMTP id bh8-20020a05600c3d0800b003a50726790fmr5128705wmb.98.1660214047966;
        Thu, 11 Aug 2022 03:34:07 -0700 (PDT)
Received: from [10.44.2.26] (84-199-106-91.ifiber.telenet-ops.be. [84.199.106.91])
        by smtp.gmail.com with ESMTPSA id u16-20020a5d4350000000b00223664ab3a8sm8234226wrr.90.2022.08.11.03.34.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 11 Aug 2022 03:34:07 -0700 (PDT)
Message-ID: <49976d61-c3e1-3991-37b3-4751f8a96a5c@tessares.net>
Date: Thu, 11 Aug 2022 12:34:06 +0200
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.1.0
Subject: Re: [PATCH mptcp-next v2 1/2] mptcp: allow priviledged operations
 from user namespaces
Content-Language: en-GB
To: Mat Martineau <mathew.j.martineau@linux.intel.com>,
 Thomas Haller <thaller@redhat.com>
Cc: mptcp@lists.linux.dev, Florian Westphal <fw@strlen.de>,
 Paolo Abeni <pabeni@redhat.com>
References: <e95949bf-53cf-bdf-27c8-8cbc3eeda450@linux.intel.com>
 <20220810074251.31887-1-thaller@redhat.com>
 <3af41bc6-436a-5849-b2d-9564dd8f46c7@linux.intel.com>
From: Matthieu Baerts <matthieu.baerts@tessares.net>
In-Reply-To: <3af41bc6-436a-5849-b2d-9564dd8f46c7@linux.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Thomas, Mat, Florian,

On 11/08/2022 01:08, Mat Martineau wrote:
> On Wed, 10 Aug 2022, Thomas Haller wrote:
> 
>> GENL_ADMIN_PERM checks that the user has CAP_NET_ADMIN in the initial
>> namespace by calling netlink_capable(). Instead, use GENL_UNS_ADMIN_PERM
>> which uses netlink_ns_capable(). This checks that the caller has
>> CAP_NET_ADMIN in the current user namespace.
>>
>> See also commit 4a92602aa1cd ('openvswitch: allow management from inside
>> user namespaces') which introduced this mechanism. See also commit
>> 5617c6cd6f84 ('nl80211: Allow privileged operations from user
>> namespaces'), which introduced this for nl80211.
>>
>> Signed-off-by: Thomas Haller <thaller@redhat.com>
> 
> Thanks Thomas, looks good:
> 
> Reviewed-by: Mat Martineau <mathew.j.martineau@linux.intel.com>

Thank you for the patches and the reviews!

> Florian had mentioned preferring net-next in the discussion of v1 (which
> Thomas has agreed with by labeling this for mptcp-next), and I agree. I
> don't think it quite meets the bar for -net or stable backporting and it
> would be easier to explain that "6.1 and later support user namespaces
> for MPTCP generic netlink commands". (Matthieu, if someone makes a
> convincing case for -net, it's up to you :) )

I initially thought it was more a bug-fix but I also agree with Florian.
Also I see that the two mentioned commits above don't have a Fixes tag.

The only exception I found and related to this flag was for l2tp: the
commit 2abe05234f2e ("l2tp: Allow management of tunnels and session in
user namespace") has been selected by davem and backported to v5.4.

https://lore.kernel.org/stable/20200417.105100.821338189941807731.davem@davemloft.net/
(see patch 03/19)


Anyway, your 2 patches are now in our tree (feat. for net-next) with
Mat's RvB tag and without a typo (s/priviledged/privileged/) + a small
fix for checkpatch related to how the commit are mentioned, nothing
important:


New patches for t/upstream:
- 3d542a6c45ea: mptcp: allow privileged operations from user namespaces
- 11bdb1959854: mptcp: account memory allocation in
mptcp_nl_cmd_add_addr() to user
- Results: c4a0ae952875..004104cc8a77 (export)


Tests are now in progress:





https://cirrus-ci.com/github/multipath-tcp/mptcp_net-next/export/20220811T101116


@Thomas: BTW, thank you for maintaining libnl!
Funny that you sent these patches to MPTCP while earlier this week I
sent the latest libnl version to Debian :)

https://bugs.debian.org/cgi-bin/bugreport.cgi?bug=1016867
https://tracker.debian.org/pkg/libnl3


Cheers,
Matt
-- 
Tessares | Belgium | Hybrid Access Solutions
www.tessares.net
