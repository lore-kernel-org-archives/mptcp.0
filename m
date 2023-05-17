Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67496171A2
	for <mptcp@lists.linux.dev>; Wed, 17 May 2023 16:14:55 +0000 (UTC)
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-3f423521b10so7078285e9.0
        for <mptcp@lists.linux.dev>; Wed, 17 May 2023 09:14:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares.net; s=google; t=1684340093; x=1686932093;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=T6kTT5RWCZM6MkGmx7i39/Z76jP36ww6+TrY7s/GSTU=;
        b=OwyB8+kcWhcODFtnQ14eTKKCfTMXtg1RmqijMxUqU2+X3++dW1BfTQy/wDj+vDlUR+
         j4wr4/b7qp2Pjz0LWSU8G1XsOKEyhHiHKRv1yzn45FV40Wqi1nM+Jbp9xQ2nopl7f5dS
         MBWJmjgtk6Jf8Sh71JP78KvanSzo0dqq3OcdY6mVQdAiekjj81Pf+XzVlKrgJnswLHDS
         ulotmVuTm7glgtODpRKnXAOwoDmKVm6g8o0bQugspDAdydAvHgAbT3jhatejTxyUrAGB
         G5/SFsvnSvkX1PsFlmBobde5bsqNWFVLduNKh+u5FYSJCtq3rRTQr7yKNFAjYp+pq08Q
         Q9FQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684340093; x=1686932093;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=T6kTT5RWCZM6MkGmx7i39/Z76jP36ww6+TrY7s/GSTU=;
        b=Ep+5IejU3OIkdeHYz+r+Ox5QTXGubKUUYO8NgyQAEo3G+WyU02PWM+DrLBbxWnMrxG
         vTyrxThI0a+v2UIaz70c0PJhjl3iiBnv/a9ruEyXWOK09n+jmUv0Z10A2BC8rMPvueKT
         ldEikRYMcmguWJBSWYrJmP6lc0D8mYyX6oxFXev62+W9XCmUzV/CqVAE5SGSC8jTK6tJ
         VTlTgZfqE3OtKv3PnvJcdASGtU1bp3A2uzmy2KpAIyt2e/I7Sr9911wlV/4GP5Slk8mS
         4EGGXVLU7YsJQz7zO8lm9uzczKAxAtWCUq1dTKmLFr/a7MJrSGj00YElKwj/V57R521r
         yWfw==
X-Gm-Message-State: AC+VfDzS+QN/JCkQXpgOlG/76afSrboOe6q4S3xB4Tc4dRN90lkI+Rcb
	GMW2HoUKtw6KCQuBDPq/A1DemaTl+0F1T0Ja6I4=
X-Google-Smtp-Source: ACHHUZ4AZTB7aqVbcBn+hn2NFR42ZR7Lh0pKQ08t7dSRt//8NgLJ+lCRQ5xaCe4mEAk5E/62ahmXYw==
X-Received: by 2002:a7b:c044:0:b0:3f5:8834:c511 with SMTP id u4-20020a7bc044000000b003f58834c511mr2041640wmc.7.1684340093385;
        Wed, 17 May 2023 09:14:53 -0700 (PDT)
Received: from ?IPV6:2a02:578:8593:1200:a66b:672f:3b69:b6da? ([2a02:578:8593:1200:a66b:672f:3b69:b6da])
        by smtp.gmail.com with ESMTPSA id y20-20020a05600c365400b003f42bb3a5adsm2780625wmq.4.2023.05.17.09.14.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 17 May 2023 09:14:53 -0700 (PDT)
Message-ID: <f8d707c8-de77-2c98-c5c2-e989b98e6fc3@tessares.net>
Date: Wed, 17 May 2023 18:14:52 +0200
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH mptcp-next v13 0/5] update userspace pm mptcp_info fields
 pt 1
Content-Language: en-GB
To: Geliang Tang <geliang.tang@suse.com>, mptcp@lists.linux.dev
References: <cover.1683692137.git.geliang.tang@suse.com>
From: Matthieu Baerts <matthieu.baerts@tessares.net>
In-Reply-To: <cover.1683692137.git.geliang.tang@suse.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Geliang,

On 10/05/2023 06:20, Geliang Tang wrote:
> v13:
>  - move the RM_ADDR command after the destruction of the subflow in
>    patch 2 and patch 5.
>  - drop mptcp_pm_remove_anno_list_by_saddr in mptcp_nl_cmd_sf_destroy in
>    patch 4.
>  - update userspace_pm.sh too in patch 5.

Thank you for the v12 and v13 and sorry for the delay!

I think we are almost there. The last thing is linked to the
modifications you did in this v13: I think we should destroy the local
addresses in mptcp_nl_cmd_sf_destroy(), see my comment in patch 4/5.
But we still need the modifications in userspace_pm.sh to send the
RM_ADDR (or change the verify step not to expect seeing a RM_ADDR).

Also, it looks like the 6 first patches (5 patches from part 1 and the
1st one of part 2) are for "net" while the other ones are for
"net-next". Do you mind sending these 6 patches first,  wait for me to
apply them, then we look at the second part for net-next?

(I have a bunch of patches in preparation modifying the selftests and
that's for -net. It will be easier to apply them first and then look at
the new features: I can help with the rebase, no issue with that.)

Cheers,
Matt
-- 
Tessares | Belgium | Hybrid Access Solutions
www.tessares.net
