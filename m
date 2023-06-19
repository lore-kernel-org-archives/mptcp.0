Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com [209.85.208.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF2EAC8FF
	for <mptcp@lists.linux.dev>; Mon, 19 Jun 2023 14:56:50 +0000 (UTC)
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-5196a728d90so4870863a12.0
        for <mptcp@lists.linux.dev>; Mon, 19 Jun 2023 07:56:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares.net; s=google; t=1687186608; x=1689778608;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=cp2nYtxG1nNaIxrkUbrHWFZbSgt+zQvdUfHUFfP5qHk=;
        b=R7rxi17rkM/CKzosxSxDt9qO/UHnGQZBjE168ijOuZ0+bDKvW0UGVaIk5syuljntIX
         IP5gpYQWlpOm1FkuvSRGGc+JUE/Di3EP8cDrushjBd4l0C4FOELibrzPHaL9K4BXXc4B
         y017JS6jhA14iJLsOd8Xipw087CSEBsl0B9xi4QdM/eAJrhxTBA4Q4kg+2wAOuwuSdN7
         u9MLYTf+5MFcdAFlFxQ0cpW7+oLcQQ+RIYLS690Pn8ilYKZuCc4a6DaJ6qjXIaXRSsib
         cUzvi3hYlX1/szeVMLCrymcY4Mnhe0Gp5wzj5KNT/iZah845QSgp1jP73lu6/SgnI1sc
         MyBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687186608; x=1689778608;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=cp2nYtxG1nNaIxrkUbrHWFZbSgt+zQvdUfHUFfP5qHk=;
        b=Cowt99o2J8MIVKM0uP1lJD2luNrjwb2yABaljI0fK/FNapuwTMstw7dpyDSjVy8Zvr
         11OYWCOfyGEqhTIYZD2ofH7FwXioI9DKrBKeYtwzDxrJG9OmjeFIS9qSYyJg+gTWuxpG
         75wxcSii33PdCVgos/VlFFYTPBeheDoFqdaNE6SB2rFBieHecFMsuq+tt5y4DwdiHto4
         N8PfjQIRSvppVKColJ7a3zCmSQi9enE9h6raLXa0UVm7I221uOnzMg5Ffydpuke0LVXu
         2vUKFOysfgSennM6HGdueS5HcZdQPYG2TSsXkXdy19UP3c7xn+cMm8USSf9MyNmIl1Ip
         Rduw==
X-Gm-Message-State: AC+VfDyWm0313aX2g5m1vWylXq3pwRUfOcS1NsRTPIJ5M3EC/54D6lJV
	1dNKkhxWxiiCu6qJe+HY2HrcZ7KU+M2tWhHbzSs=
X-Google-Smtp-Source: ACHHUZ6Fg1N9GX0eGRfzIVls6/CW3Zlr5+NakkqPXs2wQiD4S29SN1XcqW2micmQcbPV2aK8cfV0sA==
X-Received: by 2002:a50:ef19:0:b0:51b:ac91:9f58 with SMTP id m25-20020a50ef19000000b0051bac919f58mr828936eds.4.1687186608714;
        Mon, 19 Jun 2023 07:56:48 -0700 (PDT)
Received: from [10.44.2.5] ([81.246.10.41])
        by smtp.gmail.com with ESMTPSA id w3-20020aa7cb43000000b0051a5437a6c5sm1694070edt.22.2023.06.19.07.56.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 19 Jun 2023 07:56:48 -0700 (PDT)
Message-ID: <1b01f8fe-35e2-2b08-a58a-f473f041fdcd@tessares.net>
Date: Mon, 19 Jun 2023 16:56:48 +0200
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH mptcp-next v20 00/10] update userspace pm mptcp_info
 fields part 2
Content-Language: en-GB
To: Geliang Tang <geliang.tang@suse.com>, mptcp@lists.linux.dev
References: <cover.1686900596.git.geliang.tang@suse.com>
From: Matthieu Baerts <matthieu.baerts@tessares.net>
In-Reply-To: <cover.1686900596.git.geliang.tang@suse.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Geliang,

On 16/06/2023 09:30, Geliang Tang wrote:
> v20:
>  - #1-#8, only update the commit logs with warnings reported by checkpatch.
>  - #10 don't update the tests which needs to be slower than before.
> 
> v19:
>  - rename to userspace_pm_rm_sf_addr_ns1/2, and call wait_rm_addr and
>    wait_rm_sf in them.
>  - update chk_mptcp_info.
>  - set FAILING_LINKS in run_tests
>  - update commit logs.

Thank you for the new versions! (and sorry for the delay)

The first 8 patches look good to me, just a small request for patch 3/10
but I can also apply a squash-to patch or do the modifications myself
when applying them if that's OK for you.

Reviewed-by: Matthieu Baerts <matthieu.baerts@tessares.net>

For patches 9 and 10/10, I have a few questions, especially for 10/10
where I don't understand why it is needed. Do you mind explaining that
before sending a new version (if needed)?.

Cheers,
Matt
-- 
Tessares | Belgium | Hybrid Access Solutions
www.tessares.net
