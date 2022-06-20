Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDE7B2580
	for <mptcp@lists.linux.dev>; Mon, 20 Jun 2022 16:53:35 +0000 (UTC)
Received: by mail-ej1-f47.google.com with SMTP id fu3so22301390ejc.7
        for <mptcp@lists.linux.dev>; Mon, 20 Jun 2022 09:53:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares-net.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :references:from:in-reply-to:content-transfer-encoding;
        bh=/tlenR0kwm9yvxskCGzwLgCAaeCdAiQHmUbw02vyCBA=;
        b=OZNp9c83eCH+bCGgh+QQ+1DBXazhmkNfqk//gFQK2USUDZWwfpYfts/AfexTos1t6B
         sLTOC7gaYybVOkZQ1FwsVOgcds1Hhj8xdc1KGKvlpRdjDL8Iwq4Zh+y/zV/sWaGQn3ZP
         qI5YTQgWgpjMPy7kBW3bL1Z/HyfzJCf7+5EpiqIlXk+ynuTpkq2/JWJc/hf9DtJYhglc
         atexgcerRkCpgsbs2ro+Aca6q3Z+nI3JALfNFQg8Rj8SLFF8Vf/ZCZsDxjHr71pByRz6
         A2Ab491iWmfQmGQoEiE1Ed/e07TtqkHuH3qTVZHE+AkGzcNQSeJ0GNA/pp7oBUgMqAl5
         5JgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:references:from:in-reply-to
         :content-transfer-encoding;
        bh=/tlenR0kwm9yvxskCGzwLgCAaeCdAiQHmUbw02vyCBA=;
        b=efrgJmteZVpm8M0ECVWrnN+5EEWebzsXSUWKitilkWp9EKFDjYY+hMLLNe/lrbh9UP
         tdkGxUEwltGQBVtnqq0DecHKZ4zLQpf0jJT8cq/Y860cRGuDTU+oDv2l12bjakb0Fst8
         0nv9rJ+RKIUAF6UDVw9kjPgQadHS0lGzeGdh3a46iHcryyJKiFPMuy0b7S7Mgpnieoyg
         RTOyW99AfvOzIVeGnuko0RB248UeGozrx/N0mJtH0znYzt3AZ8+uAojLEpB6ZbLI4SBn
         4riSG1DiaIHHJpAmXjTBzFrsA0ugzdBDXPWrDrVrMSG7yqH58lky7tg+cgl2rG6uC9AT
         ajtg==
X-Gm-Message-State: AJIora/AlS6rYnJUUjK742pCxQe6IdwbevdYYYMsLV+7cmcsv7isZrVv
	6v031taTrhC2DxwPCjdK+wU+HNLKXrydWijb
X-Google-Smtp-Source: AGRyM1sF5hxdznjU2XnPLN7dcAlHO721xCkyWrWdyVIlJThkknaDosddxPpcij23RYfWLMn5zKInVg==
X-Received: by 2002:a17:906:7393:b0:712:57a8:5cc9 with SMTP id f19-20020a170906739300b0071257a85cc9mr21549359ejl.469.1655744013848;
        Mon, 20 Jun 2022 09:53:33 -0700 (PDT)
Received: from ?IPV6:2a02:578:8593:1200:dab4:d6b9:b46d:dda6? ([2a02:578:8593:1200:dab4:d6b9:b46d:dda6])
        by smtp.gmail.com with ESMTPSA id s18-20020a1709064d9200b006f3ef214da6sm3661804eju.12.2022.06.20.09.53.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 20 Jun 2022 09:53:33 -0700 (PDT)
Message-ID: <50a7387d-1f2b-2a25-31ef-552af589d9b9@tessares.net>
Date: Mon, 20 Jun 2022 18:53:32 +0200
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH mptcp-next v3 0/5] mptcp_join userspace pm tests
Content-Language: en-GB
To: Geliang Tang <geliang.tang@suse.com>, mptcp@lists.linux.dev
References: <cover.1655355422.git.geliang.tang@suse.com>
From: Matthieu Baerts <matthieu.baerts@tessares.net>
In-Reply-To: <cover.1655355422.git.geliang.tang@suse.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Geliang, Mat,

On 16/06/2022 07:02, Geliang Tang wrote:
> This patch set adds add address, remove address, create subflow, and
> destroy subflow test cases for userspace pm in mptcp_join script.

Thank you for the patches and the reviews!

New patches for t/upstream:
- 577d9f614162: mptcp: update MIB_RMSUBFLOW in cmd_sf_destroy
- e246aad773d9: selftests: mptcp: userspace pm address tests
- 01eef364817f: selftests: mptcp: userspace pm subflow tests
- b1781e4c95ae: selftests: mptcp: avoid Terminated messages in userspace_pm
- cef6c7fc0216: selftests: mptcp: update pm_nl_ctl usage header
- Results: 065936dc9f58..9e30e28df3d9 (export)


Builds and tests are now in progress:

https://cirrus-ci.com/github/multipath-tcp/mptcp_net-next/export/20220620T164712
https://github.com/multipath-tcp/mptcp_net-next/actions/workflows/build-validation.yml?query=branch:export

Cheers,
Matt
-- 
Tessares | Belgium | Hybrid Access Solutions
www.tessares.net
