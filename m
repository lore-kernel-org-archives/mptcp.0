Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 608B272
	for <mptcp@lists.linux.dev>; Wed, 28 Apr 2021 10:37:01 +0000 (UTC)
Received: by mail-ej1-f52.google.com with SMTP id a4so523491ejk.1
        for <mptcp@lists.linux.dev>; Wed, 28 Apr 2021 03:37:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares-net.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=4WQmceNkm46YukSwPTfp3uRbHblTm/WI4TtkeDr2v5M=;
        b=XazTbd7wI3ZxUQGo958vf0rhBP4ScXhaClbOhMvLgbdVhzldphXHTkk7eKq3R7vcSB
         m++318cJNLhQrUy3Uk9vzWu8ySQ8e2bUdPkM9nrhIvlyZmusJAZUEL2r4twu3uL5Nj/a
         GuoRJMnkPRYLNEHF+6XNKnV6BJMxxrE9RqXmcFFiKrhKRAfjll4SR0yAQX22Dk6QdkZU
         F9pZ2u9onp5vrRyonJiiwqQ69EVgWUA63BhD+kM9FDgfCweqHIpD5MKtJMOfaPSviDEW
         uPeZzlKnTeOaqn6+QMn1Kv+q96okV4T/kOGpZYj58JDuFXiatLwfw3tJ0jjFe4txsGVj
         Pp7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=4WQmceNkm46YukSwPTfp3uRbHblTm/WI4TtkeDr2v5M=;
        b=dfyvRNUipgogyfFX/2lwJAwdPBPTHpFlcF88Rz/eOO0QcCnhNgKlTyPOksMWG1fpQw
         pqBiJnHAjxK03dQSC5VrWShuIcu505aNXMMsSNzxpdKRWk6zu1afSha1VOu6hdXHLO1o
         luT6K+NEf7ONlrfmXo/xAcghsuEg7RWL8d7F5RoPdOqDoNbceJOL7yShaj94qlbLdY4S
         9c9v85KNPcN0+DrrubUiozH/5+0liQvabozqT2v7Ly0eq6bwCv2WMK20bUdQCXG8Mp7L
         UjatnhEbsL2gRdBl7BWf7t3mMM30jChy/qGRaQQTY8alcCy+uCc+gof+e54bBSFIdWaF
         H9ew==
X-Gm-Message-State: AOAM532yigdVNxIzGG/XLj6Mgs3wu05W4BNF3Jm9Dc+jgpPwjsMGaj0k
	BduaGexC2UaMqZOzdyZTIy9dHhgUqvsX1gYO
X-Google-Smtp-Source: ABdhPJyGy4i37P0N/neV4Iqaj1FfNqSIPxxbhdJBXrt8CKvOmLG4hDTREO8kVIi2nWuwW6xgHnRZzA==
X-Received: by 2002:a17:906:688e:: with SMTP id n14mr17533706ejr.375.1619606220433;
        Wed, 28 Apr 2021 03:37:00 -0700 (PDT)
Received: from tsr-lap-08.nix.tessares.net ([2a02:578:85b0:e00:9a01:f17b:24ce:3558])
        by smtp.gmail.com with ESMTPSA id u23sm4499816eds.8.2021.04.28.03.36.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 28 Apr 2021 03:37:00 -0700 (PDT)
Subject: Re: [MPTCP][PATCH v2 mptcp-next 1/4] mptcp: add sysctl
 allow_join_initial_addr_port
To: Florian Westphal <fw@strlen.de>, Geliang Tang <geliangtang@gmail.com>
Cc: mptcp@lists.linux.dev
References: <cover.1619592361.git.geliangtang@gmail.com>
 <51758a7f629764dc91186acbf09665992e5b8e69.1619592361.git.geliangtang@gmail.com>
 <20210428094043.GC975@breakpoint.cc>
From: Matthieu Baerts <matthieu.baerts@tessares.net>
Message-ID: <be8baf91-5399-43d2-e595-f8565b353815@tessares.net>
Date: Wed, 28 Apr 2021 12:36:58 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <20210428094043.GC975@breakpoint.cc>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit

Hi Florian,

Thank you for this review!

On 28/04/2021 11:40, Florian Westphal wrote:
> Geliang Tang <geliangtang@gmail.com> wrote:
>> diff --git a/net/mptcp/ctrl.c b/net/mptcp/ctrl.c
>> index 96ba616f59bf..3b963a25d5a8 100644
>> --- a/net/mptcp/ctrl.c
>> +++ b/net/mptcp/ctrl.c
>> @@ -19,6 +19,7 @@ struct mptcp_pernet {
>>  
>>  	int mptcp_enabled;
>>  	unsigned int add_addr_timeout;
>> +	int allow_join_initial_addr_port;
> 
> u8 allow_join_initial_addr_port;

Should we do the same modifications for 'mptcp_enabled'? Switch to a u8
with min 0 and max 1?

Cheers,
Matt
-- 
Tessares | Belgium | Hybrid Access Solutions
www.tessares.net
