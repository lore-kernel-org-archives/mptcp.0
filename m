Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2AA0D2F5B
	for <mptcp@lists.linux.dev>; Wed, 17 May 2023 15:26:24 +0000 (UTC)
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-3f509ec3196so65311545e9.1
        for <mptcp@lists.linux.dev>; Wed, 17 May 2023 08:26:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares.net; s=google; t=1684337183; x=1686929183;
        h=content-transfer-encoding:in-reply-to:references:to:from
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=nlyrJvAyHwKLqqjWucwu+EqH5BTKz+x8t5gTbPwitak=;
        b=OSATE+bL4hHQ825WsglUsPMy6pbbfliAZp0K3nr45iJ8l8CwgPuy8iU+RVDOfjJ1F2
         297WBkeYOmVWVg+8c6zq6YLDlQC3wqfpwjPhKSio4TecsciR0MVfop5RXYV3CAvyrwfE
         Wk9C7xfz7g+o7zXJ1KtKKSRueOzqAYQ+tF2RtioJL2pvtLok9O5T2cOxFUi6+vk2e0ZX
         p4EAxZlCINe62RY4OxcL1KMVPGf4FtsjZLD30/xVUx/HftjQAanMr72YkU69wcUif8/I
         uEnd/8x3caifhwpZIslY5V9wVRH+ugqFHWDgbOKZkLwNIfirYk39KghEVDj2oH5e6mpK
         CRWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684337183; x=1686929183;
        h=content-transfer-encoding:in-reply-to:references:to:from
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=nlyrJvAyHwKLqqjWucwu+EqH5BTKz+x8t5gTbPwitak=;
        b=IRPI8G+bWryuT2lb3tOYAyrCvhGCqr8QpfLfIB0J5bbwQytC4xj+OgjpLLJr2qNE3+
         06kt96pXUWYEwcn2TNVmshI3C4t3d4TWoywB4hHhUAvEfAsmH1YI8+HMSeckimOvTFsv
         iFblYL5mjknWXf93CCl6e7wqQFLMqs+XBHMuFgSIpXat3sk7eKes65Km3MEhqs6/arxx
         m4e4JFQTbvRHZuW9x4T3xfghAaM1PrFo7fk67+y6oC1U40H88t5hPwBWhHQQoEpR4B5J
         ZQJK0k209IFo5pOe1I+fjM5dWl4Wu9LI1+LNaMkseQBFy3OuZ7haUQPKsP6CI1qr7nsu
         fxHw==
X-Gm-Message-State: AC+VfDx15Obt9jJRe+PTKdO3c0/wv+RZz0ICkqZNX8w0qSHKBhXPvReh
	cu4cOZqgc90PUwXV1ZQOjJgQSSVN1f5yLViPh6o=
X-Google-Smtp-Source: ACHHUZ5nAOJkz1JpGfYX+nBY9OfZbX1I0fbOVv/BF1ZX7jozhhoqtYhwyRopSGw21pPQ3WCNkX+24g==
X-Received: by 2002:a1c:ed05:0:b0:3f5:d15:854e with SMTP id l5-20020a1ced05000000b003f50d15854emr2289034wmh.15.1684337182657;
        Wed, 17 May 2023 08:26:22 -0700 (PDT)
Received: from ?IPV6:2a02:578:8593:1200:a66b:672f:3b69:b6da? ([2a02:578:8593:1200:a66b:672f:3b69:b6da])
        by smtp.gmail.com with ESMTPSA id y20-20020a05600c365400b003f42bb3a5adsm2668100wmq.4.2023.05.17.08.26.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 17 May 2023 08:26:22 -0700 (PDT)
Message-ID: <18d85b02-649d-7e6f-66ed-cfccc1b8a0a5@tessares.net>
Date: Wed, 17 May 2023 17:26:21 +0200
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH mptcp-next v11 04/12] mptcp: add addr into userspace pm
 list
Content-Language: en-GB
From: Matthieu Baerts <matthieu.baerts@tessares.net>
To: Geliang Tang <geliang.tang@suse.com>, mptcp@lists.linux.dev
References: <cover.1683195386.git.geliang.tang@suse.com>
 <4ec2d013559dce53d222e9cbd53c45a4b4d5ba12.1683195386.git.geliang.tang@suse.com>
 <54773621-db9d-b7fd-f4ce-9ff470513668@tessares.net>
In-Reply-To: <54773621-db9d-b7fd-f4ce-9ff470513668@tessares.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Geliang,

Sorry for the delay to review this series (due to some holidays).

On 04/05/2023 16:59, Matthieu Baerts wrote:
> Hi Geliang,
> 
> On 04/05/2023 12:20, Geliang Tang wrote:
>> Add the address into userspace_pm_local_addr_list when the subflow is
>> created. Make sure it can be found in mptcp_nl_cmd_remove(). And delete
>> it in the new helper mptcp_userspace_pm_delete_local_addr().
>>
>> Add address into pm anno_list in mptcp_nl_cmd_sf_create(). Remove
>> it when connecting fails.
>>
>> By doing this, the "REMOVE" command also works with subflows that have
>> been created via the "SUB_CREATE" command instead of restricting to
>> the addresses that have been announced via the "ANNOUNCE" command.
>>
>> Fixes: d9a4594edabf ("mptcp: netlink: Add MPTCP_PM_CMD_REMOVE")
>> Link: https://github.com/multipath-tcp/mptcp_net-next/issues/379
>> Signed-off-by: Geliang Tang <geliang.tang@suse.com>
>> ---
>>  net/mptcp/pm_userspace.c | 51 ++++++++++++++++++++++++++++++++++++++++
>>  1 file changed, 51 insertions(+)
>>
>> diff --git a/net/mptcp/pm_userspace.c b/net/mptcp/pm_userspace.c
>> index 6beadea8c67d..c50e1507ae35 100644
>> --- a/net/mptcp/pm_userspace.c
>> +++ b/net/mptcp/pm_userspace.c
>> @@ -79,6 +79,24 @@ static int mptcp_userspace_pm_append_new_local_addr(struct mptcp_sock *msk,
>>  	return ret;
>>  }
>>  
>> +static int mptcp_userspace_pm_delete_local_addr(struct mptcp_sock *msk,
>> +						struct mptcp_pm_addr_entry *addr)
>> +{
>> +	struct mptcp_pm_addr_entry *entry, *tmp;
>> +
>> +	list_for_each_entry_safe(entry, tmp, &msk->pm.userspace_pm_local_addr_list, list) {
>> +		if (mptcp_addresses_equal(&entry->addr, &addr->addr, false)) {
>> +			/* TODO: a refcount is needed because the entry can
>> +			 * be used multiple times (e.g. fullmesh mode). */
> 
> Thank you for the new comment.
> 
> Just to know if we need to create a new ticket: are you already looking
> at that or you don't plan to? Do you prefer if I create a new ticket?

FYI, I just created a new ticket not to forget about that:

https://github.com/multipath-tcp/mptcp_net-next/issues/403

I was not sure if you were planning to look at it or not but at least we
can track this now.

Cheers,
Matt
-- 
Tessares | Belgium | Hybrid Access Solutions
www.tessares.net
