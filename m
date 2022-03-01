Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E8BE5A12
	for <mptcp@lists.linux.dev>; Tue,  1 Mar 2022 12:01:45 +0000 (UTC)
Received: by mail-ej1-f47.google.com with SMTP id a8so31016285ejc.8
        for <mptcp@lists.linux.dev>; Tue, 01 Mar 2022 04:01:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares-net.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=TxDg9GIVUuNoKFCyIXL4TWM9IaxKOENRlYwADFAnotU=;
        b=O55j1N7jh3mWYN8+/HD5DN3nR4V7+SPFz02v6AA8uXy+nzVqO6DiUobcUt+Na46Q/J
         xcImMhzCndMcTgwULfx/bndWl5fSxkLfps4VoIRWJvaJh+bE2i9yEG/22aBgibZJsNZh
         At1xarqweRASAe8/xAgsc0joSxqTaouFOPpZdCb+3rqvyPurv4lhidaarb9/W/Qpfg5q
         mfIYvwbKoWs9Hj+crL7qpIsir5tqCbvoJllL0PijZhlGzRJT2PX2M8cW6zsiBlQdKKTH
         yg9ZMYpajJJplucDSq6VFM8FUPibr2K2+TxyqcDd6eltCFJuRsr31b2HyIMj09lnJ+Rv
         psCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=TxDg9GIVUuNoKFCyIXL4TWM9IaxKOENRlYwADFAnotU=;
        b=mHge+jXRMMYQbK55yhB8km8RoM6oJXo193+huFQoiDry43BMZpdLsdyu8Hp0wm1nl/
         FYC/pIGEVg2TzHaeAZQES7xlHQeVNns0w7H3gXK/9+E4bOZPYUNaHOvlBbaukn9PcX8i
         SG6RDtVRr6dfEX7VLcNASLpBwV+hCBZEjyJctV3Tu1EU/fcfPAGvPOZ/ynfj4LiWfapc
         qBpzXyHrVNGABtRb85XQhpPjnDqLRhAuxoHWpwuRGMJaT1DC5d82gswXzvTdk09LBwwt
         DBD9eD2msQXYbRC+hyJxFOj8o3v/XrsrtkxXJJMNpT+BwBgAU/5pj5vOozW+fXrn5sk8
         LqRw==
X-Gm-Message-State: AOAM532xJupKaUDC9nsEi01WOZsOwuwLOw9j3YyJADJqddgrpT5PcmSq
	qnaQWbpcnGQ94h1fGpxKCC2GrQ==
X-Google-Smtp-Source: ABdhPJyqjKM2SPP8aXrA4x2HkB8qyAjbi7Lpq7CtMQU6HEQ0NV/M2tTG3QOg/x/lC0547WWHejvEkQ==
X-Received: by 2002:a17:907:78cc:b0:6b4:ecc1:42fb with SMTP id kv12-20020a17090778cc00b006b4ecc142fbmr17874550ejc.248.1646136103632;
        Tue, 01 Mar 2022 04:01:43 -0800 (PST)
Received: from ?IPV6:2a02:578:8593:1200:9adc:7cd9:4239:a8d7? ([2a02:578:8593:1200:9adc:7cd9:4239:a8d7])
        by smtp.gmail.com with ESMTPSA id z8-20020a170906270800b006bbd3efa6b8sm5232353ejc.80.2022.03.01.04.01.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 01 Mar 2022 04:01:43 -0800 (PST)
Message-ID: <d834213c-2315-0b48-debd-c40c3700c450@tessares.net>
Date: Tue, 1 Mar 2022 13:01:42 +0100
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.1
Subject: Re: [PATCH] mptcp: send ADD_ADDR echo before create subflows
Content-Language: en-GB
To: Yonglong Li <liyonglong@chinatelecom.cn>, Paolo Abeni <pabeni@redhat.com>
Cc: mathew.j.martineau@linux.intel.com, mptcp@lists.linux.dev
References: <1645779233-19742-1-git-send-email-liyonglong@chinatelecom.cn>
From: Matthieu Baerts <matthieu.baerts@tessares.net>
In-Reply-To: <1645779233-19742-1-git-send-email-liyonglong@chinatelecom.cn>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Yonglong, Paolo

On 25/02/2022 09:53, Yonglong Li wrote:
> In some corner case, It may receive ADD_ADDR retransmit package
> before created subflows done.
> It's more reasonable to send ADD_ADDR echo before creating subflows.

Thank you for this patch and the review!

Applied in our tree (feat. for net-next) with Paolo's ACK:

- 2b7de9309fe0: mptcp: send ADD_ADDR echo before create subflows
- Results: 097423b70867..64f0c8f3cf8b

This patch could be backported but as mentioned by Paolo, this fix is
more an optimisation and it changes the behaviour.


Builds and tests are now in progress:

https://cirrus-ci.com/github/multipath-tcp/mptcp_net-next/export/20220301T115847
https://github.com/multipath-tcp/mptcp_net-next/actions/workflows/build-validation.yml?query=branch:export


Note: packetdrill tests have been adapted to this new behaviour.

Cheers,
Matt
-- 
Tessares | Belgium | Hybrid Access Solutions
www.tessares.net
