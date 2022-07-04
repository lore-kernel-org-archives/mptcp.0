Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B87FA46B3
	for <mptcp@lists.linux.dev>; Mon,  4 Jul 2022 16:09:35 +0000 (UTC)
Received: by mail-ej1-f50.google.com with SMTP id o25so17531612ejm.3
        for <mptcp@lists.linux.dev>; Mon, 04 Jul 2022 09:09:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares-net.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=sia9cwArgWQffQyy6bmKysbMLAj0TjML+wac95tt+XQ=;
        b=fMqfZpQmJJxAaAGy4CqL0XaIKdf21Xby125XTy7Sh3VnQeuA47n10bIcZ76wwo2WAH
         /fMwWhs6lh+HIwQvBd9egi7wJmeVWPV+le49YP4TiB1BRbbEgPuTSjPqfGZBLlGxABSb
         aAuqh1EeANhkeCmgxpatckV26jj6Swn26CCPf5qkFCHwGk1PqsgR8PX3LJKgiRd9Bgdd
         FUmkOnH5W26TM4Qs3KeilQ78qTmwNtexGdxZCnFW15K5vOfYTfddeMLb1vsdZjJTPT4f
         xP3YrL2JlESUI16vA9C+WZY4Xze7pSob7LokV7chiTvcweUpMgzjJKAtvtK0bO++jwcz
         R7LA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=sia9cwArgWQffQyy6bmKysbMLAj0TjML+wac95tt+XQ=;
        b=7mcSIcTNJuBYotYSU0tWp6W0OHBaVk5bWscnF4RnhWtsyMd88pPPOQPwBKn3naoOC8
         cPAHgpv3yxV/+zhAjznINi7PbUplff623TBSPWT7+cURdaIQrGdM3FvS9eKNhPQme8Ee
         /5laksNAgjhmEeYAfiWY6PSeZgS82VmUyHaW3D1g3qZxu1c2jSCTuA8Lz38fD2gnbE5T
         0yeoURsH//6wdNOyvvMJirQGSEU0VHrld7OuJLEPqm3zV2GQ7sMAEoiQbbKObvuwWQ5L
         cS8bK5HEAGWILGhI7cGQTo1nR2um/CfGo47sKkhO12InhUhBMFvLdP7kXUL3BohqsujO
         6r6w==
X-Gm-Message-State: AJIora/DtRcTO9LVZ5ND5BM2g5iSe8pnf5RK810iZfsorvyuwi/Z6r48
	nixBqP7IXXXwJHImo4dxK6LqQ6iPzC9agg==
X-Google-Smtp-Source: AGRyM1vODEzLd0v9DRHvwZtT89jM6gAzEcCxygGjttNdgLpY4U0vuvfo/SEuDgGOmJi9bJGL+nkHYQ==
X-Received: by 2002:a17:907:2bf6:b0:72a:881b:8d79 with SMTP id gv54-20020a1709072bf600b0072a881b8d79mr18644318ejc.623.1656950973606;
        Mon, 04 Jul 2022 09:09:33 -0700 (PDT)
Received: from [10.44.2.26] ([81.246.10.41])
        by smtp.gmail.com with ESMTPSA id k20-20020a1709063fd400b00722f66fb36csm14206448ejj.112.2022.07.04.09.09.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 04 Jul 2022 09:09:33 -0700 (PDT)
Message-ID: <0648ad62-f409-0657-6e42-105c5f755814@tessares.net>
Date: Mon, 4 Jul 2022 18:09:32 +0200
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH mptcp-next 1/6] mptcp: fix local endpoint acconting.
Content-Language: en-GB
To: Paolo Abeni <pabeni@redhat.com>,
 Mat Martineau <mathew.j.martineau@linux.intel.com>
Cc: mptcp@lists.linux.dev
References: <cover.1656669391.git.pabeni@redhat.com>
 <f0f5893c05f19d5076a9d03c84b65495f488fbf2.1656669391.git.pabeni@redhat.com>
 <1dc71764-4046-79c3-c6f-5c736d2d64c0@linux.intel.com>
 <15406f2f64a2650e1ffa919bee02fee763400eaf.camel@redhat.com>
From: Matthieu Baerts <matthieu.baerts@tessares.net>
In-Reply-To: <15406f2f64a2650e1ffa919bee02fee763400eaf.camel@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Paolo, Mat,

On 04/07/2022 10:02, Paolo Abeni wrote:
> On Fri, 2022-07-01 at 17:04 -0700, Mat Martineau wrote:
>> On Fri, 1 Jul 2022, Paolo Abeni wrote:
>>
>>> In mptcp_pm_nl_rm_addr_or_subflow() we always mark as availble
>>> the id corresponding to the just removed address.
>>>
>>> The used bitmap actually tracks only the local IDs: we must
>>> restrict the operation when a (local) subflow is removed.
>>>
>>> Fixes: a88c9e496937 ("mptcp: do not block subflows creation on errors")
>>> Signed-off-by: Paolo Abeni <pabeni@redhat.com>
>>
>> Looks good to me. Ok to apply this one to the net branch, separate from 
>> the rest of the series?
> 
> Works for me, thanks!

Thank you for the patch and the review!

This patch (and only this 1/6 patch) is now in our tree (fixes for -net)
with Mat's RvB tag and without some typos found by codespell
(./scripts/checkpatch.pl --codespell):

New patches for t/upstream-net:
- 700323697153: mptcp: fix local endpoint accounting
- Results: 8b0928bdfa52..9e57efad1e78 (export-net)

New patches for t/upstream:
- 700323697153: mptcp: fix local endpoint accounting
- Results: d9c4fd4f6874..d7694db70480 (export)


Builds and tests are now in progress:

https://cirrus-ci.com/github/multipath-tcp/mptcp_net-next/export-net/20220704T160802
https://github.com/multipath-tcp/mptcp_net-next/actions/workflows/build-validation.yml?query=branch:export-net
https://cirrus-ci.com/github/multipath-tcp/mptcp_net-next/export/20220704T160802
https://github.com/multipath-tcp/mptcp_net-next/actions/workflows/build-validation.yml?query=branch:export

Cheers,
Matt
-- 
Tessares | Belgium | Hybrid Access Solutions
www.tessares.net
