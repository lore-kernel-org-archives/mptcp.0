Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com [209.85.208.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD1E270
	for <mptcp@lists.linux.dev>; Thu,  6 May 2021 08:31:51 +0000 (UTC)
Received: by mail-ed1-f46.google.com with SMTP id c22so5172125edn.7
        for <mptcp@lists.linux.dev>; Thu, 06 May 2021 01:31:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares-net.20150623.gappssmtp.com; s=20150623;
        h=to:references:cc:from:subject:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=8wrL7cMCBPP7C8+STTk8geK9Qf5UTSUz12a7G0rm+98=;
        b=Ubh4XPwcJ3OMSprz5QjnYsReB2ien1AVDKnye/jCkSswAgUlagLtJj9Hk7qAh7R9gt
         tYBy0y9zowot9/SP+TYwWlLNLpIXoxzD6F6BLnB7MBPG08dNz+ebx9ueTwOG8aRc+30t
         cKvMoAdk7wr3Dod2TyGaiEcDfFZOJaj27w7OPhMGgx4fIILMrzE2WNZCzJOy4m8YSzg/
         QzS1XW/CdywXHzjqWoY/cpsmU39D9TSqhCqkvwMQWalsFv4euyHEQuOfkj8M0/XN0MN7
         As2cSfoJxi3cEjdlE1lttdArEBU6CnCJ7fk0Fq4rhsRX+1CcAH9Hvp5f+ILNNMXb+Clu
         naXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:references:cc:from:subject:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=8wrL7cMCBPP7C8+STTk8geK9Qf5UTSUz12a7G0rm+98=;
        b=klF1AeuRnPrXnfMxSR97ROHYYWMD6SbDcXOcr7+A/XbZqFYN6PrnDIKSI+yetSqlwZ
         tzgkuq5xxt82WwHd4DA0nQ2hoYkijjUwMpQYdpsqK8yjP1gmnNTBCAeLFfmC3RREFbE2
         ftQVQhf/qxABTFPsEoTl+QHy5+oy1BtQCW3tJB9RsCZ76spu7IHRhGST6RMMcjC0Y9C4
         2IckrHVILnRbe8G2iqhDxojVNbsAiSza7I/CBaESFpLNPyjHavh5Jh8gBv+EwcmBivEB
         Xsu+suBLAeDjifOVw4JIwX1qtUxqaqZfzyPtOjtGsxBpCCckPfuHNmCqt8cpV3gAg0aC
         dD7w==
X-Gm-Message-State: AOAM530D8104ckjFOMM5ZZ/5dm5VKxBilyGX2ItAAfsJM4tWcHlxvRfp
	bodanETQRuIAO4byh12H35FWwqDNJ5a+NxeD4e4=
X-Google-Smtp-Source: ABdhPJw785dGXrEy9WF5tRQDSBc+dTSZ+jzNepA6RMbw9XL8tq4EbNKFicWXjz3evj5MK0yMFgsqrA==
X-Received: by 2002:a05:6402:270c:: with SMTP id y12mr3793840edd.284.1620289909957;
        Thu, 06 May 2021 01:31:49 -0700 (PDT)
Received: from tsr-lap-08.nix.tessares.net ([2a02:578:85b0:e00:2955:d350:566e:2ff2])
        by smtp.gmail.com with ESMTPSA id y23sm937079ejd.82.2021.05.06.01.31.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 06 May 2021 01:31:49 -0700 (PDT)
To: Paolo Abeni <pabeni@redhat.com>,
 Mat Martineau <mathew.j.martineau@linux.intel.com>,
 Geliang Tang <geliangtang@gmail.com>
References: <cover.1620163861.git.pabeni@redhat.com>
Cc: mptcp@lists.linux.dev
From: Matthieu Baerts <matthieu.baerts@tessares.net>
Subject: Re: [PATCH v6 mptcp-next 00/22] mptcp: data checksum support
Message-ID: <ed96d664-bc80-e919-f45f-688a5f30a879@tessares.net>
Date: Thu, 6 May 2021 10:31:48 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <cover.1620163861.git.pabeni@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 8bit

Hi Paolo, Geliang, Mat,

On 04/05/2021 23:41, Paolo Abeni wrote:
> Geliang Tang (14):
>   mptcp: add csum_enabled in mptcp_sock
>   mptcp: generate the data checksum
>   mptcp: add csum_reqd in mptcp_out_options
>   mptcp: send out checksum for MP_CAPABLE with data
>   mptcp: send out checksum for DSS
>   mptcp: add sk parameter for mptcp_parse_option
>   mptcp: add csum_reqd in mptcp_options_received
>   mptcp: receive checksum for MP_CAPABLE with data
>   mptcp: receive checksum for DSS
>   mptcp: validate the data checksum
>   mptcp: add the mib for data checksum
>   mptcp: add a new sysctl checksum_enabled
>   selftests: mptcp: enable checksum in mptcp_connect.sh
>   selftests: mptcp: enable checksum in mptcp_join.sh
> 
> Paolo Abeni (8):
>   Squash-to: "mptcp: generate the data checksum"
>   Squash-to: "mptcp: send out checksum for MP_CAPABLE with data"
>   Squash-to "mptcp: send out checksum for DSS"
>   Squash-to: "mptcp: receive checksum for MP_CAPABLE with data"
>   Squash-to: "mptcp: receive checksum for DSS"
>   Squash-to: mptcp: validate the data checksum
>   mptcp: cleanup error path in subflow_check_data_avail()
>   mptcp: tune re-injections for csum enabled mode.

Thank you for this great series of patches and reviews!

I just applied it in our tree with:

- squashed patches (Squash-to ones) with:
  - modified commit description (I can fix if needed)
  - Paolo's co-dev tags

- switched author for "mptcp: validate the data checksum":
  - with Geliang's co-dev tag

- added Paolo's Ack on Geliang patches:
  - I didn't do the opposite but I can if you send an explicit Ack ;)

- added Mat's RvB tags

- and fixed two small checkpatch related issues

Here are the commits:

- 9e37234f4af0: mptcp: add csum_enabled in mptcp_sock
- 8e5a007a6f49: mptcp: generate the data checksum
- 65d5dab35254: mptcp: add csum_reqd in mptcp_out_options
- fa7ac4af5f35: mptcp: send out checksum for MP_CAPABLE with data
- 020aa2793d7a: mptcp: send out checksum for DSS
- f343075f84d8: mptcp: add sk parameter for mptcp_parse_option
- 36175fd83775: mptcp: add csum_reqd in mptcp_options_received
- f9b610c1e999: mptcp: receive checksum for MP_CAPABLE with data
- dcf392ee537c: mptcp: receive checksum for DSS
- ff6ab779b490: mptcp: validate the data checksum
- c30f4b417683: mptcp: cleanup error path in subflow_check_data_avail()
- 7929c266db79: mptcp: tune re-injections for csum enabled mode
- b5cfe0de9924: mptcp: add the mib for data checksum
- caf02cd7505b: mptcp: add a new sysctl checksum_enabled
- c8a3478e7ecb: selftests: mptcp: enable checksum in mptcp_connect.sh
- ed46f07923ab: selftests: mptcp: enable checksum in mptcp_join.sh
- Results: 0987319aa674..e2c6acaa5239

Builds and tests have ran:



https://cirrus-ci.com/github/multipath-tcp/mptcp_net-next/export/20210506T070146
https://github.com/multipath-tcp/mptcp_net-next/actions/workflows/build-validation.yml?query=branch:export/20210506T070146

I'm going to look at the build failure.

Cheers,
Matt
-- 
Tessares | Belgium | Hybrid Access Solutions
www.tessares.net
