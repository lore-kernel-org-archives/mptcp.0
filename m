Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com [209.85.208.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A36C23C05
	for <mptcp@lists.linux.dev>; Fri, 21 Apr 2023 14:15:24 +0000 (UTC)
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-5050491cb04so2532675a12.0
        for <mptcp@lists.linux.dev>; Fri, 21 Apr 2023 07:15:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares.net; s=google; t=1682086523; x=1684678523;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=+Cd/uVQDdtf7JUKlALaDmoSf3jtQRlN4mL6CP/3aSnA=;
        b=M1ppE5+0FOfQsrvHd0+oApcYvfQY4Nq0sYJxjMYNOY5XdOz2QmNNRa3ZSZm7eR79sY
         MTUu3am7oJ7kbdYkNdBrwJ0boDTPQq2/BTrmtX/apDZoz0bn9byXXwipvUAyBq4CJj0Q
         pOy4M/YuqOr3CGbDoHlpa08cKt3kdqiDw4tdX5YVJHfUpGAVl8TozRddx5qckUOIwAan
         oR0dWfkLK24cg5Es6l7ap+o8DwHL6pExcYA8uny6pendyaQoljqWRmabHQS+aES8VKE4
         qHI+6imNbXLk8pBMlopd8atVxTfdk8PmD1nmcBPFPZ+8nDHSUIxpN/X6DSPT4OKiSb7y
         T05g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682086523; x=1684678523;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=+Cd/uVQDdtf7JUKlALaDmoSf3jtQRlN4mL6CP/3aSnA=;
        b=NoU3q59tFxPPkdIUueThZGkDCYKffTudcCiCvD+cfipDJpLTRjR5RF0y5dJ/WN1UVV
         +FZ2aG7YProbfqkLsS9T3X4U1JdJfkp8/IWYcVWhFMtSPEgaE82pdSAkdiXk0lYgqMCY
         euVnI08wdJl5V4ySerKagZX/9iLX95kHqBvntXwIpEF3/Nm5DUkx0pkybUnPi0sK2E4v
         mzgkIIJWuNrFqZ1q1puau+nsZnWiOvqHQFZw4eB9BN9MTH4rLQ7u8gj6JgXSagYBc6D0
         BrEijCKyPUHPqUVg0fSVrJWUNTdIxuB7D8Hk26VARFUAPOVULEWkWNPgxs5e+TCNAPEf
         h0Bg==
X-Gm-Message-State: AAQBX9fTiZZB+pTXoHfZNGW+3CBrJpYsJORglxoOMG/WVZIfDBRnjy2L
	3V76byJKguvxDBz/WrtAvGbLsgTwJi1h6mAGqaY6Kw==
X-Google-Smtp-Source: AKy350YFs8aXrDos/CAxz0UD/n3dl5y9W7uSFyGmWEoSKmifrX+yEvyGPUwEkm9e/6rmWnytgC82wQ==
X-Received: by 2002:aa7:d887:0:b0:4fa:4a27:adba with SMTP id u7-20020aa7d887000000b004fa4a27adbamr5464933edq.22.1682086522689;
        Fri, 21 Apr 2023 07:15:22 -0700 (PDT)
Received: from [10.44.2.5] (84-199-106-91.ifiber.telenet-ops.be. [84.199.106.91])
        by smtp.gmail.com with ESMTPSA id l11-20020aa7d94b000000b005084014ae2bsm1880138eds.45.2023.04.21.07.15.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 21 Apr 2023 07:15:22 -0700 (PDT)
Message-ID: <2e9d011c-fd88-4ccf-e4fd-6d312cd5b527@tessares.net>
Date: Fri, 21 Apr 2023 16:15:22 +0200
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH mptcp-next v8 1/5] mptcp: only remove addrs in
 nl_cmd_remove
Content-Language: en-GB
To: Geliang Tang <geliang.tang@suse.com>, mptcp@lists.linux.dev
References: <cover.1681960259.git.geliang.tang@suse.com>
 <8c56e8306c829d6ca42ec34e07448fcee21b5dc4.1681960259.git.geliang.tang@suse.com>
From: Matthieu Baerts <matthieu.baerts@tessares.net>
In-Reply-To: <8c56e8306c829d6ca42ec34e07448fcee21b5dc4.1681960259.git.geliang.tang@suse.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Geliang,

On 20/04/2023 05:11, Geliang Tang wrote:
> Only send RM_ADDRS to remove addrs in mptcp_nl_cmd_remove(), add a new
> helper mptcp_pm_remove_addrs() to do this. Use mptcp_nl_cmd_sf_destroy()
> to delete associated subflows.

If you need to send a new version, can you add a bit more explanations
to make things clear that the NL command was not supposed to delete
subflow but only send a RM_ADDR? I think it is important because we will
need to have this patch backported.

Maybe something like this:

  mptcp: only send RM_ADDR in nl_cmd_remove

  The specifications from [1] about the "REMOVE" command say:

      Announce that an address has been lost to the peer

  It was then only supposed to send a RM_ADDR and not trying to delete
  associated subflows.

  A new helper mptcp_pm_remove_addrs() is then introduced to do just
  that, compared to mptcp_pm_remove_addrs_and_subflows() also removing
  subflows.

  To delete a subflow, the userspace daemon can use the "SUB_DESTROY"
  command, see mptcp_nl_cmd_sf_destroy().

  Fixes: d9a4594edabf ("mptcp: netlink: Add MPTCP_PM_CMD_REMOVE")
  Link:
https://github.com/multipath-tcp/mptcp/blob/mptcp_v0.96/include/uapi/linux/mptcp.h
[1]

WDYT?

> Fixes: 9ab4807c84a4 ("mptcp: netlink: Add MPTCP_PM_CMD_ANNOUNCE")

Oops, I gave you the wrong sha, it should be:

Fixes: d9a4594edabf ("mptcp: netlink: Add MPTCP_PM_CMD_REMOVE")

Cheers,
Matt
-- 
Tessares | Belgium | Hybrid Access Solutions
www.tessares.net
