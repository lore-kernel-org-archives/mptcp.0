Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDA582F26
	for <mptcp@lists.linux.dev>; Tue,  8 Feb 2022 09:44:09 +0000 (UTC)
Received: by mail-ej1-f50.google.com with SMTP id fy20so1704946ejc.0
        for <mptcp@lists.linux.dev>; Tue, 08 Feb 2022 01:44:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares-net.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :references:from:in-reply-to:content-transfer-encoding;
        bh=WgIzpWnLd+hRvvFguJmq3uA585dUh/YWSBi5tiXKFmg=;
        b=hXCffIPo1f8uJreTGiNP88MZRZ8e9o80wXwZdOFTMU5Xr8pFYeWWHvSspmUEMp4Uam
         nhY9eXRowwPtOLlkaGy5RFgoM/75ssnPLlBglFJKWT1C5DZP5237opLCZhJVZn9RgELG
         TP8WhZUWKfR5a/V50VvNxdPUUEAk1YGfXCavIicPayrlillZEuXxHuYUaWYm3CEa/y2R
         k2Kahiy8ZN3e8TVyncXCqwTvmPVszqEBaZFKoULKkPJevywPikZfWRiCQMqyWMTlDLzP
         gWHOEXmSyzL4v0dRJJNVurocZhIQ+ULg8Dt0/z/Fu9Sk1LzsiXnFAMT2v7kh87T+hujy
         peKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:references:from:in-reply-to
         :content-transfer-encoding;
        bh=WgIzpWnLd+hRvvFguJmq3uA585dUh/YWSBi5tiXKFmg=;
        b=u6yGYKHStTghxZ2YlKwZu3cdZH/70UiMo+bmgWIujRxUBrW1T0xiJGTVYqCCpJZMkn
         P1fNHHrvVy0TwZUq71FhFZBTwlMzzbX9RqT5pU+TEbwju1K/hk4J1/NSpdyrs4h6XGEx
         fX1Exe2HXtp4IO6OE+5BhUfrHRAC/7e9Qbfvcq+LvG3+2W0mo/pkeSeS8//Dsyv8eAky
         AHD8ULNMqDEargtOJuqeUeYAtRC0cT9I20PP90pmRh/S/m16X7uuM2lT9kziZRGK7ZcI
         yJ1gIv3P7vxz+kWSKYiPqFum1xvfmzTqwNv/RH+ONC72F1bwNPGCNf+5+ghqDavjnGuR
         IrAA==
X-Gm-Message-State: AOAM530xzeuLygqkyATZuhWa0V38KSu1nUWo8PBy517v7cFr4s5lXyJL
	1t1WK23u4p0YZnabtYP/TCh/lPr3V/YAawWWDFM=
X-Google-Smtp-Source: ABdhPJy4qvFZHbALjhXvpdchnPgtNSDe6CMkbjXj0XHXTmshwErBDGSEJETxkvqrMar4QMZpEORPHw==
X-Received: by 2002:a17:906:e292:: with SMTP id gg18mr3044897ejb.199.1644313448065;
        Tue, 08 Feb 2022 01:44:08 -0800 (PST)
Received: from ?IPV6:2a02:578:8593:1200:ba0f:5a93:d93e:ce85? ([2a02:578:8593:1200:ba0f:5a93:d93e:ce85])
        by smtp.gmail.com with ESMTPSA id h1sm2046214eja.201.2022.02.08.01.44.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 08 Feb 2022 01:44:07 -0800 (PST)
Message-ID: <b4df8e13-2177-b50e-4f13-5d909d3bf0a9@tessares.net>
Date: Tue, 8 Feb 2022 10:44:07 +0100
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.1
Subject: Re: [PATCH mptcp-next] mptcp: drop unneeded type casts for hmac
Content-Language: en-GB
To: Geliang Tang <geliang.tang@suse.com>, mptcp@lists.linux.dev
References: <5ea29fecc4db9bc0a9a9d5d10e0f2a61d645d46c.1644228345.git.geliang.tang@suse.com>
From: Matthieu Baerts <matthieu.baerts@tessares.net>
In-Reply-To: <5ea29fecc4db9bc0a9a9d5d10e0f2a61d645d46c.1644228345.git.geliang.tang@suse.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Geliang, Mat,

On 07/02/2022 11:06, Geliang Tang wrote:
> Drop the unneeded type casts to 'unsigned long long' for printing out the
> hmac values in add_addr_hmac_valid() and subflow_thmac_valid().

Thank you for your patch and the review!

Now in our tree (feat. for net-next) with Mat's RvB tag:

- d59d0b9cb2a7: mptcp: drop unneeded type casts for hmac
- Results: e98f6976dd01..a50f1ded83fa

Builds and tests are now in progress:

https://cirrus-ci.com/github/multipath-tcp/mptcp_net-next/export/20220208T094354
https://github.com/multipath-tcp/mptcp_net-next/actions/workflows/build-validation.yml?query=branch:export

Cheers,
Matt
-- 
Tessares | Belgium | Hybrid Access Solutions
www.tessares.net
