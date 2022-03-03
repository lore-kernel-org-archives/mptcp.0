Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com [209.85.208.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8A137E
	for <mptcp@lists.linux.dev>; Thu,  3 Mar 2022 15:25:59 +0000 (UTC)
Received: by mail-ed1-f44.google.com with SMTP id x5so7045231edd.11
        for <mptcp@lists.linux.dev>; Thu, 03 Mar 2022 07:25:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares-net.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :references:from:in-reply-to:content-transfer-encoding;
        bh=csviJkLwRKJf+5OrQEhbn28qesi/3nQic5yEAZeLYVE=;
        b=jb4k1WMTCzPalgytkc3xcm9r1PPTWGvRqoslQvl0vAx96jTKl/85wKCMUJvRRZT67R
         FzlnddaPHXImQjb5MW2TT0F8mX4ZscNi3l4Kck6iQ4hVMD9acl243waXabOpkbqdCw7t
         gvxUV8/psJ3Z7MnW2hZf8Qn7GwSxzQHGgG0lPhsZBX4VT4VLqXbqboIgcuLaDJ4qyyvM
         jhvcptIEagzk/NwFDrN0ApCFaqtJ8svnCEBTKWdGqXl/BnHl+7FAHzUFN8dlve84RvyM
         0/eyYlWCBPvURXLhvRXfzAAxeAsnb2lqFldMwGw34lyOsMU3+7uToZx2ptE68dYP0kv6
         mrRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:references:from:in-reply-to
         :content-transfer-encoding;
        bh=csviJkLwRKJf+5OrQEhbn28qesi/3nQic5yEAZeLYVE=;
        b=LtH21ibBhsmmFjMWEHAKsr1TICXd0mdTpMTFZEen/SZoJxdS605PKD3nTH9sjxnUvn
         CjG967FAKvS72OJRJ9TWbsSP8PTzxbU5kd+LBtlieMJm1twkdVMaCtkHwtdC2GqWRjLx
         8tfkwRQtIfzml+svhHp3Q2VMKiKvfBMva7yYhe0A+FcBm8/wcC8qbAb3BqwOl6DBBK3z
         Cl5kXK2Itmwup1E0KZ786M+pccoJXn87QS5s1MzQEklS74qYxxBB5fayuXwa2x6OAsCq
         e1FzTvGdcyuF1cuezOIqpCpZbiavvqoyiKxviBUYmkCeMikCHu05e6LOhq6Y369nrhNz
         drUw==
X-Gm-Message-State: AOAM533MtYJDuMFUr06jXvIZrHamTiuBKhAUYtdH0iJcpvSbIOjWrsTP
	bFPgm9A+R6MyS1SjnrIKjQ1/VQ==
X-Google-Smtp-Source: ABdhPJyBw4HFgs/jljIDDmVj3GTPwmav33XwSgt6C2CdNJAJknZ8APLkikCxzjK3eQeKWiiRNchXKw==
X-Received: by 2002:a05:6402:270a:b0:410:a3a4:ba06 with SMTP id y10-20020a056402270a00b00410a3a4ba06mr34591768edd.293.1646321157970;
        Thu, 03 Mar 2022 07:25:57 -0800 (PST)
Received: from ?IPV6:2a02:578:8593:1200:9692:b15:c6e7:1c2e? ([2a02:578:8593:1200:9692:b15:c6e7:1c2e])
        by smtp.gmail.com with ESMTPSA id ce7-20020a170906b24700b006cf095c2f5bsm810789ejb.83.2022.03.03.07.25.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 03 Mar 2022 07:25:57 -0800 (PST)
Message-ID: <9475684e-8425-7992-7549-56ee6ea31872@tessares.net>
Date: Thu, 3 Mar 2022 16:25:56 +0100
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.1
Subject: Re: [PATCH RESEND mptcp-next v5 0/3] new bpf_mptcp_sock()
Content-Language: en-GB
To: Geliang Tang <geliang.tang@suse.com>, mptcp@lists.linux.dev
References: <cover.1646320786.git.geliang.tang@suse.com>
From: Matthieu Baerts <matthieu.baerts@tessares.net>
In-Reply-To: <cover.1646320786.git.geliang.tang@suse.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Geliang,

On 03/03/2022 16:22, Geliang Tang wrote:
> RESEND:
>  - fix the CI Build Failure.

For the next series, may you bump the version instead of using 'RESEND'.

It would be clearer. Bumping the version is not costly and typically,
'RESEND' means "resending the exact same content, potentially rebased".

Cheers,
Matt
-- 
Tessares | Belgium | Hybrid Access Solutions
www.tessares.net
