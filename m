Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0AA6B3C05
	for <mptcp@lists.linux.dev>; Tue, 28 Jun 2022 16:06:28 +0000 (UTC)
Received: by mail-wm1-f48.google.com with SMTP id o16-20020a05600c379000b003a02eaea815so6514314wmr.0
        for <mptcp@lists.linux.dev>; Tue, 28 Jun 2022 09:06:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares-net.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=FyrV2tvGy3L+XvGeSsA1bHeLvenoO78Y2ZQcOUaSD3g=;
        b=JI9axcKHI1+b6CV843Dd4HhK0D4kjbwqGsq0TIsjCdvZ/WwtIi4vI5SasE516oeVwv
         WlA2wlhQYEPOWTrk/DSG41DpnD7CCPHqWLvuft8wqH3k8XQoqVyg3QQM96r9mxElBAjB
         job54pXsShV56ksQqSYCibgej8SRHM96sctJRs7YVMupim5IA9sNNXv4ABofi+57s7eR
         jWAgHIY+erzwcFpqjxnwOC7owaacJOupOG8rFhL6/JccNNbZ0lf7ViyBmQ0O1K59doWd
         1I6UGC2AWSi1JDhDoXvrM/EHzAGb1ahWZ8Mn6qK6EBHJhivhP2t33S6GrXOB5Q/dFk5g
         veAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=FyrV2tvGy3L+XvGeSsA1bHeLvenoO78Y2ZQcOUaSD3g=;
        b=6JqrDd9nlEojK2gV4nj7XL5vNZhv3Sd8n0K5DG1rW8Jgr8yPwGJxslAegw4m6CoP3G
         IvmZcosLST5IDh2rEdIJOwDqgqmv7Jusg9XFxPj6yyGkqg50yXXpGFda4dLHPjvdIHIA
         7LXwpjthpcjODHlXH0QBO1sy4Pv6Rg9VJW1QvThsAu08lqVYIjOuxiZ1OZb9K2qBjjGq
         I/raSFhbhl6WGMNzb6D2EVqKOuZj5Iqtw0HBDhRSyh0I9Kfp/egHjGhUZGAJCypRP0RE
         /c+/uXSFOAKFbKrqXVdUIobZPxa8DJr4czQIMe7L8SnlAkcD4c5mimagYDZkJEy073Q0
         hfHw==
X-Gm-Message-State: AJIora+Jge/mPFKCZ0boNoHektMqT60sWfEcqInYts54jxXUehgVHkY8
	VTgYLiTyC2qdflOh0x2t3WZ+Iq9Ms14gMagX
X-Google-Smtp-Source: AGRyM1tedgogajziKaV0za2EtPNt3eSDJQjxWk4l2QLuOwr5CMqx2z+NAjbPYDAF2c4zrLhveGxo0A==
X-Received: by 2002:a7b:c450:0:b0:3a0:32ec:efa9 with SMTP id l16-20020a7bc450000000b003a032ecefa9mr413326wmi.12.1656432386905;
        Tue, 28 Jun 2022 09:06:26 -0700 (PDT)
Received: from [10.44.2.26] ([81.246.10.41])
        by smtp.gmail.com with ESMTPSA id g4-20020a5d5544000000b0021a39f5ba3bsm14101476wrw.7.2022.06.28.09.06.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 28 Jun 2022 09:06:26 -0700 (PDT)
Message-ID: <38524ec1-c8b6-6c62-67df-4843a8e368ac@tessares.net>
Date: Tue, 28 Jun 2022 18:06:25 +0200
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH mptcp-net] mptcp: fix locking in mptcp_nl_cmd_sf_destroy()
Content-Language: en-GB
To: Paolo Abeni <pabeni@redhat.com>, mptcp@lists.linux.dev
Cc: Florian Westphal <fw@strlen.de>
References: <886e059dc9096dcc9e1daa1eb1a07ec34d72aa74.1656323519.git.pabeni@redhat.com>
From: Matthieu Baerts <matthieu.baerts@tessares.net>
In-Reply-To: <886e059dc9096dcc9e1daa1eb1a07ec34d72aa74.1656323519.git.pabeni@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Paolo, Mat,

On 27/06/2022 11:58, Paolo Abeni wrote:
> The user-space PM subflow removal path uses a couple of helpers
> that must be called under the msk socket lock and the current
> code lacks such requirement.
> 
> Change the existing lock scope so that the relevant code is under
> its protection.
> 
> Fixes: d9a4594edabf ("mptcp: netlink: Add MPTCP_PM_CMD_REMOVE")
> Signed-off-by: Paolo Abeni <pabeni@redhat.com>
Thank you for the patch and the review!

Now in our tree (fixes for -net) with Mat's RvB tag:

New patches for t/upstream-net:
- 106e35505557: mptcp: fix locking in mptcp_nl_cmd_sf_destroy()
- 52865f3cc71f: tg:msg: add Closes tag
- Results: 93f7e050cd84..d964bfb845c8 (export)

New patches for t/upstream:
- 106e35505557: mptcp: fix locking in mptcp_nl_cmd_sf_destroy()
- 52865f3cc71f: tg:msg: add Closes tag
- Results: 9756359748a6..a972bdf0fdec (export)

Builds and tests are now in progress:

https://cirrus-ci.com/github/multipath-tcp/mptcp_net-next/export-net/20220628T160121

https://github.com/multipath-tcp/mptcp_net-next/actions/workflows/build-validation.yml?query=branch:export-net
https://cirrus-ci.com/github/multipath-tcp/mptcp_net-next/export/20220628T160121
https://github.com/multipath-tcp/mptcp_net-next/actions/workflows/build-validation.yml?query=branch:export


> ---
> It should close issues/287, let's see what the CI says


I added the "Closes" tag in the commit message to link the patch with
the issue and automatically close the ticket ;-)

Cheers,
Matt
-- 
Tessares | Belgium | Hybrid Access Solutions
www.tessares.net
