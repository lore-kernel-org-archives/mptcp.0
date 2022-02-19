Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com [209.85.208.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEDED5580
	for <mptcp@lists.linux.dev>; Sat, 19 Feb 2022 17:22:15 +0000 (UTC)
Received: by mail-ed1-f50.google.com with SMTP id s14so3589164edw.0
        for <mptcp@lists.linux.dev>; Sat, 19 Feb 2022 09:22:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares-net.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :references:from:in-reply-to:content-transfer-encoding;
        bh=vskmJXoZWQzzQZP/COFW9HNYEJ7IUeliVD1qBUluQqg=;
        b=aAOxqGN0plw3Z7wfuVfkBLX//ZrZFNuHsLK3dPJ9/JgEPRZysBE69ABa1CgiRCM7wM
         dMHK6EQiO0uGqIdWOL2Q64X4mljgCaAReECaNhxHRdXBsuF2hCsP8cnmwQJ96vNYvkRr
         QPsrgbmHXTcmtAwnHXra9p/A8IVW2MMy26t70LrOS/tFgtmwNAME31oTL+eXxxnfuFc/
         sAEA+EvWXgyHtOMxdn/bjJG36k5RGAVJZCHxjDgL77QleRIwzCzcshLmO21VmVNmvhis
         OFZ7QfER7hveXYyCeCBTI/Ee/KlnAJYuFwmVrXuXRyn0zhCams6T28lhozrn3isnLvhW
         draA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:references:from:in-reply-to
         :content-transfer-encoding;
        bh=vskmJXoZWQzzQZP/COFW9HNYEJ7IUeliVD1qBUluQqg=;
        b=BU4CZ5TScMwQs9uhhuGIwsSMDAgDH+x4yybEL0Lz8JKXM7d5zujs+sHkHZ9pr1SU4+
         QN3HqiI27fY41Y0P3WRWno0cWB7N4AjrmjfA30ej9kRrjgeb8okDr/r1LLJdRcB5HXzw
         vSSp+GFj4BcVBWft2CSBC5MYJ+TiJISmaBzRfz+iWX+fP+qgGjF5xHOWGb2OubZRqcD1
         U5UV6hJCl8GatqypLQdL7FWsAjKRlDxygIpzREKfpai+eymx9XyIrO8bVmkDn/7Dovmw
         8mpdYvgTtw88mao5S65DIXbni5jnf+ljV16kW+ycjBYlvZphJdbcfybAW30EzjlloG1a
         ubuQ==
X-Gm-Message-State: AOAM531KxONdWpf46zEWOeO0dwR5pQlEjYQ1uPHLaNCmD8YXQWtNZdT7
	ImcBete09o51vIFMdp6toLetSWYomS4JXv7V
X-Google-Smtp-Source: ABdhPJwjcs6Uv6nnwRUFtdIwtVzdYiB4pAbE6ogJsvDn6C+T9/N2D2vDFUZYnV6Rb8HHxPSHbguMfg==
X-Received: by 2002:aa7:c7c4:0:b0:407:52cc:3b32 with SMTP id o4-20020aa7c7c4000000b0040752cc3b32mr13550692eds.397.1645291333990;
        Sat, 19 Feb 2022 09:22:13 -0800 (PST)
Received: from ?IPV6:2a02:578:8593:1200:e864:9933:3026:4675? ([2a02:578:8593:1200:e864:9933:3026:4675])
        by smtp.gmail.com with ESMTPSA id i24sm6050539edt.86.2022.02.19.09.22.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 19 Feb 2022 09:22:13 -0800 (PST)
Message-ID: <2d5d453b-3d34-69e0-3e8a-ad44ab236256@tessares.net>
Date: Sat, 19 Feb 2022 18:22:13 +0100
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.1
Subject: Re: [PATCH mptcp-net 0/2] mptcp: fix ioctl on fallback
Content-Language: en-GB
To: Paolo Abeni <pabeni@redhat.com>, mptcp@lists.linux.dev
References: <cover.1645196974.git.pabeni@redhat.com>
From: Matthieu Baerts <matthieu.baerts@tessares.net>
In-Reply-To: <cover.1645196974.git.pabeni@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Paolo, Mat,

On 18/02/2022 16:17, Paolo Abeni wrote:
> The first patch fixes the issue, hopefully closing:
> 
> https://github.com/multipath-tcp/mptcp_net-next/issues/260
> 
> the 2nd patch is self-test cleanup
> 
> Paolo Abeni (2):
>   mptcp: accurate SIOCOUTQ for fallback socket
>   selftests: mptcp: do complete cleanup at exit

Thank you for the patches and the reviews!

Now in our tree (fixes for -net) with Mat's RvB tag and the Closes tag
on the first one.

- 9b0586e72457: mptcp: accurate SIOCOUTQ for fallback socket
- 155ad8f4c292: selftests: mptcp: do complete cleanup at exit
- Results: 785fa0377037..aa13e81cbcb8

Builds and tests are now in progress:

https://cirrus-ci.com/github/multipath-tcp/mptcp_net-next/export/20220219T172141
https://github.com/multipath-tcp/mptcp_net-next/actions/workflows/build-validation.yml?query=branch:export

Cheers,
Matt
-- 
Tessares | Belgium | Hybrid Access Solutions
www.tessares.net
