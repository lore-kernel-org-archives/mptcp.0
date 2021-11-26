Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com [209.85.208.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 553D272
	for <mptcp@lists.linux.dev>; Fri, 26 Nov 2021 17:53:32 +0000 (UTC)
Received: by mail-ed1-f44.google.com with SMTP id w1so42061802edc.6
        for <mptcp@lists.linux.dev>; Fri, 26 Nov 2021 09:53:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares-net.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :references:cc:from:in-reply-to:content-transfer-encoding;
        bh=i5Sq+BSB0VwzbQcd8zPzsFXFbbNsWb8fmF7OmFLru1E=;
        b=KMniw08DSF2zphcu/5pzZQALt623zzUvb6+sMP7IZJb7RZZYICKS+ERKtM9p4P6FQe
         Hq0J2V9dVpzuWi/kmrCJZM9QcItLtoANSjL5ULuAAhtMr8fgg1YNsciC7FCrow+qOJfY
         0ubGozEfa5f6rLJ4ckHUV2MAYeEI7Ft5e8K3Vq9K7P6Kv/ga3mHT7m99x0SQxT4sH/ZJ
         oAUWcVO4wNo9bi1SjfeXAr37/MMy1biWu+oJtgnW1cHzYFW+uwVwAQ1Sy0p/LggJfj61
         v1/dDYDi/usNwcF6AgtbCVQGMDPw/c7WbCSUnRxPLfS1Qg6cJN7AEWSq7+Zp7tiXaAhh
         L/Og==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:references:cc:from:in-reply-to
         :content-transfer-encoding;
        bh=i5Sq+BSB0VwzbQcd8zPzsFXFbbNsWb8fmF7OmFLru1E=;
        b=5hNouvPh0WPLpdOB33+dMuFvOlz2CrIOVnwJNUMBPirI4PPWBHqxxLzoS4MmweJwq6
         ep/dfckPW7LBgGAL1JCFQudeJg1Ybk/7apBIrcNcAy7/1/GxjDdkGIq6pR3rVnPh9hCz
         Th8BSlRnWyYzTsewG/vO0wDCCALZiI6JkMzbdYzzWr/Kb0wQcw6/j5pekfRdqFu9ghGk
         pClJPT+G4By9ZqzybNKf6BkC4lXcBG/RSAdTkX+mQaP+fdljQC3R/duspvcfApWs2svi
         xGAIPFamIhYrCZucy6V6It3gp4OrgM6f39VDsn9XpCMsPbjL6gf3JFYev8iF9BBBL5mP
         fbnw==
X-Gm-Message-State: AOAM5328v1zEAHe5GD8Z/d8yOvI2Rq2K7xHzxpi2aessKFwT7udbj59w
	LKyPbyZ83bOpSu3d5AtBQVNK5w==
X-Google-Smtp-Source: ABdhPJwVFD2i21/dbSxLCYTqSliJ5PIJYa465n0xqAJeQ0iSj+xf9XYNj1DCH6nrJ2UYluKyxnwi1g==
X-Received: by 2002:a05:6402:3496:: with SMTP id v22mr48349333edc.177.1637949210555;
        Fri, 26 Nov 2021 09:53:30 -0800 (PST)
Received: from [192.168.178.33] (213.211.136.227.static.edpnet.net. [213.211.136.227])
        by smtp.gmail.com with ESMTPSA id nb4sm3578350ejc.21.2021.11.26.09.53.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 26 Nov 2021 09:53:30 -0800 (PST)
Message-ID: <654763ae-9755-c9cf-2fdd-8d83c9693174@tessares.net>
Date: Fri, 26 Nov 2021 18:53:29 +0100
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.2
Subject: Re: [PATCH v2 mptcp-next 2/4] mptcp: keep track of used local
 endpoint
Content-Language: en-GB
To: Paolo Abeni <pabeni@redhat.com>
References: <cover.1637929034.git.pabeni@redhat.com>
 <a44a4d8c356f2318b75d174e701c42d5ea50edbc.1637929034.git.pabeni@redhat.com>
Cc: mptcp@lists.linux.dev
From: Matthieu Baerts <matthieu.baerts@tessares.net>
In-Reply-To: <a44a4d8c356f2318b75d174e701c42d5ea50edbc.1637929034.git.pabeni@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Paolo,

On 26/11/2021 13:19, Paolo Abeni wrote:
> So that we can skip already used endpoint at local address
> selection time.
> This allows for fair local endpoints usage in case of subflow
> failure.
> 
> As a side effect, this patch also enforces that each endpoint
> is used at most once for each mptcp connection.
> 
> Signed-off-by: Paolo Abeni <pabeni@redhat.com>

Good idea!

Reviewed-by: Matthieu Baerts <matthieu.baerts@tessares.net>


Cheers,
Matt
-- 
Tessares | Belgium | Hybrid Access Solutions
www.tessares.net
