Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C47ED23CD
	for <mptcp@lists.linux.dev>; Tue,  9 Aug 2022 16:40:23 +0000 (UTC)
Received: by mail-ej1-f47.google.com with SMTP id gk3so23173792ejb.8
        for <mptcp@lists.linux.dev>; Tue, 09 Aug 2022 09:40:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares.net; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :references:from:in-reply-to:content-transfer-encoding;
        bh=OxD2kiwoodTUkPm0qPx+ojJoC5zBLayKjarCs5yGv8g=;
        b=dRR5OpgXReZueMvUs/NE3ky95Y2h5c2hE+RZOEV5eooPgh9UXu8a27alvOgjm20qTy
         L02e67tQh/Growkgjofr9IGsfq7J9f6D4CT5E/8b7D/QEJcMEz7edId7zkkiojT0EGaZ
         ZZ38x4tF9CH7W08+5KMtozNqm813igdR0Sz9tu++Pb1LZ1h09LgRxq594lhuPhmQ29mO
         8RJ7HBN9snsndkj15E6JE/xH+5n6yzihMRvYiuzPbY1cXO5SvJTPOogSldpxhPkkyhCO
         y500NlJYeFRG2ukungBkv3pqbJViu9zy2BXd71OGrTlMvADdS4idQVVdkNJsa8F/Ysk6
         e0Lw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:references:from:in-reply-to
         :content-transfer-encoding;
        bh=OxD2kiwoodTUkPm0qPx+ojJoC5zBLayKjarCs5yGv8g=;
        b=XH93hfe+6YqEESuuwbdl4GrCblom6sb7eNOoVl+RuW+nKLNyTwUiXovtzfZ0NEIYDp
         BJJXzqEd7jasBPnHDq0HKLErGHQ2AkNq7swj7KzvYrCO64/jAOd2Q6im99t884kTM9o0
         m6CMd+WqPG+v/waKq9+8b+ewJAm0Lfu7eChLC5Xbj1N3fqfD2or5ecSo8K8hIlsP35dB
         TUSJUgysgIF4yxjhHtAlDVkZxT1XBt4t/g42OyABPkmc13HM/3bzSND+6nzBbF8hr5R7
         wAYgBu9f1T+u6Bzm5qSIuxDWL5ZchpHBt2avZv+YMuE3oT/VHffCuuE4vo0ScOP44P5i
         dfHQ==
X-Gm-Message-State: ACgBeo0ABsC90OH+1MNvNwyrXBvjEyyg3H5ftvSH4QZj6GzEWtnUuepE
	UWEaZ9gwKeFIRYlwzfR1QZcxxic+++UOMA==
X-Google-Smtp-Source: AA6agR7F21DfKitU2gYh3TMUNidjZPFA7QyhO0A3XyFphpmsVyXQumEpXT9DvYuuj/tRj16tvy7wKw==
X-Received: by 2002:a17:907:929:b0:731:3bb6:d454 with SMTP id au9-20020a170907092900b007313bb6d454mr9777025ejc.96.1660063221635;
        Tue, 09 Aug 2022 09:40:21 -0700 (PDT)
Received: from ?IPV6:2a02:578:8593:1200:ae2f:6836:2e67:a090? ([2a02:578:8593:1200:ae2f:6836:2e67:a090])
        by smtp.gmail.com with ESMTPSA id cz18-20020a0564021cb200b0043d1eff72b3sm6382990edb.74.2022.08.09.09.40.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 09 Aug 2022 09:40:21 -0700 (PDT)
Message-ID: <8eb663d9-744b-8c0b-1863-62a69bfecfba@tessares.net>
Date: Tue, 9 Aug 2022 18:40:19 +0200
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.1.0
Subject: Re: [PATCH mptcp-next] selftests: mptcp: move prefix tests of
 addr_nr_ns2 together
Content-Language: en-GB
To: Geliang Tang <geliang.tang@suse.com>, mptcp@lists.linux.dev
References: <a13144785eab9f2568fdf9eb7da6714d4a911756.1659923077.git.geliang.tang@suse.com>
From: Matthieu Baerts <matthieu.baerts@tessares.net>
In-Reply-To: <a13144785eab9f2568fdf9eb7da6714d4a911756.1659923077.git.geliang.tang@suse.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Geliang, Mat,

On 08/08/2022 03:44, Geliang Tang wrote:
> Move the fullmesh prefix test of addr_nr_ns2 together with its other
> prefix tests.

I'm glad to see you back!

Now in our tree (feat. for net-next) with Mat's RvB tag:

New patches for t/upstream:
- 1f2452544e4e: selftests: mptcp: move prefix tests of addr_nr_ns2 together
- Results: 8b0cb8f8874a..cb5660da7192 (export)


Tests are now in progress:

https://cirrus-ci.com/github/multipath-tcp/mptcp_net-next/export/20220809T163858

Cheers,
Matt
-- 
Tessares | Belgium | Hybrid Access Solutions
www.tessares.net
