Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A63053A4
	for <mptcp@lists.linux.dev>; Mon, 29 Aug 2022 15:47:03 +0000 (UTC)
Received: by mail-wm1-f46.google.com with SMTP id s23so4452122wmj.4
        for <mptcp@lists.linux.dev>; Mon, 29 Aug 2022 08:47:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares.net; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc;
        bh=nC6scMiosLdiBGv4d7ZPDmDIzorPzcGBFyBOnRSDlNU=;
        b=r3Yj/L7BcBqCNucpbit0WP+BRb6fjGcn05+6nU6+LOxYksth/2zDcmpB70XSjepCBJ
         hYQSrfdIyyhTsKgjWTr2vL+nHeeGbNSAVup8wl4s6Plgt5rn7hL4ZFluiHKMitADWJX8
         PT/gij/DQfFW97x1IcXffmW2IfBqXERHsJoRrs1PMDuMwxcCLn12rf7eHb26BEVMrJCz
         N8YC6x6bzU4ZQnVJ9d5F08e9qGF1T72dnCKPe9OuXt4/mrq0bQX/OfPgM9EM3HK/jCDE
         yk+l3wfxvHjkw7ICh33KHRNAH6L2RgoIjmycpdM+4OPvWrzZjG7P7wScur4S4uVsrd2e
         r4yw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc;
        bh=nC6scMiosLdiBGv4d7ZPDmDIzorPzcGBFyBOnRSDlNU=;
        b=BrEhr8BTYP1zgu3HdBw0o6rBjZRsDwfitNEPKeNsoDGuMjTeGwdOfA2PUzyFaJe0WP
         0zp6Lefdft3b8vC/5j9uF9A9hPz5YMyhbhQtvWGXhPp2C+ThPcKb7giTaa8uWV0bZoFS
         P48K0xxXHoqI7FMUJzLgLSwPviA16Dh2SGS1y4YmeGGm2Gv184DmHQWPOtotipOBCCHD
         C9Tt9slZkeXxgLXPMebMf7l++mEA8X/uA0/G2gIakqqSQFcAclAQrlsz+7FkpmZrnyzL
         p6VdN3Tusfqyz0ubaH/ayVs/8YP5O4gyiuzMmFYvyRNA9nJiqISOoiuh2yzu6gEpsN7E
         +zjg==
X-Gm-Message-State: ACgBeo3796sVzhE8Pv0WjS/+M7yunvIA2cu1w54PZ0jz67YQskkeNogp
	R4VjV3xp4tXJuA9lV7KqkOiEAAvp5Br7cw==
X-Google-Smtp-Source: AA6agR5NyDsP4paMGY+8c84P2GwaJ2FnzCNjQtBGw/9JdrN1Vk7F2Kl/zO0Qikb4Dnm7SIqDnYafRw==
X-Received: by 2002:a7b:c5c3:0:b0:3a6:14f3:8ea7 with SMTP id n3-20020a7bc5c3000000b003a614f38ea7mr6943382wmk.76.1661788022197;
        Mon, 29 Aug 2022 08:47:02 -0700 (PDT)
Received: from [10.44.2.26] ([81.246.10.41])
        by smtp.gmail.com with ESMTPSA id j18-20020a05600c191200b003a5c1e916c8sm31147942wmq.1.2022.08.29.08.47.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 29 Aug 2022 08:47:01 -0700 (PDT)
Message-ID: <a1bb945c-a978-79c4-d523-35aa1e267dcd@tessares.net>
Date: Mon, 29 Aug 2022 17:47:01 +0200
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.1.2
Subject: Re: [PATCH mptcp-next] mptcp: add do_check_data_fin to replace copied
Content-Language: en-GB
To: Geliang Tang <geliang.tang@suse.com>, mptcp@lists.linux.dev
Cc: Mat Martineau <mathew.j.martineau@linux.intel.com>
References: <95f0f96d90264cc6411b024753fe8430f6998e4f.1661258990.git.geliang.tang@suse.com>
From: Matthieu Baerts <matthieu.baerts@tessares.net>
In-Reply-To: <95f0f96d90264cc6411b024753fe8430f6998e4f.1661258990.git.geliang.tang@suse.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Geliang,

On 23/08/2022 14:52, Geliang Tang wrote:
> This patch adds a new bool variable 'do_check_data_fin' to replace the
> original int variable 'copied' in __mptcp_push_pending(), check it to
> determine whether to call __mptcp_check_send_data_fin().

Thank you for this clean-up! (and good to see you around again!)
Sorry for the delay, I had a few days off but it is now in our tree
(feat. for net-next):

New patches for t/upstream:
- 695cc660c6c6: mptcp: add do_check_data_fin to replace copied
- Results: 276e5dcffc80..0838c359eb16 (export)

Tests are now in progress:

https://cirrus-ci.com/github/multipath-tcp/mptcp_net-next/export/20220829T154355

> @@ -1510,7 +1511,7 @@ void __mptcp_push_pending(struct sock *sk, unsigned int flags)
>  			}
>  
>  			info.sent += ret;
> -			copied += ret;
> +			do_check_data_fin = true;

Note that I just moved this new line one line above to do the two
operations with 'ret' together.

>  			len -= ret;
>  
>  			mptcp_update_post_push(msk, dfrag, ret);

Cheers,
Matt
-- 
Tessares | Belgium | Hybrid Access Solutions
www.tessares.net
