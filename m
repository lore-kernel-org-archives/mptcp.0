Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7EC027F1
	for <mptcp@lists.linux.dev>; Fri, 17 Mar 2023 08:00:41 +0000 (UTC)
Received: by mail-pl1-f176.google.com with SMTP id ix20so4531455plb.3
        for <mptcp@lists.linux.dev>; Fri, 17 Mar 2023 01:00:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679040041;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=4axSodYm7h/BNJm0GjFw3QPyJy3MjTh4/w9gm29itNs=;
        b=KtHieplKKdSSyt16iknom/A+exf72LbqoTbo1Plr9qrdmCIIBdNcQAmCE8Yb+w97as
         LVJPqArFdgpmOJ4/fJ0t1s6qFvtGTLabP2JiCyT+vI3WdiZ5bcZhTauRzuIe7pORe/0Q
         rvbppjByaSGCHzM8NoHkl2tEDLFReG/mt4z1tFjT5entkbVZUB41eNx8I3FBeBgoFWO7
         d0smyRpLyvdiv17456OiqUxAyFO90oMTx1prS+qSyc+SADpkjK7wN/ryaGSBv/dHp+kI
         ntM99svq2tEIi1RjrbFrXH2wXPWe1qkrnxB/nlnonzQk4c+lynfC4BnDkKb45/WzS/dM
         nTxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679040041;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=4axSodYm7h/BNJm0GjFw3QPyJy3MjTh4/w9gm29itNs=;
        b=jtGyRzTel8+W/dNNuh2YidSalTr2Js7rN0uTiO5nKn4b+1dHC+XGC/RuekmGnC9x9X
         xqTb9dlX6NPhy1yjqvgl/1dnQ66nzXSmMCVA8yIJHVFzbl8px073ZXSz73iRMxMlfwFw
         7im11Yt3wCISDZDtqvHhYo8IquTZml6Zx+eag63URqUxH57ncghjqg1ecjFrZxNTCs7q
         fmxFIMs0UNngksh3+9ccbJhdMFhvEUW9Qva/X0Cw6gL7xSHxxTc/CVA0lrS3uahIpbaE
         8kRhiwB5GOKYts7LFV80gXG//OqqaSAn66FNDnKFGZuZk9QuqfCQds/soFB2vqA241XP
         5p7A==
X-Gm-Message-State: AO0yUKVGFYHEaQjTznGkBX4POnSPnYXTxeIZ5gz+DvMZd982O87i3eVt
	fJuH04zOYEdZM1RTYSl1v3A=
X-Google-Smtp-Source: AK7set9idfKEqSGsgoRA/rnz8q66k0EBzjhwQ6SP+vXw7pPC5h+sM/sKFKJ5l21t8O4eu3wRNw4c5A==
X-Received: by 2002:a17:90b:180e:b0:233:f394:d83 with SMTP id lw14-20020a17090b180e00b00233f3940d83mr6532920pjb.48.1679040040917;
        Fri, 17 Mar 2023 01:00:40 -0700 (PDT)
Received: from [192.168.43.80] (subs02-180-214-232-2.three.co.id. [180.214.232.2])
        by smtp.gmail.com with ESMTPSA id e13-20020a17090ab38d00b00230b572e90csm802922pjr.35.2023.03.17.01.00.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 17 Mar 2023 01:00:40 -0700 (PDT)
Message-ID: <4822168e-85a5-e507-9429-21d9a222406c@gmail.com>
Date: Fri, 17 Mar 2023 15:00:35 +0700
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH 1/2] docs: process: allow Closes tags with links
Content-Language: en-US
To: Matthieu Baerts <matthieu.baerts@tessares.net>,
 Jonathan Corbet <corbet@lwn.net>, Andy Whitcroft <apw@canonical.com>,
 Joe Perches <joe@perches.com>, Dwaipayan Ray <dwaipayanray1@gmail.com>,
 Lukas Bulwahn <lukas.bulwahn@gmail.com>,
 =?UTF-8?Q?Kai_Wasserb=c3=a4ch?= <kai@dev.carbon-project.org>,
 Thorsten Leemhuis <linux@leemhuis.info>,
 Andrew Morton <akpm@linux-foundation.org>, David Airlie <airlied@gmail.com>,
 Daniel Vetter <daniel@ffwll.ch>
Cc: linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
 dri-devel@lists.freedesktop.org, mptcp@lists.linux.dev
References: <20230314-doc-checkpatch-closes-tag-v1-0-1b83072e9a9a@tessares.net>
 <20230314-doc-checkpatch-closes-tag-v1-1-1b83072e9a9a@tessares.net>
From: Bagas Sanjaya <bagasdotme@gmail.com>
In-Reply-To: <20230314-doc-checkpatch-closes-tag-v1-1-1b83072e9a9a@tessares.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 3/16/23 00:44, Matthieu Baerts wrote:
> +In the same category as linking web pages, a special tag is also used to close
> +issues but only when the mentioned ticketing system can do this operation
> +automatically::
> +
> +        Closes: https://example.com/issues/1234
> +
> +Please use this 'Closes:' tag only if it helps managing issues thanks to
> +automations. If not, pick the 'Link:' one.
> +

What about:

```
Similarly, there is also "Closes:" tag that can be used to close issues when
the underlying tracker can do this operation automatically. For example::

    Closes: <issue link>

For other trackers keep using "Link:" tag instead.
```
?

> +Note that it might be interesting to use the 'Closes:' tag instead of 'Link:'
> +if the URL points to an issue from public bug tracker that can automatically
> +close tickets when such patches containing this tag is accepted upstream. For
> +example::
> +
> +    Closes: https://example.com/issues/1234
> +

This one LGTM.

Thanks.

-- 
An old man doll... just what I always wanted! - Clara

