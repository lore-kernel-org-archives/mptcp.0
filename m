Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com [209.85.208.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D967F2C9D
	for <mptcp@lists.linux.dev>; Thu,  2 Dec 2021 17:47:40 +0000 (UTC)
Received: by mail-ed1-f42.google.com with SMTP id e3so1258869edu.4
        for <mptcp@lists.linux.dev>; Thu, 02 Dec 2021 09:47:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares-net.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=w8pwwavZhqpAfQrnkEAwkYh3suX/fpxcwEJ/66Ghj8k=;
        b=mcJvOHBXcO3AUyeG63pqLKjNHqt8u0i8sLtnSj5/vUT2bWZGVOo6KUd2K/yIS3JYz7
         hYznB799zSVFZ33wF5XwwmgFQt3+KN0gY2ENmC7AD6tKv4YtTBHLXs5j8eXa3pvI6EKS
         gGoE26Ho2/F4g9ZwN+ro3wvvTM6LNSsaM8pzyrUGptuU4Mc48rtSdgcsbQPR/+PLUosA
         AE0SAHYs1OvvtpwB9CF2b7BxL4iEoRa16t7johyXzKPMK6phcfEM3wj1OKPuYtSJhCsG
         gLGqC2sk2zdZSEdlGNXVSTUAPYajRj+n1s8286t284IS975U3bwlRMIu29bigmsTnHRx
         /whg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=w8pwwavZhqpAfQrnkEAwkYh3suX/fpxcwEJ/66Ghj8k=;
        b=tmiGpeKPXJGJVwO91aShvatm7+jICcdl3LWlNk7zGEzYorxTH/gLS0LD+6G59rWI++
         Rl6j414c/NRueapAIkJl4+fiKLGByrZr3lw93pP/jKT6tskM9tRWynMpOI9sUILFg9CU
         H2vTz9EzO0dPboVx6rXJuojJ+MOPqw4EJqKhAfnKO5kVhPnyV/gn6g9igZfJk2q8WFfz
         qey8YepsCehw8zNs/QJW8ChjfHEG9SY/Iv+V88Kev5PnhjWoyJAXbbJdz5hW9V+ajdQ9
         LyVc6NLB0lcRxa1xwBOc60RErkZDbD+O8k8c2BZ4O/068UBvNIfSIbeRQ48nyJA7DBKG
         sH1w==
X-Gm-Message-State: AOAM533nILeIYnxfELr/DXeiNozXSxVnqa3YE9SO/kkZ79tU7wYYdQZV
	tyjFvqWKrSxXu90VlHyqwbsfqit9sTPkVuEOUPA=
X-Google-Smtp-Source: ABdhPJz6ts5/4D2ceDracbb/0GIrdmzJ7/Jld/S1BRXgz7qWjjESPR9BwVUxtWzdUai2q9uY0HpICw==
X-Received: by 2002:a05:6402:1768:: with SMTP id da8mr20003107edb.252.1638467259099;
        Thu, 02 Dec 2021 09:47:39 -0800 (PST)
Received: from [192.168.178.33] ([213.211.142.51])
        by smtp.gmail.com with ESMTPSA id hc10sm309300ejc.99.2021.12.02.09.47.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 02 Dec 2021 09:47:38 -0800 (PST)
Message-ID: <84d6074b-9dc8-d77b-0d55-27a00320b5e1@tessares.net>
Date: Thu, 2 Dec 2021 18:47:38 +0100
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.2
Subject: Re: [PATCH mptcp-net] mptcp: add missing documented NL params
Content-Language: en-GB
To: Mat Martineau <mathew.j.martineau@linux.intel.com>
Cc: mptcp@lists.linux.dev
References: <20211130162026.1455269-1-matthieu.baerts@tessares.net>
 <4a76c2f6-83e6-8fdd-cbdc-68938a20bc4c@linux.intel.com>
From: Matthieu Baerts <matthieu.baerts@tessares.net>
In-Reply-To: <4a76c2f6-83e6-8fdd-cbdc-68938a20bc4c@linux.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Mat,

On 01/12/2021 03:08, Mat Martineau wrote:
> On Tue, 30 Nov 2021, Matthieu Baerts wrote:
> 
>> 'loc_id' and 'rem_id' are set in all events linked to subflows but those
>> were missing in the events description in the comments.
>>
>> Fixes: b911c97c7dc7 ("mptcp: add netlink event support")
>> Signed-off-by: Matthieu Baerts <matthieu.baerts@tessares.net>
>> ---
>> include/uapi/linux/mptcp.h | 18 ++++++++++--------
>> 1 file changed, 10 insertions(+), 8 deletions(-)
>>
> 
> Thanks for the fix Matthieu, looks good to me.
> 
> Reviewed-by: Mat Martineau <mathew.j.martineau@linux.intel.com>

Thank you for the review!

Now in our tree (fix for net but we can send it to net-next if you prefer)

- b5eb1109c9f2: mptcp: add missing documented NL params

- Results: 3851d2148681..afbf49f90abe

Builds and tests are now in progress:



https://cirrus-ci.com/github/multipath-tcp/mptcp_net-next/export/20211202T174706

https://github.com/multipath-tcp/mptcp_net-next/actions/workflows/build-validation.yml?query=branch:export

Cheers,
Matt
-- 
Tessares | Belgium | Hybrid Access Solutions
www.tessares.net
