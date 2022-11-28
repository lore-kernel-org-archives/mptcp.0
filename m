Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A9C18F6C
	for <mptcp@lists.linux.dev>; Mon, 28 Nov 2022 17:00:46 +0000 (UTC)
Received: by mail-ej1-f49.google.com with SMTP id gu23so9236164ejb.10
        for <mptcp@lists.linux.dev>; Mon, 28 Nov 2022 09:00:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares.net; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=/USFuVj8+lwMVpcXtzFtcFSIqUQbB+QRHlV8Od7d1nE=;
        b=lBzCd018lw/gj9gWmSY3fXwq5iFTLV1cPBTn0l5MlWrcTSUpSib5o0aaXiV0B38eeJ
         G3iPtyMZQY0sgYo3krTOLKJlDOWIZ9QYNrdBNAU6BPT/c5UPwImiPgSP0U3xP2NrO7ZS
         mks3/GkRDLNIHeobBIxAhDXReH3SUaf0JksbDy6h4rgXGYy65EWvHq95ufkKox8jDFz5
         n5QcBz+hla7akhF/kJDTa466R7b38IeP2gZsJdkMsq4AyrRP0DCsZRVKyyQq6n8NIqmV
         UUtMbTVv/YCxlQYQS5UJlR/rtInYJgko2By7pOPF+mTODsODLgrzWCx0/mEP4zoEgqEn
         GwEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=/USFuVj8+lwMVpcXtzFtcFSIqUQbB+QRHlV8Od7d1nE=;
        b=CI4irhDNxaxXZEY5N4s7D8KDuTIQyCgzDpkL0aCi3vWn6l/9ec5aoHEkU5ZNXwJBhB
         JmiQGaVmkb4waHA7FtfbScVQn+jctO0zwjl5f67GD/GJxrB99NVAtzhm/qK2vt+RYrgB
         NXesGqy37magxnujjdqV3MIjqJD2oGmheI7F/LzrxEmnUIAXuKQ/HZcnsWORww2TJ1wB
         RlgrssZDGzOJfMrvg5wdzV8cDx7BslpAFLjQ6GjAZTrAtiVKIITSUhDzSy6C6bqHHUz+
         z7EWjCPE55E9ixrUHNN+lSHrDltyAzOHmEpL56vaTdkT9o41m9AVzRrlK8VQ8tsFoT6T
         2dsg==
X-Gm-Message-State: ANoB5pmpIq8IfDXIkZ9r9/m/AsOSdBe56GyRiTIDB/gioSHrYGFDkKdS
	whzdH/3cAYkfiYPuQ8IktsXxeQ==
X-Google-Smtp-Source: AA0mqf7zuzMZnJFBllxjIf7snprN1tgVFz3osWwxXYXAvIQP9cz/BiXpmXdToSnmBk4Py8NooSUoJw==
X-Received: by 2002:a17:906:d281:b0:782:7790:f132 with SMTP id ay1-20020a170906d28100b007827790f132mr28510464ejb.649.1669654845063;
        Mon, 28 Nov 2022 09:00:45 -0800 (PST)
Received: from [10.44.2.26] ([81.246.10.41])
        by smtp.gmail.com with ESMTPSA id i23-20020a0564020f1700b004589da5e5cesm5308022eda.41.2022.11.28.09.00.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 28 Nov 2022 09:00:44 -0800 (PST)
Message-ID: <089fe66f-f7e8-d0d4-7c78-1ee8d3de467e@tessares.net>
Date: Mon, 28 Nov 2022 18:00:43 +0100
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.3
Subject: Re: [PATCH mptcp-net] mptcp: netlink: fix some error return code
Content-Language: en-GB
To: Wei Yongjun <weiyongjun@huaweicloud.com>,
 Mat Martineau <mathew.j.martineau@linux.intel.com>,
 Paolo Abeni <pabeni@redhat.com>, Kishen Maloor <kishen.maloor@intel.com>,
 Florian Westphal <fw@strlen.de>
Cc: Wei Yongjun <weiyongjun1@huawei.com>, mptcp@lists.linux.dev
References: <20221118083541.123585-1-weiyongjun@huaweicloud.com>
From: Matthieu Baerts <matthieu.baerts@tessares.net>
In-Reply-To: <20221118083541.123585-1-weiyongjun@huaweicloud.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Wei,

On 18/11/2022 09:35, Wei Yongjun wrote:
> From: Wei Yongjun <weiyongjun1@huawei.com>
> 
> Fix to return negative error code -EINVAL from some error handling
> case instead of 0, as done elsewhere in those functions.
> 
> Fixes: 9ab4807c84a4 ("mptcp: netlink: Add MPTCP_PM_CMD_ANNOUNCE")
> Fixes: 702c2f646d42 ("mptcp: netlink: allow userspace-driven subflow establishment")
> Signed-off-by: Wei Yongjun <weiyongjun1@huawei.com>

Thank you for the patch!

Now in our tree (fixes for -net) with my RvB tag.

- 3d02a8bbf345: mptcp: netlink: fix some error return code
- Results: 109525edc72c..b5499098cd00 (export-net)
- Results: cf487f680c54..392b1b99f540 (export)

Tests are now in progress:

https://cirrus-ci.com/github/multipath-tcp/mptcp_net-next/export-net/20221128T165846
https://cirrus-ci.com/github/multipath-tcp/mptcp_net-next/export/20221128T165846

Cheers,
Matt
-- 
Tessares | Belgium | Hybrid Access Solutions
www.tessares.net
