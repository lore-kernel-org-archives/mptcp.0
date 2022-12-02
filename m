Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43A1D1FA9
	for <mptcp@lists.linux.dev>; Fri,  2 Dec 2022 10:20:42 +0000 (UTC)
Received: by mail-ej1-f50.google.com with SMTP id gu23so10448887ejb.10
        for <mptcp@lists.linux.dev>; Fri, 02 Dec 2022 02:20:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares.net; s=google;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:from:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=neTrFFrBwAUeTHsfC9CfrLaCSjAVw/Zq76J75ZEPiLw=;
        b=KVelgjcGldd7Je0Z+u5etQe9xLpN2BGtp87DV8e50EWt36G8fD1Civ+CxrKvUEo/LS
         jXrxLFx52qXsBhVPDTHiY405x948BuZlUg/3QZjW89xjYTFH+YNuGsfXP4TMvMyqI82n
         syQ3CdJQ3jp9JfTTSufesGjjgO1+e+wTVGAOu0sIkBnYlryYjcHtu9EQEdy9m0O7Tbku
         xrlWzL99+PEhV698Y1VaGhpJ9vfP18i1w1pHP9nugZeYS5m56V311ehN/1x0t1Z0xilb
         GaAf3EPVZLAXJKZjrTJb9yn5lWExESF4kjOrQa0n5PsE+srK55Z4qNV8jlS3MA4tBoxs
         bfmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:from:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=neTrFFrBwAUeTHsfC9CfrLaCSjAVw/Zq76J75ZEPiLw=;
        b=5efvdSzyPf/Tgk9G4+FYBz6sK4Oc40njEF+G0DRP1jMtZgt2wShvDLmJkadXsyRPBz
         sKgyCWfMeiP64vNciVuez9I1aa/NywJqNghpqBNFVmStiQ7dF2Fb26Bi8DWIzAqYTFeS
         KkndZUh99nUOyR8lDmarqsFX7/Jj1nXATqO9Zj3U7/HE90izWd++knWAhdMKrEvCsNv4
         GyE7hUmY0gJ84iRFZN5ReGZJYwBQrfeCbfMPHmtPMIXY08cMUJrxv7Sr3568fIr0tcw8
         xLH3vLt97lJEy8EP4xOPE73sEABOB1CicPC1QB96YfxZ90KAem+6EKviQ57CeLLNzr4k
         fI2w==
X-Gm-Message-State: ANoB5pmVwN1gmR01M6AWfmKUdqnjug2mAKa0YTdWaHWFCX0RVRrylVVu
	IoCm468zsIwYUXLKzKymUJvsaskFgFFRoKFT
X-Google-Smtp-Source: AA0mqf4n4hLgIEspKlD1Z92yvj0d+5/aqdEPUoxLHrrPVNFP/ZYoA9Ld7IgwADAZzAZrO69dRl2eGA==
X-Received: by 2002:a17:906:6bd8:b0:78b:a8d:e76a with SMTP id t24-20020a1709066bd800b0078b0a8de76amr4559160ejs.725.1669976441009;
        Fri, 02 Dec 2022 02:20:41 -0800 (PST)
Received: from [10.44.2.26] ([81.246.10.41])
        by smtp.gmail.com with ESMTPSA id g9-20020a17090670c900b0077f324979absm2828741ejk.67.2022.12.02.02.20.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 02 Dec 2022 02:20:40 -0800 (PST)
Message-ID: <ed2e87b2-932e-b386-e2c6-c1b81ccec7a7@tessares.net>
Date: Fri, 2 Dec 2022 11:20:40 +0100
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.0
From: Matthieu Baerts <matthieu.baerts@tessares.net>
Subject: Re: [PATCH mptcp-next] mptcp: use nlmsg_free instead of kfree_skb
To: Geliang Tang <geliang.tang@suse.com>, mptcp@lists.linux.dev
Cc: Jakub Kicinski <kuba@kernel.org>
References: <20221202053736.2980-1-geliang.tang@suse.com>
Content-Language: en-GB
In-Reply-To: <20221202053736.2980-1-geliang.tang@suse.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Geliang,

On 02/12/2022 06:37, Geliang Tang wrote:
> Use nlmsg_free() instead of kfree_skb() in pm_netlink.c.

Thank you for the quick follow up!

I suggest to add a bit more text to have a clear explanation about why
it is clean-up and not a fix, e.g.

  The skb has been created by nlmsg_new(). The proper free should then
  be done with nlmsg_free().

  For the moment, nlmsg_free() is simply calling kfree_skb() so we
  don't change the behaviour here.

I can modify the commit message when applying the patch, no need to send
a v2 ;-)

Reviewed-by: Matthieu Baerts <matthieu.baerts@tessares.net>

Cheers,
Matt
-- 
Tessares | Belgium | Hybrid Access Solutions
www.tessares.net
