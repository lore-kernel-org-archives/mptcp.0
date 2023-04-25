Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3933E6ADC
	for <mptcp@lists.linux.dev>; Tue, 25 Apr 2023 15:27:15 +0000 (UTC)
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-2f86ee42669so5698312f8f.2
        for <mptcp@lists.linux.dev>; Tue, 25 Apr 2023 08:27:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares.net; s=google; t=1682436433; x=1685028433;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ySMyRNuOD6mxgqlJr9l+K3RFSmGCEadSRgaKRQRvzwo=;
        b=shfTaHgvVgy5/hqMk1O8CGaUPss4dEO4D+LSSNZI/JRGCM/sqvTe9QK4LwriX2a3cq
         N2LfwevmBxj5tpYnEF2hMnG/V818mbf0tpXbtL2og7l0lNXZfX3xk+U2MpUNypZLlnhg
         PYygULt0MraAl0alMqQ7hBzhtOBU7lsYQxM+IvNHvmL1g9HE52IegraSAsrbtL0/LdHe
         wDyhAtnMi+i1UfuocLZ7WS/6w4Cna0/KJice9Vpj5aJLx97lYcD1uT8KuHG2YZIdzVmL
         cyPgOux2GuM/0D4o2kZUsaHaf20kYsz4rS8VR1DkKoWfo7+htyLAeV5qGBiWNt4rT7Sd
         d+Dg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682436433; x=1685028433;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ySMyRNuOD6mxgqlJr9l+K3RFSmGCEadSRgaKRQRvzwo=;
        b=dY70PouW7JJ5WtSHfM+fh1HN0h1v5gtFd9AKuWTDRT6K2OO7Z+5Pe1eh4jrGhqHf5j
         QlLjnmsXeG4BSOp4OX36wZ3lVEn0Dj6gMn4rUA3/C1q9ik3LmWV9bZG/silt1XubdZVd
         D7mGVxS+4ydjSNPLwKDYiIrtxr/DlRafEfSEuvGpbEkVEsHzdGfF+3djuTRsZVmeLbh3
         Wx5D294LaRE9oE8SZg6OtOG6HsEOOL3ai5xrO9gWWI1jmfJtwuIHLFFu6nlgVHcGU5/x
         ty2SUbkbM23CttZSzdEZDfo7Mm11mJGnhnt16YsbqKfQhbNHDabBUaR318XzO5YvSPms
         9hRg==
X-Gm-Message-State: AAQBX9fQpxk2eoEhv45xp0eDGGqa12q+vYOG1IDfz6tpuQAeFXh6Aa1o
	rkJJzXJ/Xucn+6JfqJ3ylZmxH+0OW8FQWWnc8TZzyw==
X-Google-Smtp-Source: AKy350aMGqrz1qtfSXU2B18sBxFXILQ2DQ5GzYSYCVuM5Dfo+gEygk5LWfvXK/RuVMK6UH53AoCpxw==
X-Received: by 2002:adf:fc4f:0:b0:2f7:725d:e7b4 with SMTP id e15-20020adffc4f000000b002f7725de7b4mr11444075wrs.18.1682436433219;
        Tue, 25 Apr 2023 08:27:13 -0700 (PDT)
Received: from [10.124.6.89] ([195.181.172.155])
        by smtp.gmail.com with ESMTPSA id z2-20020a5d4c82000000b003021288a56dsm12443436wrs.115.2023.04.25.08.27.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 25 Apr 2023 08:27:12 -0700 (PDT)
Message-ID: <ff5d4cc4-62da-c53e-c490-7f38df28cad0@tessares.net>
Date: Tue, 25 Apr 2023 17:27:12 +0200
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
To: Geliang Tang <geliangtang@gmail.com>
Cc: Geliang Tang <geliang.tang@suse.com>, mptcp@lists.linux.dev
References: <cover.1681960259.git.geliang.tang@suse.com>
 <8c56e8306c829d6ca42ec34e07448fcee21b5dc4.1681960259.git.geliang.tang@suse.com>
 <2e9d011c-fd88-4ccf-e4fd-6d312cd5b527@tessares.net>
 <CA+WQbwt0=5NCt2bPqnF8ZvK2khVumZPQmx_qtUATku-RVi6Evw@mail.gmail.com>
From: Matthieu Baerts <matthieu.baerts@tessares.net>
In-Reply-To: <CA+WQbwt0=5NCt2bPqnF8ZvK2khVumZPQmx_qtUATku-RVi6Evw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi Geliang,

On 25/04/2023 09:57, Geliang Tang wrote:
> Matthieu Baerts <matthieu.baerts@tessares.net> 于2023年4月21日周五 22:15写道：
>>
>> Hi Geliang,
>>
>> On 20/04/2023 05:11, Geliang Tang wrote:
>>> Only send RM_ADDRS to remove addrs in mptcp_nl_cmd_remove(), add a new
>>> helper mptcp_pm_remove_addrs() to do this. Use mptcp_nl_cmd_sf_destroy()
>>> to delete associated subflows.
>>
>> If you need to send a new version, can you add a bit more explanations
>> to make things clear that the NL command was not supposed to delete
>> subflow but only send a RM_ADDR? I think it is important because we will
>> need to have this patch backported.
>>
>> Maybe something like this:
>>
>>   mptcp: only send RM_ADDR in nl_cmd_remove
>>
>>   The specifications from [1] about the "REMOVE" command say:
>>
>>       Announce that an address has been lost to the peer
>>
>>   It was then only supposed to send a RM_ADDR and not trying to delete
>>   associated subflows.
>>
>>   A new helper mptcp_pm_remove_addrs() is then introduced to do just
>>   that, compared to mptcp_pm_remove_addrs_and_subflows() also removing
>>   subflows.
>>
>>   To delete a subflow, the userspace daemon can use the "SUB_DESTROY"
>>   command, see mptcp_nl_cmd_sf_destroy().
>>
>>   Fixes: d9a4594edabf ("mptcp: netlink: Add MPTCP_PM_CMD_REMOVE")
>>   Link:
>> https://github.com/multipath-tcp/mptcp/blob/mptcp_v0.96/include/uapi/linux/mptcp.h
>> [1]
>>
>> WDYT?
> 
> Thanks, updated this in v9.

Thank you for the individual replies, it helps to see what has been
modified or not.

Cheers,
Matt
-- 
Tessares | Belgium | Hybrid Access Solutions
www.tessares.net
