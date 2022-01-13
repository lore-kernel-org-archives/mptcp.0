Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0089F173
	for <mptcp@lists.linux.dev>; Thu, 13 Jan 2022 10:25:06 +0000 (UTC)
Received: by mail-wr1-f54.google.com with SMTP id k18so9145960wrg.11
        for <mptcp@lists.linux.dev>; Thu, 13 Jan 2022 02:25:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares-net.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=NtOmmzArRunn8/7KDrJT1nFnBE0i47OEydtGLhl4R+Y=;
        b=gmHYfNLXPTRcqQFApQzONBS3iP8i0XtgqJWqgk6Zjlz1Hxn+jW6BUsO0Rg0IQlPIf3
         WQvRjR5Dhe5WqHaMmB87m3H9V5idjfi0D58ewvcM6+kdm9S+XlibqrF2b+8mKQ23XBWu
         fCo3aUYfvdjJ2AD2mVkLnBBeQ2tHLaUA5WQKm3bd20mR8TGxJCTmUr0MNDffim3ROrSS
         RbOpLISd8mkSTBw0EkjFROjJULErjlQqFf2bnDKMtIIBnnQdfBy8R81NcpeOthc0pFp/
         ZyZ18zGQ7FuA8KWdm++DD8bEwiyRAW5ysiSzd+4XPA+Hn8bpH4QxFL6/F3XuLNvCTNFp
         DI5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=NtOmmzArRunn8/7KDrJT1nFnBE0i47OEydtGLhl4R+Y=;
        b=EITMuvMVDmhTvIm60xKO4SlsJvH/FW4v3yxY26MOiZhDYgYZrxWwFcLPO1JjCGWreY
         wmk0GM9GqsxWfTxbctOcN9cdWxNCyoeRVcQsstkOilx8Gq7z2W0kMIMYB9BRF8XDxlUv
         PO+ucOgkzRbITmuSyT7bn0o3LbzyBxJFslPVufM7vFqF8nN0m+zKEzycsiLJK6XrBOTp
         4fhLjT/QkTVIVaxFdpcXwRTkr1cUsiXORe1HHTo2j3EsZsFXjVXc13ajeSst210RpRbd
         /lKU7IcMHKnukGHioGTGuHOMehg80oVtFk/TlIAt2db7gD4v8xSmOgsZg5zV2L8QSD5b
         ENbA==
X-Gm-Message-State: AOAM533BROSHNBrwY7SVa6WAIGbUAi/wBHVfk0hC34Dk3PBVFTD/BVe5
	D4sPyvNFT0WgY58x5X6184QanZuy5GsrIw==
X-Google-Smtp-Source: ABdhPJxgSPJgPiLnlc/ZTsu36evDw66na7Fd3vostltnT0jtf0GIM3Akxe5ZV44zOLH3N6ZweosZmQ==
X-Received: by 2002:a5d:6d87:: with SMTP id l7mr3342954wrs.139.1642069505037;
        Thu, 13 Jan 2022 02:25:05 -0800 (PST)
Received: from [10.44.2.26] (84-199-106-91.ifiber.telenet-ops.be. [84.199.106.91])
        by smtp.gmail.com with ESMTPSA id p9sm2440535wmb.32.2022.01.13.02.25.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 13 Jan 2022 02:25:04 -0800 (PST)
Message-ID: <42533127-caa0-7b67-987e-f3aedb2a2164@tessares.net>
Date: Thu, 13 Jan 2022 11:25:04 +0100
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH mptcp-next v2] mptcp: fix removing ids bitmap setting
Content-Language: en-GB
To: Geliang Tang <geliang.tang@suse.com>,
 Mat Martineau <mathew.j.martineau@linux.intel.com>
Cc: Paolo Abeni <pabeni@redhat.com>, mptcp@lists.linux.dev
References: <fd0d593b0f088f5024b7a9a5f292bae4e67d6dde.1641868302.git.geliang.tang@suse.com>
From: Matthieu Baerts <matthieu.baerts@tessares.net>
In-Reply-To: <fd0d593b0f088f5024b7a9a5f292bae4e67d6dde.1641868302.git.geliang.tang@suse.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Geliang, Mat, Paolo,

On 11/01/2022 03:37, Geliang Tang wrote:
> In mptcp_pm_nl_rm_addr_or_subflow(), the bit of rm_list->ids[i] in the
> id_avail_bitmap should be set, not rm_list->ids[1]. This patch fixed it.

Thank you for the patch and the reviews!

Now in our tree (fixes for -net) with Mat's RvB tag:

- 5fd49f91fdb8: mptcp: fix removing ids bitmap setting
- Results: 6eab36365cea..459ae9092f30

Builds and tests are now in progress:

https://cirrus-ci.com/github/multipath-tcp/mptcp_net-next/export/20220113T102450
https://github.com/multipath-tcp/mptcp_net-next/actions/workflows/build-validation.yml?query=branch:export

Cheers,
Matt
-- 
Tessares | Belgium | Hybrid Access Solutions
www.tessares.net
