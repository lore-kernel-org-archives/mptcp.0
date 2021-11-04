Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com [209.85.208.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDB9168
	for <mptcp@lists.linux.dev>; Thu,  4 Nov 2021 11:51:58 +0000 (UTC)
Received: by mail-ed1-f46.google.com with SMTP id ee33so20481794edb.8
        for <mptcp@lists.linux.dev>; Thu, 04 Nov 2021 04:51:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares-net.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :references:cc:from:in-reply-to:content-transfer-encoding;
        bh=De5erlWo2xXFC/U+GuGQAbdDbFwueyGhATAFODSWuh0=;
        b=nC5VY5r0ceNobyVKx4KxkI+/WBzJYwr5I9P9g1MKUmJjeQkDdL9x0aWNJsOns/Wbk4
         KIiZN8uR5o5fwf7d8WHyZ657ovATcp2pt0tujLh0HdZB6s+DWNj6rEDU/xZkwhh0PqwP
         3DYBrNaADomUPMZ/vfaGOsxGsu6STLwRKsG9PKubw2B3rz5gXpzSXOvzJ+IdfTzXijM/
         +R6tbydQEMpW8kTRpivowz94i3MUFL4ziil44oviKYJouDNs1nfrMeSeQmBFMbIAjMds
         1nAZvnvKjoFf5eOaFEMRdIKUUtAZms93CIUIpGW1G+07kPGZn+CJkvNq4PUVhjTFkUcO
         983g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:references:cc:from:in-reply-to
         :content-transfer-encoding;
        bh=De5erlWo2xXFC/U+GuGQAbdDbFwueyGhATAFODSWuh0=;
        b=pzYTsXyAxjnNJJjb/R3AkRS5PDkucy94/MM2btccSmhRxE9JQNDduwUM/nOh2wcseE
         k2LTx9CMmrAQ9z1NTH2r600ibLIV6FAsLdhxDJ1aU2tUHEst5UeHPIvjKnuJ01pRf80K
         wMH0tQcjEwhx1boJybTeKCEn4ayRafjthIaleeWyGZfRcdL8gQdQGFcxhwvptwFh3f5Z
         CGtqKpjiSeHMvj1uVE4u4jPZzgdo9YdyPo8Gh756wUPOP37K3URBWJbMW3fHvOY+Zn5W
         beWhMYMqCddU9eTcgfIfuWup+tneC9dyH4zgOJ+GwqcgerhIn9CbFPtKhIKkUSljIIlA
         wLNg==
X-Gm-Message-State: AOAM530FgztnlMehyyQmmgcknWG6KeF0NUIOIS6TFLJ/aEbS6W3QNj9w
	JZcGRSuF8Uoro0Wvf0cgFR8tdrWExwe7mE3h
X-Google-Smtp-Source: ABdhPJwk/7PiQuRj/9UyYDq9zzp9XVA6/zJ7s+SDykjJEoQt64Diu5GMdt0aKXbhdGtBIiFk0QkRWA==
X-Received: by 2002:a17:907:1b1f:: with SMTP id mp31mr61694184ejc.319.1636026716956;
        Thu, 04 Nov 2021 04:51:56 -0700 (PDT)
Received: from ?IPV6:2a02:578:85b0:e00:8bb4:2878:7380:649e? ([2a02:578:85b0:e00:8bb4:2878:7380:649e])
        by smtp.gmail.com with ESMTPSA id b11sm2890460ede.52.2021.11.04.04.51.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 04 Nov 2021 04:51:56 -0700 (PDT)
Message-ID: <14d792ef-c1c8-2568-ca8f-228fdd4cbdaa@tessares.net>
Date: Thu, 4 Nov 2021 12:51:55 +0100
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.1.2
Subject: Re: Linux 5.15 + v2ray + mptcp
Content-Language: en-GB
To: Mark Burton <mark@helenandmark.org>
References: <8DB8DCC4-A85C-4A1A-8A82-5D53F256C09A@helenandmark.org>
Cc: mptcp@lists.linux.dev
From: Matthieu Baerts <matthieu.baerts@tessares.net>
In-Reply-To: <8DB8DCC4-A85C-4A1A-8A82-5D53F256C09A@helenandmark.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Mark,

On 04/11/2021 12:10, Mark Burton wrote:
> Just a very brief note to say I have this working with good results:

Thank you for sharing this positive comment!

Good to see it is working as expected instead of only seeing here
typical "I found a bug!" messages :-)

Cheers,
Matt
-- 
Tessares | Belgium | Hybrid Access Solutions
www.tessares.net
