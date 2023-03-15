Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com [209.85.208.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63E915681
	for <mptcp@lists.linux.dev>; Wed, 15 Mar 2023 18:29:42 +0000 (UTC)
Received: by mail-ed1-f48.google.com with SMTP id z21so13801300edb.4
        for <mptcp@lists.linux.dev>; Wed, 15 Mar 2023 11:29:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares.net; s=google; t=1678904980;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=wFueg1Re7r7oz+bq5GiyyDwW00ISWX7DiVqgOMzRA58=;
        b=z77gvtWr37A/s5VNJqbHRj5RMHdZyDNaJEFQwqIIut4z+DlUSrDiaHl4Kv474TkyTo
         PMtJeodhY9Sdc1cFqKmX02tf7fQ+YA1d30C+EOaFuIJrlIkavn22w+xZcGUZ+Fqtbo+r
         Egc9ZnO2h2BIuPSvNlvQPAEfy/3rhPfKKviynBm2JUBuf3BQCbvXz+Eg0fSuw5gvi7Pe
         6sA0vYN8/haAHMsNb/rZ/6C38LQP/w7PtgyMWswG/t67xwh0lVe2BX/zfDmadUHEdCUF
         rj0os6zkpLGszqEptTMycf7ZSZwPQUdWwhLpusTyJVsYFkLFOHPiUq+pUjjaBcKo3SsX
         X2Fg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678904980;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=wFueg1Re7r7oz+bq5GiyyDwW00ISWX7DiVqgOMzRA58=;
        b=TvwWRp0ECS2g6CSe1ol3VUGy6c9Pv8glHGY85P4lPhKHgDyqnq3poO83DIeVFRccur
         Xj/WefLR+fmo7Wfh5qkiiwbZ8P/wDAD4+I7eLZkwusfE2MlcJQktU6Sxw70j4w+sDHrV
         1wlsDWCUaw3/lVmaoQ8QtseFNiCoGBSH1+n8r+cJ8mNKMqTvBcV2IxrrCpWkZx0fejxZ
         gwy1flT4oCLksdlLbp5M9fZamb9ih2I4WWKEEY6dirhG29df9B9CMrgXpudfMUG78DAB
         95URo9KrVbCnkIFdrYJR0Tm5IUj59n2hyd250wNrhBWxsCfi7XCRXl2vHe53ckzoB23S
         b20g==
X-Gm-Message-State: AO0yUKW/byLl5tbtOkLbW5RvygXOsPhgnSref+bz9GKpXwN7XQll+HGg
	maJuZHukOsGRc+UDnsThEe+TDQ==
X-Google-Smtp-Source: AK7set9V2+oXGXLvqaa5erAztcj3u7fMWk+JUhyXOLyZzl8OTMMm30BM9l3QFu8UbAHFwKCWN/EDrg==
X-Received: by 2002:a17:906:7e4e:b0:929:bd3:eab4 with SMTP id z14-20020a1709067e4e00b009290bd3eab4mr7111332ejr.68.1678904980521;
        Wed, 15 Mar 2023 11:29:40 -0700 (PDT)
Received: from [10.124.6.19] ([195.181.172.151])
        by smtp.gmail.com with ESMTPSA id k1-20020a508ac1000000b004c0239e41d8sm2860526edk.81.2023.03.15.11.29.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 15 Mar 2023 11:29:40 -0700 (PDT)
Message-ID: <1126b5c9-0742-0d3e-f483-8f08ea22aec4@tessares.net>
Date: Wed, 15 Mar 2023 19:29:39 +0100
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH 1/2] docs: process: allow Closes tags with links
Content-Language: en-GB
To: Konstantin Ryabitsev <konstantin@linuxfoundation.org>
Cc: Jonathan Corbet <corbet@lwn.net>, Andy Whitcroft <apw@canonical.com>,
 Joe Perches <joe@perches.com>, Dwaipayan Ray <dwaipayanray1@gmail.com>,
 Lukas Bulwahn <lukas.bulwahn@gmail.com>,
 =?UTF-8?Q?Kai_Wasserb=c3=a4ch?= <kai@dev.carbon-project.org>,
 Thorsten Leemhuis <linux@leemhuis.info>,
 Andrew Morton <akpm@linux-foundation.org>, David Airlie <airlied@gmail.com>,
 Daniel Vetter <daniel@ffwll.ch>, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
 mptcp@lists.linux.dev
References: <20230314-doc-checkpatch-closes-tag-v1-0-1b83072e9a9a@tessares.net>
 <20230314-doc-checkpatch-closes-tag-v1-1-1b83072e9a9a@tessares.net>
 <20230315181205.f3av7h6owqzzw64p@meerkat.local>
From: Matthieu Baerts <matthieu.baerts@tessares.net>
In-Reply-To: <20230315181205.f3av7h6owqzzw64p@meerkat.local>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Konstantin,

On 15/03/2023 19:12, Konstantin Ryabitsev wrote:
> On Wed, Mar 15, 2023 at 06:44:56PM +0100, Matthieu Baerts wrote:
>> Note that thanks to this "Closes" tag, the mentioned bug trackers can
>> also locate where a patch has been applied in different branches and
>> repositories. If only the "Link" tag is used, the tracking can also be
>> done but the ticket will not be closed and a manual operation will be
>> needed.
> 
> We will soon gain this ability on bugzilla.kernel.org as one of the features
> of the bugbot integration tool (which is still WIP).

Good news! This feature will be helpful for bugzilla users!

> So, if it helps, I
> support making this a recognized trailer.
Thank you for your support!

Cheers,
Matt
-- 
Tessares | Belgium | Hybrid Access Solutions
www.tessares.net
