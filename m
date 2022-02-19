Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com [209.85.218.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 468135580
	for <mptcp@lists.linux.dev>; Sat, 19 Feb 2022 17:15:49 +0000 (UTC)
Received: by mail-ej1-f41.google.com with SMTP id hw13so22339790ejc.9
        for <mptcp@lists.linux.dev>; Sat, 19 Feb 2022 09:15:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares-net.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :references:from:in-reply-to:content-transfer-encoding;
        bh=pUyWWQK3EZwHzTjqqTiGtGJMmgd1d96D2nRjiohf/t4=;
        b=sfRJ1/nfSo0aJSw/hjriq56IZR7WxMWFXkUdSFjYI9CjwNrnks7IMapMz47TgsQtKw
         vQjE/hBDOGKAVzhBqBiSYlp270SoJRJlkjFqliWm23RQRJLxYPMAY1ZWiVKc9auANxyU
         YkUPKvRmQQTPH7A+UGjiRAKJQHc6SZ2qFFYSaZRY9LWeM9XIkrQB35tUbgjnnKCJLHD5
         Wnk0mNIPICOeDXInOaj42w0TDUdoF0AFnumBTWlxDfkAOw0qJ0gUyllU/j9hzIu5ny8p
         ozdumJBV1ImdBJxCLsil9ymREHB2atwRXSqzMtnRA8+Z5wq1JHPMkWjANAotHGmgDsDd
         Uwxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:references:from:in-reply-to
         :content-transfer-encoding;
        bh=pUyWWQK3EZwHzTjqqTiGtGJMmgd1d96D2nRjiohf/t4=;
        b=aK07iG0QYX5sY7FcQ59kB6GF86KqcaNxSVV7+DO0xcvTRg09Sh4aC9oMQuyCqdbDY0
         yzlco6DlDs31+lrOZSlaGCct6G1RBkVdq1xzJT4zdDNVc1baCT5l9XGZ1H67VgDZU8b/
         QCy8FEYdlRir5x23BvaGSv7ALYybziWw9+cdlN0i3FaFVvH2VfIY8NGmGRlDDaX8CMuK
         1MLBFhxQ/ABeUcx7aCAcWAo9KnYGT1HWDhM15LBU+INyfrfyXkNGshOG2p3QtfG0TaX1
         DtjnH2Dg5U2n9aivbZ76uVaLVzvkqQfAKUQRWbocDKNcz+WVS120B7lUNQrct0ZF2oEa
         IA5Q==
X-Gm-Message-State: AOAM532qwDm2SseUMTCHT0pkRuCu7YqCdndZ/z7epsAVaFo+va1hn8zK
	WCNcKgdejGmL2W0eP/kEmLNtXySk/85fhZ/e
X-Google-Smtp-Source: ABdhPJxyauUBA10e8yV/wx9Wo0k+WaG2hIorUr7nZGJiu/u4ASB9Vwh2yNHndgLuU0dNF62UgDM8Ew==
X-Received: by 2002:a17:906:f250:b0:6b5:83df:237d with SMTP id gy16-20020a170906f25000b006b583df237dmr10620211ejb.157.1645290947258;
        Sat, 19 Feb 2022 09:15:47 -0800 (PST)
Received: from ?IPV6:2a02:578:8593:1200:e864:9933:3026:4675? ([2a02:578:8593:1200:e864:9933:3026:4675])
        by smtp.gmail.com with ESMTPSA id j21sm3363559ejj.193.2022.02.19.09.15.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 19 Feb 2022 09:15:46 -0800 (PST)
Message-ID: <3afdcb57-cddb-4a5e-d4a8-98fb65f0a6c2@tessares.net>
Date: Sat, 19 Feb 2022 18:15:46 +0100
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.1
Subject: Re: [PATCH v5 mptcp-next 0/4] mptcp: more self-tests improvements
Content-Language: en-GB
To: Paolo Abeni <pabeni@redhat.com>, mptcp@lists.linux.dev
References: <cover.1645134065.git.pabeni@redhat.com>
From: Matthieu Baerts <matthieu.baerts@tessares.net>
In-Reply-To: <cover.1645134065.git.pabeni@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Paolo, Mat,

On 17/02/2022 22:44, Paolo Abeni wrote:
> This iteration tries to address the feedback from Mat on v4.
> 
> patch 1/4 is new and tries to address the problem behind issues/225 with
> stricted RFC compliance
> patch 2 and 3 clean-up endpoint management as per past discussion
> patch 4 introduce new self-tests, as deserved the previous patch

Thank you for the patches and reviews!

Now in our tree (feat. for net-next) with Mat's RvB tags and minor
modifications on the last patch:

- 1c0e3277fab9: mptcp: more careful RM_ADDR generation
- 1908304713ea: mptcp: introduce implicit endpoints
- 25124126a6c0: mptcp: strict local address ID selection
- 7532760df8bc: selftests: mptcp: add implicit endpoint test case
  - With minor modifications (missing local + help usage)
  - https://paste.opendev.org/show/812824
- Results: 78bc7e06c12d..785fa0377037

Builds and tests are now in progress:

https://cirrus-ci.com/github/multipath-tcp/mptcp_net-next/export/20220219T171438
https://github.com/multipath-tcp/mptcp_net-next/actions/workflows/build-validation.yml?query=branch:export

Cheers,
Matt
-- 
Tessares | Belgium | Hybrid Access Solutions
www.tessares.net
