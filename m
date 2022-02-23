Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com [209.85.208.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33BFA6AC8
	for <mptcp@lists.linux.dev>; Wed, 23 Feb 2022 21:06:52 +0000 (UTC)
Received: by mail-ed1-f51.google.com with SMTP id q17so104559edd.4
        for <mptcp@lists.linux.dev>; Wed, 23 Feb 2022 13:06:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares-net.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :references:from:in-reply-to:content-transfer-encoding;
        bh=OBnOTmyjjw4w5TIv77dFch8VZru0MTCPZGQRz6Ax25M=;
        b=tLEaQGoJAFPhN0Xly8QXtR+Hx1Jit1WHlaUBOCiih/5H7SMk+OK/R7JTZG5PuJ0yFR
         0j2Lj7rSyYqqdDs0ETpWukuGHnV9qmuCx+Qh9NyIe6EQUL7A96ZOQlVZH4fzUsiCDYOw
         Apz2gngirqBdHP84Hu4FFZutHg62D+9IPfTX08uhW7huV0j+pxSFmscVfm/+Jf1OSwoK
         +yz/cMyqTL5lkOTaC5vb6dIbpEO8sRRNijpeIZswvqawGQNheSN5FxIpeRkC4A9CMrEl
         OVf+bZnlWeWqk6+JdkFecp/M2HrZU5pLHAu3zz7eWZiqFYha1pdagK7AdKNn914cIpuY
         AxhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:references:from:in-reply-to
         :content-transfer-encoding;
        bh=OBnOTmyjjw4w5TIv77dFch8VZru0MTCPZGQRz6Ax25M=;
        b=s5i5mczmUVR5KaCRXemPRRfrDuVbZuZ1foqNcXLIffwjeac/wFq8VT+WKFBV+srj4M
         35A/4CbngmPjUWhV09rcLKno2gbL8S1xXfYXayAiCuOqvKjisgnHbHrnKI5AIS11nVy/
         3QoUcV2xceApD6SX6XinxLVHxB9zXdeCDmq/qgklVu1TeKVIDwoWgH9ByV8Md3JQHSNH
         FpLy8Yy9n/3784DCpUP+q0jngmmfeTfH8sPKlpK3A7Zyfx5bQX1e32aZLkANFmAPG0bH
         lon60d7XhiE4a9f/jBjEGusERa+C3xDBmwcfoF0BExtWjpty1LZZnQ9/KUU8HySwxWEh
         0ZGQ==
X-Gm-Message-State: AOAM533jW/+QVWT5zkNBcebBEKnLOgiMp4Y/pORQr1ZLv0xPCOH1ZU/b
	s04cv8PR/I5dSg4qSWOu1Oio4J6KkVBixkje
X-Google-Smtp-Source: ABdhPJwg1vRmLcc/R6KK5ydhVAjOeEMxrVoTBvdx5FV48nlLWK+DBygULdmjU178xWTeQlnh5x4vNQ==
X-Received: by 2002:a50:8d1e:0:b0:413:492b:2c86 with SMTP id s30-20020a508d1e000000b00413492b2c86mr1225515eds.140.1645650411074;
        Wed, 23 Feb 2022 13:06:51 -0800 (PST)
Received: from ?IPV6:2a02:578:8593:1200:1d50:f5b0:90f5:6f43? ([2a02:578:8593:1200:1d50:f5b0:90f5:6f43])
        by smtp.gmail.com with ESMTPSA id 23sm318466ejf.175.2022.02.23.13.06.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 23 Feb 2022 13:06:50 -0800 (PST)
Message-ID: <ce0b1ad0-7399-15b3-d83d-e6ad3215315a@tessares.net>
Date: Wed, 23 Feb 2022 22:06:50 +0100
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.1
Subject: Re: [PATCH mptcp-next] mptcp: add fullmesh flag check for adding
 address
Content-Language: en-GB
To: Geliang Tang <geliang.tang@suse.com>, mptcp@lists.linux.dev
References: <02d082c77c58ed6400d319d40e719a4ebe4e7942.1645419055.git.geliang.tang@suse.com>
From: Matthieu Baerts <matthieu.baerts@tessares.net>
In-Reply-To: <02d082c77c58ed6400d319d40e719a4ebe4e7942.1645419055.git.geliang.tang@suse.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Geliang, Mat,

On 21/02/2022 05:51, Geliang Tang wrote:
> The fullmesh flag mustn't be used with the signal flag when adding an
> address. This patch added the necessary flags check for this case.

Thank you for the patch and the review!

- a52bfb47e95a: mptcp: add fullmesh flag check for adding address
- Results: 067a741aa5fb..5db573b4c7ff

Builds and tests are now in progress:

https://cirrus-ci.com/github/multipath-tcp/mptcp_net-next/export/20220223T210614
https://github.com/multipath-tcp/mptcp_net-next/actions/workflows/build-validation.yml?query=branch:export

Cheers,
Matt
-- 
Tessares | Belgium | Hybrid Access Solutions
www.tessares.net
