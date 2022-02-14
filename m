Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com [209.85.208.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8447AA2A
	for <mptcp@lists.linux.dev>; Mon, 14 Feb 2022 20:39:35 +0000 (UTC)
Received: by mail-ed1-f45.google.com with SMTP id g7so12819019edb.5
        for <mptcp@lists.linux.dev>; Mon, 14 Feb 2022 12:39:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :references:from:in-reply-to:content-transfer-encoding;
        bh=wAsKD66Jkzh12ZPSKJLXJ+m4fwG7Jqs29Mg1LDPnnEI=;
        b=klJ+KfHD6PJh2TL8T+HY6CUary+SAIuT/VAonLu+ADC9vYAR7ufV1jdDuj4X9kTe/+
         yaJsmaPRq2ELOqBI4BE5pseheQri/8hamyqnmf17gAU3YGbSwTHZvd5Lb1dnzZmZCh0I
         47K7SBLFOUQ9PfMWkcA0w0iqNVp5GzY6wiNbZI33avdWQQdZdSCFZm8IqFtja1zPfks3
         dBBiicp0F8QdOt+A6Z2iw77FOJPHF4rv7jYybPYvqLEUm9G2/WZaqlAKzw//dzYllCAf
         W6j10cTQRhI/75zD9geYyn9stLKtlLox/Uv25owt16+qe1xVqdWpM9qTcNwlVdnzO9hT
         1zqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:references:from:in-reply-to
         :content-transfer-encoding;
        bh=wAsKD66Jkzh12ZPSKJLXJ+m4fwG7Jqs29Mg1LDPnnEI=;
        b=PYEfyxDLsniwBDgY1nVWFAbKv5MOB1ev/QHdSQEJNUM//PLBoHHBxWGGGpxTIDbmeu
         cTCTKFNzTn+OMMFNmokaeuGN2VZj7HhIQ/ldLgQpaJFie82TxCKWB99vxdTJ7dpLy4+Q
         e19SlZoqV6A/9s1hYAIYvGzxFlYHx1Q/+DBJAu4k0q6sTXWluVYgG36lM+mWEsstEy1K
         8MT/rUupNP0lP4+3Uy8VhBEKlKkre1IRypCEY9ByRhd92NSQbWQPmFbF6MtvY5roFFww
         Pxf89DyNf6idyOr8RLHj8wMKrrN2XsxYihazbfE56YnkDcitzERruL3VbV6ssf2jHGWl
         BRSg==
X-Gm-Message-State: AOAM531nug/PUttweyhjhm01YCljaecHjSJtqDrpEglhIbXNr6V7k4v0
	p73OBeoXlLJimP+EssY2pxQVcjb1Bp0=
X-Google-Smtp-Source: ABdhPJxYYZmL0dLvwZTs9keOxqpXOCFFG332CUJjB7UhEvQpkwNUrNjFR9Y2UiUbbS7sr1jM8E33QA==
X-Received: by 2002:a05:6402:2754:: with SMTP id z20mr602913edd.235.1644871173559;
        Mon, 14 Feb 2022 12:39:33 -0800 (PST)
Received: from [192.168.0.182] ([188.24.58.131])
        by smtp.gmail.com with ESMTPSA id b17sm9512408ejd.34.2022.02.14.12.39.32
        for <mptcp@lists.linux.dev>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 14 Feb 2022 12:39:32 -0800 (PST)
Message-ID: <054ab41c-3cdb-88dd-cd69-f43ac5e19d78@gmail.com>
Date: Mon, 14 Feb 2022 22:39:33 +0200
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.1
Subject: Re: iio: accel: add ADXL367 driver: Build Failure
Content-Language: en-US
To: mptcp@lists.linux.dev
References: <20220214073810.781016-6-cosmin.tanislav@analog.com>
 <fb02a7ec-0880-45cd-d6fd-5289391dac9d@gmail.com>
From: Cosmin Tanislav <demonsingur@gmail.com>
In-Reply-To: <fb02a7ec-0880-45cd-d6fd-5289391dac9d@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

I wonder what's up with this?

It seems to have failed at the Notifications step.

URL not found: 'null' 
'https://patchwork.kernel.org/api/1.2/patches/?project=mptcp&msgid=20220214073810.781016-2-cosmin.tanislav@analog.com'

+ more similar.

On 2/14/22 22:35, MPTCP CI wrote:
> Hi Cosmin,
> 
> Thank you for your modifications, that's great!
> 
> But sadly, our CI spotted some issues with it when trying to build it.
> 
> You can find more details there:
> 
>    https://patchwork.kernel.org/project/mptcp/patch/20220214073810.781016-6-cosmin.tanislav@analog.com/
>    https://github.com/multipath-tcp/mptcp_net-next/actions/runs/1843131885
> 
> Status: failure
> Initiator: MPTCPimporter
> Commits: https://github.com/multipath-tcp/mptcp_net-next/commits/8ad435df3a10
> 
> Feel free to reply to this email if you cannot access logs, if you need
> some support to fix the error, if this doesn't seem to be caused by your
> modifications or if the error is a false positive one.
> 
> Cheers,
> MPTCP GH Action bot
